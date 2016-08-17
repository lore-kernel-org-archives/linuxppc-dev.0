Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDhzT0KdPzDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 18:22:13 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Dave Hansen <dave.hansen@linux.intel.com>,
 Holger Brunck <holger.brunck@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
 <57B1EBAE.6030503@linux.intel.com>
 <3f1dff88-cd24-b36e-da9a-e84627929975@c-s.fr>
 <57B34F0F.8080100@linux.intel.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5f7ccecc-4cba-7a75-83f5-b32e2e59a805@c-s.fr>
Date: Wed, 17 Aug 2016 10:22:06 +0200
MIME-Version: 1.0
In-Reply-To: <57B34F0F.8080100@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 16/08/2016 à 19:36, Dave Hansen a écrit :
> On 08/16/2016 10:27 AM, christophe leroy wrote:
>> If I debug a very small app, it gets stuck quickly after the app has
>> stopped: indeed, the console seems ok but as soon as I try to execute
>> something simple, like a ps or top, it get stuck. The target still
>> responds to pings, but nothing else.
>
> This one is a pretty common symptom when the kernel crashes holding a
> per-process lock of some kind, probably most commonly mmap_sem.
>
> Do you have a serial console?  Can you do a sysrq-t on it to get stack
> dumps of the hung processes and ps?
>
> It's time to turn on all the debugging options we can find.  Can you
> build a kernel with all this stuff enabled (=y on all of these):
>
> CONFIG_SLUB_DEBUG
> CONFIG_DEBUG_VM
> CONFIG_DEBUG_PAGEALLOC
> CONFIG_PAGE_POISONING
> CONFIG_SLUB_DEBUG_ON
> CONFIG_KASAN
> CONFIG_*LOCKUP_DETECTOR
> CONFIG_DETECT_HUNG_TASK
> CONFIG_SCHED_DEBUG
> CONFIG_DEBUG_PREEMPT
> CONFIG_MAGIC_SYSRQ
>
> And all of the spinlock/lockdep stuff enabled too:
>
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_STACKTRACE=y
> CONFIG_DEBUG_LIST=y
>
> Let's hope that these turn something up.
>

Looks like all those options don't turn anything up.

See below what I get with Sysrq. It looks like the time is freezed:
* Log date remains the same for each line
* Timers dump is identical the two times
* The running task is stuck in udelay()

[  415.307239] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) 
show-all-locks(d) terminate-all-tasks(e) memory-full-oom-kill(f) 
kill-all-tasks(i) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) 
show-registers(p) show-all-timers(q) sync(s) show-task-states(t) 
unmount(u) show-blocked-tasks(w)

[  415.307239] sysrq: SysRq : Show Regs
[  415.307239] CPU: 0 PID: 281 Comm: sh Tainted: G        W 
4.4.14-s3k-dev-g08fc2be-svn #110
[  415.307239] task: c620d380 ti: c7fee000 task.ti: c6214000
[  415.307239] NIP: c0007e20 LR: c020f8a8 CTR: c020f874
[  415.307239] REGS: c62159c0 TRAP: 0501   Tainted: G        W 
(4.4.14-s3k-dev-g08fc2be-svn)
[  415.307239] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 24022884  XER: 00000000
[  415.307239]
GPR00: c020f8a0 c6215a70 c620d380 00000008 c601ba18 c020f8a0 00000000 
0000036a
GPR08: c620d7b0 00000000 cc38f55d 40324184 84022882
[  415.307239] NIP [c0007e20] udelay+0x30/0x3c
[  415.307239] LR [c020f8a8] nand_wait+0x34/0x12c
[  415.307239] Call Trace:
[  415.307239] [c6215a70] [c020f8a0] nand_wait+0x2c/0x12c (unreliable)
[  415.307239] [c6215a90] [c020e120] nand_write_page+0xb8/0x1a0
[  415.307239] [c6215ac0] [c020f248] nand_do_write_ops+0x1ec/0x44c
[  415.307239] [c6215b30] [c020f5ec] nand_write+0x68/0x94
[  415.307239] [c6215b70] [c02210e0] ubi_io_write+0x108/0x61c
[  415.307239] [c6215bb0] [c021e10c] ubi_eba_write_leb+0x88/0x7b4
[  415.307239] [c6215c20] [c0163bfc] ubifs_leb_write+0xac/0x144
[  415.307239] [c6215c50] [c0164740] ubifs_wbuf_sync_nolock+0xfc/0x33c
[  415.307239] [c6215c70] [c0158b7c] ubifs_jnl_write_inode+0xb0/0x208
[  415.307239] [c6215cb0] [c015f764] ubifs_write_inode+0xc4/0x14c
[  415.307239] [c6215cd0] [c015bd68] ubifs_writepage+0x1ac/0x22c
[  415.307239] [c6215d00] [c009a428] __writepage+0x24/0x7c
[  415.307239] [c6215d10] [c009c6e4] write_cache_pages+0x1d0/0x380
[  415.307239] [c6215db0] [c008fe6c] __filemap_fdatawrite_range+0x64/0x88
[  415.307239] [c6215de0] [c0090644] filemap_write_and_wait_range+0x38/0x94
[  415.307239] [c6215e00] [c015ac3c] ubifs_fsync+0x50/0xd4
[  415.307239] [c6215e20] [c0093bb8] generic_file_write_iter+0x200/0x2b4
[  415.307239] [c6215e50] [c015c294] ubifs_write_iter+0x104/0x1a8
[  415.307239] [c6215ea0] [c00cba6c] __vfs_write+0xc8/0x14c
[  415.307239] [c6215ef0] [c00cbc80] vfs_write+0xa4/0x178
[  415.307239] [c6215f10] [c00cbe64] SyS_write+0x4c/0xc4
[  415.307239] [c6215f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] Instruction dump:
[  415.307239] 3d20c05c 812975ac 7c6349d6 7d4c42e6 7d2c42e6 7d2a4850 
7f834840 409d0018
[  415.307239] 7c210b78 7d2c42e6 7d2a4850 7f834840 <419dfff0> 7c421378 
4e800020 7c0802a6


