Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssx5w118gzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 21:23:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
 akpm@linux-foundation.org, kernel-team@fb.com,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
In-Reply-To: <20160917172314.GB10771@mtj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
Date: Mon, 10 Oct 2016 21:22:55 +1100
Message-ID: <87twck5wqo.fsf@concordia.ellerman.id.au>
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

Hi Tejun,

Tejun Heo <tj@kernel.org> writes:
> From f85002f627f7fdc7b3cda526863f5c9a8d36b997 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Fri, 16 Sep 2016 15:49:32 -0400
> Subject: [PATCH] workqueue: make workqueue available early during boot
>
> Workqueue is currently initialized in an early init call; however,
> there are cases where early boot code has to be split and reordered to
> come after workqueue initialization or the same code path which makes
> use of workqueues is used both before workqueue initailization and
> after.  The latter cases have to gate workqueue usages with
> keventd_up() tests, which is nasty and easy to get wrong.
>
> Workqueue usages have become widespread and it'd be a lot more
> convenient if it can be used very early from boot.  This patch splits
> workqueue initialization into two steps.  workqueue_init_early() which
> sets up the basic data structures so that workqueues can be created
> and work items queued, and workqueue_init() which actually brings up
> workqueues online and starts executing queued work items.  The former
> step can be done very early during boot once memory allocation,
> cpumasks and idr are initialized.  The latter right after kthreads
> become available.
>
> This allows work item queueing and canceling from very early boot
> which is what most of these use cases want.
>
> * As systemd_wq being initialized doesn't indicate that workqueue is
>   fully online anymore, update keventd_up() to test wq_online instead.
>   The follow-up patches will get rid of all its usages and the
>   function itself.
>
> * Flushing doesn't make sense before workqueue is fully initialized.
>   The flush functions trigger WARN and return immediately before fully
>   online.
>
> * Work items are never in-flight before fully online.  Canceling can
>   always succeed by skipping the flush step.
>
> * Some code paths can no longer assume to be called with irq enabled
>   as irq is disabled during early boot.  Use irqsave/restore
>   operations instead.
>
> v2: Watchdog init, which requires timer to be running, moved from
>     workqueue_init_early() to workqueue_init().
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: http://lkml.kernel.org/r/CA+55aFx0vPuMuxn00rBSM192n-Du5uxy+4AvKa0SBSOVJeuCGg@mail.gmail.com


This patch seems to be causing one of my Power8 boxes not to boot.

Specifically commit 3347fa092821 ("workqueue: make workqueue available
early during boot") in linux-next.

If I revert this on top of next-20161005 then the machine boots again.

I've attached the oops below. It looks like the cfs_rq of p->se is NULL?

cheers


bootconsole [udbg0] disabled
bootconsole [udbg0] disabled
mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
pid_max: default: 163840 minimum: 1280
Dentry cache hash table entries: 16777216 (order: 11, 134217728 bytes)
Inode-cache hash table entries: 8388608 (order: 10, 67108864 bytes)
Mount-cache hash table entries: 262144 (order: 5, 2097152 bytes)
Mountpoint-cache hash table entries: 262144 (order: 5, 2097152 bytes)
Unable to handle kernel paging request for data at address 0x00000038
Faulting instruction address: 0xc0000000000fc0cc
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-compiler_gcc-6.2.0-next-20161005 #94
task: c0000007f5400000 task.stack: c000001ffc084000
NIP: c0000000000fc0cc LR: c0000000000ed928 CTR: c0000000000fbfd0
REGS: c000001ffc087780 TRAP: 0300   Not tainted  (4.8.0-compiler_gcc-6.2.0-next-20161005)
MSR: 9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 48000424  XER: 00000000
CFAR: c0000000000089dc DAR: 0000000000000038 DSISR: 40000000 SOFTE: 0 
GPR00: c0000000000ed928 c000001ffc087a00 c000000000e63200 c000000010d6d600 
GPR04: c0000007f5409200 0000000000000021 000000000748e08c 000000000000001f 
GPR08: 0000000000000000 0000000000000021 000000000748f1f8 0000000000000000 
GPR12: 0000000028000422 c00000000fb80000 c00000000000e0c8 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000021 0000000000000001 
GPR20: ffffffffafb50401 0000000000000000 c000000010d6d600 000000000000ba7e 
GPR24: 000000000000ba7e c000000000d8bc58 afb504000afb5041 0000000000000001 
GPR28: 0000000000000000 0000000000000004 c0000007f5409280 0000000000000000 
NIP [c0000000000fc0cc] enqueue_task_fair+0xfc/0x18b0
LR [c0000000000ed928] activate_task+0x78/0xe0
Call Trace:
[c000001ffc087a00] [c0000007f5409200] 0xc0000007f5409200 (unreliable)
[c000001ffc087b10] [c0000000000ed928] activate_task+0x78/0xe0
[c000001ffc087b50] [c0000000000ede58] ttwu_do_activate+0x68/0xc0
[c000001ffc087b90] [c0000000000ef1b8] try_to_wake_up+0x208/0x4f0
[c000001ffc087c10] [c0000000000d3484] create_worker+0x144/0x250
[c000001ffc087cb0] [c000000000cd72d0] workqueue_init+0x124/0x150
[c000001ffc087d00] [c000000000cc0e74] kernel_init_freeable+0x158/0x360
[c000001ffc087dc0] [c00000000000e0e4] kernel_init+0x24/0x160
[c000001ffc087e30] [c00000000000bfa0] ret_from_kernel_thread+0x5c/0xbc
Instruction dump:
62940401 3b800000 3aa00000 7f17c378 3a600001 3b600001 60000000 60000000 
60420000 72490021 ebfe0150 2f890001 <ebbf0038> 419e0de0 7fbee840 419e0e58 
---[ end trace 0000000000000000 ]---


c0000000000fbfd0 <enqueue_task_fair>:
r4 = p
...
c0000000000fc040:	80 00 c4 3b 	addi    r30,r4,128	r30 = r4 + 128	(&p->se)
...
c0000000000fc0c4:	50 01 fe eb 	ld      r31,336(r30)	r31 = *(r30 + 336) = se->cfs_rq
c0000000000fc0c8:	01 00 89 2f 	cmpwi   cr7,r9,1
c0000000000fc0cc:	38 00 bf eb 	ld      r29,56(r31)	r29 = cfs_rq->curr
