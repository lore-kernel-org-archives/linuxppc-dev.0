Return-Path: <randy.sharo@bluecollarobjects.com>
Received: from mail12.simplicato.com (mail12.simplicato.com [207.99.47.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 829EDDDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 04:47:33 +1000 (EST)
From: "Randy Sharo" <randy.sharo@bluecollarobjects.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: DMA-related IDE driver crash on mount of second partition
Date: Fri, 28 Sep 2007 14:23:16 -0400
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAKiGDOVWzK5GqPANxc0huUPCgAAAEAAAACdQuqHS3zFGjLevSRjwXUwBAAAAAA==@bluecollarobjects.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001C_01C801DB.1D66EF90"
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

------=_NextPart_000_001C_01C801DB.1D66EF90
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_001D_01C801DB.1D66EF90"


------=_NextPart_001_001D_01C801DB.1D66EF90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

I could use some guidance on tracking down this problem.

 

I have all off-the-shelf components:

   * Artesyn PMPPC440  PMC (uses 440gp processor)

   * Artesyn CC1000dm carrier card

   * Kontron PMC-HDD1 hard drive module.

 

I'm running U-boot with linux kernel 2.4.10.  The system boots, but the
kernel is unable to allocate resource region 5 of the IDE controller at
0xa0000000.  

 

Even without region 5, I can mount and access a hard drive partition.  When
I mount a second partition I get a kernel oops, though.  The two partitions
are normal ext3 partitions and there is nothing wrong with the hard drive
images - I can mount either individually with no problems.  But the kernel
crashes when I mount both together.

 

I've traced the oops to determine that the kernel is trying to (and failing
to) invalidate the cache for address 0xE0000000.  Per the output of lspci,
the 0xA0000000 window is not large enough to extend to 0xE000000.  I don't
understand why the driver is trying to access such a high address.

 

Any advice on how to resolve the resource conflict and/or crash would be
appreciated.

 

I've attached my kernel config and a complete listing of the boot sequence
and error.  Here are the immediately relevant lines, though:

 

   At boot time:

 

PCI: Probing PCI hardware

PCI: Cannot allocate resource region 5 of device 0000:00:06.0

PCI: Failed to allocate mem resource #5:100@a0000000 for 0000:00:06.0

.

.

.

SiI680: IDE controller at PCI slot 0000:00:06.0

SiI680: chipset revision 2

siimage: IDE controller MMIO ports not available.

SiI680: BASE CLOCK == 100

SiI680: 100% native mode on irq 25

    ide0: BM-DMA at 0xffd0-0xffd7, BIOS settings: hda:pio, hdb:pio

    ide1: BM-DMA at 0xffd8-0xffdf, BIOS settings: hdc:pio, hdd:pio

hda: HTS424040M9AT00, ATA DISK drive

 

 

   At run time:

 

bash-2.05b# lspci -v

00:02.0 Class 0680: 3388:0021 (rev 04)

        Subsystem: 1223:003a

        Flags: bus master, stepping, 66Mhz, medium devsel, latency 128, IRQ
25

        Memory at 80000000 (32-bit, prefetchable) [size=512M]

        Capabilities: [dc] Power Management version 4

        Capabilities: [e4] #06 [0094]

        Capabilities: [e8] Vital Product Data

 

00:06.0 Class 0101: 1095:0680 (rev 02) (prog-if 85 [Master SecO PriO])

        Subsystem: 1095:0680

        Flags: bus master, medium devsel, latency 128, IRQ 25

        I/O ports at fff8 [size=8]

        I/O ports at fff4 [size=4]

        I/O ports at ffe8 [size=8]

        I/O ports at ffe4 [size=4]

        I/O ports at ffd0 [size=16]

        Memory at a0000000 (32-bit, non-prefetchable)

        Expansion ROM at a0080000 [disabled] [size=512K]

        Capabilities: [60] Power Management version 2

 

bash-2.05b# mount /dev/ide/host0/bus0/target0/lun0/part3 x

bash-2.05b# ls x

bin  boot  etc  images  lib  lost+found  mnt  proc  root  sbin  tmp  usr
var

bash-2.05b# mount /dev/ide/host0/bus0/target0/lun0/part1 y

Oops: kernel access of bad area, sig: 11 [#1]

NIP: C0003804 LR: C00081B0 SP: DE8A3AF0 REGS: de8a3a40 TRAP: 0300    Not
tainted

 

MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

DAR: E0000000, DSISR: 00800000

TASK = dfe9ae20[336] 'mount' THREAD: de8a2000

Last syscall: 21

PLB0: bear= 0x00000000 acr=   0x9b000000 besr=  0x00000000

 

GPR00: C00082B4 DE8A3AF0 DFE9AE20 E0000000 07FFFFE0 0000001F 00000002
C02A0000

GPR08: 00000000 1FB44000 00000000 C02A0000 00000001 1002863C 1FFA8600
100C0000

GPR16: 00000000 00000000 100D0888 100C2A88 00000001 C02A0000 00029000
00000001

GPR24: 00000002 00000400 00000000 FFFFFC00 DE8A2000 DFB44800 C06BF880
FFFFFC00

NIP [c0003804] invalidate_dcache_range+0x1c/0x30

LR [c00081b0] __dma_sync+0x54/0x60

Call trace:

 [c00082b4] __dma_sync_page+0xf8/0x19c

 [c01467c0] ide_build_sglist+0xa8/0xf8

 [c0146840] ide_build_dmatable+0x30/0x1ac

 [c0146d64] ide_dma_setup+0x3c/0xc8

 [c0148ee4] __ide_do_rw_disk+0x2b8/0x598

 [c013e0f0] start_request+0x190/0x280

 [c013e438] ide_do_request+0x238/0x3d8

 [c011711c] __generic_unplug_device+0x68/0x6c

 [c011713c] generic_unplug_device+0x1c/0x38

 [c0117190] blk_backing_dev_unplug+0x38/0x3c

 [c0056a68] sync_buffer+0x64/0x68

 [c01ca8c4] __wait_on_bit+0xb0/0xc0

 [c01ca934] out_of_line_wait_on_bit+0x60/0x74

 [c0056b30] __wait_on_buffer+0x3c/0x40

 [c0058560] __bread_slow+0xac/0xd4

note: mount[336] exited with preempt_count 1

 

 

 

Regards,

   Randy Sharo

   Blue Collar Objects, LLC


------=_NextPart_001_001D_01C801DB.1D66EF90
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
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I could use some guidance on tracking down this =
problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have all off-the-shelf =
components:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; * Artesyn PMPPC440&nbsp; PMC (uses 440gp
processor)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; * Artesyn CC1000dm carrier =
card<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; * Kontron PMC-HDD1 hard drive =
module.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m running U-boot with linux kernel =
2.4.10.&nbsp; The
system boots, but the kernel is unable to allocate resource region 5 of =
the IDE
controller at 0xa0000000.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Even without region 5, I can mount and access a hard =
drive
partition.&nbsp; When I mount a second partition I get a kernel oops, =
though. &nbsp;The
two partitions are normal ext3 partitions and there is nothing wrong =
with the
hard drive images &#8211; I can mount either individually with no =
problems. &nbsp;But
the kernel crashes when I mount both =
together.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;ve traced the oops to determine that the =
kernel is
trying to (and failing to) invalidate the cache for address =
0xE0000000.&nbsp; Per
the output of lspci, the 0xA0000000 window is not large enough to extend =
to
0xE000000.&nbsp; I don&#8217;t understand why the driver is trying to =
access
such a high address.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any advice on how to resolve the resource conflict =
and/or
crash would be appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;ve attached my kernel config and a complete =
listing
of the boot sequence and error. &nbsp;Here are the immediately relevant =
lines,
though:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; At boot =
time:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Probing PCI =
hardware<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Cannot =
allocate
resource region 5 of device 0000:00:06.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PCI: Failed to =
allocate mem
resource #5:100@a0000000 for 0000:00:06.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>SiI680: IDE =
controller at
PCI slot 0000:00:06.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>SiI680: chipset =
revision 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>siimage: IDE =
controller MMIO
ports not available.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>SiI680: BASE CLOCK =
=3D=3D 100<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>SiI680: 100% native =
mode on
irq 25<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
ide0:
BM-DMA at 0xffd0-0xffd7, BIOS settings: hda:pio, =
hdb:pio<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;&nbsp;&nbsp; =
ide1:
BM-DMA at 0xffd8-0xffdf, BIOS settings: hdc:pio, =
hdd:pio<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>hda: =
HTS424040M9AT00, ATA
DISK drive<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; At run =
time:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# lspci =
-v<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>00:02.0 Class 0680:
3388:0021 (rev 04)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Subsystem: 1223:003a<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Flags: bus master, stepping, 66Mhz, medium devsel, latency 128, IRQ =
25<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Memory at 80000000 (32-bit, prefetchable) =
[size=3D512M]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [dc] Power Management version =
4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [e4] #06 [0094]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [e8] Vital Product Data<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>00:06.0 Class 0101:
1095:0680 (rev 02) (prog-if 85 [Master SecO =
PriO])<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Subsystem: 1095:0680<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Flags: bus master, medium devsel, latency 128, IRQ =
25<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I/O ports at fff8 [size=3D8]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I/O ports at fff4 [size=3D4]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I/O ports at ffe8 [size=3D8]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I/O ports at ffe4 [size=3D4]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
I/O ports at ffd0 [size=3D16]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Memory at a0000000 (32-bit, =
non-prefetchable)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;Expansion ROM at a0080000 [disabled] =
[size=3D512K]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Capabilities: [60] Power Management version =
2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# mount
/dev/ide/host0/bus0/target0/lun0/part3 x<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# ls =
x<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bin&nbsp; =
boot&nbsp;
etc&nbsp; images&nbsp; lib&nbsp; lost+found&nbsp; mnt&nbsp; proc&nbsp;
root&nbsp; sbin&nbsp; tmp&nbsp; usr&nbsp; =
var<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# mount
/dev/ide/host0/bus0/target0/lun0/part1 y<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Oops: kernel access =
of bad
area, sig: 11 [#1]<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NIP: C0003804 LR: =
C00081B0
SP: DE8A3AF0 REGS: de8a3a40 TRAP: 0300&nbsp;&nbsp;&nbsp; Not =
tainted<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>MSR: 00021000 EE: 0 =
PR: 0
FP: 0 ME: 1 IR/DR: 00<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>DAR: E0000000, =
DSISR:
00800000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>TASK =3D =
dfe9ae20[336] 'mount'
THREAD: de8a2000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Last syscall: =
21<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>PLB0: bear=3D =
0x00000000
acr=3D&nbsp;&nbsp; 0x9b000000 besr=3D&nbsp; =
0x00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR00: C00082B4 =
DE8A3AF0
DFE9AE20 E0000000 07FFFFE0 0000001F 00000002 =
C02A0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR08: 00000000 =
1FB44000
00000000 C02A0000 00000001 1002863C 1FFA8600 =
100C0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR16: 00000000 =
00000000
100D0888 100C2A88 00000001 C02A0000 00029000 =
00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>GPR24: 00000002 =
00000400
00000000 FFFFFC00 DE8A2000 DFB44800 C06BF880 =
FFFFFC00<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>NIP [c0003804]
invalidate_dcache_range+0x1c/0x30<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>LR [c00081b0]
__dma_sync+0x54/0x60<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Call =
trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font><font
size=3D2 face=3D"Courier New"><span lang=3DFR =
style=3D'font-size:10.0pt;font-family:
"Courier New"'>[c00082b4] =
__dma_sync_page+0xf8/0x19c<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DFR style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>[c01467c0]
ide_build_sglist+0xa8/0xf8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c0146840]
ide_build_dmatable+0x30/0x1ac<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font><font
size=3D2 face=3D"Courier New"><span lang=3DDE =
style=3D'font-size:10.0pt;font-family:
"Courier New"'>[c0146d64] =
ide_dma_setup+0x3c/0xc8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
lang=3DDE style=3D'font-size:10.0pt;font-family:"Courier =
New"'>&nbsp;</span></font><font
size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-family:"Courier New"'>[c0148ee4]
__ide_do_rw_disk+0x2b8/0x598<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c013e0f0]
start_request+0x190/0x280<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c013e438]
ide_do_request+0x238/0x3d8<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c011711c]
__generic_unplug_device+0x68/0x6c<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c011713c]
generic_unplug_device+0x1c/0x38<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c0117190]
blk_backing_dev_unplug+0x38/0x3c<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c0056a68]
sync_buffer+0x64/0x68<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c01ca8c4] =
__wait_on_bit+0xb0/0xc0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c01ca934]
out_of_line_wait_on_bit+0x60/0x74<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c0056b30]
__wait_on_buffer+0x3c/0x40<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>&nbsp;[c0058560]
__bread_slow+0xac/0xd4<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>note: mount[336] =
exited with
preempt_count 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Randy Sharo<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Blue Collar Objects, =
LLC<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_001D_01C801DB.1D66EF90--

