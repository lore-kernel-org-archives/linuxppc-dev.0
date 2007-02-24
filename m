Return-Path: <yhkim93@keti.re.kr>
Received: from smf.keti.re.kr (unknown [203.253.128.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49490DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 15:37:54 +1100 (EST)
From: =?ks_c_5601-1987?B?sei/tciv?= <yhkim93@keti.re.kr>
To: <linuxppc-embedded@ozlabs.org>
Subject: prblem Initializing the PCIe Bridge at u-boot
Date: Sat, 24 Feb 2007 13:37:43 +0900
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C75818.F63730E0"
Message-Id: <20070224043755.49490DDE39@ozlabs.org>
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

------=_NextPart_000_0004_01C75818.F63730E0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

Hi,

I am using to the LSI SAS MEGARAID SAS 8480E adapter. And I am under
debugging u-boot-1.2.0. u-boot-1.2.0 and kernel-2.6.20(denx's git) don't
include the code to scan and setup under pcie bridge, Right?

 I have checked the LSI adapter at general linux system. The structure =
of
the LSI Adapter is the following. I don=A1=AFt know exactly why only =
bridge
find and setup at u-boot. Help me please.

=20

=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D

[root@node-5 ~]# lspci=20

=20

06:08.0 SCSI storage controller: LSI Logic / Symbios Logic: Unknown =
device
0054 (rev 01)

        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000

        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11

        I/O ports at d000 [size=3D256]

        Memory at dfffc000 (64-bit, non-prefetchable) [size=3D16K]

        Memory at dffe0000 (64-bit, non-prefetchable) [size=3D64K]

        Expansion ROM at dfc00000 [disabled] [size=3D2M]

        Capabilities: [50] Power Management version 2

        Capabilities: [98] Message Signalled Interrupts: 64bit+ =
Queue=3D0/0
Enable-

        Capabilities: [68] PCI-X non-bridge device.

=20

06:0e.0 Memory controller: Intel Corp.: Unknown device 0374

        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, =
IRQ 6

        Memory at e7000000 (64-bit, prefetchable) [size=3D16M]

        Capabilities: [c0] Power Management version 2

        Capabilities: [d0] Message Signalled Interrupts: 64bit+ =
Queue=3D0/1
Enable-

        Capabilities: [e0] PCI-X non-bridge device.

=20

[root@node-5 ~]# lspci -t

-[0000:00]-+-00.0

           +-01.0-[0000:07]----00.0

           +-1b.0

           +-1c.0-[0000:04-06]--+-00.0-[0000:06]--+-08.0

           |                    |                 \-0e.0

           |                    \-00.2-[0000:05]--

           +-1c.4-[0000:03]----00.0

           +-1c.5-[0000:02]----00.0

           +-1d.0

           +-1d.1

           +-1d.2

           +-1d.3

           +-1d.7

           +-1e.0-[0000:01]--+-03.0

           |                 \-04.0

           +-1f.0

           +-1f.1

           +-1f.2

           \-1f.3

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The following text is printing at u-boot

=20

=20

U-Boot 1.2.0 (Feb 24 2007 - 12:11:00)


=20


CPU:   AMCC PowerPC 440SPe Rev. B at 533.328 MHz (PLB=3D133, OPB=3D66, =
EBC=3D66
MHz) =20

       RAID 6 support


       I2C boot EEPROM enabled


       Bootstrap Option D - Boot ROM Location I2C (Addr 0x50)


       Internal PCI arbiter enabled


       32 kB I-Cache 32 kB D-Cache


Board: Yucca - AMCC 440SPe Evaluation Board


I2C:   ready


DRAM:  DIMM slot 0: DDR2 SDRAM detected


DIMM slot 1: DDR2 SDRAM detected


1024 MB


Now running in RAM - U-Boot at: 3ffb2000


FLASH:  5 MB


*** Warning - bad CRC, using default environment


=20


PCI:   Bus Dev VenId DevId Class Int


PCI Autoconfig: Memory region: [80000000-8fffffff]


PCI Autoconfig: I/O region: [0-ffff]


PCIE:1 successfully set as rootpoint


PCI Autoconfig: Memory region: [b1000000-b1ffffff]


PCI Scan: Found Bus 1, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource


PCI Autoconfig: Found P2P bridge, device 1


PCI Scan: Found Bus 1, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource


PCI Autoconfig: Found P2P bridge, device 1


PCI Scan: Found Bus 2, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource


PCI Autoconfig: Found P2P bridge, device 1


PCI Scan: Found Bus 3, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource


PCI Autoconfig: Found P2P bridge, device 1


PCI Scan: Found Bus 4, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource


PCI Autoconfig: Found P2P bridge, device 1


PCI Scan: Found Bus 5, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource


PCI Autoconfig: Found P2P bridge, device 1


PCI Scan: Found Bus 6, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource


PCI Autoconfig: Found P2P bridge, device 1


PCI Scan: Found Bus 7, Device 1, Function 0


PCI Autoconfig: BAR 0, I/O, size=3D0x4, No resource

=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6..

=20

=20


------=_NextPart_000_0004_01C75818.F63730E0
Content-Type: text/html;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dks_c_5601-1987">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"time"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:=B9=D9=C5=C1;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:=B1=BC=B8=B2;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B1=BC=B8=B2";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B9=D9=C5=C1";
	panose-1:2 3 6 0 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:=B9=D9=C5=C1;}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:=B1=BC=B8=B2;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:99.25pt 3.0cm 3.0cm 3.0cm;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DKO link=3Dblue vlink=3Dpurple>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>I am =
using to the
LSI SAS MEGARAID SAS 8480E adapter. And I am under debugging =
u-boot-1.2.0. u-boot-1.2.0
and kernel-2.6.20(denx's git) don't include the code to scan and setup =
under
pcie bridge, Right?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;I have
checked the LSI adapter at general linux system. The structure of the =
LSI
Adapter is the following. I don=A1=AFt know exactly why only bridge find =
and setup
at u-boot. Help me please.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p=
></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>[root@node-5 ~]#
lspci <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><st1:time =
o:ls=3D"trans"
Hour=3D"18" Minute=3D"8" w:st=3D"on"><font size=3D2 face=3D"Courier =
New"><span
 lang=3DEN-US =
style=3D'font-size:10.0pt'>06:08</span></font></st1:time><span
lang=3DEN-US>.0 SCSI storage controller: LSI Logic / Symbios Logic: =
Unknown
device 0054 (rev 01)<o:p></o:p></span></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Subsystem: LSI Logic / Symbios Logic: Unknown device =
1000<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ =
11<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I/O ports at d000 [size=3D256]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Memory at dfffc000 (64-bit, non-prefetchable) =
[size=3D16K]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Memory at dffe0000 (64-bit, non-prefetchable) =
[size=3D64K]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Expansion ROM at dfc00000 [disabled] =
[size=3D2M]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [50] Power Management version =
2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [98] Message Signalled Interrupts: 64bit+ Queue=3D0/0 =
Enable-<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [68] PCI-X non-bridge device.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><st1:time =
o:ls=3D"trans"
Hour=3D"18" Minute=3D"0" w:st=3D"on"><font size=3D2 face=3D"Courier =
New"><span
 lang=3DEN-US =
style=3D'font-size:10.0pt'>06:0</span></font></st1:time><span
lang=3DEN-US>e.0 Memory controller: Intel Corp.: Unknown device =
0374<o:p></o:p></span></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ =
6<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Memory at e7000000 (64-bit, prefetchable) =
[size=3D16M]<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [c0] Power Management version =
2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=3D0/1 =
Enable-<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [e0] PCI-X non-bridge device.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>[root@node-5 ~]#
lspci -t<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>-[0000:00]-+-00.0<o:p></o:p></span></font></p>=


<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-01.0-[0000:07]----00.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1b.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
<font color=3Dred><span =
style=3D'color:red'>+-1c.0-[0000:04-06]--+-00.0-[0000:06]--+-08.0<o:p></o=
:p></span></font></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2 =
color=3Dred
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt;color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
\-0e.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2 =
color=3Dred
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt;color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
\-00.2-[0000:05]--<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1c.4-[0000:03]----00.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1c.5-[0000:02]----00.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1d.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1d.1<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1d.2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1d.3<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1d.7<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1e.0-[0000:01]--+-03.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
\-04.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1f.0<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1f.1<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
+-1f.2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
\-1f.3<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></spa=
n></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>The =
following text
is printing at u-boot<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>U-Boot 1.2.0 (Feb
24 2007 - <st1:time o:ls=3D"trans" Hour=3D"12" Minute=3D"11" =
w:st=3D"on">12:11:00</st1:time>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>CPU:&nbsp;&nbsp;
AMCC PowerPC 440SPe Rev. B at 533.328 MHz (PLB=3D133, OPB=3D66, EBC=3D66 =
MHz)&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
RAID 6
support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I2C boot EEPROM
enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Bootstrap Option D - Boot ROM Location I2C (Addr
0x50)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Internal PCI arbiter
enabled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
32 kB I-Cache 32 kB
D-Cache&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Board: Yucca -
AMCC 440SPe Evaluation
Board&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>I2C:&nbsp;&nbsp;
ready&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>DRAM:&nbsp; DIMM
slot 0: DDR2 SDRAM
detected&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>DIMM =
slot 1: DDR2
SDRAM
detected&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>1024
MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>Now =
running in RAM
- U-Boot at:
3ffb2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>FLASH:&nbsp; 5
MB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>*** =
Warning - bad
CRC, using default
environment&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>PCI:&nbsp;&nbsp;
Bus Dev VenId DevId Class
Int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Memory region:
[80000000-8fffffff]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
I/O region: [0-ffff]&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>PCIE:1
successfully set as
rootpoint&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Memory region:
[b1000000-b1ffffff]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 1, Device 1, Function =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No
resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Found P2P bridge, device
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 1, Device 1, Function
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No
resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Found P2P bridge, device
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 2, Device 1, Function
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No
resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Found P2P bridge, device
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 3, Device 1, Function
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No
resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Found P2P bridge, device
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 4, Device 1, Function
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No
resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Found P2P bridge, device
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 5, Device 1, Function
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No
resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Found P2P bridge, device
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 6, Device 1, Function
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No =
resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
Found P2P bridge, device
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Scan: Found
Bus 7, Device 1, Function
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US style=3D'font-size:10.0pt'>PCI =
Autoconfig:
BAR 0, I/O, size=3D0x4, No resource<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'>=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=A1=A6=
=A1=A6=A1=A6..<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'layout-grid-mode:char'><font size=3D2
face=3D"Courier New"><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D=B1=BC=B8=B2><span =
lang=3DEN-US style=3D'font-size:10.0pt;
font-family:=B1=BC=B8=B2'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C75818.F63730E0--
