UP_RATE = 12;
DOWN_RATE = 7;
[h,g]=ifir(DOWN_RATE,'low',[.12 .14],[.01 .001]);
input = [1 zeros(1,300)];

E = poly1(upsample(input,UP_RATE),DOWN_RATE);

LPF = poly1(h, DOWN_RATE);
LOW_SIG{size(E,1),1} = [];

for i=1:size(E,1)    
    LOW_SIG{i,1} = fftfilt(LPF(i,:),downsample(E(i,:),DOWN_RATE));
end;

LOW_SIG_M = cell2mat(LOW_SIG);

output = transpose(LOW_SIG_M(:));

desired_output = fftfilt(h,input);
O = dfilt.dffir(output);
DO = dfilt.dffir(desired_output);
hfv = fvtool(DO);
legend(hfv,'Desired Output', 'Implemented Output');