[  415.307239] sysrq: SysRq : Show Blocked State
[  415.307239]   task                PC stack   pid father
[  415.307239] Sched Debug Version: v0.11, 4.4.14-s3k-dev-g08fc2be-svn #110
[  415.307239] ktime                                   : 415174.352520
[  415.307239] sched_clk                               : 415307.239936
[  415.307239] cpu_clk                                 : 415307.239936
[  415.307239] jiffies                                 : 11517
[  415.307239]
[  415.307239] sysctl_sched
[  415.307239]   .sysctl_sched_latency                    : 6.000000
[  415.307239]   .sysctl_sched_min_granularity            : 0.750000
[  415.307239]   .sysctl_sched_wakeup_granularity         : 1.000000
[  415.307239]   .sysctl_sched_child_runs_first           : 0
[  415.307239]   .sysctl_sched_features                   : 44859
[  415.307239]   .sysctl_sched_tunable_scaling            : 1 (logaritmic)
[  415.307239]
[  415.307239] cpu#0
[  415.307239]   .nr_running                    : 2
[  415.307239]   .load                          : 2048
[  415.307239]   .nr_switches                   : 26656
[  415.307239]   .nr_load_updates               : 0
[  415.307239]   .nr_uninterruptible            : 0
[  415.307239]   .next_balance                  : 0.000000
[  415.307239]   .curr->pid                     : 281
[  415.307239]   .clock                         : 415307.239936
[  415.307239]   .clock_task                    : 415307.239936
[  415.307239]   .cpu_load[0]                   : 0
[  415.307239]   .cpu_load[1]                   : 0
[  415.307239]   .cpu_load[2]                   : 0
[  415.307239]   .cpu_load[3]                   : 0
[  415.307239]   .cpu_load[4]                   : 0
[  415.307239]
[  415.307239] cfs_rq[0]:
[  415.307239]   .exec_clock                    : 0.000000
[  415.307239]   .MIN_vruntime                  : 42490.860493
[  415.307239]   .min_vruntime                  : 42493.860493
[  415.307239]   .max_vruntime                  : 42490.860493
[  415.307239]   .spread                        : 0.000000
[  415.307239]   .spread0                       : 0.000000
[  415.307239]   .nr_spread_over                : 0
[  415.307239]   .nr_running                    : 2
[  415.307239]   .load                          : 2048
[  415.307239]
[  415.307239] rt_rq[0]:
[  415.307239]   .rt_nr_running                 : 0
[  415.307239]   .rt_throttled                  : 0
[  415.307239]   .rt_time                       : 0.000000
[  415.307239]   .rt_runtime                    : 950.000000
[  415.307239]
[  415.307239] dl_rq[0]:
[  415.307239]   .dl_nr_running                 : 0
[  415.307239]
[  415.307239] runnable tasks:
[  415.307239]             task   PID         tree-key  switches  prio 
   wait-time             sum-exec        sum-sleep
[  415.307239] 
----------------------------------------------------------------------------------------------------------
[  415.307239]             init     1     41218.246221       324   120 
       0.000000      7091.870720         0.000000
[  415.307239]         kthreadd     2     10041.075333        53   120 
       0.000000        39.044608         0.000000
[  415.307239]      ksoftirqd/0     3     42471.449421       525   120 
       0.000000       174.042368         0.000000
[  415.307239]      kworker/0:0     4       393.682966        10   120 
       0.000000         3.465472         0.000000
[  415.307239]     kworker/0:0H     5       542.229904         3   100 
       0.000000         0.373504         0.000000
[  415.307239]     kworker/u2:0     6     42490.860493       482   120 
       0.000000       682.979200         0.000000
[  415.307239]      rcu_preempt     7     42471.239885      7355   120 
       0.000000      2497.164544         0.000000
[  415.307239]        rcu_sched     8        16.696155         2   120 
       0.000000         0.232192         0.000000
[  415.307239]           rcu_bh     9        18.788058         2   120 
       0.000000         0.225792         0.000000
[  415.307239]        kdevtmpfs    10      9906.339623        53   120 
       0.000000        49.822080         0.000000
[  415.307239]             perf    11       209.966618         2   100 
       0.000000         0.418688         0.000000
[  415.307239]       khungtaskd    12     42271.067789        43   120 
       0.000000         9.401344         0.000000
[  415.307239]        writeback    13       393.600057         2   100 
       0.000000         0.301184         0.000000
[  415.307239]      kworker/0:1    14     42462.051405      3062   120 
       0.000000      1814.468864         0.000000
[  415.307239]           crypto    15       395.547701         2   100 
       0.000000         0.310016         0.000000
[  415.307239]           rpciod    16       547.595271         3   100 
       0.000000         0.346752         0.000000
[  415.307239]          kswapd0    17      1141.966520         3   120 
       0.000000         0.758656         0.000000
[  415.307239]    fsnotify_mark    18      1289.797239         2   120 
       0.000000         1.068032         0.000000
[  415.307239]           nfsiod    19      1294.974059         2   100 
       0.000000         0.303360         0.000000
