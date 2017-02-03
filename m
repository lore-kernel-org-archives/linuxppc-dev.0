Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF3sB1q3rzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 15:33:34 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v134TfZn088366
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Feb 2017 23:33:32 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ccsu3ycg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 23:33:31 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Fri, 3 Feb 2017 10:03:28 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 134251258024
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 10:05:13 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v134XPiK12517488
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 10:03:25 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v134XNfx026654
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Feb 2017 10:03:25 +0530
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20170202155506.GX6515@twins.programming.kicks-ass.net>
Date: Fri, 3 Feb 2017 10:03:14 +0530
Cc: Ross Zwisler <zwisler@gmail.com>, Mike Galbraith <efault@gmx.de>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
 <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
 <1485863317.4498.2.camel@gmx.de>
 <CAOxpaSW_GnndoxLBPtyTrqPJ9XOWvgXOQNDf8D+6OohWeObn5Q@mail.gmail.com>
 <20170202155506.GX6515@twins.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Message-Id: <3BAB5673-2BF8-46E0-8018-6A0F3DEEC9F7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 02-Feb-2017, at 9:25 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Tue, Jan 31, 2017 at 10:22:47AM -0700, Ross Zwisler wrote:
>> On Tue, Jan 31, 2017 at 4:48 AM, Mike Galbraith <efault@gmx.de> =
wrote:
>>> On Tue, 2017-01-31 at 16:30 +0530, Sachin Sant wrote:
>=20
>=20
> Could some of you test this? It seems to cure things in my (very)
> limited testing.
>=20

I ran few cycles of cpu hot(un)plug tests. In most cases it works except =
one
where I ran into rcu stall:

