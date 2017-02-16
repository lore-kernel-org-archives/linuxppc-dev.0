Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPD5J5BfkzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 22:12:20 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vPD5J0htTz9s7D
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 22:12:19 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GB9sZq013477
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 06:12:18 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28nanu0vex-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 06:12:17 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 16:42:14 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 71C55E005A
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 16:43:44 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GBB9gu12779542
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 16:41:09 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GBC9db002708
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2017 16:42:10 +0530
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_2FB4F60F-C63C-412B-B1AD-6745FBF734BE"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: BUG: using __this_cpu_read() in
 preemptible/iommu_range_alloc+0x98/0x3e0
Date: Thu, 16 Feb 2017 16:42:02 +0530
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <CBC8035B-9E5A-4E6E-8370-7602616816BB@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_2FB4F60F-C63C-412B-B1AD-6745FBF734BE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

While booting latest mainline kernel on a POWER8 PowerVM
LPAR with CONFIG_PREEMPT=3Dy, following messages are observed

[    7.834713] ibmveth 30000002 ibmveth2: renamed from eth0
[    7.850025] BUG: using __this_cpu_read() in preemptible [00000000] =
code: systemd-udevd/266
[    7.850068] caller is iommu_range_alloc+0x98/0x3e0
[    7.850078] CPU: 4 PID: 266 Comm: systemd-udevd Not tainted =
4.10.0-rc8 #1
[    7.850085] Call Trace:
[    7.850095] [c00000023df632d0] [c00000000235ff24] =
dump_stack+0xb4/0xf4 (unreliable)
[    7.850109] [c00000023df63310] [c000000001e06754] =
check_preemption_disabled+0x164/0x170
[    7.850120] [c00000023df633a0] [c000000001832508] =
iommu_range_alloc+0x98/0x3e0
[    7.850131] [c00000023df63450] [c000000001832ad4] =
iommu_alloc+0x64/0x170
[    7.850141] [c00000023df634a0] [c000000001833fe0] =
iommu_map_page+0xd0/0x1d0
[    7.850150] [c00000023df63530] [c0000000018320d8] =
dma_iommu_map_page+0x58/0xa0
[    7.850163] [c00000023df63550] [d0000000049a3c78] =
ibmvscsi_probe+0x138/0xa94 [ibmvscsi]
[    7.850175] [c00000023df63630] [c0000000018951c4] =
vio_bus_probe+0x1a4/0x460
[    7.850186] [c00000023df636d0] [c000000001f3a490] =
driver_probe_device+0x300/0x5a0
[    7.850196] [c00000023df63760] [c000000001f3a89c] =
__driver_attach+0x16c/0x170
[    7.850207] [c00000023df637e0] [c000000001f3701c] =
bus_for_each_dev+0x8c/0xf0
[    7.850217] [c00000023df63830] [c000000001f398d8] =
driver_attach+0x38/0x50
[    7.850228] [c00000023df63850] [c000000001f39118] =
bus_add_driver+0x308/0x390
[    7.850238] [c00000023df638e0] [c000000001f3bb60] =
driver_register+0xa0/0x180
[    7.850248] [c00000023df63950] [c000000001892848] =
__vio_register_driver+0x68/0xc0
[    7.850262] [c00000023df639d0] [d0000000049a4664] =
init_module+0x90/0xcc [ibmvscsi]
[    7.850273] [c00000023df63a00] [c0000000017fd24c] =
do_one_initcall+0x6c/0x1d0
[    7.850284] [c00000023df63ac0] [c00000000235e8f4] =
do_init_module+0x98/0x264
[    7.850295] [c00000023df63b50] [c00000000198a248] =
load_module+0x25d8/0x28b0
[    7.850306] [c00000023df63d30] [c00000000198a860] =
SyS_finit_module+0xf0/0x170
[    7.850318] [c00000023df63e30] [c0000000017fb184] =
system_call+0x38/0xe0

There are several such traces during boot. Have attached the dmesg.log.

Thanks
-Sachin


--Apple-Mail=_2FB4F60F-C63C-412B-B1AD-6745FBF734BE
Content-Disposition: attachment;
	filename=dmesg.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg.log"
Content-Transfer-Encoding: 7bit

