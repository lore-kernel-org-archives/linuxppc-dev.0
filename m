Return-Path: <Atit_Shah@Satyam.com>
Received: from vvamail.satyam.com (vvamail.satyam.com [208.220.247.17])
	by ozlabs.org (Postfix) with ESMTP id E0E4767A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 15:28:29 +1000 (EST)
Received: from che1.satyam.com (che1.satyam.com [172.18.73.11])
	by vvamail.satyam.com (8.11.6/8.11.6) with ESMTP id j2V4OiR29215
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Mar 2005 23:24:45 -0500
Received: from hyd.satyam.com (localhost [127.0.0.1])
	by che1.satyam.com (8.11.6/8.11.6) with ESMTP id j2V4dR225256
	for <linuxppc-embedded@ozlabs.org>; Thu, 31 Mar 2005 10:09:38 +0530
Received: from hhtnt002.hht.satyam.com (localhost [127.0.0.1])
	by hyd.satyam.com (8.11.6/8.11.6) with ESMTP id j2V4dbg23265
	for <linuxppc-embedded@ozlabs.org>; Thu, 31 Mar 2005 10:09:37 +0530
Message-ID: <A44765C986F8D411995B00B0D0795F4B3C5630A3@hhtnt002>
From: Atit_Shah <Atit_Shah@Satyam.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 31 Mar 2005 10:15:07 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C535AC.69695F0C"
Subject: Linux crashes during memory mapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C535AC.69695F0C
Content-Type: text/plain

Hi All,
  
 I am trying to port the EP8248 Linux image (which works perfectly on the
EP8248 board) on the VPN board (In house board) which is mpc8248 based
board. 

I do not have any problem with the functioning of U-Boot but Linux crashes
after printing "Uncompressing Kernel ... OK" and then it seems that nothing
is happening.

It would be great if u could help me resolve the issue. The following is how
i have configured my board:
 

1. The value of the IMMR in HCRW is configured to 0xF0000000 (which is same
as in the ep8248 image). The value of IMAP_ADDR in
linux/arch/ppc/platforms/ep8248.h and u-boot/include/configs/ep8248.h is
0xF0000000

 

2. The memory map of EP8248 board (REFERENCE BOARD) is :
=====================================================================
Memory Region            Size                              Address Range

=====================================================================
SDRAM                    16MByte                      0000_0000 -- 07FF_FFFF

Flash                    8MByte                       FF80_0000 -- FFFF_FFFF




3. The memory map of the VPN Board (MY BOARD) is as folllows:
=====================================================================
Memory Region            Size                              Address Range

======================================================================
SDRAM                    32MByte                      0000_0000 -- 01FF_FFFF

Flash                    32MByte                      FF00_0000 -- FFFF_FFFF

 

>From the u-boot the parameters passed to the kernel (pointer to a function
which actually starts loading the kernel image) are :

            (*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);

           kbd                (ptr to board info strcture), 
           initrd_start       (=0, as in our case we dont have any ramdisk),

           initrd_end         (=0), 
           cmd_start          (Start of command line string), 
           cmd_end   		(End of command line string)

 
4. Board Info Structure defined in u-boot (/include/asm-ppc/u-boot.h) and
Linux (include/asm-ppc/ep8248.h) are the same and is passed correctly from
u-boot to Linux. 
 

By putting some Printk's I had cheacked that control is reaching to the
function mapin_ram(void) in file arch/ppc/mm/pgtable.c

Here it is supposed to map the 32 MB of virtual memory to the Physical
memory.

The control does not leave the for loop in which the memory mapping takes
place.


This is what the console log buffer has shown:
=================================================================
md 0x00177e34 

