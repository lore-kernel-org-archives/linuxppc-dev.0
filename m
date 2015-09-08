Return-Path: <nick@edi.schmalenberger.us>
Received: from edi.schmalenberger.us (edi.schmalenberger.us
 [IPv6:2605:2700:0:19::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BF411A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 14:54:53 +1000 (AEST)
Date: Mon, 7 Sep 2015 21:54:49 -0700
From: Nick Schmalenberger <nick@schmalenberger.us>
To: linuxppc-dev@lists.ozlabs.org
Subject: i2c i2c-2: I2C write to 0x2d failed, err -27 on Xserve G5
Message-ID: <20150908045449.GE8935@edi.schmalenberger.us>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZwgA9U+XZDXt4+m+"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,
I'm running this kernel:
[  +0.000000] Linux version 3.16.0-4-powerpc64
(debian-kernel@lists.debian.org) (gcc version 4.8.4 (Debian
4.8.4-1) ) #1 SMP Debian 3.16.7-ckt11-1+deb8u3 (2015-08-04)

on my Xserve G5, and it works great except these messages keep
coming in dmesg:
[Sep 4 19:11] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 19:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 20:04] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 20:29] i2c i2c-2: I2C write to 0x2d failed, err -27

Is this a known problem, or has been fixed in a newer version
since this branch in Debian? I see in the mailing list, there are
some i2c related fixes. I can run a kernel.org kernel + apply
patches if that should help. See attached full dmesg and lspci 
for more details. Thanks!  
-Nick

--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="20150904-edi-dmesg.txt"

