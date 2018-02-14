Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhY4J1MZFzF0lB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:50:36 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1ELiFuN102245
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:50:34 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g4ukt3px1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:50:33 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 16:50:33 -0500
Subject: Re: [PATCH V3 0/9] powerpc: Support for ibm,dynamic-memory-v2
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Cyril Bur <cyrilbur@gmail.com>
References: <151214667699.64022.17601877129884655591.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <87a7yz3wjo.fsf@concordia.ellerman.id.au>
 <53bf14ae-bb01-585d-3d40-2d8afeb5d345@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 15:50:28 -0600
MIME-Version: 1.0
In-Reply-To: <53bf14ae-bb01-585d-3d40-2d8afeb5d345@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <9ce5cfca-0b1f-4a1b-f887-71a932131e0b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/14/2018 03:30 PM, Tyrel Datwyler wrote:
> On 12/03/2017 09:13 PM, Michael Ellerman wrote:
>> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>>
>>> This patch set provides a series of updates to de-couple the LMB
>>> information provided in the device tree property from the device
>>> tree property format. This eases the ability to support a new
>>> format for the dynamic memory property, ibm,dynamic-memory-v2.
>>
>> Something in here is still blowing up for me in a KVM guest:
> 
> So, it looks like this series was applied despite observing this KVM guest crash. Cyril posted yesterday to the list about hitting this same issue with 4.16-rc1.
> 
> -Tyrel
> 

Yes, Michael pointed out that he hit this on his system but I have never
been able to replicate this error.

Now that others are seeing it any help I could get on re-creating the failure
would be appreciated.

-Nathan

