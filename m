Return-Path: <Orges.Furxhi@thyssenkrupp.com>
Received: from mail002.triaton.com (mail002.triaton.com [149.250.222.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail002.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id F26DD67B5D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 08:37:21 +1000 (EST)
Received: from frasintmail2.it09.biz (frasintmail2.triaton.com [195.203.86.9])
	by mail002.triaton.com (8.13.6/8.13.6) with ESMTP id k5DM7IYO017403
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Jun 2006 00:07:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by frasintmail2.it09.biz (Postfix) with ESMTP id EF9711768
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 00:06:31 +0200 (CEST)
Received: from mdcexc05.na.ops.local (tkeweb07.thyssenkruppelevator.com
	[66.194.145.38])
	by frasintmail2.it09.biz (Postfix) with ESMTP id F0C261739
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 00:06:30 +0200 (CEST)
Message-ID: <162B449665D6D643AD9E1D50FC6F4B1403F16C35@mdcexc05.na.ops.local>
From: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
To: linuxppc-embedded@ozlabs.org
Subject: USB flashdrive on Motorola MPC5200 (IceCube) board, linux kernel
	2.4.20
Date: Tue, 13 Jun 2006 17:10:37 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C68F36.33393170"
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

------_=_NextPart_001_01C68F36.33393170
Content-Type: text/plain

Hi all,

 

I have been trying for days now to get my usb flashdrive to work on my
Motorola MPC5200 (IceCube) board running on the 2.4.20 linux kernel. I have
followed the instruction in this Flash Memory HOWTO  article
(http://www.tldp.org/HOWTO/Flash-Memory-HOWTO/index.html
<http://www.tldp.org/HOWTO/Flash-Memory-HOWTO/index.html> ), but I have had
no success.

When I mount the usbfs filesystem (mount -t usbfs none /proc/bus/usb/) the
following 3 items are  created in the /proc/bus/usb/ directory:

dr-xr-xr-x    1 root     root            0 Jan  1 00:12 001

-r--r--r--    1 root     root            0 Jan  1 00:12 devices

-r--r--r--    1 root     root            0 Jan  1 00:12 drivers

 

# cat devices shows:

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2

B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0

D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1

P:  Vendor=0000 ProdID=0000 Rev= 0.00

S:  Product=USB OHCI Root Hub

S:  SerialNumber=f0001000

C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA

I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub

E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

 

# cat drivers  shows

         usbdevfs

         hub

         usb-storage

 

In the this Flash Memory-HOWTO it is mentioned that the usb-storage-x
directory will be created in the /proc/scsi/ directory, but I do not see it
on my system. Also the contents of  /proc/scsi/scsi  are "Attached devices:
none". 

 

Following are my boot up messages:

 

U-Boot 1.1.4 (Mar 21 2006 - 15:07:57)

 

CPU:   MPC5200 v1.2 at 462 MHz

       Bus 132 MHz, IPB 66 MHz, PCI 33 MHz

Board: Motorola MPC5200 (IceCube)

I2C:   85 kHz, ready

DRAM:  64 MB

FLASH:  8 MB

In:    serial

Out:   serial

Err:   serial

Net:   FEC ETHERNET

 

Type "run flash_nfs" to mount root filesystem over NFS

 

Hit any key to stop autoboot:  0

## Booting image at ff900000 ...

   Image Name:   Linux-2.4.20_mvl31-lite5200

   Created:      2006-06-13  21:40:05 UTC

   Image Type:   PowerPC Linux Kernel Image (gzip compressed)

   Data Size:    989480 Bytes = 966.3 kB

   Load Address: 00000000

   Entry Point:  00000000

   Verifying Checksum ... OK

   Uncompressing Kernel Image ... OK

Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb

Linux version 2.4.20_mvl31-lite5200 (ofurxhi@mdc58503) (gcc version 3.3.1
(Monta

Vista 3.3.1-7.0.13.0500039 2005-01-12)) #11 Tue Jun 13 16:32:09 CDT 2006

On node 0 totalpages: 16384

zone(0): 16384 pages.

zone(1): 0 pages.

zone(2): 0 pages.

Kernel command line: root=/dev/mtdblock2 rw rootfstype=jffs2
ip=192.168.0.7:192.

168.0.2:192.168.0.2:255.255.255.0:cpua::off

frequencies: cpu=461995100, bus=131998608, ipb=65999304, pci=32999652

Calibrating delay loop... 307.20 BogoMIPS

Memory: 62460k available (1540k kernel code, 524k data, 240k init, 0k
highmem)

Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)

Inode cache hash table entries: 4096 (order: 3, 32768 bytes)

Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)

Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)