[Aug31 20:54] Allocated 131072 bytes for 32 pacas at c00000000ffe0000
[  +0.000000] DART table allocated at: c00000007f000000
[  +0.000000] Using PowerMac machine description
[  +0.000000] Page orders: linear mapping = 24, virtual = 12, io = 12, vmemmap = 24
[  +0.000000] kvm_cma: CMA: reserved 256 MiB
[  +0.000000] Found initrd at 0xc000000001a00000:0xc000000002c04c00
[  +0.000000] Found U3 memory controller & host bridge @ 0xf8000000 revision: 0x35
[  +0.000000] Mapped at 0xd000080080000000
[  +0.000000] Found a K2 mac-io controller, rev: 96, mapped at 0xd000080080050000
[  +0.000000] PowerMac motherboard: XServe G5
[  +0.000000] boot stdout isn't a display !
[  +0.000000] DART IOMMU initialized for U3 type chipset
[  +0.000000] bootconsole [udbg0] enabled
[  +0.000000] CPU maps initialized for 1 thread per core
[  +0.000000]  (thread shift is 0)
[  +0.000000] Freed 65536 bytes for unused pacas
[  +0.000000] Starting Linux PPC64 #1 SMP Debian 3.16.7-ckt11-1+deb8u3 (2015-08-04)
[  +0.000000] -----------------------------------------------------
[  +0.000000] ppc64_pft_size                = 0x0
[  +0.000000] physicalMemorySize            = 0x100000000
[  +0.000000] htab_address                  = 0xc00000017c000000
[  +0.000000] htab_hash_mask                = 0x7ffff
[  +0.000000] -----------------------------------------------------
[  +0.000000] Initializing cgroup subsys cpuset
[  +0.000000] Initializing cgroup subsys cpu
[  +0.000000] Initializing cgroup subsys cpuacct
[  +0.000000] Linux version 3.16.0-4-powerpc64 (debian-kernel@lists.debian.org) (gcc version 4.8.4 (Debian 4.8.4-1) ) #1 SMP Debian 3.16.7-ckt11-1+deb8u3 (2015-08-04)
[  +0.000000] [boot]0012 Setup Arch
[  +0.000000] Top of RAM: 0x180000000, Total RAM: 0x100000000
[  +0.000000] Memory hole size: 2048MB
[  +0.000000] Found U3-AGP PCI host bridge.  Firmware bus number: 240->255
[  +0.000000] PCI host bridge /pci@0,f0000000  ranges:
[  +0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[  +0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[  +0.000000]  MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000 
[  +0.000000] Can't get bus-range for /ht@0,f2000000, assume bus 0
[  +0.000000] Found U3-HT PCI host bridge.  Firmware bus number: 0->239
[  +0.000000] PCI host bridge /ht@0,f2000000 (primary) ranges:
[  +0.000000] via-pmu: Server Mode is enabled
[  +0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[  +0.000000] nvram: Checking bank 0...
[  +0.000000] nvram: gen0=58, gen1=59
[  +0.000000] nvram: Active bank is: 1
[  +0.000000] nvram: OF partition at 0x410
[  +0.000000] nvram: XP partition at 0x1020
[  +0.000000] nvram: NR partition at 0x1120
[  +0.000000] Zone ranges:
[  +0.000000]   DMA      [mem 0x00000000-0x17fffffff]
[  +0.000000]   Normal   empty
[  +0.000000] Movable zone start for each node
[  +0.000000] Early memory node ranges
[  +0.000000]   node   0: [mem 0x00000000-0x7fffffff]
[  +0.000000]   node   0: [mem 0x100000000-0x17fffffff]
[  +0.000000] On node 0 totalpages: 65536
[  +0.000000]   DMA zone: 56 pages used for memmap
[  +0.000000]   DMA zone: 0 pages reserved
[  +0.000000]   DMA zone: 65536 pages, LIFO batch:1
[  +0.000000] [boot]0015 Setup Done
[  +0.000000] PERCPU: Embedded 2 pages/cpu @c000000002e00000 s101120 r0 d29952 u524288
[  +0.000000] pcpu-alloc: s101120 r0 d29952 u524288 alloc=1*1048576
[  +0.000000] pcpu-alloc: [0] 0 1 
[  +0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 65480
[  +0.000000] Policy zone: DMA
[  +0.000000] Kernel command line: root=/dev/mapper/edi_volumes-edi_root ro console=ttyPZ0,57600n8 
[  +0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[  +0.000000] Sorting __ex_table...
[  +0.000000] Memory: 3799296K/4194304K available (7360K kernel code, 1792K rwdata, 1840K rodata, 960K init, 2071K bss, 395008K reserved)
[  +0.000000] Hierarchical RCU implementation.
[  +0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[  +0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[  +0.000000] 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=2.
[  +0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[  +0.000000] NR_IRQS:512 nr_irqs:512 16
[  +0.000000] mpic: Resetting
[  +0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 2 CPUs
[  +0.000000] mpic: ISU size: 120, shift: 7, mask: 7f
[  +0.000000] mpic: Initializing for 120 sources
[  +0.000000] mpic: Resetting
[  +0.000000] mpic: Setting up MPIC " MPIC 2   " version 1.2 at f8040000, max 2 CPUs
[  +0.000000] mpic: ISU size: 124, shift: 7, mask: 7f
[  +0.000000] mpic: Initializing for 124 sources
[  +0.000000] /u3@0,f8000000/mpic@f8040000: hooking up to IRQ 56
[  +0.000000] time_init: decrementer frequency = 33.333333 MHz
[  +0.000000] time_init: processor frequency   = 2000.000000 MHz
[  +0.000000] clocksource: timebase mult[1e000005] shift[24] registered
[  +0.012510] clockevent: decrementer mult[8888887] shift[32] cpu[0]
[  +0.000460] Console: colour dummy device 80x25
[  +0.008795] console [ttyPZ0] enabled
[  +0.013897] bootconsole [udbg0] disabled
[  +0.015681] mempolicy: Disabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[  +0.022172] pid_max: default: 32768 minimum: 301
[  +0.009761] Security Framework initialized
[  +0.007965] AppArmor: AppArmor disabled by boot time parameter
[  +0.011614] Yama: disabled by default; enable with sysctl kernel.yama.*
[  +0.013292] Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
[  +0.018134] Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
[  +0.015794] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
[  +0.013050] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
[  +0.015087] Initializing cgroup subsys memory
[  +0.008805] Initializing cgroup subsys devices
[  +0.008564] Initializing cgroup subsys freezer
[  +0.008809] Initializing cgroup subsys net_cls
[  +0.008858] Initializing cgroup subsys blkio
[  +0.008508] Initializing cgroup subsys perf_event
[  +0.009370] Initializing cgroup subsys net_prio
[  +0.009095] ftrace: allocating 20397 entries in 8 pages
[  +0.031979] PowerMac SMP probe found 2 cpus
[  +0.008409] KeyWest i2c @0xf8001003 irq 16 /u3@0,f8000000/i2c@f8001000
[  +0.012879]  channel 0 bus <multibus>
[  +0.007288]  channel 1 bus <multibus>
[  +0.007350] KeyWest i2c @0x80018000 irq 26 /ht@0,f2000000/pci@3/mac-io@7/i2c@18000
[  +0.015048]  channel 0 bus <multibus>
[  +0.007424] PMU i2c /ht@0,f2000000/pci@3/mac-io@7/via-pmu@16000/pmu-i2c
[  +0.013072]  channel 1 bus <multibus>
[  +0.007281]  channel 2 bus <multibus>
[  +0.007383] Processor timebase sync using Pulsar i2c clock
[  +0.010851] mpic: requesting IPIs...
[  +0.007233] PPC970/FX/MP performance monitor hardware support registered
[  +0.070952] Brought up 2 CPUs
[  +0.011698] devtmpfs: initialized
[  +0.069233] EEH: devices created
[  +0.014315] NET: Registered protocol family 16
[  +0.008554] eeh_init: Platform EEH operation not found
[  +0.010313] IBM eBus Device Driver
[  +0.007175] cpuidle: using governor ladder
[  +0.007834] cpuidle: using governor menu
[  +0.010270] PCI: Probing PCI hardware
[  +0.007073] PCI host bridge to bus 0000:f0
[  +0.008043] pci_bus 0000:f0: root bus resource [io  0x10000-0x80ffff] (bus address [0x0000-0x7fffff])
[  +0.018399] pci_bus 0000:f0: root bus resource [mem 0xf1000000-0xf1ffffff]
[  +0.013715] pci_bus 0000:f0: root bus resource [mem 0xa0000000-0xafffffff]
[  +0.013717] pci_bus 0000:f0: root bus resource [bus f0-ff]
[  +0.010944] pci_bus 0000:f0: busn_res: [bus f0-ff] end is updated to ff
[  +0.000027] pci 0000:f0:0b.0: [106b:0059] type 00 class 0x060000
[  +0.041058] IOMMU table initialized, virtual merging enabled
[  +0.010946] pci_bus 0000:f0: busn_res: [bus f0-ff] end is updated to f0
[  +0.000098] PCI host bridge to bus 0001:00
[  +0.008061] pci_bus 0001:00: root bus resource [io  0x820000-0xc1ffff] (bus address [0x0000-0x3fffff])
[  +0.018579] pci_bus 0001:00: root bus resource [mem 0xfa000000-0xffffffff]
[  +0.013714] pci_bus 0001:00: root bus resource [mem 0x80000000-0x9fffffff]
[  +0.013717] pci_bus 0001:00: root bus resource [mem 0xb0000000-0xefffffff]
[  +0.013716] pci_bus 0001:00: root bus resource [bus 00-ef]
[  +0.010941] pci_bus 0001:00: busn_res: [bus 00-ef] end is updated to ff
[  +0.000025] pci 0001:00:00.0: [106b:0057] type 00 class 0x060000
[  +0.000115] pci 0001:00:01.0: [1022:7450] type 01 class 0x060400
[  +0.000149] pci 0001:00:02.0: [1022:7450] type 01 class 0x060400
[  +0.000140] pci 0001:00:03.0: [106b:0045] type 01 class 0x060400
[  +0.000163] pci 0001:00:04.0: [106b:0046] type 01 class 0x060400
[  +0.000147] pci 0001:00:05.0: [106b:0047] type 01 class 0x060400
[  +0.000159] pci 0001:00:06.0: [106b:0048] type 01 class 0x060400
[  +0.000146] pci 0001:00:07.0: [106b:0049] type 01 class 0x060400
[  +0.000255] pci 0001:00:01.0: PCI bridge to [bus 06]
[  +0.009654] pci 0001:07:04.0: [14e4:1648] type 00 class 0x020000
[  +0.000017] pci 0001:07:04.0: reg 0x10: [mem 0x90030000-0x9003ffff 64bit]
[  +0.000012] pci 0001:07:04.0: reg 0x18: [mem 0x90020000-0x9002ffff 64bit]
[  +0.000056] pci 0001:07:04.0: PME# supported from D3hot D3cold
[  +0.000119] pci 0001:07:04.1: [14e4:1648] type 00 class 0x020000
[  +0.000018] pci 0001:07:04.1: reg 0x10: [mem 0x90010000-0x9001ffff 64bit]
[  +0.000011] pci 0001:07:04.1: reg 0x18: [mem 0x90000000-0x9000ffff 64bit]
[  +0.000056] pci 0001:07:04.1: PME# supported from D3hot D3cold
[  +0.000114] pci 0001:00:02.0: PCI bridge to [bus 07]
[  +0.009559] pci 0001:00:02.0:   bridge window [mem 0x90000000-0x900fffff]
[  +0.000168] pci 0001:01:07.0: [106b:0041] type 00 class 0xff0000
[  +0.000015] pci 0001:01:07.0: reg 0x10: [mem 0x80000000-0x8007ffff]
[  +0.000141] pci 0001:00:03.0: PCI bridge to [bus 01]
[  +0.009577] pci 0001:00:03.0:   bridge window [mem 0x80000000-0x800fffff]
[  +0.000007] pci 0001:00:03.0:   bridge window [mem 0x00000000-0x000fffff pref]
[  +0.000102] pci 0001:02:0b.0: [1033:0035] type 00 class 0x0c0310
[  +0.000018] pci 0001:02:0b.0: reg 0x10: [mem 0x80102000-0x80102fff]
[  +0.000066] pci 0001:02:0b.0: supports D1 D2
[  +0.000005] pci 0001:02:0b.0: PME# supported from D0 D1 D2 D3hot D3cold
[  +0.000112] pci 0001:02:0b.1: [1033:0035] type 00 class 0x0c0310
[  +0.000018] pci 0001:02:0b.1: reg 0x10: [mem 0x80101000-0x80101fff]
[  +0.000066] pci 0001:02:0b.1: supports D1 D2
[  +0.000004] pci 0001:02:0b.1: PME# supported from D0 D1 D2 D3hot D3cold
[  +0.000114] pci 0001:02:0b.2: [1033:00e0] type 00 class 0x0c0320
[  +0.000018] pci 0001:02:0b.2: reg 0x10: [mem 0x80100000-0x801000ff]
[  +0.000066] pci 0001:02:0b.2: supports D1 D2
[  +0.000004] pci 0001:02:0b.2: PME# supported from D0 D1 D2 D3hot D3cold
[  +0.000112] pci 0001:00:04.0: PCI bridge to [bus 02]
[  +0.009560] pci 0001:00:04.0:   bridge window [mem 0x80100000-0x801fffff]
[  +0.000007] pci 0001:00:04.0:   bridge window [mem 0x00000000-0x000fffff pref]
[  +0.000143] pci 0001:03:0d.0: [106b:0043] type 00 class 0xff0000
[  +0.000013] pci 0001:03:0d.0: reg 0x10: [mem 0x80204000-0x80207fff]
[  +0.000132] pci 0001:03:0e.0: [106b:0042] type 00 class 0x0c0010
[  +0.000017] pci 0001:03:0e.0: reg 0x10: [mem 0x80200000-0x80200fff]
[  +0.000061] pci 0001:03:0e.0: supports D1 D2
[  +0.000004] pci 0001:03:0e.0: PME# supported from D0 D1 D2 D3hot
[  +0.000108] pci 0001:00:05.0: PCI bridge to [bus 03]
[  +0.009562] pci 0001:00:05.0:   bridge window [mem 0x80200000-0x802fffff]
[  +0.000007] pci 0001:00:05.0:   bridge window [mem 0x00000000-0x000fffff pref]
[  +0.000142] pci 0001:00:06.0: PCI bridge to [bus 04]
[  +0.009748] pci 0001:00:06.0:   bridge window [mem 0x80300000-0x805fffff]
[  +0.000007] pci 0001:00:06.0:   bridge window [mem 0x00000000-0x000fffff pref]
[  +0.000091] pci 0001:05:0c.0: [1166:0240] type 00 class 0x01018f
[  +0.000014] pci 0001:05:0c.0: reg 0x10: [io  0x820000-0x820007]
[  +0.000010] pci 0001:05:0c.0: reg 0x14: [io  0x820000-0x820003]
[  +0.000010] pci 0001:05:0c.0: reg 0x18: [io  0x820000-0x820007]
[  +0.000010] pci 0001:05:0c.0: reg 0x1c: [io  0x820000-0x820003]
[  +0.000009] pci 0001:05:0c.0: reg 0x20: [io  0x820000-0x82000f]
[  +0.000010] pci 0001:05:0c.0: reg 0x24: [mem 0x80600000-0x80601fff]
[  +0.000114] pci 0001:00:07.0: PCI bridge to [bus 05]
[  +0.009620] pci 0001:00:07.0:   bridge window [mem 0x80600000-0x806fffff]
[  +0.000007] pci 0001:00:07.0:   bridge window [mem 0x00000000-0x000fffff pref]
[  +0.000058] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 07
[  +0.000115] pci_bus 0000:f0: resource 4 [io  0x10000-0x80ffff]
[  +0.000005] pci_bus 0000:f0: resource 5 [mem 0xf1000000-0xf1ffffff]
[  +0.000004] pci_bus 0000:f0: resource 6 [mem 0xa0000000-0xafffffff]
[  +0.000044] pci 0001:00:01.0: PCI bridge to [bus 06]
[  +0.009664] pci 0001:00:02.0: PCI bridge to [bus 07]
[  +0.009885] pci 0001:00:02.0:   bridge window [mem 0x90000000-0x900fffff]
[  +0.013545] pci 0001:00:03.0: PCI bridge to [bus 01]
[  +0.009898] pci 0001:00:03.0:   bridge window [mem 0x80000000-0x800fffff]
[  +0.013545] pci 0001:00:04.0: PCI bridge to [bus 02]
[  +0.009898] pci 0001:00:04.0:   bridge window [mem 0x80100000-0x801fffff]
[  +0.013539] pci 0001:00:05.0: PCI bridge to [bus 03]
[  +0.009899] pci 0001:00:05.0:   bridge window [mem 0x80200000-0x802fffff]
[  +0.013544] pci 0001:00:06.0: PCI bridge to [bus 04]
[  +0.009905] pci 0001:00:06.0:   bridge window [mem 0x80300000-0x805fffff]
[  +0.013531] pci 0001:00:07.0: PCI bridge to [bus 05]
[  +0.009897] pci 0001:00:07.0:   bridge window [mem 0x80600000-0x806fffff]
[  +0.013546] pci_bus 0001:00: resource 4 [io  0x820000-0xc1ffff]
[  +0.000004] pci_bus 0001:00: resource 5 [mem 0xfa000000-0xffffffff]
[  +0.000005] pci_bus 0001:00: resource 6 [mem 0x80000000-0x9fffffff]
[  +0.000004] pci_bus 0001:00: resource 7 [mem 0xb0000000-0xefffffff]
[  +0.000005] pci_bus 0001:07: resource 1 [mem 0x90000000-0x900fffff]
[  +0.000004] pci_bus 0001:01: resource 1 [mem 0x80000000-0x800fffff]
[  +0.000005] pci_bus 0001:02: resource 1 [mem 0x80100000-0x801fffff]
[  +0.000004] pci_bus 0001:03: resource 1 [mem 0x80200000-0x802fffff]
[  +0.000004] pci_bus 0001:04: resource 1 [mem 0x80300000-0x805fffff]
[  +0.000004] pci_bus 0001:05: resource 1 [mem 0x80600000-0x806fffff]
[  +0.000004] PCI: Probing PCI hardware done
[  +0.003188] opal: Node not found
[  +0.006102] opal_async_comp_init: Opal node not found
[  +0.023469] vgaarb: loaded
[  +0.005347] SCSI subsystem initialized
[  +0.007288] libata version 3.00 loaded.
[  +0.000425] Switched to clocksource timebase
[  +0.019070] NET: Registered protocol family 2
[  +0.008911] TCP established hash table entries: 32768 (order: 2, 262144 bytes)
[  +0.014356] TCP bind hash table entries: 32768 (order: 3, 524288 bytes)
[  +0.013752] TCP: Hash tables configured (established 32768 bind 32768)
[  +0.012766] TCP: reno registered
[  +0.006353] UDP hash table entries: 2048 (order: 0, 65536 bytes)
[  +0.012037] UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
[  +0.013050] NET: Registered protocol family 1
[  +0.008461] pci 0001:00:01.0: MSI quirk detected; subordinate MSI disabled
[  +0.013676] pci 0001:00:01.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[  +0.014054] pci 0001:00:02.0: MSI quirk detected; subordinate MSI disabled
[  +0.013715] pci 0001:00:02.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[  +0.014067] PCI: CLS mismatch (32 != 64), using 128 bytes
[  +0.000040] pci 0001:02:0b.0: enabling device (0000 -> 0002)
[  +0.063729] pci 0001:02:0b.1: enabling device (0000 -> 0002)
[  +0.063977] pci 0001:02:0b.2: enabling device (0004 -> 0006)
[  +0.011093] Unpacking initramfs...
[  +0.673382] Freeing initrd memory: 18432K (c000000001a00000 - c000000002c00000)
[  +0.015197] Hypercall H_BEST_ENERGY not supported
[  +0.048825] futex hash table entries: 512 (order: 0, 65536 bytes)
[  +0.011930] audit: initializing netlink subsys (disabled)
[  +0.010694] audit: type=2000 audit(1441079687.523:1): initialized
[  +0.012702] HugeTLB registered 16 MB page size, pre-allocated 0 pages
[  +0.012589] zbud: loaded
[  +0.005450] VFS: Disk quotas dquot_6.5.2
[  +0.007581] Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[  +0.013413] msgmni has been set to 7968
[  +0.008305] alg: No test for stdrng (krng)
[  +0.007916] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[  +0.014807] io scheduler noop registered
[  +0.007677] io scheduler deadline registered
[  +0.008604] io scheduler cfq registered (default)
[  +0.009592] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  +0.010812] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[  +0.013492] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[  +0.013000] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[  +0.014287] Linux agpgart interface v0.103
[  +0.008153] agpgart-uninorth 0000:f0:0b.0: Apple U3H chipset
[  +0.016965] agpgart-uninorth 0000:f0:0b.0: configuring for size idx: 64
[  +0.013007] agpgart-uninorth 0000:f0:0b.0: AGP aperture is 256M @ 0x0
[  +0.012936] MacIO PCI driver attached to K2 chipset
[  +0.010251] 0.00013020:ch-a: ttyPZ0 at MMIO 0x80013020 (irq = 22, base_baud = 230400) is a Z85c30 ESCC - Serial port
[  +0.020978] 0.00013000:ch-b: ttyPZ1 at MMIO 0x80013000 (irq = 23, base_baud = 230400) is a Z85c30 ESCC - Serial port
[  +0.021081] pata-pci-macio 0001:03:0d.0: enabling device (0014 -> 0016)
[  +0.025388] pata-pci-macio 0001:03:0d.0: Activating pata-macio chipset K2 ATA-6, Apple bus ID 3
[  +0.017608] scsi0 : pata_macio
[  +0.005906] ata1: PATA max UDMA/100 irq 39
[  +0.008414] mousedev: PS/2 mouse device common for all mice
[  +0.011150] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[  +0.013997] PowerMac i2c bus pmu 2 registered
[  +0.008659] PowerMac i2c bus pmu 1 registered
[  +0.008985] PowerMac i2c bus mac-io 0 registered
[  +0.009428] PowerMac i2c bus u3 1 registered
[  +0.008245] i2c i2c-3: i2c-powermac: modalias failure on /u3@0,f8000000/i2c@f8001000/cereal@1c0
[  +0.017343] PowerMac i2c bus u3 0 registered
[  +0.045523] Registering G5 CPU frequency driver
[  +0.008689] Frequency method: i2c/pfunc, Voltage method: i2c/pfunc
[  +0.012325] Low: 1800 Mhz, High: 2000 Mhz, Cur: 1800 MHz
[  +0.022358] ledtrig-cpu: registered to indicate activity on CPUs
[  +0.009699] ata1.00: ATAPI: QSI CD-ROM TCR-241, WL20, max MWDMA2
[  +0.014041] TCP: cubic registered
[  +0.001902] ata1.00: configured for MWDMA2
[  +0.012943] NET: Registered protocol family 10
[  +0.008736] blk_queue_max_segment_size: set to minimum 65536
[  +0.011866] scsi 0:0:0:0: CD-ROM            QSI      CD-ROM TCR-241   WL20 PQ: 0 ANSI: 5
[  +0.000027] mip6: Mobile IPv6
[  +0.000009] NET: Registered protocol family 17
[  +0.000011] mpls_gso: MPLS GSO support
[  +0.000062] PM: Registered nosave memory: [mem 0x7f000000-0x7fffffff]
[  +0.000357] registered taskstats version 1
[  +0.058628] ata1.00: K2/Shasta alignment limits applied
[  +0.010607] input: PMU as /devices/virtual/input/input0
[  +0.010614] rtc-generic rtc-generic: setting system clock to 2015-09-01 03:54:49 UTC (1441079689)
[  +0.017456] PM: Hibernation image not present or could not be loaded.
[  +0.001171] Freeing unused kernel memory: 960K (c000000000910000 - c000000000a00000)
[  +0.052395] systemd-udevd[62]: starting version 215
[  +0.010454] random: systemd-udevd urandom read with 8 bits of entropy available
[  +0.037221] pps_core: LinuxPPS API ver. 1 registered
[  +0.009601] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[  +0.007392] usbcore: registered new interface driver usbfs
[  +0.000027] usbcore: registered new interface driver hub
[  +0.033533] PTP clock support registered
[  +0.002589] usbcore: registered new device driver usb
[  +0.003019] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[  +0.002407] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  +0.001177] ehci-pci: EHCI PCI platform driver
[  +0.000150] ehci-pci 0001:02:0b.2: EHCI Host Controller
[  +0.000016] ehci-pci 0001:02:0b.2: new USB bus registered, assigned bus number 1
[  +0.000244] ehci-pci 0001:02:0b.2: irq 63, io mem 0x80100000
[  +0.006868] sata_svw 0001:05:0c.0: version 2.3
[  +0.004179] ehci-pci 0001:02:0b.2: USB 2.0 started, EHCI 1.00
[  +0.000177] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[  +0.000002] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  +0.000002] usb usb1: Product: EHCI Host Controller
[  +0.000002] usb usb1: Manufacturer: Linux 3.16.0-4-powerpc64 ehci_hcd
[  +0.000002] usb usb1: SerialNumber: 0001:02:0b.2
[  +0.000297] hub 1-0:1.0: USB hub found
[  +0.000020] hub 1-0:1.0: 5 ports detected
[  +0.000982] ohci-pci: OHCI PCI platform driver
[  +0.000104] ohci-pci 0001:02:0b.0: OHCI PCI host controller
[  +0.000013] ohci-pci 0001:02:0b.0: new USB bus registered, assigned bus number 2
[  +0.000101] ohci-pci 0001:02:0b.0: irq 63, io mem 0x80102000
[  +0.114593] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[  +0.000003] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  +0.000002] usb usb2: Product: OHCI PCI host controller
[  +0.000002] usb usb2: Manufacturer: Linux 3.16.0-4-powerpc64 ohci_hcd
[  +0.000002] usb usb2: SerialNumber: 0001:02:0b.0
[  +0.000297] hub 2-0:1.0: USB hub found
[  +0.000023] hub 2-0:1.0: 3 ports detected
[  +0.001393] ohci-pci 0001:02:0b.1: OHCI PCI host controller
[  +0.000012] ohci-pci 0001:02:0b.1: new USB bus registered, assigned bus number 3
[  +0.000107] ohci-pci 0001:02:0b.1: irq 63, io mem 0x80101000
[  +0.117818] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[  +0.000003] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  +0.000002] usb usb3: Product: OHCI PCI host controller
[  +0.000002] usb usb3: Manufacturer: Linux 3.16.0-4-powerpc64 ohci_hcd
[  +0.000002] usb usb3: SerialNumber: 0001:02:0b.1
[  +0.000298] hub 3-0:1.0: USB hub found
[  +0.000019] hub 3-0:1.0: 2 ports detected
[  +0.155142] firewire_ohci 0001:03:0e.0: enabling device (0000 -> 0002)
[  +0.002471] tg3.c:v3.137 (May 11, 2014)
[  +0.001473] sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[  +0.000008] cdrom: Uniform CD-ROM driver Revision: 3.20
[  +0.010387] tg3 0001:07:04.0 eth0: Tigon3 [partno(BCM95704A6) rev 2003] (PCIX:133MHz:64-bit) MAC address 00:0d:93:9c:ca:f6
[  +0.000004] tg3 0001:07:04.0 eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[  +0.000003] tg3 0001:07:04.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[  +0.000002] tg3 0001:07:04.0 eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
[  +0.019888] tg3 0001:07:04.1 eth1: Tigon3 [partno(BCM95704A6) rev 2003] (PCIX:133MHz:64-bit) MAC address 00:0d:93:9c:ca:f7
[  +0.000004] tg3 0001:07:04.1 eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[  +0.000003] tg3 0001:07:04.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[  +0.000003] tg3 0001:07:04.1 eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
[  +0.150559] scsi1 : sata_svw
[  +0.000214] sr 0:0:0:0: Attached scsi CD-ROM sr0
[  +0.005580] sr 0:0:0:0: Attached scsi generic sg0 type 5
[  +0.010467] scsi2 : sata_svw
[  +0.006743] scsi3 : sata_svw
[  +0.005711] scsi4 : sata_svw
[  +0.005536] ata2: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600000 irq 17
[  +0.014640] ata3: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600100 irq 17
[  +0.006834] firewire_ohci 0001:03:0e.0: added OHCI v1.0 device as card 0, 8 IR + 8 IT contexts, quirks 0x0
[  +0.027196] ata4: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600200 irq 17
[  +0.014750] ata5: SATA max UDMA/133 mmio m8192@0x80600000 port 0x80600300 irq 17
[  +0.334000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  +0.020433] ata2.00: ATA-8: Hitachi HUA723020ALA641, MK7OA840, max UDMA/133
[  +0.013548] ata2.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[  +0.026429] ata2.00: configured for UDMA/133
[  +0.008354] scsi 1:0:0:0: Direct-Access     ATA      Hitachi HUA72302 A840 PQ: 0 ANSI: 5
[  +0.016482] scsi 1:0:0:0: Attached scsi generic sg1 type 0
[  +0.038923] firewire_core 0001:03:0e.0: created device fw0: GUID 000d93fffeb2ca86, S800
[  +0.016365] firewire_core 0001:03:0e.0: phy config: new root=ffc1, gap_count=5
[  +0.275465] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  +0.020448] ata3.00: ATA-8: Hitachi HUA723020ALA641, MK7OA840, max UDMA/133
[  +0.013549] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[  +0.026435] ata3.00: configured for UDMA/133
[  +0.008343] scsi 2:0:0:0: Direct-Access     ATA      Hitachi HUA72302 A840 PQ: 0 ANSI: 5
[  +0.016703] scsi 2:0:0:0: Attached scsi generic sg2 type 0
[  +0.330517] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  +0.020452] ata4.00: ATA-8: Hitachi HUA723020ALA641, MK7OA840, max UDMA/133
[  +0.013566] ata4.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[  +0.018430] ata4.00: configured for UDMA/133
[  +0.008337] scsi 3:0:0:0: Direct-Access     ATA      Hitachi HUA72302 A840 PQ: 0 ANSI: 5
[  +0.016692] scsi 3:0:0:0: Attached scsi generic sg3 type 0
[  +0.341503] ata5: SATA link down (SStatus 4 SControl 300)
[  +0.022800] sd 3:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[  +0.015418] sd 2:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[  +0.000114] sd 1:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[  +0.000094] sd 1:0:0:0: [sda] Write Protect is off
[  +0.000003] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  +0.000038] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  +0.006680] sd 3:0:0:0: [sdc] Write Protect is off
[  +0.000005] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  +0.000029] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  +0.079051] sd 2:0:0:0: [sdb] Write Protect is off
[  +0.009410] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  +0.000105] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  +0.019454]  sda: [mac] sda1 sda2 sda3 sda4 sda5
[  +0.008974]  sdc: [mac] sdc1 sdc2 sdc3 sdc4 sdc5
[  +0.010334]  sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5
[  +0.001595] sd 1:0:0:0: [sda] Attached SCSI disk
[  +0.011727] sd 3:0:0:0: [sdc] Attached SCSI disk
[  +0.014848] sd 2:0:0:0: [sdb] Attached SCSI disk
[  +0.197548] md: bind<sda4>
[  +0.046389] md: bind<sdc4>
[  +0.024655] md: bind<sdb4>
[  +0.013536] md: raid1 personality registered for level 1
[  +0.011189] md/raid1:md0: active with 3 out of 3 mirrors
[  +0.010545] created bitmap (1 pages) for device md0
[  +0.010110] md0: bitmap initialized from disk: read 1 pages, set 0 of 29805 bits
[  +0.024313] md0: detected capacity change from 0 to 2000164618240
[  +0.017313]  md0: unknown partition table
[  +0.062324] random: nonblocking pool is initialized
[  +0.054777] device-mapper: uevent: version 1.0.3
[  +0.009091] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[  +0.292383] PM: Starting manual resume from disk
[  +0.009221] PM: Hibernation image partition 253:1 present
[  +0.000003] PM: Looking for hibernation image.
[  +0.000744] PM: Image not found (code -22)
[  +0.000005] PM: Hibernation image not present or could not be loaded.
[  +0.225819] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[  +0.416056] systemd[1]: systemd 215 running in system mode. (+PAM +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ -SECCOMP -APPARMOR)
[  +0.026461] systemd[1]: Detected architecture 'ppc64'.
[  +0.128762] systemd[1]: Inserted module 'autofs4'
[  +0.017693] systemd[1]: Set hostname to <edi>.
[  +0.573562] systemd[1]: Cannot add dependency job for unit display-manager.service, ignoring: Unit display-manager.service failed to load: No such file or directory.
[  +0.030406] systemd[1]: Starting Forward Password Requests to Wall Directory Watch.
[  +0.015178] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  +0.014926] systemd[1]: Expecting device dev-ttyPZ0.device...
[  +0.027422] systemd[1]: Starting Remote File Systems (Pre).
[  +0.027974] systemd[1]: Reached target Remote File Systems (Pre).
[  +0.011928] systemd[1]: Starting Dispatch Password Requests to Console Directory Watch.
[  +0.016003] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[  +0.015693] systemd[1]: Starting Paths.
[  +0.020379] systemd[1]: Reached target Paths.
[  +0.008455] systemd[1]: Starting Arbitrary Executable File Formats File System Automount Point.
[  +0.039554] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[  +0.018481] systemd[1]: Expecting device dev-mapper-edi_volumes\x2dedi_swap.device...
[  +0.033524] systemd[1]: Expecting device dev-disk-by\x2duuid-2fad7988\x2d26bc\x2d4fa6\x2d8737\x2d184a4d272fa9.device...
[  +0.039990] systemd[1]: Expecting device dev-disk-by\x2duuid-78a7aa7a\x2dfa31\x2d4c59\x2da81d\x2dfff147ca2770.device...
[  +0.040001] systemd[1]: Expecting device dev-disk-by\x2duuid-465618f2\x2db082\x2d4ae5\x2da5b3\x2d9ca627ec9ead.device...
[  +0.040003] systemd[1]: Expecting device dev-mapper-edi_volumes\x2dedi_home.device...
[  +0.035996] systemd[1]: Starting Root Slice.
[  +0.023998] systemd[1]: Created slice Root Slice.
[  +0.009082] systemd[1]: Starting User and Session Slice.
[  +0.026918] systemd[1]: Created slice User and Session Slice.
[  +0.011173] systemd[1]: Starting Delayed Shutdown Socket.
[  +0.028825] systemd[1]: Listening on Delayed Shutdown Socket.
[  +0.011168] systemd[1]: Starting /dev/initctl Compatibility Named Pipe.
[  +0.032831] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[  +0.013604] systemd[1]: Starting Journal Socket (/dev/log).
[  +0.026400] systemd[1]: Listening on Journal Socket (/dev/log).
[  +0.011521] systemd[1]: Starting LVM2 metadata daemon socket.
[  +0.028479] systemd[1]: Listening on LVM2 metadata daemon socket.
[  +0.011868] systemd[1]: Starting Device-mapper event daemon FIFOs.
[  +0.048136] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[  +0.012761] systemd[1]: Starting udev Control Socket.
[  +0.027233] systemd[1]: Listening on udev Control Socket.
[  +0.010496] systemd[1]: Starting udev Kernel Socket.
[  +0.025504] systemd[1]: Listening on udev Kernel Socket.
[  +0.010324] systemd[1]: Starting Journal Socket.
[  +0.025690] systemd[1]: Listening on Journal Socket.
[  +0.009681] systemd[1]: Starting System Slice.
[  +0.022303] systemd[1]: Created slice System Slice.
[  +0.009484] systemd[1]: Started File System Check on Root Device.
[  +0.012091] systemd[1]: Starting system-systemd\x2dfsck.slice.
[  +0.030430] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[  +0.012223] systemd[1]: Starting system-getty.slice.
[  +0.023772] systemd[1]: Created slice system-getty.slice.
[  +0.010475] systemd[1]: Starting system-serial\x2dgetty.slice.
[  +0.029528] systemd[1]: Created slice system-serial\x2dgetty.slice.
[  +0.012279] systemd[1]: Starting Increase datagram queue length...
[  +0.029483] systemd[1]: Starting Nameserver information manager...
[  +0.063535] systemd[1]: Starting Load Kernel Modules...
[  +0.024795] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[  +0.039951] systemd[1]: Mounting Debug File System...
[  +0.018992] RackMeter initialized
[  +0.021738] systemd[1]: Started Set Up Additional Binary Formats.
[  +0.013271] systemd[1]: Mounting Huge Pages File System...
[  +0.025846] systemd[1]: Mounting POSIX Message Queue File System...
[  +0.027922] systemd[1]: Starting udev Coldplug all Devices...
[  +0.028181] systemd[1]: Starting Slices.
[  +0.022035] systemd[1]: Reached target Slices.
[  +0.008677] systemd[1]: Starting Remount Root and Kernel File Systems...
[  +0.051350] systemd[1]: Mounted POSIX Message Queue File System.
[  +0.027961] systemd[1]: Mounted Huge Pages File System.
[  +0.010684] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro
[  +0.025349] systemd[1]: Mounted Debug File System.
[  +0.027994] systemd[1]: Started Increase datagram queue length.
[  +0.028034] systemd[1]: Started Load Kernel Modules.
[  +0.031945] systemd[1]: Started Create list of required static device nodes for the current kernel.
[  +0.040083] systemd[1]: Started Remount Root and Kernel File Systems.
[  +0.031927] systemd[1]: Started Nameserver information manager.
[  +0.028021] systemd[1]: Started udev Coldplug all Devices.
[  +0.078660] systemd[1]: Starting udev Wait for Complete Device Initialization...
[  +0.035492] systemd[1]: Started Various fixups to make systemd work better on Debian.
[  +0.015378] systemd[1]: Starting Load/Save Random Seed...
[  +0.028449] systemd[1]: Starting Create Static Device Nodes in /dev...
[  +0.031946] systemd[1]: Starting Apply Kernel Variables...
[  +0.028178] systemd[1]: Mounted Configuration File System.
[  +0.010867] systemd[1]: Mounted FUSE Control File System.
[  +0.010589] systemd[1]: Starting Syslog Socket.
[  +0.024477] systemd[1]: Listening on Syslog Socket.
[  +0.010454] systemd[1]: Starting Journal Service...
[  +0.037496] systemd[1]: Started Journal Service.
[  +0.136165] systemd-udevd[234]: starting version 215
[  +0.549115] windfarm: Initializing for desktop G5 with 2 chips
[  +0.121801] windfarm: CPUs control loops started.
[  +0.009174] wf_rm31: Backside control loop started.
[  +0.009806] wf_rm31: Slots control loop started.
[  +0.276334] Adding 3903424k swap on /dev/mapper/edi_volumes-edi_swap.  Priority:-1 extents:1 across:3903424k FS
[  +0.694372] EXT4-fs (sdb3): mounting ext2 file system using the ext4 subsystem
[  +0.017062] EXT4-fs (sdb3): mounted filesystem without journal. Opts: (null)
[  +0.242309] EXT4-fs (sdc3): mounting ext2 file system using the ext4 subsystem
[  +0.015949] EXT4-fs (sdc3): mounted filesystem without journal. Opts: (null)
[  +0.032473] EXT4-fs (sda3): mounting ext2 file system using the ext4 subsystem
[  +0.149128] EXT4-fs (sda3): mounted filesystem without journal. Opts: (null)
[  +0.260414] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[  +0.286704] systemd-journald[224]: Received request to flush runtime journal from PID 1
[  +0.353219] tg3 0001:07:04.0: firmware: direct-loading firmware tigon/tg3_tso.bin
[  +0.067811] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[Aug31 20:55] tg3 0001:07:04.0 eth0: Link is up at 1000 Mbps, full duplex
[  +0.012875] tg3 0001:07:04.0 eth0: Flow control is off for TX and off for RX
[  +0.014284] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[Aug31 21:01] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 21:02] DCCP: Activated CCID 2 (TCP-like)
[  +0.008738] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[Aug31 21:42] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 22:06] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 22:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 22:25] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 22:48] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 22:55] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 23:01] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 23:17] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 23:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 23:31] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 23:40] i2c i2c-2: I2C write to 0x2d failed, err -27
[Aug31 23:52] finch[1258]: unhandled signal 11 at 00000081 nip 1f8121d8 lr 1f812508 code 30001
[Sep 1 00:09] finch[5876]: unhandled signal 11 at 000003f8 nip 1fde2530 lr 1fde2508 code 30001
[Sep 1 00:55] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 01:11] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 01:12] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 01:13] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 01:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 01:19] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 01:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +25.957725] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 01:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 02:15] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 02:55] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 03:06] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 03:09] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 03:18] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 04:07] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 04:18] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 04:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 04:49] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 05:04] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 05:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 05:47] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 05:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 05:54] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +30.036666] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 05:57] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 06:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:08] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:10] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:38] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:40] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:46] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:47] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:51] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 09:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 10:27] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +45.153359] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 10:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 11:04] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 11:09] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 11:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 12:10] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 12:31] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 12:46] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 12:47] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 12:48] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 12:50] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 13:11] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 13:30] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 13:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 13:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 14:02] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 16:11] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 16:31] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 16:36] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 17:57] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 18:01] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 18:02] Peer 12.119.238.122:61463/143 unexpectedly shrunk window 1203705724:1203705742 (repaired)
[Sep 1 18:18] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 18:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 18:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 19:26] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 19:43] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 19:45] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 19:47] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 19:49] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 20:36] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 21:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 21:59] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 22:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 22:51] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 22:58] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 23:43] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 23:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 1 23:47] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 00:02] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 00:33] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 00:46] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 01:00] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 01:51] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 02:21] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 02:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 02:23] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 02:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 02:58] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 03:08] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 03:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 03:20] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 03:32] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 03:47] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 04:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 04:40] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 05:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 06:24] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 06:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 06:46] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 07:03] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 08:25] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 08:36] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 08:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 09:26] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 09:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 09:38] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 10:24] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 10:58] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 10:59] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 11:41] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 11:42] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 11:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 12:32] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 13:02] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 13:07] i2c i2c-2: I2C write to 0x2d failed, err -27
[  +4.987030] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 13:16] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 13:41] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 13:42] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 14:18] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 14:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 14:31] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 14:56] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 15:17] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 15:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 15:23] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 17:13] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 17:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 17:37] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 17:40] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 17:50] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 18:17] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 19:58] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 20:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 20:20] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 20:46] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 21:31] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 22:49] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 2 22:51] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 00:10] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 00:15] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 00:42] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 01:01] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 01:04] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 01:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 01:15] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 01:59] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 02:07] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 02:56] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 03:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[  +1.008036] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 04:08] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 04:45] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +40.027879] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 04:46] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 04:55] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 04:57] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +12.096741] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 05:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 05:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 06:19] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 06:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 06:25] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +10.951523] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 06:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 07:56] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 09:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 10:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 10:30] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 10:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 11:06] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 11:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 11:55] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 12:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 13:21] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 13:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 13:55] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 14:16] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 14:18] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:03] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:12] i2c i2c-2: I2C write to 0x2d failed, err -27
[  +5.006247] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:47] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:50] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:55] i2c i2c-2: I2C write to 0x2d failed, err -27
[  +0.072057] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +20.958676] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 15:56] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 16:12] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 16:21] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 16:39] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 16:56] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 17:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 17:30] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 17:31] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 17:33] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 17:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 19:06] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 20:26] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 21:45] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 21:53] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 21:58] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 22:05] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 22:10] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 22:11] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +14.010984] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 22:18] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:08] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:16] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:17] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +11.000664] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:20] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:33] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:35] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:52] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +20.001214] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 3 23:58] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 01:11] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 02:16] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 02:39] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 03:03] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 04:07] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 04:24] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 04:28] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 05:14] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +31.001907] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 05:27] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +23.039204] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 05:30] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 05:43] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 05:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[ +10.946423] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 05:54] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 06:00] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 06:02] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 06:03] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 06:34] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 07:04] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 07:21] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 07:48] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 08:48] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 09:09] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 09:13] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 09:25] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 09:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 10:02] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 10:18] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 10:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 10:33] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 10:40] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 10:44] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 11:23] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 12:06] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 12:37] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 14:46] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 14:59] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 15:19] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 15:22] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 15:42] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 16:36] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 18:24] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 19:11] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 19:29] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 20:04] i2c i2c-2: I2C write to 0x2d failed, err -27
[Sep 4 20:29] i2c i2c-2: I2C write to 0x2d failed, err -27

