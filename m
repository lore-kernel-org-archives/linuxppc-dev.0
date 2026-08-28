Return-Path: <linuxppc-dev+bounces-26173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A447C61DBD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 15:15:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWhlW1d2xz2y8F;
	Sat, 29 Aug 2026 01:15:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787930119;
	cv=none; b=M9uDAV4/TNSV83ngcmm7UfnMgKAJ5WtOh4CsIgwNGJG5xDjp0r+TTA7Yq0lPrn7GSiZs9xhQdD1JvGwlONQo0xia/DfYjrquJ622ZvQW8e4Mt4aSp7IowUuJTxeD1j4L/a0yEo0TU5Xhbco22sTXDHnK+t2YSXmtrnrO/5GJ0mRHtcCs/UsZt54V/RVdZNdnGVfjDfAaw5Ppyd95dTaO4ODSDaNcJJtXp/SwkRECvapXToPG65KZpSFjISfOwe4L+Qf3nTX79VkLFx21+0GdzY71XQnFwSJKDDptOfUbG0qvAZMH/ZpZHxhfwY9/pNuU82WrANksUG83NmyqEIvL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787930119; c=relaxed/relaxed;
	bh=ed5zxkd1DpAkTQ6wCTB9p/Kv8Uo+sanYyPelWDQJOx8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=j0De/15S5HaSmXPHvCYNcnYtcyUklhxPGSg6zODl3EnFwsAFDtXv/0qRLfLgLKE/sPMjWnqcqmzfd+MXYX8rEotLKVlP+w5SoTWte7Bs89O9oBXe5MOtkYhhUiSthqz8s5ikNhs+8aDdVClAOMsMvMBHpftjh+6mDBbUH9Oi7q1+fFsq9rZMg9QhvMKpd6pjGs3o2LF4iCKrl8hHASwAC2XHTP1CBDaSJGS7f6Y5W+1MRV3H3uYqRR0UM2mUWkuXdNje6NJiSTQzGNw3139YdR1n5Kr0tkwmthL/oYTe9aRO5cGaUOt89Eb2I3pdOqwSaCZF/MyjNxeG7bs7COdhjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=S0zK3360; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=S0zK3360;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWhlR03FKz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 01:15:14 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 25A1D7792AE2;
	Fri, 28 Aug 2026 10:15:10 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OkkrvCfHGUz6; Fri, 28 Aug 2026 10:15:05 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E42257792ABB;
	Fri, 28 Aug 2026 10:15:04 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com E42257792ABB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1787930104; bh=ed5zxkd1DpAkTQ6wCTB9p/Kv8Uo+sanYyPelWDQJOx8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=S0zK3360zXgglTlq0hYSYBjekcdftuACvUwE7aC+zayexA4HzI0R4dY2QZsu6nI3S
	 VGudsWW72MMcxv5rob9cLe15TU4ra6VWhara52tRAuUUY5f9D04fBDYiRAPCRuDmw5
	 tUaCkRz5J30MD6fOQa4FBxWvsoRlt449bFc3DDaE=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id psjbsP7-mUQo; Fri, 28 Aug 2026 10:15:04 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A2DD27792A5E;
	Fri, 28 Aug 2026 10:15:04 -0500 (CDT)
Date: Fri, 28 Aug 2026 10:15:00 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <191178034.36227.1787849576996.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [BUG] VFIO amdgpu passthrough fails on PowerNV in XIVE mode
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042
Thread-Index: GCECahNkPF5KOpTU3mLy6DV1Mqh22Q==
Thread-Topic: VFIO amdgpu passthrough fails on PowerNV in XIVE mode

When passing through an AMD GPU via VFIO on a POWER9 PowerNV host using qem=
u, the passthrough fails in guest XIVE mode but works properly in guest XIC=
S mode.  Host and guest are Debian stable (6.12).

dmesg from a XIVE mode guest kernel boot:

char device redirected to /dev/pts/2 (label monitor)


SLOF **********************************************************************
QEMU Starting
 Build Date =3D Jun 28 2026 05:33:17
 FW Version =3D release 20230918
 Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/nvram@71000000
Populating /vdevice/vty@71000001
Populating /vdevice/vty@71000002
Populating /pci@800000020000000
                     00 0000 (D) : 1af4 1000    virtio [ net ]
                     00 0800 (D) : 1af4 1005    legacy-device*
                     00 1000 (B) : 1b36 0001    pci*
                     01 0000 (D) : 1002 67c4    vga*
                     01 0100 (D) : 1002 aaf0    multimedia-device*
                     00 1800 (B) : 1b36 0001    pci*
                     00 2000 (D) : 1af4 1059    sound*
No NVRAM common partition, re-initializing...
Scanning USB
Using default console: /vdevice/vty@71000001
Detected RAM kernel at 400000 (287f250 bytes)

  Welcome to Open Firmware

  Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php

Booting from memory...
OF stdout device is: /vdevice/vty@71000001
Preparing to boot Linux version 6.12.101+deb13-powerpc64le (debian-kernel@l=
ists.debian.org) (powerpc64le-linux-gnu-gcc-14 (Debian 14.2.0-19) 14.2.0, G=
NU ld (GNU Binutils for Debian) 2.44) #1 SMP Debian 6.12.101-1 (2026-08-05)
Detected machine type: 0000000000000101
command line: <REDACTED>
Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
Calling ibm,client-architecture-support... done
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 000000000583c000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000200000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000200000000
instantiating rtas at 0x000000002ffff000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x000000000583d000 -> 0x000000000583dbeb
Device tree struct  0x000000000583e000 -> 0x0000000005846000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000400000 ...
[    0.000000] random: crng init done
[    0.000000] radix-mmu: Page sizes from device-tree:
[    0.000000] radix-mmu: Page size shift =3D 12 AP=3D0x0
[    0.000000] radix-mmu: Page size shift =3D 16 AP=3D0x5
[    0.000000] radix-mmu: Page size shift =3D 21 AP=3D0x1
[    0.000000] radix-mmu: Page size shift =3D 30 AP=3D0x2
[    0.000000] Activating Kernel Userspace Access Prevention
[    0.000000] Activating Kernel Userspace Execution Prevention
[    0.000000] radix-mmu: Mapped 0x0000000000000000-0x0000000002600000 with=
 2.00 MiB pages (exec)
[    0.000000] radix-mmu: Mapped 0x0000000002600000-0x0000000040000000 with=
 2.00 MiB pages
[    0.000000] radix-mmu: Mapped 0x0000000040000000-0x0000000200000000 with=
 1.00 GiB pages