[  173.493453] INFO: rcu_sched detected stalls on CPUs/tasks:
[  173.493473] 	8-...: (2 GPs behind) idle=3D006/140000000000000/0 =
softirq=3D0/0 fqs=3D2996=20
[  173.493476] 	(detected by 0, t=3D6002 jiffies, g=3D885, c=3D884, =
q=3D6350)
[  173.493482] Task dump for CPU 8:
[  173.493484] cpuhp/8         R  running task        0  3416      2 =
0x00000884
[  173.493489] Call Trace:
[  173.493492] [c0000004f7b834a0] [c0000004f7b83560] 0xc0000004f7b83560 =
(unreliable)
[  173.493498] [c0000004f7b83670] [c000000000008d28] =
alignment_common+0x128/0x130
[  173.493503] --- interrupt: 600 at _raw_spin_lock+0x2c/0xc0
[  173.493503]     LR =3D try_to_wake_up+0x204/0x5c0
[  173.493507] [c0000004f7b83960] [c0000004f4d8084c] 0xc0000004f4d8084c =
(unreliable)
[  173.493511] [c0000004f7b83990] [c0000000000fef54] =
try_to_wake_up+0x204/0x5c0
[  173.493515] [c0000004f7b83a10] [c0000000000e2b88] =
create_worker+0x148/0x250
[  173.493519] [c0000004f7b83ab0] [c0000000000e6e1c] =
alloc_unbound_pwq+0x3bc/0x4c0
[  173.493522] [c0000004f7b83b10] [c0000000000e7084] =
wq_update_unbound_numa+0x164/0x270
[  173.493526] [c0000004f7b83bb0] [c0000000000e8990] =
workqueue_online_cpu+0x250/0x3b0
[  173.493529] [c0000004f7b83c70] [c0000000000c2758] =
cpuhp_invoke_callback+0x148/0x5b0
[  173.493533] [c0000004f7b83ce0] [c0000000000c2df8] =
cpuhp_up_callbacks+0x48/0x140
[  173.493536] [c0000004f7b83d30] [c0000000000c3e98] =
cpuhp_thread_fun+0x148/0x180
[  173.493540] [c0000004f7b83d60] [c0000000000f3930] =
smpboot_thread_fn+0x290/0x2a0
[  173.493544] [c0000004f7b83dc0] [c0000000000edb3c] kthread+0x14c/0x190
[  173.493547] [c0000004f7b83e30] [c00000000000b4e8] =
ret_from_kernel_thread+0x5c/0x74
[  243.913715] INFO: task kworker/0:2:380 blocked for more than 120 =
seconds.
[  243.913732]       Not tainted 4.10.0-rc6-next-20170202 #6
[  243.913735] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
[  243.913738] kworker/0:2     D    0   380      2 0x00000800
[  243.913746] Workqueue: events vmstat_shepherd
[  243.913748] Call Trace:
[  243.913752] [c0000000ff07f820] [c00000000011135c] =
enqueue_entity+0x81c/0x1200 (unreliable)
[  243.913757] [c0000000ff07f9f0] [c00000000001a660] =
__switch_to+0x300/0x400
[  243.913762] [c0000000ff07fa50] [c0000000008df4f4] =
__schedule+0x314/0xb10
[  243.913766] [c0000000ff07fb20] [c0000000008dfd30] schedule+0x40/0xb0
[  243.913769] [c0000000ff07fb50] [c0000000008e02b8] =
schedule_preempt_disabled+0x18/0x30
[  243.913773] [c0000000ff07fb70] [c0000000008e1654] =
__mutex_lock.isra.6+0x1a4/0x660
[  243.913777] [c0000000ff07fc00] [c0000000000c3828] =
get_online_cpus+0x48/0x90
[  243.913780] [c0000000ff07fc30] [c00000000025fd78] =
vmstat_shepherd+0x38/0x150
[  243.913784] [c0000000ff07fc80] [c0000000000e5794] =
process_one_work+0x1a4/0x4d0
[  243.913788] [c0000000ff07fd20] [c0000000000e5b58] =
worker_thread+0x98/0x5a0
[  243.913791] [c0000000ff07fdc0] [c0000000000edb3c] kthread+0x14c/0x190
[  243.913795] [c0000000ff07fe30] [c00000000000b4e8] =
ret_from_kernel_thread+0x5c/0x74
[  243.913824] INFO: task drmgr:3413 blocked for more than 120 seconds.
[  243.913826]       Not tainted 4.10.0-rc6-next-20170202 #6
[  243.913829] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.
[  243.913831] drmgr           D    0  3413   3114 0x00040080
[  243.913834] Call Trace:
[  243.913836] [c000000257ff3380] [c000000257ff3440] 0xc000000257ff3440 =
(unreliable)
[  243.913840] [c000000257ff3550] [c00000000001a660] =
__switch_to+0x300/0x400
[  243.913844] [c000000257ff35b0] [c0000000008df4f4] =
__schedule+0x314/0xb10
[  243.913847] [c000000257ff3680] [c0000000008dfd30] schedule+0x40/0xb0
[  243.913851] [c000000257ff36b0] [c0000000008e4594] =
schedule_timeout+0x274/0x470
[  243.913855] [c000000257ff37b0] [c0000000008e0efc] =
wait_for_common+0x1ac/0x2c0
[  243.913858] [c000000257ff3830] [c0000000000c50e4] =
bringup_cpu+0x84/0xe0
[  243.913862] [c000000257ff3860] [c0000000000c2758] =
cpuhp_invoke_callback+0x148/0x5b0
[  243.913865] [c000000257ff38d0] [c0000000000c2df8] =
cpuhp_up_callbacks+0x48/0x140
[  243.913868] [c000000257ff3920] [c0000000000c5438] _cpu_up+0xe8/0x1c0
[  243.913872] [c000000257ff3980] [c0000000000c5630] =
do_cpu_up+0x120/0x150
[  243.913876] [c000000257ff3a00] [c0000000005c005c] =
cpu_subsys_online+0x5c/0xe0
[  243.913879] [c000000257ff3a50] [c0000000005b7d84] =
device_online+0xb4/0x120
[  243.913883] [c000000257ff3a90] [c000000000093424] =
dlpar_online_cpu+0x144/0x1e0
[  243.913887] [c000000257ff3b50] [c000000000093c08] =
dlpar_cpu_add+0x108/0x2f0
[  243.913891] [c000000257ff3be0] [c0000000000948dc] =
dlpar_cpu_probe+0x3c/0x80
[  243.913894] [c000000257ff3c20] [c0000000000207a8] =
arch_cpu_probe+0x38/0x60
[  243.913898] [c000000257ff3c40] [c0000000005c0880] =
cpu_probe_store+0x40/0x70
[  243.913902] [c000000257ff3c70] [c0000000005b2e94] =
dev_attr_store+0x34/0x60
[  243.913906] [c000000257ff3c90] [c0000000003b0fc4] =
sysfs_kf_write+0x64/0xa0
[  243.913910] [c000000257ff3cb0] [c0000000003afd10] =
kernfs_fop_write+0x170/0x250
[  243.913914] [c000000257ff3d00] [c0000000002fb0f0] =
__vfs_write+0x40/0x1c0
[  243.913917] [c000000257ff3d90] [c0000000002fcba8] =
vfs_write+0xc8/0x240
[  243.913921] [c000000257ff3de0] [c0000000002fe790] =
SyS_write+0x60/0x110
[  243.913924] [c000000257ff3e30] [c00000000000b184] =
system_call+0x38/0xe0
[  243.913929] INFO: task ppc64_cpu:3423 blocked for more than 120 =
seconds.
[  243.913931]       Not tainted 4.10.0-rc6-next-20170202 #6
[  243.913933] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" =
disables this message.

Thanks
-Sachin=
