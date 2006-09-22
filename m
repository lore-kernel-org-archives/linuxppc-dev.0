Return-Path: <Tony_Hardie@net.com>
Received: from mx03.net.com (mx03.net.com [134.56.3.133])
	by ozlabs.org (Postfix) with ESMTP id 1143A67B6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Sep 2006 04:01:42 +1000 (EST)
Received: from mx02-int.net.com (mx02-int.net.com [134.56.112.14])
	by mx03.net.com (Switch-3.1.8/Switch-3.1.7) with ESMTP id
	k8MHe4Qb023983 for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 10:40:05 -0700 (PDT)
Received: from fmt-ex01.net.com (fmt-ex01.net.com [134.56.112.251])
	by mx02-int.net.com (Switch-3.1.3/Switch-3.1.0) with ESMTP id
	k8MHUpba022610 for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Sep 2006 10:39:28 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DE6D.918D2F0A"
Subject: kernel opps during PCI read
Date: Fri, 22 Sep 2006 10:35:58 -0700
Message-ID: <CE711B0E5D7A1A4096A808997E00832901B32FEE@fmt-ex01.net.com>
From: "Tony Hardie" <Tony_Hardie@net.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DE6D.918D2F0A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hiya, I'm running into the following issue running on our custom PPC8270
(PQ2FADS style) system.

It only seems to happen when we load the system just a little (more PCI
interrupts and transactions).

=20

Any ideas?

=20

=20

/ # [  456.440195] Machine check in kernel mode.

[  456.442646] Caused by (from SRR1=3D41030): Transfer error ack signal

