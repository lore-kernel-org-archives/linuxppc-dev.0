Return-Path: <mike.dyer@provision-comm.com>
Received: from smtp1.betherenow.co.uk (smtp1.betherenow.co.uk [87.194.0.68])
	by ozlabs.org (Postfix) with SMTP id ACB8DDDE24
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Oct 2008 01:12:33 +1100 (EST)
Message-ID: <48F4A8CD.6000101@provision-comm.com>
Date: Tue, 14 Oct 2008 15:12:29 +0100
From: Mike Dyer <mike.dyer@provision-comm.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8313E RDB: Badness at fs/sysfs/dir.c:463
References: <48F49D7D.5070107@provision-comm.com>
In-Reply-To: <48F49D7D.5070107@provision-comm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

Apologies for the bad formatting of the previous message...

I've just pulled the 2.6.27 kernel from git and am trying it out on my=20
MPC8313E RDB dev kit.  I get the following badness during boot (the=20
complete boot record is attached later) :

------------[ cut here ]------------
Badness at fs/sysfs/dir.c:463
NIP: c00c5b54 LR: c00c5b3c CTR: 00000000
REGS: c7827d90 TRAP: 0700   Not tainted  (2.6.27)
MSR: 00029032 <EE,ME,IR,DR>  CR: 22022042  XER: 20000000
TASK =3D c7816400[1] 'swapper' THREAD: c7826000
GPR00: c00c5b3c c7827e40 c7816400 ffffffef c7800e5c c7800b7c c7811570=20
00000000
GPR08: 000001a0 c0370000 00000048 00000000 82044048 100b224c 07ffb000=20
00000000
GPR16: 07ff09e0 07ff94c8 00000000 00000000 00000000 c035c76c c035c740=20
c7ace610
GPR24: 00000000 00000000 00000000 00000001 c7811570 fffffffe c7acdc00=20
c7827e58
Call Trace:
[c7827e40] [c00c5b3c] 0xc00c5b3c (unreliable)
[c7827e50] [c00c6dc4] 0xc00c6dc4
[c7827e80] [c0182d94] 0xc0182d94
[c7827ea0] [c0181590] 0xc0181590
[c7827ef0] [c0213a6c] 0xc0213a6c
[c7827f00] [c0009818] 0xc0009818
[c7827f10] [c00098c0] 0xc00098c0
[c7827f30] [c0009a30] 0xc0009a30
[c7827f50] [c032a1d4] 0xc032a1d4
[c7827f60] [c0003874] 0xc0003874
[c7827fd0] [c031517c] 0xc031517c
[c7827ff0] [c001216c] 0xc001216c
Instruction dump:
912b0028 4bffffbc 9421fff0 7c0802a6 90010014 4bffff2d 2f83ffef 419e0014
80010014 38210010 7c0803a6 4e800020 <0fe00000> 4bffffec 9421ffe0 7c0802a6


I used the mpc8313e_rdb_defconfig, with the exception of enabling more=20
debug.

Any help - not sure where to start... ?

Cheers,
Mike


Complete boot sequence:

Using MPC831x RDB machine description
Linux version 2.6.27 (mike@mike-linux.provision-comm.com) (gcc version=20
4.2.4) #2 Tue Oct 14 14:04:03 BST 2008
Found initrd at 0xc7cf0000:0xc7f2e337
console [udbg0] enabled
setup_arch: bootmem
mpc831x_rdb_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus=20
number: 0->0
PCI host bridge /sleep-nexus/pci@e0008500 (primary) ranges:
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetc=
h
  IO 0x00000000e2000000..0x00000000e20fffff -> 0x0000000000000000
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3251=
2
Kernel command line: root=3D/dev/ram0 rw console=3DttyS0,115200=20
mtdparts=3De2800000.flash:560k(u-boot),80k(u-boot-env),2m(kernel),16k(dtb=
),-(root)
IPIC (128 IRQ sources) at fdefa700
PID hash table entries: 512 (order: 9, 2048 bytes)
clocksource: timebase mult[6000002] shift[22] registered
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 123844k/131072k available (3364k kernel code, 7080k reserved,=20
132k data, 98k bss, 208k init)
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
Calibrating delay loop... 83.20 BogoMIPS (lpj=3D166400)
Mount-cache hash table entries: 512
net_namespace: 288 bytes
NET: Registered protocol family 16
            =20
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
checking if image is initramfs...it isn't (no cpio magic); looks like an=20
initrd
Freeing initrd memory: 2296k freed
------------[ cut here ]------------
Badness at fs/sysfs/dir.c:463
NIP: c00c5b54 LR: c00c5b3c CTR: 00000000
REGS: c7827d90 TRAP: 0700   Not tainted  (2.6.27)
MSR: 00029032 <EE,ME,IR,DR>  CR: 22022042  XER: 20000000
TASK =3D c7816400[1] 'swapper' THREAD: c7826000
GPR00: c00c5b3c c7827e40 c7816400 ffffffef c7800e5c c7800b7c c7811570=20
00000000
GPR08: 000001a0 c0370000 00000048 00000000 82044048 100b224c 07ffb000=20
00000000
GPR16: 07ff09e0 07ff94c8 00000000 00000000 00000000 c035c76c c035c740=20
c7ace610
GPR24: 00000000 00000000 00000000 00000001 c7811570 fffffffe c7acdc00=20
c7827e58
Call Trace:
[c7827e40] [c00c5b3c] 0xc00c5b3c (unreliable)
[c7827e50] [c00c6dc4] 0xc00c6dc4
[c7827e80] [c0182d94] 0xc0182d94
[c7827ea0] [c0181590] 0xc0181590
[c7827ef0] [c0213a6c] 0xc0213a6c
[c7827f00] [c0009818] 0xc0009818
[c7827f10] [c00098c0] 0xc00098c0
[c7827f30] [c0009a30] 0xc0009a30
[c7827f50] [c032a1d4] 0xc032a1d4
[c7827f60] [c0003874] 0xc0003874
[c7827fd0] [c031517c] 0xc031517c
[c7827ff0] [c001216c] 0xc001216c
Instruction dump:
912b0028 4bffffbc 9421fff0 7c0802a6 90010014 4bffff2d 2f83ffef 419e0014
80010014 38210010 7c0803a6 4e800020 <0fe00000> 4bffffec 9421ffe0 7c0802a6
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 246
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 16) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 17) is a 16550A
brd: module loaded
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:95:01
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:95:02
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
fe000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
fe000000.flash: Swapping erase regions for broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
NAND device: Manufacturer ID: 0xec, Chip ID: 0x75 (Samsung NAND 32MiB=20
3,3V 8-bit)
cmdlinepart partition parsing not available
RedBoot partition parsing not available
Creating 3 MTD partitions on "e2800000.flash":
0x00000000-0x00100000 : "u-boot"
0x00100000-0x00400000 : "kernel"
0x00400000-0x02000000 : "fs"
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
rtc-ds1307 0-0068: rtc core: registered ds1339 as rtc0
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-ds1307 0-0068: setting system clock to 2000-01-04 22:45:49 UTC=20
(947025949)
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 208k init
