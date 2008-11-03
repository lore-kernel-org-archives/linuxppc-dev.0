Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id C46F2DDF79
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 03:39:20 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Kx2SS-0003fz-Mb
	for linuxppc-embedded@ozlabs.org; Mon, 03 Nov 2008 08:39:16 -0800
Message-ID: <20306038.post@talk.nabble.com>
Date: Mon, 3 Nov 2008 08:39:16 -0800 (PST)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: linux 2.6 boot failure with rfs installed in the flash disk (xupv2p
	+ ppc)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

After booting successfully the kernel with the ramdisk, I tried to boot the
kernel with a root file system installed on the third partition of the flas=
h
disk.=20
Partition 1: Type =3D FAT16, Size =3D 32Mbyte
Partition 2 : Type =3D Linux Swap, Size =3D 256Mbyte
partition 3: Type=3DLinux, Size =3D 950 Mbyte

I installed the filesystem (using BusyBox 1.12.1, and the script mkrootfs.s=
h
written by Wofgang Klingauf), and I configured the kernel to support xsysac=
e
driver.

I changed bootargs to "console=3DttyUL0,9600 root=3D/dev/xsa3 rw"; /* it wa=
s
console=3DttyS0, root=3D/dev/ram rw*/

I rebooted the kernel, it stops after "Warning: unable to open an initial
console."

The output of the console is as follows:

***************************************************************************=
**************
zImage starting: loaded at 0x00400000 (sp: 0x0059eefc)
Allocating 0x377124 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x0059d133)...done 0x3545e8 bytes

Linux/PowerPC load: console=3DttyUL0,9600 root=3D/dev/xsa3 rw
Finalizing device tree... flat tree at 0x40ae18
Using Xilinx Virtex machine description
Linux version 2.6.27-rc9 (dhouib@lo-lester-030) (gcc version 3.4.5) #29
PREEMPT Mon Nov 3 16:23:09 CET 2008
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=3DttyUL0,9600 root=3D/dev/xsa3 rw
Xilinx intc at 0x41200000 mapped to 0xfdfff000
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[d55555] shift[22] registered
Console: colour dummy device 80x25
console [ttyUL0] enabled
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256000k/262144k available (3256k kernel code, 5832k reserved, 128k
data, 136k bss, 160k init)
Calibrating delay loop... 598.01 BogoMIPS (lpj=3D1196032)
Mount-cache hash table entries: 512
net_namespace: 756 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 500
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
40600000.serial: ttyUL0 at MMIO 0x40600003 (irq =3D 16) is a uartlite
brd: module loaded
loop: module loaded
xsysace 41800000.sysace: Xilinx SystemACE revision 1.0.12
xsysace 41800000.sysace: capacity: 3940272 sectors
 xsa: xsa1 xsa2 xsa3
Xilinx SystemACE device driver, major=3D254
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 160k init
Warning: unable to open an initial console.
=20

*******************************************************************

I made a search in the net and I have found in (
http://rm-rfroot.net/files/courses/xupv2p/docs/carithers/report.pdf) that:
If we do not include the option to automatically mount the =E2=80=98/dev=E2=
=80=99 file
system, the init process will not be able to open a terminal since =E2=80=
=98console=E2=80=99
is listed in =E2=80=98/dev=E2=80=99 as a device.=20

But there was no option in the kernel config that enable /dev Automatically
mount at boot.

=20

My questions are:

1. can i configure the kernel to automatically mount /dev at boot?

2. how can I configure correctly the ram size (the default options
virtex4_defconfig are: CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D8192). But I have an SDRAM of 256 Megabytes size.

=20

Thanks=20

Saadia

--=20
View this message in context: http://www.nabble.com/linux-2.6-boot-failure-=
with-rfs-installed-in-the-flash-disk-%28xupv2p-%2B-ppc%29-tp20306038p203060=
38.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
