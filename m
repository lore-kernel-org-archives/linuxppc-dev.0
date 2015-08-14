Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 6EDB71A0779
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 23:15:59 +1000 (AEST)
Received: from exch2.transmode.se (exch2.transmode.se [192.168.203.24])
 by smtp.transmode.se (Postfix) with ESMTP id 437391186FC6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:15:53 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: PCI not working in 4.1 for p2010rdb(Freescale) based board
Date: Fri, 14 Aug 2015 13:15:52 +0000
Message-ID: <1439558152.3120.207.camel@transmode.se>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I upgraded our kernel for our custom p2010rdb based board from 3.4 to 4.1 a=
nd I cannot get the
PCI controller to work, it is not initialized as can be seem by the below d=
mesg fro 3.4 and 4.1.
Sorry to say, PCI is not my cup of tea so I don't not know how to find the =
culprit.
I have checked what I can but nothing stands out and I would appreciate som=
e help/pointers

dmesg for 4.1:
[    0.000000] Using P2010 RDB machine description
[    0.000000] Memory CAM mapping: 256/256 Mb, residual: 0Mb
[    0.000000] Linux version 4.1.0+ (jocke@gentoo-jocke) (gcc version 4.5.3=
 (Gentoo 4.5.3-r2 p1.6, pie-0.4.7) ) #102 Thu Aug 13 21:23:04 CEST 2015
[    0.000000] Found legacy serial port 0 for /soc@ff700000/serial@4500
[    0.000000]   mem=3Dff704500, taddr=3Dff704500, irq=3D0, clk=3D600000000=
, speed=3D0
[    0.000000] Found legacy serial port 1 for /soc@ff700000/serial@4600
[    0.000000]   mem=3Dff704600, taddr=3Dff704600, irq=3D0, clk=3D600000000=
, speed=3D0
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] E500 platform from Transmode Systems AB
[    0.000000] Top of RAM: 0x20000000, Total RAM: 0x20000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000001fffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000001fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001ffff=
fff]
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c03c8b10, node_mem_map df=
5ec000
[    0.000000]   DMA zone: 1024 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 131072 pages, LIFO batch:31
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 130048
[    0.000000] Kernel command line: root=3D/dev/mtdblock6 rw rootfstype=3Dj=
ffs2 ip=3D172.18.2.61:192.168.201.63:172.18.0.1:255.255.0.0:P2020RDB:eth0:o=
ff console=3DttyS0,115200
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 443652K/524288K available (2984K kernel code, 108K r=
wdata, 664K rodata, 152K init, 126K bss, 80636K reserved, 0K cma-reserved)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffdf000..0xfffff000  : fixmap
[    0.000000]   * 0xfdffe000..0xfe000000  : early ioremap
[    0.000000]   * 0xe1000000..0xfdffe000  : vmalloc & ioremap
[    0.000000] NR_IRQS:128 nr_irqs:128 16
[    0.000000] mpic: Resetting
[    0.000000] mpic: Setting up MPIC " OpenPIC  " version 1.2 at ff740000, =
max 1 CPUs
[    0.000000] mpic: ISU size: 256, shift: 8, mask: ff
[    0.000000] mpic: Initializing for 256 sources
[    0.000000] time_init: decrementer frequency =3D 75.000000 MHz
[    0.000000] time_init: processor frequency   =3D 1200.000000 MHz
[    0.000007] clocksource timebase: mask: 0xffffffffffffffff max_cycles: 0=
x114c1bade8, max_idle_ns: 440795203839 ns
[    0.010184] clocksource: timebase mult[d555555] shift[24] registered
[    0.016531] clockevent: decrementer mult[13333333] shift[32] cpu[0]
[    0.016616] pid_max: default: 32768 minimum: 301
[    0.021202] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.027754] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes)
[    0.036855] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 7645041785100000 ns
[    0.046775] NET: Registered protocol family 16
[    0.055827] spidev registred.
[    0.064391] PCI: Probing PCI hardware
[    0.067979] PCI: Assigning unassigned resources...
[    0.068068] Registering qe_ic with sysfs...
[    0.071912] pps_core: LinuxPPS API ver. 1 registered
[    0.076804] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.086152] PTP clock support registered
[    0.090408] Switched to clocksource timebase
[    0.095368] NET: Registered protocol family 2
[    0.100202] TCP established hash table entries: 4096 (order: 2, 16384 by=
tes)
[    0.107199] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.113626] TCP: Hash tables configured (established 4096 bind 4096)
[    0.120013] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.125781] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.132109] NET: Registered protocol family 1
[    0.136405] PCI: CLS 0 bytes, default 32
[    0.141059] Setting up Freescale MSI support
[    0.141551] Adding PCI host bridge /pcie@ff70a000
[    0.141561] PCI memory map start 0x00000000ff70a000, size 0x000000000000=
1000
[    0.141578] Found FSL PCI host bridge at 0x00000000ff70a000. Firmware bu=
s number: 0->1
[    0.149423]  ->Hose at 0xdb0d5a00, cfg_addr=3D0xe1020000,cfg_data=3D0xe1=
020004
[    0.149427] PCI host bridge /pcie@ff70a000 (primary) ranges:
[    0.155066]  MEM 0x0000000080000000..0x000000009fffffff -> 0x00000000800=
00000=20
[    0.162279]   IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x00000000000=
00000
[    0.169659] PCI MEM resource start 0x0000000080000000, size 0x0000000020=
000000.
[    0.169665] PCI IO resource start 0x0000000000000000, size 0x00000000000=
10000, phy base 0x00000000ffc00000.
[    0.169671] /pcie@ff70a000: PCICSRBAR @ 0xfff00000
[    0.179635] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.186075] jffs2: version 2.2. =A9 2001-2006 Red Hat, Inc.
[    0.191672] io scheduler noop registered (default)
[    0.196526] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.202109] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.208754] Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
[    0.215254] console [ttyS0] disabled
[    0.218849] serial8250.0: ttyS0 at MMIO 0xff704500 (irq =3D 42, base_bau=
d =3D 37500000) is a 16550A
[    0.227481] console [ttyS0] enabled
[    0.234423] bootconsole [udbg0] disabled
[    0.242395] serial8250.0: ttyS1 at MMIO 0xff704600 (irq =3D 42, base_bau=
d =3D 37500000) is a 16550A
.....