--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="20150907-edi-lspci.txt"

0000:f0:0b.0 Host bridge: Apple Inc. U3H AGP Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 16, Cache Line Size: 32 bytes
	Capabilities: [80] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans+ 64bit+ FW+ AGP3- Rate=x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit+ FW- Rate=<none>
	Kernel driver in use: agpgart-uninorth

0001:00:00.0 Host bridge: Apple Inc. U3 HT Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [40] HyperTransport: Host or Secondary Interface
		Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide- Slave- <EOCErr- DUL-
		Link Control: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Revision ID: 1.04
		Link Frequency: 600MHz
		Link Error: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM+ ECTLT- 64bA- UIDRD- ExtRS+ UCnfE-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00

0001:00:01.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
		Status: Dev=00:01.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=1 UnitCnt=2 MastHost- DefDir- DUL-
		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.02
		Link Frequency 0: 600MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
		Link Frequency 1: 400MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00

0001:00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 90000000-900fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [a0] PCI-X bridge device
		Secondary Status: 64bit+ 133MHz+ SCD- USC- SCO- SRD- Freq=133MHz
		Status: Dev=00:02.0 64bit+ 133MHz+ SCD- USC- SCO- SRD-
		Upstream: Capacity=14 CommitmentLimit=65535
		Downstream: Capacity=2 CommitmentLimit=65535
	Capabilities: [b8] HyperTransport: Interrupt Discovery and Configuration