00177e34: 3c363e6d 73746172 743d303c 363e6d73    <6>mstart=0<6>ms
00177e44: 697a653d 303c363e 66737461 72743d30    ize=0<6>fstart=0
00177e54: 3c363e66 73697a65 3d303c36 3e696d6d    <6>fsize=0<6>imm
00177e64: 723d303c 363e626f 74666c61 673d303c    r=0<6>botflag=0<
00177e74: 363e6970 6164643d 303c363e 65616464    6>ipadd=0<6>eadd
00177e84: 3d633031 35303032 383c363e 65737065    =c0150028<6>espe
00177e94: 643d303c 363e696e 6974663d 303c363e    d=0<6>initf=0<6>
00177ea4: 62757366 3d303c36 3e63706d 663d303c    busf=0<6>cpmf=0<
00177eb4: 363e6272 67663d30 3c363e73 6363663d    6>brgf=0<6>sccf=
00177ec4: 303c363e 76636f3d 303c363e 62617564    0<6>vco=0<6>baud
00177ed4: 3d304f6f 70733a20 6b65726e 656c2061    =0Oops: kernel a
00177ee4: 63636573 73206f66 20626164 20617265    ccess of bad are
00177ef4: 612c2073 69673a20 31310a3c 343e4e49    a, sig: 11.<4>NI
00177f04: 503a2030 30303030 30303020 5845523a    P: 00000000 XER:
00177f14: 20303030 30303030 30204c52 3a203030     00000000 LR: 00
00177f24: 30303030 30302053 503a2030 30303030    000000 SP: 00000
00177f34: 30303020 52454753 3a206330 31353030    000 REGS: c01500
00177f44: 30302054 5241503a 20303030 30202020    00 TRAP: 0000   
00177f54: 204e6f74 20746169 6e746564 0a3c343e     Not tainted.<4>
00177f64: 4d53523a 20303030 30303030 30204545    MSR: 00000000 EE
00177f74: 3a203020 50523a20 30204650 3a203020    : 0 PR: 0 FP: 0 
00177f84: 4d453a20 30204952 2f44523a 2030300a    ME: 0 IR/DR: 00.
00177f94: 3c343e54 41534b20 3d206330 31346634    <4>TASK = c014f4
00177fa4: 37305b30 5d202773 77617070 65722720    70[0] 'swapper' 
00177fb4: 4c617374 20737973 63616c6c 3a203020    Last syscall: 0 
00177fc4: 0a3c343e 6c617374 206d6174 68203030    .<4>last math 00
00177fd4: 30303030 3030206c 61737420 616c7469    000000 last alti
00177fe4: 76656320 30303030 30303030 0a3c343e    vec 00000000.<4>
00177ff4: 43616c6c 20626163 6b747261 63653a20    Call backtrace: 
00178004: 30303030 30303034 200a3c34 3e4f6f70    00000004 .<4>Oop
00178014: 733a206b 65726e65 6c206163 63657373    s: kernel access
00178024: 206f6620 62616420 61726561 2c207369     of bad area, si
00178034: 673a2031 310a3c34 3e4e4950 3a204330    g: 11.<4>NIP: C0
00178044: 31353030 43302058 45523a20 43303135    1500C0 XER: C015
00178054: 30304138 204c523a 20303330 30303043    00A8 LR: 030000C
00178064: 30205350 3a203030 30333030 30312052    0 SP: 00030001 R
00178074: 4547533a 20633031 35303030 30205452    EGS: c0150000 TR
00178084: 41503a20 63303135 30306330 20202020    AP: c01500c0    
00178094: 4e6f7420 7461696e 7465640a 3c343e4d    Not tainted.<4>M
001780a4: 53523a20 66666666 66646661 2045453a    SR: fffffdfa EE:
001780b4: 20312050 523a2031 2046503a 2031204d     1 PR: 1 FP: 1 M
001780c4: 453a2031 2049522f 44523a20 31310a3c    E: 1 IR/DR: 11.<
001780d4: 343e5441 534b203d 20633031 34663437    4>TASK = c014f47
001780e4: 305b305d 20277377 61707065 7227204c    0[0] 'swapper' L
001780f4: 61737420 73797363 616c6c3a 2030200a    ast syscall: 0 .
00178104: 3c343e6c 61737420 6d617468 20303030    <4>last math 000
00178114: 30303030 30206c61 73742061 6c746976    00000 last altiv
00178124: 65632030 30303030 3030300a 3c343e43    ec 00000000.<4>C
00178134: 616c6c20 6261636b 74726163 653a2030    all backtrace: 0
00178144: 30303030 30303420 0a3c343e 4f6f7073    0000004 .<4>Oops
00178154: 3a206b65 726e656c 20616363 65737320    : kernel access 
00178164: 6f662062 61642061 7265612c 20736967    of bad area, sig
00178174: 3a203131 0a3c343e 4e49503a 20433031    : 11.<4>NIP: C01
00178184: 35303043 30205845 523a2043 30313530    500C0 XER: C0150
00178194: 30413820 4c523a20 30303030 31303332    0A8 LR: 00001032
001781a4: 2053503a 20433030 31333946 30205245     SP: C00139F0 RE
001781b4: 47533a20 63303135 30303030 20545241    GS: c0150000 TRA
001781c4: 503a2063 30313530 30633020 2020204e    P: c01500c0    N
001781d4: 6f742074 61696e74 65640a3c 343e4d53    ot tainted.<4>MS
001781e4: 523a2066 66666666 64666120 45453a20    R: fffffdfa EE: 
001781f4: 31205052 3a203120 46503a20 31204d45    1 PR: 1 FP: 1 ME
00178204: 3a203120 49522f44 523a2031 310a3c34    : 1 IR/DR: 11.<4
00178214: 3e544153 4b203d20 63303134 66343730    >TASK = c014f470
00178224: 5b305d20 27737727 204c6173 74207379    [0] 'sw' Last sy
00178234: 7363616c 6c3a202d 31303732 33363535    scall: -10723655
00178244: 3638200a 3c343e6c 61737420 6d617468    68 .<4>last math
00178254: 20303030 30303030 30206c61 73742061     00000000 last a
00178264: 6c746976 65632030 30303030 3030300a    ltivec 00000000.
00178274: 00000000 00000000 00000000 00000000    ................
 

