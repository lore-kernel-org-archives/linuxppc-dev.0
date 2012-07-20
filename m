Return-Path: <ronne@list.ru>
Received: from fallback4.mail.ru (fallback4.mail.ru [94.100.176.42])
 by ozlabs.org (Postfix) with ESMTP id 71DDC2C0100
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 00:53:51 +1000 (EST)
Received: from smtp23.mail.ru (smtp23.mail.ru [94.100.176.176])
 by fallback4.mail.ru (mPOP.Fallback_MX) with ESMTP id E30B991F2739
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 18:46:38 +0400 (MSK)
Received: from [91.79.217.78] (port=11940 helo=[192.168.1.64])
 by smtp23.mail.ru with esmtpa (envelope-from <ronne@list.ru>)
 id 1SsETQ-0000Io-Cv
 for linuxppc-dev@lists.ozlabs.org; Fri, 20 Jul 2012 18:46:33 +0400
Message-ID: <50096F45.80601@list.ru>
Date: Fri, 20 Jul 2012 18:46:29 +0400
From: Andrey Gusev <ronne@list.ru>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Errors related to i2c-powermac on the G4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!
I build kernel from git and can see errors in dmesg on boot. 3.4.5 
doesn't have such issue.
git show | head -n2
commit 85efc72a0218335324d358ac479a04c16316fd4d
Merge: 3e4b945 6a3ca4f