0001:00:03.0 PCI bridge: Apple Inc. K2 HT-PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80000000-800fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [70] HyperTransport: Slave or Primary Interface
		Command: BaseUnitID=3 UnitCnt=5 MastHost- DefDir- DUL-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 0: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
		Revision ID: 1.04
		Link Frequency 0: 400MHz
		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Feature Capability: IsocFC- LDTSTOP+ CRCTM+ ECTLT- 64bA- UIDRD-
		Link Frequency 1: 200MHz
		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
		Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
		Prefetchable memory behind bridge Upper: 00-00
		Bus Number: 00
	Capabilities: [90] HyperTransport: Interrupt Discovery and Configuration

0001:00:04.0 PCI bridge: Apple Inc. K2 HT-PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80100000-801fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [70] HyperTransport: Revision ID: 1.04

0001:00:05.0 PCI bridge: Apple Inc. K2 HT-PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80200000-802fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [70] HyperTransport: Revision ID: 1.04

0001:00:06.0 PCI bridge: Apple Inc. K2 HT-PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80300000-805fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [70] HyperTransport: Revision ID: 1.04

0001:00:07.0 PCI bridge: Apple Inc. K2 HT-PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80600000-806fffff
	Prefetchable memory behind bridge: 00000000-000fffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [70] HyperTransport: Revision ID: 1.04