Page-cache hash table entries: 16384 (order: 4, 65536 bytes)

POSIX conformance testing by UNIFIX

PCI: Probing PCI hardware

PCI: Cannot allocate resource region 1 of device 00:00.0

PCI: Cannot allocate resource region 1 of device 00:01.0

PCI: Cannot allocate resource region 1 of device 00:02.0

PCI: Cannot allocate resource region 1 of device 00:03.0

PCI: Cannot allocate resource region 1 of device 00:04.0

PCI: Cannot allocate resource region 1 of device 00:05.0

PCI: Cannot allocate resource region 1 of device 00:06.0

PCI: Cannot allocate resource region 1 of device 00:07.0

PCI: Cannot allocate resource region 1 of device 00:08.0

PCI: Cannot allocate resource region 1 of device 00:09.0

PCI: Cannot allocate resource region 1 of device 00:0a.0

PCI: Cannot allocate resource region 1 of device 00:0b.0

PCI: Cannot allocate resource region 1 of device 00:0c.0

PCI: Cannot allocate resource region 1 of device 00:0d.0

PCI: Cannot allocate resource region 1 of device 00:0e.0

PCI: Cannot allocate resource region 1 of device 00:0f.0

PCI: Cannot allocate resource region 1 of device 00:10.0

PCI: Cannot allocate resource region 1 of device 00:11.0

PCI: Cannot allocate resource region 1 of device 00:12.0

PCI: Cannot allocate resource region 1 of device 00:13.0

PCI: Cannot allocate resource region 1 of device 00:14.0

PCI: Cannot allocate resource region 1 of device 00:15.0

PCI: Cannot allocate resource region 1 of device 00:16.0

PCI: Cannot allocate resource region 1 of device 00:17.0

PCI: Cannot allocate resource region 1 of device 00:18.0

PCI: Cannot allocate resource region 1 of device 00:19.0

PCI: Cannot allocate resource region 1 of device 00:1a.0

PCI: Cannot allocate resource region 1 of device 00:1b.0

PCI: Cannot allocate resource region 1 of device 00:1c.0

PCI: Cannot allocate resource region 1 of device 00:1d.0

PCI: Cannot allocate resource region 1 of device 00:1e.0

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

LSP Revision 52

ikconfig 0.5 with /proc/ikconfig

Starting kswapd

Disabling the Out Of Memory Killer

Journalled Block Device driver loaded

devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x1

JFFS version 1.0, (C) 1999, 2000  Axis Communications AB

JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., designed by Axis
Communications

 AB.

pty: 256 Unix98 ptys configured

RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize

loop: loaded (max 8 devices)

Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky

SCSI subsystem driver Revision: 1.00

kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2

kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2

NO QRY response

cfi_cmdset_0001: Erase suspend on write enabled

Using buffer write method

Icecube flash bank 0: Using static image partition definition

Creating 3 MTD partitions on "Icecube Bank 0":

0x00000000-0x00100000 : "u-boot"

0x00100000-0x00200000 : "kernel"

0x00200000-0x00800000 : "jffs2"

usb.c: registered new driver usbdevfs

usb.c: registered new driver hub

usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ 44

usb.c: new USB bus registered, assigned bus number 1

Product: USB OHCI Root Hub

SerialNumber: f0001000

hub.c: USB hub found

hub.c: 2 ports detected

Initializing USB Mass Storage driver...

usb.c: registered new driver usb-storage

USB Mass Storage support registered.

eth0: Phy @ 0x0, type LXT971 (0x001378e2)

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 512 buckets, 4Kbytes

TCP: Hash tables configured (established 4096 bind 8192)

eth0: config: auto-negotiation off, 100HDX, 10HDX.

IP-Config: Complete:

      device=eth0, addr=192.168.0.7, mask=255.255.255.0, gw=192.168.0.2,

     host=cpua, domain=, nis-domain=(none),

     bootserver=192.168.0.2, rootserver=192.168.0.2, rootpath=

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

Empty flash at 0x0000fffc ends at 0x00010000

CLEANMARKER node found at 0x00010000, not first node in block (0x00000000)

Empty flash at 0x0002fffc ends at 0x00030000