dmesg:
[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 1536MB; using 4096kB for hash table (at 
cfc00000)
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.5.0-rc7+ (andrey@power-debian) (gcc 
version 4.6.3 (Debian 4.6.3-8) ) #2 SMP PREEMPT Fri Jul 20 18:04:08 MSK 2012
[    0.000000] Found initrd at 0xc1300000:0xc16f8000
[    0.000000] Found UniNorth memory controller & host bridge @ 
0xf8000000 revision: 0x24
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 3, mapped at 
0xff740000
[    0.000000] PowerMac motherboard: PowerMac G4 Windtunnel
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. 
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 
0x00000000f1000000
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 
0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 
0x0000000090000000
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. 
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 
0x00000000f3000000
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 
0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 
0x0000000080000000
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. 
Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 
0x00000000f5000000
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 
0x0000000000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=1492, gen1=1493
[    0.000000] nvram: Active bank is: 1
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Top of RAM: 0x60000000, Total RAM: 0x60000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00000000-0x2fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x30000000-0x5fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x5fffffff]
[    0.000000] On node 0 totalpages: 393216
[    0.000000] free_area_init_node: node 0, pgdat c0567ca0, node_mem_map 
c05c2000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 195072 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1536 pages used for memmap
[    0.000000]   HighMem zone: 195072 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 7 pages/cpu @c11cd000 s7072 r8192 d13408 
u32768
[    0.000000] pcpu-alloc: s7072 r8192 d13408 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 390144
[    0.000000] Kernel command line: root=/dev/mapper/power--group-root 
ro nouveau.modeset=0 libata.force=2:pio4 drm.debug=0x04
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
[    0.000000] High memory: 786432k
[    0.000000] Memory: 1545224k/1572864k available (5392k kernel code, 
27640k reserved, 204k data, 244k bss, 236k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffbf000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xfdcda000..0xff800000  : early ioremap
[    0.000000]   * 0xf1000000..0xfdcda000  : vmalloc & ioremap
[    0.000000] SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, 
CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]     Dump stacks of tasks blocking RCU-preempt GP.
[    0.000000] NR_IRQS:128 nr_irqs:128 16
[    0.000000] mpic: Resetting
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 
80040000, max 2 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] GMT Delta read from XPRAM: 240 minutes, DST: on
[    0.000000] time_init: decrementer frequency = 33.304672 MHz
[    0.000000] time_init: processor frequency   = 866.666664 MHz
[    0.000000] clocksource: timebase mult[1e069bf8] shift[24] registered
[    0.000000] clockevent: decrementer mult[886a7ad] shift[32] cpu[0]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[    0.001299] pid_max: default: 32768 minimum: 301
[    0.001485] Mount-cache hash table entries: 512
[    0.002003] device-tree: Duplicate name in 
/cpus/PowerPC,G4@0/l2-cache, renamed to "l2-cache#1"
[    0.002103] device-tree: Duplicate name in /cpus/PowerPC,G4@0, 
renamed to "l2-cache#1"
[    0.002239] device-tree: Duplicate name in 
/cpus/PowerPC,G4@1/l2-cache, renamed to "l2-cache#1"
[    0.002335] device-tree: Duplicate name in /cpus/PowerPC,G4@1, 
renamed to "l2-cache#1"
[    0.005927] Initializing cgroup subsys freezer
[    0.006500] PowerMac SMP probe found 2 cpus
[    0.006621] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.006642]  channel 0 bus <multibus>
[    0.006654]  channel 1 bus <multibus>
[    0.006699] KeyWest i2c @0x80018000 irq 26 
/pci@f2000000/mac-io@17/i2c@18000
[    0.006717]  channel 0 bus <multibus>
[    0.006734] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.006750]  channel 1 bus <multibus>
[    0.006762]  channel 2 bus <multibus>
[    0.006783] pmf: no parser for command 17 !
[    0.006826] Processor timebase sync using GPIO 0x73
[    0.006840] mpic: requesting IPIs...
[    0.006922] CPU0: L2CR is 80080000
[    0.006939] CPU0: L3CR is 8f0b0000
[    0.006956] MPC7450 family performance monitor hardware support 
registered
[476246925.023023] CPU1: L2CR was 80000
[476246925.023054] CPU1: L2CR set to 80080000
[476246925.023057] CPU1: L3CR was 0
[476246925.023215] CPU1: L3CR set to 8f0b0000
[    0.018176] Brought up 2 CPUs
[    0.019123] NET: Registered protocol family 16
[    0.021924] PCI: Probing PCI hardware
[    0.022130] PCI host bridge to bus 0000:00
[    0.022162] pci_bus 0000:00: root bus resource [io  
0x802000-0x1001fff] (bus address [0x0000-0x7fffff])
[    0.022193] pci_bus 0000:00: root bus resource [mem 
0xf1000000-0xf1ffffff]
[    0.022215] pci_bus 0000:00: root bus resource [mem 
0x90000000-0xafffffff]
[    0.022290] pci 0000:00:0b.0: [106b:0034] type 00 class 0x060000
[    0.022396] pci 0000:00:10.0: [10de:0172] type 00 class 0x030000
[    0.022421] pci 0000:00:10.0: reg 10: [mem 0x91000000-0x91ffffff]
[    0.022436] pci 0000:00:10.0: reg 14: [mem 0x98000000-0x9fffffff pref]
[    0.022451] pci 0000:00:10.0: reg 18: [mem 0x00000000-0x0007ffff pref]
[    0.022484] pci 0000:00:10.0: reg 30: [mem 0x90000000-0x9001ffff pref]
[    0.023104] PCI host bridge to bus 0001:10
[    0.023133] pci_bus 0001:10: root bus resource [io  0x0000-0x7fffff]
[    0.023155] pci_bus 0001:10: root bus resource [mem 
0xf3000000-0xf3ffffff]
[    0.023177] pci_bus 0001:10: root bus resource [mem 
0x80000000-0x8fffffff]
[    0.023231] pci 0001:10:0b.0: [106b:0035] type 00 class 0x060000
[    0.023318] pci 0001:10:15.0: [12eb:0002] type 00 class 0x040100
[    0.023341] pci 0001:10:15.0: reg 10: [mem 0x800c0000-0x800fffff]
[    0.023356] pci 0001:10:15.0: reg 14: [io  0x0410-0x0417]
[    0.023371] pci 0001:10:15.0: reg 18: [io  0x0400-0x0407]
[    0.023427] pci 0001:10:15.0: supports D2
[    0.023454] pci 0001:10:17.0: [106b:0022] type 00 class 0xff0000
[    0.023472] pci 0001:10:17.0: reg 10: [mem 0x80000000-0x8007ffff]
[    0.023546] pci 0001:10:18.0: [106b:0019] type 00 class 0x0c0310
[    0.023565] pci 0001:10:18.0: reg 10: [mem 0x80081000-0x80081fff]
[    0.023639] pci 0001:10:19.0: [106b:0019] type 00 class 0x0c0310
[    0.023659] pci 0001:10:19.0: reg 10: [mem 0x80080000-0x80080fff]
[    0.024952] PCI host bridge to bus 0002:20
[    0.024981] pci_bus 0002:20: root bus resource [io  
0xff7fe000-0xffffdfff] (bus address [0x0000-0x7fffff])
[    0.025012] pci_bus 0002:20: root bus resource [mem 
0xf5000000-0xf5ffffff]
[    0.025066] pci 0002:20:0b.0: [106b:0036] type 00 class 0x060000
[    0.025126] pci 0002:20:0d.0: [106b:0033] type 00 class 0xff0000
[    0.025144] pci 0002:20:0d.0: reg 10: [mem 0xf5004000-0xf5007fff]
[    0.025212] pci 0002:20:0e.0: [106b:0031] type 00 class 0x0c0010
[    0.025233] pci 0002:20:0e.0: reg 10: [mem 0xf5000000-0xf5000fff]
[    0.025292] pci 0002:20:0e.0: supports D1 D2
[    0.025300] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.025329] pci 0002:20:0f.0: [106b:0032] type 00 class 0x020000
[    0.025347] pci 0002:20:0f.0: reg 10: [mem 0xf5200000-0xf53fffff]
[    0.025391] pci 0002:20:0f.0: reg 30: [mem 0xf5100000-0xf51fffff pref]
[    0.026420] PCI 0001:10 Cannot reserve Legacy IO [io  0x0000-0x0fff]
[    0.026443] pci 0000:00:10.0: BAR 2: assigned [mem 
0xf1000000-0xf107ffff pref]
[    0.026485] pci_bus 0000:00: resource 4 [io  0x802000-0x1001fff]
[    0.026493] pci_bus 0000:00: resource 5 [mem 0xf1000000-0xf1ffffff]
[    0.026501] pci_bus 0000:00: resource 6 [mem 0x90000000-0xafffffff]
[    0.026509] pci_bus 0001:10: resource 4 [io  0x0000-0x7fffff]
[    0.026517] pci_bus 0001:10: resource 5 [mem 0xf3000000-0xf3ffffff]
[    0.026525] pci_bus 0001:10: resource 6 [mem 0x80000000-0x8fffffff]
[    0.026533] pci_bus 0002:20: resource 4 [io  0xff7fe000-0xffffdfff]
[    0.026541] pci_bus 0002:20: resource 5 [mem 0xf5000000-0xf5ffffff]
[    0.040171] bio: create slab <bio-0> at 0
[    0.041044] vgaarb: device added: 
PCI:0000:00:10.0,decodes=io+mem,owns=mem,locks=none
[    0.041124] vgaarb: loaded
[    0.041138] vgaarb: bridge control possible 0000:00:10.0
[    0.041767] SCSI subsystem initialized
[    0.042242] libata version 3.00 loaded.
[    0.042661] usbcore: registered new interface driver usbfs
[    0.042839] usbcore: registered new interface driver hub
[    0.043046] usbcore: registered new device driver usb
[    0.043610] Advanced Linux Sound Architecture Driver Version 1.0.25.
[    0.044434] Switching to clocksource timebase
[    0.056661] NET: Registered protocol family 2
[    0.056832] IP route cache hash table entries: 32768 (order: 5, 
131072 bytes)
[    0.057466] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes)
[    0.059937] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.061777] TCP: Hash tables configured (established 131072 bind 65536)
[    0.061818] TCP: reno registered
[    0.061845] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.061899] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.062184] NET: Registered protocol family 1
[    0.062301] pci 0001:10:18.0: enabling device (0000 -> 0002)
[    0.112542] pci 0001:10:19.0: enabling device (0000 -> 0002)
[    0.163532] PCI: CLS mismatch (32 != 1020), using 32 bytes
[    0.163724] Trying to unpack rootfs image as initramfs...
[    0.374104] Freeing initrd memory: 4064k freed
[    0.375276] Thermal assist unit not available
[    0.377113] highmem bounce pool size: 64 pages
[    0.393582] fuse init (API version 7.19)
[    0.394172] msgmni has been set to 1489
[    0.396965] alg: No test for stdrng (krng)
[    0.418813] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 253)
[    0.418856] io scheduler noop registered
[    0.419099] io scheduler cfq registered (default)
[    0.419447] Using unsupported 1600x1200 NVDA,Display-B at 98004000, 
depth=8, pitch=2048
[    0.450602] Console: switching to colour frame buffer device 200x75
[    0.479372] fb0: Open Firmware frame buffer device on 
/pci@f0000000/NVDA,Parent@10/NVDA,Display-B@1
[    0.479661] Using unsupported 640x480 NVDA,Display-A at 99000000, 
depth=8, pitch=640
[    0.479898] checking generic (98004000 258000) vs hw (99000000 4b000)
[    0.480124] fb1: Open Firmware frame buffer device on 
/pci@f0000000/NVDA,Parent@10/NVDA,Display-A@0
[    0.480587] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.481886] pmac_zilog: 0.6 (Benjamin Herrenschmidt 
<benh@kernel.crashing.org>)
[    0.482291] Generic non-volatile memory driver v1.1
[    0.482593] Linux agpgart interface v0.103
[    0.482736] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
[    0.484460] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 64
[    0.484827] agpgart-uninorth 0000:00:0b.0: AGP aperture is 256M @ 0x0
[    0.491700] brd: module loaded
[    0.495335] loop: module loaded
[    0.495689] MacIO PCI driver attached to Keylargo chipset
[    0.498235] 0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 22) is 
a Z85c30 ESCC - Serial port
[    0.498968] 0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 23) is 
a Z85c30 ESCC - Serial port
[    0.500475] pata-pci-macio 0002:20:0d.0: enabling device (0000 -> 0002)
[    0.511513] pata-pci-macio 0002:20:0d.0: Activating pata-macio 
chipset UniNorth ATA-6, Apple bus ID 3
[    0.512635] scsi0 : pata_macio
[    0.513093] ata1: PATA max UDMA/100 irq 39
[    0.667968] ata1.00: ATA-5: IBM-IC35L060AVVA07-0, VA3BA52A, max UDMA/100
[    0.668179] ata1.00: 120103200 sectors, multi 16: LBA
[    0.676945] ata1.00: configured for UDMA/100
[    0.677456] scsi 0:0:0:0: Direct-Access     ATA      IBM-IC35L060AVVA 
VA3B PQ: 0 ANSI: 5
[    1.525510] pata-macio 0.0001f000:ata-4: Activating pata-macio 
chipset KeyLargo ATA-4, Apple bus ID 2
[    1.526619] scsi1 : pata_macio
[    1.527015] ata2: PATA max UDMA/66 irq 19
[    1.697163] ata2.00: HPA detected: current 40130390, native 40132503
[    1.697343] ata2.00: ATA-5: QUANTUM FIREBALLP LM20.5, A35.0700, max 
UDMA/66
[    1.697535] ata2.00: 40130390 sectors, multi 0: LBA
[    1.697675] ata2.00: FORCE: xfer_mask set to pio4
[    1.720124] ata2.00: configured for PIO4
[    1.720481] scsi 1:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL 
A35. PQ: 0 ANSI: 5
[    2.538510] pata-macio 0.00020000:ata-3: Activating pata-macio 
chipset KeyLargo ATA-3, Apple bus ID 0
[    2.539571] scsi2 : pata_macio
[    2.539987] ata3: PATA max MWDMA2 irq 20
[    2.540364] sungem.c:v1.0 David S. Miller <davem@redhat.com>
[    2.541529] gem 0002:20:0f.0: eth0: Sun GEM (PCI) 10/100/1000BaseT 
Ethernet 00:03:93:ab:d1:a6
[    2.542312] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.542818] ohci_hcd 0001:10:18.0: OHCI Host Controller
[    2.542980] ohci_hcd 0001:10:18.0: new USB bus registered, assigned 
bus number 1
[    2.543251] ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
[    2.613408] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    2.613604] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    2.613797] usb usb1: Product: OHCI Host Controller
[    2.613926] usb usb1: Manufacturer: Linux 3.5.0-rc7+ ohci_hcd
[    2.622108] usb usb1: SerialNumber: 0001:10:18.0
[    2.622663] hub 1-0:1.0: USB hub found
[    2.622683] hub 1-0:1.0: 2 ports detected
[    2.622841] ohci_hcd 0001:10:19.0: OHCI Host Controller
[    2.622856] ohci_hcd 0001:10:19.0: new USB bus registered, assigned 
bus number 2
[    2.622907] ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
[    2.692391] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    2.700756] ata3.00: ATAPI: TSSTcorp CDDVDW SH-S222A, SB02, max UDMA/66
[    2.708672] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    2.716736] usb usb2: Product: OHCI Host Controller
[    2.724896] usb usb2: Manufacturer: Linux 3.5.0-rc7+ ohci_hcd
[    2.733113] ata3.00: configured for MWDMA2
[    2.737517] usb usb2: SerialNumber: 0001:10:19.0
[    2.749518] hub 2-0:1.0: USB hub found
[    2.757747] hub 2-0:1.0: 2 ports detected
[    2.766328] uhci_hcd: USB Universal Host Controller Interface driver
[    2.766676] scsi 2:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-S222A  
SB02 PQ: 0 ANSI: 5
[    2.783116] mousedev: PS/2 mouse device common for all mice
[    2.784565] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw 
xa/form2 cdda tray
[    2.784571] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.785023] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    2.808056] rtc-generic rtc-generic: rtc core: registered rtc-generic 
as rtc0
[    2.816567] i2c /dev entries driver
[    2.825370] i2c i2c-0: therm_windtunnel: attach_adapter method is 
deprecated
[    2.833666] i2c i2c-0: Please use another way to instantiate your 
i2c_client
[    2.841935] PowerMac i2c bus pmu 2 registered
[    2.850440] i2c i2c-1: therm_windtunnel: attach_adapter method is 
deprecated
[    2.858624] i2c i2c-1: Please use another way to instantiate your 
i2c_client
[    2.866754] PowerMac i2c bus pmu 1 registered
[    2.875415] i2c i2c-2: therm_windtunnel: attach_adapter method is 
deprecated
[    2.883473] i2c i2c-2: Please use another way to instantiate your 
i2c_client
[    2.891500] PowerMac i2c bus mac-io 0 registered
[    2.899496] i2c i2c-2: i2c-powermac: invalid reg on 
/pci@f2000000/mac-io@17/i2c@18000/cereal
[    2.907626] i2c i2c-2: i2c-powermac: invalid reg on 
/pci@f2000000/mac-io@17/i2c@18000/deq
[    2.915711] i2c i2c-2: i2c-powermac: invalid reg on 
/pci@f2000000/mac-io@17/i2c@18000/i2c-modem
[    2.924148] i2c i2c-3: therm_windtunnel: attach_adapter method is 
deprecated
[    2.932259] i2c i2c-3: Please use another way to instantiate your 
i2c_client
[    2.941370] PowerMac i2c bus uni-n 1 registered
[    2.949523] i2c i2c-3: i2c-powermac: invalid reg on 
/uni-n@f8000000/i2c@f8001000/cereal
[    2.958084] i2c i2c-4: therm_windtunnel: attach_adapter method is 
deprecated
[    2.958531] usb 1-1: new full-speed USB device number 2 using ohci_hcd
[    2.974633] i2c i2c-4: Please use another way to instantiate your 
i2c_client
[    2.984188] DS1775 digital thermometer [@49]
[    2.992590] Temp: 58.1 C  Hyst: 70.0 C  OS: 75.0 C
[    3.001592] ADM1030 fan controller [@2c]
[    3.009847] PowerMac i2c bus uni-n 0 registered
[    3.018007] i2c i2c-4: Failed to register i2c client MAC,adm1030 at 
0x2c (-16)
[    3.026299] i2c i2c-4: i2c-powermac: Failure to register 
/uni-n@f8000000/i2c@f8001000/fan@58
[    3.034827] i2c i2c-4: Failed to register i2c client MAC,ds1775 at 
0x49 (-16)
[    3.043106] i2c i2c-4: i2c-powermac: Failure to register 
/uni-n@f8000000/i2c@f8001000/temp-monitor@92
[    3.051420] i2c i2c-4: i2c-powermac: invalid reg on 
/uni-n@f8000000/i2c@f8001000/cereal
[    3.060750] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) 
initialised: dm-devel@redhat.com
[    3.071757] usbcore: registered new interface driver usbhid
[    3.080215] usbhid: USB HID core driver
[    3.088767] TCP: cubic registered
[    3.097981] NET: Registered protocol family 10
[    3.106997] sit: IPv6 over IPv4 tunneling driver
[    3.116214] NET: Registered protocol family 17
[    3.125056] registered taskstats version 1
[    3.133221] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
[    3.141806] usb 1-1: New USB device strings: Mfr=0, Product=1, 
SerialNumber=0
[    3.142123] input: PMU as /devices/virtual/input/input0
[    3.158220] usb 1-1: Product: USB2.0 Hub
[    3.158235] rtc-generic rtc-generic: setting system clock to 
2012-07-20 14:13:40 UTC (1342793620)
[    3.158267] ALSA device list:
[    3.158269]   No soundcards found.
[    3.191467] Freeing unused kernel memory: 236k freed
[    3.200129] hub 1-1:1.0: USB hub found
[    3.209554] hub 1-1:1.0: 4 ports detected
[    3.506533] usb 1-1.1: new full-speed USB device number 3 using ohci_hcd
[    3.604581] usb 1-1.1: New USB device found, idVendor=05e3, 
idProduct=0608
[    3.614028] usb 1-1.1: New USB device strings: Mfr=0, Product=1, 
SerialNumber=0
[    3.622455] usb 1-1.1: Product: USB2.0 Hub
[    3.632649] hub 1-1.1:1.0: USB hub found
[    3.641563] hub 1-1.1:1.0: 4 ports detected
[    3.676594] sd 1:0:0:0: [sdb] 40130390 512-byte logical blocks: (20.5 
GB/19.1 GiB)
[    3.685049] sd 0:0:0:0: [sda] 120103200 512-byte logical blocks: 
(61.4 GB/57.2 GiB)
[    3.693552] sd 0:0:0:0: [sda] Write Protect is off
[    3.701893] sd 1:0:0:0: [sdb] Write Protect is off
[    3.710039] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.710088] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.710185] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.718425] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.733521]  sdb: [mac] sdb1 sdb2
[    3.741916]  sda: [mac] sda1 sda2 sda3 sda4
[    3.752562] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.760667] sd 1:0:0:0: [sdb] Attached SCSI disk
[    3.765386] firewire_ohci 0002:20:0e.0: enabling device (0000 -> 0002)
[    3.818016] firewire_ohci 0002:20:0e.0: added OHCI v1.10 device as 
card 0, 8 IR + 8 IT contexts, quirks 0x0
[    3.952567] usb 1-1.1.2: new low-speed USB device number 4 using ohci_hcd
[    4.059556] usb 1-1.1.2: New USB device found, idVendor=046d, 
idProduct=c05f
[    4.067674] usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[    4.075979] usb 1-1.1.2: Product: USB Optical Mouse
[    4.084184] usb 1-1.1.2: Manufacturer: Logitech
[    4.100649] input: Logitech USB Optical Mouse as 
/devices/pci0001:10/0001:10:18.0/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/input/input1
[    4.109222] hid-generic 0003:046D:C05F.0001: input,hidraw0: USB HID 
v1.11 Mouse [Logitech USB Optical Mouse] on usb-0001:10:18.0-1.1.2/input0
[    4.187566] usb 1-1.1.4: new low-speed USB device number 5 using ohci_hcd
[    4.298550] usb 1-1.1.4: New USB device found, idVendor=04d9, 
idProduct=0022
[    4.307154] usb 1-1.1.4: New USB device strings: Mfr=0, Product=2, 
SerialNumber=0
[    4.315731] usb 1-1.1.4: Product: USB Keyboard
[    4.325248] firewire_core 0002:20:0e.0: created device fw0: GUID 
000393fffeabd1a6, S400
[    4.344770] input: USB Keyboard as 
/devices/pci0001:10/0001:10:18.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4:1.0/input/input2
[    4.353865] hid-generic 0003:04D9:0022.0002: input,hidraw1: USB HID 
v1.10 Keyboard [USB Keyboard] on usb-0001:10:18.0-1.1.4/input0
[    4.383826] input: USB Keyboard as 
/devices/pci0001:10/0001:10:18.0/usb1/1-1/1-1.1/1-1.1.4/1-1.1.4:1.1/input/input3
[    4.393591] hid-generic 0003:04D9:0022.0003: input,hidraw2: USB HID 
v1.10 Device [USB Keyboard] on usb-0001:10:18.0-1.1.4/input1
[   11.071787] CPU-temp: 58.3 C, Case: 42.0 C,  Fan: 4 (tuned -7)
[   17.491115] EXT3-fs (dm-1): mounted filesystem with writeback data mode
[   17.500095] kjournald starting.  Commit interval 5 seconds
[   19.988537] udevd[844]: starting version 175
[   21.035940] [drm] Initialized drm 1.1.0 20060810
[   21.761861] snd-aoa-fabric-layout: Using direct GPIOs
[   21.789148] i2c i2c-0: aoa_codec_tas: attach_adapter method is deprecated
[   21.798499] i2c i2c-0: Please use another way to instantiate your 
i2c_client
[   21.807708] i2c i2c-1: aoa_codec_tas: attach_adapter method is deprecated
[   21.817284] i2c i2c-1: Please use another way to instantiate your 
i2c_client
[   21.826853] i2c i2c-2: aoa_codec_tas: attach_adapter method is deprecated
[   21.836126] i2c i2c-2: Please use another way to instantiate your 
i2c_client
[   21.836133] snd-aoa-codec-tas: found 'deq' node
[   21.843569] snd-aoa-fabric-layout: can use this codec
[   21.891167] snd-aoa-codec-tas: tas found, addr 0x35 on 
/pci@f2000000/mac-io@17/i2c@18000/deq
[   21.891216] i2c i2c-3: aoa_codec_tas: attach_adapter method is deprecated
[   21.904528] i2c i2c-3: Please use another way to instantiate your 
i2c_client
[   21.914716] i2c i2c-4: aoa_codec_tas: attach_adapter method is deprecated
[   21.924114] i2c i2c-4: Please use another way to instantiate your 
i2c_client
[   22.422901] snd_au8830 0001:10:15.0: enabling device (0004 -> 0007)
[   22.432683] Vortex: init....
[   22.765728] done.
[   25.615272] EXT3-fs (dm-1): using internal journal
[   28.262558] Adding 1048572k swap on /dev/mapper/power--group-swap_1.  
Priority:-1 extents:1 across:1048572k
[   30.133666] kjournald starting.  Commit interval 5 seconds
[   30.142936] EXT3-fs (dm-3): using internal journal
[   30.151909] EXT3-fs (dm-3): mounted filesystem with writeback data mode
[   30.182230] REISERFS (device dm-4): found reiserfs format "3.6" with 
standard journal
[   30.191216] REISERFS (device dm-4): using ordered data mode
[   30.200049] reiserfs: using flush barriers
[   30.214671] REISERFS (device dm-4): journal params: device dm-4, size 
8192, journal first block 18, max trans len 1024, max batch 900, max 
commit age 30, max trans age 30
[   30.226596] REISERFS (device dm-4): checking transaction log (dm-4)
[   30.279661] REISERFS (device dm-4): Using r5 hash to sort names
[   30.562935] EXT4-fs (sdb2): barriers disabled
[   30.577379] EXT4-fs (sdb2): mounted filesystem with writeback data 
mode. Opts: barrier=0,data=writeback
[   32.871229] usb 1-1.1.2: USB disconnect, device number 4
[   35.075732] CPU-temp: 58.8 C, Case: 41.7 C,  Fan: 5 (tuned +1)
[   35.217224] usb 1-1.1.2: new low-speed USB device number 6 using ohci_hcd
[   35.326226] usb 1-1.1.2: New USB device found, idVendor=046d, 
idProduct=c05f
[   35.338929] usb 1-1.1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[   35.352827] usb 1-1.1.2: Product: USB Optical Mouse
[   35.362657] usb 1-1.1.2: Manufacturer: Logitech
[   35.371432] input: Logitech USB Optical Mouse as 
/devices/pci0001:10/0001:10:18.0/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/input/input4
[   35.371620] hid-generic 0003:046D:C05F.0004: input,hidraw0: USB HID 
v1.11 Mouse [Logitech USB Optical Mouse] on usb-0001:10:18.0-1.1.2/input0
[   36.152910] sungem_phy: PHY ID: 2060e1, addr: 0
[   36.153154] gem 0002:20:0f.0: eth0: Found BCM5421 PHY
[   36.164232] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   38.569869] gem 0002:20:0f.0: eth0: Link is up at 100 Mbps, full-duplex
[   38.579574] gem 0002:20:0f.0: eth0: Pause is enabled (rxfifo: 10240 
off: 7168 on: 5632)

