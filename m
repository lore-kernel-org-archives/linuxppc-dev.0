Return-Path: <eguan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1xm13T2GzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 18:21:05 +1000 (AEST)
Date: Tue, 4 Jul 2017 16:21:01 +0800
From: Eryu Guan <eguan@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: tj@kernel.org, Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
Message-ID: <20170704082101.GM23360@eguan.usersys.redhat.com>
References: <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
 <8760fdrdq1.fsf@concordia.ellerman.id.au>
 <20170630114756.GD23360@eguan.usersys.redhat.com>
 <87tw2syayk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fwqqG+mf3f7vyBCB"
In-Reply-To: <87tw2syayk.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2017 at 04:26:11PM +1000, Michael Ellerman wrote:
> Eryu Guan <eguan@redhat.com> writes:
> > On Fri, Jun 30, 2017 at 08:07:02PM +1000, Michael Ellerman wrote:
> >> 
> >> Can you try this patch and see if it changes anything? (with the debug
> >> still applied).
> >
> > This patch fixes the crash for me. After appliying this patch (with all
> > other debug patches still applied), kernel didn't print any warnings or
> > calltraces or debug messages.
> 
> OK. It's not meant to fix it :)

Understand.

> 
> I can't form any connection between your bisection result and that
> patch, nothing is making any sense TBH.
> 
> What hardware are you on? And are you doing CPU hotplug or anything like that?

It's a "PowerVM" guest (I'm not familiar with powerpc, I don't know what
does that mean..) running on Power8 host. I didn't do any CPU hotplug or
anything like that.

lscpu output:
Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-15
Thread(s) per core:    8
Core(s) per socket:    1
Socket(s):             2
NUMA node(s):          3
Model:                 2.1 (pvr 004b 0201)
Model name:            POWER8 (architected), altivec supported
Hypervisor vendor:     (null)
Virtualization type:   full
L1d cache:             64K
L1i cache:             32K
NUMA node0 CPU(s):     0-7
NUMA node2 CPU(s):     8-15
NUMA node3 CPU(s):

> 
> Can you back out the last patch I sent and try this?

I appended the calltraces from the test here, I also attached full dmesg
log, which included the boot log.