CLEANMARKER node found at 0x00030000, not first node in block (0x00020000)

Empty flash at 0x0004fffc ends at 0x00050000

CLEANMARKER node found at 0x00050000, not first node in block (0x00040000)

Empty flash at 0x0006fffc ends at 0x00070000

CLEANMARKER node found at 0x00070000, not first node in block (0x00060000)

Empty flash at 0x0008fffc ends at 0x00090000

CLEANMARKER node found at 0x00090000, not first node in block (0x00080000)

Empty flash at 0x000afffc ends at 0x000b0000

CLEANMARKER node found at 0x000b0000, not first node in block (0x000a0000)

Empty flash at 0x000cfffc ends at 0x000d0000

CLEANMARKER node found at 0x000d0000, not first node in block (0x000c0000)

Empty flash at 0x000efffc ends at 0x000f0000

CLEANMARKER node found at 0x000f0000, not first node in block (0x000e0000)

Empty flash at 0x0010fffc ends at 0x00110000

CLEANMARKER node found at 0x00110000, not first node in block (0x00100000)

Empty flash at 0x0012fffc ends at 0x00130000

CLEANMARKER node found at 0x00130000, not first node in block (0x00120000)

Empty flash at 0x0014fffc ends at 0x00150000

CLEANMARKER node found at 0x00150000, not first node in block (0x00140000)

Empty flash at 0x0016fffc ends at 0x00170000

CLEANMARKER node found at 0x00170000, not first node in block (0x00160000)

Empty flash at 0x0018fffc ends at 0x00190000

CLEANMARKER node found at 0x00190000, not first node in block (0x00180000)

Empty flash at 0x001afffc ends at 0x001b0000

CLEANMARKER node found at 0x001b0000, not first node in block (0x001a0000)

Empty flash at 0x001cfffc ends at 0x001d0000

CLEANMARKER node found at 0x001d0000, not first node in block (0x001c0000)

Empty flash at 0x001efffc ends at 0x001f0000

CLEANMARKER node found at 0x001f0000, not first node in block (0x001e0000)

Empty flash at 0x0020fffc ends at 0x00210000

CLEANMARKER node found at 0x00210000, not first node in block (0x00200000)

Empty flash at 0x0022fffc ends at 0x00230000

CLEANMARKER node found at 0x00230000, not first node in block (0x00220000)

Empty flash at 0x0024fffc ends at 0x00250000

CLEANMARKER node found at 0x00250000, not first node in block (0x00240000)

Empty flash at 0x0026fffc ends at 0x00270000

CLEANMARKER node found at 0x00270000, not first node in block (0x00260000)

VFS: Mounted root (jffs2 filesystem).

Mounted devfs on /dev

Freeing unused kernel memory: 240k init

serial console detected.  Disabling virtual terminals.

init started:  BusyBox v0.60.3 (2004.01.09-22:53+0000) multi-call binary

Initializing iocspi

Warning: loading /lib/modules/iocspim.o will taint the kernel: no license

  See http://www.tux.org/lkml/#export-tainted for information about tainted
modu

les

iocspi: release_20060418

iocspi: major 254.

Module iocspim loaded, with warnings

Initializing canspi

Warning: loading /lib/modules/canspim.o will taint the kernel: no license

  See http://www.tux.org/lkml/#export-tainted for information about tainted
modu

les

canspi: init_module()

canspi: init_module(): sema_init

canspi: init_module(): register_chrdev

canspi: major 253.

canspi: micro_config()

canspi: micro_config: PSC request_irq failed (0)

canspi: micro_config psc=f0002400 cdm=f0000200 gpio=f0000b00
portcfg=10051004

Module canspim loaded, with warnings

Initializing iocdrv

Warning: loading /lib/modules/iocdrvm.o will taint the kernel: no license

  See http://www.tux.org/lkml/#export-tainted for information about tainted
modu

les

iocdrv: release_20060502

iocdrv: major 252.

Module iocdrvm loaded, with warnings

System initialized

 

MontaVista(R) Linux(R) Professional Edition 3.1

 

cpua login: 

 

 

Any help would be highly appreciated.

 

Thank you,

 

Orges Furxhi 