------=_NextPart_000_001C_01C801DB.1D66EF90
Content-Type: text/plain;
	name="config.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config.txt"

#=0A=
# Automatically generated make config: don't edit=0A=
# Linux kernel version: 2.6.10=0A=
# Wed Sep 19 13:46:12 2007=0A=
#=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_GENERIC_HARDIRQS=3Dy=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
CONFIG_PPC=3Dy=0A=
CONFIG_PPC32=3Dy=0A=
CONFIG_GENERIC_NVRAM=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_BROKEN_ON_SMP=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_LOCALVERSION=3D"-pmppc440"=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_POSIX_MQUEUE=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
# CONFIG_AUDIT is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D14=0A=
# CONFIG_HOTPLUG is not set=0A=
CONFIG_KOBJECT_UEVENT=3Dy=0A=
CONFIG_IKCONFIG=3Dy=0A=
CONFIG_IKCONFIG_PROC=3Dy=0A=
CONFIG_EMBEDDED=3Dy=0A=
CONFIG_KALLSYMS=3Dy=0A=
# CONFIG_KALLSYMS_ALL is not set=0A=
# CONFIG_KALLSYMS_EXTRA_PASS is not set=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
CONFIG_SHMEM=3Dy=0A=
CONFIG_CC_ALIGN_FUNCTIONS=3D0=0A=
CONFIG_CC_ALIGN_LABELS=3D0=0A=
CONFIG_CC_ALIGN_LOOPS=3D0=0A=
CONFIG_CC_ALIGN_JUMPS=3D0=0A=
# CONFIG_TINY_SHMEM is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
# CONFIG_MODULE_SRCVERSION_ALL is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor=0A=
#=0A=
# CONFIG_6xx is not set=0A=
# CONFIG_40x is not set=0A=
CONFIG_44x=3Dy=0A=
# CONFIG_POWER3 is not set=0A=
# CONFIG_POWER4 is not set=0A=
# CONFIG_8xx is not set=0A=
# CONFIG_E500 is not set=0A=
CONFIG_BOOKE=3Dy=0A=
CONFIG_PTE_64BIT=3Dy=0A=
# CONFIG_MATH_EMULATION is not set=0A=
# CONFIG_CPU_FREQ is not set=0A=
CONFIG_4xx=3Dy=0A=
=0A=
#=0A=
# IBM 4xx options=0A=
#=0A=
# CONFIG_EBONY is not set=0A=
# CONFIG_OCOTEA is not set=0A=
CONFIG_PMPPC440=3Dy=0A=
CONFIG_440GP=3Dy=0A=
CONFIG_440=3Dy=0A=
CONFIG_IBM_OCP=3Dy=0A=
CONFIG_PPC4xx_DMA=3Dy=0A=
CONFIG_PPC4xx_EDMA=3Dy=0A=
CONFIG_PPC_GEN550=3Dy=0A=
# CONFIG_PM is not set=0A=
CONFIG_NOT_COHERENT_CACHE=3Dy=0A=
=0A=
#=0A=
# Platform options=0A=
#=0A=
CONFIG_PMC_BASEBOARD=3Dy=0A=
# CONFIG_K750I_SITE1 is not set=0A=
# CONFIG_K750I_SITE2 is not set=0A=
# CONFIG_K752I_SITE1 is not set=0A=
# CONFIG_K752I_SITE2 is not set=0A=
# CONFIG_CC1000_SITE1 is not set=0A=
CONFIG_CC1000_SITE2=3Dy=0A=
# CONFIG_KATANAQP_SITE1 is not set=0A=
# CONFIG_KATANAQP_SITE2 is not set=0A=
# CONFIG_KATANAQP_SITE3 is not set=0A=
# CONFIG_KATANAQP_SITE4 is not set=0A=
# CONFIG_PC_KEYBOARD is not set=0A=
# CONFIG_SMP is not set=0A=
# CONFIG_PREEMPT is not set=0A=
CONFIG_HIGHMEM=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
CONFIG_CMDLINE_BOOL=3Dy=0A=
CONFIG_CMDLINE=3D"ip=3Don"=0A=
=0A=
#=0A=
# Bus options=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
CONFIG_PCI_DOMAINS=3Dy=0A=
# CONFIG_PCI_LEGACY_PROC is not set=0A=
CONFIG_PCI_NAMES=3Dy=0A=
=0A=
#=0A=
# Advanced setup=0A=
#=0A=
CONFIG_ADVANCED_OPTIONS=3Dy=0A=
# CONFIG_HIGHMEM_START_BOOL is not set=0A=
CONFIG_HIGHMEM_START=3D0xfe000000=0A=
# CONFIG_LOWMEM_SIZE_BOOL is not set=0A=
CONFIG_LOWMEM_SIZE=3D0x30000000=0A=
# CONFIG_KERNEL_START_BOOL is not set=0A=
CONFIG_KERNEL_START=3D0xc0000000=0A=
# CONFIG_TASK_SIZE_BOOL is not set=0A=
CONFIG_TASK_SIZE=3D0x80000000=0A=
# CONFIG_CONSISTENT_START_BOOL is not set=0A=
CONFIG_CONSISTENT_START=3D0xff100000=0A=
# CONFIG_CONSISTENT_SIZE_BOOL is not set=0A=
CONFIG_CONSISTENT_SIZE=3D0x00200000=0A=
# CONFIG_BOOT_LOAD_BOOL is not set=0A=
CONFIG_BOOT_LOAD=3D0x01000000=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
# CONFIG_STANDALONE is not set=0A=
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy=0A=
# CONFIG_DEBUG_DRIVER is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
CONFIG_MTD=3Dy=0A=
# CONFIG_MTD_DEBUG is not set=0A=
CONFIG_MTD_PARTITIONS=3Dy=0A=
# CONFIG_MTD_CONCAT is not set=0A=
# CONFIG_MTD_REDBOOT_PARTS is not set=0A=
# CONFIG_MTD_CMDLINE_PARTS is not set=0A=
=0A=
#=0A=
# User Modules And Translation Layers=0A=
#=0A=
CONFIG_MTD_CHAR=3Dy=0A=
CONFIG_MTD_BLOCK=3Dy=0A=
# CONFIG_FTL is not set=0A=
# CONFIG_NFTL is not set=0A=
# CONFIG_INFTL is not set=0A=
=0A=
#=0A=
# RAM/ROM/Flash chip drivers=0A=
#=0A=
CONFIG_MTD_CFI=3Dy=0A=
# CONFIG_MTD_JEDECPROBE is not set=0A=
CONFIG_MTD_GEN_PROBE=3Dy=0A=
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy=0A=
CONFIG_MTD_CFI_NOSWAP=3Dy=0A=
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set=0A=
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set=0A=
CONFIG_MTD_CFI_GEOMETRY=3Dy=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set=0A=
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set=0A=
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set=0A=
CONFIG_MTD_CFI_I1=3Dy=0A=
CONFIG_MTD_CFI_I2=3Dy=0A=
# CONFIG_MTD_CFI_I4 is not set=0A=
# CONFIG_MTD_CFI_I8 is not set=0A=
CONFIG_MTD_CFI_INTELEXT=3Dy=0A=
# CONFIG_MTD_CFI_AMDSTD is not set=0A=
# CONFIG_MTD_CFI_STAA is not set=0A=
CONFIG_MTD_CFI_UTIL=3Dy=0A=
# CONFIG_MTD_RAM is not set=0A=
# CONFIG_MTD_ROM is not set=0A=
# CONFIG_MTD_ABSENT is not set=0A=
=0A=
#=0A=
# Mapping drivers for chip access=0A=
#=0A=
# CONFIG_MTD_COMPLEX_MAPPINGS is not set=0A=
# CONFIG_MTD_PHYSMAP is not set=0A=
CONFIG_MTD_PMPPC440=3Dy=0A=
=0A=
#=0A=
# Self-contained MTD device drivers=0A=
#=0A=
# CONFIG_MTD_PMC551 is not set=0A=
# CONFIG_MTD_SLRAM is not set=0A=
# CONFIG_MTD_PHRAM is not set=0A=
# CONFIG_MTD_MTDRAM is not set=0A=
# CONFIG_MTD_BLKMTD is not set=0A=
=0A=
#=0A=
# Disk-On-Chip Device Drivers=0A=
#=0A=
# CONFIG_MTD_DOC2000 is not set=0A=
# CONFIG_MTD_DOC2001 is not set=0A=
# CONFIG_MTD_DOC2001PLUS is not set=0A=
=0A=
#=0A=
# NAND Flash Device Drivers=0A=
#=0A=
# CONFIG_MTD_NAND is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
# CONFIG_BLK_DEV_CRYPTOLOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_SX8 is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_COUNT=3D16=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D8192=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
CONFIG_INITRAMFS_SOURCE=3D""=0A=
CONFIG_LBD=3Dy=0A=
# CONFIG_CDROM_PKTCDVD is not set=0A=
=0A=
#=0A=
# IO Schedulers=0A=
#=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
CONFIG_IOSCHED_CFQ=3Dy=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_IDE_SATA is not set=0A=
CONFIG_BLK_DEV_IDEDISK=3Dy=0A=
# CONFIG_IDEDISK_MULTI_MODE is not set=0A=
# CONFIG_BLK_DEV_IDECD is not set=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
# CONFIG_IDE_TASK_IOCTL is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
CONFIG_IDE_GENERIC=3Dy=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_BLK_DEV_GENERIC=3Dy=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_SL82C105 is not set=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
# CONFIG_IDEDMA_ONLYDISK is not set=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD74XX is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_TRIFLEX is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5520 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_SC1200 is not set=0A=
# CONFIG_BLK_DEV_PIIX is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_OLD is not set=0A=
# CONFIG_BLK_DEV_PDC202XX_NEW is not set=0A=
# CONFIG_BLK_DEV_SVWKS is not set=0A=
CONFIG_BLK_DEV_SIIMAGE=3Dy=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_ARM is not set=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Macintosh device drivers=0A=
#=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_UNIX=3Dy=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
# CONFIG_IP_PNP_DHCP is not set=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
# CONFIG_INET_TUNNEL is not set=0A=
CONFIG_IP_TCPDIAG=3Dy=0A=
# CONFIG_IP_TCPDIAG_IPV6 is not set=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
# CONFIG_IP_NF_CONNTRACK is not set=0A=
# CONFIG_IP_NF_CONNTRACK_MARK is not set=0A=
# CONFIG_IP_NF_QUEUE is not set=0A=
# CONFIG_IP_NF_IPTABLES is not set=0A=
# CONFIG_IP_NF_ARPTABLES is not set=0A=
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set=0A=
# CONFIG_IP_NF_COMPAT_IPFWADM is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
# CONFIG_NET_CLS_ROUTE is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
# CONFIG_HAMRADIO is not set=0A=
# CONFIG_IRDA is not set=0A=
# CONFIG_BT is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
# CONFIG_DUMMY is not set=0A=
CONFIG_BONDING=3Dm=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
# CONFIG_NET_ETHERNET is not set=0A=
CONFIG_IBM_EMAC=3Dy=0A=
# CONFIG_IBM_EMAC_ERRMSG is not set=0A=
CONFIG_IBM_EMAC_RXB=3D64=0A=
CONFIG_IBM_EMAC_TXB=3D8=0A=
CONFIG_IBM_EMAC_FGAP=3D8=0A=
CONFIG_IBM_EMAC_SKBRES=3D0=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
CONFIG_E1000=3Dy=0A=
# CONFIG_E1000_NAPI is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_S2IO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
# CONFIG_SERIO_I8042 is not set=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
# CONFIG_SERIO_RAW is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
# CONFIG_INPUT_KEYBOARD is not set=0A=
# CONFIG_INPUT_MOUSE is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
# CONFIG_INPUT_MISC is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dy=0A=
CONFIG_SERIAL_8250_CONSOLE=3Dy=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D4=0A=
CONFIG_SERIAL_8250_EXTENDED=3Dy=0A=
# CONFIG_SERIAL_8250_MANY_PORTS is not set=0A=
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy=0A=
# CONFIG_SERIAL_8250_DETECT_IRQ is not set=0A=
# CONFIG_SERIAL_8250_MULTIPORT is not set=0A=
# CONFIG_SERIAL_8250_RSA is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dy=0A=
CONFIG_SERIAL_CORE_CONSOLE=3Dy=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_LEGACY_PTYS=3Dy=0A=
CONFIG_LEGACY_PTY_COUNT=3D256=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_GEN_RTC=3Dy=0A=
# CONFIG_GEN_RTC_X is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
CONFIG_I2C=3Dy=0A=
CONFIG_I2C_CHARDEV=3Dy=0A=
=0A=
#=0A=
# I2C Algorithms=0A=
#=0A=
# CONFIG_I2C_ALGOBIT is not set=0A=
# CONFIG_I2C_ALGOPCF is not set=0A=
# CONFIG_I2C_ALGOPCA is not set=0A=
=0A=
#=0A=
# I2C Hardware Bus support=0A=
#=0A=
# CONFIG_I2C_ALI1535 is not set=0A=
# CONFIG_I2C_ALI1563 is not set=0A=
# CONFIG_I2C_ALI15X3 is not set=0A=
# CONFIG_I2C_AMD756 is not set=0A=
# CONFIG_I2C_AMD8111 is not set=0A=
# CONFIG_I2C_I801 is not set=0A=
# CONFIG_I2C_I810 is not set=0A=
CONFIG_I2C_IBM_IIC=3Dy=0A=
# CONFIG_I2C_ISA is not set=0A=
# CONFIG_I2C_NFORCE2 is not set=0A=
# CONFIG_I2C_PARPORT_LIGHT is not set=0A=
# CONFIG_I2C_PIIX4 is not set=0A=
# CONFIG_I2C_PROSAVAGE is not set=0A=
# CONFIG_I2C_SAVAGE4 is not set=0A=
# CONFIG_SCx200_ACB is not set=0A=
# CONFIG_I2C_SIS5595 is not set=0A=
# CONFIG_I2C_SIS630 is not set=0A=
# CONFIG_I2C_SIS96X is not set=0A=
# CONFIG_I2C_STUB is not set=0A=
# CONFIG_I2C_VIA is not set=0A=
# CONFIG_I2C_VIAPRO is not set=0A=
# CONFIG_I2C_VOODOO3 is not set=0A=
# CONFIG_I2C_PCA_ISA is not set=0A=
=0A=
#=0A=
# Hardware Sensors Chip support=0A=
#=0A=
# CONFIG_I2C_SENSOR is not set=0A=
# CONFIG_SENSORS_ADM1021 is not set=0A=
# CONFIG_SENSORS_ADM1025 is not set=0A=
# CONFIG_SENSORS_ADM1026 is not set=0A=
# CONFIG_SENSORS_ADM1031 is not set=0A=
# CONFIG_SENSORS_ASB100 is not set=0A=
# CONFIG_SENSORS_DS1621 is not set=0A=
# CONFIG_SENSORS_FSCHER is not set=0A=
# CONFIG_SENSORS_GL518SM is not set=0A=
# CONFIG_SENSORS_IT87 is not set=0A=
# CONFIG_SENSORS_LM63 is not set=0A=
# CONFIG_SENSORS_LM75 is not set=0A=
# CONFIG_SENSORS_LM77 is not set=0A=
# CONFIG_SENSORS_LM78 is not set=0A=
# CONFIG_SENSORS_LM80 is not set=0A=
# CONFIG_SENSORS_LM83 is not set=0A=
# CONFIG_SENSORS_LM85 is not set=0A=
# CONFIG_SENSORS_LM87 is not set=0A=
# CONFIG_SENSORS_LM90 is not set=0A=
# CONFIG_SENSORS_MAX1619 is not set=0A=
# CONFIG_SENSORS_PC87360 is not set=0A=
# CONFIG_SENSORS_SMSC47M1 is not set=0A=
# CONFIG_SENSORS_VIA686A is not set=0A=
# CONFIG_SENSORS_W83781D is not set=0A=
# CONFIG_SENSORS_W83L785TS is not set=0A=
# CONFIG_SENSORS_W83627HF is not set=0A=
CONFIG_SENSORS_M41T00=3Dy=0A=
=0A=
#=0A=
# Other I2C Chip support=0A=
#=0A=
# CONFIG_SENSORS_EEPROM is not set=0A=
# CONFIG_SENSORS_PCF8574 is not set=0A=
# CONFIG_SENSORS_PCF8591 is not set=0A=
# CONFIG_SENSORS_RTC8564 is not set=0A=
# CONFIG_I2C_DEBUG_CORE is not set=0A=
# CONFIG_I2C_DEBUG_ALGO is not set=0A=
# CONFIG_I2C_DEBUG_BUS is not set=0A=
# CONFIG_I2C_DEBUG_CHIP is not set=0A=
=0A=
#=0A=
# Dallas's 1-wire bus=0A=
#=0A=
# CONFIG_W1 is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
CONFIG_USB_ARCH_HAS_HCD=3Dy=0A=
CONFIG_USB_ARCH_HAS_OHCI=3Dy=0A=
=0A=
#=0A=
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be =
needed; see USB_STORAGE Help for more information=0A=
#=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# MMC/SD Card support=0A=
#=0A=
# CONFIG_MMC is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dy=0A=
CONFIG_EXT2_FS_XATTR=3Dy=0A=
# CONFIG_EXT2_FS_POSIX_ACL is not set=0A=
# CONFIG_EXT2_FS_SECURITY is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
# CONFIG_EXT3_FS_POSIX_ACL is not set=0A=
# CONFIG_EXT3_FS_SECURITY is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_XFS_FS is not set=0A=
CONFIG_MINIX_FS=3Dy=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_QUOTA is not set=0A=
CONFIG_DNOTIFY=3Dy=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
CONFIG_SYSFS=3Dy=0A=
CONFIG_DEVFS_FS=3Dy=0A=
CONFIG_DEVFS_MOUNT=3Dy=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
# CONFIG_TMPFS is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
CONFIG_JFFS2_FS=3Dy=0A=
CONFIG_JFFS2_FS_DEBUG=3D0=0A=
# CONFIG_JFFS2_FS_NAND is not set=0A=
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set=0A=
CONFIG_JFFS2_ZLIB=3Dy=0A=
CONFIG_JFFS2_RTIME=3Dy=0A=
# CONFIG_JFFS2_RUBIN is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dy=0A=
# CONFIG_NFS_V3 is not set=0A=
# CONFIG_NFS_V4 is not set=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
# CONFIG_NFSD is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
# CONFIG_EXPORTFS is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
# CONFIG_RPCSEC_GSS_KRB5 is not set=0A=
# CONFIG_RPCSEC_GSS_SPKM3 is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_CIFS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC_CCITT is not set=0A=
CONFIG_CRC32=3Dy=0A=
# CONFIG_LIBCRC32C is not set=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_SCHEDSTATS is not set=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set=0A=
# CONFIG_DEBUG_KOBJECT is not set=0A=
# CONFIG_DEBUG_HIGHMEM is not set=0A=
# CONFIG_DEBUG_INFO is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_XMON is not set=0A=
CONFIG_BDI_SWITCH=3Dy=0A=
# CONFIG_SERIAL_TEXT_DEBUG is not set=0A=
CONFIG_PPC_OCP=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_KEYS is not set=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set
------=_NextPart_000_001C_01C801DB.1D66EF90
Content-Type: text/plain;
	name="legacymode.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="legacymode.txt"