1.Is all this information sufficient to help you understand and pin point
our mistake, Is there any thing other than the parameters which are passed
to the kernel from the u-boot that I need to look into.

2. I have a query in the Linux source code. I would like to know why the
value of "ioremap_base = 0xfe000000UL;" in linux/arch/ppc/mm/init.c line 356
has been hard coded and how was this value determined? What is the impact of
this value?

Any pointers, ideas, comments would be of great help. i would be more than
glad to provide you with any further information required to debug the
problem.

Thanks and best regards,
Atit
 


************************************************************************** 
This email (including any attachments) is intended for the sole use of the
intended recipient/s and may contain material that is CONFIDENTIAL AND
PRIVATE COMPANY INFORMATION. Any review or reliance by others or copying or
distribution or forwarding of any or all of the contents in this message is
STRICTLY PROHIBITED. If you are not the intended recipient, please contact
the sender by email and delete all copies; your cooperation in this regard
is appreciated.
**************************************************************************

------_=_NextPart_001_01C535AC.69695F0C
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>Linux crashes during memory mapping</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi All,</FONT>
<BR><FONT SIZE=3D2>&nbsp; </FONT>
<BR><FONT SIZE=3D2>&nbsp;I am trying to port the EP8248 Linux image =
(which works perfectly on the EP8248 board) on the VPN board (In house =
board) which is mpc8248 based board. </FONT></P>

<P><FONT SIZE=3D2>I do not have any problem with the functioning of =
U-Boot but Linux crashes after printing "Uncompressing Kernel ... OK" =
and then it seems that nothing is happening.</FONT></P>

<P><FONT SIZE=3D2>It would be great if u could help me resolve the =
issue. The following is how i have configured my board:</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>1. The value of the IMMR in HCRW is configured to =
0xF0000000 (which is same as in the ep8248 image). The value of =
IMAP_ADDR in linux/arch/ppc/platforms/ep8248.h and =
u-boot/include/configs/ep8248.h is 0xF0000000</FONT></P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>2. The memory map of EP8248 board (REFERENCE BOARD) =
is :</FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</FONT>
<BR><FONT SIZE=3D2>Memory =
Region&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address =
Range&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; </FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</FONT>
<BR><FONT =
SIZE=3D2>SDRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16MByte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000_0000 =
-- =
07FF_FFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT =
SIZE=3D2>Flash&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8MByte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FF80_0000 -- =
FFFF_FFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>3. The memory map of the VPN Board (MY BOARD) is as =
folllows:</FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</FONT>
<BR><FONT SIZE=3D2>Memory =
Region&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =
Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address =
Range&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; </FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D</FONT>
<BR><FONT =
SIZE=3D2>SDRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32MByte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000_0000 =
-- =
01FF_FFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT =
SIZE=3D2>Flash&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32MByte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FF00_0000 =
-- =
FFFF_FFFF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>From the u-boot the parameters passed to the kernel =
(pointer to a function which actually starts loading the kernel image) =
are :</FONT></P>

