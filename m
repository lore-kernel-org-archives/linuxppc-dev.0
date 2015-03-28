Return-Path: <olaf@aepfle.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 606E01A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2015 00:23:42 +1100 (AEDT)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3004014008F
 for <linuxppc-dev@ozlabs.org>; Sun, 29 Mar 2015 00:23:39 +1100 (AEDT)
Received: from probook.fritz.box ([2001:a60:1085:1c01:1ec1:deff:feb9:bb48])
 by smtp.strato.de (RZmta 37.4 AUTH) with ESMTPSA id J03d24r2SCxHy85
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256))
 (Client did not present a certificate) for <linuxppc-dev@ozlabs.org>;
 Sat, 28 Mar 2015 13:59:17 +0100 (CET)
Date: Sat, 28 Mar 2015 13:59:16 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: nouveau regression on G5 Dual Core
Message-ID: <20150328125916.GA29649@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I just updated the kernel from some 3.18 based state to 4.0-rc5+. The
result is a white screen. Looks like the failure is this, full dmesg
below.

...
[    0.877458] [drm] Initialized drm 1.1.0 20060810
[    0.877849] nouveau  [  DEVICE][0000:0a:00.0] BOOT0  : 0x043100a4
[    0.877853] nouveau  [  DEVICE][0000:0a:00.0] Chipset: NV43 (NV43)
[    0.877856] nouveau  [  DEVICE][0000:0a:00.0] Family : NV40
[    0.878059] nouveau 0000:0a:00.0: Invalid ROM contents
[    0.878074] nouveau ![   VBIOS][0000:0a:00.0] unable to locate usable image
[    0.878079] nouveau E[  DEVICE][0000:0a:00.0] failed to create 0x10000001, -22
[    0.878085] nouveau E[     DRM] failed to create 0x00000080, -22
[    0.878423] nouveau: probe of 0000:0a:00.0 failed with error -22
...

I will try to bisect it during the next days.


Olaf