[   74.410871] ------------[ cut here ]------------
[   74.410895] WARNING: CPU: 0 PID: 2378 at kernel/workqueue.c:3346 alloc_unbound_pwq+0x320/0x690
[   74.410901] Modules linked in: ext4 jbd2 mbcache sg pseries_rng ghash_generic gf128mul xts vmx_crypto nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp
[   74.410949] CPU: 0 PID: 2378 Comm: mount Not tainted 4.12.0.debug+ #35
[   74.410954] task: c0000003f0447280 task.stack: c0000003f039c000
[   74.410959] NIP: c00000000011a310 LR: c00000000011a300 CTR: c00000000011a1e4
[   74.410963] REGS: c0000003f039f550 TRAP: 0700   Not tainted  (4.12.0.debug+)
[   74.410968] MSR: 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
[   74.410993]   CR: 24028888  XER: 00000001
[   74.410998] CFAR: c000000000581584 SOFTE: 1
[   74.410998] GPR00: c00000000011a590 c0000003f039f7d0 c000000001751800 0000000000000001
[   74.410998] GPR04: 00000000000000a0 00000000000000c0 0000000000000000 0000000000000000
[   74.410998] GPR08: ffffffffffffffff 0000000000000000 0000000000000000 0000000000000030
[   74.410998] GPR12: 0000000000000001 c00000000fac0000 0000000000000002 c0000003fd237000
[   74.410998] GPR16: c0000003d1a10400 0000000000000000 0000000000000000 0000000000000002
[   74.410998] GPR20: 0000000000000000 c0000003cb7ac560 c0000003fd0387a0 c00000000179a294
[   74.410998] GPR24: c0000003cb7ac400 c0000003f02349c0 00000000000000a0 c0000003f0234a00
[   74.410998] GPR28: 000000006ca6897b c0000003cb7ac400 c00000000179a294 0000000000000000
[   74.411082] NIP [c00000000011a310] alloc_unbound_pwq+0x320/0x690
[   74.411087] LR [c00000000011a300] alloc_unbound_pwq+0x310/0x690
[   74.411091] Call Trace:
[   74.411095] [c0000003f039f7d0] [c00000000011a590] alloc_unbound_pwq+0x5a0/0x690 (unreliable)
[   74.411103] [c0000003f039f830] [c00000000011aad4] apply_wqattrs_prepare+0x1f4/0x340
[   74.411113] [c0000003f039f8a0] [c00000000011ac5c] apply_workqueue_attrs_locked+0x3c/0xa0
[   74.411120] [c0000003f039f8d0] [c00000000011b1a4] apply_workqueue_attrs+0x54/0x90
[   74.411127] [c0000003f039f910] [c00000000011d774] __alloc_workqueue_key+0x184/0x5b0
[   74.411145] [c0000003f039f9d0] [d000000015211768] ext4_fill_super+0x1c68/0x33e0 [ext4]
[   74.411152] [c0000003f039fb10] [c0000000003910fc] mount_bdev+0x22c/0x260
[   74.411168] [c0000003f039fbb0] [d000000015209020] ext4_mount+0x20/0x40 [ext4]
[   74.411174] [c0000003f039fbd0] [c000000000392544] mount_fs+0x74/0x210
[   74.411181] [c0000003f039fc80] [c0000000003c0808] vfs_kern_mount+0x78/0x220
[   74.411188] [c0000003f039fd00] [c0000000003c61c4] do_mount+0x254/0xf70
[   74.411194] [c0000003f039fde0] [c0000000003c7304] SyS_mount+0x94/0x100
[   74.411201] [c0000003f039fe30] [c00000000000b190] system_call+0x38/0xe0
[   74.411206] Instruction dump:
[   74.411211] 554ac03e 7f8ae050 7b9c0020 2fac0000 409e0290 7f44d378 38a00000 484672cd
[   74.411227] 60000000 7c63d278 7c630074 7863d182 <0b030000> 3ca061c8 3f42001e 60a58647
[   74.411243] ---[ end trace b720011b125c3341 ]---
[   74.411253] ------------[ cut here ]------------
[   74.411258] WARNING: CPU: 0 PID: 2378 at kernel/workqueue.c:3376 alloc_unbound_pwq+0x4b0/0x690
[   74.411262] Modules linked in: ext4 jbd2 mbcache sg pseries_rng ghash_generic gf128mul xts vmx_crypto nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp
[   74.411303] CPU: 0 PID: 2378 Comm: mount Tainted: G        W       4.12.0.debug+ #35
[   74.411307] task: c0000003f0447280 task.stack: c0000003f039c000
[   74.411312] NIP: c00000000011a4a0 LR: c00000000011a490 CTR: 0000000000000000
[   74.411316] REGS: c0000003f039f550 TRAP: 0700   Tainted: G        W        (4.12.0.debug+)
[   74.411320] MSR: 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
[   74.411343]   CR: 28028888  XER: 20000001
[   74.411348] CFAR: c000000000581584 SOFTE: 1
[   74.411348] GPR00: c00000000011a474 c0000003f039f7d0 c000000001751800 0000000000000001
[   74.411348] GPR04: 00000000000000a0 00000000000000c0 0000000000000000 0000000000000000
[   74.411348] GPR08: ffffffffffffffff 0000000000000000 0000000000000000 0000000000000000
[   74.411348] GPR12: 0000000000008800 c00000000fac0000 0000000000000002 c0000003fd237000
[   74.411348] GPR16: c0000003d1a10400 0000000000000000 0000000000000000 0000000000000002
[   74.411348] GPR20: 0000000000000000 c0000003cb7ac560 c0000003fd0387a0 c00000000179a294
[   74.411348] GPR24: c0000003cb7ac400 c0000003f11ba800 c000000001935218 c0000003f0234a00
[   74.411348] GPR28: 00000000000000a0 c0000003cb7ac400 c00000000179a294 00000000000000a0
[   74.411431] NIP [c00000000011a4a0] alloc_unbound_pwq+0x4b0/0x690
[   74.411436] LR [c00000000011a490] alloc_unbound_pwq+0x4a0/0x690
[   74.411440] Call Trace:
[   74.411444] [c0000003f039f7d0] [c00000000011a474] alloc_unbound_pwq+0x484/0x690 (unreliable)
[   74.411452] [c0000003f039f830] [c00000000011aad4] apply_wqattrs_prepare+0x1f4/0x340
[   74.411459] [c0000003f039f8a0] [c00000000011ac5c] apply_workqueue_attrs_locked+0x3c/0xa0
[   74.411465] [c0000003f039f8d0] [c00000000011b1a4] apply_workqueue_attrs+0x54/0x90
[   74.411472] [c0000003f039f910] [c00000000011d774] __alloc_workqueue_key+0x184/0x5b0
[   74.411488] [c0000003f039f9d0] [d000000015211768] ext4_fill_super+0x1c68/0x33e0 [ext4]
[   74.411494] [c0000003f039fb10] [c0000000003910fc] mount_bdev+0x22c/0x260
[   74.411510] [c0000003f039fbb0] [d000000015209020] ext4_mount+0x20/0x40 [ext4]
[   74.411516] [c0000003f039fbd0] [c000000000392544] mount_fs+0x74/0x210
[   74.411523] [c0000003f039fc80] [c0000000003c0808] vfs_kern_mount+0x78/0x220
[   74.411529] [c0000003f039fd00] [c0000000003c61c4] do_mount+0x254/0xf70
[   74.411535] [c0000003f039fde0] [c0000000003c7304] SyS_mount+0x94/0x100
[   74.411542] [c0000003f039fe30] [c00000000000b190] system_call+0x38/0xe0
[   74.411547] Instruction dump:
[   74.411552] 4bffa3b9 93f9004c e93904b8 83fe0000 38a00000 7fe4fb78 e8690008 4846713d
[   74.411567] 60000000 7fe31a78 7c630074 7863d182 <0b030000> e93904b8 39400000 7f23cb78
[   74.411584] ---[ end trace b720011b125c3342 ]---
[   74.411704] ------------[ cut here ]------------
[   74.411710] WARNING: CPU: 0 PID: 2378 at kernel/workqueue.c:1788 create_worker+0x174/0x2c0
[   74.411714] Modules linked in: ext4 jbd2 mbcache sg pseries_rng ghash_generic gf128mul xts vmx_crypto nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp
[   74.411755] CPU: 0 PID: 2378 Comm: mount Tainted: G        W       4.12.0.debug+ #35
[   74.411759] task: c0000003f0447280 task.stack: c0000003f039c000
[   74.411763] NIP: c000000000114ed4 LR: c000000000114ec4 CTR: c0000000001343e0
[   74.411768] REGS: c0000003f039f4b0 TRAP: 0700   Tainted: G        W        (4.12.0.debug+)
[   74.411772] MSR: 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
[   74.411795]   CR: 28028888  XER: 00000001
[   74.411801] CFAR: c000000000581584 SOFTE: 1
[   74.411801] GPR00: c000000000114ea0 c0000003f039f730 c000000001751800 0000000000000001
[   74.411801] GPR04: 00000000000000a0 00000000000000c0 0000000000000000 00000000000c0063
[   74.411801] GPR08: ffffffffffffffff 0000000000000000 0000000000000000 0000000000000062
[   74.411801] GPR12: 0000000048028882 c00000000fac0000 0000000000000002 c0000003fd237000
[   74.411801] GPR16: c0000003d1a10400 0000000000000000 0000000000000000 0000000000000002
[   74.411801] GPR20: 0000000000000000 c0000003cb7ac560 c0000003fd0387a0 c00000000179a294
[   74.411801] GPR24: c0000003cb7ac400 c0000003f11ba800 c000000001935218 c0000003f11baca8
[   74.411801] GPR28: c0000003f039f790 00000000000000a0 c0000003fd25c000 c0000003f11ba800
[   74.411884] NIP [c000000000114ed4] create_worker+0x174/0x2c0
[   74.411888] LR [c000000000114ec4] create_worker+0x164/0x2c0
[   74.411892] Call Trace:
[   74.411895] [c0000003f039f730] [c000000000114ea0] create_worker+0x140/0x2c0 (unreliable)
[   74.411903] [c0000003f039f7d0] [c00000000011a508] alloc_unbound_pwq+0x518/0x690
[   74.411910] [c0000003f039f830] [c00000000011aad4] apply_wqattrs_prepare+0x1f4/0x340
[   74.411916] [c0000003f039f8a0] [c00000000011ac5c] apply_workqueue_attrs_locked+0x3c/0xa0
[   74.411923] [c0000003f039f8d0] [c00000000011b1a4] apply_workqueue_attrs+0x54/0x90
[   74.411929] [c0000003f039f910] [c00000000011d774] __alloc_workqueue_key+0x184/0x5b0
[   74.411946] [c0000003f039f9d0] [d000000015211768] ext4_fill_super+0x1c68/0x33e0 [ext4]
[   74.411952] [c0000003f039fb10] [c0000000003910fc] mount_bdev+0x22c/0x260
[   74.411968] [c0000003f039fbb0] [d000000015209020] ext4_mount+0x20/0x40 [ext4]
[   74.411974] [c0000003f039fbd0] [c000000000392544] mount_fs+0x74/0x210
[   74.411980] [c0000003f039fc80] [c0000000003c0808] vfs_kern_mount+0x78/0x220
[   74.411986] [c0000003f039fd00] [c0000000003c61c4] do_mount+0x254/0xf70
[   74.411993] [c0000003f039fde0] [c0000000003c7304] SyS_mount+0x94/0x100
[   74.411999] [c0000003f039fe30] [c00000000000b190] system_call+0x38/0xe0
[   74.412004] Instruction dump:
[   74.412009] 3d220005 39298a94 e87e0040 38a00000 83a90000 38630380 7fa4eb78 4846c709
[   74.412025] 60000000 7fa31a78 7c630074 7863d182 <0b030000> 3d420005 394a8a94 e93f04b8
[   74.412041] ---[ end trace b720011b125c3343 ]---
[   74.412046] ------------[ cut here ]------------
[   74.412051] WARNING: CPU: 0 PID: 2378 at kernel/workqueue.c:1789 create_worker+0x1a8/0x2c0
[   74.412055] Modules linked in: ext4 jbd2 mbcache sg pseries_rng ghash_generic gf128mul xts vmx_crypto nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp
[   74.412095] CPU: 0 PID: 2378 Comm: mount Tainted: G        W       4.12.0.debug+ #35
[   74.412099] task: c0000003f0447280 task.stack: c0000003f039c000
[   74.412103] NIP: c000000000114f08 LR: c000000000114ef8 CTR: c0000000001343e0
[   74.412108] REGS: c0000003f039f4b0 TRAP: 0700   Tainted: G        W        (4.12.0.debug+)
[   74.412144] MSR: 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
[   74.412167]   CR: 28028888  XER: 00000001
[   74.412172] CFAR: c000000000581584 SOFTE: 1
[   74.412172] GPR00: c000000000114ea0 c0000003f039f730 c000000001751800 0000000000000001
[   74.412172] GPR04: 00000000000000a0 00000000000000c0 0000000000000000 00000000000c0063
[   74.412172] GPR08: ffffffffffffffff 0000000000000000 0000000000000000 0000000000000062
[   74.412172] GPR12: 0000000048028882 c00000000fac0000 0000000000000002 c0000003fd237000
[   74.412172] GPR16: c0000003d1a10400 0000000000000000 0000000000000000 0000000000000002
[   74.412172] GPR20: 0000000000000000 c0000003cb7ac560 c0000003fd0387a0 c00000000179a294
[   74.412172] GPR24: c0000003cb7ac400 c0000003f11ba800 c000000001935218 c0000003f11baca8
[   74.412172] GPR28: c0000003f039f790 00000000000000a0 c0000003fd25c000 c0000003f11ba800
[   74.412255] NIP [c000000000114f08] create_worker+0x1a8/0x2c0
[   74.412259] LR [c000000000114ef8] create_worker+0x198/0x2c0
[   74.412263] Call Trace:
[   74.412267] [c0000003f039f730] [c000000000114ea0] create_worker+0x140/0x2c0 (unreliable)
[   74.412275] [c0000003f039f7d0] [c00000000011a508] alloc_unbound_pwq+0x518/0x690
[   74.412281] [c0000003f039f830] [c00000000011aad4] apply_wqattrs_prepare+0x1f4/0x340
[   74.412288] [c0000003f039f8a0] [c00000000011ac5c] apply_workqueue_attrs_locked+0x3c/0xa0
[   74.412294] [c0000003f039f8d0] [c00000000011b1a4] apply_workqueue_attrs+0x54/0x90
[   74.412301] [c0000003f039f910] [c00000000011d774] __alloc_workqueue_key+0x184/0x5b0
[   74.412317] [c0000003f039f9d0] [d000000015211768] ext4_fill_super+0x1c68/0x33e0 [ext4]
[   74.412323] [c0000003f039fb10] [c0000000003910fc] mount_bdev+0x22c/0x260
[   74.412339] [c0000003f039fbb0] [d000000015209020] ext4_mount+0x20/0x40 [ext4]
[   74.412345] [c0000003f039fbd0] [c000000000392544] mount_fs+0x74/0x210
[   74.412352] [c0000003f039fc80] [c0000000003c0808] vfs_kern_mount+0x78/0x220
[   74.412358] [c0000003f039fd00] [c0000000003c61c4] do_mount+0x254/0xf70
[   74.412364] [c0000003f039fde0] [c0000000003c7304] SyS_mount+0x94/0x100
[   74.412371] [c0000003f039fe30] [c00000000000b190] system_call+0x38/0xe0
[   74.412376] Instruction dump:
[   74.412380] 3d420005 394a8a94 e93f04b8 38a00000 83aa0000 e8690008 7fa4eb78 4846c6d5
[   74.412396] 60000000 7fa31a78 7c630074 7863d182 <0b030000> 7fe4fb78 7fc3f378 4bfffd75
[   74.412412] ---[ end trace b720011b125c3344 ]---
[   74.412524] select_task_rq: CPU 160 out of range for task c0000003f1500000 (kworker/u321:0)
[   74.412612] p->cpus_allowed:
[   74.412616] CPU: 0 PID: 2378 Comm: mount Tainted: G        W       4.12.0.debug+ #35
[   74.412620] Call Trace:
[   74.412625] [c0000003f039f620] [c000000000a562a8] dump_stack+0xe8/0x154 (unreliable)
[   74.412635] [c0000003f039f660] [c000000000135b2c] try_to_wake_up+0x1bc/0x940
[   74.412641] [c0000003f039f730] [c000000000114f44] create_worker+0x1e4/0x2c0
[   74.412647] [c0000003f039f7d0] [c00000000011a508] alloc_unbound_pwq+0x518/0x690
[   74.412654] [c0000003f039f830] [c00000000011aad4] apply_wqattrs_prepare+0x1f4/0x340
[   74.412660] [c0000003f039f8a0] [c00000000011ac5c] apply_workqueue_attrs_locked+0x3c/0xa0
[   74.412667] [c0000003f039f8d0] [c00000000011b1a4] apply_workqueue_attrs+0x54/0x90
[   74.412673] [c0000003f039f910] [c00000000011d774] __alloc_workqueue_key+0x184/0x5b0
[   74.412689] [c0000003f039f9d0] [d000000015211768] ext4_fill_super+0x1c68/0x33e0 [ext4]
[   74.412700] [c0000003f039fb10] [c0000000003910fc] mount_bdev+0x22c/0x260
[   74.412715] [c0000003f039fbb0] [d000000015209020] ext4_mount+0x20/0x40 [ext4]
[   74.412722] [c0000003f039fbd0] [c000000000392544] mount_fs+0x74/0x210
[   74.412728] [c0000003f039fc80] [c0000000003c0808] vfs_kern_mount+0x78/0x220
[   74.412734] [c0000003f039fd00] [c0000000003c61c4] do_mount+0x254/0xf70
[   74.412740] [c0000003f039fde0] [c0000000003c7304] SyS_mount+0x94/0x100
[   74.412749] [c0000003f039fe30] [c00000000000b190] system_call+0x38/0xe0
[   74.420022] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)

