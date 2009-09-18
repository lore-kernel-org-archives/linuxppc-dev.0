Return-Path: <sumeshkkn@hotmail.com>
Received: from blu0-omc3-s29.blu0.hotmail.com (blu0-omc3-s29.blu0.hotmail.com
	[65.55.116.104]) by ozlabs.org (Postfix) with ESMTP id 4BA97B7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Sep 2009 19:31:37 +1000 (EST)
Message-ID: <BLU124-W15B59AFF88DB52C03BD481B4E00@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_95296fc3-7c24-42fa-99f0-04ee61c8ba4a_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Linux booting issue on powerpc 440x5
Date: Fri, 18 Sep 2009 09:31:34 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_95296fc3-7c24-42fa-99f0-04ee61c8ba4a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi=2C
I am trying to boot linux kernel (2.6.30) on PPC440x5 processor in a custom=
 built board. I am using simple ppc platform.
I have a small bootloader which will only copy the simpleImage.myboard.bin =
to 0x400000 location of my SRAM from the flash.
SRAM is only 16MB and bootloader creates one and only TLB of 16MB
I am getting "Kernel access of bad area=2C sig: 11 [#1]" while kernel is bo=
oting.
kernel crashes in different places=2C for different compilation
Bellow given are 2 dumps of kernel crash
In DUMP1=2C in back trace=2C execution flow is shown like=2C
Start_kernel() --> sort_main_extable() --> sort_extable(). and sort extable=
 calls some functions whose name is not mentioned.
Why is it not able to get the name of the function.?
i went through the 'objdump' of the kernel=2C I don't know whether it can h=
elp me somehow=2C it looked like this
--c018c730:   48 00 71 9d     bl      c01938cc <sort_main_extable>c018c734:=
   48 00 3e 3d     bl      c0190570 <trap_init>--c01938e8:   4b f7 10 f1   =
  bl      c01049d8 <sort_extable>c01938ec:   80 01 00 14     lwz     r0=2C2=
0(r1)--c01049fc:   48 00 8d 99     bl      c010d794 <sort>c0104a00:   80 01=
 00 14     lwz     r0=2C20(r1)--c016b99c:   42 6f 6f 74     bc+     18=2C4*=
cr3+so=2Cc0172910 <kallsyms_token_index+0x7400>--
Could this be problem with "kallsyms"..? Because sort_extable() calls sort(=
) which is an exported function defined in linux-2.6.30\lib\sort.c
when i checked 'objdump' of the kernel=2C i could see the usage of a preser=
ved opcode of ppc440x5 (code: eciwx).
I tried compiling the kernel with "kallsyms" disabled=2C that also did not =
work.
In DUMP2=2C backtrace is not able to identify the name of 'caller' of unfla=
tten_device_tree(). The caller is mentioned as "[00000000] (null)"
Could this be a stack problem=2C like stack pointer getting corrupted.?
At last=2C could this be a hardware problem(expecting to be memory problem)=
..?
Can you tell me if i am missing something.?
thanks=2CShyju. N