[    0.000000] lpar: Using radix MMU under hypervisor
[    0.000000] Linux version 6.12.101+deb13-powerpc64le (debian-kernel@list=
s.debian.org) (powerpc64le-linux-gnu-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU =
ld (GNU Binutils for Debian) 2.44) #1 SMP Debian 6.12.101-1 (2026-08-05)
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node i=
n the DT
[    0.000000] Found initrd at 0xc000000002c90000:0xc00000000583bc4e
[    0.000000] Hardware name: IBM pSeries (emulated by qemu) POWER9 (archit=
ected) 0x4e1203 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
[    0.000000] printk: legacy bootconsole [udbg0] enabled
[    0.000000] Partition configured for 8 cpus.
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000] numa: Partition configured for 1 NUMA nodes.
[    0.000000] -----------------------------------------------------
[    0.000000] phys_mem_size     =3D 0x200000000
[    0.000000] dcache_bsize      =3D 0x80
[    0.000000] icache_bsize      =3D 0x80
[    0.000000] cpu_features      =3D 0x0001c06b8f4f9183
[    0.000000]   possible        =3D 0x001ffbebcf5fb187
[    0.000000]   always          =3D 0x0000000380008181
[    0.000000] cpu_user_features =3D 0xdc0065c2 0xaef00000
[    0.000000] mmu_features      =3D 0x3c007641
[    0.000000] firmware_features =3D 0x00000a85455a445f
[    0.000000] vmalloc start     =3D 0xc008000000000000
[    0.000000] IO start          =3D 0xc00a000000000000
[    0.000000] vmemmap start     =3D 0xc00c000000000000
[    0.000000] -----------------------------------------------------
[    0.000000] NODE_DATA(0) allocated [mem 0x1ffed4200-0x1ffedc3ff]
[    0.000000] rfi-flush: fallback displacement flush available
[    0.000000] rfi-flush: ori type flush available
[    0.000000] rfi-flush: mttrig type flush available
[    0.000000] count-cache-flush: hardware flush enabled.
[    0.000000] link-stack-flush: software flush enabled.
[    0.000000] stf-barrier: eieio barrier available
[    0.000000] PPC64 nvram contains 65536 bytes
[    0.000000] barrier-nospec: using ORI speculation barrier
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000001ffffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x00000001ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000001fffff=
fff]
[    0.000000] percpu: Embedded 39 pages/cpu s120472 r0 d39272 u159744
[    0.000000] Kernel command line: <REDACTED> video=3DDP-4:1920x1080D rw
[    0.000000] Unknown kernel command line parameters "<REDACTED>", will be=
 passed to user space.
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 20971=
52
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D8, =
Nodes=3D1
[    0.000000] ftrace: allocating 38773 entries in 228 pages
[    0.000000] ftrace: allocated 228 pages with 4 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D2048 to nr_cpu_=
ids=3D8.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.000000] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.000000] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1 rcu_task_cpu_ids=3D8.
[    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000] xive: Using IRQ range [0-7]
[    0.000000] xive: Interrupt handling initialized with spapr backend
[    0.000000] xive: Using priority 6 for all interrupts
[    0.000000] xive: Using 64kB queues
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.000001] time_init: 56 bit decrementer (max: 7fffffffffffff)
[    0.000615] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: =
0x761537d007, max_idle_ns: 440795202126 ns
[    0.001720] clocksource: timebase mult[1f40000] shift[24] registered
[    0.002490] Console: colour dummy device 80x25
[    0.002987] printk: legacy console [hvc0] enabled
[    0.002987] printk: legacy console [hvc0] enabled
[    0.003530] printk: legacy bootconsole [udbg0] disabled
[    0.003530] printk: legacy bootconsole [udbg0] disabled
[    0.004155] pid_max: default: 32768 minimum: 301
[    0.004247] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,ap=
parmor,tomoyo,bpf,ipe,ima,evm
[    0.004393] landlock: Up and running.
[    0.004426] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.004588] AppArmor: AppArmor initialized
[    0.004666] TOMOYO Linux initialized
[    0.005011] LSM support for eBPF active
[    0.005148] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s, linear)
[    0.005214] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes, linear)
[    0.005931] POWER9 performance monitor hardware support registered
[    0.006019] rcu: Hierarchical SRCU implementation.
[    0.006058] rcu:     Max phase no-delay instances is 1000.
[    0.006149] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.006683] smp: Bringing up secondary CPUs ...
[    0.016529] smp: Brought up 1 node, 8 CPUs
[    0.016575] numa: Node 0 CPUs: 0-7
[    0.058876] node 0 deferred pages initialised in 24ms
[    0.059024] Memory: 8123080K/8388608K available (16456K kernel code, 229=
6K rwdata, 16312K rodata, 5084K init, 1320K bss, 257324K reserved, 0K cma-r=
eserved)
[    0.064952] devtmpfs: initialized
[    0.069011] PCI host bridge /pci@800000020000000  ranges:
[    0.069071]   IO 0x0000200000000000..0x000020000000ffff -> 0x00000000000=
00000
[    0.069152]  MEM 0x0000200080000000..0x00002000ffffffff -> 0x00000000800=
00000
[    0.069224]  MEM 0x0000210000000000..0x000021ffffffffff -> 0x00002100000=
00000
[    0.069406] futex hash table entries: 2048 (order: 6, 262144 bytes, line=
ar)
[    0.071841] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.072103] audit: initializing netlink subsys (disabled)
[    0.074371] thermal_sys: Registered thermal governor 'fair_share'
[    0.074373] thermal_sys: Registered thermal governor 'bang_bang'
[    0.074442] thermal_sys: Registered thermal governor 'step_wise'
[    0.074506] thermal_sys: Registered thermal governor 'user_space'
[    0.074570] thermal_sys: Registered thermal governor 'power_allocator'
[    0.074652] cpuidle: using governor ladder
[    0.074760] cpuidle: using governor menu
Linux ppc64le
#[    0.075291] a1udit: type=3D2000  audit(1787849254S.068:1): state=3Dinit=
ialized audit_enabled=3D0 res=3D1M
P Debian 6.[    0.077962] EEH: pSeries platform initialized
[    0.092470] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.104484] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.104550] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.104605] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s
[    0.104656] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.115824] iommu: Default domain type: Translated
[    0.115873] iommu: DMA domain TLB invalidation policy: strict mode
[    0.116094] SCSI subsystem initialized
[    0.120439] pps_core: LinuxPPS API ver. 1 registered
[    0.120487] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.120570] PTP clock support registered
[    0.123285] NetLabel: Initializing
[    0.123324] NetLabel:  domain hash size =3D 128
[    0.123370] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.123451] NetLabel:  unlabeled traffic allowed by default
[    0.123496] PCI: Probing PCI hardware
[    0.126327] PCI host bridge to bus 0000:00
[    0.126368] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bu=
s address [0x0000-0xffff])
[    0.126448] pci_bus 0000:00: root bus resource [mem 0x200080000000-0x200=
0ffffffff] (bus address [0x80000000-0xffffffff])
[    0.126539] pci_bus 0000:00: root bus resource [mem 0x210000000000-0x21f=
fffffffff 64bit]
[    0.127681] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.127843] pci 0000:00:00.0: No hypervisor support for SR-IOV on this d=
evice, IOV BARs disabled.
[    0.128427] pci 0000:00:01.0: No hypervisor support for SR-IOV on this d=
evice, IOV BARs disabled.
[    0.129245] pci 0000:00:02.0: No hypervisor support for SR-IOV on this d=
evice, IOV BARs disabled.
[    0.129909] pci 0000:00:03.0: No hypervisor support for SR-IOV on this d=
evice, IOV BARs disabled.
[    0.130306] pci 0000:00:04.0: No hypervisor support for SR-IOV on this d=
evice, IOV BARs disabled.
[    0.496778] IOMMU table initialized, virtual merging enabled
[    0.496958] pci_bus 0000:01: extended config space not accessible
[    0.497173] pci 0000:01:00.0: No hypervisor support for SR-IOV on this d=
evice, IOV BARs disabled.
[    0.497513] pci 0000:01:00.0: supports D1 D2
[    0.497720] pci 0000:01:00.0: Adding to iommu group 0
[    0.497879] pci 0000:01:00.1: No hypervisor support for SR-IOV on this d=
evice, IOV BARs disabled.
[    0.498225] pci 0000:01:00.1: supports D1 D2
[    0.498410] pci 0000:01:00.1: Adding to iommu group 0
[    0.498567] pci_bus 0000:02: extended config space not accessible
[    0.498759] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.498802] pci 0000:00:02.0:   bridge window [io  0x11000-0x11fff]
[    0.499449] pci 0000:00:02.0:   bridge window [mem 0x200080100000-0x2000=
802fffff]
[    0.499869] pci 0000:00:02.0:   bridge window [mem 0x210100000000-0x2101=
ffffffff 64bit pref]
[    0.500702] pci 0000:00:03.0: PCI bridge to [bus 02]
[    0.500748] pci 0000:00:03.0:   bridge window [io  0x12000-0x12fff]
[    0.501379] pci 0000:00:03.0:   bridge window [mem 0x200080400000-0x2000=
804fffff]
[    0.501797] pci 0000:00:03.0:   bridge window [mem 0x210200000000-0x2102=
ffffffff 64bit pref]
[    0.502522] pci_bus 0000:00: resource 4 [io  0x10000-0x1ffff]
[    0.502574] pci_bus 0000:00: resource 5 [mem 0x200080000000-0x2000ffffff=
ff]
[    0.502620] pci_bus 0000:00: resource 6 [mem 0x210000000000-0x21ffffffff=
ff 64bit]
[    0.502674] pci_bus 0000:01: resource 0 [io  0x11000-0x11fff]
[    0.502719] pci_bus 0000:01: resource 1 [mem 0x200080100000-0x2000802fff=
ff]
[    0.502766] pci_bus 0000:01: resource 2 [mem 0x210100000000-0x2101ffffff=
ff 64bit pref]
[    0.502822] pci_bus 0000:02: resource 0 [io  0x12000-0x12fff]
[    0.502869] pci_bus 0000:02: resource 1 [mem 0x200080400000-0x2000804fff=
ff]
[    0.502916] pci_bus 0000:02: resource 2 [mem 0x210200000000-0x2102ffffff=
ff 64bit pref]
[    0.503065] pci 0000:00:00.0: ibm,query-pe-dma-windows(2026) 0 8000000 2=
0000000 returned 0, lb=3D2000000000 ps=3D107 wn=3D1
[    0.503145] pci 0000:00:00.0: Adding to iommu group 0
[    0.503567] pci 0000:00:01.0: Adding to iommu group 0
[    0.503966] pci 0000:00:02.0: Adding to iommu group 0
[    0.504242] pci 0000:00:03.0: Adding to iommu group 0
[    0.504509] pci 0000:00:04.0: Adding to iommu group 0
[    0.510398] EEH: Capable adapter found: recovery enabled.
[    0.510909] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.510957] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.511007] pci 0000:01:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone
[    0.511065] vgaarb: loaded
[    0.560933] clocksource: Switched to clocksource timebase
[    0.561117] VFS: Disk quotas dquot_6.6.0
[    0.561156] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.563265] AppArmor: AppArmor Filesystem Enabled
[    0.699183] NET: Registered PF_INET protocol family
[    0.699355] IP idents hash table entries: 131072 (order: 8, 1048576 byte=
s, linear)
[    0.712143] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4,=
 65536 bytes, linear)
