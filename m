Return-Path: <linuxppc-dev+bounces-25905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E75C5B572
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 15:29:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNxZZ0HNSz2xtt;
	Tue, 18 Aug 2026 01:29:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786980549;
	cv=none; b=cT7wNZX9+sJfUIa0OxUkxmedLmPaKThAAAVSQBaWhGty9JG0qizoj3XUQz3z5cE2imxW06UahDKkir/eawVyL/G7qBOf/hkLL65FsSN8wml8qFlVyIoLIk3YLLsY6j7px5uhJ72cnD4jBl5FHDsjYzaBk+bayQzORVlLu3LZj1UNz68Nxm6ScgTZ26DV8BIGBIzSM1AGcwVOmDzPtrwMHT+EFegRIsPfL+eF+9Y8ieVE6f28X1JvtZESYOGfaGUCVeYdSHCZIdyuRrBKdXlu+WIhoVQfQ3z7dQFe39rtPdQl9x7dyfDRIAiMn/aLLC/pS8E5guZjWbQjAQbFL9kO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786980549; c=relaxed/relaxed;
	bh=wqgpDUacGwQlE7sN9Z4cU8nKJHbY24wGY+ol2ZeM+EQ=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=coN5AFY+ek48llHb3KcK2JlwY1wvjbgpRowaDFhMcFWE7KoD9vkMRNb0c1ww+W8QguRkb0zqYjli6Av4Gkmdjz/5zXblFJHruIV7dVK0/wCPk2dfIDnN30Pl55wQuuNf/5+qd7mixL5Wb1chn0DH/Gwor53vHmudV642MH7gUDI5T3cWjcZpdKDmVe9FioS9I5Tc5XZZikcwhbuHAtiSZu7vfW6fi9tKfL1yJEt5Sq4FgQzPJ4rt9waA61YPIhoUHBA12t7KNmdYZO7lgFViXrZrVRhRVWcJLxhlRQdcejWrRzAEejJDLnJTFz08xYOQpK96EJXCiRjsUdQ3aAeRQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=jq8I9W5o; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=jq8I9W5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNxZX6r8yz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 01:29:08 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 58CDE7792B27;
	Mon, 17 Aug 2026 10:29:06 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cqPx0lsPu--Q; Mon, 17 Aug 2026 10:29:04 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BCC8C7792AB3;
	Mon, 17 Aug 2026 10:29:04 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com BCC8C7792AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786980544; bh=wqgpDUacGwQlE7sN9Z4cU8nKJHbY24wGY+ol2ZeM+EQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=jq8I9W5oLZoxhSNw1omqZDt2s3PL+el71VyzmEJSQdnC2xQFsSHamublZNzCjPtyQ
	 OmzR0wT77j19vhEs6WYF5kFbw9ifkLBBAGKyBmMzCjzSUIcCp2PBHN0cqsLNOPovge
	 hP8eBqMVX3hJDYlc86ihuN6zY2fmrnzX9+2Zh+DU=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R1yOHZcJEU0p; Mon, 17 Aug 2026 10:29:04 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 7AE087792A51;
	Mon, 17 Aug 2026 10:29:04 -0500 (CDT)
Date: Mon, 17 Aug 2026 10:29:00 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <203407354.16057.1786980540348.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [REGRESSION] Stuck CPUs after kexec() on PowerNV
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
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC151 (Linux)/8.5.0_GA_3042)
Thread-Index: nA7AfflprNPUr+j54e5ptB81FPapfQ==
Thread-Topic: Stuck CPUs after kexec() on PowerNV

On a POWER9/PowerNV dual CPU host, when launching a pSeries VM via QEMU which exposes more than around 8 guest CPU cores, there is a rapidly increasing probability of a stuck CPU after kexec() runs, which is highly sensitive to the number of cores available in the guest VM.  If an attempt is made to pass through all cores on a 144 core system, multiple stuck CPUs are effectively guaranteed along with an associated boot failure of the guest.

Here is a typical guest dmesg after kexec(), note the CPU 8 stuck message:

