Return-Path: <bhuang2@uncc.edu>
Received: from uncc.edu (ironhost1.uncc.edu [152.15.42.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ironhost1.uncc.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BB853DE098
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Mar 2008 10:57:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8912D.5F9319E0"
Subject: Linux 2.6 PCI Device Driver on Virtex 4
Date: Fri, 28 Mar 2008 19:42:24 -0400
Message-ID: <61B0EE7C247C1349881F63414448FC1F920E6F@EXEVS06.its.uncc.edu>
From: "Huang, Bin" <bhuang2@uncc.edu>
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

------_=_NextPart_001_01C8912D.5F9319E0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

I have spent the past few months slowly trying to get a PCI design
with Linux 2.6 on the Virtex 4. I have been able to overcome some of
the hurdles; however, I am still unable to boot up a working system.

I am using PPC.I have implemented Xilinx's board support  package =
including
xparameter head file, ml410 early boot files, pci support files,
Board initialization file, did board specific setup, and fixed some
bugs in its call tree.

I have attached my booting message in this mail.  As you can see, I am
stuck at "[   11.805382] Freeing unused kernel memory: 100k init" . =
Usually
it's the last step before the kernel starts root file system. I am sure =
my ramdisk and
root file system were both working OK. My naive thought is that the =
kernel could not
register serial port successfully (see time stamp [ 5.965954]). As a =
result, ttyS0 was
not able to run and display messages after starting ramdisk.=20

It's also interesting to see my ml410 board respond me with a "ml300"
id. My booting message was saying:
         pci_scan: bus 0, device  8, id 030010ee
"10ee" is the vendor id for xilinx while "0300" is the device id which
I think might represent ml300. Does Xilinx forget to refresh its rom?=20


Here is my environment and tools:
-- Xilinx ML410 Rev C
-- Xilinx EDK 9.2i
-- Secret lab Linux v2.6 originally configured as platform Xilinx
ML403

And my booting message:
-------------------------------------------------------------------------=
--
Xilinx ML410 Board-Specific Initialization:

ppb_init: dev =3D  9, id =3D ac23104c
pci_scan: bus 0, device  1, id 545110b9
pci_scan: bus 0, device  2, id 153310b9
pci_scan: bus 0, device  3, id 545710b9
pci_scan: bus 0, device  8, id 030010ee
pci_scan: bus 0, device  9, id ac23104c
pci_scan: bus 0, device 12, id 710110b9
pci_scan: bus 0, device 15, id 523710b9
sio_init: Device ID =3D 53 15, Revision =3D f3.
sio_init: LPT1 base =3D 0x0378, irq =3D 5.
sio_init: COM1 base =3D 0x03f8, irq =3D 4.
sio_init: COM2 base =3D 0x02f8, irq =3D 3.
sio_init: KBC irq =3D 1, PS2 irq =3D 1.
sio_init: Super I/O initialization complete.

loaded at:     00400000 006C21B4
board data at: 006C0124 006C01A0
relocated to:  00405154 004051D0
zimage at:     00406215 004EFDAA
initrd at:     004F0000 006BFDB0
avail ram:     006C3000 08000000

Linux/PPC load: console=3DttyS0,9600 ip=3Doff root=3D/dev/ram
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.23-rc2-g0d62d8a8-dirty (bhuang2@rsass-
homer.uncc.edu) (gcc version 4.2.1) #190 Thu Mar 28
[    0.000000] Xilinx ML40x Reference System (Virtex-4 FX)
[    0.000000] Port by MontaVista Software, Inc. (sou...@mvista.com)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    32768
[    0.000000]   Normal      32768 ->    32768
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    32768
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 32512
[    0.000000] Kernel command line: console=3DttyS0,9600 ip=3Doff =
root=3D/
dev/ram
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xE7FED000
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000175] Console: colour dummy device 80x25
[    0.000241] console [ttyS0] enabled
[    1.382947] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[    1.466045] Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
[    1.572643] Memory: 125852k available (1480k kernel code, 496k
data, 100k init, 0k highmem)
[    1.764350] Mount-cache hash table entries: 512
[    1.827727] PCI: Probing PCI hardware
[    1.906477] ppc405_map_irq: bus 0 idsel 1 pin 1, res =3D 31
[    1.970528] ppc405_map_irq: bus 0 idsel 2 pin 1, res =3D 31
[    2.035157] ppc405_map_irq: bus 0 idsel 3 pin 1, res =3D 31
[    2.099646] ppc405_map_irq: bus 0 idsel 8 pin 1, res =3D 31
[    2.164225] ppc405_map_irq: bus 0 idsel 9 pin 1, res =3D 31
[    2.228787] ppc405_map_irq: bus 0 idsel 11 pin 1, res =3D 31
[    2.294400] ppc405_map_irq: bus 0 idsel 12 pin 1, res =3D 31
[    2.360031] ppc405_map_irq: bus 0 idsel 15 pin 1, res =3D 31
[    2.441645] SCSI subsystem initialized
[    2.487503] usbcore: registered new interface driver usbfs
[    2.553907] usbcore: registered new interface driver hub
[    2.617790] usbcore: registered new device driver usb
[    2.687574] checking if image is initramfs...it isn't (no cpio
magic); looks like an initrd
[    4.548936] Freeing initrd memory: 1855k freed
[    4.606889] io scheduler noop registered
[    4.653232] io scheduler anticipatory registered (default)
[    4.718790] io scheduler deadline registered
[    4.769907] io scheduler cfq registered
[    4.815634] Activating ISA DMA hang workarounds.
[    5.667502] 0000:00:0f.0 OHCI: BIOS handoff failed (BIOS bug ?)
ffffffff
[    5.798505] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports,
IRQ sharing disabled
[    5.892194] serial8250: ttyS0 at MMIO 0x0 (irq =3D 12) is a 16550A
[    5.965954] Couldn't register serial port 0000:00:03.0: -28
[    6.044910] RAMDISK driver initialized: 16 RAM disks of 65536K size
1024 blocksize
[    6.141529] loop: module loaded
[    6.178422] Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
[    6.254522] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=3Dxx
[    6.351314] ALI15X3: IDE controller at PCI slot 0000:00:0b.0
[    6.418510] ALI15X3: chipset revision 196
[    6.466414] ALI15X3: 100% native mode on irq 31
[    6.520489] ALI15X3: simplex device: DMA forced
[    6.574602]     ide0: BM-DMA at 0xdfd0-0xdfd7, BIOS settings:
hda:DMA, hdb:DMA
[    6.660918] ALI15X3: simplex device: DMA forced
[    6.715201]     ide1: BM-DMA at 0xdfd8-0xdfdf, BIOS settings:
hdc:DMA, hdd:DMA
[    9.054991] usbmon: debugfs is not available
[    9.106161] mice: PS/2 mouse device common for all mice
[    9.168819] ali15x3_smbus 0000:00:0c.0: ALI15X3_smb region
uninitialized - upgrade BIOS or use force_addr=3D0xaddr
[    9.290327] ali15x3_smbus 0000:00:0c.0: ALI15X3 not detected,
module not inserted.
[    9.383605] RAMDISK: Compressed image found at block 0
[   11.704980] VFS: Mounted root (ext2 filesystem) readonly.
[   11.805382] Freeing unused kernel memory: 100k init
................kernel stops here................

