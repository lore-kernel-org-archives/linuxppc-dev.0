Return-Path: <mgaouar@solacom.com>
Received: from solacom.com (unknown [209.217.64.195])
	by ozlabs.org (Postfix) with ESMTP id E3E8EDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 05:55:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7F63F.FACA4D75"
Subject: U-Boot problems with MPC8272ADS
Date: Thu, 13 Sep 2007 15:55:05 -0400
Message-ID: <9A1468054ED2FD40907CC3B2C1871D400106CC84@hermes.versatel.com>
From: "Manil Gaouar" <mgaouar@solacom.com>
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

------_=_NextPart_001_01C7F63F.FACA4D75
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

=20

I have a MPC8272ADS evaluation board from Motorolla. I am trying to run
U-Boot and Linux kernel 2.6 on it. I am using the 4.1 ELDK, U-Boot from
the git repos, and Linux kernel 2.6 from git repos.

=20

I am burning U-Boot into the flash using a BDI2000.

=20

My problem is:=20

=20

1-       When burning the U-Boot and setting the jumper JP9 in BSCR
everything works fine, I reboot the board and the memory at 0xfff00000
is locked which probably means that U-Boot is running, but I have no
display on my serial link (running cu S0@115200).

2-       When I put the jumper JP6 in memory position the card keeps
resetting and I have a message error if I connect the BDI to the board
saying:

=20

- TARGET: processing user reset request

- BDI asserts HRESET

- Reset JTAG controller passed

- Bypass check: 0x00000001 =3D> 0x00000001

- JTAG exists check passed

- COP status is 0x7D

- Check running state failed

- TARGET: Target PVR is 0x80822014

*** TARGET: resetting target failed

# PPC: unexpected response from target

- TARGET: target will be restarted in 10 sec

8272>

=20

And it keeps resetting and same message again and again.

=20

Here is my BDI CFG file:

=20

; bdiGDB configuration file for MPC8272ADS board

; ----------------------------------------------

[INIT]

; init core register

WREG    MSR             0x00001002      ;MSR  : ME,RI

WM32         0x0F010004      0xFFFFFFC3     ;SYPCR: disable watchdog

WM32         0x0F0101A8      0x04700000       ;IMMR : internal space @
0x04700000

WM32         0x04710024       0x100C0000      ;BCR  : Single PQ2, ..

WM32         0x04710c94       0x00000001       ;RMR  : checkstop reset
enable

; init memory controller

=20

WM32         0x04710104       0xFF800876      ;OR0: Flash 8MB, CS early
negate, 11 w.s., Timing relax

WM32         0x04710100       0xFF801801      ;BR0: Flash @0xFF800000,
32bit, no parity

WM32         0x0471010C      0xFFFF8010      ;OR1: BCSR 32KB, all types
access, 1 w.s.

WM32         0x04710108       0x04501801       ;BR1: BCSR @0x04500000,
32bit, no parity

WM32         0x04710124       0xFFFF8866      ;OR4: EEPROM 32KB, all
types access, 6 w.s.

WM32         0x04710120       0xC2000801      ;BR4: EEPROM @0xC2000000,
8bit, no parity

; init SDRAM Init (PPC bus)

WM16         0x04710184       0x2800          ;MPTPR: Divide Bus clock
by 41

WM8          0x0471019C      0x13             ;PSRT : Divide MPTPR
output by 20

WM32         0x04710114       0xfe002ec0        ;OR2  : 32MB, 2 banks,
row start at A9, 11 rows

WM32         0x04710110       0x00000041       ;BR2  : SDRAM
@0x00000000, 64bit, no parity

WM32         0x04710190       0x824b36a3       ;PSDMR: Precharge all
banks

WM32         0x04710190       0xaa4b36a3

WM8          0x00000000       0x00             ;Access SDRAM

WM32         0x04710190       0x8a4b36a3       ;PSDMR: CBR Refresh

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM8          0x00000000       0xFF             ;Access SDRAM

WM32         0x04710190       0x9a4b36a3       ;PSDMR: Mode Set

WM8          0x00000190       0x00             ;Access SDRAM

WM32         0x04710190       0xc24b36a3       ;PSDMR: enable refresh,
normal operation

[TARGET]

CPUTYPE     8272        ;the CPU type

JTAGCLOCK   0           ;use 16 MHz JTAG clock

POWERUP     7000        ;start delay after power-up detected in ms

BOOTADDR    0xfff00100  ;boot address used for start-up break

WORKSPACE   0x04700000            ;workspace in target RAM for fast
download

;MEMDELAY    2000        ;additional memory access delay