Thanks,
Eryu
> 
> cheers
> 
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c74bf39ef764..8ec3841f9689 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3338,6 +3338,8 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  
>  	lockdep_assert_held(&wq_pool_mutex);
>  
> +	WARN_ON(cpumask_empty(attrs->cpumask));
> +
>  	/* do we already have a matching pool? */
>  	hash_for_each_possible(unbound_pool_hash, pool, hash_node, hash) {
>  		if (wqattrs_equal(pool->attrs, attrs)) {
> @@ -3366,6 +3368,8 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  	copy_workqueue_attrs(pool->attrs, attrs);
>  	pool->node = target_node;
>  
> +	WARN_ON(cpumask_empty(pool->attrs->cpumask));
> +
>  	/*
>  	 * no_numa isn't a worker_pool attribute, always clear it.  See
>  	 * 'struct workqueue_attrs' comments for detail.
> @@ -5494,6 +5498,7 @@ static void __init wq_numa_init(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		node = cpu_to_node(cpu);
> +		printk("%s: setting cpu %d on node %d present? %d\n", __func__, cpu, node, cpu_present(cpu));
>  		if (WARN_ON(node == NUMA_NO_NODE)) {
>  			pr_warn("workqueue: NUMA node mapping not available for cpu%d, disabling NUMA support\n", cpu);
>  			/* happens iff arch is bonkers, let's just proceed */
> @@ -5502,6 +5507,16 @@ static void __init wq_numa_init(void)
>  		cpumask_set_cpu(cpu, tbl[node]);
>  	}
>  
> +	for_each_possible_cpu(cpu) {
> +		struct worker_pool *pool;
> +
> +		for_each_cpu_worker_pool(pool, cpu) {
> +			if (cpumask_empty(pool->attrs->cpumask))
> +				printk("%s: cpumask EMPTY! for pool %p on cpu %d\n", __func__, pool, cpu);
> +			printk("%s: pool %p on cpu %d node = %d\n", __func__, pool, cpu, pool->node);
> +		}
> +	}
> +
>  	wq_numa_possible_cpumask = tbl;
>  	wq_numa_enabled = true;
>  }

