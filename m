Return-Path: <srs0=umlw=3o=linux.vnet.ibm.com=sachinp@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzJpR6N6gzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 20:28:47 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzJpR5hh9z8w2W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 20:28:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzJpR1QFcz9s8T
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2017 20:28:47 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36ANqVa029813
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 06:28:43 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29nddrudwy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 06:28:43 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 20:28:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v36ASSf041222372
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 20:28:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v36AS0gq002673
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 20:28:00 +1000
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_E93CECD4-C7B3-4E9D-846C-8123F225A26B"
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: WARN @lib/refcount.c:128 during hot unplug of I/O adapter.
Date: Thu, 6 Apr 2017 15:57:45 +0530
Cc: LKML <linux-kernel@vger.kernel.org>
To: linuxppc-dev@ozlabs.org
Message-Id: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_E93CECD4-C7B3-4E9D-846C-8123F225A26B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On a POWER8 LPAR running 4.11.0-rc5, a hot unplug operation on
any I/O adapter results in the following warning

This problem has been in the code for some time now. I had first seen =
this in
-next tree.

[  269.589441] rpadlpar_io: slot PHB 72 removed
[  270.589997] refcount_t: underflow; use-after-free.
[  270.590019] ------------[ cut here ]------------
[  270.590025] WARNING: CPU: 5 PID: 3335 at lib/refcount.c:128 =
refcount_sub_and_test+0xf4/0x110
[  270.590028] Modules linked in: xt_CHECKSUM iptable_mangle =
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat =
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT =
nf_reject_ipv4 tun bridge stp llc rpadlpar_io rpaphp kvm_pr kvm =
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter =
dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag =
netlink_diag ghash_generic xts gf128mul vmx_crypto tpm_ibmvtpm tpm sg =
pseries_rng nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc =
ip_tables xfs libcrc32c sr_mod sd_mod cdrom ibmvscsi ibmveth =
scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
[  270.590076] CPU: 5 PID: 3335 Comm: drmgr Not tainted 4.11.0-rc5 #3
[  270.590079] task: c0000005d8df8600 task.stack: c0000000fb3a8000
[  270.590081] NIP: c000000001aa3ca4 LR: c000000001aa3ca0 CTR: =
00000000006338e4
[  270.590084] REGS: c0000000fb3ab8a0 TRAP: 0700   Not tainted  =
(4.11.0-rc5)
[  270.590087] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
[  270.590090]   CR: 22002422  XER: 00000007
[  270.590093] CFAR: c000000001edaabc SOFTE: 1=20
[  270.590093] GPR00: c000000001aa3ca0 c0000000fb3abb20 c0000000025ea900 =
0000000000000026=20
[  270.590093] GPR04: c00000077fc4ada0 c00000077fc617b8 00000000000f0c33 =
0000000000000000=20
[  270.590093] GPR08: 0000000000000000 c00000000227146c 000000077d9e0000 =
0000000000003ff0=20
[  270.590093] GPR12: 0000000000002200 c00000000e802d00 0000000000000000 =
0000000000000000=20
[  270.590093] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[  270.590093] GPR20: 0000000000000000 000000001001b5a8 0000000010018338 =
0000000010016650=20
[  270.590093] GPR24: 000000001001b278 c000000776e0fdcc 0000000010016650 =
0000000000000000=20
[  270.590093] GPR28: c00000077ffea910 c0000000fbf79180 c000000776e0fdc0 =
c0000000fbf791d8=20
[  270.590126] NIP [c000000001aa3ca4] refcount_sub_and_test+0xf4/0x110
[  270.590129] LR [c000000001aa3ca0] refcount_sub_and_test+0xf0/0x110
[  270.590132] Call Trace:
[  270.590134] [c0000000fb3abb20] [c000000001aa3ca0] =
refcount_sub_and_test+0xf0/0x110 (unreliable)
[  270.590139] [c0000000fb3abb80] [c000000001a8221c] =
kobject_put+0x3c/0xa0
[  270.590143] [c0000000fb3abbf0] [c000000001d22d34] =
of_node_put+0x24/0x40
[  270.590147] [c0000000fb3abc10] [c00000000165c874] =
ofdt_write+0x204/0x6b0
[  270.590151] [c0000000fb3abcd0] [c00000000197a220] =
proc_reg_write+0x80/0xd0
[  270.590155] [c0000000fb3abd00] [c0000000018de680] =
__vfs_write+0x40/0x1c0
[  270.590158] [c0000000fb3abd90] [c0000000018dffd8] =
vfs_write+0xc8/0x240
[  270.590162] [c0000000fb3abde0] [c0000000018e1c40] =
SyS_write+0x60/0x110
[  270.590165] [c0000000fb3abe30] [c0000000015cb184] =
system_call+0x38/0xe0
[  270.590168] Instruction dump:
[  270.590170] 7863d182 4e800020 7c0802a6 39200001 3d42fff8 3c62ffb1 =
386371a8 992a0171=20
[  270.590175] f8010010 f821ffa1 48436de1 60000000 <0fe00000> 38210060 =
38600000 e8010010=20
[  270.590180] ---[ end trace 08c7a2f3c8bead33 ]=E2=80=94