0001:01:07.0 Unassigned class [ff00]: Apple Inc. K2 KeyLargo Mac/IO (rev 60)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16, Cache Line Size: 64 bytes
	Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]
	Kernel driver in use: macio

0001:02:0b.0 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (250ns min, 10500ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 63
	Region 0: Memory at 80102000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci-pci

0001:02:0b.1 USB controller: NEC Corporation OHCI USB Controller (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (250ns min, 10500ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 63
	Region 0: Memory at 80101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci-pci

0001:02:0b.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation uPD72010x USB 2.0 Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (4000ns min, 8500ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 63
	Region 0: Memory at 80100000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci-pci

0001:03:0d.0 Unassigned class [ff00]: Apple Inc. K2 ATA/100
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin ? routed to IRQ 39
	Region 0: Memory at 80204000 (32-bit, non-prefetchable) [size=16K]
	Kernel driver in use: pata-pci-macio

0001:03:0e.0 FireWire (IEEE 1394): Apple Inc. K2 FireWire (prog-if 10 [OHCI])
	Subsystem: Apple Inc. Device 5811
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 248 (3000ns min, 6000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at 80200000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
	Kernel driver in use: firewire_ohci

0001:05:0c.0 IDE interface: Broadcom K2 SATA (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Broadcom K2 SATA
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16
	Interrupt: pin ? routed to IRQ 17
	Region 0: I/O ports at <unassigned> [disabled]
	Region 1: I/O ports at <unassigned> [disabled]
	Region 2: I/O ports at <unassigned> [disabled]
	Region 3: I/O ports at <unassigned> [disabled]
	Region 4: I/O ports at <unassigned> [disabled]
	Region 5: Memory at 80600000 (32-bit, non-prefetchable) [size=8K]
	Kernel driver in use: sata_svw

0001:07:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
	Subsystem: Apple Inc. Device 005a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 54
	Region 0: Memory at 90030000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at 90020000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO- RBC=2048 OST=1
		Status: Dev=07:04.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
		Read-only fields:
			[PN] Part number: BCM95704A6
			[EC] Engineering changes: 106679-15
			[SN] Serial number: 0123456789
			[MN] Manufacture ID: 31 34 65 34
			[RV] Reserved: checksum bad, 26 byte(s) reserved
		Read/write fields:
			[YA] Asset tag: XYZ01234567
			[RW] Read-write area: 107 byte(s) free
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: efeffabefef865f4  Data: fffe
	Kernel driver in use: tg3

0001:07:04.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
	Subsystem: Apple Inc. Device 005a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 16 (16000ns min), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 57
	Region 0: Memory at 90010000 (64-bit, non-prefetchable) [size=64K]
	Region 2: Memory at 90000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=1
		Status: Dev=07:04.1 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
		Read-only fields:
			[PN] Part number: BCM95704A6
			[EC] Engineering changes: 106679-15
			[SN] Serial number: 0123456789
			[MN] Manufacture ID: 31 34 65 34
			[RV] Reserved: checksum bad, 26 byte(s) reserved
		Read/write fields:
			[YA] Asset tag: XYZ01234567
			[RW] Read-write area: 107 byte(s) free
		End
	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: fffff7fff7f6feb8  Data: fe77
	Kernel driver in use: tg3


--ZwgA9U+XZDXt4+m+--