[  415.307239]            bond0    37      4873.191411         2   100 
       0.000000         0.320512         0.000000
[  415.307239]    ipv6_addrconf    49      5541.654525         2   100 
       0.000000         0.303232         0.000000
[  415.307239]          deferwq    50      5664.433381         2   100 
       0.000000         0.299264         0.000000
[  415.307239]     kworker/u2:1    51     29504.315231         5   120 
       0.000000         0.803840         0.000000
[  415.307239]         spi32766    52     24174.314766       243   120 
       0.000000        44.892928         0.000000
[  415.307239]        ubi_bgt0d    63     10399.804677        11   120 
       0.000000        25.593344         0.000000
[  415.307239]     ubifs_bgt0_0    65     10052.319044         2   120 
       0.000000         7.036288         0.000000
[  415.307239]           udhcpc   171     19428.265114         1   120 
       0.000000         5.979520         0.000000
[  415.307239]         watchdog   188         0.654209       842     0 
       0.000000      3819.744512         0.000000
[  415.307239]             ntpd   208     42384.913677       419   120 
       0.000000       645.997952         0.000000
[  415.307239]            inetd   221     21775.101204         5   120 
       0.000000        39.310848         0.000000
[  415.307239]            crond   234     40244.762133        14   120 
       0.000000        49.742208         0.000000
[  415.307239]            snmpd   250     42386.978381      1732   120 
       0.000000     12158.752128         0.000000
[  415.307239]            login   263     28214.829541        46   120 
       0.000000       420.666240         0.000000
[  415.307239] R             sh   281     42490.860493       174   120 
       0.000000       538.372864         0.000000
[  415.307239]


[  415.307239] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) 
show-all-locks(d) terminate-all-tasks(e) memory-full-oom-kill(f) 
kill-all-tasks(i) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) 
show-registers(p) show-all-timers(q) sync(s) show-task-states(t) 
unmount(u) show-blocked-tasks(w)
[  415.307239] sysrq: SysRq : Show clockevent devices & pending hrtimers 
(no others)
[  415.307239] Timer List Version: v0.8
[  415.307239] HRTIMER_MAX_CLOCK_BASES: 4
[  415.307239] now at 415174352520 nsecs
[  415.307239]
[  415.307239] cpu: 0
[  415.307239]  clock 0:
[  415.307239]   .base:       c05a6a00
[  415.307239]   .index:      0
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get
[  415.307239]   .offset:     0 nsecs
[  415.307239] active timers:
[  415.307239]  #0: tick_cpu_sched, tick_sched_timer, S:01
[  415.307239]  # expires at 415180000000-415180000000 nsecs [in 5647480 
to 5647480 nsecs]
[  415.307239]  #1: <c6485ea8>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 415316748939-415316748939 nsecs [in 
142396419 to 142396419 nsecs]
[  415.307239]  #2: <c6481a28>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 415325581283-415326561308 nsecs [in 
151228763 to 152208788 nsecs]
[  415.307239]  #3: <c61fa178>, it_real_fn, S:01
[  415.307239]  # expires at 415635620681-415635620681 nsecs [in 
461268161 to 461268161 nsecs]
[  415.307239]  #4: <c622dea8>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 426702410278-426702460278 nsecs [in 
11528057758 to 11528107758 nsecs]
[  415.307239]  #5: <c6487a28>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 129624716464923-129624816464923 nsecs [in 
129209542112403 to 129209642112403 nsecs]
[  415.307239]  clock 1:
[  415.307239]   .base:       c05a6a20
[  415.307239]   .index:      1
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get_real
[  415.307239]   .offset:     1471420915047270622 nsecs
[  415.307239] active timers:
[  415.307239]  clock 2:
[  415.307239]   .base:       c05a6a40
[  415.307239]   .index:      2
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get_boottime
[  415.307239]   .offset:     0 nsecs
[  415.307239] active timers:
[  415.307239]  clock 3:
[  415.307239]   .base:       c05a6a60
[  415.307239]   .index:      3
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get_clocktai
[  415.307239]   .offset:     1471420915047270622 nsecs
[  415.307239] active timers:
[  415.307239]   .expires_next   : 415180000000 nsecs
[  415.307239]   .hres_active    : 1
[  415.307239]   .nr_events      : 43162
[  415.307239]   .nr_retries     : 20
[  415.307239]   .nr_hangs       : 0
[  415.307239]   .max_hang_time  : 0
[  415.307239]   .nohz_mode      : 0
[  415.307239]   .last_tick      : 0 nsecs
[  415.307239]   .tick_stopped   : 0
[  415.307239]   .idle_jiffies   : 0
[  415.307239]   .idle_calls     : 0
[  415.307239]   .idle_sleeps    : 0
[  415.307239]   .idle_entrytime : 0 nsecs
[  415.307239]   .idle_waketime  : 0 nsecs
[  415.307239]   .idle_exittime  : 0 nsecs
[  415.307239]   .idle_sleeptime : 0 nsecs
[  415.307239]   .iowait_sleeptime: 0 nsecs
[  415.307239]   .last_jiffies   : 0
[  415.307239]   .next_timer     : 0
[  415.307239]   .idle_expires   : 0 nsecs
[  415.307239] jiffies: 11517
[  415.307239]
[  415.307239] Tick Device: mode:     1
[  415.307239] Per CPU device: 0
[  415.307239] Clock Event Device: decrementer
[  415.307239]  max_delta_ns:   260301049532
[  415.307239]  min_delta_ns:   1000
[  415.307239]  mult:           35433480
[  415.307239]  shift:          32
[  415.307239]  mode:           3
[  415.307239]  next_event:     415180000000 nsecs
[  415.307239]  set_next_event: decrementer_set_next_event
[  415.307239]  shutdown: decrementer_shutdown
[  415.307239]  resume:   decrementer_shutdown
[  415.307239]  event_handler:  hrtimer_interrupt
[  415.307239]  retries:        0
[  415.307239]