Have attached the dmesg log from the system. Let me know if any =
additional
information is required to help debug this problem.

Thanks
-Sachin



--Apple-Mail=_E93CECD4-C7B3-4E9D-846C-8123F225A26B
Content-Disposition: attachment;
	filename=dmesg-4.11-rc5.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg-4.11-rc5.log"
Content-Transfer-Encoding: 7bit

[    0.000000] Allocated 4718592 bytes for 2048 pacas at c00000000e800000
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
[    0.000000] Linux version 4.11.0-rc5 (root@alp13.pok.stglabs.ibm.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #3 SMP Thu Apr 6 01:28:06 PDT 2017
[    0.000000] Found initrd at 0xc0000000029f0000:0xc000000004d638dd
[    0.000000] Using pSeries machine description
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 16 cpus.
[    0.000000] CPU maps initialized for 8 threads per core
[    0.000000]  (thread shift is 3)
[    0.000000] Freed 4653056 bytes for unused pacas
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x1c
[    0.000000] phys_mem_size     = 0x780000000
[    0.000000] dcache_bsize      = 0x80
[    0.000000] icache_bsize      = 0x80
[    0.000000] cpu_features      = 0x27fc7aec18500249
[    0.000000]   possible        = 0x7fffffff18500649
[    0.000000]   always          = 0x0000000018100040
[    0.000000] cpu_user_features = 0xdc0065c2 0xef000000
[    0.000000] mmu_features      = 0x7c004001
[    0.000000] firmware_features = 0x00000001c45ffc5f
[    0.000000] htab_hash_mask    = 0x1fffff
[    0.000000] physical_start    = 0x15c0000
[    0.000000] -----------------------------------------------------
[    0.000000] numa: Initmem setup node 0
[    0.000000] numa:   NODE_DATA [mem 0x77ff5e300-0x77ff67fff]
[    0.000000] numa:     NODE_DATA(0) on node 7
[    0.000000] numa: Initmem setup node 6 [mem 0x00000000-0x5dfffffff]
[    0.000000] numa:   NODE_DATA [mem 0x5dfff6300-0x5dfffffff]
[    0.000000] numa: Initmem setup node 7 [mem 0x5e0000000-0x77fffffff]
[    0.000000] numa:   NODE_DATA [mem 0x77ff54600-0x77ff5e2ff]
[    0.000000] PPC64 nvram contains 15360 bytes
[    0.000000] Top of RAM: 0x780000000, Total RAM: 0x780000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000077fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   6: [mem 0x0000000000000000-0x00000005dfffffff]
[    0.000000]   node   7: [mem 0x00000005e0000000-0x000000077fffffff]
[    0.000000] Could not find start_pfn for node 0
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
[    0.000000] On node 0 totalpages: 0
[    0.000000] Initmem setup node 6 [mem 0x0000000000000000-0x00000005dfffffff]
[    0.000000] On node 6 totalpages: 385024
[    0.000000]   DMA zone: 376 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 385024 pages, LIFO batch:1
[    0.000000] Initmem setup node 7 [mem 0x00000005e0000000-0x000000077fffffff]
[    0.000000] On node 7 totalpages: 106496
[    0.000000]   DMA zone: 104 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 106496 pages, LIFO batch:1
[    0.000000] percpu: Embedded 3 pages/cpu @c00000077fb00000 s156184 r0 d40424 u262144
[    0.000000] pcpu-alloc: s156184 r0 d40424 u262144 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.000000] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.000000] Built 3 zonelists in Node order, mobility grouping on.  Total pages: 491040
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: root=/dev/mapper/rhel_alp13-root 
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Memory: 31276544K/31457280K available (9408K kernel code, 1536K rwdata, 2844K rodata, 3072K init, 3649K bss, 180736K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=16, Nodes=8
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=16.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=16
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] pic: no ISA interrupt controller
[    0.000000] time_init: decrementer frequency = 512.000000 MHz
[    0.000000] time_init: processor frequency   = 3724.000000 MHz
[    0.000003] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.000065] clocksource: timebase mult[1f40000] shift[24] registered
[    0.000109] clockevent: decrementer mult[83126e98] shift[32] cpu[6]
[    0.000189] Console: colour dummy device 80x25
[    0.000221] console [hvc0] enabled
[    0.000245] bootconsole [udbg0] disabled
[    0.000463] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000477] pid_max: default: 32768 minimum: 301
[    0.002306] Security Framework initialized
[    0.002313] SELinux:  Initializing.
[    0.002483] SELinux:  Starting in permissive mode
[    0.003244] Dentry cache hash table entries: 4194304 (order: 9, 33554432 bytes)
[    0.022959] Inode-cache hash table entries: 2097152 (order: 8, 16777216 bytes)
[    0.034468] Mount-cache hash table entries: 65536 (order: 3, 524288 bytes)
[    0.034510] Mountpoint-cache hash table entries: 65536 (order: 3, 524288 bytes)
[    0.036509] EEH: pSeries platform initialized
[    0.036518] POWER8 performance monitor hardware support registered
[    0.037784] smp: Bringing up secondary CPUs ...
[    0.600512] smp: Brought up 3 nodes, 16 CPUs
[    0.600527] numa: Node 0 CPUs:
[    0.600530] numa: Node 6 CPUs: 0-15
[    0.600532] numa: Node 7 CPUs:
[    0.601204] devtmpfs: initialized
[    0.610466] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.610482] futex hash table entries: 4096 (order: 3, 524288 bytes)
[    0.610936] NET: Registered protocol family 16
[    0.610976] EEH: No capable adapters found
[    0.611135] cpuidle: using governor menu
[    0.611161] RTAS daemon started
[    0.611228] pstore: using zlib compression
[    0.611231] pstore: Registered nvram as persistent store backend
[    0.613850] PCI: Probing PCI hardware
[    0.613854] PCI: Probing PCI hardware done
[    0.613938] pseries-rng: Registering arch random hook.
[    0.614909] HugeTLB registered 16 MB page size, pre-allocated 0 pages
[    0.614913] HugeTLB registered 16 GB page size, pre-allocated 0 pages
[    0.616329] vgaarb: loaded
[    0.616489] SCSI subsystem initialized
[    0.616518] usbcore: registered new interface driver usbfs
[    0.616526] usbcore: registered new interface driver hub
[    0.616590] usbcore: registered new device driver usb
[    0.616793] NetLabel: Initializing
[    0.616796] NetLabel:  domain hash size = 128
[    0.616798] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.616812] NetLabel:  unlabeled traffic allowed by default
[    0.616931] clocksource: Switched to clocksource timebase
[    0.625880] VFS: Disk quotas dquot_6.6.0
[    0.626026] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    0.628057] NET: Registered protocol family 2
[    0.628237] TCP established hash table entries: 262144 (order: 5, 2097152 bytes)
[    0.628667] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    0.628779] TCP: Hash tables configured (established 262144 bind 65536)
[    0.628810] UDP hash table entries: 16384 (order: 3, 524288 bytes)
[    0.628869] UDP-Lite hash table entries: 16384 (order: 3, 524288 bytes)
[    0.629199] NET: Registered protocol family 1
[    0.629206] PCI: CLS 0 bytes, default 128
[    0.629240] Unpacking initramfs...
[    1.087242] Freeing initrd memory: 36288K
[    1.087973] IOMMU table initialized, virtual merging enabled
[    1.098080] hv-24x7: read 1330 catalog entries, created 337 event attrs (0 failures), 169 descs
[    1.098577] audit: initializing netlink subsys (disabled)
[    1.101042] Kprobe smoke test: started
[    1.126952] Kprobe smoke test: passed successfully
[    1.127327] Initialise system trusted keyrings
[    1.127389] workingset: timestamp_bits=38 max_order=19 bucket_order=0
[    1.128529] zbud: loaded
[    1.129264] SELinux:  Registering netfilter hooks
[    1.168852] NET: Registered protocol family 38
[    1.168870] Key type asymmetric registered
[    1.168873] Asymmetric key parser 'x509' registered
[    1.168889] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.168957] io scheduler noop registered
[    1.168959] io scheduler deadline registered (default)
[    1.169049] io scheduler cfq registered
[    1.169051] io scheduler mq-deadline registered
[    1.169235] atomic64_test: passed
[    1.169510] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.169701] Linux agpgart interface v0.103
[    1.169781] rdac: device handler registered
[    1.169811] hp_sw: device handler registered
[    1.169814] emc: device handler registered
[    1.169921] alua: device handler registered
[    1.169947] libphy: Fixed MDIO Bus: probed
[    1.169984] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.169992] ehci-pci: EHCI PCI platform driver
[    1.169998] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.170005] ohci-pci: OHCI PCI platform driver
[    1.170011] uhci_hcd: USB Universal Host Controller Interface driver
[    1.170037] usbcore: registered new interface driver usbserial
[    1.170044] usbcore: registered new interface driver usbserial_generic
[    1.170050] usbserial: USB Serial support registered for generic
[    1.170088] mousedev: PS/2 mouse device common for all mice
[    1.170177] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[    1.170304] pseries_idle_driver registered
[    1.170324] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sync_size new:4096 old:0
[    1.170329] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sync_sg new:510 old:0
[    1.170333] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: max_sg_len new:4080 old:0
[    1.170363] alg: No test for 842 (842-nx)
[    1.170397] hidraw: raw HID events driver (C) Jiri Kosina
[    1.170513] usbcore: registered new interface driver usbhid
[    1.170516] usbhid: USB HID core driver
[    1.170568] drop_monitor: Initializing network drop monitor service
[    1.170672] Initializing XFRM netlink socket
[    1.171203] NET: Registered protocol family 10
[    1.171662] Segment Routing with IPv6
[    1.171684] NET: Registered protocol family 17
[    1.171722] emulate_step_test: ld             : PASS
[    1.171727] emulate_step_test: lwz            : PASS
[    1.171732] emulate_step_test: lwzx           : PASS
[    1.171737] emulate_step_test: std            : PASS
[    1.171743] emulate_step_test: ldarx / stdcx. : PASS
[    1.171750] emulate_step_test: lfsx           : PASS
[    1.171755] emulate_step_test: stfsx          : PASS
[    1.171760] emulate_step_test: lfdx           : PASS
[    1.171764] emulate_step_test: stfdx          : PASS
[    1.171769] emulate_step_test: lvx            : PASS
[    1.171774] emulate_step_test: stvx           : PASS
[    1.171780] emulate_step_test: lxvd2x         : PASS
[    1.171784] emulate_step_test: stxvd2x        : PASS
[    1.171789] Running MSI bitmap self-tests ...
[    1.172013] registered taskstats version 1
[    1.172029] Loading compiled-in X.509 certificates
[    1.173938] alg: No test for pkcs1pad(rsa,sha1) (pkcs1pad(rsa-generic,sha1))
[    1.174901] Loaded X.509 cert 'Build time autogenerated kernel key: 49669810573f8e9c173ca7d6fc63b45f4a9229e1'
[    1.174950] zswap: loaded using pool lzo/zbud
[    1.194242] Key type big_key registered
[    1.194336] rtc-generic rtc-generic: setting system clock to 2017-04-06 10:10:37 UTC (1491473437)
[    1.194798] Freeing unused kernel memory: 3072K
[    1.194801] This architecture does not have kernel memory protection.
[    1.198458] pstore: decompression failed;returned -5
[    1.200257] random: systemd: uninitialized urandom read (16 bytes read)
[    1.200630] random: systemd: uninitialized urandom read (16 bytes read)
[    1.201777] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    1.201881] systemd[1]: Detected architecture ppc64-le.
[    1.201885] systemd[1]: Running in initial RAM disk.
[    1.202073] systemd[1]: Set hostname to <localhost.localdomain>.
[    1.224408] random: systemd: uninitialized urandom read (16 bytes read)
[    1.224443] random: systemd: uninitialized urandom read (16 bytes read)
[    1.224473] random: systemd: uninitialized urandom read (16 bytes read)
[    1.224524] random: systemd: uninitialized urandom read (16 bytes read)
[    1.225007] random: systemd: uninitialized urandom read (16 bytes read)
[    1.225116] random: systemd: uninitialized urandom read (16 bytes read)
[    1.225272] random: systemd: uninitialized urandom read (16 bytes read)
[    1.225709] random: systemd: uninitialized urandom read (16 bytes read)
[    1.228893] systemd[1]: Created slice Root Slice.
[    1.228904] systemd[1]: Starting Root Slice.
[    1.229075] systemd[1]: Listening on udev Control Socket.
[    1.229084] systemd[1]: Starting udev Control Socket.
[    1.229288] systemd[1]: Created slice System Slice.
[    1.229297] systemd[1]: Starting System Slice.
[    1.342088] device-mapper: uevent: version 1.0.3
[    1.342287] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    1.401537] ibmveth: IBM Power Virtual Ethernet Driver 1.06
[    1.405011] ibmvscsi 30000071: SRP_VERSION: 16.a
[    1.412168] random: fast init done
[    7.997039] ibmvscsi 30000071: SRP_VERSION: 16.a
[    7.997224] ibmvscsi 30000071: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
[    7.997229] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
[    7.997375] ibmvscsi 30000071: partner initialization complete
[    7.997425] ibmvscsi 30000071: host srp version: 16.a, host partition alp18-VIOS (100), OS 3, max io 1048576
[    7.997491] ibmvscsi 30000071: Client reserve enabled
[    7.997500] ibmvscsi 30000071: sent SRP login
[    7.997541] ibmvscsi 30000071: SRP_LOGIN succeeded
[    8.027362] scsi 0:0:1:0: Direct-Access     AIX      VDASD            0001 PQ: 0 ANSI: 3
[    8.027559] scsi 0:0:2:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
[    8.073257] sd 0:0:1:0: [sda] 230686720 512-byte logical blocks: (118 GB/110 GiB)
[    8.073324] sd 0:0:1:0: [sda] Write Protect is off
[    8.073329] sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08
[    8.073374] sd 0:0:1:0: [sda] Cache data unavailable
[    8.073379] sd 0:0:1:0: [sda] Assuming drive cache: write through
[    8.078320] sr 0:0:2:0: [sr0] scsi-1 drive
[    8.078325] cdrom: Uniform CD-ROM driver Revision: 3.20
[    8.078465] sr 0:0:2:0: Attached scsi CD-ROM sr0
[    8.083404]  sda: sda1 sda2 sda3
[    8.083795] sd 0:0:1:0: [sda] Attached SCSI disk
[    9.058308] SGI XFS with ACLs, security attributes, no debug enabled
[    9.061456] XFS (dm-2): Mounting V5 Filesystem
[    9.521373] random: crng init done
[    9.650648] XFS (dm-2): Starting recovery (logdev: internal)
[   10.331586] XFS (dm-2): Ending recovery (logdev: internal)
[   10.602237] systemd-journald[233]: Received SIGTERM from PID 1 (systemd).
[   10.712617] systemd: 24 output lines suppressed due to ratelimiting
[   11.071231] SELinux: 32768 avtab hash slots, 104960 rules.
[   11.084950] SELinux: 32768 avtab hash slots, 104960 rules.
[   11.103094] SELinux:  8 users, 14 roles, 4986 types, 301 bools, 1 sens, 1024 cats
[   11.103097] SELinux:  91 classes, 104960 rules
[   11.105809] SELinux:  Permission validate_trans in class security not defined in policy.
[   11.105829] SELinux:  Permission module_load in class system not defined in policy.
[   11.105912] SELinux:  Class binder not defined in policy.
[   11.105915] SELinux:  Class cap_userns not defined in policy.
[   11.105917] SELinux:  Class cap2_userns not defined in policy.
[   11.105919] SELinux:  Class sctp_socket not defined in policy.
[   11.105922] SELinux:  Class icmp_socket not defined in policy.
[   11.105924] SELinux:  Class ax25_socket not defined in policy.
[   11.105926] SELinux:  Class ipx_socket not defined in policy.
[   11.105928] SELinux:  Class netrom_socket not defined in policy.
[   11.105930] SELinux:  Class atmpvc_socket not defined in policy.
[   11.105933] SELinux:  Class x25_socket not defined in policy.
[   11.105935] SELinux:  Class rose_socket not defined in policy.
[   11.105937] SELinux:  Class decnet_socket not defined in policy.
[   11.105939] SELinux:  Class atmsvc_socket not defined in policy.
[   11.105941] SELinux:  Class rds_socket not defined in policy.
[   11.105943] SELinux:  Class irda_socket not defined in policy.
[   11.105946] SELinux:  Class pppox_socket not defined in policy.
[   11.105948] SELinux:  Class llc_socket not defined in policy.
[   11.105950] SELinux:  Class can_socket not defined in policy.
[   11.105952] SELinux:  Class tipc_socket not defined in policy.
[   11.105954] SELinux:  Class bluetooth_socket not defined in policy.
[   11.105957] SELinux:  Class iucv_socket not defined in policy.
[   11.105959] SELinux:  Class rxrpc_socket not defined in policy.
[   11.105961] SELinux:  Class isdn_socket not defined in policy.
[   11.105963] SELinux:  Class phonet_socket not defined in policy.
[   11.105965] SELinux:  Class ieee802154_socket not defined in policy.
[   11.105968] SELinux:  Class caif_socket not defined in policy.
[   11.105970] SELinux:  Class alg_socket not defined in policy.
[   11.105972] SELinux:  Class nfc_socket not defined in policy.
[   11.105974] SELinux:  Class vsock_socket not defined in policy.
[   11.105976] SELinux:  Class kcm_socket not defined in policy.
[   11.105979] SELinux:  Class qipcrtr_socket not defined in policy.
[   11.105981] SELinux:  Class smc_socket not defined in policy.
[   11.105983] SELinux: the above unknown classes and permissions will be allowed
[   11.105988] SELinux:  Completing initialization.
[   11.105988] SELinux:  Setting up existing superblocks.
[   11.155609] systemd[1]: Successfully loaded SELinux policy in 218.703ms.
[   11.342766] ip_tables: (C) 2000-2006 Netfilter Core Team
[   11.342789] systemd[1]: Inserted module 'ip_tables'
[   11.356749] systemd[1]: Relabelled /dev and /run in 13.178ms.
[   14.121597] systemd-journald[848]: Received request to flush runtime journal from PID 1
[   14.677090] RPC: Registered named UNIX socket transport module.
[   14.677105] RPC: Registered udp transport module.
[   14.677107] RPC: Registered tcp transport module.
[   14.677110] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   15.163618] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   15.505779] pseries_rng: Registering IBM pSeries RNG driver
[   15.661631] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   15.661716] sr 0:0:2:0: Attached scsi generic sg1 type 5
[   15.922191] ibmveth 30000002 net0: renamed from eth0
[   15.959363] Using 'aes-generic' as fallback implementation.
[   15.959424] crypto_register_alg 'aes' = 0
[   15.963616] Using 'aes-generic' as fallback implementation.
[   15.963853] Using 'aes-generic' as fallback implementation.
[   15.963860] Using 'cbc(p8_aes)' as fallback implementation.
[   15.964061] crypto_register_alg 'cbc(aes)' = 0
[   15.968868] Using 'aes-generic' as fallback implementation.
[   15.969110] Using 'aes-generic' as fallback implementation.
[   15.969117] Using 'ctr(p8_aes)' as fallback implementation.
[   15.969268] crypto_register_alg 'ctr(aes)' = 0
[   16.214234] Using 'aes-generic' as fallback implementation.
[   16.214359] Using 'aes-generic' as fallback implementation.
[   16.214366] Using 'aes-generic' as fallback implementation.
[   16.214584] Using 'aes-generic' as fallback implementation.
[   16.214590] Using 'aes-generic' as fallback implementation.
[   16.214593] Using 'xts(ecb(p8_aes))' as fallback implementation.
[   16.214712] crypto_register_alg 'xts(aes)' = 0
[   16.264483] Using 'ghash-generic' as fallback implementation.
[   16.460314] Adding 5767104k swap on /dev/mapper/rhel_alp13-swap.  Priority:-1 extents:1 across:5767104k FS
[   17.118038] XFS (sda2): Mounting V5 Filesystem
[   17.120645] XFS (dm-1): Mounting V5 Filesystem
[   17.423162] XFS (dm-1): Starting recovery (logdev: internal)
[   17.893319] XFS (dm-1): Ending recovery (logdev: internal)
[   19.267220] tpm_ibmvtpm 30000003: CRQ initialization completed
[   19.430959] XFS (sda2): Starting recovery (logdev: internal)
[   19.569471] XFS (sda2): Ending recovery (logdev: internal)
[   20.182194] audit: type=2000 audit(1491473437.090:1): state=initialized audit_enabled=0 res=1
[   20.182210] audit: type=1404 audit(1491473447.240:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[   20.182214] audit: type=1403 audit(1491473447.450:3): policy loaded auid=4294967295 ses=4294967295
[   22.390751] IPv6: ADDRCONF(NETDEV_UP): net0: link is not ready
[   30.108434] DCCP: Activated CCID 2 (TCP-like)
[   30.108466] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   30.714727] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   30.842165] Ebtables v2.0 registered
[   31.559810] rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
[   32.094019] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   32.121566] tun: Universal TUN/TAP device driver, 1.6
[   32.389024] virbr0: port 1(virbr0-nic) entered blocking state
[   32.389047] virbr0: port 1(virbr0-nic) entered disabled state
[   32.389125] device virbr0-nic entered promiscuous mode
[   33.048001] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   33.487048] virbr0: port 1(virbr0-nic) entered blocking state
[   33.487070] virbr0: port 1(virbr0-nic) entered listening state
[   33.625050] virbr0: port 1(virbr0-nic) entered disabled state
[  248.527132] PCI host bridge /pci@800000020000048  ranges:
[  248.527153]  MEM 0x00003fce00000000..0x00003fce7effffff -> 0x0000000080000000 
[  248.527156]  MEM 0x000031c000000000..0x000031cfffffffff -> 0x0003d1c000000000 
[  248.527215] PCI host bridge to bus 0048:01
[  248.527222] pci_bus 0048:01: root bus resource [mem 0x3fce00000000-0x3fce7effffff] (bus address [0x80000000-0xfeffffff])
[  248.527228] pci_bus 0048:01: root bus resource [mem 0x31c000000000-0x31cfffffffff] (bus address [0x3d1c000000000-0x3d1cfffffffff])
[  248.527234] pci_bus 0048:01: root bus resource [bus 01-ff]
[  248.604704] rpaphp: Slot [U78C7.001.RCH0042-P1-C2] registered
[  248.604722] rpadlpar_io: slot PHB 72 added
[  269.589391] pci_bus 0048:01: busn_res: [bus 01-ff] is released
[  269.589441] rpadlpar_io: slot PHB 72 removed
[  270.589997] refcount_t: underflow; use-after-free.
[  270.590019] ------------[ cut here ]------------
[  270.590025] WARNING: CPU: 5 PID: 3335 at lib/refcount.c:128 refcount_sub_and_test+0xf4/0x110
[  270.590028] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun bridge stp llc rpadlpar_io rpaphp kvm_pr kvm ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dccp_diag dccp tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag ghash_generic xts gf128mul vmx_crypto tpm_ibmvtpm tpm sg pseries_rng nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc ip_tables xfs libcrc32c sr_mod sd_mod cdrom ibmvscsi ibmveth scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
[  270.590076] CPU: 5 PID: 3335 Comm: drmgr Not tainted 4.11.0-rc5 #3
[  270.590079] task: c0000005d8df8600 task.stack: c0000000fb3a8000
[  270.590081] NIP: c000000001aa3ca4 LR: c000000001aa3ca0 CTR: 00000000006338e4
[  270.590084] REGS: c0000000fb3ab8a0 TRAP: 0700   Not tainted  (4.11.0-rc5)
[  270.590087] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
[  270.590090]   CR: 22002422  XER: 00000007
[  270.590093] CFAR: c000000001edaabc SOFTE: 1 
GPR00: c000000001aa3ca0 c0000000fb3abb20 c0000000025ea900 0000000000000026 
GPR04: c00000077fc4ada0 c00000077fc617b8 00000000000f0c33 0000000000000000 
GPR08: 0000000000000000 c00000000227146c 000000077d9e0000 0000000000003ff0 
GPR12: 0000000000002200 c00000000e802d00 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 000000001001b5a8 0000000010018338 0000000010016650 
GPR24: 000000001001b278 c000000776e0fdcc 0000000010016650 0000000000000000 
GPR28: c00000077ffea910 c0000000fbf79180 c000000776e0fdc0 c0000000fbf791d8 
[  270.590126] NIP [c000000001aa3ca4] refcount_sub_and_test+0xf4/0x110
[  270.590129] LR [c000000001aa3ca0] refcount_sub_and_test+0xf0/0x110
[  270.590132] Call Trace:
[  270.590134] [c0000000fb3abb20] [c000000001aa3ca0] refcount_sub_and_test+0xf0/0x110 (unreliable)
[  270.590139] [c0000000fb3abb80] [c000000001a8221c] kobject_put+0x3c/0xa0
[  270.590143] [c0000000fb3abbf0] [c000000001d22d34] of_node_put+0x24/0x40
[  270.590147] [c0000000fb3abc10] [c00000000165c874] ofdt_write+0x204/0x6b0
[  270.590151] [c0000000fb3abcd0] [c00000000197a220] proc_reg_write+0x80/0xd0
[  270.590155] [c0000000fb3abd00] [c0000000018de680] __vfs_write+0x40/0x1c0
[  270.590158] [c0000000fb3abd90] [c0000000018dffd8] vfs_write+0xc8/0x240
[  270.590162] [c0000000fb3abde0] [c0000000018e1c40] SyS_write+0x60/0x110
[  270.590165] [c0000000fb3abe30] [c0000000015cb184] system_call+0x38/0xe0
[  270.590168] Instruction dump:
[  270.590170] 7863d182 4e800020 7c0802a6 39200001 3d42fff8 3c62ffb1 386371a8 992a0171 
[  270.590175] f8010010 f821ffa1 48436de1 60000000 <0fe00000> 38210060 38600000 e8010010 
[  270.590180] ---[ end trace 08c7a2f3c8bead33 ]---
[  278.491869] nr_pdflush_threads exported in /proc is scheduled for removal

--Apple-Mail=_E93CECD4-C7B3-4E9D-846C-8123F225A26B--