-------------------------DUMP 1------------------------------------id mach(=
): doneMMU:enterMMU:hw initMMU:mapinMMU:setioMMU:exitbootmemarch: exit<7>To=
p of RAM: 0x1000000=2C Total RAM: 0x1000000Zone PFN ranges:  DMA      0x000=
00000 -> 0x00001000  Normal   0x00001000 -> 0x00001000Movable zone start PF=
N for each nodeearly_node_map[1] active PFN ranges    0: 0x00000000 -> 0x00=
001000MMU: Allocated 1088 bytes of context maps for 255 contextsBuilt 1 zon=
elists in Zone order=2C mobility grouping off.  Total pages: 4064Kernel com=
mand line: console=3DttyS0 root=3D/dev/ramUnable to handle kernel paging re=
quest for data at address 0x00021000Faulting instruction address: 0xc010a7c=
4Oops: Kernel access of bad area=2C sig: 11 [#1]PREEMPT PowerPC 44x Platfor=
mModules linked in:NIP: c010a7c4 LR: c010dc50 CTR: 00000000REGS: c01bfeb0 T=
RAP: 0300   Not tainted  (2.6.30)MSR: 00021000 <ME=2CCE>  CR: 24000044  XER=
: 00000000DEAR: 00021000=2C ESR: 00000000TASK =3D c01a94b8[0] 'swapper' THR=
EAD: c01be000GPR00: 00001180 c01bff60 c01a94b8 00021000 00000025 00000008 c=
0104968 00000000 GPR08: 2f72616d c0110000 c0155938 c01a0000 22000024 000000=
00 fffff104 00000000 GPR16: 00000000 00000000 00000000 00000000 fffffff8 00=
0008b8 c010d758 c0104968 GPR24: 00001198 00001190 c018a001 c01c5498 000008c=
0 00001188 00021000 c01c42f0 NIP [c010a7c4] strchr+0x0/0x3cLR [c010dc50] ma=
tch_token+0x138/0x228Call Trace:[c01bff60] [c016b99c] 0xc016b99c (unreliabl=
e)[c01bffa0] [c0104a00] sort_extable+0x28/0x38[c01bffb0] [c01938ec] sort_ma=
in_extable+0x20/0x30[c01bffc0] [c018c734] start_kernel+0x140/0x288[c01bfff0=
] [c0000200] skpinv+0x190/0x1ccInstruction dump:7ca903a6 88040000 38a5ffff =
38840001 2f800000 98090000 39290001 419e0010 4200ffe4 98a90000 4e800020 4e8=
00020 <88030000> 5484063e 7f802000 4d9e0020 ---[ end trace 31fd0ba7d8756001=
 ]---Kernel panic - not syncing: Attempted to kill the idle task!Call Trace=
:[c01bfd90] [c0005d5c] show_stack+0x4c/0x16c (unreliable)[c01bfdd0] [c002f1=
7c] panic+0xa0/0x168[c01bfe20] [c0032eb8] do_exit+0x61c/0x638[c01bfe60] [c0=
00b60c] kernel_bad_stack+0x0/0x4c[c01bfe90] [c000f310] bad_page_fault+0x90/=
0xd8[c01bfea0] [c000e184] handle_page_fault+0x7c/0x80[c01bff60] [c016b99c] =
0xc016b99c[c01bffa0] [c0104a00] sort_extable+0x28/0x38[c01bffb0] [c01938ec]=
 sort_main_extable+0x20/0x30[c01bffc0] [c018c734] start_kernel+0x140/0x288[=
c01bfff0] [c0000200] skpinv+0x190/0x1ccRebooting in 180 seconds..----------=
---------------------------------------------------------
-------------------------DUMP 2------------------------------------id mach(=
): doneMMU:enterMMU:hw initMMU:mapinMMU:setioMMU:exit<1>Unable to handle ke=
rnel paging request for data at address 0x40ee8053Faulting instruction addr=
ess: 0xc018ff44Oops: Kernel access of bad area=2C sig: 11 [#1]PREEMPT Power=
PC 44x PlatformModules linked in:NIP: c018ff44 LR: c018ff20 CTR: 00000000RE=
GS: c01bfe10 TRAP: 0300   Not tainted  (2.6.30)MSR: 00021000 <ME=2CCE>  CR:=
 44088024  XER: 00000000DEAR: 40ee8053=2C ESR: 00800000TASK =3D c01a94b8[0]=
 'swapper' THREAD: c01be000GPR00: c0ffea58 c01bfec0 c01a94b8 c0ffea6e c04eb=
3aa 00000003 c0ffea74 00000000 GPR08: 00000000 40ee802f c04eb3a0 c01bfec8 2=
4082022 00000000 fffff104 00000000 GPR16: 00000000 c016cfe8 c016cfd8 c0170c=
bc c01bfec8 c0ffea24 c04eb3a4 c04eb3a0 GPR24: 00000008 c01bff8c c04eb33c c0=
ffea2c 00000007 c01bff88 c0ffe984 c0ffea6d NIP [c018ff44] unflatten_dt_node=
+0x158/0x520LR [c018ff20] unflatten_dt_node+0x134/0x520Call Trace:[c01bff20=
] [c019023c] unflatten_dt_node+0x450/0x520[c01bff80] [c01903b4] unflatten_d=
evice_tree+0xa8/0x13c[c01bffb0] [00000000] (null)Instruction dump:7f85e378 =
7ec4b378 4be81b55 81390000 381b002c 93690000 90190000 4192001c 813e0028 93d=
b001c 2f890000 419e03b4 <93690024> 937e0028 387b0034 3abb0014 ---[ end trac=
e 31fd0ba7d8756001 ]---Kernel panic - not syncing: Attempted to kill the id=
le task!Call Trace:[c01bfcf0] [c0005d5c] show_stack+0x4c/0x16c (unreliable)=
[c01bfd30] [c002f17c] panic+0xa0/0x168[c01bfd80] [c0032eb8] do_exit+0x61c/0=
x638[c01bfdc0] [c000b60c] kernel_bad_stack+0x0/0x4c[c01bfdf0] [c000f310] ba=
d_page_fault+0x90/0xd8[c01bfe00] [c000e184] handle_page_fault+0x7c/0x80[c01=
bfec0] [00000000] (null)[c01bff20] [c019023c] unflatten_dt_node+0x450/0x520=
[c01bff80] [c01903b4] unflatten_device_tree+0xa8/0x13c[c01bffb0] [00000000]=
 (null)-------------------------------------------------------------------



_________________________________________________________________
Need a place to rent=2C buy or share? Let us find your next place for you!=
=20
http://clk.atdmt.com/NMN/go/157631292/direct/01/=

--_95296fc3-7c24-42fa-99f0-04ee61c8ba4a_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
<div><br></div><div>Hi=2C</div><div><br></div><div>I am trying to boot linu=
x kernel (2.6.30) on PPC440x5 processor in a custom built board. I am using=
 simple ppc platform.</div><div><br></div><div>I have a small bootloader wh=
ich will only copy the simpleImage.myboard.bin to 0x400000 location of my S=
RAM from the flash.</div><div><br></div><div>SRAM is only 16MB and bootload=
er creates one and only TLB of 16MB</div><div><br></div><div>I am getting "=
Kernel access of bad area=2C sig: 11 [#1]" while kernel is booting.</div><d=
iv><br></div><div>kernel crashes in different places=2C for different compi=
lation</div><div><br></div><div>Bellow given are 2 dumps of kernel crash</d=
iv><div><br></div><div>In DUMP1=2C in back trace=2C execution flow is shown=
 like=2C</div><div><br></div><div>Start_kernel() --&gt=3B sort_main_extable=
() --&gt=3B sort_extable(). and sort extable calls some functions whose nam=
e is not mentioned.</div><div><br></div><div>Why is it not able to get the =
name of the function.?</div><div><br></div><div>i went through the 'objdump=
' of the kernel=2C I don't know whether it can help me somehow=2C it looked=
 like this</div><div><br></div><div>--</div><div>c018c730: &nbsp=3B 48 00 7=
1 9d &nbsp=3B &nbsp=3B bl &nbsp=3B &nbsp=3B &nbsp=3Bc01938cc &lt=3Bsort_mai=
n_extable&gt=3B</div><div>c018c734: &nbsp=3B 48 00 3e 3d &nbsp=3B &nbsp=3B =
bl &nbsp=3B &nbsp=3B &nbsp=3Bc0190570 &lt=3Btrap_init&gt=3B</div><div>--</d=
iv><div>c01938e8: &nbsp=3B 4b f7 10 f1 &nbsp=3B &nbsp=3B bl &nbsp=3B &nbsp=
=3B &nbsp=3Bc01049d8 &lt=3Bsort_extable&gt=3B</div><div>c01938ec: &nbsp=3B =
80 01 00 14 &nbsp=3B &nbsp=3B lwz &nbsp=3B &nbsp=3B r0=2C20(r1)</div><div>-=
-</div><div>c01049fc: &nbsp=3B 48 00 8d 99 &nbsp=3B &nbsp=3B bl &nbsp=3B &n=
bsp=3B &nbsp=3Bc010d794 &lt=3Bsort&gt=3B</div><div>c0104a00: &nbsp=3B 80 01=
 00 14 &nbsp=3B &nbsp=3B lwz &nbsp=3B &nbsp=3B r0=2C20(r1)</div><div>--</di=
v><div>c016b99c: &nbsp=3B 42 6f 6f 74 &nbsp=3B &nbsp=3B bc+ &nbsp=3B &nbsp=
=3B 18=2C4*cr3+so=2Cc0172910 &lt=3Bkallsyms_token_index+0x7400&gt=3B</div><=
div>--</div><div><br></div><div>Could this be problem with "kallsyms"..? Be=
cause sort_extable() calls sort() which is an exported function defined in =
linux-2.6.30\lib\sort.c</div><div><br></div><div>when i checked 'objdump' o=
f the kernel=2C i could see the usage of a preserved opcode of ppc440x5 (co=
de: eciwx).</div><div><br></div><div>I tried compiling the kernel with "kal=
lsyms" disabled=2C that also did not work.</div><div><br></div><div>In DUMP=
2=2C backtrace is not able to identify the name of 'caller' of unflatten_de=
vice_tree(). The caller is mentioned as "[00000000] (null)"</div><div><br><=
/div><div>Could this be a stack problem=2C like stack pointer getting corru=
pted.?</div><div><br></div><div>At last=2C could this be a hardware problem=
(expecting to be memory problem)..?</div><div><br></div><div>Can you tell m=
e if i am missing something.?</div><div><br></div><div>thanks=2C</div><div>=
Shyju. N</div><div><br></div><div><br></div><div>-------------------------D=
UMP 1------------------------------------</div><div>id mach(): done</div><d=
iv>MMU:enter</div><div>MMU:hw init</div><div>MMU:mapin</div><div>MMU:setio<=
/div><div>MMU:exit</div><div>bootmemarch: exit</div><div>&lt=3B7&gt=3BTop o=
f RAM: 0x1000000=2C Total RAM: 0x1000000</div><div>Zone PFN ranges:</div><d=
iv>&nbsp=3B&nbsp=3BDMA &nbsp=3B &nbsp=3B &nbsp=3B0x00000000 -&gt=3B 0x00001=
000</div><div>&nbsp=3B&nbsp=3BNormal &nbsp=3B 0x00001000 -&gt=3B 0x00001000=
</div><div>Movable zone start PFN for each node</div><div>early_node_map[1]=
 active PFN ranges</div><div>&nbsp=3B&nbsp=3B &nbsp=3B0: 0x00000000 -&gt=3B=
 0x00001000</div><div>MMU: Allocated 1088 bytes of context maps for 255 con=
texts</div><div>Built 1 zonelists in Zone order=2C mobility grouping off. &=
nbsp=3BTotal pages: 4064</div><div>Kernel command line: console=3DttyS0 roo=
t=3D/dev/ram</div><div>Unable to handle kernel paging request for data at a=
ddress 0x00021000</div><div>Faulting instruction address: 0xc010a7c4</div><=
div>Oops: Kernel access of bad area=2C sig: 11 [#1]</div><div>PREEMPT Power=
PC 44x Platform</div><div>Modules linked in:</div><div>NIP: c010a7c4 LR: c0=
10dc50 CTR: 00000000</div><div>REGS: c01bfeb0 TRAP: 0300 &nbsp=3B Not taint=
ed &nbsp=3B(2.6.30)</div><div>MSR: 00021000 &lt=3BME=2CCE&gt=3B &nbsp=3BCR:=
 24000044 &nbsp=3BXER: 00000000</div><div>DEAR: 00021000=2C ESR: 00000000</=
div><div>TASK =3D c01a94b8[0] 'swapper' THREAD: c01be000</div><div>GPR00: 0=
0001180 c01bff60 c01a94b8 00021000 00000025 00000008 c0104968 00000000&nbsp=
=3B</div><div>GPR08: 2f72616d c0110000 c0155938 c01a0000 22000024 00000000 =
fffff104 00000000&nbsp=3B</div><div>GPR16: 00000000 00000000 00000000 00000=
000 fffffff8 000008b8 c010d758 c0104968&nbsp=3B</div><div>GPR24: 00001198 0=
0001190 c018a001 c01c5498 000008c0 00001188 00021000 c01c42f0&nbsp=3B</div>=
<div>NIP [c010a7c4] strchr+0x0/0x3c</div><div>LR [c010dc50] match_token+0x1=
38/0x228</div><div>Call Trace:</div><div>[c01bff60] [c016b99c] 0xc016b99c (=
unreliable)</div><div>[c01bffa0] [c0104a00] sort_extable+0x28/0x38</div><di=
v>[c01bffb0] [c01938ec] sort_main_extable+0x20/0x30</div><div>[c01bffc0] [c=
018c734] start_kernel+0x140/0x288</div><div>[c01bfff0] [c0000200] skpinv+0x=
190/0x1cc</div><div>Instruction dump:</div><div>7ca903a6 88040000 38a5ffff =
38840001 2f800000 98090000 39290001 419e0010&nbsp=3B</div><div>4200ffe4 98a=
90000 4e800020 4e800020 &lt=3B88030000&gt=3B 5484063e 7f802000 4d9e0020&nbs=
p=3B</div><div>---[ end trace 31fd0ba7d8756001 ]---</div><div>Kernel panic =
- not syncing: Attempted to kill the idle task!</div><div>Call Trace:</div>=
<div>[c01bfd90] [c0005d5c] show_stack+0x4c/0x16c (unreliable)</div><div>[c0=
1bfdd0] [c002f17c] panic+0xa0/0x168</div><div>[c01bfe20] [c0032eb8] do_exit=
+0x61c/0x638</div><div>[c01bfe60] [c000b60c] kernel_bad_stack+0x0/0x4c</div=
><div>[c01bfe90] [c000f310] bad_page_fault+0x90/0xd8</div><div>[c01bfea0] [=
c000e184] handle_page_fault+0x7c/0x80</div><div>[c01bff60] [c016b99c] 0xc01=
6b99c</div><div>[c01bffa0] [c0104a00] sort_extable+0x28/0x38</div><div>[c01=
bffb0] [c01938ec] sort_main_extable+0x20/0x30</div><div>[c01bffc0] [c018c73=
4] start_kernel+0x140/0x288</div><div>[c01bfff0] [c0000200] skpinv+0x190/0x=
1cc</div><div>Rebooting in 180 seconds..</div><div>------------------------=
-------------------------------------------</div><div><br></div><div>------=
-------------------DUMP 2------------------------------------</div><div>id =
mach(): done</div><div>MMU:enter</div><div>MMU:hw init</div><div>MMU:mapin<=
/div><div>MMU:setio</div><div>MMU:exit</div><div>&lt=3B1&gt=3BUnable to han=
dle kernel paging request for data at address 0x40ee8053</div><div>Faulting=
 instruction address: 0xc018ff44</div><div>Oops: Kernel access of bad area=
=2C sig: 11 [#1]</div><div>PREEMPT PowerPC 44x Platform</div><div>Modules l=
inked in:</div><div>NIP: c018ff44 LR: c018ff20 CTR: 00000000</div><div>REGS=
: c01bfe10 TRAP: 0300 &nbsp=3B Not tainted &nbsp=3B(2.6.30)</div><div>MSR: =
00021000 &lt=3BME=2CCE&gt=3B &nbsp=3BCR: 44088024 &nbsp=3BXER: 00000000</di=
v><div>DEAR: 40ee8053=2C ESR: 00800000</div><div>TASK =3D c01a94b8[0] 'swap=
per' THREAD: c01be000</div><div>GPR00: c0ffea58 c01bfec0 c01a94b8 c0ffea6e =
c04eb3aa 00000003 c0ffea74 00000000&nbsp=3B</div><div>GPR08: 00000000 40ee8=
02f c04eb3a0 c01bfec8 24082022 00000000 fffff104 00000000&nbsp=3B</div><div=
>GPR16: 00000000 c016cfe8 c016cfd8 c0170cbc c01bfec8 c0ffea24 c04eb3a4 c04e=
b3a0&nbsp=3B</div><div>GPR24: 00000008 c01bff8c c04eb33c c0ffea2c 00000007 =
c01bff88 c0ffe984 c0ffea6d&nbsp=3B</div><div>NIP [c018ff44] unflatten_dt_no=
de+0x158/0x520</div><div>LR [c018ff20] unflatten_dt_node+0x134/0x520</div><=
div>Call Trace:</div><div>[c01bff20] [c019023c] unflatten_dt_node+0x450/0x5=
20</div><div>[c01bff80] [c01903b4] unflatten_device_tree+0xa8/0x13c</div><d=
iv>[c01bffb0] [00000000] (null)</div><div>Instruction dump:</div><div>7f85e=
378 7ec4b378 4be81b55 81390000 381b002c 93690000 90190000 4192001c&nbsp=3B<=
/div><div>813e0028 93db001c 2f890000 419e03b4 &lt=3B93690024&gt=3B 937e0028=
 387b0034 3abb0014&nbsp=3B</div><div>---[ end trace 31fd0ba7d8756001 ]---</=
div><div>Kernel panic - not syncing: Attempted to kill the idle task!</div>=
<div>Call Trace:</div><div>[c01bfcf0] [c0005d5c] show_stack+0x4c/0x16c (unr=
eliable)</div><div>[c01bfd30] [c002f17c] panic+0xa0/0x168</div><div>[c01bfd=
80] [c0032eb8] do_exit+0x61c/0x638</div><div>[c01bfdc0] [c000b60c] kernel_b=
ad_stack+0x0/0x4c</div><div>[c01bfdf0] [c000f310] bad_page_fault+0x90/0xd8<=
/div><div>[c01bfe00] [c000e184] handle_page_fault+0x7c/0x80</div><div>[c01b=
fec0] [00000000] (null)</div><div>[c01bff20] [c019023c] unflatten_dt_node+0=
x450/0x520</div><div>[c01bff80] [c01903b4] unflatten_device_tree+0xa8/0x13c=
</div><div>[c01bffb0] [00000000] (null)</div><div>-------------------------=
------------------------------------------</div><div><br></div><div><br></d=
iv><div><br></div><br /><hr />Let us find your next place for you!  <a href=
=3D'http://clk.atdmt.com/NMN/go/157631292/direct/01/' target=3D'_new'>Need =
a place to rent=2C buy or share?</a></body>
</html>=

--_95296fc3-7c24-42fa-99f0-04ee61c8ba4a_--