TFTP from server 10.10.2.24=0A=
our IP address is 10.10.14.5=0A=
Filename 'kernel-aspmppc440-linux-2.6.10'.=0A=
Load address: 0xc000000=0A=
Loading: =
#################################################################=0A=
         =
#################################################################=0A=
         =
#################################################################=0A=
         ####################################################=0A=
done=0A=
Bytes transferred =3D 1260746 (133cca hex)=0A=
## Booting image at 0c000000 ...=0A=
   Image Name:   Linux-2.6.10-pmppc440=0A=
   Created:      2007-09-18  19:28:50 UTC=0A=
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)=0A=
   Data Size:    1260682 Bytes =3D 1231 kB =3D 1 MB=0A=
   Load Address: 00000000=0A=
   Entry Point:  00000000=0A=
   Verifying Checksum ... OK=0A=
   Uncompressing Kernel Image ... OK=0A=
Linux version 2.6.10-pmppc440 (randy@fred) (gcc version 3.3.3 (DENX ELDK =
3.1 3.3=0A=
.3-8)) #2 Tue Sep 18 19:28:48 GMT 2007=0A=
Artesyn PmPPC440 Copyright 2006, Artesyn Communication Products, Inc.=0A=
Built 1 zonelists=0A=
Kernel command line: rw ip=3Don=0A=
PID hash table entries: 4096 (order: 12, 65536 bytes)=0A=
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)=0A=
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Memory: 516480k available (1844k kernel code, 648k data, 324k init, 0k =
highmem)=0A=
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=0A=
NET: Registered protocol family 16=0A=
PCI: Probing PCI hardware=0A=
PCI: Cannot allocate resource region 5 of device 0000:00:06.0=0A=
PCI: Failed to allocate mem resource #5:100@a0000000 for 0000:00:06.0=0A=
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)=0A=
devfs: boot_options: 0x1=0A=
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.=0A=
Generic RTC Driver v1.07=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled=0A=
ttyS0 at MMIO 0x0 (irq =3D 0) is a 16550A=0A=
ttyS1 at MMIO 0x0 (irq =3D 1) is a 16550A=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered=0A=
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize=0A=
loop: loaded (max 8 devices)=0A=
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2=0A=
Copyright (c) 1999-2004 Intel Corporation.=0A=
mal0: Initialized, 4 tx channels, 2 rx channels=0A=
emac: IBM EMAC Ethernet driver, version 2.0=0A=
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>=0A=
zmii0: input 0 in RMII mode=0A=
eth0: IBM emac, MAC 00:80:f9:69:0b:1f=0A=
eth0: Found Generic MII PHY (0x04)=0A=
zmii0: input 1 in RMII mode=0A=
eth1: IBM emac, MAC 00:80:f9:69:08:1f=0A=
eth1: Found Generic MII PHY (0x05)=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
SiI680: IDE controller at PCI slot 0000:00:06.0=0A=
SiI680: chipset revision 2=0A=
siimage: IDE controller MMIO ports not available.=0A=
SiI680: BASE CLOCK =3D=3D 100=0A=
SiI680: 100% native mode on irq 25=0A=
    ide0: BM-DMA at 0xffd0-0xffd7, BIOS settings: hda:pio, hdb:pio=0A=
    ide1: BM-DMA at 0xffd8-0xffdf, BIOS settings: hdc:pio, hdd:pio=0A=
