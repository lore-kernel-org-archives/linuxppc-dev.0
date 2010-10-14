Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CA262B70E8
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 00:25:08 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id o9EDP3Z1000808
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 18:55:03 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9EDP3iY4100230
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 18:55:03 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9EDP3jT015679
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 00:25:03 +1100
Message-ID: <4CB704AC.4070203@linux.vnet.ibm.com>
Date: Thu, 14 Oct 2010 18:55:00 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: systemtap@sources.redhat.com, linuxppc-dev@ozlabs.org
Subject: Oops while running systemtap on the p6 machine against the kernel
	version 2.6.36-rc7-git3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While running systemtap tests on the p6 machine , against the kernel version 2.6.36-rc7-git3
Oops occured , here are the call trace

  BUG: spinlock bad magic on CPU#6, stapio/20398
-- 0:conmux-control -- time-stamp -- Oct/13/10  2:49:18 --res
  lock: c000000000fcfa18, .magic: 00000000, .owner:<none>/-1, .owner_cpu: 0
Call Trace:
[c0000001effbfab0] [c000000000011934] .show_stack+0x6c/0x16c (unreliable)
[c0000001effbfb60] [c0000000002c9274] .spin_bug+0xb0/0xd4
[c0000001effbfbf0] [c0000000002c953c] .do_raw_spin_lock+0x48/0x184
[c0000001effbfc90] [c00000000054af78] ._raw_spin_lock+0x10/0x24
[c0000001effbfd00] [d000000003015908] .__stp_time_timer_callback+0x94/0x13c [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
[c0000001effbfdc0] [c00000000009c2f8] .run_timer_softirq+0x1d8/0x2a8
[c0000001effbfec0] [c0000000000952d0] .__do_softirq+0xe4/0x1b4
[c0000001effbff90] [c00000000002a7a8] .call_do_softirq+0x14/0x24
[c00000010af1f560] [c00000000000dde4] .do_softirq+0x88/0xf0
[c00000010af1f600] [c000000000095030] .irq_exit+0x50/0xac
[c00000010af1f680] [c000000000027660] .timer_interrupt+0x110/0x13c
[c00000010af1f710] [c000000000003718] decrementer_common+0x118/0x180
--- Exception: 901 at .smp_call_function_many+0x284/0x2d0
     LR = .smp_call_function_many+0x268/0x2d0
[c00000010af1fae0] [c0000000000c55c4] .smp_call_function+0x3c/0x54
[c00000010af1fb60] [c000000000094cdc] .on_each_cpu+0x24/0x84
[c00000010af1fc00] [d000000003016738] ._stp_ctl_write_cmd+0x3b0/0x9c8 [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
[c00000010af1fce0] [c0000000001585f4] .vfs_write+0xd0/0x1b8
[c00000010af1fd80] [c0000000001587e4] .SyS_write+0x58/0xa0
[c00000010af1fe30] [c0000000000085b4] syscall_exit+0x0/0x40
------------[ cut here ]------------
kernel BUG at kernel/timer.c:681!
Oops: Exception in kernel mode, sig: 5 [#1]
SMP NR_CPUS=1024 NUMA pSeries
last sysfs file: /sys/module/stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798/sections/__param
Modules linked in: stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798 ipv6 fuse loop dm_mod ibmveth sg sr_mod cdrom sd_mod crc_t10dif ibmvscsic scsi_transport_srp scsi_tgt scsi_mod [last unloaded: stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
NIP: c00000000009d090 LR: d00000000301597c CTR: c00000000009cfb0
REGS: c0000001effbf9d0 TRAP: 0700   Not tainted  (2.6.36-rc7-git3-autotest)
MSR: 8000000000029032<EE,ME,CE,IR,DR>   CR: 28000482  XER: 00000002
TASK = c000000103422410[20398] 'stapio' THREAD: c00000010af1c000 CPU: 6
GPR00: 0000000000000001 c0000001effbfc50 c000000000a31660 c000000000fcfa48
GPR04: 000000010000c8da 0000000000000070 0000000000000002 0000000000000000
GPR08: ffffffffffffffff c000000000ac7bf8 0000000000000006 c00000000009cfb0
GPR12: d000000003017090 c00000000f600f00 0000000010008fd8 0000000010008ff8
GPR16: 0000000000000000 c000000000a91180 0000000000000000 0000000000000001
GPR20: c00000010edb9030 c00000010edb9430 c00000010edb9830 c00000010edb9c30
GPR24: 0000000000000001 001167a5b590dc41 c000000000fcfa18 000000010000c8da
GPR28: c000000000fcfa48 d00000000301597c c0000000009a6470 000000010000c8da
NIP [c00000000009d090] .mod_timer+0xe0/0x24c
LR [d00000000301597c] .__stp_time_timer_callback+0x108/0x13c [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
Call Trace:
[c0000001effbfc50] [c0000001effbfd00] 0xc0000001effbfd00 (unreliable)
[c0000001effbfd00] [d00000000301597c] .__stp_time_timer_callback+0x108/0x13c [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
[c0000001effbfdc0] [c00000000009c2f8] .run_timer_softirq+0x1d8/0x2a8
[c0000001effbfec0] [c0000000000952d0] .__do_softirq+0xe4/0x1b4
[c0000001effbff90] [c00000000002a7a8] .call_do_softirq+0x14/0x24
[c00000010af1f560] [c00000000000dde4] .do_softirq+0x88/0xf0
[c00000010af1f600] [c000000000095030] .irq_exit+0x50/0xac
[c00000010af1f680] [c000000000027660] .timer_interrupt+0x110/0x13c
[c00000010af1f710] [c000000000003718] decrementer_common+0x118/0x180
--- Exception: 901 at .smp_call_function_many+0x284/0x2d0
     LR = .smp_call_function_many+0x268/0x2d0
[c00000010af1fae0] [c0000000000c55c4] .smp_call_function+0x3c/0x54
[c00000010af1fb60] [c000000000094cdc] .on_each_cpu+0x24/0x84
[c00000010af1fc00] [d000000003016738] ._stp_ctl_write_cmd+0x3b0/0x9c8 [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
[c00000010af1fce0] [c0000000001585f4] .vfs_write+0xd0/0x1b8
[c00000010af1fd80] [c0000000001587e4] .SyS_write+0x58/0xa0
[c00000010af1fe30] [c0000000000085b4] syscall_exit+0x0/0x40
Instruction dump:
7ffb4878 f9210070 e93e8078 80090000 2f800000 419e0010 7fa4eb78 7f83e378
4bfffcb1 e81c0020 7c000074 7800d182<0b000000>  7f83e378 38810070 3b400000
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[c0000001effbf5b0] [c000000000011934] .show_stack+0x6c/0x16c (unreliable)
[c0000001effbf660] [c000000000552094] .panic+0x9c/0x204
[c0000001effbf700] [c000000000028974] .die+0x268/0x2ac
[c0000001effbf7a0] [c000000000028ca8] ._exception+0x88/0x174
[c0000001effbf960] [c000000000004f8c] program_check_common+0x10c/0x180
--- Exception: 700 at .mod_timer+0xe0/0x24c
     LR = .__stp_time_timer_callback+0x108/0x13c [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
[c0000001effbfc50] [c0000001effbfd00] 0xc0000001effbfd00 (unreliable)
[c0000001effbfd00] [d00000000301597c] .__stp_time_timer_callback+0x108/0x13c [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
[c0000001effbfdc0] [c00000000009c2f8] .run_timer_softirq+0x1d8/0x2a8
[c0000001effbfec0] [c0000000000952d0] .__do_softirq+0xe4/0x1b4
[c0000001effbff90] [c00000000002a7a8] .call_do_softirq+0x14/0x24
[c00000010af1f560] [c00000000000dde4] .do_softirq+0x88/0xf0
[c00000010af1f600] [c000000000095030] .irq_exit+0x50/0xac
[c00000010af1f680] [c000000000027660] .timer_interrupt+0x110/0x13c
[c00000010af1f710] [c000000000003718] decrementer_common+0x118/0x180
--- Exception: 901 at .smp_call_function_many+0x284/0x2d0
     LR = .smp_call_function_many+0x268/0x2d0
[c00000010af1fae0] [c0000000000c55c4] .smp_call_function+0x3c/0x54
[c00000010af1fb60] [c000000000094cdc] .on_each_cpu+0x24/0x84
[c00000010af1fc00] [d000000003016738] ._stp_ctl_write_cmd+0x3b0/0x9c8 [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
[c00000010af1fce0] [c0000000001585f4] .vfs_write+0xd0/0x1b8
[c00000010af1fd80] [c0000000001587e4] .SyS_write+0x58/0xa0
[c00000010af1fe30] [c0000000000085b4] syscall_exit+0x0/0x40
Rebooting in 180 seconds..-- 0:conmux-control -- time-stamp -- Oct/13/10  2:51:18 --

Thanks
Divya