[    0.000000] Allocated 4096 bytes for 2 pacas at c00000000ffff000
[    0.000000] DART table allocated at: c00000007f000000
[    0.000000] Using PowerMac machine description
[    0.000000] Page orders: linear mapping = 24, virtual = 12, io = 12
[    0.000000] Found initrd at 0xc0000000013d64ba:0xc00000000171b5be
[    0.000000] Found U4 memory controller & host bridge @ 0xf8000000 revision: 0x42
[    0.000000] Mapped at 0xd000080080000000
[    0.000000] Found a Shasta mac-io controller, rev: 0, mapped at 0xd000080080041000
[    0.000000] PowerMac motherboard: PowerMac G5 Dual Core
[    0.000000] DART IOMMU initialized for U4 type chipset
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] Starting Linux PPC64 #2 SMP Sat Mar 28 13:48:35 CET 2015
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x0
[    0.000000] phys_mem_size     = 0x80000000
[    0.000000] cpu_features      = 0x0804806318100448
[    0.000000]   possible        = 0x1f7fffef18500649
[    0.000000]   always          = 0x0000000018100040
[    0.000000] cpu_user_features = 0xdc080000 0x00000000
[    0.000000] mmu_features      = 0x0c000001
[    0.000000] firmware_features = 0x0000000000000000
[    0.000000] htab_address      = 0xc00000007c000000
[    0.000000] htab_hash_mask    = 0x3ffff
[    0.000000] -----------------------------------------------------
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.18-mainline (master@a39bdfb590f54d0f41d6a5b352b085322d007dcd) (gcc version 4.8.1 20130909 [gcc-4_8-branch revision 202388] (SUSE Linux) ) #2 SMP Sat Mar 28 13:48:35 CET 2015
[    0.000000] Found U4-PCIE PCI host bridge.  Firmware bus number: 0->255
[    0.000000] PCI host bridge /pci@0,f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
[    0.000000] Can't get bus-range for /ht@0,f2000000, assume bus 0
[    0.000000] Found U3-HT PCI host bridge.  Firmware bus number: 0->239
[    0.000000] PCI host bridge /ht@0,f2000000 (primary) ranges:
[    0.000000] SMU: Driver 0.7 (c) 2005 Benjamin Herrenschmidt, IBM Corp.
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=282, gen1=283
[    0.000000] nvram: Active bank is: 1
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Top of RAM: 0x80000000, Total RAM: 0x80000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat c0000000008e0900, node_mem_map c00000007a000000
[    0.000000]   DMA zone: 8192 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 524288 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 18 pages/cpu @c00000007ee00000 s33688 r0 d40040 u524288
[    0.000000] pcpu-alloc: s33688 r0 d40040 u524288 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 516096
[    0.000000] Kernel command line: quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 1995976K/2097152K available (7008K kernel code, 1072K rwdata, 1516K rodata, 304K init, 2215K bss, 101176K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] mpic: Resetting
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at f8040000, max 2 CPUs
[    0.000000] mpic: ISU size: 124, shift: 7, mask: 7f
[    0.000000] mpic: Initializing for 124 sources
[    0.000000] mpic: Setting up HT PICs workarounds for U3/U4
[    0.000000] mpic:   - HT:01.0 disabled MSI mapping found @ 0xfee00000
[    0.000000] mpic:   - HT:02.0 disabled MSI mapping found @ 0xfee00000
[    0.000000] mpic:   - HT:03.0 disabled MSI mapping found @ 0xfee00000
[    0.000000] mpic:   - HT:04.0 disabled MSI mapping found @ 0xfee00000
[    0.000000] mpic:   - HT:05.0 disabled MSI mapping found @ 0xfee00000
[    0.000000] mpic:   - HT:06.0 disabled MSI mapping found @ 0xfee00000
[    0.000000] mpic:   - HT:07.0 [0x90] vendor 106b device 0053 has 86 irqs
[    0.000000] time_init: decrementer frequency = 33.333333 MHz
[    0.000000] time_init: processor frequency   = 2300.000000 MHz
[    0.000002] clocksource: timebase mult[1e000005] shift[24] registered
[    0.000006] clockevent: decrementer mult[8888887] shift[32] cpu[0]
[    0.000046] Console: colour dummy device 80x25
[    0.000050] console [tty0] enabled
[    0.000052] bootconsole [udbg0] disabled
[    0.000058] pid_max: default: 32768 minimum: 301
[    0.000096] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000099] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000453] Initializing cgroup subsys blkio
[    0.000460] Initializing cgroup subsys memory
[    0.000474] Initializing cgroup subsys devices
[    0.000478] Initializing cgroup subsys freezer
[    0.000484] Initializing cgroup subsys net_cls
[    0.000489] Initializing cgroup subsys net_prio
[    0.000494] Initializing cgroup subsys debug
[    0.000619] PowerMac SMP probe found 2 cpus
[    0.000701] KeyWest i2c @0xf8001003 irq 16 /u4@0,f8000000/i2c@f8001000
[    0.000704]  channel 1 bus /u4@0,f8000000/i2c@f8001000/i2c-bus@1
[    0.000745] KeyWest i2c @0x80018000 irq 27 /ht@0,f2000000/pci@8/mac-io@7/i2c@18000
[    0.000748]  channel 0 bus /ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0
[    0.000751]  channel 0 bus /ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0
[    0.000782] SMU i2c /smu@0,0/smu-i2c-control@0
[    0.000786]  channel b bus /smu@0,0/smu-i2c-control@0/i2c-bus@b
[    0.000790]  channel e bus /smu@0,0/smu-i2c-control@0/i2c-bus@e
[    0.000804] Processor timebase sync using platform function
[    0.000807] mpic: requesting IPIs...
[    0.002393] Brought up 2 CPUs
[    0.002704] devtmpfs: initialized
[    0.005124] device-tree: Duplicate name in i2c@18000, renamed to "i2c-bus@0#1"
[    0.006762] NET: Registered protocol family 16
[    0.013368] cpuidle: using governor ladder
[    0.019383] cpuidle: using governor menu
[    0.019624] PCI: Probing PCI hardware
[    0.019733] PCI host bridge to bus 0000:00
[    0.019740] pci_bus 0000:00: root bus resource [io  0x10000-0x80ffff] (bus address [0x0000-0x7fffff])
[    0.019744] pci_bus 0000:00: root bus resource [mem 0xf1000000-0xf1ffffff]
[    0.019747] pci_bus 0000:00: root bus resource [mem 0x90000000-0xafffffff]
[    0.019751] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.019757] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[    0.019793] pci 0000:00:0b.0: [106b:005b] type 01 class 0x060400
[    0.019828] PCI: Fixup U4 PCIe bridge range: [mem 0x90000000-0xafffffff]
[    0.019867] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.055638] IOMMU table initialized, virtual merging enabled
[    0.055723] pci 0000:0a:00.0: [10de:0141] type 00 class 0x030000
[    0.055740] pci 0000:0a:00.0: reg 0x10: [mem 0xa1000000-0xa1ffffff]
[    0.055755] pci 0000:0a:00.0: reg 0x14: [mem 0x90000000-0x9fffffff 64bit pref]
[    0.055768] pci 0000:0a:00.0: reg 0x1c: [mem 0xa0000000-0xa0ffffff 64bit]
[    0.055785] pci 0000:0a:00.0: reg 0x30: [mem 0xa2000000-0xa201ffff pref]
[    0.055902] pci 0000:0a:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.055914] pci 0000:00:0b.0: PCI bridge to [bus 0a]
[    0.055921] pci 0000:00:0b.0:   bridge window [io  0x10000-0x1ffff]
[    0.055926] pci 0000:00:0b.0:   bridge window [mem 0x90000000-0xafffffff]
[    0.055933] pci 0000:00:0b.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    0.055973] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 0a
[    0.056053] PCI host bridge to bus 0001:00
[    0.056058] pci_bus 0001:00: root bus resource [io  0x811000-0xc10fff] (bus address [0x0000-0x3fffff])
[    0.056062] pci_bus 0001:00: root bus resource [mem 0xfa000000-0xffffffff]
[    0.056065] pci_bus 0001:00: root bus resource [mem 0x80000000-0x8fffffff]
[    0.056068] pci_bus 0001:00: root bus resource [mem 0xb0000000-0xefffffff]
[    0.056072] pci_bus 0001:00: root bus resource [bus 00-ef]
[    0.056077] pci_bus 0001:00: busn_res: [bus 00-ef] end is updated to ff
[    0.056094] pci 0001:00:00.0: [106b:0074] type 00 class 0x060000
[    0.056179] pci 0001:00:01.0: [1166:0130] type 01 class 0x060400
[    0.056291] pci 0001:00:02.0: [1166:0130] type 01 class 0x060400
[    0.056396] pci 0001:00:03.0: [1166:0132] type 01 class 0x060400
[    0.056498] pci 0001:00:04.0: [1166:0132] type 01 class 0x060400
[    0.056606] pci 0001:00:05.0: [1166:0132] type 01 class 0x060400
[    0.056710] pci 0001:00:06.0: [1166:0132] type 01 class 0x060400
[    0.056815] pci 0001:00:07.0: [106b:0053] type 01 class 0x060400
[    0.056942] pci 0001:00:08.0: [106b:0054] type 01 class 0x060400
[    0.057057] pci 0001:00:09.0: [106b:0055] type 01 class 0x060400
[    0.057252] pci 0001:00:01.0: PCI bridge to [bus 04]
[    0.057327] pci 0001:05:04.0: [14e4:166a] type 00 class 0x020000
[    0.057342] pci 0001:05:04.0: reg 0x10: [mem 0xfa530000-0xfa53ffff 64bit]
[    0.057352] pci 0001:05:04.0: reg 0x18: [mem 0xfa520000-0xfa52ffff 64bit]
[    0.057400] pci 0001:05:04.0: PME# supported from D3hot D3cold
[    0.057477] pci 0001:05:04.1: [14e4:166a] type 00 class 0x020000
[    0.057492] pci 0001:05:04.1: reg 0x10: [mem 0xfa510000-0xfa51ffff 64bit]
[    0.057502] pci 0001:05:04.1: reg 0x18: [mem 0xfa500000-0xfa50ffff 64bit]
[    0.057554] pci 0001:05:04.1: PME# supported from D3hot D3cold
[    0.057628] pci 0001:00:02.0: PCI bridge to [bus 05]
[    0.057636] pci 0001:00:02.0:   bridge window [mem 0xfa500000-0xfa5fffff]
[    0.057709] pci 0001:00:03.0: PCI bridge to [bus 06]
[    0.057771] pci 0001:00:04.0: PCI bridge to [bus 07]
[    0.057831] pci 0001:00:05.0: PCI bridge to [bus 08]
[    0.057893] pci 0001:00:06.0: PCI bridge to [bus 09]
[    0.057969] pci 0001:00:07.0: PCI bridge to [bus 02]
[    0.057978] pci 0001:00:07.0:   bridge window [mem 0xfa000000-0xfa3fffff]
[    0.057984] pci 0001:00:07.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    0.058050] pci 0001:01:07.0: [106b:004f] type 00 class 0xff0000
[    0.058061] pci 0001:01:07.0: reg 0x10: [mem 0x80000000-0x8007ffff]
[    0.058171] pci 0001:01:0b.0: [1033:0035] type 00 class 0x0c0310
[    0.058186] pci 0001:01:0b.0: reg 0x10: [mem 0x80082000-0x80082fff]
[    0.058241] pci 0001:01:0b.0: supports D1 D2
[    0.058244] pci 0001:01:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.058314] pci 0001:01:0b.1: [1033:0035] type 00 class 0x0c0310
[    0.058328] pci 0001:01:0b.1: reg 0x10: [mem 0x80081000-0x80081fff]
[    0.058383] pci 0001:01:0b.1: supports D1 D2
[    0.058386] pci 0001:01:0b.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.058458] pci 0001:01:0b.2: [1033:00e0] type 00 class 0x0c0320
[    0.058473] pci 0001:01:0b.2: reg 0x10: [mem 0x80080000-0x800800ff]
[    0.058532] pci 0001:01:0b.2: supports D1 D2
[    0.058535] pci 0001:01:0b.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.058606] pci 0001:00:08.0: PCI bridge to [bus 01]
[    0.058615] pci 0001:00:08.0:   bridge window [mem 0x80000000-0x800fffff]
[    0.058621] pci 0001:00:08.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    0.058713] pci 0001:03:0c.0: [1166:0240] type 00 class 0x01018f
[    0.058724] pci 0001:03:0c.0: reg 0x10: [io  0x811000-0x811007]
[    0.058732] pci 0001:03:0c.0: reg 0x14: [io  0x811000-0x811003]
[    0.058740] pci 0001:03:0c.0: reg 0x18: [io  0x811000-0x811007]
[    0.058748] pci 0001:03:0c.0: reg 0x1c: [io  0x811000-0x811003]
[    0.058756] pci 0001:03:0c.0: reg 0x20: [io  0x811000-0x81100f]
[    0.058764] pci 0001:03:0c.0: reg 0x24: [mem 0xfa402000-0xfa403fff]
[    0.058845] pci 0001:03:0d.0: [106b:0050] type 00 class 0xff0000
[    0.058854] pci 0001:03:0d.0: reg 0x10: [mem 0xfa404000-0xfa407fff]
[    0.058952] pci 0001:03:0e.0: [106b:0052] type 00 class 0x0c0010
[    0.058966] pci 0001:03:0e.0: reg 0x10: [mem 0xfa400000-0xfa400fff]
[    0.059016] pci 0001:03:0e.0: supports D1 D2
[    0.059019] pci 0001:03:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.059085] pci 0001:00:09.0: PCI bridge to [bus 03]
[    0.059094] pci 0001:00:09.0:   bridge window [mem 0xfa400000-0xfa4fffff]
[    0.059099] pci 0001:00:09.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    0.059152] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 09
[    0.059248] PCI 0000:00 Cannot reserve Legacy IO [io  0x10000-0x10fff]
[    0.059266] pci 0000:00:0b.0: BAR 9: assigned [mem 0xf1000000-0xf10fffff 64bit pref]
[    0.059270] pci 0000:00:0b.0: PCI bridge to [bus 0a]
[    0.059274] pci 0000:00:0b.0:   bridge window [io  0x10000-0x1ffff]
[    0.059280] pci 0000:00:0b.0:   bridge window [mem 0x90000000-0xafffffff]
[    0.059285] pci 0000:00:0b.0:   bridge window [mem 0xf1000000-0xf10fffff 64bit pref]
[    0.059292] pci_bus 0000:00: resource 4 [io  0x10000-0x80ffff]
[    0.059296] pci_bus 0000:00: resource 5 [mem 0xf1000000-0xf1ffffff]
[    0.059299] pci_bus 0000:00: resource 6 [mem 0x90000000-0xafffffff]
[    0.059302] pci_bus 0000:0a: resource 0 [io  0x10000-0x1ffff]
[    0.059306] pci_bus 0000:0a: resource 1 [mem 0x90000000-0xafffffff]
[    0.059309] pci_bus 0000:0a: resource 2 [mem 0xf1000000-0xf10fffff 64bit pref]
[    0.059349] pci 0001:00:01.0: PCI bridge to [bus 04]
[    0.059355] pci 0001:00:02.0: PCI bridge to [bus 05]
[    0.059360] pci 0001:00:02.0:   bridge window [mem 0xfa500000-0xfa5fffff]
[    0.059365] pci 0001:00:03.0: PCI bridge to [bus 06]
[    0.059371] pci 0001:00:04.0: PCI bridge to [bus 07]
[    0.059377] pci 0001:00:05.0: PCI bridge to [bus 08]
[    0.059384] pci 0001:00:06.0: PCI bridge to [bus 09]
[    0.059390] pci 0001:00:07.0: PCI bridge to [bus 02]
[    0.059394] pci 0001:00:07.0:   bridge window [mem 0xfa000000-0xfa3fffff]
[    0.059400] pci 0001:00:08.0: PCI bridge to [bus 01]
[    0.059405] pci 0001:00:08.0:   bridge window [mem 0x80000000-0x800fffff]
[    0.059410] pci 0001:00:09.0: PCI bridge to [bus 03]
[    0.059415] pci 0001:00:09.0:   bridge window [mem 0xfa400000-0xfa4fffff]
[    0.059421] pci_bus 0001:00: resource 4 [io  0x811000-0xc10fff]
[    0.059424] pci_bus 0001:00: resource 5 [mem 0xfa000000-0xffffffff]
[    0.059428] pci_bus 0001:00: resource 6 [mem 0x80000000-0x8fffffff]
[    0.059431] pci_bus 0001:00: resource 7 [mem 0xb0000000-0xefffffff]
[    0.059435] pci_bus 0001:05: resource 1 [mem 0xfa500000-0xfa5fffff]
[    0.059438] pci_bus 0001:02: resource 1 [mem 0xfa000000-0xfa3fffff]
[    0.059442] pci_bus 0001:01: resource 1 [mem 0x80000000-0x800fffff]
[    0.059445] pci_bus 0001:03: resource 1 [mem 0xfa400000-0xfa4fffff]
[    0.059447] PCI: Probing PCI hardware done
[    0.069900] vgaarb: device added: PCI:0000:0a:00.0,decodes=io+mem,owns=none,locks=none
[    0.069931] vgaarb: loaded
[    0.069933] vgaarb: bridge control possible 0000:0a:00.0
[    0.070035] SCSI subsystem initialized
[    0.070100] libata version 3.00 loaded.
[    0.070184] usbcore: registered new interface driver usbfs
[    0.070202] usbcore: registered new interface driver hub
[    0.070221] usbcore: registered new device driver usb
[    0.070243] pps_core: LinuxPPS API ver. 1 registered
[    0.070245] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.070254] PTP clock support registered
[    0.070504] Switched to clocksource timebase
[    0.073275] NET: Registered protocol family 2
[    0.073551] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.073638] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    0.073948] TCP: Hash tables configured (established 16384 bind 16384)
[    0.073983] TCP: reno registered
[    0.073987] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    0.074012] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    0.074112] NET: Registered protocol family 1
[    0.074154] PCI: CLS mismatch (32 != 64), using 128 bytes
[    0.074173] pci 0001:00:03.0: Found enabled HT MSI Mapping
[    0.074181] pci 0001:00:04.0: Found enabled HT MSI Mapping
[    0.074190] pci 0001:00:05.0: Found enabled HT MSI Mapping
[    0.074199] pci 0001:00:06.0: Found enabled HT MSI Mapping
[    0.074229] pci 0001:01:0b.0: enabling device (0000 -> 0002)
[    0.124541] pci 0001:01:0b.1: enabling device (0000 -> 0002)
[    0.175519] pci 0001:01:0b.2: enabling device (0004 -> 0006)
[    0.175628] Unpacking initramfs...
[    0.871523] Freeing initrd memory: 3344K (c0000000013d7000 - c00000000171b000)
[    0.872071] futex hash table entries: 512 (order: 4, 65536 bytes)
[    0.875971] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[    0.876752] cryptomgr_test (30) used greatest stack depth: 13456 bytes left
[    0.876802] cryptomgr_test (31) used greatest stack depth: 13184 bytes left
[    0.876909] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.876967] io scheduler noop registered
[    0.876972] io scheduler deadline registered
[    0.876987] io scheduler cfq registered (default)
[    0.877355] Generic RTC Driver v1.07
[    0.877396] Linux agpgart interface v0.103
[    0.877458] [drm] Initialized drm 1.1.0 20060810
[    0.877849] nouveau  [  DEVICE][0000:0a:00.0] BOOT0  : 0x043100a4
[    0.877853] nouveau  [  DEVICE][0000:0a:00.0] Chipset: NV43 (NV43)
[    0.877856] nouveau  [  DEVICE][0000:0a:00.0] Family : NV40
[    0.878059] nouveau 0000:0a:00.0: Invalid ROM contents
[    0.878074] nouveau ![   VBIOS][0000:0a:00.0] unable to locate usable image
[    0.878079] nouveau E[  DEVICE][0000:0a:00.0] failed to create 0x10000001, -22
[    0.878085] nouveau E[     DRM] failed to create 0x00000080, -22
[    0.878423] nouveau: probe of 0000:0a:00.0 failed with error -22
[    0.878549] MacIO PCI driver attached to Shasta chipset
[    0.879216] windfarm: initializing for dual-core desktop G5
[    1.129773] sata_svw 0001:03:0c.0: version 2.3
[    1.129822] sata_svw 0001:03:0c.0: Using 32-bit DMA via iommu
[    1.130528] scsi host0: sata_svw
[    1.130685] scsi host1: sata_svw
[    1.130824] scsi host2: sata_svw
[    1.130967] scsi host3: sata_svw
[    1.131035] ata1: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402000 irq 18
[    1.131039] ata2: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402100 irq 18
[    1.131042] ata3: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402200 irq 18
[    1.131046] ata4: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402300 irq 18
[    1.131112] pata-pci-macio 0001:03:0d.0: enabling device (0004 -> 0006)
[    1.141512] pata-pci-macio 0001:03:0d.0: Activating pata-macio chipset Shasta ATA-6, Apple bus ID 3
[    1.141816] scsi host4: pata_macio
[    1.141883] ata5: PATA max UDMA/133 irq 38
[    1.141951] tg3.c:v3.137 (May 11, 2014)
[    1.148958] tg3 0001:05:04.0: Using 32-bit DMA via iommu
[    1.149258] tg3 0001:05:04.0 eth0: Tigon3 [partno(BCM95780) rev 8003] (PCIX:133MHz:64-bit) MAC address 00:14:51:68:b7:00
[    1.149263] tg3 0001:05:04.0 eth0: attached PHY is 5780 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    1.149266] tg3 0001:05:04.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.149270] tg3 0001:05:04.0 eth0: dma_rwctrl[76144000] dma_mask[40-bit]
[    1.158402] tg3 0001:05:04.1: Using 32-bit DMA via iommu
[    1.158664] tg3 0001:05:04.1 eth1: Tigon3 [partno(BCM95780) rev 8003] (PCIX:133MHz:64-bit) MAC address 00:14:51:68:b7:01
[    1.158668] tg3 0001:05:04.1 eth1: attached PHY is 5780 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    1.158672] tg3 0001:05:04.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.158676] tg3 0001:05:04.1 eth1: dma_rwctrl[76144000] dma_mask[40-bit]
[    1.158730] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.158760] ehci-pci: EHCI PCI platform driver
[    1.158830] ehci-pci 0001:01:0b.2: EHCI Host Controller
[    1.158841] ehci-pci 0001:01:0b.2: new USB bus registered, assigned bus number 1
[    1.158899] ehci-pci 0001:01:0b.2: irq 70, io mem 0x80080000
[    1.164510] ehci-pci 0001:01:0b.2: USB 2.0 started, EHCI 1.00
[    1.164758] hub 1-0:1.0: USB hub found
[    1.164769] hub 1-0:1.0: 5 ports detected
[    1.165048] ehci-platform: EHCI generic platform driver
[    1.165075] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.165101] ohci-pci: OHCI PCI platform driver
[    1.165133] ohci-pci 0001:01:0b.0: OHCI PCI host controller
[    1.165141] ohci-pci 0001:01:0b.0: new USB bus registered, assigned bus number 2
[    1.165171] ohci-pci 0001:01:0b.0: irq 70, io mem 0x80082000
[    1.235537] hub 2-0:1.0: USB hub found
[    1.235550] hub 2-0:1.0: 3 ports detected
[    1.235738] ohci-pci 0001:01:0b.1: OHCI PCI host controller
[    1.235746] ohci-pci 0001:01:0b.1: new USB bus registered, assigned bus number 3
[    1.235776] ohci-pci 0001:01:0b.1: irq 70, io mem 0x80081000
[    1.306525] hub 3-0:1.0: USB hub found
[    1.306538] hub 3-0:1.0: 2 ports detected
[    1.306697] i2c /dev entries driver
[    1.306797] PowerMac i2c bus smu 14 registered
[    1.306884] PowerMac i2c bus smu 11 registered
[    1.307067] PowerMac i2c bus mac-io 0 registered
[    1.307170] PowerMac i2c bus mac-io 0 registered
[    1.307306] PowerMac i2c bus u4 1 registered
[    1.312881] ata5.00: ATAPI: HL-DT-ST DVD-RW GWA-4165B, C006, max UDMA/66
[    1.318510] Registering G5 CPU frequency driver
[    1.318513] Frequency method: SCOM, Voltage method: GPIO
[    1.318516] Low: 1150 Mhz, High: 2300 Mhz, Cur: 2300 MHz
[    1.318602] hidraw: raw HID events driver (C) Jiri Kosina
[    1.318793] usbcore: registered new interface driver usbhid
[    1.318795] usbhid: USB HID core driver
[    1.318879] TCP: cubic registered
[    1.319109] NET: Registered protocol family 10
[    1.319515] NET: Registered protocol family 17
[    1.319532] Key type dns_resolver registered
[    1.319763] registered taskstats version 1
[    1.334894] ata5.00: configured for UDMA/66
[    1.435568] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.438861] ata1.00: ATA-7: WDC WD2500JS-41MVB1, 10.02E01, max UDMA/133
[    1.438868] ata1.00: 488397168 sectors, multi 16: LBA48 
[    1.441854] ata1.00: configured for UDMA/133
[    1.442196] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500JS-41M 2E01 PQ: 0 ANSI: 5
[    1.442805] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
[    1.442817] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.442950] sd 0:0:0:0: [sda] Write Protect is off
[    1.442960] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.443045] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.458491]  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
[    1.459950] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.728535] usb 3-1: new full-speed USB device number 2 using ohci-pci
[    1.747561] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.752089] ata2.00: ATA-7: Maxtor 6V250F0, VA111630, max UDMA/133
[    1.752096] ata2.00: 490234752 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    1.758858] ata2.00: configured for UDMA/133
[    1.759036] scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6V250F0   1630 PQ: 0 ANSI: 5
[    1.759469] sd 1:0:0:0: [sdb] 490234752 512-byte logical blocks: (251 GB/233 GiB)
[    1.759544] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.759614] sd 1:0:0:0: [sdb] Write Protect is off
[    1.759623] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.759740] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.784142]  sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12
[    1.785802] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.878532] windfarm: CPUs control loops started.
[    1.922646] hub 3-1:1.0: USB hub found
[    1.925571] hub 3-1:1.0: 3 ports detected
[    2.225570] usb 3-1.2: new low-speed USB device number 3 using ohci-pci
[    2.339136] input: Mitsumi Electric Apple Optical USB Mouse as /devices/pci0001:00/0001:00:08.0/0001:01:0b.1/usb3/3-1/3-1.2/3-1.2:1.0/0003:05AC:0304.0001/input/input0
[    2.339246] apple 0003:05AC:0304.0001: input,hidraw0: USB HID v1.10 Mouse [Mitsumi Electric Apple Optical USB Mouse] on usb-0001:01:0b.1-1.2/input0
[    2.410568] usb 3-1.3: new full-speed USB device number 4 using ohci-pci
[    2.527471] input: Mitsumi Electric Apple Extended USB Keyboard as /devices/pci0001:00/0001:00:08.0/0001:01:0b.1/usb3/3-1/3-1.3/3-1.3:1.0/0003:05AC:020B.0002/input/input1
[    2.577619] hid-generic 0003:05AC:020B.0002: input,hidraw1: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:01:0b.1-1.3/input0
[    2.588712] input: Mitsumi Electric Apple Extended USB Keyboard as /devices/pci0001:00/0001:00:08.0/0001:01:0b.1/usb3/3-1/3-1.3/3-1.3:1.1/0003:05AC:020B.0003/input/input2
[    2.639619] hid-generic 0003:05AC:020B.0003: input,hidraw2: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:01:0b.1-1.3/input1
[    2.705321] sat 0 partition c8: c8 6 2 7f ff 2 ff 1 fb bf 0 41 0 20 0 0 0 7 89 37 0 a0 0 0
[    2.766527] ata3: failed to resume link (SControl 0)
[    2.766560] ata3: SATA link down (SStatus 0 SControl 0)
[    3.324834] sat 0 partition c4: c4 4 1 7f 22 11 e0 e6 ff 55 7b 12 ec 11 0 0
[    3.773525] ata4: failed to resume link (SControl 0)
[    3.773559] ata4: SATA link down (SStatus 0 SControl 0)
[    3.777453] scsi 4:0:0:0: CD-ROM            HL-DT-ST DVD-RW GWA-4165B C006 PQ: 0 ANSI: 5
[    3.777472] ata5.00: K2/Shasta alignment limits applied
[    3.806516] sr 4:0:0:0: [sr0] scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[    3.806523] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.806849] sr 4:0:0:0: Attached scsi CD-ROM sr0
[    3.807001] sr 4:0:0:0: Attached scsi generic sg2 type 5
[    3.807475] Freeing unused kernel memory: 304K (c00000000085b000 - c0000000008a7000)
[    3.823120] mount (57) used greatest stack depth: 11072 bytes left
[    3.857974] ln (66) used greatest stack depth: 11024 bytes left
[    3.862965] ln (68) used greatest stack depth: 10368 bytes left
[    3.886728] device-mapper: uevent: version 1.0.3
[    3.886876] device-mapper: ioctl: 4.30.0-ioctl (2014-12-22) initialised: dm-devel@redhat.com
[    3.887317] modprobe (77) used greatest stack depth: 10224 bytes left
[    3.899433] systemd-udevd[83]: starting version 208
[    3.918375] udevadm (84) used greatest stack depth: 9888 bytes left
[    3.995264] ata_id (101) used greatest stack depth: 9024 bytes left
[    4.098364] random: nonblocking pool is initialized
[    4.155252] sat 0 partition c9: c9 6 2 7f ff 2 ff 1 fb bf 0 41 0 20 0 0 0 7 89 37 0 a0 0 0
[    4.778729] sat 0 partition c5: c5 4 1 7f 22 11 e0 e6 ff 55 7b 12 ec 11 0 0
[    5.136615] XFS (sdb11): Mounting V4 Filesystem
[    5.156290] windfarm: Backside control loop started.
[    5.206861] windfarm: Slots control loop started.
[    5.307872] windfarm: Drive bay control loop started.
[    5.510702] XFS (sdb11): Ending clean mount
[    5.512753] mount (157) used greatest stack depth: 8480 bytes left
[    5.781546] udevd (96) used greatest stack depth: 8064 bytes left
[    6.593488] modprobe (180) used greatest stack depth: 7872 bytes left
[    6.684936] systemd[1]: systemd 208 running in system mode. (+PAM +LIBWRAP +AUDIT +SELINUX -IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ)
[    6.737694] systemd[1]: Inserted module 'autofs4'
[    6.749490] systemd[1]: Set hostname to <g5>.
[    7.111377] LVM: Logical Volume autoactivation enabled.
[    7.111448] LVM: Activation generator successfully completed.
[    8.035378] systemd[1]: Starting Replay Read-Ahead Data...
[    8.038082] systemd[1]: Starting Collect Read-Ahead Data...
[    8.039740] systemd[1]: Starting Syslog Socket.
[    8.039876] systemd[1]: Listening on Syslog Socket.
[    8.039956] systemd[1]: Starting Remote File Systems (Pre).
[    8.039991] systemd[1]: Reached target Remote File Systems (Pre).
[    8.040036] systemd[1]: Starting Remote File Systems.
[    8.040066] systemd[1]: Reached target Remote File Systems.
[    8.040152] systemd[1]: Starting Delayed Shutdown Socket.
[    8.040226] systemd[1]: Listening on Delayed Shutdown Socket.
[    8.040269] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[    8.040342] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    8.040372] systemd[1]: Starting LVM2 metadata daemon socket.
[    8.040462] systemd[1]: Listening on LVM2 metadata daemon socket.
[    8.040736] systemd[1]: Starting udev Kernel Socket.
[    8.040817] systemd[1]: Listening on udev Kernel Socket.
[    8.040872] systemd[1]: Starting udev Control Socket.
[    8.040942] systemd[1]: Listening on udev Control Socket.
[    8.041000] systemd[1]: Starting Journal Socket.
[    8.041146] systemd[1]: Listening on Journal Socket.
[    8.041476] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    8.043107] systemd[1]: Starting Create dynamic rule for /dev/root link...
[    8.044544] systemd[1]: Starting Journal Service...
[    8.046183] systemd[1]: Started Journal Service.
[    8.063108] systemd-readahead[190]: Bumped block_nr parameter of 8:16 to 20480. This is a temporary hack and should be removed one day.
[    8.718613] systemd-journald[194]: Vacuuming done, freed 0 bytes
[    9.640103] systemd-udevd[232]: starting version 208
[    9.681143] systemd-journald[194]: Received request to flush runtime journal from PID 1
[   10.037178] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[   10.037306] 0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 23, base_baud = 230400) is a Z85c30 ESCC - Serial port
[   10.037753] 0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 24, base_baud = 230400) is a Z85c30 ESCC - Serial port
[   10.289034] mousedev: PS/2 mouse device common for all mice
[   10.332944] firewire_ohci 0001:03:0e.0: enabling device (0000 -> 0002)
[   10.384625] firewire_ohci 0001:03:0e.0: added OHCI v1.0 device as card 0, 8 IR + 8 IT contexts, quirks 0x0
[   10.886845] firewire_core 0001:03:0e.0: created device fw0: GUID 001451fffea8daae, S800
[   10.886862] firewire_core 0001:03:0e.0: phy config: new root=ffc1, gap_count=5
[   10.891443] snd-aoa-codec-onyx: created and attached onyx instance
[   10.891978] snd-aoa-codec-onyx: created and attached onyx instance
[   13.537556] u3msi: allocated virq 0x19 (hw 0x8) addr 0xfee00000
[   13.565471] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   15.366223] tg3 0001:05:04.0 eth0: Link is up at 100 Mbps, full duplex
[   15.366245] tg3 0001:05:04.0 eth0: Flow control is on for TX and on for RX
[   15.366277] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