[  415.307239] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) 
show-all-locks(d) terminate-all-tasks(e) memory-full-oom-kill(f) 
kill-all-tasks(i) show-memory-usage(m) nice-all-RT-tasks(n) poweroff(o) 
show-registers(p) show-all-timers(q) sync(s) show-task-states(t) 
unmount(u) show-blocked-tasks(w)


[  415.307239] sysrq: SysRq : Show State
[  415.307239]   task                PC stack   pid father
[  415.307239] init            S 0fd6f410  5244     1      0 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c6091dc0] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c6091e80] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c6091eb0] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6091ec0] [c0018fb0] do_wait+0x1b0/0x1fc
[  415.307239] [c6091ef0] [c0019cf4] SyS_wait4+0x74/0xd8
[  415.307239] [c6091f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] kthreadd        S 00000000  6492     2      0 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6093e00] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c6093ec0] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6093ef0] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6093f00] [c00354d0] kthreadd+0x138/0x148
[  415.307239] [c6093f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] ksoftirqd/0     S 00000000  5644     3      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6095d70] [c0048b8c] trace_hardirqs_on_caller+0x9c/0x1a0 
(unreliable)
[  415.307239] [c6095e30] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6095e60] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6095e70] [c00387e8] smpboot_thread_fn+0x284/0x2ec
[  415.307239] [c6095eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6095f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] kworker/0:0     S 00000000  6748     4      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6097d60] [0000000c] 0xc (unreliable)
[  415.307239] [c6097e20] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6097e50] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6097e60] [c002ef60] worker_thread+0x1b0/0x474
[  415.307239] [c6097eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6097f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] kworker/0:0H    S 00000000  7404     5      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6099d60] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c6099e20] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6099e50] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6099e60] [c002ef60] worker_thread+0x1b0/0x474
[  415.307239] [c6099eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6099f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] kworker/u2:0    R running   5324     6      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c609bd60] [c96e0000] 0xc96e0000 (unreliable)
[  415.307239] [c609be20] [c042b100] __schedule+0x350/0x660
[  415.307239] [c609be50] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c609be60] [c002ef60] worker_thread+0x1b0/0x474
[  415.307239] [c609beb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c609bf40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] rcu_preempt     S 00000000  6540     7      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c609dd30] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c609ddf0] [c042b100] __schedule+0x350/0x660
[  415.307239] [c609de20] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c609de30] [c005df00] rcu_gp_kthread+0xa4/0x8d0
[  415.307239] [c609deb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c609df40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] rcu_sched       S 00000000  7356     8      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c609fd30] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c609fdf0] [c042b100] __schedule+0x350/0x660
[  415.307239] [c609fe20] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c609fe30] [c005df00] rcu_gp_kthread+0xa4/0x8d0
[  415.307239] [c609feb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c609ff40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] rcu_bh          S 00000000  7356     9      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c60b1d30] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c60b1df0] [c042b100] __schedule+0x350/0x660
[  415.307239] [c60b1e20] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c60b1e30] [c005df00] rcu_gp_kthread+0xa4/0x8d0
[  415.307239] [c60b1eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c60b1f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] kdevtmpfs       S 00000000  6348    10      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c60b3d10] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c60b3dd0] [c042b100] __schedule+0x350/0x660
[  415.307239] [c60b3e00] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c60b3e10] [c01f4304] devtmpfsd+0x2e0/0x2e4
[  415.307239] [c60b3eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c60b3f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] perf            S 00000000  7388    11      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c60b5d50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c60b5e10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c60b5e40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c60b5e50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c60b5eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c60b5f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] khungtaskd      S 00000000  7324    12      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c60b9dd0] [c042b100] __schedule+0x350/0x660
[  415.307239] [c60b9e00] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c60b9e10] [c042f2a0] schedule_timeout+0xfc/0x16c
[  415.307239] [c60b9e60] [c00788ac] watchdog+0x70/0x498
[  415.307239] [c60b9eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c60b9f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] writeback       S 00000000  7388    13      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c60bbd50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c60bbe10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c60bbe40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c60bbe50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c60bbeb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c60bbf40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] kworker/0:1     S 00000000  6332    14      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c60bdd60] [c004a590] __lock_acquire+0x314/0x1a30 
(unreliable)
[  415.307239] [c60bde20] [c042b100] __schedule+0x350/0x660
[  415.307239] [c60bde50] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c60bde60] [c002ef60] worker_thread+0x1b0/0x474
[  415.307239] [c60bdeb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c60bdf40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] crypto          S 00000000  7388    15      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c60bfd50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c60bfe10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c60bfe40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c60bfe50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c60bfeb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c60bff40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] rpciod          S 00000000  7388    16      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6115d50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c6115e10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6115e40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6115e50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c6115eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6115f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] kswapd0         S 00000000  7068    17      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6117d10] [22000082] 0x22000082 (unreliable)
[  415.307239] [c6117dd0] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6117e00] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6117e10] [c00a3eb4] kswapd+0x628/0x638
[  415.307239] [c6117eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6117f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] fsnotify_mark   S 00000000  6620    18      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6119d60] [00009032] 0x9032 (unreliable)
[  415.307239] [c6119e20] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6119e50] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6119e60] [c00ffbb8] fsnotify_mark_destroy+0xfc/0x12c
[  415.307239] [c6119eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6119f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] nfsiod          S 00000000  7388    19      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c611bd50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c611be10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c611be40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c611be50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c611beb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c611bf40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] bond0           S 00000000  7388    37      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6225d50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c6225e10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6225e40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6225e50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c6225eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6225f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] ipv6_addrconf   S 00000000  7388    49      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6211d50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c6211e10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6211e40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6211e50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c6211eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6211f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] deferwq         S 00000000  7388    50      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c621fd50] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c621fe10] [c042b100] __schedule+0x350/0x660
[  415.307239] [c621fe40] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c621fe50] [c002f458] rescuer_thread+0x234/0x2c8
[  415.307239] [c621feb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c621ff40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] kworker/u2:1    S 00000000  7404    51      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c6213d60] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c6213e20] [c042b100] __schedule+0x350/0x660
[  415.307239] [c6213e50] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6213e60] [c002ef60] worker_thread+0x1b0/0x474
[  415.307239] [c6213eb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c6213f40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] spi32766        S 00000000  7404    52      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c621bd80] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c621be40] [c042b100] __schedule+0x350/0x660
[  415.307239] [c621be70] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c621be80] [c0035618] kthread_worker_fn+0xc8/0x124
[  415.307239] [c621beb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c621bf40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] ubi_bgt0d       S 00000000  6156    63      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c622fd70] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c622fe30] [c042b100] __schedule+0x350/0x660
[  415.307239] [c622fe60] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c622fe70] [c0223eac] ubi_thread+0xc8/0x188
[  415.307239] [c622feb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c622ff40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] ubifs_bgt0_0    S 00000000  7180    65      2 0x00000800
[  415.307239] Call Trace:
[  415.307239] [c622bd80] [c042ff6c] 
_raw_spin_unlock_irqrestore+0x48/0x98 (unreliable)
[  415.307239] [c622be40] [c042b100] __schedule+0x350/0x660
[  415.307239] [c622be70] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c622be80] [c016fa68] ubifs_bg_thread+0x120/0x19c
[  415.307239] [c622beb0] [c0034de8] kthread+0xc8/0xdc
[  415.307239] [c622bf40] [c000bd38] ret_from_kernel_thread+0x5c/0x64
[  415.307239] udhcpc          S 0fd9efa8  6268   171      1 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c64879e0] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c6487a10] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6487a20] [c042f5f4] 
schedule_hrtimeout_range_clock+0xc4/0x14c
[  415.307239] [c6487a90] [c00de47c] poll_schedule_timeout+0x44/0x7c
[  415.307239] [c6487aa0] [c00deb7c] do_select+0x5ec/0x710
[  415.307239] [c6487dc0] [c00deecc] core_sys_select+0x22c/0x4cc
[  415.307239] [c6487f10] [c00df214] SyS_select+0xa8/0x124
[  415.307239] [c6487f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] watchdog        S 0fedb94c  5532   188      1 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c6485d80] [c05a4140] pidmap_lock+0x0/0x20 (unreliable)
[  415.307239] [c6485e40] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c6485e70] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6485e80] [c042f424] do_nanosleep+0x74/0xe0
[  415.307239] [c6485ea0] [c0063fbc] hrtimer_nanosleep+0xb0/0x144
[  415.307239] [c6485f10] [c0064104] SyS_nanosleep+0xb4/0xe0
[  415.307239] [c6485f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] ntpd            S 0fe32fa8  5452   208      1 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c6223920] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c62239e0] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c6223a10] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6223a20] [c042f674] 
schedule_hrtimeout_range_clock+0x144/0x14c
[  415.307239] [c6223a90] [c00de47c] poll_schedule_timeout+0x44/0x7c
[  415.307239] [c6223aa0] [c00deb7c] do_select+0x5ec/0x710
[  415.307239] [c6223dc0] [c00deecc] core_sys_select+0x22c/0x4cc
[  415.307239] [c6223f10] [c00df214] SyS_select+0xa8/0x124
[  415.307239] [c6223f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] inetd           S 0fd9efa8  6172   221      1 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c6483920] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c64839e0] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c6483a10] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6483a20] [c042f674] 
schedule_hrtimeout_range_clock+0x144/0x14c
[  415.307239] [c6483a90] [c00de47c] poll_schedule_timeout+0x44/0x7c
[  415.307239] [c6483aa0] [c00deb7c] do_select+0x5ec/0x710
[  415.307239] [c6483dc0] [c00deecc] core_sys_select+0x22c/0x4cc
[  415.307239] [c6483f10] [c00df214] SyS_select+0xa8/0x124
[  415.307239] [c6483f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] crond           S 0fd6f94c  6156   234      1 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c622dd80] [c004a590] __lock_acquire+0x314/0x1a30 
(unreliable)
[  415.307239] [c622de40] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c622de70] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c622de80] [c042f424] do_nanosleep+0x74/0xe0
[  415.307239] [c622dea0] [c0063fbc] hrtimer_nanosleep+0xb0/0x144
[  415.307239] [c622df10] [c0064104] SyS_nanosleep+0xb4/0xe0
[  415.307239] [c622df40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] snmpd           S 0fa3afa8  5516   250      1 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c6481920] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c64819e0] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c6481a10] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c6481a20] [c042f5f4] 
schedule_hrtimeout_range_clock+0xc4/0x14c
[  415.307239] [c6481a90] [c00de47c] poll_schedule_timeout+0x44/0x7c
[  415.307239] [c6481aa0] [c00deb7c] do_select+0x5ec/0x710
[  415.307239] [c6481dc0] [c00deecc] core_sys_select+0x22c/0x4cc
[  415.307239] [c6481f10] [c00df214] SyS_select+0xa8/0x124
[  415.307239] [c6481f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] login           S 0fd6f410  5404   263      1 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c611ddc0] [c05dd3b0] list_entries+0x0/0x120000 (unreliable)
[  415.307239] [c611de80] [c042b07c] __schedule+0x2cc/0x660
[  415.307239] [c611deb0] [c042b4a0] schedule+0x2c/0x54
[  415.307239] [c611dec0] [c0018fb0] do_wait+0x1b0/0x1fc
[  415.307239] [c611def0] [c0019cf4] SyS_wait4+0x74/0xd8
[  415.307239] [c611df40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] sh              R running   5580   281    263 0x00000000
[  415.307239] Call Trace:
[  415.307239] [c7fefe60] [c003da18] show_state_filter+0xc8/0x1c8 
(unreliable)
[  415.307239] [c7fefe90] [c01d901c] sysrq_handle_showstate+0x14/0x24
[  415.307239] [c7fefea0] [c01d94cc] __handle_sysrq+0x180/0x268
[  415.307239] [c7fefed0] [c01e2980] cpm_uart_int_rx+0x1f8/0x33c
[  415.307239] [c7feff20] [c01e2e70] cpm_uart_int+0x104/0x134
[  415.307239] [c7feff40] [c0054598] handle_irq_event_percpu+0x5c/0x158
[  415.307239] [c7feff70] [c00546d8] handle_irq_event+0x44/0x78
[  415.307239] [c7feff90] [c00579b8] handle_fasteoi_irq+0xd4/0x210
[  415.307239] [c7feffb0] [c0053e48] generic_handle_irq+0x30/0x4c
[  415.307239] [c7feffc0] [c00132dc] cpm_cascade+0x28/0x48
[  415.307239] [c7feffd0] [c0053e48] generic_handle_irq+0x30/0x4c
[  415.307239] [c7feffe0] [c0003ea0] __do_irq+0x3c/0x88
[  415.307239] [c7fefff0] [c000b394] call_do_irq+0x24/0x3c
[  415.307239] [c6215980] [c0003f74] do_IRQ+0x88/0xe0
[  415.307239] [c62159b0] [c000c314] ret_from_except+0x0/0x14
[  415.307239] [c6215a70] [c020f8a0] nand_wait+0x2c/0x12c
[  415.307239] [c6215a90] [c020e120] nand_write_page+0xb8/0x1a0
[  415.307239] [c6215ac0] [c020f248] nand_do_write_ops+0x1ec/0x44c
[  415.307239] [c6215b30] [c020f5ec] nand_write+0x68/0x94
[  415.307239] [c6215b70] [c02210e0] ubi_io_write+0x108/0x61c
[  415.307239] [c6215bb0] [c021e10c] ubi_eba_write_leb+0x88/0x7b4
[  415.307239] [c6215c20] [c0163bfc] ubifs_leb_write+0xac/0x144
[  415.307239] [c6215c50] [c0164740] ubifs_wbuf_sync_nolock+0xfc/0x33c
[  415.307239] [c6215c70] [c0158b7c] ubifs_jnl_write_inode+0xb0/0x208
[  415.307239] [c6215cb0] [c015f764] ubifs_write_inode+0xc4/0x14c
[  415.307239] [c6215cd0] [c015bd68] ubifs_writepage+0x1ac/0x22c
[  415.307239] [c6215d00] [c009a428] __writepage+0x24/0x7c
[  415.307239] [c6215d10] [c009c6e4] write_cache_pages+0x1d0/0x380
[  415.307239] [c6215db0] [c008fe6c] __filemap_fdatawrite_range+0x64/0x88
[  415.307239] [c6215de0] [c0090644] filemap_write_and_wait_range+0x38/0x94
[  415.307239] [c6215e00] [c015ac3c] ubifs_fsync+0x50/0xd4
[  415.307239] [c6215e20] [c0093bb8] generic_file_write_iter+0x200/0x2b4
[  415.307239] [c6215e50] [c015c294] ubifs_write_iter+0x104/0x1a8
[  415.307239] [c6215ea0] [c00cba6c] __vfs_write+0xc8/0x14c
[  415.307239] [c6215ef0] [c00cbc80] vfs_write+0xa4/0x178
[  415.307239] [c6215f10] [c00cbe64] SyS_write+0x4c/0xc4
[  415.307239] [c6215f40] [c000bbd4] ret_from_syscall+0x0/0x38
[  415.307239] Sched Debug Version: v0.11, 4.4.14-s3k-dev-g08fc2be-svn #110
[  415.307239] ktime                                   : 415174.352520
[  415.307239] sched_clk                               : 415307.239936
[  415.307239] cpu_clk                                 : 415307.239936
[  415.307239] jiffies                                 : 11517
[  415.307239]
[  415.307239] sysctl_sched
[  415.307239]   .sysctl_sched_latency                    : 6.000000
[  415.307239]   .sysctl_sched_min_granularity            : 0.750000
[  415.307239]   .sysctl_sched_wakeup_granularity         : 1.000000
[  415.307239]   .sysctl_sched_child_runs_first           : 0
[  415.307239]   .sysctl_sched_features                   : 44859
[  415.307239]   .sysctl_sched_tunable_scaling            : 1 (logaritmic)
[  415.307239]
[  415.307239] cpu#0
[  415.307239]   .nr_running                    : 2
[  415.307239]   .load                          : 2048
[  415.307239]   .nr_switches                   : 26656
[  415.307239]   .nr_load_updates               : 0
[  415.307239]   .nr_uninterruptible            : 0
[  415.307239]   .next_balance                  : 0.000000
[  415.307239]   .curr->pid                     : 281
[  415.307239]   .clock                         : 415307.239936
[  415.307239]   .clock_task                    : 415307.239936
[  415.307239]   .cpu_load[0]                   : 0
[  415.307239]   .cpu_load[1]                   : 0
[  415.307239]   .cpu_load[2]                   : 0
[  415.307239]   .cpu_load[3]                   : 0
[  415.307239]   .cpu_load[4]                   : 0
[  415.307239]
[  415.307239] cfs_rq[0]:
[  415.307239]   .exec_clock                    : 0.000000
[  415.307239]   .MIN_vruntime                  : 42490.860493
[  415.307239]   .min_vruntime                  : 42493.860493
[  415.307239]   .max_vruntime                  : 42490.860493
[  415.307239]   .spread                        : 0.000000
[  415.307239]   .spread0                       : 0.000000
[  415.307239]   .nr_spread_over                : 0
[  415.307239]   .nr_running                    : 2
[  415.307239]   .load                          : 2048
[  415.307239]
[  415.307239] rt_rq[0]:
[  415.307239]   .rt_nr_running                 : 0
[  415.307239]   .rt_throttled                  : 0
[  415.307239]   .rt_time                       : 0.000000
[  415.307239]   .rt_runtime                    : 950.000000
[  415.307239]
[  415.307239] dl_rq[0]:
[  415.307239]   .dl_nr_running                 : 0
[  415.307239]
[  415.307239] runnable tasks:
[  415.307239]             task   PID         tree-key  switches  prio 
   wait-time             sum-exec        sum-sleep