[  456.448828] Oops: machine check, sig: 7 [#1]

[  456.453088] PREEMPT

[  456.455269] NIP: C00119CC LR: C0011914 CTR: C0011334

[  456.460233] REGS: c01fbd40 TRAP: 0200   Tainted: P       (2.6.17.3)

[  456.466493] MSR: 00041030 <ME,IR,DR>  CR: 22002082  XER: 20000000

[  456.472589] TASK =3D c01b5f20[0] 'swapper' THREAD: c01fa000

[  456.477809] GPR00: 00000000 C01FBDF0 C01B5F20 00000000 FFFFFF7F
00000003 00000001 C01FBE18

[  456.486164] GPR08: 00000000 F0010904 00000000 F0010907 00000000
100934F0 07FFF000 00000001

[  456.494520] GPR16: 00800000 07FFE964 FFFFFFFF 00000000 07FFC6BC
007FFF00 FF800040 07FA7770

[  456.502876] GPR24: C0210000 C01FBE58 00000001 000000CF C01FBE18
000000A0 C024A000 C03AAA00

[  456.511406] NIP [C00119CC] indirect_read_config+0x100/0x14c

[  456.516977] LR [C0011914] indirect_read_config+0x48/0x14c

[  456.522373] Call Trace:

[  456.524812] [C01FBDF0] [C01FA028] init_thread_union+0x28/0x2000
(unreliable)

[  456.531862] [C01FBE10] [C00E2FB0] pci_bus_read_config_byte+0x60/0xa8

[  456.538216] [C01FBE50] [C909373C] OnInterrupt+0x40/0x178 [bridge]

[  456.544309] [C01FBE70] [C003EA54] handle_IRQ_event+0x64/0xb8

[  456.549966] [C01FBE90] [C003EBE0] __do_IRQ+0x138/0x1c0

[  456.555102] [C01FBEC0] [C0009D04] do_IRQ+0x44/0x88

[  456.559889] [C01FBEE0] [C0004914] ret_from_except+0x0/0x14

[  456.565372] [C01FBFA0] [C000C9B8] cpu_idle+0xe0/0xf8

[  456.570334] [C01FBFB0] [C0003A64] rest_init+0x3c/0x4c

[  456.575382] [C01FBFC0] [C01FC6C4] start_kernel+0x1d0/0x228

[  456.580865] [C01FBFF0] [000032C0] 0x32c0

[  456.584781] Instruction dump:

[  456.587741] bb410008 38210020 7c0803a6 4e800020 887f004c 813e0010
5460063e 7c004a78

[  456.595487] 3120ffff 7d490110 4bffff70 7c0928ae <0c000000> 4c00012c
901c0000 38600000

 [  456.615184] Kernel panic - not syncing: Aiee, killing interrupt
handler!

=20

Cheers

Tony

=20

Tony Hardie B.Sc
VX Software Architect
Net.com
6900 Paseo Padre Parkway
Fremont
CA, 94555
Ph: 510-574-2386
Mob: 510-449-4339

=20


------_=_NextPart_001_01C6DE6D.918D2F0A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40"
xmlns:ns0=3D"urn:schemas-microsoft-com:office:smarttags">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hiya, I&#8217;m running into the following issue =
running on
our custom PPC8270 (PQ2FADS style) system.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>It only seems to happen when we load the system just =
a
little (more PCI interrupts and =
transactions).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any ideas?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/ # [&nbsp; 456.440195] Machine check in kernel =
mode.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.442646] Caused by (from SRR1=3D41030): =
Transfer error
ack signal<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.448828] Oops: machine check, sig: 7 =
[#1]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.453088] =
PREEMPT<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.455269] NIP: C00119CC LR: C0011914 CTR: =
C0011334<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.460233] REGS: c01fbd40 TRAP: =
0200&nbsp;&nbsp; Tainted: P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;(2.6.17.3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.466493] MSR: 00041030 =
&lt;ME,IR,DR&gt;&nbsp; CR: 22002082&nbsp;
XER: 20000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.472589] TASK =3D c01b5f20[0] 'swapper' =
THREAD: c01fa000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.477809] GPR00: 00000000 C01FBDF0 C01B5F20 =
00000000
FFFFFF7F 00000003 00000001 C01FBE18<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.486164] GPR08: 00000000 F0010904 00000000 =
F0010907
00000000 100934F0 07FFF000 00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.494520] GPR16: 00800000 07FFE964 FFFFFFFF =
00000000
07FFC6BC 007FFF00 FF800040 07FA7770<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.502876] GPR24: C0210000 C01FBE58 00000001 =
000000CF
C01FBE18 000000A0 C024A000 C03AAA00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.511406] NIP [C00119CC]
indirect_read_config+0x100/0x14c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.516977] LR [C0011914] =
indirect_read_config+0x48/0x14c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.522373] Call =
Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.524812] [C01FBDF0] [C01FA028]
init_thread_union+0x28/0x2000 (unreliable)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.531862] [C01FBE10] [C00E2FB0]
pci_bus_read_config_byte+0x60/0xa8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.538216] [C01FBE50] [C909373C] =
OnInterrupt+0x40/0x178
[bridge]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.544309] [C01FBE70] [C003EA54]
handle_IRQ_event+0x64/0xb8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.549966] [C01FBE90] [C003EBE0] =
__do_IRQ+0x138/0x1c0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.555102] [C01FBEC0] [C0009D04] =
do_IRQ+0x44/0x88<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.559889] [C01FBEE0] [C0004914]
ret_from_except+0x0/0x14<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.565372] [C01FBFA0] [C000C9B8] =
cpu_idle+0xe0/0xf8<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.570334] [C01FBFB0] [C0003A64] =
rest_init+0x3c/0x4c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.575382] [C01FBFC0] [C01FC6C4]
start_kernel+0x1d0/0x228<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.580865] [C01FBFF0] [000032C0] =
0x32c0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.584781] Instruction =
dump:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.587741] bb410008 38210020 7c0803a6 =
4e800020 887f004c
813e0010 5460063e 7c004a78<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[&nbsp; 456.595487] 3120ffff 7d490110 4bffff70 =
7c0928ae &lt;0c000000&gt;
4c00012c 901c0000 38600000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&nbsp; 456.615184] Kernel panic - not syncing: =
Aiee, killing
interrupt handler!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Cheers<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Tony<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Tony Hardie
B.Sc<br>
VX Software Architect<br>
Net.com<br>
<st1:Street w:st=3D"on"><st1:address w:st=3D"on">6900 Paseo Padre =
Parkway</st1:address></st1:Street><br>
<st1:place w:st=3D"on"><st1:City =
w:st=3D"on">Fremont</st1:City></st1:place><br>
<ns0:country-region w:insAuthor=3D"Tony Hardie" =
w:insDate=3D"2006-09-22T10:32:00Z"
 w:endInsAuthor=3D"Tony Hardie" =
w:endInsDate=3D"2006-09-22T10:32:00Z"><ns0:place
  w:insAuthor=3D"Tony Hardie" w:insDate=3D"2006-09-22T10:32:00Z"
  w:endInsAuthor=3D"Tony Hardie" =
w:endInsDate=3D"2006-09-22T10:32:00Z">CA, =
94555</ns0:place></ns0:country-region><br>
Ph: 510-574-2386<br>
Mob: 510-449-4339</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6DE6D.918D2F0A--