[    0.712256] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.712326] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes, linear)
[    0.712583] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.712744] TCP: Hash tables configured (established 65536 bind 65536)
[    0.712857] MPTCP token hash table entries: 8192 (order: 6, 196608 bytes=
, linear)
[    0.712933] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear=
)
[    0.712993] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, l=
inear)
[    0.713093] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.713143] NET: Registered PF_XDP protocol family
[    0.713270] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.713352] PCI: CLS 0 bytes, default 128
[    0.713667] Trying to unpack rootfs image as initramfs...
[    0.723447] Initialise system trusted keyrings
[    0.723513] Key type blacklist registered
[    0.734061] workingset: timestamp_bits=3D38 max_order=3D21 bucket_order=
=3D0
[    0.734138] zbud: loaded
[    0.735823] fuse: init (API version 7.41)
[    0.737717] integrity: Platform Keyring initialized
[    0.770075] Key type asymmetric registered
[    0.770118] Asymmetric key parser 'x509' registered
[    1.314464] Freeing initrd memory: 44716K
[    1.324535] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[    1.324793] io scheduler mq-deadline registered
[    1.359739] ledtrig-cpu: registered to indicate activity on CPUs
[    1.360077] virtio-pci 0000:00:00.0: enabling device (0100 -> 0103)
[    1.361580] virtio-pci 0000:00:00.0: ibm,query-pe-dma-windows(2026) 0 80=
00000 20000000 returned 0, lb=3D2000000000 ps=3D107 wn=3D1
[    1.362727] virtio-pci 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 80=
00000 20000000 18 21 returned 0 (liobn =3D 0x80000001 starting addr =3D 800=
0000 0)
[    1.383092] virtio-pci 0000:00:00.0: lsa_required: 0, lsa_enabled: 0, di=
rect mapping: 1
[    1.383164] virtio-pci 0000:00:00.0: lsa_required: 0, lsa_enabled: 0, di=
rect mapping: 1
[    1.383989] virtio-pci 0000:00:01.0: enabling device (0100 -> 0103)
[    1.384591] virtio-pci 0000:00:01.0: lsa_required: 0, lsa_enabled: 0, di=
rect mapping: 1
[    1.384651] virtio-pci 0000:00:01.0: lsa_required: 0, lsa_enabled: 0, di=
rect mapping: 1
[    1.385377] virtio-pci 0000:00:04.0: enabling device (0100 -> 0102)
[    1.386015] virtio-pci 0000:00:04.0: lsa_required: 0, lsa_enabled: 0, di=
rect mapping: 1
[    1.386074] virtio-pci 0000:00:04.0: lsa_required: 0, lsa_enabled: 0, di=
rect mapping: 1
[    1.387728] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.388359] Non-volatile memory driver v1.3
[    1.388390] Linux agpgart interface v0.103
[    1.388681] mousedev: PS/2 mouse device common for all mice
[    1.388803] rtc-generic rtc-generic: registered as rtc0
[    1.388852] rtc-generic rtc-generic: setting system clock to 2026-08-27T=
16:47:36 UTC (1787849256)
[    1.389159] NET: Registered PF_INET6 protocol family
[    1.402473] Segment Routing with IPv6
[    1.402535] In-situ OAM (IOAM) with IPv6
[    1.402607] mip6: Mobile IPv6
[    1.402650] NET: Registered PF_PACKET protocol family
[    1.403842] mpls_gso: MPLS GSO support
[    1.408320] registered taskstats version 1
[    1.408486] Loading compiled-in X.509 certificates
[    1.441119] Loaded X.509 cert 'Build time autogenerated kernel key: b3a7=
7d36822d37216f4863f7456da0fb23e87ac4'
[    1.444224] Demotion targets for Node 0: null
[    1.455359] Key type .fscrypt registered
[    1.455411] Key type fscrypt-provisioning registered
[    1.486408] Key type encrypted registered
[    1.486468] AppArmor: AppArmor sha256 policy hashing enabled
[    1.486539] ima: No TPM chip found, activating TPM-bypass!
[    1.486591] ima: Allocated hash algorithm: sha256
[    1.486655] ima: No architecture policies found
[    1.486729] evm: Initialising EVM extended attributes:
[    1.486778] evm: security.selinux
[    1.486816] evm: security.SMACK64 (disabled)
[    1.486864] evm: security.SMACK64EXEC (disabled)
[    1.486912] evm: security.SMACK64TRANSMUTE (disabled)
[    1.486961] evm: security.SMACK64MMAP (disabled)
[    1.487009] evm: security.apparmor
[    1.487046] evm: security.ima
[    1.487084] evm: security.capability
[    1.487121] evm: HMAC attrs: 0x1
[    1.528905] SED: plpks not available
[    1.553994] Freeing unused kernel image (initmem) memory: 5084K
[    1.554415] Run /init as init process
Loading, please wait...
Starting systemd-udevd version 257.13-1~deb13u1
[    1.789222] virtio_net virtio0 enp0s0: renamed from eth0
[    3.608920] amdgpu 0000:01:00.0: enabling device (0140 -> 0142)
[    3.609573] [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67=
C4 0x1028:0x0B0D 0x00).
[    3.609669] [drm] register mmio base: 0x80100000
[    3.609713] [drm] register mmio size: 262144
[    3.613254] [drm] add ip block number 0 <vi_common>
[    3.613307] [drm] add ip block number 1 <gmc_v8_0>
[    3.613346] [drm] add ip block number 2 <tonga_ih>
[    3.613384] [drm] add ip block number 3 <gfx_v8_0>
[    3.613422] [drm] add ip block number 4 <sdma_v3_0>
[    3.613461] [drm] add ip block number 5 <powerplay>
[    3.613499] [drm] add ip block number 6 <dm>
[    3.613537] [drm] add ip block number 7 <uvd_v6_0>
[    3.613576] [drm] add ip block number 8 <vce_v3_0>
[    3.615135] amdgpu 0000:01:00.0: amdgpu: Fetched VBIOS from ROM BAR
[    3.615192] amdgpu: ATOM BIOS: 113-C9540400-101
[    3.615486] [drm] UVD is enabled in VM mode
[    3.615520] [drm] UVD ENC is enabled in VM mode
[    3.615561] [drm] VCE enabled in VM mode
[    3.615595] amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re not supported
[    3.615665] amdgpu 0000:01:00.0: amdgpu: PCIE atomic ops is not supporte=
d
[    3.615730] amdgpu 0000:01:00.0: amdgpu: PCI CONFIG reset
[    3.616140] [drm] GPU posting now...
[    3.731695] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, frag=
ment size is 9-bit
[    3.731805] amdgpu 0000:01:00.0: lsa_required: 0, lsa_enabled: 0, direct=
 mapping: 1
