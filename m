Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r42cB6RXlzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 01:05:14 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 May 2016 20:35:10 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 41527E0061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 20:38:14 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4AF58JA43253768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 20:35:09 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4AF579l001100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 20:35:08 +0530
From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 Paul Mackerras <paulus@ozlabs.org>
Subject: softlockup with 4.6.0-rc3-00130-g4d2a14c 
Date: Tue, 10 May 2016 20:35:01 +0530
Message-ID: <874ma6j6n6.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I am finding the below softlockups with kvm guest. This is using the
same version of kernel for host and guest.

[  323.547841] NMI watchdog: BUG: soft lockup - CPU#7 stuck for 22s! [systemd-timesyn:3116]
[  323.548023] Modules linked in:
[  323.548029] CPU: 7 PID: 3116 Comm: systemd-timesyn Not tainted 4.6.0-rc3-00130-g4d2a14c #2
[  323.548031] task: c000000038b16d00 ti: c00000003baac000 task.ti: c00000003baac000
[  323.548032] NIP: c00000000005b404 LR: c000000000934c68 CTR: c000000000099650
[  323.548033] REGS: c00000003baaf9d0 TRAP: 0901   Not tainted  (4.6.0-rc3-00130-g4d2a14c)
[  323.548034] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48002844  XER: 00000000
[  323.548040] CFAR: c000000000934c64 SOFTE: 1 
               GPR00: c000000000934c68 c00000003baafc50 c000000000db3f00 c000000000e7e978 
               GPR04: 0000000000000001 00000000000081d0 000bd4444b0f5a4e 0000000000000000 
               GPR08: c000000000e207b8 0000000000000002 0000000080000001 0000000000000000 
               GPR12: c00000000001cfb0 c00000000fe01c00 
[  323.548055] NIP [c00000000005b404] __spin_yield+0x14/0xa0
[  323.548059] LR [c000000000934c68] _raw_spin_lock_irqsave+0x118/0x120
[  323.548060] Call Trace:
[  323.548062] [c00000003baafc50] [c000000000934c68] _raw_spin_lock_irqsave+0x118/0x120 (unreliable)
[  323.548065] [c00000003baafc90] [c000000000139a6c] do_adjtimex+0x9c/0x1c0
[  323.548068] [c00000003baafd00] [c00000000013238c] posix_clock_realtime_adj+0x1c/0x30
[  323.548070] [c00000003baafd20] [c000000000133920] SyS_clock_adjtime+0xa0/0x150
[  323.548073] [c00000003baafe30] [c000000000009260] system_call+0x38/0x108
[  323.548074] Instruction dump:
[  323.548075] eba1ffe8 eb81ffe0 eb61ffd8 4e800020 60000000 60000000 60000000 3c4c00d6 
[  323.548078] 38428b10 81430000 2faa0000 4d9e0020 <79490420> 2b8907ff 79290020 7d101026


--------------------

[   21.926941] INFO: rcu_sched self-detected stall on CPU
[   21.931553]  7-...: (2098 ticks this GP) idle=9b3/140000000000001/0 softirq=204/267 fqs=2097 
[   21.931601]   (t=2100 jiffies g=-249 c=-250 q=23178)
[   21.931751] Task dump for CPU 7:
[   21.931755] systemd         R  running task     9872     1      0 0x00040004
[   21.931763] Call Trace:
[   21.931773] [c00000003e503630] [c0000000000e783c] sched_show_task+0xec/0x180 (unreliable)
[   21.931779] [c00000003e5036a0] [c000000000123504] rcu_dump_cpu_stacks+0xe4/0x150
[   21.931783] [c00000003e5036f0] [c000000000128214] rcu_check_callbacks+0x6b4/0x9c0
[   21.931804] [c00000003e503810] [c00000000012ec7c] update_process_times+0x4c/0xa0
[   21.931809] [c00000003e503840] [c000000000143828] tick_sched_handle.isra.5+0x28/0xb0
[   21.931812] [c00000003e503870] [c00000000014390c] tick_sched_timer+0x5c/0xd0
[   21.931816] [c00000003e5038b0] [c00000000012f528] __hrtimer_run_queues+0xf8/0x380
[   21.931819] [c00000003e503930] [c0000000001303e0] hrtimer_interrupt+0xe0/0x2b0
[   21.931823] [c00000003e5039f0] [c00000000001d57c] __timer_interrupt+0x8c/0x270
[   21.931826] [c00000003e503a40] [c00000000001dc5c] timer_interrupt+0x9c/0xe0
[   21.931830] [c00000003e503a70] [c000000000002750] decrementer_common+0x150/0x180
[   21.931834] --- interrupt: 901 at ktime_get_ts64+0xf0/0x150
                   LR = ktime_get_ts64+0x74/0x150
[   21.931836] [c00000003e503d60] [0000000000000000]           (null) (unreliable)
[   21.931841] [c00000003e503da0] [c00000000029fa38] poll_select_set_timeout+0x78/0xd0
[   21.931844] [c00000003e503de0] [c0000000002a1020] SyS_poll+0x80/0x150
[   21.931847] [c00000003e503e30] [c000000000009260] system_call+0x38/0x108
[   24.006941] NMI watchdog: BUG: soft lockup - CPU#7 stuck for 21s! [systemd:1]
[   24.007117] Modules linked in:
[   24.007122] CPU: 7 PID: 1 Comm: systemd Not tainted 4.6.0-rc3-00130-g4d2a14c #1
[   24.007123] task: c00000003e4c0000 ti: c00000003e500000 task.ti: c00000003e500000
[   24.007125] NIP: c000000000137400 LR: c000000000137384 CTR: c00000000001cfb0
[   24.007126] REGS: c00000003e503ae0 TRAP: 0901   Not tainted  (4.6.0-rc3-00130-g4d2a14c)
[   24.007126] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28424844  XER: 20000000
[   24.007132] CFAR: c000000000137414 SOFTE: 1 
               GPR00: c00000000029fa38 c00000003e503d60 c000000000db3a00 000000000025ff39 
               GPR04: ffffffffa8ce0e65 ac491cb5c5ec0000 000000005731f19b 0000000000000000 
               GPR08: 000000003b9ac9ff 2af484699eac9820 0000000093054a12 ffffffffffffffff 
               GPR12: c00000000001cfb0 c00000000fe01c00 
[   24.007141] NIP [c000000000137400] ktime_get_ts64+0xf0/0x150
[   24.007143] LR [c000000000137384] ktime_get_ts64+0x74/0x150
[   24.007143] Call Trace:
[   24.007145] [c00000003e503da0] [c00000000029fa38] poll_select_set_timeout+0x78/0xd0
[   24.007146] [c00000003e503de0] [c0000000002a1020] SyS_poll+0x80/0x150
[   24.007148] [c00000003e503e30] [c000000000009260] system_call+0x38/0x108
[   24.007149] Instruction dump:
[   24.007151] 7ce94e34 7ce43214 7d295214 39400000 7fa94040 409d0034 48000018 60000000 
[   24.007154] 60000000 60000000 60000000 60420000 <3d29c465> 394a0001 39293600 794a0020 
[   28.745210] Adding 917440k swap on /dev/vda3.  Priority:-1 extents:1 across:917440k 
[   28.759694] EXT4-fs (vda2): re-mounted. Opts: errors=remount-ro

-aneesh