On kernel 3.4.5: lspci -vvv

0000:00:0b.0 Host bridge: Apple Inc. UniNorth 2 AGP
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 16, Cache Line Size: 32 bytes
     Capabilities: [80] AGP version 1.0
         Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
     Kernel driver in use: agpgart-uninorth

0000:00:10.0 VGA compatible controller: NVIDIA Corporation NV17 
[GeForce4 MX 420] (rev a3) (prog-if 00 [VGA controller])
     Subsystem: NVIDIA Corporation Device 0008
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 248 (1250ns min, 250ns max)
     Interrupt: pin A routed to IRQ 48
     Region 0: Memory at 91000000 (32-bit, non-prefetchable) [size=16M]
     Region 1: Memory at 98000000 (32-bit, prefetchable) [size=128M]
     Region 2: Memory at f1000000 (32-bit, prefetchable) [size=512K]
     Expansion ROM at 90000000 [disabled] [size=128K]
     Capabilities: [60] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [44] AGP version 2.0
         Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 
64bit- FW+ AGP3- Rate=x1,x2,x4
         Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

0001:10:0b.0 Host bridge: Apple Inc. UniNorth 2 PCI
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 16, Cache Line Size: 32 bytes

0001:10:15.0 Multimedia audio controller: Aureal Semiconductor Vortex 2 
(rev fe)
     Subsystem: Diamond Multimedia Systems Monster Sound II
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 16 (1000ns min, 3000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 58
     Region 0: Memory at 800c0000 (32-bit, non-prefetchable) [size=256K]
     Region 1: I/O ports at 0410 [size=8]
     Region 2: I/O ports at 0400 [size=8]
     Capabilities: [dc] Power Management version 1
         Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: snd_au8830

0001:10:17.0 Unassigned class [ff00]: Apple Inc. KeyLargo Mac I/O (rev 03)
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 16, Cache Line Size: 32 bytes
     Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]
     Kernel driver in use: macio