[  415.307239] 
----------------------------------------------------------------------------------------------------------
[  415.307239]             init     1     41218.246221       324   120 
       0.000000      7091.870720         0.000000
[  415.307239]         kthreadd     2     10041.075333        53   120 
       0.000000        39.044608         0.000000
[  415.307239]      ksoftirqd/0     3     42471.449421       525   120 
       0.000000       174.042368         0.000000
[  415.307239]      kworker/0:0     4       393.682966        10   120 
       0.000000         3.465472         0.000000
[  415.307239]     kworker/0:0H     5       542.229904         3   100 
       0.000000         0.373504         0.000000
[  415.307239]     kworker/u2:0     6     42490.860493       482   120 
       0.000000       682.979200         0.000000
[  415.307239]      rcu_preempt     7     42471.239885      7355   120 
       0.000000      2497.164544         0.000000
[  415.307239]        rcu_sched     8        16.696155         2   120 
       0.000000         0.232192         0.000000
[  415.307239]           rcu_bh     9        18.788058         2   120 
       0.000000         0.225792         0.000000
[  415.307239]        kdevtmpfs    10      9906.339623        53   120 
       0.000000        49.822080         0.000000
[  415.307239]             perf    11       209.966618         2   100 
       0.000000         0.418688         0.000000
[  415.307239]       khungtaskd    12     42271.067789        43   120 
       0.000000         9.401344         0.000000