[    3.731880] amdgpu 0000:01:00.0: lsa_required: 0, lsa_enabled: 0, direct=
 mapping: 1
[    3.732204] [drm] System can't access extended configuration space, plea=
se check!!
[    3.733031] amdgpu 0000:01:00.0: BAR 2 [mem 0x210110000000-0x2101101ffff=
f 64bit pref]: releasing
[    3.733119] amdgpu 0000:01:00.0: BAR 0 [mem 0x210100000000-0x21010ffffff=
f 64bit pref]: releasing
[    3.733223] amdgpu 0000:01:00.0: BAR 0 [mem 0x210100000000-0x21010ffffff=
f 64bit pref]: assigned
[    3.733408] amdgpu 0000:01:00.0: BAR 2 [mem 0x210110000000-0x2101101ffff=
f 64bit pref]: assigned
[    3.734107] amdgpu 0000:01:00.0: amdgpu: VRAM: 8192M 0x000000F400000000 =
- 0x000000F5FFFFFFFF (8192M used)
[    3.734197] amdgpu 0000:01:00.0: amdgpu: GART: 256M 0x000000FF00000000 -=
 0x000000FF0FFFFFFF
[    3.734273] [drm] Detected VRAM RAM=3D8192M, BAR=3D256M
[    3.734323] [drm] RAM width 256bits GDDR5
[    3.734368] amdgpu 0000:01:00.0: lsa_required: 0, lsa_enabled: 0, direct=
 mapping: 1
