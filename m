Return-Path: <acrux_it@libero.it>
Received: from cp-out11.libero.it (cp-out11.libero.it [212.52.84.111])
	by ozlabs.org (Postfix) with ESMTP id A95B9B7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Mar 2010 02:19:41 +1100 (EST)
Received: from acrux-1faad1e87 (62.98.27.128) by cp-out11.libero.it (8.5.119)
	(authenticated as acrux_it@libero.it)
	id 4AE04A3D1B500E87 for linuxppc-dev@lists.ozlabs.org;
	Wed, 10 Mar 2010 16:14:27 +0100
Date: Wed, 10 Mar 2010 16:14:41 +0100
From: acrux <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: mv643xx_eth broken again on pegasos2 G4
Message-Id: <20100310161441.6e76143f.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi,
mv643xx_eth driver seems to be broken (and very often there is a kernel panic too).
Last working kernel is 2.6.31.2

here a dmesg from 2.6.32.9:

memory = 1024MB; using 2048kB for hash table (at cfe00000)
Linux version 2.6.32.9 (root@pegasos2) (gcc version 4.3.4 (CRUX PPC) (GCC) ) #1
PREEMPT Wed Mar 10 15:56:51 CET 2010
Found legacy serial port 0 for /pci@80000000/isa@C/serial@i2F8
  port=2f8, taddr=fe0002f8, irq=0, clk=1843200, speed=0
bootconsole [udbg0] enabled
chrp type = 6 [Genesi Pegasos]
Pegasos l2cr : L2 cache was not active, activating
PCI bus 0 controlled by /pci@80000000 at 80000000
PCI host bridge /pci@80000000 (primary) ranges:
  IO 0x00000000fe000000..0x00000000fe00ffff -> 0x0000000000000000
 MEM 0x0000000080000000..0x00000000bfffffff -> 0x0000000080000000
PCI bus 0 controlled by /pci@C0000000 at c0000000
PCI host bridge /pci@C0000000  ranges:
  IO 0x00000000f8000000..0x00000000f800ffff -> 0x0000000000000000
 MEM 0x00000000c0000000..0x00000000dfffffff -> 0x00000000c0000000
Top of RAM: 0x40000000, Total RAM: 0x40000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   0x00030000 -> 0x00030000
  HighMem  0x00030000 -> 0x00040000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00040000