[  415.307239]        writeback    13       393.600057         2   100 
       0.000000         0.301184         0.000000
[  415.307239]      kworker/0:1    14     42462.051405      3062   120 
       0.000000      1814.468864         0.000000
[  415.307239]           crypto    15       395.547701         2   100 
       0.000000         0.310016         0.000000
[  415.307239]           rpciod    16       547.595271         3   100 
       0.000000         0.346752         0.000000
[  415.307239]          kswapd0    17      1141.966520         3   120 
       0.000000         0.758656         0.000000
[  415.307239]    fsnotify_mark    18      1289.797239         2   120 
       0.000000         1.068032         0.000000
[  415.307239]           nfsiod    19      1294.974059         2   100 
       0.000000         0.303360         0.000000
[  415.307239]            bond0    37      4873.191411         2   100 
       0.000000         0.320512         0.000000
[  415.307239]    ipv6_addrconf    49      5541.654525         2   100 
       0.000000         0.303232         0.000000
[  415.307239]          deferwq    50      5664.433381         2   100 
       0.000000         0.299264         0.000000
[  415.307239]     kworker/u2:1    51     29504.315231         5   120 
       0.000000         0.803840         0.000000
[  415.307239]         spi32766    52     24174.314766       243   120 
       0.000000        44.892928         0.000000