[    3.734441] amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning =
bypass mask 0xfffffffffffffff
[    3.735849] [drm] amdgpu: 8192M of VRAM memory ready
[    3.735914] [drm] amdgpu: 3994M of GTT memory ready.
[    3.736022] [drm] GART: num cpu pages 65536, num gpu pages 65536
[    3.736991] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000=
).
[    3.739203] [drm] Chained IB support enabled!
[    3.743266] amdgpu: hwmgr_sw_init smu backed is polaris10_smu
[    3.745190] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[    3.747250] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[    4.021447] [drm] Display Core v3.2.301 initialized on DCE 11.2
[    4.032498] [drm] forcing DP-4 connector on
[    4.133834] [drm] UVD and UVD ENC initialized successfully.
[    4.234773] [drm] VCE initialized successfully.
[    4.327800] amdgpu 0000:01:00.0: amdgpu: SE 4, SH per SE 1, CU per SH 9,=
 active_cu_number 36
[    4.333546] amdgpu 0000:01:00.0: amdgpu: Using BACO for runtime pm
[    4.336498] [drm] Initialized amdgpu 3.61.0 for 0000:01:00.0 on minor 0
[    4.852853] [drm] Fence fallback timer expired on ring gfx
[    5.363783] [drm] Fence fallback timer expired on ring comp_1.0.0
[    5.876918] [drm] Fence fallback timer expired on ring comp_1.1.0
[    6.388904] [drm] Fence fallback timer expired on ring comp_1.2.0
[    6.900906] [drm] Fence fallback timer expired on ring comp_1.3.0
[    7.412924] [drm] Fence fallback timer expired on ring comp_1.0.1
[    7.924918] [drm] Fence fallback timer expired on ring comp_1.1.1
[    8.436910] [drm] Fence fallback timer expired on ring comp_1.2.1
[    8.948923] [drm] Fence fallback timer expired on ring comp_1.3.1
[    9.459783] [drm] Fence fallback timer expired on ring sdma0
[    9.972915] [drm] Fence fallback timer expired on ring sdma1
[   10.516935] [drm] Fence fallback timer expired on ring uvd
[   11.028944] [drm] Fence fallback timer expired on ring uvd
[   11.540921] [drm] Fence fallback timer expired on ring uvd_enc0
[   12.052828] [drm] Fence fallback timer expired on ring uvd_enc1
[   12.660918] [drm] Fence fallback timer expired on ring vce0
[   13.172934] [drm] Fence fallback timer expired on ring sdma0
[   13.683793] [drm] Fence fallback timer expired on ring sdma0
[   14.196928] [drm] Fence fallback timer expired on ring sdma0
[   14.708926] [drm] Fence fallback timer expired on ring sdma0
[   15.220935] [drm] Fence fallback timer expired on ring sdma0
[   15.732926] [drm] Fence fallback timer expired on ring sdma0
[   15.762842] Console: switching to colour frame buffer device 240x67
[   25.844961] amdgpu 0000:01:00.0: [drm] *ERROR* [CRTC:60:crtc-0] flip_don=
e timed out
[   36.084949] amdgpu 0000:01:00.0: [drm] *ERROR* flip_done timed out
[   36.084961] amdgpu 0000:01:00.0: [drm] *ERROR* [CRTC:60:crtc-0] commit w=
ait timed out
[   46.324969] amdgpu 0000:01:00.0: [drm] *ERROR* flip_done timed out
[   46.324975] amdgpu 0000:01:00.0: [drm] *ERROR* [PLANE:55:plane-5] commit=
 wait timed out
[   46.325084] ------------[ cut here ]------------
[   46.325085] WARNING: CPU: 6 PID: 257 at drivers/gpu/drm/amd/amdgpu/../di=
splay/amdgpu_dm/amdgpu_dm.c:9409 amdgpu_dm_atomic_commit_tail+0x2938/0x32e0=
 [amdgpu]
[   46.325468] Modules linked in: amdgpu(+) i2c_algo_bit drm_buddy drm_ttm_=
helper ttm drm_exec drm_suballoc_helper gpu_sched amdxcp drm_display_helper=
 drm_kms_helper drm drm_panel_orientation_quirks virtio_net net_failover cr=
c32c_vpmsum failover
[   46.325495] CPU: 6 UID: 0 PID: 257 Comm: (udev-worker) Not tainted 6.12.=
101+deb13-powerpc64le #1  Debian 6.12.101-1
[   46.325501] Hardware name: IBM pSeries (emulated by qemu) POWER9 (archit=
ected) 0x4e1203 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
[   46.325504] NIP:  c00800000212dd60 LR: c00800000212dd48 CTR: c0000000010=
10df0
[   46.325507] REGS: c00000000429e120 TRAP: 0700   Not tainted  (6.12.101+d=
eb13-powerpc64le Debian 6.12.101-1)
[   46.325510] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR=
: 2822822c  XER: 000000b3
[   46.325526] CFAR: c000000001010e64 IRQMASK: 1
[   46.325526] GPR00: c00800000212dd48 c00000000429e3c0 c0080000025b0800 00=
00000000000000
[   46.325526] GPR04: 0000000000000000 0000000000000000 000000000000000d ff=
fffffffffe0000
[   46.325526] GPR08: 0000000000000000 0000000000000001 c000000003e0015c c0=
080000024d90d0
[   46.325526] GPR12: c000000001010df0 c0000001fffe2380 c000000003e00000 00=
00000000000000
[   46.325526] GPR16: c000000003e40010 0000000000000000 c0000000078f4300 c0=
0000000429e603
[   46.325526] GPR20: 0000000000000000 0000000000000000 000000000000000c 00=
00000000000001
[   46.325526] GPR24: c000000007e13e00 c000000013bad118 0000000000000000 c0=
00000013bb2000
[   46.325526] GPR28: 0000000000000000 c000000014089000 c000000007e0d400 c0=
00000013bad000
[   46.325578] NIP [c00800000212dd60] amdgpu_dm_atomic_commit_tail+0x2938/0=
x32e0 [amdgpu]
[   46.325936] LR [c00800000212dd48] amdgpu_dm_atomic_commit_tail+0x2920/0x=
32e0 [amdgpu]
[   46.326294] Call Trace:
[   46.326296] [c00000000429e3c0] [c00800000212dd38] amdgpu_dm_atomic_commi=
t_tail+0x2910/0x32e0 [amdgpu] (unreliable)
[   46.326656] [c00000000429e6c0] [c0080000005d7004] commit_tail+0xdc/0x220=
 [drm_kms_helper]