On node 0 totalpages: 262144
free_area_init_node: node 0, pgdat c045b65c, node_mem_map c0baf000
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
  HighMem zone: 512 pages used for memmap
  HighMem zone: 65024 pages, LIFO batch:15
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/hda5 video=radeonfb:800x600@60 mv643xx_eth=no
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
High memory: 262080k
Memory: 1031700k/1048576k available (4268k kernel code, 16184k reserved, 236k da
ta, 120k bss, 160k init)
Kernel virtual memory layout:
  * 0xfffef000..0xfffff000  : fixmap
  * 0xff800000..0xffc00000  : highmem PTEs
  * 0xff7e0000..0xff800000  : early ioremap
  * 0xf1000000..0xff7e0000  : vmalloc & ioremap
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:512
i8259 legacy interrupt controller initialized
time_init: decrementer frequency = 33.333333 MHz
time_init: processor frequency   = 999.999990 MHz
clocksource: timebase mult[7800001] shift[22] registered
clockevent: decrementer mult[8888887] shift[32] cpu[0]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
pci 0000:00:01.0: reg 10 32bit mmio: [0x80000000-0x800007ff]
pci 0000:00:01.0: reg 14 io port: [0x1080-0x10ff]
pci 0000:00:01.0: supports D2
pci 0000:00:01.0: PME# supported from D2 D3hot D3cold
pci 0000:00:01.0: PME# disabled
pci 0000:00:0c.1: reg 10 io port: [0x1000-0x1007]
pci 0000:00:0c.1: reg 14 io port: [0x100c-0x100f]
pci 0000:00:0c.1: reg 18 io port: [0x1010-0x1017]
pci 0000:00:0c.1: reg 1c io port: [0x101c-0x101f]
pci 0000:00:0c.1: reg 20 io port: [0x1020-0x102f]
pci 0000:00:0c.2: reg 20 io port: [0x1040-0x105f]
pci 0000:00:0c.3: reg 20 io port: [0x1060-0x107f]
pci 0000:00:0c.5: reg 10 io port: [0x1100-0x11ff]
pci 0000:00:0c.5: reg 14 io port: [0x1030-0x1033]
pci 0000:00:0c.5: reg 18 io port: [0x1034-0x1037]
pci 0000:00:0c.6: reg 10 io port: [0x1200-0x12ff]
pci 0000:00:0d.0: reg 10 io port: [0x1300-0x13ff]
pci 0000:00:0d.0: reg 14 32bit mmio: [0x80000800-0x800008ff]
pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:0d.0: PME# disabled
pci 0001:01:08.0: reg 10 32bit mmio pref: [0xc0000000-0xc7ffffff]
pci 0001:01:08.0: reg 14 io port: [0x1000-0x10ff]
pci 0001:01:08.0: reg 18 32bit mmio: [0xc8000000-0xc800ffff]
pci 0001:01:08.0: reg 30 32bit mmio pref: [0xc8020000-0xc803ffff]
pci 0001:01:08.0: supports D1 D2
pci 0001:01:08.1: reg 10 32bit mmio pref: [0xd0000000-0xd7ffffff]
pci 0001:01:08.1: reg 14 32bit mmio: [0xc8010000-0xc801ffff]
pci 0001:01:08.1: supports D1 D2
PCI 0000:00 Cannot reserve Legacy IO [0x00-0xfff]
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x80000000-0xbfffffff]
pci_bus 0001:01: resource 0 io:  [0xffff0000-0xffffffff]
pci_bus 0001:01: resource 1 mem: [0xc0000000-0xdfffffff]
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0001:01:08.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
Switching to clocksource timebase
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
pci 0000:00:0c.1: Fixing VIA IDE, force legacy mode on
Thermal assist unit not available
highmem bounce pool size: 64 pages
msgmni has been set to 1504
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler cfq registered (default)
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: No ATY,RefCLK property !
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=240.00 Mhz, System=166.00 MHz
radeonfb: PLL min 20000 max 40000
i2c i2c-2: unable to read EDID block.
i2c i2c-2: unable to read EDID block.
i2c i2c-2: unable to read EDID block.
i2c i2c-3: unable to read EDID block.
i2c i2c-3: unable to read EDID block.
i2c i2c-3: unable to read EDID block.
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 100x37
radeonfb (0001:01:08.0): ATI Radeon 5960 "Y`"
Generic non-volatile memory driver v1.1
Linux agpgart interface v0.103
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x2f8 (irq = 0) is a 16550A
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
via82cxxx 0000:00:0c.1: VIA vt8231 (rev 10) IDE UDMA100
via82cxxx 0000:00:0c.1: IDE controller (0x1106:0x0571 rev 0x06)
via82cxxx 0000:00:0c.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1020-0x1027
    ide1: BM-DMA at 0x1028-0x102f