>>
>>     OF stdout device is: /vdevice/vty@71000000
>>     Preparing to boot Linux version 4.14.0-rc2-gcc6x-g9e1fc7e (kerkins@alpine1-p1) (gcc version 6.4.1 20171202 (Custom 6328ca9eaa476138)) #1 SMP Sun Dec 3 21:45:32 AEDT 2017
>>     Detected machine type: 0000000000000101
>>     command line: 
>>     Max number of cores passed to firmware: 256 (NR_CPUS = 2048)
>>     Calling ibm,client-architecture-support... done
>>     memory layout at init:
>>       memory_limit : 0000000000000000 (16 MB aligned)
>>       alloc_bottom : 00000000015c0000
>>       alloc_top    : 0000000030000000
>>       alloc_top_hi : 0000000100000000
>>       rmo_top      : 0000000030000000
>>       ram_top      : 0000000100000000
>>     instantiating rtas at 0x000000002fff0000... done
>>     prom_hold_cpus: skipped
>>     copying OF device tree...
>>     Building dt strings...
>>     Building dt structure...
>>     Device tree strings 0x00000000017d0000 -> 0x00000000017d09d8
>>     Device tree struct  0x00000000017e0000 -> 0x00000000017f0000
>>     Quiescing Open Firmware ...
>>     Booting Linux via __start() @ 0x0000000000400000 ...
>>     [    0.000000] bootconsole [udbg0] enabled
>>     [    0.000000] Allocated 2883584 bytes for 2048 pacas at c00000000fd40000
>>     [    0.000000] hash-mmu: Page sizes from device-tree:
>>     [    0.000000] hash-mmu: base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
>>     [    0.000000] hash-mmu: base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
>>     [    0.000000]  -> fw_vec5_feature_init()
>>     [    0.000000]  <- fw_vec5_feature_init()
>>     [    0.000000]  -> fw_hypertas_feature_init()
>>     [    0.000000]  <- fw_hypertas_feature_init()
>>     [    0.000000] Page orders: linear mapping = 16, virtual = 16, io = 16, vmemmap = 16
>>     [    0.000000] Using 1TB segments
>>     [    0.000000] hash-mmu: Initializing hash mmu with SLB
>>     [    0.000000] Linux version 4.14.0-rc2-gcc6x-g9e1fc7e (kerkins@alpine1-p1) (gcc version 6.4.1 20171202 (Custom 6328ca9eaa476138)) #1 SMP Sun Dec 3 21:45:32 AEDT 2017
>>     [    0.000000] Found initrd at 0xc0000000015c0000:0xc00000000178d70b
>>     [    0.000000] Machine is LPAR !
>>     [    0.000000]  -> pseries_init()
>>     [    0.000000]  -> fw_cmo_feature_init()
>>     [    0.000000] CMO not available
>>     [    0.000000]  <- fw_cmo_feature_init()
>>     [    0.000000]  <- pseries_init()
>>     [    0.000000] Using pSeries machine description
>>     [    0.000000] Partition configured for 16 cpus.
>>     [    0.000000] CPU maps initialized for 8 threads per core
>>     [    0.000000]  (thread shift is 3)
>>     [    0.000000] Freed 2818048 bytes for unused pacas
>>     [    0.000000] -----------------------------------------------------
>>     [    0.000000] ppc64_pft_size    = 0x19
>>     [    0.000000] phys_mem_size     = 0x100000000
>>     [    0.000000] dcache_bsize      = 0x80
>>     [    0.000000] icache_bsize      = 0x80
>>     [    0.000000] cpu_features      = 0x17dc7aec18500249
>>     [    0.000000]   possible        = 0xdfdfffff18500649
>>     [    0.000000]   always          = 0x0000000018100040
>>     [    0.000000] cpu_user_features = 0xdc0065c2 0xef000000
>>     [    0.000000] mmu_features      = 0x78006001
>>     [    0.000000] firmware_features = 0x00000001405a440b
>>     [    0.000000] htab_hash_mask    = 0x3ffff
>>     [    0.000000] -----------------------------------------------------
>>     [    0.000000] numa:   NODE_DATA [mem 0xfff6a300-0xfff73fff]
>>     [    0.000000]  -> smp_init_pSeries()
>>     [    0.000000]  <- smp_init_pSeries()
>>     [    0.000000] PCI host bridge /pci@800000020000000  ranges:
>>     [    0.000000]   IO 0x0000010080000000..0x000001008000ffff -> 0x0000000000000000
>>     [    0.000000]  MEM 0x00000100a0000000..0x000001101fffffff -> 0x0000000080000000 
>>     [    0.000000] PPC64 nvram contains 65536 bytes
>>     [    0.000000] Top of RAM: 0x100000000, Total RAM: 0x100000000
>>     [    0.000000] Memory hole size: 0MB
>>     [    0.000000] Zone ranges:
>>     [    0.000000]   DMA      [mem 0x0000000000000000-0x00000000ffffffff]
>>     [    0.000000]   DMA32    empty
>>     [    0.000000]   Normal   empty
>>     [    0.000000] Movable zone start for each node
>>     [    0.000000] Early memory node ranges
>>     [    0.000000]   node   0: [mem 0x0000000000000000-0x00000000ffffffff]
>>     [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
>>     [    0.000000] On node 0 totalpages: 65536
>>     [    0.000000]   DMA zone: 64 pages used for memmap
>>     [    0.000000]   DMA zone: 0 pages reserved
>>     [    0.000000]   DMA zone: 65536 pages, LIFO batch:1
>>     [    0.000000] percpu: Embedded 4 pages/cpu @c0000000ffb00000 s167064 r0 d95080 u262144
>>     [    0.000000] pcpu-alloc: s167064 r0 d95080 u262144 alloc=1*1048576
>>     [    0.000000] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
>>     [    0.000000] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
>>     [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65472
>>     [    0.000000] Policy zone: DMA
>>     [    0.000000] Kernel command line: 
>>     [    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
>>     [    0.000000] Memory: 4163840K/4194304K available (11008K kernel code, 1664K rwdata, 2752K rodata, 1152K init, 1414K bss, 30464K reserved, 0K cma-reserved)
>>     [    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
>>     [    0.000000] ftrace: allocating 28124 entries in 11 pages
>>     [    0.000000] Hierarchical RCU implementation.
>>     [    0.000000] 	RCU event tracing is enabled.
>>     [    0.000000] 	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=16.
>>     [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
>>     [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
>>     [    0.000000] pic: no ISA interrupt controller
>>     [    0.000000] time_init: decrementer frequency = 512.000000 MHz
>>     [    0.000000] time_init: processor frequency   = 3425.000000 MHz
>>     [    0.000001] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
>>     [    0.001138] clocksource: timebase mult[1f40000] shift[24] registered
>>     [    0.001818] clockevent: decrementer mult[83126e98] shift[32] cpu[0]
>>     [    0.002539] Console: colour dummy device 80x25
>>     [    0.003018] console [hvc0] enabled
>>     [    0.003018] console [hvc0] enabled
>>     [    0.003411] bootconsole [udbg0] disabled
>>     [    0.003411] bootconsole [udbg0] disabled
>>     [    0.003875] pid_max: default: 32768 minimum: 301
>>     [    0.004217] Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
>>     [    0.004394] Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
>>     [    0.004461] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
>>     [    0.004514] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
>>     [    0.006022] EEH: pSeries platform initialized
>>     [    0.006102] POWER8 performance monitor hardware support registered
>>     [    0.006156] power8-pmu: PMAO restore workaround active.
>>     [    0.006211] Hierarchical SRCU implementation.
>>     [    0.006394] smp: Bringing up secondary CPUs ...
>>     [    0.020141] smp: Brought up 1 node, 16 CPUs
>>     [    0.020514] numa: Node 0 CPUs: 0-15
>>     [    0.020685] Using standard scheduler topology
>>     [    0.024234] devtmpfs: initialized
>>     [    0.024965] random: get_random_u32 called from bucket_table_alloc+0x144/0x360 with crng_init=0
>>     [    0.028242] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
>>     [    0.029834] futex hash table entries: 4096 (order: 3, 524288 bytes)
>>     [    0.030024] kworker/u32:0 (106) used greatest stack depth: 12272 bytes left
>>     [    0.032033] NET: Registered protocol family 16
>>     [    0.032563] EEH: No capable adapters found
>>     [    0.034455] cpuidle: using governor menu
>>     [    0.036083] random: fast init done
>>     [    0.042279] RTAS daemon started
>>     [    0.042915] pstore: using zlib compression
>>     [    0.043109] pstore: Registered nvram as persistent store backend
>>     Linux ppc64le
>>     #1 SMP Sun Dec 3[    0.045751] rtas_msi: Registering RTAS MSI callbacks.
>>     [    0.058501] PCI: Probing PCI hardware
>>     [    0.058823] no ibm,pcie-link-speed-stats property
>>     [    0.059114] PCI host bridge to bus 0000:00
>>     [    0.059378] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
>>     [    0.059880] pci_bus 0000:00: root bus resource [mem 0x100a0000000-0x1101fffffff] (bus address [0x80000000-0xfffffffff])
>>     [    0.060473] pci_bus 0000:00: root bus resource [bus 00-ff]
>>     [    0.060686] pci_dma_bus_setup_pSeriesLP: setting up bus /pci@800000020000000
>>     [    0.061048]   parent is /pci@800000020000000, iommu_table: 0x          (null)
>>     [    0.065074] IOMMU table initialized, virtual merging enabled
>>     [    0.065428]   created table: c0000000fe201000
>>     [    0.065681] PCI: Probing PCI hardware done
>>     [    0.086830] vgaarb: loaded
>>     [    0.087716] SCSI subsystem initialized
>>     [    0.088766] libata version 3.00 loaded.
>>     [    0.090210] usbcore: registered new interface driver usbfs
>>     [    0.090675] usbcore: registered new interface driver hub
>>     [    0.091411] usbcore: registered new device driver usb
>>     [    0.092023] pps_core: LinuxPPS API ver. 1 registered
>>     [    0.092418] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
>>     [    0.093119] PTP clock support registered
>>     [    0.094681] clocksource: Switched to clocksource timebase
>>     [    0.106055] hugetlbfs: disabling because there are no supported hugepage sizes
>>     [    0.111204] NET: Registered protocol family 2
>>     [    0.112104] TCP established hash table entries: 32768 (order: 2, 262144 bytes)
>>     [    0.112810] TCP bind hash table entries: 32768 (order: 3, 524288 bytes)
>>     [    0.113369] TCP: Hash tables configured (established 32768 bind 32768)
>>     [    0.113993] UDP hash table entries: 2048 (order: 0, 65536 bytes)
>>     [    0.114583] UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
>>     [    0.115133] NET: Registered protocol family 1
>>     [    0.115852] RPC: Registered named UNIX socket transport module.
>>     [    0.116376] RPC: Registered udp transport module.
>>     [    0.116779] RPC: Registered tcp transport module.
>>     [    0.117176] RPC: Registered tcp NFSv4.1 backchannel transport module.
>>     [    0.117735] PCI: CLS 0 bytes, default 128
>>     [    0.118123] Trying to unpack rootfs image as initramfs...
>>     [    0.145121] Freeing initrd memory: 1792K
>>     [    0.151187] audit: initializing netlink subsys (disabled)
>>     [    0.152291] audit: type=2000 audit(1512304166.130:1): state=initialized audit_enabled=0 res=1
>>     [    0.153746] workingset: timestamp_bits=38 max_order=16 bucket_order=0
>>     [    0.161309] NFS: Registering the id_resolver key type
>>     [    0.161796] Key type id_resolver registered
>>     [    0.162029] Key type id_legacy registered
>>     [    0.162826] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
>>     [    0.163638] io scheduler noop registered
>>     [    0.164114] io scheduler deadline registered
>>     [    0.164758] io scheduler cfq registered (default)
>>     [    0.165354] io scheduler mq-deadline registered
>>     [    0.165713] io scheduler kyber registered
>>     [    0.166959] atomic64_test: passed
>>     [    0.197910] __vio_register_driver: driver hvc_console registering
>>     [    0.199239] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>>     [    0.203789] brd: module loaded
>>     [    0.209646] loop: module loaded
>>     [    0.209921] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
>>     [    0.210454] __vio_register_driver: driver ibmvscsi registering
>>     [    0.214828] ibmvscsi 71000003: SRP_VERSION: 16.a
>>     [    0.215752] ibmvscsi 71000003: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
>>     [    0.216463] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
>>     [    0.217445] ibmvscsi 71000003: partner initialization complete
>>     [    0.217950] ibmvscsi 71000003: host srp version: 16.a, host partition qemu (0), OS 2, max io 2097152
>>     [    0.218617] ibmvscsi 71000003: sent SRP login
>>     [    0.218902] ibmvscsi 71000003: SRP_LOGIN succeeded
>>     [    0.257469] scsi 0:0:2:0: CD-ROM            QEMU     QEMU CD-ROM      2.5+ PQ: 0 ANSI: 5
>>     [    0.448382] sr 0:0:2:0: [sr0] scsi3-mmc drive: 16x/50x cd/rw xa/form2 cdda tray
>>     [    0.448992] cdrom: Uniform CD-ROM driver Revision: 3.20
>>     [    0.449673] sr 0:0:2:0: Attached scsi CD-ROM sr0
>>     [    0.450738] sr 0:0:2:0: Attached scsi generic sg0 type 5
>>     [    0.451472] libphy: Fixed MDIO Bus: probed
>>     [    0.452068] ibmveth: IBM Power Virtual Ethernet Driver 1.06
>>     [    0.452411] __vio_register_driver: driver ibmveth registering
>>     [    0.453225] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
>>     [    0.454141] e100: Copyright(c) 1999-2006 Intel Corporation
>>     [    0.454537] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
>>     [    0.455441] e1000: Copyright (c) 1999-2006 Intel Corporation.
>>     [    0.455920] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
>>     [    0.456616] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>>     [    0.457115] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>>     [    0.457528] ehci-pci: EHCI PCI platform driver
>>     [    0.457917] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>>     [    0.458868] ohci-pci: OHCI PCI platform driver
>>     [    0.459673] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
>>     [    0.460373] i2c /dev entries driver
>>     [    0.460995] IR NEC protocol handler initialized
>>     [    0.461537] IR RC5(x/sz) protocol handler initialized
>>     [    0.461921] IR RC6 protocol handler initialized
>>     [    0.462304] IR JVC protocol handler initialized
>>     [    0.462679] IR Sony protocol handler initialized
>>     [    0.463061] IR SANYO protocol handler initialized
>>     [    0.463427] IR Sharp protocol handler initialized
>>     [    0.463811] IR MCE Keyboard/mouse protocol handler initialized
>>     [    0.464284] IR XMP protocol handler initialized
>>     [    0.464901] device-mapper: uevent: version 1.0.3
>>     [    0.465724] device-mapper: ioctl: 4.36.0-ioctl (2017-06-09) initialised: dm-devel@redhat.com
>>     [    0.466797] pseries_idle_driver registered
>>     [    0.467761] usbcore: registered new interface driver usbhid
>>     [    0.468401] usbhid: USB HID core driver
>>     [    0.469142] ipip: IPv4 and MPLS over IPv4 tunneling driver
>>     [    0.469558] NET: Registered protocol family 17
>>     [    0.470202] Key type dns_resolver registered
>>     [    0.470535] Unable to handle kernel paging request for data at address 0x00000010
>>     [    0.471030] Faulting instruction address: 0xc000000000d92d04
>>     [    0.471440] Oops: Kernel access of bad area, sig: 11 [#1]
>>     [    0.471760] LE SMP NR_CPUS=2048 NUMA pSeries
>>     [    0.472081] Modules linked in:
>>     [    0.472319] CPU: 7 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc2-gcc6x-g9e1fc7e #1
>>     [    0.472811] task: c0000000fea80000 task.stack: c0000000feb00000
>>     [    0.473215] NIP:  c000000000d92d04 LR: c000000000d92cfc CTR: 0000000000000000
>>     [    0.473706] REGS: c0000000feb038d0 TRAP: 0380   Not tainted  (4.14.0-rc2-gcc6x-g9e1fc7e)
>>     [    0.474203] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 84000248  XER: 20000000
>>     [    0.474901] CFAR: c000000000deb200 SOFTE: 1 
>>     [    0.474901] GPR00: c000000000d92cfc c0000000feb03b50 c000000000fca600 0000000000000000 
>>     [    0.474901] GPR04: c0000000feb03b70 0000000000000000 000000000000002f 0000000000000022 
>>     [    0.474901] GPR08: 0000000000000000 c0000000017e35a8 0000000000000000 0000000000000220 
>>     [    0.474901] GPR12: 0000000000000000 c00000000fd42680 c00000000000d778 0000000000000000 
>>     [    0.474901] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>     [    0.474901] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>>     [    0.474901] GPR24: 0000000000000000 c000000000d66f60 c000000000d838a4 c000000000dfd918 
>>     [    0.474901] GPR28: 0000000000000007 c0000000fffffc30 c0000000feb03bf0 0000000000000010 
>>     [    0.479304] NIP [c000000000d92d04] read_drconf_v1_cell+0x50/0x9c
>>     [    0.479705] LR [c000000000d92cfc] read_drconf_v1_cell+0x48/0x9c
>>     [    0.480104] Call Trace:
>>     [    0.480244] [c0000000feb03b50] [c000000000d92cfc] read_drconf_v1_cell+0x48/0x9c (unreliable)
>>     [    0.480907] [c0000000feb03b90] [c000000000d931a4] drmem_init+0x13c/0x2ec
>>     [    0.481352] [c0000000feb03c40] [c00000000000d50c] do_one_initcall+0x6c/0x1d0
>>     [    0.481897] [c0000000feb03d00] [c000000000d84600] kernel_init_freeable+0x27c/0x358
>>     [    0.482428] [c0000000feb03dc0] [c00000000000d79c] kernel_init+0x2c/0x160
>>     [    0.482872] [c0000000feb03e30] [c00000000000bae0] ret_from_kernel_thread+0x5c/0x7c
>>     [    0.483416] Instruction dump:
>>     [    0.483667] 7c7f1b78 60000000 60000000 7c240b78 3d22ffe5 39296414 e95e0000 e8690002 
>>     [    0.484216] f9440021 48058495 60000000 e9210020 <f87f0000> 39090004 38e90008 39490010 
>>     [    0.484926] ---[ end trace 5aca0f2a87d33521 ]---
>>     [    0.496557] 
>>     [    1.496724] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>>     [    1.496724] 
>>     [    1.505124] Rebooting in 10 seconds..
>>
>>
>> cheers
>>
> 