------_=_NextPart_001_01C68F36.33393170
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
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
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have been trying for days now to get my usb =
flashdrive to
work on my Motorola MPC5200 (IceCube) board running on the 2.4.20 linux =
kernel.
I have followed the instruction in this Flash Memory HOWTO =
&nbsp;article (</span></font><a
href=3D"http://www.tldp.org/HOWTO/Flash-Memory-HOWTO/index.html"
title=3D"http://www.tldp.org/HOWTO/Flash-Memory-HOWTO/index.html">http:/=
/www.tldp.org/HOWTO/Flash-Memory-HOWTO/index.html</a><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>), but I
have had no success.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When I mount the usbfs filesystem (mount &#8211;t =
usbfs none
/proc/bus/usb/) the following 3 items are &nbsp;created in the =
/proc/bus/usb/
directory:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>dr-xr-xr-x&nbsp;&nbsp;&nbsp; 1 =
root&nbsp;&nbsp;&nbsp;&nbsp;
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0
Jan&nbsp; 1 00:12 001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-r--r--r--&nbsp;&nbsp;&nbsp; 1 =
root&nbsp;&nbsp;&nbsp;&nbsp;
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0
Jan&nbsp; 1 00:12 devices<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-r--r--r--&nbsp;&nbsp;&nbsp; 1 =
root&nbsp;&nbsp;&nbsp;&nbsp;
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0
Jan&nbsp; 1 00:12 drivers<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'># cat devices shows:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>T:&nbsp; Bus=3D01 Lev=3D00 =
Prnt=3D00
Port=3D00 Cnt=3D00 Dev#=3D&nbsp; 1 Spd=3D12&nbsp; MxCh=3D =
2<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>B:&nbsp; Alloc=3D&nbsp; =
0/900 us (
0%), #Int=3D&nbsp; 0, #Iso=3D&nbsp; 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>D:&nbsp; Ver=3D 1.10 =
Cls=3D09(hub&nbsp;
) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D&nbsp; =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>P:&nbsp; Vendor=3D0000 =
ProdID=3D0000
Rev=3D 0.00<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>S:&nbsp; Product=3DUSB =
OHCI Root Hub<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>S:&nbsp; =
SerialNumber=3Df0001000<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>C:* #Ifs=3D 1 Cfg#=3D 1 =
Atr=3D40
MxPwr=3D&nbsp; 0mA<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I:&nbsp; If#=3D 0 Alt=3D 0 =
#EPs=3D 1
Cls=3D09(hub&nbsp; ) Sub=3D00 Prot=3D00 =
Driver=3Dhub<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>E:&nbsp; Ad=3D81(I) =
Atr=3D03(Int.)
MxPS=3D&nbsp;&nbsp; 2 Ivl=3D255ms<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'># cat drivers&nbsp; =
shows<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
usbdevfs<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hub<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
usb-storage<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In the this Flash Memory-HOWTO it is mentioned that =
the
usb-storage-x directory will be created in the /proc/scsi/ directory, =
but I do
not see it on my system. Also the contents of &nbsp;/proc/scsi/scsi =
&nbsp;are &#8220;Attached
devices: none&#8221;. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Following are my boot up =
messages:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>U-Boot 1.1.4 (Mar 21 2006 - =
15:07:57)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU:&nbsp;&nbsp; MPC5200 v1.2 at 462 =
MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bus 132 MHz, =
IPB 66
MHz, PCI 33 MHz<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Board: Motorola MPC5200 =
(IceCube)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I2C:&nbsp;&nbsp; 85 kHz, =
ready<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>DRAM:&nbsp; 64 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>FLASH:&nbsp; 8 MB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In:&nbsp;&nbsp;&nbsp; =
serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Out:&nbsp;&nbsp; serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Err:&nbsp;&nbsp; serial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Net:&nbsp;&nbsp; FEC =
ETHERNET<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Type &quot;run flash_nfs&quot; to mount root =
filesystem over
NFS<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hit any key to stop autoboot:&nbsp; =
0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>## Booting image at ff900000 =
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Image Name:&nbsp;&nbsp;
Linux-2.4.20_mvl31-lite5200<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2006-06-13&nbsp; 21:40:05 UTC<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux =
Kernel
Image (gzip compressed)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 989480 =
Bytes =3D
966.3 kB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Load Address: =
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Entry Point:&nbsp; =
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Verifying Checksum ... =
OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; Uncompressing Kernel Image ... =
OK<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Memory BAT mapping: BAT2=3D64Mb, BAT3=3D0Mb, =
residual: 0Mb<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Linux version 2.4.20_mvl31-lite5200 =
(ofurxhi@mdc58503) (gcc
version 3.3.1 (Monta<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><font size=3D2 =
face=3DArial><span
 style=3D'font-size:10.0pt;font-family:Arial'>Vista</span></font></st1:p=
lace><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>
3.3.1-7.0.13.0500039 2005-01-12)) #11 Tue Jun 13 16:32:09 CDT =
2006<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>On node 0 totalpages: =
16384<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>zone(0): 16384 pages.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>zone(1): 0 pages.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>zone(2): 0 pages.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kernel command line: root=3D/dev/mtdblock2 rw =
rootfstype=3Djffs2
ip=3D192.168.0.7:192.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>168.0.2:192.168.0.2:255.255.255.0:cpua::off<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>frequencies: cpu=3D461995100, bus=3D131998608, =
ipb=3D65999304,
pci=3D32999652<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Calibrating delay loop... 307.20 =
BogoMIPS<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Memory: 62460k available (1540k kernel code, 524k =
data, 240k
init, 0k highmem)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dentry cache hash table entries: 8192 (order: 4, =
65536
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Inode cache hash table entries: 4096 (order: 3, =
32768 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mount-cache hash table entries: 1024 (order: 1, 8192 =
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Buffer-cache hash table entries: 4096 (order: 2, =
16384
bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Page-cache hash table entries: 16384 (order: 4, =
65536 bytes)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>POSIX conformance testing by =
UNIFIX<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Probing PCI =
hardware<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:00.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:01.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:02.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:03.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:04.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:05.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:06.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:07.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:08.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:09.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:0a.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:0b.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:0c.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:0d.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:0e.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:0f.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:10.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:11.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:12.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:13.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:14.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:15.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:16.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:17.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:18.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:19.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:1a.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:1b.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:1c.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:1d.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PCI: Cannot allocate resource region 1 of device =
00:1e.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Linux NET4.0 for Linux =
2.4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Based upon <st1:place w:st=3D"on"><st1:PlaceName =
w:st=3D"on">Swansea</st1:PlaceName>
 <st1:PlaceType w:st=3D"on">University</st1:PlaceType></st1:place> =
Computer
Society NET3.039<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Initializing RT netlink =
socket<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>LSP Revision 52<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ikconfig 0.5 with =
/proc/ikconfig<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Starting kswapd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Disabling the Out Of Memory =
Killer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Journalled Block Device driver =
loaded<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>devfs: v1.12c (20020818) Richard Gooch
(rgooch@atnf.csiro.au)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>devfs: boot_options: =
0x1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>JFFS version 1.0, (C) 1999, 2000&nbsp; Axis =
Communications
AB<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>JFFS2 version 2.1. (C) 2001, 2002 Red Hat, Inc., =
designed by
Axis Communications<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;AB.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>pty: 256 Unix98 ptys =
configured<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>RAMDISK driver initialized: 16 RAM disks of 8192K =
size 1024
blocksize<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>loop: loaded (max 8 =
devices)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Universal TUN/TAP device driver 1.5 (C)1999-2002 =
Maxim
Krasnyansky<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SCSI subsystem driver Revision: =
1.00<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>kmod: failed to exec /sbin/modprobe -s -k =
scsi_hostadapter,
errno =3D 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>kmod: failed to exec /sbin/modprobe -s -k =
scsi_hostadapter,
errno =3D 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NO QRY response<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>cfi_cmdset_0001: Erase suspend on write =
enabled<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Using buffer write =
method<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Icecube flash bank 0: Using static image partition
definition<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Creating 3 MTD partitions on &quot;Icecube Bank =
0&quot;:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0x00000000-0x00100000 : =
&quot;u-boot&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0x00100000-0x00200000 : =
&quot;kernel&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0x00200000-0x00800000 : =
&quot;jffs2&quot;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb.c: registered new driver =
usbdevfs<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb.c: registered new driver =
hub<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb-ohci.c: USB OHCI at membase 0xf0001000, IRQ =
44<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb.c: new USB bus registered, assigned bus number =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Product: USB OHCI Root =
Hub<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SerialNumber: f0001000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>hub.c: USB hub found<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>hub.c: 2 ports detected<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Initializing USB Mass Storage =
driver...<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>usb.c: registered new driver =
usb-storage<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>USB Mass Storage support =
registered.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>eth0: Phy @ 0x0, type LXT971 =
(0x001378e2)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET4: Linux TCP/IP 1.0 for =
NET4.0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IP Protocols: ICMP, UDP, TCP, =
IGMP<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IP: routing cache hash table of 512 buckets, =
4Kbytes<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>TCP: Hash tables configured (established 4096 bind =
8192)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>eth0: config: auto-negotiation off, 100HDX, =
10HDX.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>IP-Config: Complete:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0,
addr=3D192.168.0.7, mask=3D255.255.255.0, =
gw=3D192.168.0.2,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; host=3Dcpua, domain=3D,
nis-domain=3D(none),<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp; bootserver=3D192.168.0.2,
rootserver=3D192.168.0.2, rootpath=3D<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>NET4: Unix domain sockets 1.0/SMP for Linux =
NET4.0.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0000fffc ends at =
0x00010000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00010000, not first node =
in
block (0x00000000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0002fffc ends at =
0x00030000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00030000, not first node =
in
block (0x00020000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0004fffc ends at =
0x00050000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00050000, not first node =
in
block (0x00040000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0006fffc ends at =
0x00070000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00070000, not first node =
in
block (0x00060000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0008fffc ends at =
0x00090000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00090000, not first node =
in
block (0x00080000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x000afffc ends at =
0x000b0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x000b0000, not first node =
in
block (0x000a0000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x000cfffc ends at =
0x000d0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x000d0000, not first node =
in
block (0x000c0000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x000efffc ends at =
0x000f0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x000f0000, not first node =
in
block (0x000e0000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0010fffc ends at =
0x00110000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00110000, not first node =
in
block (0x00100000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0012fffc ends at =
0x00130000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00130000, not first node =
in
block (0x00120000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0014fffc ends at =
0x00150000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00150000, not first node =
in
block (0x00140000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0016fffc ends at =
0x00170000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00170000, not first node =
in block
(0x00160000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0018fffc ends at =
0x00190000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00190000, not first node =
in
block (0x00180000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x001afffc ends at =
0x001b0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x001b0000, not first node =
in
block (0x001a0000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x001cfffc ends at =
0x001d0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x001d0000, not first node =
in
block (0x001c0000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x001efffc ends at =
0x001f0000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x001f0000, not first node =
in
block (0x001e0000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0020fffc ends at =
0x00210000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00210000, not first node =
in
block (0x00200000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0022fffc ends at =
0x00230000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00230000, not first node =
in
block (0x00220000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0024fffc ends at =
0x00250000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00250000, not first node =
in
block (0x00240000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Empty flash at 0x0026fffc ends at =
0x00270000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CLEANMARKER node found at 0x00270000, not first node =
in
block (0x00260000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>VFS: Mounted root (jffs2 =
filesystem).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Mounted devfs on /dev<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Freeing unused kernel memory: 240k =
init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>serial console detected.&nbsp; Disabling virtual =
terminals.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>init started:&nbsp; BusyBox v0.60.3 =
(2004.01.09-22:53+0000)
multi-call binary<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Initializing iocspi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Warning: loading /lib/modules/iocspim.o will taint =
the
kernel: no license<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; See http://www.tux.org/lkml/#export-tainted =
for
information about tainted modu<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>les<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>iocspi: =
release_20060418<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>iocspi: major 254.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Module iocspim loaded, with =
warnings<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Initializing canspi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Warning: loading /lib/modules/canspim.o will taint =
the
kernel: no license<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; See http://www.tux.org/lkml/#export-tainted =
for
information about tainted modu<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>les<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>canspi: init_module()<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>canspi: init_module(): =
sema_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>canspi: init_module(): =
register_chrdev<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>canspi: major 253.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>canspi: micro_config()<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>canspi: micro_config: PSC request_irq failed =
(0)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>canspi: micro_config psc=3Df0002400 cdm=3Df0000200 =
gpio=3Df0000b00
portcfg=3D10051004<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Module canspim loaded, with =
warnings<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Initializing iocdrv<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Warning: loading /lib/modules/iocdrvm.o will taint =
the
kernel: no license<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp; See http://www.tux.org/lkml/#export-tainted =
for
information about tainted modu<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>les<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>iocdrv: =
release_20060502<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>iocdrv: major 252.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Module iocdrvm loaded, with =
warnings<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>System initialized<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>MontaVista(R) Linux(R) Professional Edition =
3.1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>cpua login: <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any help would be highly =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thank you,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Orges Furxhi <o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C68F36.33393170--
