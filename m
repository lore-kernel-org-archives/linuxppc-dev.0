Return-Path: <Dave.Glenton@amulethotkey.com>
Received: from c2beaomr10.btconnect.com (c2beaomr10.btconnect.com
	[213.123.26.188]) by ozlabs.org (Postfix) with ESMTP id C9702DDDA7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 04:39:55 +1100 (EST)
Received: from mail1.amulethotkey.com ([192.168.200.9])
	by mail-gw.amulethotkey.com with esmtp (Exim 4.69 (FreeBSD))
	(envelope-from <Dave.Glenton@amulethotkey.com>) id 1LXIyz-0004e9-LG
	for linuxppc-dev@ozlabs.org; Wed, 11 Feb 2009 17:34:45 +0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: initramfs boot issues with MPC8315
Date: Wed, 11 Feb 2009 17:34:43 -0000
Message-ID: <92711F48C3CF124AA6B539DC07F455DEA73E7E@mail1.amulethotkey.com>
From: "Dave Glenton" <Dave.Glenton@amulethotkey.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
=20
=20
I am having problems getting a NOR flash based PowerPC to boot. Up until
now I have been developing successfully using nfs and are now attempting
to boot the board from flash.
=20
I initially tried using a ramdisk and the resulting rootfs file system
is larger than the 4MB Flash space I have available.
=20
If I select initramfs as the target image I end up with a
initramfs.cpio.gz.uboot image of 1.4MB.
=20
However when I transfer the kernel, rootfs and dtb to flash and boot the
system the kernel fails to find init. (See boot log below) I have read
that initramfs dose not require boot args, is this correct?
=20
I have also tried booting with using bootm FE500000 - FE700000 with no
improvement
=20
Any suggestions gratefully received

Dave=20


BOOT LOG:=20

=20
U-Boot 1.3.0-rc2 (Feb 5 2009 - 14:24:11) MPC83XX

Reset Status:

CPU: e300c3, MPC8315E, Rev: 11 at 399.999 MHz, CSB: 133 MHz

Board: MPC8315ERDB

u-boot svn version 56

I2C: ready

DRAM: 128 MB

Now running in RAM - U-Boot at: 07fa8000

[DJG] PCIE0: 0x0 :No link

[DJG] PCIE1: 0x0 :No link

FLASH: 8 MB

NAND: No NAND device found!!!

0 MiB

In: serial

Out: serial

Err: serial

Net: eTSEC0

Hit any key to stop autoboot: 0

=3D>

=3D> bootm FE500000 FE100000 FE700000

## Booting image at fe500000 ...

Image Name: Linux-2.6.24.3-rt3_svn_70

Created: 2009-02-11 16:44:40 UTC

Image Type: PowerPC Linux Kernel Image (gzip compressed)

Data Size: 1037349 Bytes =3D 1013 kB

Load Address: 00000000

Entry Point: 00000000

Verifying Checksum ... OK

Uncompressing Kernel Image ... OK

## Loading RAMDisk Image at fe100000 ...

Image Name: uboot initramfs rootfs

Created: 2009-02-11 16:45:11 UTC

Image Type: PowerPC Linux RAMDisk Image (gzip compressed)

Data Size: 1441260 Bytes =3D 1.4 MB

Load Address: 00000000

Entry Point: 00000000

Verifying Checksum ... OK

Booting using the fdt at 0xfe700000

Loading Ramdisk to 07dc5000, end 07f24dec ... OK

Loading Device Tree to 007fc000, end 007fefff ... OK

Using MPC831x RDB machine description

Linux version 2.6.24.3-rt3drt2_svn_70 (daveg@eng-fedora) (gcc version
4.1.2) #76 Wed Feb 11 16:44:37 GMT 2009

Found initrd at 0xc7dc5000:0xc7f24dec

console [udbg0] enabled

setup_arch: bootmem

mpc831x_rdb_setup_arch()

