Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83507.mail.sp1.yahoo.com (web83507.mail.sp1.yahoo.com
	[216.252.120.163]) by ozlabs.org (Postfix) with SMTP id 32769DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 05:32:13 +1100 (EST)
Message-ID: <736813.1073.qm@web83507.mail.sp1.yahoo.com>
Date: Thu, 26 Mar 2009 11:25:33 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Bootlog bug?
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: ron_madrid@sbcglobal.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have a little problem with my boot messages.  I'm not sure what this is, but does anyone have any ideas as to what it could be or what further information I could give to help track this down.  As of now this is not manifesting itself, but I don't know what it might do.

Using MPC831x RDB machine description
Linux version 2.6.27 (root@localhost.localdomain) (gcc version 4.2.2) #1 Fri Feb 6 15:06:45 PST 2009
console [udbg0] enabled
setup_arch: bootmem
mpc831x_rdb_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
PCI host bridge /sleep-nexus/pci@e0008500 (primary) ranges:
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
  IO 0x00000000e2000000..0x00000000e20fffff -> 0x0000000000000000
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/mtdblock2 rootfstype=jffs2 rw console=ttyS0,115200
IPIC (128 IRQ sources) at fdefa700
PID hash table entries: 512 (order: 9, 2048 bytes)
clocksource: timebase mult[7800001] shift[22] registered
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 125836k/131072k available (3684k kernel code, 5096k reserved, 128k data, 97k bss, 192k init)
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 66.56 BogoMIPS (lpj=133120)
Mount-cache hash table entries: 512
net_namespace: 288 bytes
NET: Registered protocol family 16

PCI: Probing PCI hardware
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:00.0: PME# disabled
bus: 00 index 0 io port: [0, fffff]
bus: 00 index 1 mmio: [90000000, 9fffffff]
bus: 00 index 2 mmio: [80000000, 8fffffff]
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
------------[ cut here ]------------
Badness at c00bdebc [verbose debug info unavailable]
NIP: c00bdebc LR: c00bdea4 CTR: 00000000
REGS: c7827d90 TRAP: 0700   Not tainted  (2.6.27)
MSR: 00029032 <EE,ME,IR,DR>  CR: 22022042  XER: 20000000
TASK = c7816400[1] 'swapper' THREAD: c7826000
GPR00: c00bdea4 c7827e40 c7816400 ffffffef c7800dcc c7800afc c7811540 00000000
GPR08: 000001e0 c03c0000 00000040 00000000 82044048 10101400 07ffb000 00000000
GPR16: 07ff0350 07ff59b4 00000000 00000000 00000000 c03ac84c c03ac820 c7857210
GPR24: 00000000 00000000 00000000 00000001 c7811540 fffffffe c78b4480 c7827e58
NIP [c00bdebc] sysfs_add_one+0x28/0x30
LR [c00bdea4] sysfs_add_one+0x10/0x30
Call Trace:
[c7827e40] [c00bdea4] sysfs_add_one+0x10/0x30 (unreliable)
[c7827e50] [c00bf12c] sysfs_do_create_link+0xac/0x15c
[c7827e80] [c01a09b4] bus_add_device+0xf4/0x190
[c7827ea0] [c019f1a0] device_add+0x38c/0x5c8
[c7827ef0] [c0225db4] of_device_register+0x24/0x34
[c7827f00] [c0009844] of_platform_device_create+0x44/0x74
[c7827f10] [c00098ec] of_platform_bus_create+0x78/0xc8
[c7827f30] [c0009a5c] of_platform_bus_probe+0x120/0x150
[c7827f50] [c037a3e4] __machine_initcall_mpc831x_rdb_declare_of_platform_devices+0x4c/0x60
[c7827f60] [c0003874] do_one_initcall+0x38/0x188
[c7827fd0] [c036917c] kernel_init+0x88/0xf4
[c7827ff0] [c0011b10] kernel_thread+0x44/0x60
Instruction dump:
912b0028 4bffffbc 9421fff0 7c0802a6 90010014 4bffff2d 2f83ffef 419e0014
80010014 38210010 7c0803a6 4e800020 <0fe00000> 4bffffec 9421ffe0 7c0802a6
JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
msgmni has been set to 246
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
brd: module loaded
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:95:01
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron NAND 256MiB 3,3V 8-bit)
nand_bbt: ECC error while reading bad block table
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Creating 3 MTD partitions on "e2800000.flash":
0x00000000-0x00200000 : "u-boot"
0x00200000-0x00800000 : "kernel"
0x00800000-0x04000000 : "fs"
eLBC NAND device at 0xe2800000, bank 0
usbmon: debugfs is not available
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
USB Universal Host Controller Interface driver v3.0
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
Empty flash at 0x004dbca8 ends at 0x004dc000
Empty flash at 0x01381ad8 ends at 0x01382000
Empty flash at 0x01383264 ends at 0x01383800
Empty flash at 0x015a9048 ends at 0x015a9800
Empty flash at 0x015aa990 ends at 0x015ab000
Empty flash at 0x015ba24c ends at 0x015ba800
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 192k init


Thanks for the help.

Ron
