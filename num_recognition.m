clear all                             %�壨��ʼ��������

%***************
%handle pictures
%***************
DirOutput = dir('D:\���ҵ�ͼ�ģ�G�̣�\MATLAB\*.bmp'); % ���Ϻ�׺���ƺ��ˡ���ȡʽ������ļ���,dir
SimpleName = {DirOutput(1:end).name}';%���������Ľ��Ϊ�ṹ���飬��������ÿ��һ���ļ���
resha=reshape(SimpleName,10,10);      %תΪ10*10����
resh=resha';                          %ת��
cel=cell(10,10);
for i=1:10
    for j=1:10
	    m1=imread(resh{i,j});         %m1��һ�����������᲻ͣ�ı���һ��ͼƬ��Ϣ������������һ��ͼƬ����Ϣ
	    m2=imresize(m1,[15 15]);      %��ÿһ��I��ŵ�ͼƬתΪ15*15��С��
		lev = graythresh(m2);         %��ƽ���Ҷȣ�
        bwimg = im2bw( m2, lev);      %���ֵͼ�ľ���
	    I{i,j}=reshape(bwimg',1,225);  %������bwimgת��Ϊ1��225�У����ϵ��£������ң�����bwimg'Ϊ����bwimg��ת�ã�
	end
end


%����ƴ��
cat_o=cell(1,10);
for a=1:10
    cat_out=I{a,1};
	for b=1:9
        cat_out=cat(1,cat_out,I{a,b+1});
		cat_o_b{b}=cat_out;
	end
	cat_o{a}=cat_out;
end
	 

	 
%find p(1|yi) and p(0|yi)
p1y=cell(1,10);
p0y=cell(1,10);
for d=1:10
    p1y{d}=(sum(cat_o{1,d})+1)/12;          %+1��+2��ֹ���ָ���Ϊ������
	p0y{d}=1-p1y{d};
end


%����ͼƬ����
A = imread('D:\0-11.bmp');   %��ȡͼƬ����ͼƬ������ֵ���ھ���A��
B=imresize(A,[15 15]);      %scaleͼƬ
lev = graythresh(B);      %��ƽ���Ҷȣ�
bwimg = im2bw( B, lev);   %���ֵͼ�ľ���
X=reshape(bwimg',1,225);    %������bwimgת��Ϊ1��25�У����ϵ��£������ң�����bwimg'Ϊ����bwimg��ת�ã�
%X=[x1,...,x225]��֪

%��������
p_out=[];
for n=1:10    
	p_out(n)=1;
    for k=1:225
        if X(k)==1
           p_out(n)=p_out(n)*p1y{n}(k);	      
        else  
	       p_out(n)=p_out(n)*p0y{n}(k);
	    end
    end
end

[m, position_k]=max(p_out(1,:));
wi=position_k-1;
fprintf('ͼƬ���������%d\n',wi);