[  415.307239]        ubi_bgt0d    63     10399.804677        11   120 
       0.000000        25.593344         0.000000
[  415.307239]     ubifs_bgt0_0    65     10052.319044         2   120 
       0.000000         7.036288         0.000000
[  415.307239]           udhcpc   171     19428.265114         1   120 
       0.000000         5.979520         0.000000
[  415.307239]         watchdog   188         0.654209       842     0 
       0.000000      3819.744512         0.000000
[  415.307239]             ntpd   208     42384.913677       419   120 
       0.000000       645.997952         0.000000
[  415.307239]            inetd   221     21775.101204         5   120 
       0.000000        39.310848         0.000000
[  415.307239]            crond   234     40244.762133        14   120 
       0.000000        49.742208         0.000000
[  415.307239]            snmpd   250     42386.978381      1732   120 
       0.000000     12158.752128         0.000000
[  415.307239]            login   263     28214.829541        46   120 
       0.000000       420.666240         0.000000
[  415.307239] R             sh   281     42490.860493       174   120 
       0.000000       538.372864         0.000000
[  415.307239]
[  415.307239]
[  415.307239] Showing all locks held in the system:
[  415.307239] 7 locks held by sh/281:
[  415.307239]  #0:  (sb_writers#5){.+.+.+}, at: [<c00ce934>] 
__sb_start_write+0xac/0xc4
[  415.307239]  #1:  (&ui->ui_mutex){+.+...}, at: [<c015f704>] 
ubifs_write_inode+0x64/0x14c
[  415.307239]  #2:  (&c->commit_sem){++++..}, at: [<c0157bac>] 
make_reservation+0x5c/0x408
[  415.307239]  #3:  (&wbuf->io_mutex/1){+.+...}, at: [<c0157bd4>] 
make_reservation+0x84/0x408
[  415.307239]  #4:  (&le->mutex){++++..}, at: [<c021d8d0>] 
leb_write_lock+0x24/0x38
[  415.307239]  #5:  (rcu_read_lock){......}, at: [<c01d934c>] 
__handle_sysrq+0x0/0x268
[  415.307239]  #6:  (tasklist_lock){.+.?..}, at: [<c004a10c>] 
debug_show_all_locks+0x3c/0x1ac
[  415.307239]
[  415.307239] =============================================
[  415.307239]
[  415.307239] Showing busy workqueues and worker pools:
[  415.307239] workqueue events_unbound: flags=0x2
[  415.307239]   pwq 2: cpus=0 flags=0x4 nice=0 active=1/512
[  415.307239]     pending: flush_to_ldisc