0001:10:18.0 USB controller: Apple Inc. KeyLargo USB (prog-if 10 [OHCI])
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 16 (750ns min, 21500ns max)
     Interrupt: pin A routed to IRQ 27
     Region 0: Memory at 80081000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci_hcd

0001:10:19.0 USB controller: Apple Inc. KeyLargo USB (prog-if 10 [OHCI])
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 16 (750ns min, 21500ns max)
     Interrupt: pin A routed to IRQ 28
     Region 0: Memory at 80080000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci_hcd

0002:20:0b.0 Host bridge: Apple Inc. UniNorth 2 Internal PCI
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 16, Cache Line Size: 32 bytes

0002:20:0d.0 Unassigned class [ff00]: Apple Inc. UniNorth 2 ATA/100
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+ INTx-
     Latency: 32, Cache Line Size: 32 bytes
     Interrupt: pin ? routed to IRQ 39
     Region 0: Memory at f5004000 (32-bit, non-prefetchable) [size=16K]
     Kernel driver in use: pata-pci-macio

0002:20:0e.0 FireWire (IEEE 1394): Apple Inc. UniNorth 2 FireWire (rev 
01) (prog-if 10 [OHCI])
     Subsystem: Apple Inc. iBook G4 2004
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 64 (3000ns min, 6000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 40
     Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
     Kernel driver in use: firewire_ohci

0002:20:0f.0 Ethernet controller: Apple Inc. UniNorth 2 GMAC (Sun GEM)
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+ INTx-
     Latency: 16 (16000ns min, 16000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 41
     Region 0: Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
     Expansion ROM at f5100000 [disabled] [size=1M]
     Kernel driver in use: gem


cat /proc/ioports
00000000-007fffff : /pci@f2000000
   00000400-00000407 : 0001:10:15.0
     00000400-00000407 : au8830
   00000410-00000417 : 0001:10:15.0
     00000410-00000417 : au8830
00802000-01001fff : /pci@f0000000
   00802000-00802fff : Legacy IO
ff7fe000-ffffdfff : /pci@f4000000
   ff7fe000-ff7fefff : Legacy IO

cat /proc/iomem
00000000-5fffffff : System RAM
80000000-8fffffff : /pci@f2000000
   80000000-8007ffff : 0001:10:17.0
     80000000-8007ffff : 0.80000000:mac-io
       80000050-8000007f : 0.00000050:gpio
       80008000-800080ff : 0.00010000:i2s
         80008000-800080ff : i2sbus: i2s-a (tx)
       80008100-800081ff : 0.00010000:i2s
         80008100-800081ff : i2sbus: i2s-a (rx)
       80008200-800082ff : 0.00010000:i2s
       80008300-800083ff : 0.00010000:i2s
       80008a00-80008aff : 0.0001f000:ata-4
         80008a00-80008aff : pata-macio-dma
       80008b00-80008bff : 0.00020000:ata-3
         80008b00-80008bff : pata-macio-dma
       80010000-80010fff : 0.00010000:i2s
         80010000-80010fff : i2sbus: i2s-a (control)
       80013000-80013000 : 0.00013000:ch-b
         80013000-80013000 : pmac_zilog
       80013010-80013010 : 0.00013000:ch-b
         80013010-80013010 : pmac_zilog
       80013020-80013020 : 0.00013020:ch-a
         80013020-80013020 : pmac_zilog
       80013030-80013030 : 0.00013020:ch-a
         80013030-80013030 : pmac_zilog
       80013040-80013040 : 0.00013000:ch-b
         80013040-80013040 : pmac_zilog
       80013050-80013050 : 0.00013020:ch-a
         80013050-80013050 : pmac_zilog
       80015000-80015fff : 0.00015000:timer
       80016000-80017fff : 0.00016000:via-pmu
       80018000-80018fff : 0.00018000:i2c
       8001f000-8001ffff : 0.0001f000:ata-4
         8001f000-8001ffff : pata-macio
       80020000-80020fff : 0.00020000:ata-3
         80020000-80020fff : pata-macio
       80040000-8007ffff : 0.00040000:interrup
   80080000-80080fff : 0001:10:19.0
     80080000-80080fff : ohci_hcd
   80081000-80081fff : 0001:10:18.0
     80081000-80081fff : ohci_hcd
   800c0000-800fffff : 0001:10:15.0
     800c0000-800fffff : au8830
90000000-afffffff : /pci@f0000000
   90000000-9001ffff : 0000:00:10.0
   91000000-91ffffff : 0000:00:10.0
   98000000-9fffffff : 0000:00:10.0
     98004000-9825bfff : offb
     99000000-9904afff : offb
f1000000-f1ffffff : /pci@f0000000
   f1000000-f107ffff : 0000:00:10.0
f3000000-f3ffffff : /pci@f2000000
f5000000-f5ffffff : /pci@f4000000
   f5000000-f5000fff : 0002:20:0e.0
     f5000000-f5000fff : firewire_ohci
   f5004000-f5007fff : 0002:20:0d.0
     f5004000-f5007fff : pata-macio
   f5100000-f51fffff : 0002:20:0f.0
   f5200000-f53fffff : 0002:20:0f.0
     f5200000-f53fffff : sungem

cat /proc/interrupts
            CPU0       CPU1
  19:     102335     246416   MPIC 1    Level     pata-macio
  20:       1880       4818   MPIC 1    Level     pata-macio
  25:          0          2   MPIC 1    Level     VIA-PMU
  26:          7         49   MPIC 1    Level     keywest i2c
  27:       6878      18995   MPIC 1    Level     ohci_hcd:usb1
  28:          0          1   MPIC 1    Level     ohci_hcd:usb2
  30:          0          0   MPIC 1    Level     i2sbus: i2s-a (control)
  31:          0          0   MPIC 1    Edge      i2sbus: i2s-a (tx)
  33:          0          0   MPIC 1    Edge      i2sbus: i2s-a (rx)
  39:       6376      17040   MPIC 1    Level     pata-pci-macio
  40:          8         14   MPIC 1    Level     firewire_ohci
  41:        752       2018   MPIC 1    Level     eth0
  42:        994       2269   MPIC 1    Level     keywest i2c
  47:          0          0   MPIC 1    Level     GPIO1 ADB
  58:          0          0   MPIC 1    Level     snd_au8830
  60:          0          0   MPIC 1    Edge      lineout-detect
  61:          0          0   MPIC 1    Edge      headphone-detect
123:          0          0   MPIC 1    Edge      ipi call function
124:      20414      17465   MPIC 1    Edge      ipi reschedule
125:       9766       4066   MPIC 1    Edge      ipi call function single
LOC:    1420948    1414212   Local timer interrupts
SPU:          0          3   Spurious interrupts
CNT:          0          0   Performance monitoring interrupts
MCE:          0          0   Machine check exceptions

power-debian:/home/andrey/personal/pbliga/pbliga# cat /proc/cpuinfo
processor    : 0
cpu        : 7455, altivec supported
clock        : 866.666664MHz
revision    : 2.1 (pvr 8001 0201)
bogomips    : 66.60

processor    : 1
cpu        : 7455, altivec supported
clock        : 866.666664MHz
revision    : 2.1 (pvr 8001 0201)
bogomips    : 66.60

total bogomips    : 133.21
timebase    : 33304672
platform    : PowerMac
model        : PowerMac3,6
machine        : PowerMac3,6
motherboard    : PowerMac3,6 MacRISC2 MacRISC Power Macintosh
detected as    : 129 (PowerMac G4 Windtunnel)
pmac flags    : 00000010
L2 cache    : 256K unified
pmac-generation    : NewWorld
Memory        : 1536 MB

Best,
Andrey