=20

[HOST]

IP          172.16.0.120

FILE        u-boot.bin

FORMAT      BIN

;FILE        E:\temp\test16k.bin

;FORMAT      BIN 0x04708000

LOAD        MANUAL      ;load code MANUAL or AUTO after reset

DEBUGPORT   2001

PROMPT      8272> ;new prompt for Telnet

;DUMP        /home/solacom/bdi/dump.bin

[FLASH]

CHIPTYPE    I28BX8            ; Flash type

CHIPSIZE    0x200000          ; Single chip size (2 Mbyte)

BUSWIDTH    32                  ; total width for the whole SIMM

WORKSPACE   0x04700000            ;workspace in target RAM for fast
download

FILE        /home/solacom/bdi/1MB_junk.bin

FORMAT      BIN 0xFF800000

ERASE       0xFF800000  ;erase sector  4 of flash SIMM

ERASE       0xFF840000  ;erase sector  5 of flash SIMM

ERASE       0xFF880000  ;erase sector  6 of flash SIMM

ERASE       0xFF8C0000  ;erase sector  7 of flash SIMM

[REGS]

DMM1        0x04700000

FILE        reg8272.def

=20

Here are the commands I used to upload the U-Boot:

=20

8272>unlock

8272>erase

8272>erase 0xfff00000

8272>prog 0xfff00000 u-boot.bin

The prgrammation goes fine.

When I do a 8272>md 0xfff00000 I have the same data as the beginning of
the u-boot.bin, which means that my upload is correct.

=20

Can you help me on this please? My TEXT_BASE is 0xFFF00000 which means
u-boot run from flash, but putting JP9 means running from RAM right?

=20

I am confused about this, I've read a tutorial www.jungo.com/openrg/doc/
4.7/installation_guide/pdf/ppc.pdf and followed their steps to start
U-Boot, but I can not see the U_Boot prompt, may be U-Boot is not
running, I have no clue...Can we know when U-Boot is not running without
display?

=20

Thx for any help...