[   46.326677] [c00000000429e700] [c0080000005d7378] drm_atomic_helper_comm=
it+0x210/0x250 [drm_kms_helper]
[   46.326695] [c00000000429e740] [c00800000035e7a0] drm_atomic_commit+0xe8=
/0x150 [drm]
[   46.326733] [c00000000429e820] [c008000000368218] drm_client_modeset_com=
mit_atomic+0x2c0/0x340 [drm]
[   46.326770] [c00000000429e8e0] [c0080000003685a8] drm_client_modeset_com=
mit_locked+0x80/0x240 [drm]
[   46.326805] [c00000000429e930] [c0080000005ea03c] drm_fb_helper_pan_disp=
lay+0x144/0x330 [drm_kms_helper]
[   46.326824] [c00000000429e9b0] [c000000000a6c6b8] fb_pan_display+0x68/0x=
260
[   46.326830] [c00000000429e9e0] [c000000000a7d984] bit_update_start+0x34/=
0x70
[   46.326837] [c00000000429ea10] [c000000000a7b1e0] fbcon_switch+0x480/0x6=
10
[   46.326844] [c00000000429eb80] [c000000000abe39c] redraw_screen+0x1cc/0x=
350
[   46.326850] [c00000000429ebf0] [c000000000abf440] do_bind_con_driver.isr=
a.0+0x420/0x4e0
[   46.326857] [c00000000429ecb0] [c000000000abf6d8] do_take_over_console+0=
x1d8/0x300
[   46.326863] [c00000000429ed60] [c000000000a773f8] do_fbcon_takeover+0x11=
8/0x250
[   46.326869] [c00000000429ed80] [c000000000a7cdf8] fbcon_fb_registered+0x=
268/0x300
[   46.326876] [c00000000429edd0] [c000000000a6d164] do_register_framebuffe=
r+0x254/0x370
[   46.326881] [c00000000429eea0] [c000000000a6d2c4] register_framebuffer+0=
x44/0x70
[   46.326886] [c00000000429eed0] [c0080000005e8400] __drm_fb_helper_initia=
l_config_and_unlock+0x3b8/0x6a0 [drm_kms_helper]
[   46.326903] [c00000000429efb0] [c0080000008e99d8] drm_fbdev_ttm_client_h=
otplug+0xc0/0x150 [drm_ttm_helper]
[   46.326910] [c00000000429f030] [c008000000366994] drm_client_register+0x=
ac/0x120 [drm]
[   46.326946] [c00000000429f0c0] [c0080000008ea0b4] drm_fbdev_ttm_setup+0x=
bc/0x1008 [drm_ttm_helper]
[   46.326951] [c00000000429f140] [c008000001d21cc8] amdgpu_pci_probe+0x5b0=
/0x6e0 [amdgpu]
[   46.327230] [c00000000429f1e0] [c000000000a285c8] local_pci_probe+0x68/0=
x100
[   46.327237] [c00000000429f260] [c000000000a286f8] pci_call_probe+0x98/0x=
220
[   46.327242] [c00000000429f3c0] [c000000000a2a4e4] pci_device_probe+0xb4/=
0x220
[   46.327248] [c00000000429f410] [c000000000b2bd58] really_probe+0x108/0x5=
20
[   46.327255] [c00000000429f4a0] [c000000000b2c230] __driver_probe_device+=
0xc0/0x280
[   46.327263] [c00000000429f520] [c000000000b2c544] driver_probe_device+0x=
54/0x130
[   46.327270] [c00000000429f560] [c000000000b2c908] __driver_attach+0x118/=
0x2b0
[   46.327276] [c00000000429f5e0] [c000000000b27fa4] bus_for_each_dev+0xb4/=
0x140
[   46.327283] [c00000000429f640] [c000000000b2afa4] driver_attach+0x34/0x5=
0
[   46.327290] [c00000000429f660] [c000000000b2a1dc] bus_add_driver+0x16c/0=
x330
[   46.327296] [c00000000429f6f0] [c000000000b2e244] driver_register+0xa4/0=
x1b0
[   46.327303] [c00000000429f760] [c000000000a27b58] __pci_register_driver+=
0x68/0x80
[   46.327309] [c00000000429f780] [c0080000024c687c] amdgpu_init+0x8c/0xb4 =
[amdgpu]
[   46.327636] [c00000000429f7b0] [c000000000010b50] do_one_initcall+0x80/0=
x3b0
[   46.327642] [c00000000429f890] [c000000000241bb8] do_init_module+0x78/0x=
320
[   46.327649] [c00000000429f910] [c000000000245b44] init_module_from_file+=
0xb4/0x130
[   46.327657] [c00000000429f9f0] [c000000000245f50] sys_finit_module+0x330=
/0x4f0
[   46.327664] [c00000000429fb00] [c00000000002c998] system_call_exception+=
0x118/0x230
[   46.327669] [c00000000429fe50] [c00000000000cfdc] system_call_vectored_c=
ommon+0x15c/0x2ec
[   46.327677] --- interrupt: 3000 at 0x3fffa7bb3650
[   46.327680] NIP:  00003fffa7bb3650 LR: 00003fffa7bb3650 CTR: 00000000000=
00000
[   46.327683] REGS: c00000000429fe80 TRAP: 3000   Not tainted  (6.12.101+d=
eb13-powerpc64le Debian 6.12.101-1)
[   46.327687] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> =
 CR: 48222244  XER: 00000000
[   46.327702] IRQMASK: 0
[   46.327702] GPR00: 0000000000000161 00003fffd74096a0 00003fffa7cc6d00 00=
00000000000039
[   46.327702] GPR04: 00003fffa5f9b7f8 0000000000000000 000000000000001f 00=
00000000000045
[   46.327702] GPR08: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000000
[   46.327702] GPR12: 0000000000000000 00003fffa8365400 0000000020000000 00=
00000000020000
[   46.327702] GPR16: 0000000000000000 0000000000000000 0000000102bfc790 00=
003fffd7409b70
[   46.327702] GPR20: 0000000122f81d80 0000000122f6db10 0000000000000000 00=
00000000000000
[   46.327702] GPR24: 0000000122f6db10 0000000000000000 0000000000000000 00=
003fffa5f9b7f8
[   46.327702] GPR28: 0000000122f695d0 0000000000020000 0000000122f6db10 00=
00000000000000
[   46.327754] NIP [00003fffa7bb3650] 0x3fffa7bb3650
[   46.327757] LR [00003fffa7bb3650] 0x3fffa7bb3650
[   46.327759] --- interrupt: 3000
[   46.327761] Code: 7fe3fb78 483ab34d e8410018 e87f0000 38630168 483ab38d =
e8410018 813f0748 7c7a1b78 7d290034 5529d97e 69290001 <0b090000> e93f0000 8=
1290168 7d290034
[   46.327782] ---[ end trace 0000000000000000 ]---
[   46.327800] ------------[ cut here ]------------
[   46.327801] WARNING: CPU: 6 PID: 257 at drivers/gpu/drm/amd/amdgpu/../di=
splay/amdgpu_dm/amdgpu_dm.c:8795 amdgpu_dm_atomic_commit_tail+0x295c/0x32e0=
 [amdgpu]