---------------------------------------------------------------------------=
---

old 3.4 dmesg:
Using P2010 RDB machine description
Memory CAM mapping: 256/256 Mb, residual: 0Mb
Linux version 3.4.0+ (jocke@gentoo-jocke) (gcc version 4.5.3 (Gentoo 4.5.3-=
r2 p1.6, pie-0.4.7) ) #25 Thu Apr 23 15:44:23 CEST 2015
Found legacy serial port 0 for /soc@ff700000/serial@4500
  mem=3Dff704500, taddr=3Dff704500, irq=3D0, clk=3D600000000, speed=3D0
Found legacy serial port 1 for /soc@ff700000/serial@4600
  mem=3Dff704600, taddr=3Dff704600, irq=3D0, clk=3D600000000, speed=3D0
bootconsole [udbg0] enabled
Found FSL PCI host bridge at 0x00000000ff70a000. Firmware bus number: 0->0
PCI host bridge /pcie@ff70a000  ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000=20
  IO 0x00000000ffc00000..0x00000000ffc0ffff -> 0x0000000000000000
/pcie@ff70a000: PCICSRBAR @ 0xfff00000
E500 platform from Transmode Systems AB
Top of RAM: 0x20000000, Total RAM: 0x20000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00020000
  Normal   empty
Movable zone start PFN for each node
Early memory PFN ranges
    0: 0x00000000 -> 0x00020000
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c038988c, node_mem_map c03bc000
  DMA zone: 1024 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 130048 pages, LIFO batch:31
MMU: Allocated 1088 bytes of context maps for 255 contexts
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0=20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=3D/dev/mtdblock6 rw rootfstype=3Djffs2 ip=3D172.1=
8.2.61:192.168.201.63:172.18.0.1:255.255.0.0:P2020RDB:eth0:off console=3Dtt=
yS0,115200
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 509708k/524288k available (3548k kernel code, 14580k reserved, 140k=
 data, 126k bss, 156k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfdfec000..0xfe000000  : early ioremap
  * 0xe1000000..0xfdfec000  : vmalloc & ioremap
NR_IRQS:128 nr_irqs:128 16
mpic: Resetting
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ff740000, max 1 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
time_init: decrementer frequency =3D 75.000000 MHz
time_init: processor frequency   =3D 1200.000000 MHz
clocksource: timebase mult[d555555] shift[24] registered
clockevent: decrementer mult[13333333] shift[32] cpu[0]
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
gpiochip_add: registered GPIOs 224 to 255 on device: /soc@ff700000/gpio-con=
troller@f000
PCI: Probing PCI hardware
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0xfdfed000-0xfdffcfff] (bus address=
 [0x0000-0xffff])
pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]
pci 0000:00:00.0: [1957:0079] type 01 class 0x0b2000
pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't match header type 01)
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: [14e4:b541] type 00 class 0x020000
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x0003ffff 64bit]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
PCI 0000:00 Cannot reserve Legacy IO [io  0xfdfed000-0xfdfedfff]
pci 0000:01:00.0: BAR 0: assigned [mem 0x80000000-0x8003ffff 64bit]
pci 0000:00:00.0: PCI bridge to [bus 01-01]
pci 0000:00:00.0:   bridge window [io  0xfdfed000-0xfdffcfff]
pci 0000:00:00.0:   bridge window [mem 0x80000000-0x9fffffff]
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci_bus 0000:00: resource 4 [io  0xfdfed000-0xfdffcfff]
pci_bus 0000:00: resource 5 [mem 0x80000000-0x9fffffff]
pci_bus 0000:01: resource 0 [io  0xfdfed000-0xfdffcfff]
pci_bus 0000:01: resource 1 [mem 0x80000000-0x9fffffff]
Registering qe_ic with sysfs...
bio: create slab <bio-0> at 0
Switching to clocksource timebase

.....=
