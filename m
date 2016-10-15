Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sx05K0HZ9zDt4W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2016 20:48:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
In-Reply-To: <20161014150757.GA11102@mtj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
Date: Sat, 15 Oct 2016 20:48:01 +1100
Message-ID: <87mvi6c59q.fsf@concordia.ellerman.id.au>
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

Tejun Heo <tj@kernel.org> writes:

> Hello, Michael.
>
> On Tue, Oct 11, 2016 at 10:22:13PM +1100, Michael Ellerman wrote:
>> The oops happens because we're in enqueue_task_fair() and p->se->cfs_rq
>> is NULL.
>> 
>> The cfs_rq is NULL because we did set_task_rq(p, 2048), where 2048 is
>> NR_CPUS. That causes us to index past the end of the tg->cfs_rq array in
>> set_task_rq() and happen to get NULL.
>> 
>> We never should have done set_task_rq(p, 2048), because 2048 is >=
>> nr_cpu_ids, which means it's not a valid CPU number, and set_task_rq()
>> doesn't cope with that.
>
> Hmm... it doesn't reproduce it here and can't see how the commit would
> affect this given that it doesn't really change when the kworker
> kthreads are being created.

Try turning on CONFIG_DEBUG_PER_CPU_MAPS=y ?

That will warn if you're indexing off the end of a cpu mask and just
getting lucky with the result.

>> Presumably we shouldn't be ending up with tsk_cpus_allowed() being
>> empty, but I haven't had time to track down why that's happening.
>
> Can you please add WARN_ON_ONCE(!tsk_nr_cpus_allowed(p)) to
> select_task_rq() and post what that says?

It says:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ../kernel/sched/core.c:1602 try_to_wake_up+0x3f4/0x5c0
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-compiler_gcc-6.2.0-next-20161014-dirty #116
task: c000000ff9200000 task.stack: c000001ffc084000
NIP: c0000000000f1ba4 LR: c0000000000f180c CTR: 0000000000000000
REGS: c000001ffc0878f0 TRAP: 0700   Not tainted  (4.8.0-compiler_gcc-6.2.0-next-20161014-dirty)
MSR: 9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE> CR: 28000422  XER: 00000000
CFAR: c0000000000f18bc SOFTE: 0 
GPR00: c0000000000f180c c000001ffc087b70 c000000000e83400 0000000000000000 
GPR04: 0000000000000002 0000000000000000 0000000000000000 0000000000000000 
GPR08: c000000000dc3400 0000000000000001 0000000000000002 0000000000000000 
GPR12: 0000000000000000 c00000000fb80000 c00000000000e0c8 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000000eb8960 
GPR24: 0000000000000000 c000000000d8ce00 0000000000000000 0000000000000000 
GPR28: c0000007f54050f4 0000000000000000 0000000000000000 c0000007f5404900 
NIP [c0000000000f1ba4] try_to_wake_up+0x3f4/0x5c0
LR [c0000000000f180c] try_to_wake_up+0x5c/0x5c0
Call Trace:
[c000001ffc087b70] [c0000000000f180c] try_to_wake_up+0x5c/0x5c0 (unreliable)
[c000001ffc087bf0] [c0000000000d53e4] create_worker+0x144/0x250
[c000001ffc087c90] [c000000000cf7930] workqueue_init+0x170/0x19c
[c000001ffc087d00] [c000000000ce0e74] kernel_init_freeable+0x158/0x360
[c000001ffc087dc0] [c00000000000e0e4] kernel_init+0x24/0x160
[c000001ffc087e30] [c00000000000bfa0] ret_from_kernel_thread+0x5c/0xbc
Instruction dump:
e8790890 4bff6ed9 2fa30000 419e00dc 60000000 4bfffe54 3d02fff4 8928d7f9 
2f890000 409e0018 39200001 9928d7f9 <0fe00000> 60000000 60420000 3b5f0368 
---[ end trace 0000000000000000 ]---


But I'm not sure that tells us anything new?

cheers