[   46.328162] Modules linked in: amdgpu(+) i2c_algo_bit drm_buddy drm_ttm_=
helper ttm drm_exec drm_suballoc_helper gpu_sched amdxcp drm_display_helper=
 drm_kms_helper drm drm_panel_orientation_quirks virtio_net net_failover cr=
c32c_vpmsum failover
[   46.328184] CPU: 6 UID: 0 PID: 257 Comm: (udev-worker) Tainted: G       =
 W          6.12.101+deb13-powerpc64le #1  Debian 6.12.101-1
[   46.328189] Tainted: [W]=3DWARN
[   46.328191] Hardware name: IBM pSeries (emulated by qemu) POWER9 (archit=
ected) 0x4e1203 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
[   46.328193] NIP:  c00800000212dd84 LR: c00800000212dd48 CTR: c0000000010=
10df0
[   46.328196] REGS: c00000000429e120 TRAP: 0700   Tainted: G        W     =
      (6.12.101+deb13-powerpc64le Debian 6.12.101-1)
[   46.328199] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR=
: 2822822c  XER: 200400b3
[   46.328214] CFAR: c00000000000dacc IRQMASK: 1
[   46.328214] GPR00: c00800000212dd48 c00000000429e3c0 c0080000025b0800 00=
00000000000000
[   46.328214] GPR04: 0000000000000000 0000000000000000 000000000000000d ff=
fffffffffe0000
[   46.328214] GPR08: 0000000000000000 0000000000000001 c0000000078f4e80 c0=
080000024d90d0
[   46.328214] GPR12: c000000001010df0 c0000001fffe2380 c000000003e00000 00=
00000000000000
[   46.328214] GPR16: c000000003e40010 0000000000000000 c0000000078f4300 c0=
0000000429e603
[   46.328214] GPR20: 0000000000000000 0000000000000000 000000000000000c 00=
00000000000001
[   46.328214] GPR24: c000000007e13e00 c000000013bad118 0000000000000000 c0=
00000013bb2000
[   46.328214] GPR28: 0000000000000000 c000000014089000 c000000007e0d400 c0=
00000013bad000
[   46.328264] NIP [c00800000212dd84] amdgpu_dm_atomic_commit_tail+0x295c/0=
x32e0 [amdgpu]
[   46.328622] LR [c00800000212dd48] amdgpu_dm_atomic_commit_tail+0x2920/0x=
32e0 [amdgpu]
[   46.328991] Call Trace:
[   46.328992] [c00000000429e3c0] [c00800000212dd38] amdgpu_dm_atomic_commi=
t_tail+0x2910/0x32e0 [amdgpu] (unreliable)
[   46.329352] [c00000000429e6c0] [c0080000005d7004] commit_tail+0xdc/0x220=
 [drm_kms_helper]
[   46.329371] [c00000000429e700] [c0080000005d7378] drm_atomic_helper_comm=
it+0x210/0x250 [drm_kms_helper]
[   46.329389] [c00000000429e740] [c00800000035e7a0] drm_atomic_commit+0xe8=
/0x150 [drm]
[   46.329425] [c00000000429e820] [c008000000368218] drm_client_modeset_com=
mit_atomic+0x2c0/0x340 [drm]
[   46.329461] [c00000000429e8e0] [c0080000003685a8] drm_client_modeset_com=
mit_locked+0x80/0x240 [drm]
[   46.329497] [c00000000429e930] [c0080000005ea03c] drm_fb_helper_pan_disp=
lay+0x144/0x330 [drm_kms_helper]
[   46.329515] [c00000000429e9b0] [c000000000a6c6b8] fb_pan_display+0x68/0x=
260
[   46.329520] [c00000000429e9e0] [c000000000a7d984] bit_update_start+0x34/=
0x70
[   46.329527] [c00000000429ea10] [c000000000a7b1e0] fbcon_switch+0x480/0x6=
10
[   46.329533] [c00000000429eb80] [c000000000abe39c] redraw_screen+0x1cc/0x=
350
[   46.329539] [c00000000429ebf0] [c000000000abf440] do_bind_con_driver.isr=
a.0+0x420/0x4e0
[   46.329546] [c00000000429ecb0] [c000000000abf6d8] do_take_over_console+0=
x1d8/0x300
[   46.329552] [c00000000429ed60] [c000000000a773f8] do_fbcon_takeover+0x11=
8/0x250
[   46.329558] [c00000000429ed80] [c000000000a7cdf8] fbcon_fb_registered+0x=
268/0x300
[   46.329565] [c00000000429edd0] [c000000000a6d164] do_register_framebuffe=
r+0x254/0x370
[   46.329570] [c00000000429eea0] [c000000000a6d2c4] register_framebuffer+0=
x44/0x70
[   46.329574] [c00000000429eed0] [c0080000005e8400] __drm_fb_helper_initia=
l_config_and_unlock+0x3b8/0x6a0 [drm_kms_helper]
[   46.329592] [c00000000429efb0] [c0080000008e99d8] drm_fbdev_ttm_client_h=
otplug+0xc0/0x150 [drm_ttm_helper]
[   46.329598] [c00000000429f030] [c008000000366994] drm_client_register+0x=
ac/0x120 [drm]
[   46.329633] [c00000000429f0c0] [c0080000008ea0b4] drm_fbdev_ttm_setup+0x=
bc/0x1008 [drm_ttm_helper]
[   46.329639] [c00000000429f140] [c008000001d21cc8] amdgpu_pci_probe+0x5b0=
/0x6e0 [amdgpu]
[   46.329918] [c00000000429f1e0] [c000000000a285c8] local_pci_probe+0x68/0=
x100
[   46.329924] [c00000000429f260] [c000000000a286f8] pci_call_probe+0x98/0x=
220
[   46.329929] [c00000000429f3c0] [c000000000a2a4e4] pci_device_probe+0xb4/=
0x220
[   46.329935] [c00000000429f410] [c000000000b2bd58] really_probe+0x108/0x5=
20
[   46.329942] [c00000000429f4a0] [c000000000b2c230] __driver_probe_device+=
0xc0/0x280
[   46.329949] [c00000000429f520] [c000000000b2c544] driver_probe_device+0x=
54/0x130
[   46.329956] [c00000000429f560] [c000000000b2c908] __driver_attach+0x118/=
0x2b0
[   46.329963] [c00000000429f5e0] [c000000000b27fa4] bus_for_each_dev+0xb4/=
0x140
[   46.329969] [c00000000429f640] [c000000000b2afa4] driver_attach+0x34/0x5=
0
[   46.329976] [c00000000429f660] [c000000000b2a1dc] bus_add_driver+0x16c/0=
x330
[   46.329982] [c00000000429f6f0] [c000000000b2e244] driver_register+0xa4/0=
x1b0
[   46.329989] [c00000000429f760] [c000000000a27b58] __pci_register_driver+=
0x68/0x80
[   46.329995] [c00000000429f780] [c0080000024c687c] amdgpu_init+0x8c/0xb4 =
[amdgpu]
[   46.330327] [c00000000429f7b0] [c000000000010b50] do_one_initcall+0x80/0=
x3b0
[   46.330332] [c00000000429f890] [c000000000241bb8] do_init_module+0x78/0x=
320
[   46.330339] [c00000000429f910] [c000000000245b44] init_module_from_file+=
0xb4/0x130
[   46.330347] [c00000000429f9f0] [c000000000245f50] sys_finit_module+0x330=
/0x4f0
[   46.330354] [c00000000429fb00] [c00000000002c998] system_call_exception+=
0x118/0x230
[   46.330359] [c00000000429fe50] [c00000000000cfdc] system_call_vectored_c=
ommon+0x15c/0x2ec
[   46.330366] --- interrupt: 3000 at 0x3fffa7bb3650
[   46.330369] NIP:  00003fffa7bb3650 LR: 00003fffa7bb3650 CTR: 00000000000=
00000
[   46.330373] REGS: c00000000429fe80 TRAP: 3000   Tainted: G        W     =
      (6.12.101+deb13-powerpc64le Debian 6.12.101-1)
