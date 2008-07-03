Return-Path: <sanandkumar@hcl.in>
Received: from gws04.hcl.in (chn-hclin-gws02.hcl.in [203.105.186.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gws04.hcl.in",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C57D9DDF60
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 20:12:41 +1000 (EST)
Received: from gws04.hcl.in (gws04 [10.249.64.135])
	by localhost.hcl.in (Postfix) with ESMTP id 70B1D360029
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 15:42:23 +0530 (IST)
Received: from chn-egw02-out.corp.hcl.in (unknown [10.249.64.38])by
	gws04.hcl.in (Postfix) with ESMTP id 2CAB936001Cfor
	<linuxppc-embedded@ozlabs.org>; Thu,  3 Jul 2008 15:42:23 +0530 (IST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DCF5.4896DC8A"
Subject: Linux on ML403 serial console problem
Date: Thu, 3 Jul 2008 15:42:21 +0530
Message-ID: <66E8AEE9980BB44CA5FCAD39EBA56AC604A5F1DF@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
From: "Anand Kumar S" <sanandkumar@hcl.in>
To: <linuxppc-embedded@ozlabs.org.>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8DCF5.4896DC8A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


Hi,

=20

I am using MVL 4=2E0=2E1 to boot on ML403 board=2E I have created the
xparameters=2Eh file using EDK 10=2E1 and I was able to boot the kernel=
 with
32 MB of memory and UART set as std 16550 uart=2E

Since this board came without sysace flash card I am using ramdisk
technique to boot linux=2E I created a small ramdisk with my test program
which sleeps for 10 seconds and prints a hello

world using printf=2E I modified kernel init/main=2Ec to execute /bin/test
(my test program) from the RAMDISK=2E I created the ramdisk and appended
with zImage using make zImage=2Einitrd command

=20

I used dow method from xmd to download the zImage=2Einitrd=2Eelf on the
board and I was able to boot the board till the point of executing my
/bin/test=2E However I see that the print statements

from my test program are not coming on the serial port=2E I see that the
printf calls tty_io write and it goes to uart_write routine in
serial_core=2Ec, however I am not able to see my prints on

the hyperterminal=2E I can see all the kernel printks except for this
printf statement from my user program=2E Also all the kernel printks seem
to call serial_8250_console write routine but the

user application seems to call the uart_write routine=2E Does someone have
any idea about what might be going wrong here? Is it something to do
with serial console settings ?

=20

Any help is greatly appreciated as I am really struggling with this
problem for the past 3 days=2E Given below is the output from serial port=
=2E
I do not have FB support or VT or VT console

Support enabled=2E Only SERIAL console support is enabled i=2Ee
SERIAL_CORE_CONSOLE/SERIAL_8250_CONSOLE support is enabled

=20

=2E=2E=2E=2E=2E=2E

=2E=2E=2E=2E=2E=2E

Serial: 8250/16550 driver $Revision: 1=2E90 $ 5 ports, IRQ sharing
disabled

Registering platform device 'serial8250'=2E Parent at platform

ttyS0 at MMIO 0x0 (irq =3D 9) is a 16550A

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

PPP generic driver version 2=2E4=2E2

PPP Deflate Compression module registered

NET: Registered protocol family 24

xemac 0: using fifo mode=2E

eth0: Xilinx EMAC #0 at 81000000 mapped to 0xC30C0000, irq=3D0

i2c /dev entries driver

xilinx_iic=2E0 #0 at 0x81600000 mapped to 0xC30E0000, irq=3D6

mice: PS/2 mouse device common for all mice

NET: Registered protocol family 2

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 2048 bind 4096)

NET: Registered protocol family 1

NET: Registered protocol family 17

interrupts enabled=20

TX interrupts enabled=2E register baseaddr c30c0000 offset 7fc is 8=20

TX interrupts enabled=2E register baseaddr c30c0000 offset ffc is 0=20

RX interrupts enabled=2E register baseaddr c30c0000 offset 17fc is 9=20

RX interrupts enabled=2E register baseaddr c30c0000 offset 1ffc is 0=20

GIER interrupts enabled=2E register baseaddr c30c0000 offset 7f8 is
80000000=20

Sending DHCP requests =2E,=2E=2E=2E OK

IP-Config: Got DHCP answer from 0=2E0=2E0=2E0, my address is 10=2E100=2E12=
=2E132

IP-Config: Complete:

      device=3Deth0, addr=3D10=2E100=2E12=2E132, mask=3D255=2E255=2E255=
=2E0,
gw=3D10=2E100=2E12=2E1,

     host=3D10=2E100=2E12=2E132, domain=3Dhclt=2Ecorp=2Ehcl=2Ein,=
 nis-domain=3D(none),

     bootserver=3D0=2E0=2E0=2E0, rootserver=3D0=2E0=2E0=2E0, rootpath=3D

RAMDISK: Compressed image found at block 0

VFS: Mounted root (ext2 filesystem)=2E

Freeing unused kernel memory: 124k init

done freeing memory=2E creating console=20

console created=20

running process /bin/test=20

in tty_write

before calling write=2E buf contents h e l

core write

core write

core write

Kernel panic - not syncing: Attempted to kill init!

 <0>Rebooting in 180 seconds=2E=2E<NULL>

=20



DISCLAIMER:
---------------------------------------------------------------------------=
--------------------------------------------

The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in=20
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of=20
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have=20
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and=20
attachments please check them for viruses and defect=2E

---------------------------------------------------------------------------=
--------------------------------------------
------_=_NextPart_001_01C8DCF5.4896DC8A
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=
=3D"urn:schemas-microsoft-com:office:word" xmlns=3D"http://www=2Ew3=
=2Eorg/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p=2EMsoNormal, li=2EMsoNormal, div=2EMsoNormal
	{margin:0in;
	margin-bottom:=2E0001pt;
	font-size:12=2E0pt;
	font-family:"Times New Roman";}
a:link, span=2EMsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span=2EMsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span=2EEmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8=2E5in 11=2E0in;
	margin:1=2E0in 1=2E25in 1=2E0in 1=2E25in;}
div=2ESection1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>I am using MVL 4=2E0=2E1 to boot on ML403 board=2E I=
 have created
the xparameters=2Eh file using EDK 10=2E1 and I was able to boot the kernel=
 with 32
MB of memory and UART set as std 16550 uart=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Since this board came without sysace flash card I am=
 using
ramdisk technique to boot linux=2E I created a small ramdisk with my test=
 program
which sleeps for 10 seconds and prints a hello<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>world using printf=2E I modified kernel init/main=2Ec to=
 execute
/bin/test (my test program) from the RAMDISK=2E I created the ramdisk and=
 appended
with zImage using make zImage=2Einitrd command<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>I used dow method from xmd to download the zImage=
=2Einitrd=2Eelf
on the board and I was able to boot the board till the point of executing=
 my
/bin/test=2E However I see that the print=
 statements<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>from my test program are not coming on the serial port=
=2E I
see that the printf calls tty_io write and it goes to uart_write routine in
serial_core=2Ec, however I am not able to see my prints=
 on<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>the hyperterminal=2E I can see all the kernel printks=
 except
for this printf statement from my user program=2E Also all the kernel=
 printks
seem to call serial_8250_console write routine but=
 the<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>user application seems to call the uart_write routine=2E=
 Does
someone have any idea about what might be going wrong here? Is it something=
 to
do with serial console settings ?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Any help is greatly appreciated as I am really=
 struggling
with this problem for the past 3 days=2E Given below is the output from=
 serial
port=2E I do not have FB support or VT or VT=
 console<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>Support enabled=2E Only SERIAL console support is=
 enabled i=2Ee
SERIAL_CORE_CONSOLE/SERIAL_8250_CONSOLE support is=
 enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>&#8230;=2E=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=
=3D'font-size:10=2E0pt;
font-family:Arial'>&#8230;=2E=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>Serial: 8250/16550 driver=
 $Revision:
1=2E90 $ 5 ports, IRQ sharing disabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>Registering platform device
'serial8250'=2E Parent at platform<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>ttyS0 at MMIO 0x0 (irq =3D=
 9) is a
16550A<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>io scheduler noop=
 registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>io scheduler anticipatory=
 registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>io scheduler deadline=
 registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>io scheduler cfq=
 registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>RAMDISK driver initialized:=
 16 RAM
disks of 8192K size 1024 blocksize<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>loop: loaded (max 8=
 devices)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>PPP generic driver version 2=
=2E4=2E2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>PPP Deflate Compression=
 module
registered<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>NET: Registered protocol=
 family 24<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>xemac 0: using fifo mode=
=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>eth0: Xilinx EMAC #0 at=
 81000000
mapped to 0xC30C0000, irq=3D0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>i2c /dev entries=
 driver<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>xilinx_iic=2E0 #0 at=
 0x81600000 mapped
to 0xC30E0000, irq=3D6<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>mice: PS/2 mouse device=
 common for
all mice<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>NET: Registered protocol=
 family 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>IP: routing cache hash table=
 of 512
buckets, 4Kbytes<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>TCP: Hash tables configured
(established 2048 bind 4096)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>NET: Registered protocol=
 family 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>NET: Registered protocol=
 family 17<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>interrupts enabled=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>TX interrupts enabled=2E=
 register
baseaddr c30c0000 offset 7fc is 8 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>TX interrupts enabled=2E=
 register
baseaddr c30c0000 offset ffc is 0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>RX interrupts enabled=2E=
 register
baseaddr c30c0000 offset 17fc is 9 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>RX interrupts enabled=2E=
 register
baseaddr c30c0000 offset 1ffc is 0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>GIER interrupts enabled=2E=
 register
baseaddr c30c0000 offset 7f8 is 80000000 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>Sending DHCP requests =2E,=
=2E=2E=2E OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>IP-Config: Got DHCP answer=
 from
0=2E0=2E0=2E0, my address is 10=2E100=2E12=
=2E132<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>IP-Config:=
 Complete:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=
=2E0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
device=3Deth0, addr=3D10=2E100=2E12=2E132, mask=3D255=2E255=2E255=2E0, gw=
=3D10=2E100=2E12=2E1,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;
host=3D10=2E100=2E12=2E132, domain=3Dhclt=2Ecorp=2Ehcl=2Ein, nis-domain=
=3D(none),<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;
bootserver=3D0=2E0=2E0=2E0, rootserver=3D0=2E0=2E0=2E0, rootpath=
=3D<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>RAMDISK: Compressed image=
 found at
block 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>VFS: Mounted root (ext2=
 filesystem)=2E<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>Freeing unused kernel=
 memory: 124k
init<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>done freeing memory=2E=
 creating
console <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>console created=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>running process /bin/test=
 <o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>in=
 tty_write<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>before calling write=2E buf=
 contents h
e l<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>core=
 write<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>core=
 write<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>core=
 write<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>Kernel panic - not syncing:
Attempted to kill init!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=2E0pt;font-family:Arial'>&nbsp;&lt;0&gt;Rebooting in=
 180
seconds=2E=2E&lt;NULL&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=
=3DArial><span
style=3D'font-size:10=
=2E0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>DISCLAIMER:<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
<br>
The contents of this e-mail and any attachment(s) are confidential and=
 intended for the named recipient(s) only=2E<br>
It shall not attach any liability on the originator or HCL or its=
 affiliates=2E Any views or opinions presented in <br>
this email are solely those of the author and may not necessarily reflect=
 the opinions of HCL or its affiliates=2E<br>
Any form of reproduction, dissemination, copying, disclosure, modification,=
 distribution and / or publication of <br>
this message without the prior written consent of the author of this e-mail=
 is strictly prohibited=2E If you have <br>
received this email in error please delete it and notify the sender=
 immediately=2E Before opening any mail and <br>
attachments please check them for viruses and defect=2E<br>
<br>
---------------------------------------------------------------------------=
--------------------------------------------<br>
</font></td></tr></table>
------_=_NextPart_001_01C8DCF5.4896DC8A--