Probing IDE interface ide0...
hda: ST340810A, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
Probing IDE interface ide1...
hdc: SAMSUNG CDRW/DVD SM-352B, ATAPI CD/DVD-ROM drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
ide0 at 0x1000-0x1007,0x100e on irq 14
ide1 at 0x1010-0x1017,0x101e on irq 15
ide-gd driver 1.18
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
ide-cd driver 5.00
ide-cd: hdc: ATAPI 52X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Fixed MDIO Bus: probed
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
i2c /dev entries driver
Linux video capture interface: v2.00
device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
atkbd.c: keyboard reset failed on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.21.
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input0
REISERFS (device hda5): found reiserfs format "3.6" with standard journal
REISERFS (device hda5): using ordered data mode
REISERFS (device hda5): journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
REISERFS (device hda5): checking transaction log (hda5)
REISERFS (device hda5): Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly on device 3:5.
Freeing unused kernel memory: 160k init
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
via-rhine 0000:00:0d.0: enabling device (0000 -> 0003)
eth0: VIA Rhine II at 0x80000800, 00:0b:2f:4f:65:7b, IRQ 9.
eth0: MII PHY found at address 16, status 0x786d advertising 01e1 Link 45e1.
MV-643xx 10/100/1000 ethernet driver version 1.4
sysfs: cannot create duplicate filename '/class/mdio_bus/0'
------------[ cut here ]------------
Badness at fs/sysfs/dir.c:491
NIP: c00dc568 LR: c00dc568 CTR: c00200ac
REGS: ef015c70 TRAP: 0700   Not tainted  (2.6.32.9)
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22422488  XER: 00000000
TASK = ef082bc0[1011] 'modprobe' THREAD: ef014000
GPR00: c00dc568 ef015d20 ef082bc0 00000042 c04303f0 c04303f0 00000000 00000001
GPR08: 00000000 00000000 01430ee0 ffffffff 81f2ba43 10020a5c 00000000 00000000
GPR16: 00000000 00000000 100056bc 00000003 4801f000 00000000 00000000 c0430120
GPR24: 107fb560 107fb57c ef17fc48 00000001 ffffffef ef015d48 ef108030 ef355000
NIP [c00dc568] sysfs_add_one+0x7c/0xa0
LR [c00dc568] sysfs_add_one+0x7c/0xa0
Call Trace:
[ef015d20] [c00dc568] sysfs_add_one+0x7c/0xa0 (unreliable)
[ef015d40] [c00dd700] sysfs_do_create_link+0xf4/0x188
[ef015d70] [c022ffbc] device_add+0x1a8/0x51c
[ef015db0] [c026be38] mdiobus_register+0xa0/0x1ac
[ef015de0] [f224d5dc] mv643xx_eth_shared_probe+0x140/0x3f8 [mv643xx_eth]
[ef015e00] [c0233dd0] platform_drv_probe+0x20/0x30
[ef015e10] [c0232a4c] driver_probe_device+0xd4/0x1a8
[ef015e30] [c0232b90] __driver_attach+0x70/0xa4
[ef015e50] [c02320cc] bus_for_each_dev+0x5c/0xac
[ef015e80] [c023285c] driver_attach+0x24/0x34
[ef015e90] [c0231910] bus_add_driver+0xb4/0x248
[ef015eb0] [c0232f78] driver_register+0xd0/0x174
[ef015ed0] [c023412c] platform_driver_register+0x6c/0x7c
[ef015ee0] [f2256024] mv643xx_eth_init_module+0x24/0x80 [mv643xx_eth]
[ef015f00] [c0003ee0] do_one_initcall+0x64/0x1f8
[ef015f20] [c0054680] sys_init_module+0xe0/0x224
[ef015f40] [c0013828] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff69720
    LR = 0x10004150
Instruction dump:
807d0000 7fe4fb78 4bffff51 3c80c03a 3884adb0 4bf3ce4d 809e0010 4bf3ce45
7c641b78 3c60c03b 38639868 48259099 <0fe00000> 7fe3fb78 4bfaac0d 80010024
mii_bus 0 failed to register
mv643xx_eth: probe of mv643xx_eth.0 failed with error -12
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xf2250908
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT CHRP
Modules linked in: mv643xx_eth(+) via_rhine serio_raw parport firewire_core
NIP: f2250908 LR: f2250900 CTR: c0232574
REGS: ef015d10 TRAP: 0300   Tainted: G        W   (2.6.32.9)
MSR: 00009032 <EE,ME,IR,DR>  CR: 84422488  XER: 20000000
DAR: 00000000, DSISR: 40000000
TASK = ef082bc0[1011] 'modprobe' THREAD: ef014000
GPR00: f22508f4 ef015dc0 ef082bc0 00000000 efb42300 efb42005 efb4214d 00000000
GPR08: 00000000 00000001 2bfd0c6b c0232574 00000000 10020a5c 00000000 00000000
GPR16: 00000000 00000000 100056bc 00000003 c0430230 00000000 00000000 00000000
GPR24: c0430228 107fb57c 00000000 efb42000 f22528c0 fffffff4 c04300d8 efb42300
NIP [f2250908] mv643xx_eth_probe+0xac/0x620 [mv643xx_eth]
LR [f2250900] mv643xx_eth_probe+0xa4/0x620 [mv643xx_eth]
Call Trace:
[ef015dc0] [f22508f4] mv643xx_eth_probe+0x98/0x620 [mv643xx_eth] (unreliable)
[ef015e00] [c0233dd0] platform_drv_probe+0x20/0x30
[ef015e10] [c0232a4c] driver_probe_device+0xd4/0x1a8
[ef015e30] [c0232b90] __driver_attach+0x70/0xa4
[ef015e50] [c02320cc] bus_for_each_dev+0x5c/0xac
[ef015e80] [c023285c] driver_attach+0x24/0x34
[ef015e90] [c0231910] bus_add_driver+0xb4/0x248
[ef015eb0] [c0232f78] driver_register+0xd0/0x174
[ef015ed0] [c023412c] platform_driver_register+0x6c/0x7c
[ef015ee0] [f2256034] mv643xx_eth_init_module+0x34/0x80 [mv643xx_eth]
[ef015f00] [c0003ee0] do_one_initcall+0x64/0x1f8
[ef015f20] [c0054680] sys_init_module+0xe0/0x224
[ef015f40] [c0013828] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff69720
    LR = 0x10004150