[   46.330376] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> =
 CR: 48222244  XER: 00000000
[   46.330391] IRQMASK: 0
[   46.330391] GPR00: 0000000000000161 00003fffd74096a0 00003fffa7cc6d00 00=
00000000000039
[   46.330391] GPR04: 00003fffa5f9b7f8 0000000000000000 000000000000001f 00=
00000000000045
[   46.330391] GPR08: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000000
[   46.330391] GPR12: 0000000000000000 00003fffa8365400 0000000020000000 00=
00000000020000
[   46.330391] GPR16: 0000000000000000 0000000000000000 0000000102bfc790 00=
003fffd7409b70
[   46.330391] GPR20: 0000000122f81d80 0000000122f6db10 0000000000000000 00=
00000000000000
[   46.330391] GPR24: 0000000122f6db10 0000000000000000 0000000000000000 00=
003fffa5f9b7f8
[   46.330391] GPR28: 0000000122f695d0 0000000000020000 0000000122f6db10 00=
00000000000000
[   46.330441] NIP [00003fffa7bb3650] 0x3fffa7bb3650
[   46.330444] LR [00003fffa7bb3650] 0x3fffa7bb3650
[   46.330447] --- interrupt: 3000
[   46.330449] Code: 7d290034 5529d97e 69290001 0b090000 e93f0000 81290168 =
7d290034 5529d97e 0b090000 e95f08f0 312affff 7d295110 <0b090000> e93f05c8 3=
8e00002 39400000
[   46.330470] ---[ end trace 0000000000000000 ]---
[   56.564945] amdgpu 0000:01:00.0: [drm] *ERROR* [CRTC:60:crtc-0] flip_don=
e timed out
[   56.584201] amdgpu 0000:01:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[   56.812446] netfs: FS-Cache loaded
[   56.875570] RPC: Registered named UNIX socket transport module.
[   56.875646] RPC: Registered udp transport module.
[   56.875698] RPC: Registered tcp transport module.
[   56.875788] RPC: Registered tcp-with-tls transport module.
[   56.875840] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   57.195774] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.
[   58.345218] systemd[1]: Inserted module 'autofs4'
[   58.710288] systemd[1]: systemd 257.13-1~deb13u1 running in system mode =
(+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +=
OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPT=
SETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE =
+TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYS=
VINIT +LIBARCHIVE)
[   58.710641] systemd[1]: Detected virtualization kvm.
[   58.710706] systemd[1]: Detected architecture ppc64-le.

Welcome to Debian GNU/Linux 13 (trixie)!

[   58.782458] systemd[1]: Hostname set to <REDACTED>.
[   59.012309] systemd[1]: bpf-restrict-fs: Failed to link program; assumin=
g BPF LSM is not available.
[   59.310064] NET: Registered PF_VSOCK protocol family
[   59.343558] systemd-ssh-generator[342]: Failed to query local AF_VSOCK C=
ID: Cannot assign requested address
[   59.463103] systemd-sysv-generator[344]: SysV service '/etc/init.d/openi=
pmi' lacks a native systemd unit file, automatically generating a unit file=
 for compatibility.
[   59.463268] systemd-sysv-generator[344]: Please update package to includ=
e a native systemd unit file.
[   59.463365] systemd-sysv-generator[344]: =E2=9A=A0 This compatibility lo=
gic is deprecated, expect removal soon. =E2=9A=A0
[   59.566555] (sd-exec-[332]: /usr/lib/systemd/system-generators/systemd-s=
sh-generator failed with exit status 1.
[   64.460290] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:02.0/0000:01:00.1/sound/card1/input0
[   64.460546] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:02.0/0000:01:00.1/sound/card1/input1
[   64.460766] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:02.0/0000:01:00.1/sound/card1/input2
[   64.460981] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:02.0/0000:01:00.1/sound/card1/input3
[   64.471598] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:02.0/0000:01:00.1/sound/card1/input4
[   64.472038] input: HDA ATI HDMI HDMI/DP,pcm=3D11 as /devices/pci0000:00/=
0000:00:02.0/0000:01:00.1/sound/card1/input5
[   65.677564] IPMI message handler: version 39.2
[   65.696811] ipmi device interface
[   66.807828] amdgpu 0000:01:00.0: [drm] *ERROR* flip_done timed out
[   66.807985] amdgpu 0000:01:00.0: [drm] *ERROR* [CRTC:60:crtc-0] commit w=
ait timed out