[    0.000000] random: crng init done
[    0.000000] radix-mmu: Page sizes from device-tree:
[    0.000000] radix-mmu: Page size shift = 12 AP=0x0
[    0.000000] radix-mmu: Page size shift = 16 AP=0x5
[    0.000000] radix-mmu: Page size shift = 21 AP=0x1
[    0.000000] radix-mmu: Page size shift = 30 AP=0x2
[    0.000000] Activating Kernel Userspace Access Prevention
[    0.000000] Activating Kernel Userspace Execution Prevention
[    0.000000] radix-mmu: Mapped 0x0000000000000000-0x0000000002600000 with 2.00 MiB pages (exec)
[    0.000000] radix-mmu: Mapped 0x0000000002600000-0x0000000040000000 with 2.00 MiB pages
[    0.000000] radix-mmu: Mapped 0x0000000040000000-0x0000008000000000 with 1.00 GiB pages
[    0.000000] lpar: Using radix MMU under hypervisor
[    0.000000] Linux version 6.12.95+deb13-powerpc64le (debian-kernel@lists.debian.org) (powerpc64le-linux-gnu-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP Debian 6.12.95-1 (2026-07-04)
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
[    0.000000] Found initrd at 0xc0000000064f0000:0xc000000007d7979c
[    0.000000] Hardware name: IBM pSeries (emulated by qemu) POWER9 (architected) 0x4e1203 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
[    0.000000] printk: legacy bootconsole [udbg0] enabled
[    0.000000] Partition configured for 43 cpus.
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] Allocated 1624 bytes for 43 pacas
[    0.000000] numa: Partition configured for 1 NUMA nodes.
[    0.000000] -----------------------------------------------------
[    0.000000] phys_mem_size     = 0x8000000000
[    0.000000] dcache_bsize      = 0x80
[    0.000000] icache_bsize      = 0x80
[    0.000000] cpu_features      = 0x0001c06b8f4f9183
[    0.000000]   possible        = 0x001ffbebcf5fb187
[    0.000000]   always          = 0x0000000380008181
[    0.000000] cpu_user_features = 0xdc0065c2 0xaef00000
[    0.000000] mmu_features      = 0x1c007641
[    0.000000] firmware_features = 0x00000885455a445f
[    0.000000] vmalloc start     = 0xc008000000000000
[    0.000000] IO start          = 0xc00a000000000000
[    0.000000] vmemmap start     = 0xc00c000000000000
[    0.000000] -----------------------------------------------------
[    0.000000] NODE_DATA(0) allocated [mem 0x7fffa28f00-0x7fffa310ff]
[    0.000000] rfi-flush: fallback displacement flush available
[    0.000000] rfi-flush: ori type flush available
[    0.000000] rfi-flush: mttrig type flush available
[    0.000000] rfi-flush: patched 12 locations (ori+mttrig type flush)
[    0.000000] count-cache-flush: hardware flush enabled.
[    0.000000] link-stack-flush: software flush enabled.
[    0.000000] entry-flush: patched 61 locations (ori+mttrig type flush)
[    0.000000] uaccess-flush: patched 1 locations (ori+mttrig type flush)
[    0.000000] stf-barrier: eieio barrier available
[    0.000000] stf-barrier: patched 61 entry locations (eieio barrier)
[    0.000000] stf-barrier: patched 12 exit locations (eieio barrier)
[    0.000000] PPC64 nvram contains 65536 bytes
[    0.000000] barrier-nospec: using ORI speculation barrier
[    0.000000] barrier-nospec: patched 176 locations
[    0.000000] Top of RAM: 0x8000000000, Total RAM: 0x8000000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000007fffffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000007fffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000007fffffffff]
[    0.000000] percpu: Embedded 39 pages/cpu s120472 r0 d39272 u159744
[    0.000000] pcpu-alloc: s120472 r0 d39272 u159744 alloc=39*4096
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15
[    0.000000] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 22 [0] 23
[    0.000000] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] 30 [0] 31
[    0.000000] pcpu-alloc: [0] 32 [0] 33 [0] 34 [0] 35 [0] 36 [0] 37 [0] 38 [0] 39
[    0.000000] pcpu-alloc: [0] 40 [0] 41 [0] 42
[    0.000000] Kernel command line: root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.2:/mnt/udata/nfsroots/ppc64el/astrid,v3,hard,nointr,tcp ip=192.168.2.36::192.168.2.1:255.255.255.0:embed-o-matic:enp0s0:off ast.modeset=0 console=tty0 console=hvc0,115200n8 panic=10 rw
[    0.000000] Unknown kernel command line parameters "nfsroot=192.168.2.2:/mnt/udata/nfsroots/ppc64el/astrid,v3,hard,nointr,tcp ip=192.168.2.36::192.168.2.1:255.255.255.0:embed-o-matic:enp0s0:off", will be passed to user space.
[    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] printk: log_buf_len total cpu_extra contributions: 172032 bytes
[    0.000000] printk: log_buf_len min size: 131072 bytes
[    0.000000] printk: log_buf_len: 524288 bytes
[    0.000000] printk: early log buf free: 126384(96%)
[    0.000000] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, linear)
[    0.000000] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 134217728
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=43, Nodes=1
[    0.000000] ftrace: allocating 38704 entries in 227 pages
[    0.000000] ftrace: allocated 227 pages with 5 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=43.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=43
[    0.000000] RCU Tasks Rude: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=43.
[    0.000000] RCU Tasks Trace: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=43.
[    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000] xive: Using IRQ range [0-2a]
[    0.000000] xive: Interrupt handling initialized with spapr backend
[    0.000000] xive: Using priority 6 for all interrupts
[    0.000000] xive: Using 64kB queues
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] time_init: decrementer frequency = 512.000000 MHz
[    0.000000] time_init: processor frequency   = 2134.000000 MHz
[    0.000001] time_init: 56 bit decrementer (max: 7fffffffffffff)
[    0.000735] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.002016] clocksource: timebase mult[1f40000] shift[24] registered
[    0.002809] clockevent: decrementer mult[83126f] shift[24] cpu[0]
[    0.002967] Console: colour dummy device 80x25
[    0.003524] printk: legacy console [tty0] enabled
[    0.004385] printk: legacy console [hvc0] enabled
[    0.005019] printk: legacy bootconsole [udbg0] disabled
[    0.005768] pid_max: default: 44032 minimum: 344
[    0.005904] LSM: initializing lsm=capability,landlock,lockdown,yama,apparmor,tomoyo,bpf,ipe,ima,evm
[    0.006096] landlock: Up and running.
[    0.006139] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.006342] AppArmor: AppArmor initialized
[    0.006439] TOMOYO Linux initialized
[    0.006858] LSM support for eBPF active
[    0.007186] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.007404] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.008424] POWER9 performance monitor hardware support registered
[    0.008547] rcu: Hierarchical SRCU implementation.
[    0.008602] rcu:     Max phase no-delay instances is 1000.
[    0.008725] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.009704] smp: Bringing up secondary CPUs ...
[    5.021136] Processor 8 is stuck.
[    5.040206] smp: Brought up 1 node, 42 CPUs
[    5.040269] numa: Node 0 CPUs: 0-42
[    5.539085] node 0 deferred pages initialised in 468ms
[    5.539259] Memory: 528141096K/536870912K available (16428K kernel code, 2300K rwdata, 16340K rodata, 5080K init, 1320K bss, 8695376K reserved, 0K cma-reserved)
[    5.592658] devtmpfs: initialized
[    5.604671] PCI host bridge /pci@800000020000000  ranges:
[    5.604729]   IO 0x0000200000000000..0x000020000000ffff -> 0x0000000000000000
[    5.604796]  MEM 0x0000200080000000..0x00002000ffffffff -> 0x0000000080000000
[    5.604861]  MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000
[    5.605039] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    5.605248] futex hash table entries: 16384 (order: 9, 2097152 bytes, linear)
[    5.607696] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    5.607954] audit: initializing netlink subsys (disabled)
[    5.608195] audit: type=2000 audit(1786980313.572:1): state=initialized audit_enabled=0 res=1
[    5.608317] thermal_sys: Registered thermal governor 'fair_share'
[    5.608344] thermal_sys: Registered thermal governor 'bang_bang'
[    5.608416] thermal_sys: Registered thermal governor 'step_wise'
[    5.608576] thermal_sys: Registered thermal governor 'user_space'
[    5.608659] thermal_sys: Registered thermal governor 'power_allocator'