hda: HTS424040M9AT00, ATA DISK drive=0A=
elevator: using anticipatory as default io scheduler=0A=
ide0 at 0xfff8-0xffff,0xfff6 on irq 25=0A=
eth0: Link is Up=0A=
eth0: Speed: 100, Full duplex.=0A=
hda: max request size: 64KiB=0A=
hda: 78140160 sectors (40007 MB) w/1739KiB Cache, CHS=3D16383/255/63, =
UDMA(100)=0A=
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3=0A=
PmPPC440 flash: Found 1 x16 devices at 0x0 in 16-bit bank=0A=
PmPPC440 flash: Found 1 x16 devices at 0x1000000 in 16-bit bank=0A=
PmPPC440 flash: Found 1 x16 devices at 0x2000000 in 16-bit bank=0A=
PmPPC440 flash: Found 1 x16 devices at 0x3000000 in 16-bit bank=0A=
 Intel/Sharp Extended Query Table at 0x0031=0A=
Using buffer write method=0A=
cfi_cmdset_0001: Erase suspend on write enabled=0A=
Creating 5 MTD partitions on "PmPPC440 flash":=0A=
0x00000000-0x01d80000 : "Primary Filesystem"=0A=
0x01d80000-0x02000000 : "Primary Kernel"=0A=
0x02000000-0x03d80000 : "Secondary Filesystem"=0A=
0x03d80000-0x03f00000 : "Secondary Kernel"=0A=
0x03f00000-0x04000000 : "U-Boot (Reserved)"=0A=
mice: PS/2 mouse device common for all mice=0A=
i2c /dev entries driver=0A=
IBM IIC driver v2.1=0A=
ibm-iic0: using standard (100 kHz) mode=0A=
ibm-iic1: using standard (100 kHz) mode=0A=
NET: Registered protocol family 2=0A=
IP: routing cache hash table of 4096 buckets, 32Kbytes=0A=
TCP: Hash tables configured (established 131072 bind 65536)=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
eth0: Link is Up=0A=
eth0: Speed: 100, Full duplex.=0A=
Sending BOOTP requests . OK=0A=
IP-Config: Got BOOTP answer from 10.10.2.24, my address is 10.10.14.5=0A=
IP-Config: Gateway not on directly connected network.=0A=
Looking up port of RPC 100003/2 on 10.10.2.24=0A=
Looking up port of RPC 100005/1 on 10.10.2.24=0A=
VFS: Mounted root (nfs filesystem).=0A=
Mounted devfs on /dev=0A=
Freeing unused kernel memory: 324k init=0A=
INIT: version 2.84 booting=0A=
                Welcome to DENX Embedded Linux Environment=0A=
                Press 'I' to enter interactive startup.=0A=