Freescale SerDes at e00e3000 initialized

Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus
number: 0->0

Found MPC83xx PCI host bridge at 0x00000000e0009000. Firmware bus
number: 0->0

Found MPC83xx PCI host bridge at 0x00000000e000a000. Firmware bus
number: 0->0

arch: exit

Zone PFN ranges:

DMA 0 -> 32768

Normal 32768 -> 32768

Movable zone start PFN for each node

early_node_map[1] active PFN ranges

0: 0 -> 32768

Built 1 zonelists in Zone order, mobility grouping on. Total pages:
32512

Kernel command line:

IPIC (128 IRQ sources) at faef7700

PID hash table entries: 512 (order: 9, 2048 bytes)

clocksource: timebase mult[7800001] shift[22] registered

Console: colour dummy device 80x25

Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)

Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)

Memory: 126032k/131072k available (2040k kernel code, 4896k reserved,
132k data, 72k bss, 128k init)

Mount-cache hash table entries: 512

net_namespace: 76 bytes

NET: Registered protocol family 16

ptp-timer node not found

ptp-timer node not found

PCI: Probing PCI hardware

usbcore: registered new interface driver usbfs

usbcore: registered new interface driver hub

usbcore: registered new device driver usb

Time: timebase clocksource has been installed.

NET: Registered protocol family 2

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)

TCP established hash table entries: 4096 (order: 3, 32768 bytes)

TCP bind hash table entries: 4096 (order: 2, 16384 bytes)

TCP: Hash tables configured (established 4096 bind 4096)

TCP reno registered

Unpacking initramfs... done

Freeing initrd memory: 1407k freed

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled

serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 21) is a 16550A

console handover: boot [udbg0] -> real [ttyS0]

serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 22) is a 16550A

Gianfar MII Bus: probed

eth0: Gianfar Ethernet Controller Version 1.3-skbr, 00:17:10:10:00:b5

GFAR: SKB Handler initialized at CPU#0(max=3D32)

eth0: MTU =3D 1500 (frame size=3D1526, truesize=3D1792)

eth0: Running with NAPI enabled

eth0: 64/64 RX/TX BD ring size

eth1: Gianfar Ethernet Controller Version 1.3-skbr, 00:00:00:00:00:00

GFAR: SKB Handler initialized at CPU#0(max=3D32)

eth1: MTU =3D 1500 (frame size=3D1526, truesize=3D1792)

eth1: Running with NAPI enabled

eth1: 64/64 RX/TX BD ring size

of-flash fe000000.nor: Device tree uses obsolete "direct-mapped" flash
binding

fe000000.nor: Found 1 x16 devices at 0x0 in 16-bit bank

Amd/Fujitsu Extended Query Table at 0x0040

fe000000.nor: Swapping erase regions for broken CFI table.

number of CFI chips: 1

cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.

RedBoot partition parsing not available

of-flash fe000000.nor: Device tree uses obsolete partition map binding

Creating 4 MTD partitions on "fe000000.nor":

0x00000000-0x00100000 : "U-Boot"

0x00100000-0x00500000 : "FileSystem"

0x00500000-0x00700000 : "Kernel"

0x00700000-0x00800000 : "DTB"

mice: PS/2 mouse device common for all mice

i2c /dev entries driver

WDT driver for MPC83xx initialized. mode:reset timeout=3D65535 (32
seconds)

usbcore: registered new interface driver usbhid

drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver

TCP cubic registered

NET: Registered protocol family 1

NET: Registered protocol family 17

Freeing unused kernel memory: 128k init

Failed to execute /init

Kernel panic - not syncing: No init found. Try passing init=3D option to
kernel.

Call Trace:

[c7825ee0] [c00081b0] (unreliable)

[c7825f10] [c001cb10]

[c7825f60] [c0003940]

[c7825f70] [c01de278]

[c7825ff0] [c000fd38]

Rebooting in 180 seconds..