[    0.000000] Reserving 512MB of memory at 128MB for crashkernel (System RAM: 20480MB)
[    0.000000] Allocated 4718592 bytes for 2048 pacas at c000000001340000
[    0.000000] Page sizes from device-tree:
[    0.000000] base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
[    0.000000] base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
[    0.000000] base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
[    0.000000] base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
[    0.000000] base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
[    0.000000] base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
[    0.000000] base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
[    0.000000] Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24
[    0.000000] Using 1TB segments
[    0.000000] Initializing hash mmu with SLB
[    0.000000] Linux version 4.10.0-rc8 (root@alp13) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) ) #1 SMP PREEMPT Thu Feb 16 03:03:58 CST 2017
[    0.000000] Found initrd at 0xc000000002fb0000:0xc0000000161cd1c3
[    0.000000] Using pSeries machine description
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 16 cpus.
[    0.000000] CPU maps initialized for 8 threads per core
[    0.000000]  (thread shift is 3)
[    0.000000] Freed 4653056 bytes for unused pacas
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x1b
[    0.000000] phys_mem_size     = 0x500000000
[    0.000000] dcache_bsize      = 0x80
[    0.000000] icache_bsize      = 0x80
[    0.000000] cpu_features      = 0x27fc7aec18500249
[    0.000000]   possible        = 0x7fffffff18500649
[    0.000000]   always          = 0x0000000018100040
[    0.000000] cpu_user_features = 0xdc0065c2 0xef000000
[    0.000000] mmu_features      = 0x7c004001
[    0.000000] firmware_features = 0x00000001c45ffc5f
[    0.000000] htab_hash_mask    = 0xfffff
[    0.000000] physical_start    = 0x17f0000
[    0.000000] -----------------------------------------------------
[    0.000000] numa: Initmem setup node 0
[    0.000000] numa:   NODE_DATA [mem 0x4fff5e300-0x4fff67fff]
[    0.000000] numa:     NODE_DATA(0) on node 5
[    0.000000] numa: Initmem setup node 4 [mem 0x00000000-0x25fffffff]
[    0.000000] numa:   NODE_DATA [mem 0x25fff6300-0x25fffffff]
[    0.000000] numa: Initmem setup node 5 [mem 0x260000000-0x4ffffffff]
[    0.000000] numa:   NODE_DATA [mem 0x4fff54600-0x4fff5e2ff]
[    0.000000] Section 1277 and 1279 (node 5) have a circular dependency on usemap and pgdat allocations
[    0.000000] PCI host bridge /pci@800000020000038  ranges:
[    0.000000]  MEM 0x00003fca00000000..0x00003fca7effffff -> 0x0000000080000000 
[    0.000000]  MEM 0x0000314000000000..0x0000314fffffffff -> 0x0003d14000000000 
[    0.000000] PPC64 nvram contains 15360 bytes
[    0.000000] Top of RAM: 0x500000000, Total RAM: 0x500000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x00000004ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   4: [mem 0x0000000000000000-0x000000025fffffff]
[    0.000000]   node   5: [mem 0x0000000260000000-0x00000004ffffffff]
[    0.000000] Could not find start_pfn for node 0
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
[    0.000000] On node 0 totalpages: 0
[    0.000000] Initmem setup node 4 [mem 0x0000000000000000-0x000000025fffffff]
[    0.000000] On node 4 totalpages: 155648
[    0.000000]   DMA zone: 152 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 155648 pages, LIFO batch:1
[    0.000000] Initmem setup node 5 [mem 0x0000000260000000-0x00000004ffffffff]
[    0.000000] On node 5 totalpages: 172032
[    0.000000]   DMA zone: 168 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 172032 pages, LIFO batch:1
[    0.000000] percpu: Embedded 3 pages/cpu @c0000004ffb00000 s149528 r0 d47080 u262144
[    0.000000] pcpu-alloc: s149528 r0 d47080 u262144 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.000000] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.000000] Built 3 zonelists in Node order, mobility grouping on.  Total pages: 327360
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: crashkernel=2G-4G:320M,4G-32G:512M root=UUID=3faa3fa2-0397-475a-b16f-15b0abbecb12 
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Memory: 20236608K/20971520K available (11776K kernel code, 1664K rwdata, 3408K rodata, 4352K init, 2983K bss, 734912K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=16, Nodes=6
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] pic: no ISA interrupt controller
[    0.000000] time_init: decrementer frequency = 512.000000 MHz
[    0.000000] time_init: processor frequency   = 3724.000000 MHz
[    0.000004] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.000075] clocksource: timebase mult[1f40000] shift[24] registered
[    0.000122] clockevent: decrementer mult[83126e98] shift[32] cpu[0]
[    0.000221] Console: colour dummy device 80x25
[    0.000284] console [hvc0] enabled
[    0.000313] bootconsole [udbg0] disabled
[    0.000685] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000699] pid_max: default: 32768 minimum: 301
[    0.004014] Security Framework initialized
[    0.004022] Yama: becoming mindful.
[    0.004043] AppArmor: AppArmor initialized
[    0.005307] Dentry cache hash table entries: 4194304 (order: 9, 33554432 bytes)
[    0.027564] Inode-cache hash table entries: 2097152 (order: 8, 16777216 bytes)
[    0.041084] Mount-cache hash table entries: 65536 (order: 3, 524288 bytes)
[    0.041128] Mountpoint-cache hash table entries: 65536 (order: 3, 524288 bytes)
[    0.043950] ftrace: allocating 30181 entries in 12 pages
[    0.082818] EEH: pSeries platform initialized
[    0.082855] POWER8 performance monitor hardware support registered
[    0.118879] smp: Bringing up secondary CPUs ...
[    0.599677] smp: Brought up 3 nodes, 16 CPUs
[    0.599705] numa: Node 0 CPUs:
[    0.599709] numa: Node 4 CPUs: 0-7
[    0.599712] numa: Node 5 CPUs: 8-15
[    0.601955] devtmpfs: initialized
[    0.614383] evm: security.selinux
[    0.614396] evm: security.SMACK64
[    0.614398] evm: security.SMACK64EXEC
[    0.614400] evm: security.SMACK64TRANSMUTE
[    0.614402] evm: security.SMACK64MMAP
[    0.614404] evm: security.ima
[    0.614405] evm: security.capability
[    0.614760] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.615295] NET: Registered protocol family 16
[    0.617633] EEH: PCI Enhanced I/O Error Handling Enabled
[    0.631570] cpuidle: using governor ladder
[    0.647583] cpuidle: using governor menu
[    0.647635] RTAS daemon started
[    0.647714] pstore: using zlib compression
[    0.647717] pstore: Registered nvram as persistent store backend
[    0.651347] PCI: Probing PCI hardware
[    0.651386] PCI host bridge to bus 0038:01
[    0.651391] pci_bus 0038:01: root bus resource [mem 0x3fca00000000-0x3fca7effffff] (bus address [0x80000000-0xfeffffff])
[    0.651396] pci_bus 0038:01: root bus resource [mem 0x314000000000-0x314fffffffff] (bus address [0x3d14000000000-0x3d14fffffffff])
[    0.651401] pci_bus 0038:01: root bus resource [bus 01-ff]
[    0.654411] pci 0038:01:00.0: PME# supported from D0 D3hot
[    0.732465] IOMMU table initialized, virtual merging enabled
[    0.732516] iommu: Adding device 0038:01:00.0 to group 0
[    0.733225] PCI: Probing PCI hardware done
[    0.733330] pseries-rng: Registering arch random hook.
[    0.760866] HugeTLB registered 16 MB page size, pre-allocated 0 pages
[    0.760890] HugeTLB registered 16 GB page size, pre-allocated 0 pages
[    0.762420] vgaarb: loaded
[    0.762747] SCSI subsystem initialized
[    0.762828] libata version 3.00 loaded.
[    0.762861] usbcore: registered new interface driver usbfs
[    0.762871] usbcore: registered new interface driver hub
[    0.762956] usbcore: registered new device driver usb
[    0.762973] pps_core: LinuxPPS API ver. 1 registered
[    0.762976] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.762981] PTP clock support registered
[    0.763283] NetLabel: Initializing
[    0.763285] NetLabel:  domain hash size = 128
[    0.763288] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.763304] NetLabel:  unlabeled traffic allowed by default
[    0.763492] clocksource: Switched to clocksource timebase
[    0.772877] VFS: Disk quotas dquot_6.6.0
[    0.773058] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    0.773263] AppArmor: AppArmor Filesystem Enabled
[    0.775546] NET: Registered protocol family 2
[    0.775749] TCP established hash table entries: 262144 (order: 5, 2097152 bytes)
[    0.776173] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    0.776280] TCP: Hash tables configured (established 262144 bind 65536)
[    0.776301] UDP hash table entries: 16384 (order: 4, 1048576 bytes)
[    0.776411] UDP-Lite hash table entries: 16384 (order: 4, 1048576 bytes)
[    0.776680] NET: Registered protocol family 1
[    0.776791] PCI: CLS 128 bytes, default 128
[    0.776842] Trying to unpack rootfs image as initramfs...
[    4.786510] Freeing initrd memory: 82240K
[    4.815995] hv-24x7: read 1330 catalog entries, created 337 event attrs (0 failures), 169 descs
[    4.816459] futex hash table entries: 4096 (order: 3, 524288 bytes)
[    4.816650] audit: initializing netlink subsys (disabled)
[    4.816728] audit: type=2000 audit(1487241149.728:1): initialized
[    4.817285] Initialise system trusted keyrings
[    4.817494] workingset: timestamp_bits=38 max_order=19 bucket_order=0
[    4.819236] zbud: loaded
[    4.821442] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    4.821960] fuse init (API version 7.26)
[    4.822430] Allocating IMA blacklist keyring.
[    4.824780] Key type asymmetric registered
[    4.824785] Asymmetric key parser 'x509' registered
[    4.824797] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    4.824874] io scheduler noop registered
[    4.824878] io scheduler deadline registered (default)
[    4.824886] io scheduler cfq registered
[    4.825466] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    4.826726] Linux agpgart interface v0.103
[    7.739867] tpm_ibmvtpm 30000003: CRQ initialization completed
[    7.743379] brd: module loaded
[    7.745338] loop: module loaded
[    7.745517] libphy: Fixed MDIO Bus: probed
[    7.745519] tun: Universal TUN/TAP device driver, 1.6
[    7.745522] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    7.745557] ibmveth: IBM Power Virtual Ethernet Driver 1.06
[    7.745693] PPP generic driver version 2.4.2
[    7.745755] VFIO - User Level meta-driver version: 0.3
[    7.746257] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.746286] ehci-pci: EHCI PCI platform driver
[    7.746311] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.746318] ohci-pci: OHCI PCI platform driver
[    7.746334] uhci_hcd: USB Universal Host Controller Interface driver
[    7.746513] mousedev: PS/2 mouse device common for all mice
[    7.746708] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[    7.746719] i2c /dev entries driver
[    7.747038] device-mapper: uevent: version 1.0.3
[    7.747309] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    7.747548] pseries_idle_driver registered
[    7.747785] ledtrig-cpu: registered to indicate activity on CPUs
[    7.748722] NET: Registered protocol family 10
[    7.749099] Segment Routing with IPv6
[    7.749112] NET: Registered protocol family 17
[    7.749121] Key type dns_resolver registered
[    7.749262] registered taskstats version 1
[    7.749268] Loading compiled-in X.509 certificates
[    7.751602] Loaded X.509 cert 'Build time autogenerated kernel key: 772d826f2e401f7b1e7ab1909ba66dc378229671'
[    7.751629] zswap: loaded using pool lzo/zbud
[    7.770773] Key type big_key registered
[    7.772520] Key type trusted registered
[    7.774307] Key type encrypted registered
[    7.774314] AppArmor: AppArmor sha1 policy hashing enabled
[    7.775615] evm: HMAC attrs: 0x1
[    7.776285] rtc-generic rtc-generic: setting system clock to 2017-02-16 10:32:32 UTC (1487241152)
[    7.777128] Freeing unused kernel memory: 4352K
[    7.777132] This architecture does not have kernel memory protection.
[    7.787887] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    7.788019] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    7.788036] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    7.788585] random: udevadm: uninitialized urandom read (16 bytes read)
[    7.788649] random: udevadm: uninitialized urandom read (16 bytes read)
[    7.788777] random: udevadm: uninitialized urandom read (16 bytes read)
[    7.788910] random: udevadm: uninitialized urandom read (16 bytes read)
[    7.788934] random: udevadm: uninitialized urandom read (16 bytes read)
[    7.789095] random: udevadm: uninitialized urandom read (16 bytes read)
[    7.789174] random: udevadm: uninitialized urandom read (16 bytes read)
[    7.834713] ibmveth 30000002 ibmveth2: renamed from eth0
[    7.850025] BUG: using __this_cpu_read() in preemptible [00000000] code: systemd-udevd/266
[    7.850068] caller is iommu_range_alloc+0x98/0x3e0
[    7.850078] CPU: 4 PID: 266 Comm: systemd-udevd Not tainted 4.10.0-rc8 #1
[    7.850085] Call Trace:
[    7.850095] [c00000023df632d0] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[    7.850109] [c00000023df63310] [c000000001e06754] check_preemption_disabled+0x164/0x170
[    7.850120] [c00000023df633a0] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[    7.850131] [c00000023df63450] [c000000001832ad4] iommu_alloc+0x64/0x170
[    7.850141] [c00000023df634a0] [c000000001833fe0] iommu_map_page+0xd0/0x1d0
[    7.850150] [c00000023df63530] [c0000000018320d8] dma_iommu_map_page+0x58/0xa0
[    7.850163] [c00000023df63550] [d0000000049a3c78] ibmvscsi_probe+0x138/0xa94 [ibmvscsi]
[    7.850175] [c00000023df63630] [c0000000018951c4] vio_bus_probe+0x1a4/0x460
[    7.850186] [c00000023df636d0] [c000000001f3a490] driver_probe_device+0x300/0x5a0
[    7.850196] [c00000023df63760] [c000000001f3a89c] __driver_attach+0x16c/0x170
[    7.850207] [c00000023df637e0] [c000000001f3701c] bus_for_each_dev+0x8c/0xf0
[    7.850217] [c00000023df63830] [c000000001f398d8] driver_attach+0x38/0x50
[    7.850228] [c00000023df63850] [c000000001f39118] bus_add_driver+0x308/0x390
[    7.850238] [c00000023df638e0] [c000000001f3bb60] driver_register+0xa0/0x180
[    7.850248] [c00000023df63950] [c000000001892848] __vio_register_driver+0x68/0xc0
[    7.850262] [c00000023df639d0] [d0000000049a4664] init_module+0x90/0xcc [ibmvscsi]
[    7.850273] [c00000023df63a00] [c0000000017fd24c] do_one_initcall+0x6c/0x1d0
[    7.850284] [c00000023df63ac0] [c00000000235e8f4] do_init_module+0x98/0x264
[    7.850295] [c00000023df63b50] [c00000000198a248] load_module+0x25d8/0x28b0
[    7.850306] [c00000023df63d30] [c00000000198a860] SyS_finit_module+0xf0/0x170
[    7.850318] [c00000023df63e30] [c0000000017fb184] system_call+0x38/0xe0
[    7.850342] BUG: using __this_cpu_read() in preemptible [00000000] code: systemd-udevd/266
[    7.850351] caller is iommu_range_alloc+0x98/0x3e0
[    7.850358] CPU: 4 PID: 266 Comm: systemd-udevd Not tainted 4.10.0-rc8 #1
[    7.850365] Call Trace:
[    7.850371] [c00000023df632d0] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[    7.850384] [c00000023df63310] [c000000001e06754] check_preemption_disabled+0x164/0x170
[    7.850395] [c00000023df633a0] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[    7.850406] [c00000023df63450] [c000000001832ad4] iommu_alloc+0x64/0x170
[    7.850417] [c00000023df634a0] [c000000001833fe0] iommu_map_page+0xd0/0x1d0
[    7.850427] [c00000023df63530] [c0000000018320d8] dma_iommu_map_page+0x58/0xa0
[    7.850441] [c00000023df63550] [d0000000049a3d10] ibmvscsi_probe+0x1d0/0xa94 [ibmvscsi]
[    7.850452] [c00000023df63630] [c0000000018951c4] vio_bus_probe+0x1a4/0x460
[    7.850462] [c00000023df636d0] [c000000001f3a490] driver_probe_device+0x300/0x5a0
[    7.850473] [c00000023df63760] [c000000001f3a89c] __driver_attach+0x16c/0x170
[    7.850484] [c00000023df637e0] [c000000001f3701c] bus_for_each_dev+0x8c/0xf0
[    7.850495] [c00000023df63830] [c000000001f398d8] driver_attach+0x38/0x50
[    7.850504] [c00000023df63850] [c000000001f39118] bus_add_driver+0x308/0x390
[    7.850513] [c00000023df638e0] [c000000001f3bb60] driver_register+0xa0/0x180
[    7.850523] [c00000023df63950] [c000000001892848] __vio_register_driver+0x68/0xc0
[    7.850535] [c00000023df639d0] [d0000000049a4664] init_module+0x90/0xcc [ibmvscsi]
[    7.850545] [c00000023df63a00] [c0000000017fd24c] do_one_initcall+0x6c/0x1d0
[    7.850556] [c00000023df63ac0] [c00000000235e8f4] do_init_module+0x98/0x264
[    7.850567] [c00000023df63b50] [c00000000198a248] load_module+0x25d8/0x28b0
[    7.850578] [c00000023df63d30] [c00000000198a860] SyS_finit_module+0xf0/0x170
[    7.850590] [c00000023df63e30] [c0000000017fb184] system_call+0x38/0xe0
[    7.850645] BUG: using __this_cpu_read() in preemptible [00000000] code: systemd-udevd/266
[    7.850655] caller is iommu_range_alloc+0x98/0x3e0
[    7.850662] CPU: 4 PID: 266 Comm: systemd-udevd Not tainted 4.10.0-rc8 #1
[    7.850669] Call Trace:
[    7.850675] [c00000023df632d0] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[    7.850687] [c00000023df63310] [c000000001e06754] check_preemption_disabled+0x164/0x170
[    7.850697] [c00000023df633a0] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[    7.850708] [c00000023df63450] [c000000001832ad4] iommu_alloc+0x64/0x170
[    7.850719] [c00000023df634a0] [c000000001833fe0] iommu_map_page+0xd0/0x1d0
[    7.850729] [c00000023df63530] [c0000000018320d8] dma_iommu_map_page+0x58/0xa0
[    7.850741] [c00000023df63550] [d0000000049a3e1c] ibmvscsi_probe+0x2dc/0xa94 [ibmvscsi]
[    7.850751] [c00000023df63630] [c0000000018951c4] vio_bus_probe+0x1a4/0x460
[    7.850759] [c00000023df636d0] [c000000001f3a490] driver_probe_device+0x300/0x5a0
[    7.850768] [c00000023df63760] [c000000001f3a89c] __driver_attach+0x16c/0x170
[    7.850777] [c00000023df637e0] [c000000001f3701c] bus_for_each_dev+0x8c/0xf0
[    7.850786] [c00000023df63830] [c000000001f398d8] driver_attach+0x38/0x50
[    7.850795] [c00000023df63850] [c000000001f39118] bus_add_driver+0x308/0x390
[    7.850805] [c00000023df638e0] [c000000001f3bb60] driver_register+0xa0/0x180
[    7.850814] [c00000023df63950] [c000000001892848] __vio_register_driver+0x68/0xc0
[    7.850824] [c00000023df639d0] [d0000000049a4664] init_module+0x90/0xcc [ibmvscsi]
[    7.850834] [c00000023df63a00] [c0000000017fd24c] do_one_initcall+0x6c/0x1d0
[    7.850844] [c00000023df63ac0] [c00000000235e8f4] do_init_module+0x98/0x264
[    7.850853] [c00000023df63b50] [c00000000198a248] load_module+0x25d8/0x28b0
[    7.850862] [c00000023df63d30] [c00000000198a860] SyS_finit_module+0xf0/0x170
[    7.850871] [c00000023df63e30] [c0000000017fb184] system_call+0x38/0xe0
[    7.850896] ibmvscsi 30000071: SRP_VERSION: 16.a
[    7.891696] cxgb3: Chelsio T3 Network Driver - version 1.1.5-ko
[    7.892039] cxgb3 0038:01:00.0: Using 64-bit direct DMA at offset 800000000000000
[    8.110528] cxgb3 0038:01:00.0: Port 0 using 8 queue sets.
[    8.110540] cxgb3 0038:01:00.0 eth0: Chelsio T310 10GBASE-R RNIC (rev 4) PCI Express x8 MSI-X
[    8.110544] cxgb3: eth0: 128MB CM, 256MB PMTX, 256MB PMRX, S/N: 51YL502430908J  
[    8.112373] cxgb3 0038:01:00.0 enP56p1s0: renamed from eth0
[   13.787626] ibmvscsi 30000071: SRP_VERSION: 16.a
[   13.787835] BUG: using __this_cpu_read() in preemptible [00000000] code: systemd-udevd/266
[   13.787841] caller is iommu_range_alloc+0x98/0x3e0
[   13.787845] CPU: 4 PID: 266 Comm: systemd-udevd Not tainted 4.10.0-rc8 #1
[   13.787848] Call Trace:
[   13.787852] [c00000023df632c0] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[   13.787858] [c00000023df63300] [c000000001e06754] check_preemption_disabled+0x164/0x170
[   13.787862] [c00000023df63390] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[   13.787866] [c00000023df63440] [c000000001832ad4] iommu_alloc+0x64/0x170
[   13.787870] [c00000023df63490] [c000000001834290] iommu_alloc_coherent+0x130/0x1d0
[   13.787875] [c00000023df63530] [c00000000183219c] dma_iommu_alloc_coherent+0x3c/0x60
[   13.787880] [c00000023df63550] [d0000000049a403c] ibmvscsi_probe+0x4fc/0xa94 [ibmvscsi]
[   13.787885] [c00000023df63630] [c0000000018951c4] vio_bus_probe+0x1a4/0x460
[   13.787888] [c00000023df636d0] [c000000001f3a490] driver_probe_device+0x300/0x5a0
[   13.787892] [c00000023df63760] [c000000001f3a89c] __driver_attach+0x16c/0x170
[   13.787897] [c00000023df637e0] [c000000001f3701c] bus_for_each_dev+0x8c/0xf0
[   13.787900] [c00000023df63830] [c000000001f398d8] driver_attach+0x38/0x50
[   13.787904] [c00000023df63850] [c000000001f39118] bus_add_driver+0x308/0x390
[   13.787908] [c00000023df638e0] [c000000001f3bb60] driver_register+0xa0/0x180
[   13.787912] [c00000023df63950] [c000000001892848] __vio_register_driver+0x68/0xc0
[   13.787916] [c00000023df639d0] [d0000000049a4664] init_module+0x90/0xcc [ibmvscsi]
[   13.787921] [c00000023df63a00] [c0000000017fd24c] do_one_initcall+0x6c/0x1d0
[   13.787924] [c00000023df63ac0] [c00000000235e8f4] do_init_module+0x98/0x264
[   13.787929] [c00000023df63b50] [c00000000198a248] load_module+0x25d8/0x28b0
[   13.787933] [c00000023df63d30] [c00000000198a860] SyS_finit_module+0xf0/0x170
[   13.787937] [c00000023df63e30] [c0000000017fb184] system_call+0x38/0xe0
[   13.787947] ibmvscsi 30000071: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
[   13.787951] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
[   13.788178] ibmvscsi 30000071: partner initialization complete
[   13.788229] ibmvscsi 30000071: host srp version: 16.a, host partition alp18-VIOS (100), OS 3, max io 1048576
[   13.788306] ibmvscsi 30000071: Client reserve enabled
[   13.788317] ibmvscsi 30000071: sent SRP login
[   13.788359] ibmvscsi 30000071: SRP_LOGIN succeeded
[   13.808086] scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
[   13.808328] scsi 0:0:2:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
[   13.809884] random: fast init done
[   13.857744] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   13.857829] sd 0:0:1:0: [sda] 230686720 512-byte logical blocks: (118 GB/110 GiB)
[   13.857900] sd 0:0:1:0: [sda] Write Protect is off
[   13.857908] sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08
[   13.857961] sd 0:0:1:0: [sda] Cache data unavailable
[   13.857969] sd 0:0:1:0: [sda] Assuming drive cache: write through
[   13.858085] sr 0:0:2:0: [sr0] scsi-1 drive
[   13.858092] cdrom: Uniform CD-ROM driver Revision: 3.20
[   13.858415] sr 0:0:2:0: Attached scsi CD-ROM sr0
[   13.858577] sr 0:0:2:0: Attached scsi generic sg1 type 5
[   13.873806]  sda: sda1 sda2 sda3
[   13.874226] sd 0:0:1:0: [sda] Attached SCSI disk
[   15.115752] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   15.513362] random: crng init done
[   15.569113] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[   15.569260] systemd[1]: Detected architecture ppc64-le.
[   15.580164] systemd[1]: Set hostname to <alp13>.
[   15.668031] systemd-sysv-generator[591]: Configuration file /lib/systemd/system/opal_errd.service is marked executable. Please remove executable permission bits. Proceeding anyway.
[   15.781800] systemd-sysv-generator[591]: Configuration file /lib/systemd/system/rtas_errd.service is marked executable. Please remove executable permission bits. Proceeding anyway.
[   16.023224] systemd[1]: Configuration file /lib/systemd/system/opal_errd.service is marked executable. Please remove executable permission bits. Proceeding anyway.
[   16.023550] systemd[1]: Configuration file /lib/systemd/system/rtas_errd.service is marked executable. Please remove executable permission bits. Proceeding anyway.
[   16.034913] systemd[1]: Created slice System Slice.
[   16.035241] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   16.035407] systemd[1]: Reached target Encrypted Volumes.
[   16.035637] systemd[1]: Created slice system-serial\x2dgetty.slice.
[   16.035830] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   16.596163] RPC: Registered named UNIX socket transport module.
[   16.596165] RPC: Registered udp transport module.
[   16.596166] RPC: Registered tcp transport module.
[   16.596166] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   16.712999] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   16.810109] systemd-journald[605]: Received request to flush runtime journal from PID 1
[   16.989479] crypto_register_alg 'aes' = 0
[   16.989915] crypto_register_alg 'cbc(aes)' = 0
[   16.990559] crypto_register_alg 'ctr(aes)' = 0
[   16.991867] crypto_register_alg 'xts(aes)' = 0
[   17.011267] pseries_rng: Registering IBM pSeries RNG driver
[   17.419791] Adding 4714432k swap on /dev/sda3.  Priority:-1 extents:1 across:4714432k FS
[   17.627432] audit: type=1400 audit(1487241162.344:2): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=1288 comm="apparmor_parser"
[   17.708577] audit: type=1400 audit(1487241162.428:3): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient" pid=1287 comm="apparmor_parser"
[   17.708707] audit: type=1400 audit(1487241162.428:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=1287 comm="apparmor_parser"
[   17.708792] audit: type=1400 audit(1487241162.428:5): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=1287 comm="apparmor_parser"
[   17.708873] audit: type=1400 audit(1487241162.428:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=1287 comm="apparmor_parser"
[   18.319953] ipmi message handler version 39.2
[   18.336078] ipmi device interface
[   18.369589] IPMI System Interface driver.
[   18.369666] ipmi_si: Unable to find any System Interface(s)
[   18.370217] BUG: using __this_cpu_read() in preemptible [00000000] code: ip/1411
[   18.370250] caller is iommu_range_alloc+0x98/0x3e0
[   18.370257] CPU: 14 PID: 1411 Comm: ip Not tainted 4.10.0-rc8 #1
[   18.370262] Call Trace:
[   18.370273] [c0000004f743b110] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[   18.370290] [c0000004f743b150] [c000000001e06754] check_preemption_disabled+0x164/0x170
[   18.370297] [c0000004f743b1e0] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[   18.370304] [c0000004f743b290] [c000000001832ad4] iommu_alloc+0x64/0x170
[   18.370310] [c0000004f743b2e0] [c000000001834290] iommu_alloc_coherent+0x130/0x1d0
[   18.370319] [c0000004f743b380] [c00000000183219c] dma_iommu_alloc_coherent+0x3c/0x60
[   18.370327] [c0000004f743b3a0] [c000000002033708] ibmveth_open+0x168/0x7c0
[   18.370334] [c0000004f743b450] [c0000000021d67c0] __dev_open+0x160/0x220
[   18.370339] [c0000004f743b4e0] [c0000000021d6c4c] __dev_change_flags+0xdc/0x1e0
[   18.370345] [c0000004f743b560] [c0000000021d6d90] dev_change_flags+0x40/0xa0
[   18.370353] [c0000004f743b5a0] [c0000000021ed4a8] do_setlink+0x388/0xf30
[   18.370359] [c0000004f743b710] [c0000000021f0240] rtnl_newlink+0x570/0x9a0
[   18.370364] [c0000004f743b9f0] [c0000000021f07b4] rtnetlink_rcv_msg+0x144/0x2c0
[   18.370372] [c0000004f743ba70] [c0000000022239b8] netlink_rcv_skb+0x118/0x160
[   18.370377] [c0000004f743bab0] [c0000000021ec9e8] rtnetlink_rcv+0x48/0x70
[   18.370383] [c0000004f743bae0] [c000000002222f80] netlink_unicast+0x1f0/0x300
[   18.370388] [c0000004f743bb40] [c00000000222360c] netlink_sendmsg+0x3dc/0x490
[   18.370394] [c0000004f743bbd0] [c0000000021a5e88] sock_sendmsg+0x68/0xa0
[   18.370399] [c0000004f743bc00] [c0000000021a6bac] ___sys_sendmsg+0x30c/0x320
[   18.370404] [c0000004f743bd90] [c0000000021a8290] __sys_sendmsg+0x60/0xc0
[   18.370411] [c0000004f743be30] [c0000000017fb184] system_call+0x38/0xe0
[   18.370426] BUG: using __this_cpu_read() in preemptible [00000000] code: ip/1411
[   18.370436] caller is iommu_range_alloc+0x98/0x3e0
[   18.370441] CPU: 14 PID: 1411 Comm: ip Not tainted 4.10.0-rc8 #1
[   18.370443] Call Trace:
[   18.370447] [c0000004f743b120] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[   18.370454] [c0000004f743b160] [c000000001e06754] check_preemption_disabled+0x164/0x170
[   18.370459] [c0000004f743b1f0] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[   18.370465] [c0000004f743b2a0] [c000000001832ad4] iommu_alloc+0x64/0x170
[   18.370470] [c0000004f743b2f0] [c000000001833fe0] iommu_map_page+0xd0/0x1d0
[   18.370479] [c0000004f743b380] [c0000000018320d8] dma_iommu_map_page+0x58/0xa0
[   18.370486] [c0000004f743b3a0] [c000000002033768] ibmveth_open+0x1c8/0x7c0
[   18.370491] [c0000004f743b450] [c0000000021d67c0] __dev_open+0x160/0x220
[   18.370497] [c0000004f743b4e0] [c0000000021d6c4c] __dev_change_flags+0xdc/0x1e0
[   18.370502] [c0000004f743b560] [c0000000021d6d90] dev_change_flags+0x40/0xa0
[   18.370508] [c0000004f743b5a0] [c0000000021ed4a8] do_setlink+0x388/0xf30
[   18.370513] [c0000004f743b710] [c0000000021f0240] rtnl_newlink+0x570/0x9a0
[   18.370519] [c0000004f743b9f0] [c0000000021f07b4] rtnetlink_rcv_msg+0x144/0x2c0
[   18.370525] [c0000004f743ba70] [c0000000022239b8] netlink_rcv_skb+0x118/0x160
[   18.370531] [c0000004f743bab0] [c0000000021ec9e8] rtnetlink_rcv+0x48/0x70
[   18.370536] [c0000004f743bae0] [c000000002222f80] netlink_unicast+0x1f0/0x300
[   18.370542] [c0000004f743bb40] [c00000000222360c] netlink_sendmsg+0x3dc/0x490
[   18.370547] [c0000004f743bbd0] [c0000000021a5e88] sock_sendmsg+0x68/0xa0
[   18.370553] [c0000004f743bc00] [c0000000021a6bac] ___sys_sendmsg+0x30c/0x320
[   18.370558] [c0000004f743bd90] [c0000000021a8290] __sys_sendmsg+0x60/0xc0
[   18.370565] [c0000004f743be30] [c0000000017fb184] system_call+0x38/0xe0
[   18.370574] BUG: using __this_cpu_read() in preemptible [00000000] code: ip/1411
[   18.370584] caller is iommu_range_alloc+0x98/0x3e0
[   18.370588] CPU: 14 PID: 1411 Comm: ip Not tainted 4.10.0-rc8 #1
[   18.370590] Call Trace:
[   18.370595] [c0000004f743b120] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[   18.370601] [c0000004f743b160] [c000000001e06754] check_preemption_disabled+0x164/0x170
[   18.370607] [c0000004f743b1f0] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[   18.370613] [c0000004f743b2a0] [c000000001832ad4] iommu_alloc+0x64/0x170
[   18.370619] [c0000004f743b2f0] [c000000001833fe0] iommu_map_page+0xd0/0x1d0
[   18.370625] [c0000004f743b380] [c0000000018320d8] dma_iommu_map_page+0x58/0xa0
[   18.370632] [c0000004f743b3a0] [c0000000020337b4] ibmveth_open+0x214/0x7c0
[   18.370638] [c0000004f743b450] [c0000000021d67c0] __dev_open+0x160/0x220
[   18.370645] [c0000004f743b4e0] [c0000000021d6c4c] __dev_change_flags+0xdc/0x1e0
[   18.370654] [c0000004f743b560] [c0000000021d6d90] dev_change_flags+0x40/0xa0
[   18.370665] [c0000004f743b5a0] [c0000000021ed4a8] do_setlink+0x388/0xf30
[   18.370671] [c0000004f743b710] [c0000000021f0240] rtnl_newlink+0x570/0x9a0
[   18.370678] [c0000004f743b9f0] [c0000000021f07b4] rtnetlink_rcv_msg+0x144/0x2c0
[   18.370684] [c0000004f743ba70] [c0000000022239b8] netlink_rcv_skb+0x118/0x160
[   18.370689] [c0000004f743bab0] [c0000000021ec9e8] rtnetlink_rcv+0x48/0x70
[   18.370695] [c0000004f743bae0] [c000000002222f80] netlink_unicast+0x1f0/0x300
[   18.370702] [c0000004f743bb40] [c00000000222360c] netlink_sendmsg+0x3dc/0x490
[   18.370708] [c0000004f743bbd0] [c0000000021a5e88] sock_sendmsg+0x68/0xa0
[   18.370721] [c0000004f743bc00] [c0000000021a6bac] ___sys_sendmsg+0x30c/0x320
[   18.370727] [c0000004f743bd90] [c0000000021a8290] __sys_sendmsg+0x60/0xc0
[   18.370733] [c0000004f743be30] [c0000000017fb184] system_call+0x38/0xe0
[   18.371041] BUG: using __this_cpu_read() in preemptible [00000000] code: ip/1411
[   18.371051] caller is iommu_range_alloc+0x98/0x3e0
[   18.371054] CPU: 14 PID: 1411 Comm: ip Not tainted 4.10.0-rc8 #1
[   18.371056] Call Trace:
[   18.371061] [c0000004f743b120] [c00000000235ff24] dump_stack+0xb4/0xf4 (unreliable)
[   18.371067] [c0000004f743b160] [c000000001e06754] check_preemption_disabled+0x164/0x170
[   18.371073] [c0000004f743b1f0] [c000000001832508] iommu_range_alloc+0x98/0x3e0
[   18.371077] [c0000004f743b2a0] [c000000001832ad4] iommu_alloc+0x64/0x170
[   18.371082] [c0000004f743b2f0] [c000000001833fe0] iommu_map_page+0xd0/0x1d0
[   18.371085] [c0000004f743b380] [c0000000018320d8] dma_iommu_map_page+0x58/0xa0
[   18.371089] [c0000004f743b3a0] [c000000002033a10] ibmveth_open+0x470/0x7c0
[   18.371093] [c0000004f743b450] [c0000000021d67c0] __dev_open+0x160/0x220
[   18.371096] [c0000004f743b4e0] [c0000000021d6c4c] __dev_change_flags+0xdc/0x1e0
[   18.371100] [c0000004f743b560] [c0000000021d6d90] dev_change_flags+0x40/0xa0
[   18.371105] [c0000004f743b5a0] [c0000000021ed4a8] do_setlink+0x388/0xf30
[   18.371109] [c0000004f743b710] [c0000000021f0240] rtnl_newlink+0x570/0x9a0
[   18.371113] [c0000004f743b9f0] [c0000000021f07b4] rtnetlink_rcv_msg+0x144/0x2c0
[   18.371117] [c0000004f743ba70] [c0000000022239b8] netlink_rcv_skb+0x118/0x160
[   18.371122] [c0000004f743bab0] [c0000000021ec9e8] rtnetlink_rcv+0x48/0x70
[   18.371125] [c0000004f743bae0] [c000000002222f80] netlink_unicast+0x1f0/0x300
[   18.371129] [c0000004f743bb40] [c00000000222360c] netlink_sendmsg+0x3dc/0x490
[   18.371133] [c0000004f743bbd0] [c0000000021a5e88] sock_sendmsg+0x68/0xa0
[   18.371138] [c0000004f743bc00] [c0000000021a6bac] ___sys_sendmsg+0x30c/0x320
[   18.371143] [c0000004f743bd90] [c0000000021a8290] __sys_sendmsg+0x60/0xc0
[   18.371147] [c0000004f743be30] [c0000000017fb184] system_call+0x38/0xe0

--Apple-Mail=_2FB4F60F-C63C-412B-B1AD-6745FBF734BE--