Building the cache [  OK  ]=0A=
Mounting proc filesystem:  [  OK  ]=0A=
Configuring kernel parameters:  [  OK  ]=0A=
Setting clock : Tue Sep 18 14:47:08 EDT 2007 [  OK  ]=0A=
Setting hostname gsr-fileserver5:  [  OK  ]=0A=
=0A=
Activating swap partitions:  [  OK  ]=0A=
Checking filesystems=0A=
[  OK  ]=0A=
Mounting local filesystems:  [  OK  ]=0A=
Enabling swap space:  [  OK  ]=0A=
=0A=
INIT: Entering runlevel: 3=0A=
Entering non-interactive startup=0A=
Setting network parameters:  [  OK  ]=0A=
Bringing up loopback interface:  [  OK  ]=0A=
Starting system logger: [  OK  ]=0A=
Starting kernel logger: [  OK  ]=0A=
Initializing random number generator:  [  OK  ]=0A=
Starting portmapper: [  OK  ]=0A=
Mounting NFS filesystems:  [  OK  ]=0A=
Mounting other filesystems:  [  OK  ]=0A=
Starting xinetd: [  OK  ]=0A=
=0A=
gsr-fileserver5 login: root=0A=
Last login: Mon Sep 17 20:37:51 on console=0A=
bash-2.05b# lspci -v=0A=
00:02.0 Class 0680: 3388:0021 (rev 04)=0A=
        Subsystem: 1223:003a=0A=
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 128, =
IRQ 25=0A=
        Memory at 80000000 (32-bit, prefetchable) [size=3D512M]=0A=
        Capabilities: [dc] Power Management version 4=0A=
        Capabilities: [e4] #06 [0094]=0A=
        Capabilities: [e8] Vital Product Data=0A=