--fwqqG+mf3f7vyBCB
Content-Type: application/x-bzip2
Content-Disposition: attachment; filename="dmesg.log.bz2"
Content-Transfer-Encoding: base64

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
FtLYz8f+bAXjbzXygU6ZXpK6JBILzU8pyOb4B5A5A2ohc1+h1z+nfPx2HyWWiWqE76Pllj19
diFZyNK1VklzmQc/UQl44iMuvjtq4sEPsEwzM12Z6RaXTa6ROfn69lwBu4KQl8K/ov3CsQAk
sZoW8E+cvcLLjHb0y+R4B5vnvOC37NtiJJjkib4HhIwX4qQ8on/MMvHoqrJaKm6G4ij03/1v
2WA9ELbbuOdz2wD4aP5eySSTSWe5mZmZ7Pe5mZmZ7YX8u39Sz8w7op7e/1e2j9qtNIPGzyy9
8ms+nYe3O+9F5q+tWIfwsENleav6lYr86HNXirSJyVjFbiv8TzE/2iY4J1sbp53+qLzPvyho
dDubjRz7vrcThjj9lYHwZhplt9PHhjKPZpJHYv8ntykhj7Nkt4Y/MD8Af1AP3gfUG4NgXnBd
4Lw08PuABewBdYk4YEwly4H0LMbgonyzft7HP8bv54avKvYT723NgC96BHWadTprzauoWK8Q
vexR54lHu5/pJT9FtmDHvGjv9XyemjE7H/XxKB6mPYJKdGUgXsJ8JbQ1iZWHqsJz0gG/Tv9P
ZSLdtVCCHaQBqIsjIikjIqH44iBH8t/bcQQMjCkiYxkGhJhQhEXMpkEZHKBmxYrYHOL5kkAt
A+1do+2bazVaVCsgFC2qqBrgXMCRAIppBQyLFJMLT6czp5A+j+XRF5W8Ky8AefQrvYrFexWm
mBGBGaDStK0rFYNMGMGMqSQAsIWVpW36N/0a9r7/mfq4A/z6oIgkjKJhgxAAQlyIV5oIfxox
Z2O23Wc3PZwm5ilHUoktXqIgb3R3d3d3REDe6O7u7uXKOju7u7jDhKEklqMOEoSSWroiBvdH
d3d3dEQN7o7u7u5co6O7u7uLJQkkkiyUJJJLncb3R3d3d3O43uju7u7lyjo7u7u5wwYMPssh
PL1VVzQopJ5udGBERLvPdyaCYBwBiOzg14uLm8Sm7rvdXBRyOBCEIY4cd857899777777+aV
VVVVVVVVetHp1RzfxLKrOkUblpoQMhME4J85KCXIENhf81hcVKlxAkWGRgYl5QoUKFCM2ZmZ
mZVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
VVVVVVVVVVVVVVVVVVVVVVVVVVVVVV3d3d3d7u7SxakkuvmgBgGHu3gG+Qr5+L8xuGGmuOux
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
Y3OSE7n4ZSPEr7pQOXMWvF/DXPj/J0SSTCX6cwVHlXgs3r6ECYFsPW7lrawE8ETFjsRwH4Yc
+vMt+UVAE/vB9YP6bgAn2C/kkJPODZVReyA/49c/3qvtK/N8RXI+72/R+39n1GWeWOOYv1fV
hqccjWLHvBc5CTrNjMUUVtmZmA/oI5un24WUDAxLOoXG155L3PUM7zl5D3vmUKl7C5K98yvK
hEHlG5O+TRSMoDUm8iJscIkDRe5A2dtXRUZ0EmdmTxU2FF8nTTK0edZOxoUPmPppNpjLsiYe
o5eRRm5NX3RVUAaU4Q2CMMTBD0CdqryK0kFuzarZc6d1hUxkGb6oh9SMd2vYAFbNzXHJnaMw
5FDpgoRUY8ecFy5MppVTwVmV4vMG3iC1Xmo4dcou97mvBW7OjdjRpg7uw8TuPFVV1uvhnXgn
RG7WiNzWsvJ2ChFE6qtxZGhGsi6BMh6gvOmotZJ2FL2knyJS3IrcvIpTBQqZ6FSZ3tjNNMNM
dMcLCCOSsWMHRCNrK/crFdNcdLVstStb4Qq5pIOQ4jHS0y2vjYhmbS1eWXamZnZmqsmYVK62
9NbT73RgGFxxmZwAHA0OPwb5lgMw0aeKRnkzgfQjl1sdubL7j48PZdH9+he6zNCpVDjg75dX
tX20IOCnuPB6arGYd6uZml37Nu/SzNw4Ut3d3d3d3XJJRwrd3d3d3ZmTpKx3O4bx3dzWVVEl
Fa1mEk5rMwrRJWazMJJN3d2SSdZd2STejeXhJTu+Zl4SSby80UVo5eEknKu9HCcc3mry8Jd3
fKvHJKfMwkk3l5eazMwko3hJzWZllZMkvE3ZwvBT6vCS7uluu7u5KOu8zMnd13eHSSSmZlLd
3dcuLy5vc3DO7slYcNpyt3CssuVhWHAVhW7hQw4Vh14RJcklLTu6dSR04dOpK9o643aW7u7o
W7hzFjlYVZwp8Kw2Vh2lKTsjZZKcjWAnifY4DoBaeHU8Pi/0Qd1obLvHe789b1f6QfN+oPxq
2fiK+JyV+ix94frV/s0ILfHv8AfHoSUUl9n7gX8fsVbi0tfUABDmABFz0u+6u3uC6u2/5bUD
y4q/tV7VfzK7H7QAVX6mnaAWoA0L7gghYAv3qVyVLMTtvfc+Un25zfk1/3ufOuvOOWOx8wWS
3pJn1HCUFEt1n0reCtNEA8z9ff2tlHIVwVivT9m3RuX3xvx/FN/cr86ujB3DBxBs82H4g8k+
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
6nl1pAJzgP/4u5IpwoSFht4zMA==

--fwqqG+mf3f7vyBCB--