-------------------------------------------------------------------------=
--


If anyone has tried to do this (or has already done this) I would
apprecaite any help or suggestions.=20

regards,

Bin=20

------_=_NextPart_001_01C8912D.5F9319E0
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Linux 2.6 PCI Device Driver on Virtex 4</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I have spent the past few months slowly trying to get =
a PCI design<BR>
with Linux 2.6 on the Virtex 4. I have been able to overcome some of<BR>
the hurdles; however, I am still unable to boot up a working system.<BR>
<BR>
I am using PPC.I have implemented Xilinx's board support&nbsp; package =
including<BR>
xparameter head file, ml410 early boot files, pci support files,<BR>
Board initialization file, did board specific setup, and fixed some<BR>
bugs in its call tree.<BR>
<BR>
I have attached my booting message in this mail.&nbsp; As you can see, I =
am<BR>
stuck at &quot;[&nbsp;&nbsp; 11.805382] Freeing unused kernel memory: =
100k init&quot; . Usually<BR>
it's the last step before the kernel starts root file system. I am sure =
my ramdisk and<BR>
root file system were both working OK. My naive thought is that the =
kernel could not<BR>
register serial port successfully (see time stamp [ 5.965954]). As a =
result, ttyS0 was<BR>
not able to run and display messages after starting ramdisk.<BR>
<BR>
It's also interesting to see my ml410 board respond me with a =
&quot;ml300&quot;<BR>
id. My booting message was saying:<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_scan: bus 0, =
device&nbsp; 8, id 030010ee<BR>
&quot;10ee&quot; is the vendor id for xilinx while &quot;0300&quot; is =
the device id which<BR>
I think might represent ml300. Does Xilinx forget to refresh its =
rom?<BR>
<BR>
<BR>
Here is my environment and tools:<BR>
-- Xilinx ML410 Rev C<BR>
-- Xilinx EDK 9.2i<BR>
-- Secret lab Linux v2.6 originally configured as platform Xilinx<BR>
ML403<BR>
<BR>
And my booting message:<BR>
-------------------------------------------------------------------------=
--<BR>
Xilinx ML410 Board-Specific Initialization:<BR>
<BR>
ppb_init: dev =3D&nbsp; 9, id =3D ac23104c<BR>
pci_scan: bus 0, device&nbsp; 1, id 545110b9<BR>
pci_scan: bus 0, device&nbsp; 2, id 153310b9<BR>
pci_scan: bus 0, device&nbsp; 3, id 545710b9<BR>
pci_scan: bus 0, device&nbsp; 8, id 030010ee<BR>
pci_scan: bus 0, device&nbsp; 9, id ac23104c<BR>
pci_scan: bus 0, device 12, id 710110b9<BR>
pci_scan: bus 0, device 15, id 523710b9<BR>
sio_init: Device ID =3D 53 15, Revision =3D f3.<BR>
sio_init: LPT1 base =3D 0x0378, irq =3D 5.<BR>
sio_init: COM1 base =3D 0x03f8, irq =3D 4.<BR>
sio_init: COM2 base =3D 0x02f8, irq =3D 3.<BR>
sio_init: KBC irq =3D 1, PS2 irq =3D 1.<BR>
sio_init: Super I/O initialization complete.<BR>
<BR>
loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 006C21B4<BR>
board data at: 006C0124 006C01A0<BR>
relocated to:&nbsp; 00405154 004051D0<BR>
zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00406215 004EFDAA<BR>
initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 004F0000 006BFDB0<BR>
avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 006C3000 08000000<BR>
<BR>
Linux/PPC load: console=3DttyS0,9600 ip=3Doff root=3D/dev/ram<BR>
Uncompressing Linux...done.<BR>
Now booting the kernel<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.23-rc2-g0d62d8a8-dirty =
(bhuang2@rsass-<BR>
homer.uncc.edu) (gcc version 4.2.1) #190 Thu Mar 28<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx ML40x Reference System (Virtex-4 =
FX)<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Port by MontaVista Software, Inc. =
(sou...@mvista.com)<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; =
DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0 -&gt;&nbsp;&nbsp;&nbsp; 32768<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; =
Normal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32768 -&gt;&nbsp;&nbsp;&nbsp; =
32768<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Movable zone start PFN for each node<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[1] active PFN ranges<BR>
[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; =
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; =
32768<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists in Zone order.&nbsp; =
Total pages: 32512<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=3DttyS0,9600 =
ip=3Doff root=3D/<BR>
dev/ram<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] Xilinx INTC #0 at 0x41200000 mapped to =
0xE7FED000<BR>
[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 512 (order: 9, =
2048 bytes)<BR>
[&nbsp;&nbsp;&nbsp; 0.000175] Console: colour dummy device 80x25<BR>
[&nbsp;&nbsp;&nbsp; 0.000241] console [ttyS0] enabled<BR>
[&nbsp;&nbsp;&nbsp; 1.382947] Dentry cache hash table entries: 16384 =
(order: 4, 65536<BR>
bytes)<BR>
[&nbsp;&nbsp;&nbsp; 1.466045] Inode-cache hash table entries: 8192 =
(order: 3, 32768<BR>
bytes)<BR>
[&nbsp;&nbsp;&nbsp; 1.572643] Memory: 125852k available (1480k kernel =
code, 496k<BR>
data, 100k init, 0k highmem)<BR>
[&nbsp;&nbsp;&nbsp; 1.764350] Mount-cache hash table entries: 512<BR>
[&nbsp;&nbsp;&nbsp; 1.827727] PCI: Probing PCI hardware<BR>
[&nbsp;&nbsp;&nbsp; 1.906477] ppc405_map_irq: bus 0 idsel 1 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 1.970528] ppc405_map_irq: bus 0 idsel 2 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 2.035157] ppc405_map_irq: bus 0 idsel 3 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 2.099646] ppc405_map_irq: bus 0 idsel 8 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 2.164225] ppc405_map_irq: bus 0 idsel 9 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 2.228787] ppc405_map_irq: bus 0 idsel 11 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 2.294400] ppc405_map_irq: bus 0 idsel 12 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 2.360031] ppc405_map_irq: bus 0 idsel 15 pin 1, res =
=3D 31<BR>
[&nbsp;&nbsp;&nbsp; 2.441645] SCSI subsystem initialized<BR>
[&nbsp;&nbsp;&nbsp; 2.487503] usbcore: registered new interface driver =
usbfs<BR>
[&nbsp;&nbsp;&nbsp; 2.553907] usbcore: registered new interface driver =
hub<BR>
[&nbsp;&nbsp;&nbsp; 2.617790] usbcore: registered new device driver =
usb<BR>
[&nbsp;&nbsp;&nbsp; 2.687574] checking if image is initramfs...it isn't =
(no cpio<BR>
magic); looks like an initrd<BR>
[&nbsp;&nbsp;&nbsp; 4.548936] Freeing initrd memory: 1855k freed<BR>
[&nbsp;&nbsp;&nbsp; 4.606889] io scheduler noop registered<BR>
[&nbsp;&nbsp;&nbsp; 4.653232] io scheduler anticipatory registered =
(default)<BR>
[&nbsp;&nbsp;&nbsp; 4.718790] io scheduler deadline registered<BR>
[&nbsp;&nbsp;&nbsp; 4.769907] io scheduler cfq registered<BR>
[&nbsp;&nbsp;&nbsp; 4.815634] Activating ISA DMA hang workarounds.<BR>
[&nbsp;&nbsp;&nbsp; 5.667502] 0000:00:0f.0 OHCI: BIOS handoff failed =
(BIOS bug ?)<BR>
ffffffff<BR>
[&nbsp;&nbsp;&nbsp; 5.798505] Serial: 8250/16550 driver $Revision: 1.90 =
$ 1 ports,<BR>
IRQ sharing disabled<BR>
[&nbsp;&nbsp;&nbsp; 5.892194] serial8250: ttyS0 at MMIO 0x0 (irq =3D 12) =
is a 16550A<BR>
[&nbsp;&nbsp;&nbsp; 5.965954] Couldn't register serial port =
0000:00:03.0: -28<BR>
[&nbsp;&nbsp;&nbsp; 6.044910] RAMDISK driver initialized: 16 RAM disks =
of 65536K size<BR>
1024 blocksize<BR>
[&nbsp;&nbsp;&nbsp; 6.141529] loop: module loaded<BR>
[&nbsp;&nbsp;&nbsp; 6.178422] Uniform Multi-Platform E-IDE driver =
Revision:<BR>
7.00alpha2<BR>
[&nbsp;&nbsp;&nbsp; 6.254522] ide: Assuming 33MHz system bus speed for =
PIO modes;<BR>
override with idebus=3Dxx<BR>
[&nbsp;&nbsp;&nbsp; 6.351314] ALI15X3: IDE controller at PCI slot =
0000:00:0b.0<BR>
[&nbsp;&nbsp;&nbsp; 6.418510] ALI15X3: chipset revision 196<BR>
[&nbsp;&nbsp;&nbsp; 6.466414] ALI15X3: 100% native mode on irq 31<BR>
[&nbsp;&nbsp;&nbsp; 6.520489] ALI15X3: simplex device: DMA forced<BR>
[&nbsp;&nbsp;&nbsp; 6.574602]&nbsp;&nbsp;&nbsp;&nbsp; ide0: BM-DMA at =
0xdfd0-0xdfd7, BIOS settings:<BR>
hda:DMA, hdb:DMA<BR>
[&nbsp;&nbsp;&nbsp; 6.660918] ALI15X3: simplex device: DMA forced<BR>
[&nbsp;&nbsp;&nbsp; 6.715201]&nbsp;&nbsp;&nbsp;&nbsp; ide1: BM-DMA at =
0xdfd8-0xdfdf, BIOS settings:<BR>
hdc:DMA, hdd:DMA<BR>
[&nbsp;&nbsp;&nbsp; 9.054991] usbmon: debugfs is not available<BR>
[&nbsp;&nbsp;&nbsp; 9.106161] mice: PS/2 mouse device common for all =
mice<BR>
[&nbsp;&nbsp;&nbsp; 9.168819] ali15x3_smbus 0000:00:0c.0: ALI15X3_smb =
region<BR>
uninitialized - upgrade BIOS or use force_addr=3D0xaddr<BR>
[&nbsp;&nbsp;&nbsp; 9.290327] ali15x3_smbus 0000:00:0c.0: ALI15X3 not =
detected,<BR>
module not inserted.<BR>
[&nbsp;&nbsp;&nbsp; 9.383605] RAMDISK: Compressed image found at block =
0<BR>
[&nbsp;&nbsp; 11.704980] VFS: Mounted root (ext2 filesystem) =
readonly.<BR>
[&nbsp;&nbsp; 11.805382] Freeing unused kernel memory: 100k init<BR>
................kernel stops here................<BR>
<BR>
-------------------------------------------------------------------------=
--<BR>
<BR>
<BR>
If anyone has tried to do this (or has already done this) I would<BR>
apprecaite any help or suggestions.<BR>
<BR>
regards,<BR>
<BR>
Bin </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8912D.5F9319E0--