Instruction dump:
7c7b1b79 41820528 3bfb0300 3a980008 7e83a378 7fe4fb78 48000dd1 807e0000
38630008 480011b5 907b0300 813e0004 <80030000> 5529502a 39290400 7c004a14
---[ end trace 1a9241f24ee15efc ]---
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:0c.2: enabling device (0000 -> 0001)
uhci_hcd 0000:00:0c.2: UHCI Host Controller
uhci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:0c.2: irq 9, io base 0x00001040
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:0c.3: enabling device (0000 -> 0001)
uhci_hcd 0000:00:0c.3: UHCI Host Controller
uhci_hcd 0000:00:0c.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:0c.3: irq 9, io base 0x00001060
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
vt596_smbus 0000:00:0c.4: SMBUS: Error: Host SMBus controller not enabled! - upgrade BIOS or use force=1
firewire_ohci 0000:00:01.0: enabling device (0000 -> 0003)
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
firewire_ohci: Added fw-ohci device 0000:00:01.0, OHCI version 1.0
parport_pc: Current parallel port base: 0x3BC
parport0: PC-style at 0x3bc, irq 7 [PCSPP]
parport_pc: VIA parallel port: io=0x3BC, irq=7
VIA 82xx Audio 0000:00:0c.5: enabling device (0000 -> 0001)
usb 1-2: new low speed USB device using uhci_hcd and address 2
usb 1-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: MOSART Semi. Wireless Keyboard & Mouse as /devices/pci0000:00/0000:00:0c.2/usb1/1-2/1-2:1.0/input/input1
generic-usb 0003:062A:0102.0001: input: USB HID v1.10 Keyboard [MOSART Semi. Wireless Keyboard & Mouse] on usb-0000:00:0c.2-2/input0
usb 2-2: new full speed USB device using uhci_hcd and address 2
input: MOSART Semi. Wireless Keyboard & Mouse as /devices/pci0000:00/0000:00:0c.2/usb1/1-2/1-2:1.1/input/input2
firewire_core: created device fw0: GUID 0011060000004b2f, S400
generic-usb 0003:062A:0102.0002: input,hiddev0: USB HID v1.10 Mouse [MOSART Semi. Wireless Keyboard & Mouse] on usb-0000:00:0c.2-2/input1
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
usb 2-2: configuration #1 chosen from 1 choice
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
REISERFS (device hda6): found reiserfs format "3.6" with standard journal
REISERFS (device hda6): using ordered data mode
REISERFS (device hda6): journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
REISERFS (device hda6): checking transaction log (hda6)
REISERFS (device hda6): Using r5 hash to sort names
REISERFS (device hda7): found reiserfs format "3.6" with standard journal
REISERFS (device hda7): using ordered data mode
REISERFS (device hda7): journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
REISERFS (device hda7): checking transaction log (hda7)
REISERFS (device hda7): Using r5 hash to sort names
Adding 499992k swap on /dev/hda1.  Priority:-1 extents:1 across:499992k
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 10
hda: UDMA/100 mode selected
hda: cache flushes not supported
eth0: no IPv6 routers present



--n
-- 
acrux <acrux_it@libero.it>