=0A=
00:06.0 Class 0101: 1095:0680 (rev 02) (prog-if 85 [Master SecO PriO])=0A=
        Subsystem: 1095:0680=0A=
        Flags: bus master, medium devsel, latency 128, IRQ 25=0A=
        I/O ports at fff8 [size=3D8]=0A=
        I/O ports at fff4 [size=3D4]=0A=
        I/O ports at ffe8 [size=3D8]=0A=
        I/O ports at ffe4 [size=3D4]=0A=
        I/O ports at ffd0 [size=3D16]=0A=
        Memory at a0000000 (32-bit, non-prefetchable)=0A=
        Expansion ROM at a0080000 [disabled] [size=3D512K]=0A=
        Capabilities: [60] Power Management version 2=0A=
=0A=
bash-2.05b# mount /dev/ide/host0/bus0/target0/lun0/part3 x=0A=
bash-2.05b# ls x=0A=
bin  boot  etc  images  lib  lost+found  mnt  proc  root  sbin  tmp  usr =
 var=0A=
bash-2.05b# mount /dev/ide/host0/bus0/target0/lun0/part1 y=0A=
Oops: kernel access of bad area, sig: 11 [#1]=0A=
NIP: C0003804 LR: C00081B0 SP: DE8A3AF0 REGS: de8a3a40 TRAP: 0300    Not =
tainted=0A=
=0A=
MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00=0A=
DAR: E0000000, DSISR: 00800000=0A=
TASK =3D dfe9ae20[336] 'mount' THREAD: de8a2000=0A=
Last syscall: 21=0A=
PLB0: bear=3D 0x00000000 acr=3D   0x9b000000 besr=3D  0x00000000=0A=
=0A=
GPR00: C00082B4 DE8A3AF0 DFE9AE20 E0000000 07FFFFE0 0000001F 00000002 =
C02A0000=0A=
GPR08: 00000000 1FB44000 00000000 C02A0000 00000001 1002863C 1FFA8600 =
100C0000=0A=
GPR16: 00000000 00000000 100D0888 100C2A88 00000001 C02A0000 00029000 =
00000001=0A=
GPR24: 00000002 00000400 00000000 FFFFFC00 DE8A2000 DFB44800 C06BF880 =
FFFFFC00=0A=
NIP [c0003804] invalidate_dcache_range+0x1c/0x30=0A=
LR [c00081b0] __dma_sync+0x54/0x60=0A=
Call trace:=0A=
 [c00082b4] __dma_sync_page+0xf8/0x19c=0A=
 [c01467c0] ide_build_sglist+0xa8/0xf8=0A=
 [c0146840] ide_build_dmatable+0x30/0x1ac=0A=
 [c0146d64] ide_dma_setup+0x3c/0xc8=0A=
 [c0148ee4] __ide_do_rw_disk+0x2b8/0x598=0A=
 [c013e0f0] start_request+0x190/0x280=0A=
 [c013e438] ide_do_request+0x238/0x3d8=0A=
 [c011711c] __generic_unplug_device+0x68/0x6c=0A=
 [c011713c] generic_unplug_device+0x1c/0x38=0A=
 [c0117190] blk_backing_dev_unplug+0x38/0x3c=0A=
 [c0056a68] sync_buffer+0x64/0x68=0A=
 [c01ca8c4] __wait_on_bit+0xb0/0xc0=0A=
 [c01ca934] out_of_line_wait_on_bit+0x60/0x74=0A=
 [c0056b30] __wait_on_buffer+0x3c/0x40=0A=
 [c0058560] __bread_slow+0xac/0xd4=0A=
note: mount[336] exited with preempt_count 1=0A=
Oops: kernel access of bad area, sig: 11 [#2]=0A=
NIP: C007C7B4 LR: C007CB0C SP: DFDD5E80 REGS: dfdd5dd0 TRAP: 0300    Not =
tainted=0A=
=0A=
MSR: 00029000 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 00=0A=
DAR: 00000094, DSISR: 00000000=0A=
TASK =3D c07d0720[7] 'pdflush' THREAD: dfdd4000=0A=
Last syscall: -1=0A=
PLB0: bear=3D 0x00000000 acr=3D   0x9b000000 besr=3D  0x00000000=0A=
=0A=
GPR00: A0000000 DFDD5E80 C07D0720 DFFD2000 DFDD5F00 00000000 000001F4 =
00000BB8=0A=
GPR08: 00000004 20000000 00000400 00000004 00005B8A 00000000 1FFA8600 =
007FFF08=0A=
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 1FFA3428 00000000 C0250000 =
FFFC615D=0A=
GPR24: C02A0000 C02A0000 DFFD2074 DFFD207C DFDD5F00 C0250000 FFFFFFFC =
DFFD2000=0A=
NIP [c007c7b4] sync_sb_inodes+0x54/0x2a4=0A=
LR [c007cb0c] writeback_inodes+0x108/0x120=0A=
Call trace:=0A=
 [c007cb0c] writeback_inodes+0x108/0x120=0A=
 [c0038f48] wb_kupdate+0xe4/0x168=0A=
 [c0039c30] __pdflush+0x120/0x1e4=0A=
 [c0039d14] pdflush+0x20/0x30=0A=
 [c002bd44] kthread+0xb4/0xbc=0A=
 [c0003bec] kernel_thread+0x44/0x60=0A=
Segmentation fault=0A=
bash-2.05b#
------=_NextPart_000_001C_01C801DB.1D66EF90--