<P><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (*kernel) (kbd, initrd_start, initrd_end, cmd_start, =
cmd_end);</FONT>
</P>

<P><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
kbd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (ptr to board info strcture), </FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
initrd_start&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=3D0, as in our case =
we dont have any ramdisk), </FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
initrd_end&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=3D0), =
</FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cmd_start&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Start =
of command line string), </FONT>
<BR><FONT =
SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cmd_end&nbsp;&nbsp; &nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (End of command line =
string)</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>4. Board Info Structure defined in u-boot =
(/include/asm-ppc/u-boot.h) and Linux (include/asm-ppc/ep8248.h) are =
the same and is passed correctly from u-boot to Linux. </FONT></P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>By putting some Printk's I had cheacked that control =
is reaching to the function mapin_ram(void) in file =
arch/ppc/mm/pgtable.c</FONT></P>

<P><FONT SIZE=3D2>Here it is supposed to map the 32 MB of virtual =
memory to the Physical memory.</FONT>
</P>

<P><FONT SIZE=3D2>The control does not leave the for loop in which the =
memory mapping takes place.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>This is what the console log buffer has shown:</FONT>
<BR><FONT =
SIZE=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT>
<BR><FONT SIZE=3D2>md 0x00177e34 </FONT>
</P>

<P><FONT SIZE=3D2>00177e34: 3c363e6d 73746172 743d303c =
363e6d73&nbsp;&nbsp;&nbsp; &lt;6&gt;mstart=3D0&lt;6&gt;ms</FONT>
<BR><FONT SIZE=3D2>00177e44: 697a653d 303c363e 66737461 =
72743d30&nbsp;&nbsp;&nbsp; ize=3D0&lt;6&gt;fstart=3D0</FONT>
<BR><FONT SIZE=3D2>00177e54: 3c363e66 73697a65 3d303c36 =
3e696d6d&nbsp;&nbsp;&nbsp; &lt;6&gt;fsize=3D0&lt;6&gt;imm</FONT>
<BR><FONT SIZE=3D2>00177e64: 723d303c 363e626f 74666c61 =
673d303c&nbsp;&nbsp;&nbsp; r=3D0&lt;6&gt;botflag=3D0&lt;</FONT>
<BR><FONT SIZE=3D2>00177e74: 363e6970 6164643d 303c363e =
65616464&nbsp;&nbsp;&nbsp; 6&gt;ipadd=3D0&lt;6&gt;eadd</FONT>
<BR><FONT SIZE=3D2>00177e84: 3d633031 35303032 383c363e =
65737065&nbsp;&nbsp;&nbsp; =3Dc0150028&lt;6&gt;espe</FONT>
<BR><FONT SIZE=3D2>00177e94: 643d303c 363e696e 6974663d =
303c363e&nbsp;&nbsp;&nbsp; d=3D0&lt;6&gt;initf=3D0&lt;6&gt;</FONT>
<BR><FONT SIZE=3D2>00177ea4: 62757366 3d303c36 3e63706d =
663d303c&nbsp;&nbsp;&nbsp; busf=3D0&lt;6&gt;cpmf=3D0&lt;</FONT>
<BR><FONT SIZE=3D2>00177eb4: 363e6272 67663d30 3c363e73 =
6363663d&nbsp;&nbsp;&nbsp; 6&gt;brgf=3D0&lt;6&gt;sccf=3D</FONT>
<BR><FONT SIZE=3D2>00177ec4: 303c363e 76636f3d 303c363e =
62617564&nbsp;&nbsp;&nbsp; 0&lt;6&gt;vco=3D0&lt;6&gt;baud</FONT>
<BR><FONT SIZE=3D2>00177ed4: 3d304f6f 70733a20 6b65726e =
656c2061&nbsp;&nbsp;&nbsp; =3D0Oops: kernel a</FONT>
<BR><FONT SIZE=3D2>00177ee4: 63636573 73206f66 20626164 =
20617265&nbsp;&nbsp;&nbsp; ccess of bad are</FONT>
<BR><FONT SIZE=3D2>00177ef4: 612c2073 69673a20 31310a3c =
343e4e49&nbsp;&nbsp;&nbsp; a, sig: 11.&lt;4&gt;NI</FONT>
<BR><FONT SIZE=3D2>00177f04: 503a2030 30303030 30303020 =
5845523a&nbsp;&nbsp;&nbsp; P: 00000000 XER:</FONT>
<BR><FONT SIZE=3D2>00177f14: 20303030 30303030 30204c52 =
3a203030&nbsp;&nbsp;&nbsp;&nbsp; 00000000 LR: 00</FONT>
<BR><FONT SIZE=3D2>00177f24: 30303030 30302053 503a2030 =
30303030&nbsp;&nbsp;&nbsp; 000000 SP: 00000</FONT>
<BR><FONT SIZE=3D2>00177f34: 30303020 52454753 3a206330 =
31353030&nbsp;&nbsp;&nbsp; 000 REGS: c01500</FONT>
<BR><FONT SIZE=3D2>00177f44: 30302054 5241503a 20303030 =
30202020&nbsp;&nbsp;&nbsp; 00 TRAP: 0000&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>00177f54: 204e6f74 20746169 6e746564 =
0a3c343e&nbsp;&nbsp;&nbsp;&nbsp; Not tainted.&lt;4&gt;</FONT>
<BR><FONT SIZE=3D2>00177f64: 4d53523a 20303030 30303030 =
30204545&nbsp;&nbsp;&nbsp; MSR: 00000000 EE</FONT>
<BR><FONT SIZE=3D2>00177f74: 3a203020 50523a20 30204650 =
3a203020&nbsp;&nbsp;&nbsp; : 0 PR: 0 FP: 0 </FONT>
<BR><FONT SIZE=3D2>00177f84: 4d453a20 30204952 2f44523a =
2030300a&nbsp;&nbsp;&nbsp; ME: 0 IR/DR: 00.</FONT>
<BR><FONT SIZE=3D2>00177f94: 3c343e54 41534b20 3d206330 =
31346634&nbsp;&nbsp;&nbsp; &lt;4&gt;TASK =3D c014f4</FONT>
<BR><FONT SIZE=3D2>00177fa4: 37305b30 5d202773 77617070 =
65722720&nbsp;&nbsp;&nbsp; 70[0] 'swapper' </FONT>
<BR><FONT SIZE=3D2>00177fb4: 4c617374 20737973 63616c6c =
3a203020&nbsp;&nbsp;&nbsp; Last syscall: 0 </FONT>
<BR><FONT SIZE=3D2>00177fc4: 0a3c343e 6c617374 206d6174 =
68203030&nbsp;&nbsp;&nbsp; .&lt;4&gt;last math 00</FONT>
<BR><FONT SIZE=3D2>00177fd4: 30303030 3030206c 61737420 =
616c7469&nbsp;&nbsp;&nbsp; 000000 last alti</FONT>
<BR><FONT SIZE=3D2>00177fe4: 76656320 30303030 30303030 =
0a3c343e&nbsp;&nbsp;&nbsp; vec 00000000.&lt;4&gt;</FONT>
<BR><FONT SIZE=3D2>00177ff4: 43616c6c 20626163 6b747261 =
63653a20&nbsp;&nbsp;&nbsp; Call backtrace: </FONT>
<BR><FONT SIZE=3D2>00178004: 30303030 30303034 200a3c34 =
3e4f6f70&nbsp;&nbsp;&nbsp; 00000004 .&lt;4&gt;Oop</FONT>
<BR><FONT SIZE=3D2>00178014: 733a206b 65726e65 6c206163 =
63657373&nbsp;&nbsp;&nbsp; s: kernel access</FONT>
<BR><FONT SIZE=3D2>00178024: 206f6620 62616420 61726561 =
2c207369&nbsp;&nbsp;&nbsp;&nbsp; of bad area, si</FONT>
<BR><FONT SIZE=3D2>00178034: 673a2031 310a3c34 3e4e4950 =
3a204330&nbsp;&nbsp;&nbsp; g: 11.&lt;4&gt;NIP: C0</FONT>
<BR><FONT SIZE=3D2>00178044: 31353030 43302058 45523a20 =
43303135&nbsp;&nbsp;&nbsp; 1500C0 XER: C015</FONT>
<BR><FONT SIZE=3D2>00178054: 30304138 204c523a 20303330 =
30303043&nbsp;&nbsp;&nbsp; 00A8 LR: 030000C</FONT>
<BR><FONT SIZE=3D2>00178064: 30205350 3a203030 30333030 =
30312052&nbsp;&nbsp;&nbsp; 0 SP: 00030001 R</FONT>
<BR><FONT SIZE=3D2>00178074: 4547533a 20633031 35303030 =
30205452&nbsp;&nbsp;&nbsp; EGS: c0150000 TR</FONT>
<BR><FONT SIZE=3D2>00178084: 41503a20 63303135 30306330 =
20202020&nbsp;&nbsp;&nbsp; AP: c01500c0&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>00178094: 4e6f7420 7461696e 7465640a =
3c343e4d&nbsp;&nbsp;&nbsp; Not tainted.&lt;4&gt;M</FONT>
<BR><FONT SIZE=3D2>001780a4: 53523a20 66666666 66646661 =
2045453a&nbsp;&nbsp;&nbsp; SR: fffffdfa EE:</FONT>
<BR><FONT SIZE=3D2>001780b4: 20312050 523a2031 2046503a =
2031204d&nbsp;&nbsp;&nbsp;&nbsp; 1 PR: 1 FP: 1 M</FONT>
<BR><FONT SIZE=3D2>001780c4: 453a2031 2049522f 44523a20 =
31310a3c&nbsp;&nbsp;&nbsp; E: 1 IR/DR: 11.&lt;</FONT>
<BR><FONT SIZE=3D2>001780d4: 343e5441 534b203d 20633031 =
34663437&nbsp;&nbsp;&nbsp; 4&gt;TASK =3D c014f47</FONT>
<BR><FONT SIZE=3D2>001780e4: 305b305d 20277377 61707065 =
7227204c&nbsp;&nbsp;&nbsp; 0[0] 'swapper' L</FONT>
<BR><FONT SIZE=3D2>001780f4: 61737420 73797363 616c6c3a =
2030200a&nbsp;&nbsp;&nbsp; ast syscall: 0 .</FONT>
<BR><FONT SIZE=3D2>00178104: 3c343e6c 61737420 6d617468 =
20303030&nbsp;&nbsp;&nbsp; &lt;4&gt;last math 000</FONT>
<BR><FONT SIZE=3D2>00178114: 30303030 30206c61 73742061 =
6c746976&nbsp;&nbsp;&nbsp; 00000 last altiv</FONT>
<BR><FONT SIZE=3D2>00178124: 65632030 30303030 3030300a =
3c343e43&nbsp;&nbsp;&nbsp; ec 00000000.&lt;4&gt;C</FONT>
<BR><FONT SIZE=3D2>00178134: 616c6c20 6261636b 74726163 =
653a2030&nbsp;&nbsp;&nbsp; all backtrace: 0</FONT>
<BR><FONT SIZE=3D2>00178144: 30303030 30303420 0a3c343e =
4f6f7073&nbsp;&nbsp;&nbsp; 0000004 .&lt;4&gt;Oops</FONT>
<BR><FONT SIZE=3D2>00178154: 3a206b65 726e656c 20616363 =
65737320&nbsp;&nbsp;&nbsp; : kernel access </FONT>
<BR><FONT SIZE=3D2>00178164: 6f662062 61642061 7265612c =
20736967&nbsp;&nbsp;&nbsp; of bad area, sig</FONT>
<BR><FONT SIZE=3D2>00178174: 3a203131 0a3c343e 4e49503a =
20433031&nbsp;&nbsp;&nbsp; : 11.&lt;4&gt;NIP: C01</FONT>
<BR><FONT SIZE=3D2>00178184: 35303043 30205845 523a2043 =
30313530&nbsp;&nbsp;&nbsp; 500C0 XER: C0150</FONT>
<BR><FONT SIZE=3D2>00178194: 30413820 4c523a20 30303030 =
31303332&nbsp;&nbsp;&nbsp; 0A8 LR: 00001032</FONT>
<BR><FONT SIZE=3D2>001781a4: 2053503a 20433030 31333946 =
30205245&nbsp;&nbsp;&nbsp;&nbsp; SP: C00139F0 RE</FONT>
<BR><FONT SIZE=3D2>001781b4: 47533a20 63303135 30303030 =
20545241&nbsp;&nbsp;&nbsp; GS: c0150000 TRA</FONT>
<BR><FONT SIZE=3D2>001781c4: 503a2063 30313530 30633020 =
2020204e&nbsp;&nbsp;&nbsp; P: c01500c0&nbsp;&nbsp;&nbsp; N</FONT>
<BR><FONT SIZE=3D2>001781d4: 6f742074 61696e74 65640a3c =
343e4d53&nbsp;&nbsp;&nbsp; ot tainted.&lt;4&gt;MS</FONT>
<BR><FONT SIZE=3D2>001781e4: 523a2066 66666666 64666120 =
45453a20&nbsp;&nbsp;&nbsp; R: fffffdfa EE: </FONT>
<BR><FONT SIZE=3D2>001781f4: 31205052 3a203120 46503a20 =
31204d45&nbsp;&nbsp;&nbsp; 1 PR: 1 FP: 1 ME</FONT>
<BR><FONT SIZE=3D2>00178204: 3a203120 49522f44 523a2031 =
310a3c34&nbsp;&nbsp;&nbsp; : 1 IR/DR: 11.&lt;4</FONT>
<BR><FONT SIZE=3D2>00178214: 3e544153 4b203d20 63303134 =
66343730&nbsp;&nbsp;&nbsp; &gt;TASK =3D c014f470</FONT>
<BR><FONT SIZE=3D2>00178224: 5b305d20 27737727 204c6173 =
74207379&nbsp;&nbsp;&nbsp; [0] 'sw' Last sy</FONT>
<BR><FONT SIZE=3D2>00178234: 7363616c 6c3a202d 31303732 =
33363535&nbsp;&nbsp;&nbsp; scall: -10723655</FONT>
<BR><FONT SIZE=3D2>00178244: 3638200a 3c343e6c 61737420 =
6d617468&nbsp;&nbsp;&nbsp; 68 .&lt;4&gt;last math</FONT>
<BR><FONT SIZE=3D2>00178254: 20303030 30303030 30206c61 =
73742061&nbsp;&nbsp;&nbsp;&nbsp; 00000000 last a</FONT>
<BR><FONT SIZE=3D2>00178264: 6c746976 65632030 30303030 =
3030300a&nbsp;&nbsp;&nbsp; ltivec 00000000.</FONT>
<BR><FONT SIZE=3D2>00178274: 00000000 00000000 00000000 =
00000000&nbsp;&nbsp;&nbsp; ................</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
</P>