[  415.307239] sysrq: SysRq : Show clockevent devices & pending hrtimers 
(no others)
[  415.307239] Timer List Version: v0.8
[  415.307239] HRTIMER_MAX_CLOCK_BASES: 4
[  415.307239] now at 415174352520 nsecs
[  415.307239]
[  415.307239] cpu: 0
[  415.307239]  clock 0:
[  415.307239]   .base:       c05a6a00
[  415.307239]   .index:      0
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get
[  415.307239]   .offset:     0 nsecs
[  415.307239] active timers:
[  415.307239]  #0: tick_cpu_sched, tick_sched_timer, S:01
[  415.307239]  # expires at 415180000000-415180000000 nsecs [in 5647480 
to 5647480 nsecs]
[  415.307239]  #1: <c6485ea8>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 415316748939-415316748939 nsecs [in 
142396419 to 142396419 nsecs]
[  415.307239]  #2: <c6481a28>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 415325581283-415326561308 nsecs [in 
151228763 to 152208788 nsecs]
[  415.307239]  #3: <c61fa178>, it_real_fn, S:01
[  415.307239]  # expires at 415635620681-415635620681 nsecs [in 
461268161 to 461268161 nsecs]
[  415.307239]  #4: <c622dea8>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 426702410278-426702460278 nsecs [in 
11528057758 to 11528107758 nsecs]
[  415.307239]  #5: <c6487a28>, hrtimer_wakeup, S:01
[  415.307239]  # expires at 129624716464923-129624816464923 nsecs [in 
129209542112403 to 129209642112403 nsecs]
[  415.307239]  clock 1:
[  415.307239]   .base:       c05a6a20
[  415.307239]   .index:      1
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get_real
[  415.307239]   .offset:     1471420915047270622 nsecs
[  415.307239] active timers:
[  415.307239]  clock 2:
[  415.307239]   .base:       c05a6a40
[  415.307239]   .index:      2
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get_boottime
[  415.307239]   .offset:     0 nsecs
[  415.307239] active timers:
[  415.307239]  clock 3:
[  415.307239]   .base:       c05a6a60
[  415.307239]   .index:      3
[  415.307239]   .resolution: 1 nsecs
[  415.307239]   .get_time:   ktime_get_clocktai
[  415.307239]   .offset:     1471420915047270622 nsecs
[  415.307239] active timers:
[  415.307239]   .expires_next   : 415180000000 nsecs
[  415.307239]   .hres_active    : 1
[  415.307239]   .nr_events      : 43162
[  415.307239]   .nr_retries     : 20
[  415.307239]   .nr_hangs       : 0
[  415.307239]   .max_hang_time  : 0
[  415.307239]   .nohz_mode      : 0
[  415.307239]   .last_tick      : 0 nsecs
[  415.307239]   .tick_stopped   : 0
[  415.307239]   .idle_jiffies   : 0
[  415.307239]   .idle_calls     : 0
[  415.307239]   .idle_sleeps    : 0
[  415.307239]   .idle_entrytime : 0 nsecs
[  415.307239]   .idle_waketime  : 0 nsecs
[  415.307239]   .idle_exittime  : 0 nsecs
[  415.307239]   .idle_sleeptime : 0 nsecs
[  415.307239]   .iowait_sleeptime: 0 nsecs
[  415.307239]   .last_jiffies   : 0
[  415.307239]   .next_timer     : 0
[  415.307239]   .idle_expires   : 0 nsecs
[  415.307239] jiffies: 11517
[  415.307239]
[  415.307239] Tick Device: mode:     1
[  415.307239] Per CPU device: 0
[  415.307239] Clock Event Device: decrementer
[  415.307239]  max_delta_ns:   260301049532
[  415.307239]  min_delta_ns:   1000
[  415.307239]  mult:           35433480
[  415.307239]  shift:          32
[  415.307239]  mode:           3
[  415.307239]  next_event:     415180000000 nsecs
[  415.307239]  set_next_event: decrementer_set_next_event
[  415.307239]  shutdown: decrementer_shutdown
[  415.307239]  resume:   decrementer_shutdown
[  415.307239]  event_handler:  hrtimer_interrupt
[  415.307239]  retries:        0
[  415.307239]