------_=_NextPart_001_01C7F63F.FACA4D75
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
 /* List Definitions */
 @list l0
	{mso-list-id:225183657;
	mso-list-type:hybrid;
	mso-list-template-ids:209630752 297729790 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:%1-;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a MPC8272ADS evaluation board from Motorolla. =
I am
trying to run U-Boot and Linux kernel 2.6 on it. I am using the 4.1 =
ELDK,
U-Boot from the git repos, and Linux kernel 2.6 from git =
repos.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am burning U-Boot into the flash using a =
BDI2000.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>My problem is: <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>1-<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>When burning
the U-Boot and setting the jumper JP9 in BSCR everything works fine, I =
reboot
the board and the memory at 0xfff00000 is locked which probably means =
that
U-Boot is running, but I have no display on my serial link (running cu
S0@115200).<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>2-<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>When I put
the jumper JP6 in memory position the card keeps resetting and I have a =
message
error if I connect the BDI to the board =
saying:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- TARGET: processing user =
reset
request<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- BDI asserts =
HRESET<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- Reset JTAG controller =
passed<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- Bypass check: 0x00000001 =
=3D&gt;
0x00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- JTAG exists check =
passed<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- COP status is =
0x7D<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- Check running state =
failed<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- TARGET: Target PVR is =
0x80822014<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>*** TARGET: resetting =
target failed<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'># PPC: unexpected response =
from
target<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>- TARGET: target will be =
restarted
in 10 sec<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>8272&gt;<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>And it keeps resetting and =
same
message again and again.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Here is my BDI CFG =
file:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>; bdiGDB configuration file =
for
MPC8272ADS board<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>;
----------------------------------------------<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>[INIT]<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>; init core =
register<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WREG&nbsp;&nbsp;&nbsp;
MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;
0x00001002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;MSR&nbsp; : =
ME,RI<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x0F010004&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFFFFFFC3&nbsp;&nbsp;&nbsp;&nbsp; ;SYPCR:
disable watchdog<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x0F0101A8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x04700000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;IMMR
: internal space @ 0x04700000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x100C0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;BCR&nbsp;
: Single PQ2, ..<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710c94&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000001&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;RMR&nbsp;
: checkstop reset enable<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>; init memory =
controller<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710104&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF800876&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;OR0:
Flash 8MB, CS early negate, 11 w.s., Timing =
relax<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF801801&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;BR0:
Flash @0xFF800000, 32bit, no parity<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x0471010C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFFFF8010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;OR1:
BCSR 32KB, all types access, 1 w.s.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710108&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x04501801&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;BR1:
BCSR @0x04500000, 32bit, no parity<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710124&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFFFF8866&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;OR4:
EEPROM 32KB, all types access, 6 w.s.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710120&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xC2000801&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;BR4:
EEPROM @0xC2000000, 8bit, no parity<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>; init SDRAM Init (PPC =
bus)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM16&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710184&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x2800&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;MPTPR: Divide Bus clock by 41<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0471019C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x13&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;PSRT : Divide MPTPR output by 20<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710114&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xfe002ec0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;OR2&nbsp;
: 32MB, 2 banks, row start at A9, 11 rows<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710110&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000041&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;BR2&nbsp;
: SDRAM @0x00000000, 64bit, no parity<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x824b36a3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;PSDMR:
Precharge all banks<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xaa4b36a3<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x8a4b36a3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;PSDMR:
CBR Refresh<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;Access =
SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFF&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x9a4b36a3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;PSDMR:
Mode Set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM8&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00000190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x00&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
;Access SDRAM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WM32&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x04710190&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xc24b36a3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;PSDMR:
enable refresh, normal operation<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>[TARGET]<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>CPUTYPE&nbsp;&nbsp;&nbsp;&nb=
sp;
8272&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;the CPU =
type<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>JTAGCLOCK&nbsp;&nbsp;
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;use 16 =
MHz JTAG
clock<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>POWERUP&nbsp;&nbsp;&nbsp;&nb=
sp;
7000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;start delay after =
power-up
detected in ms<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>BOOTADDR&nbsp;&nbsp;&nbsp;
0xfff00100&nbsp; ;boot address used for start-up =
break<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WORKSPACE&nbsp;&nbsp; =
0x04700000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ;workspace
in target RAM for fast download<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>;MEMDELAY&nbsp;&nbsp;&nbsp;
2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;additional memory access =
delay<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>[HOST]<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>IP&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;
172.16.0.120<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>FILE&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
u-boot.bin<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>FORMAT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
BIN<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>;FILE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
E:\temp\test16k.bin<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>;FORMAT&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;
BIN 0x04708000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>LOAD&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
MANUAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;load code MANUAL or AUTO after =
reset<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>DEBUGPORT&nbsp;&nbsp; =
2001<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>PROMPT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
8272&gt; ;new prompt for Telnet<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>;DUMP&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
/home/solacom/bdi/dump.bin<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>[FLASH]<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>CHIPTYPE&nbsp;&nbsp;&nbsp;
I28BX8&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ; =
Flash
type<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>CHIPSIZE&nbsp;&nbsp;&nbsp; =
0x200000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;
Single chip size (2 Mbyte)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>BUSWIDTH&nbsp;&nbsp;&nbsp; =
32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;
total width for the whole SIMM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>WORKSPACE&nbsp;&nbsp; =
0x04700000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ;workspace
in target RAM for fast download<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>FILE&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
/home/solacom/bdi/1MB_junk.bin<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>FORMAT&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
BIN 0xFF800000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>ERASE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
0xFF800000&nbsp; ;erase sector&nbsp; 4 of flash =
SIMM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>ERASE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
0xFF840000&nbsp; ;erase sector&nbsp; 5 of flash =
SIMM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>ERASE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
0xFF880000&nbsp; ;erase sector&nbsp; 6 of flash =
SIMM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>ERASE&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;
0xFF8C0000&nbsp; ;erase sector&nbsp; 7 of flash =
SIMM<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>[REGS]<o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>DMM1&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
0x04700000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>FILE&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
reg8272.def<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Here are the commands I =
used to
upload the U-Boot:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>8272&gt;unlock<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>8272&gt;erase<o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>8272&gt;erase =
0xfff00000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>8272&gt;prog 0xfff00000 =
u-boot.bin<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>The prgrammation goes =
fine.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>When I do a 8272&gt;md =
0xfff00000 I
have the same data as the beginning of the u-boot.bin, which means that =
my
upload is correct.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Can you help me on this =
please? My
TEXT_BASE is 0xFFF00000 which means u-boot run from flash, but putting =
JP9
means running from RAM right?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I am confused about this, =
I&#8217;ve
read a tutorial www.jungo.com/openrg/doc/ =
4.7/installation_guide/pdf/ppc.pdf
and followed their steps to start U-Boot, but I can not see the U_Boot =
prompt,
may be U-Boot is not running, I have no clue&#8230;Can we know when =
U-Boot is
not running without display?<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></fo=
nt></p>

<p class=3DMsoNormal style=3D'margin-left:.25in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Thx for any =
help&#8230;<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C7F63F.FACA4D75--