<P><FONT SIZE=3D2>1.Is all this information sufficient to help you =
understand and pin point our mistake, Is there any thing other than the =
parameters which are passed to the kernel from the u-boot that I need =
to look into.</FONT></P>

<P><FONT SIZE=3D2>2. I have a query in the Linux source code. I would =
like to know why the value of &quot;ioremap_base =3D =
0xfe000000UL;&quot; in linux/arch/ppc/mm/init.c line 356 has been hard =
coded and how was this value determined? What is the impact of this =
value?</FONT></P>

<P><FONT SIZE=3D2>Any pointers, ideas, comments would be of great help. =
i would be more than glad to provide you with any further information =
required to debug the problem.</FONT></P>

<P><FONT SIZE=3D2>Thanks and best regards,</FONT>
<BR><FONT SIZE=3D2>Atit</FONT>
<BR><FONT SIZE=3D2>&nbsp;</FONT>
</P>
<BR>

<P><FONT =
SIZE=3D2>***************************************************************=
*********** </FONT>
<BR><FONT SIZE=3D2>This email (including any attachments) is intended =
for the sole use of the intended recipient/s and may contain material =
that is CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any review or =
reliance by others or copying or distribution or forwarding of any or =
all of the contents in this message is STRICTLY PROHIBITED. If you are =
not the intended recipient, please contact the sender by email and =
delete all copies; your cooperation in this regard is =
appreciated.</FONT></P>

<P><FONT =
SIZE=3D2>***************************************************************=
***********</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C535AC.69695F0C--
