Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stZMt34FkzDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 22:22:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
In-Reply-To: <20161010130253.GB29742@mtj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
Date: Tue, 11 Oct 2016 22:22:13 +1100
Message-ID: <87a8eb5dwa.fsf@concordia.ellerman.id.au>
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
> On Mon, Oct 10, 2016 at 09:22:55PM +1100, Michael Ellerman wrote:
>> This patch seems to be causing one of my Power8 boxes not to boot.
>> 
>> Specifically commit 3347fa092821 ("workqueue: make workqueue available
>> early during boot") in linux-next.
>> 
>> If I revert this on top of next-20161005 then the machine boots again.
>> 
>> I've attached the oops below. It looks like the cfs_rq of p->se is NULL?
>
> Hah, weird that it's arch dependent, or maybe it's just different
> config options.  Most likely, it's caused by workqueue_init() call
> being moved too early.  Can you please try the following patch and see
> whether the problem goes away?

No that doesn't help.

What does is this:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 94732d1ab00a..4e79549d242f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1614,7 +1614,8 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	 * [ this allows ->select_task() to simply return task_cpu(p) and
 	 *   not worry about this generic constraint ]
 	 */
-	if (unlikely(!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)) ||
+	if (unlikely(cpu >= nr_cpu_ids ||
+		     !cpumask_test_cpu(cpu, tsk_cpus_allowed(p)) ||
 		     !cpu_online(cpu)))
 		cpu = select_fallback_rq(task_cpu(p), p);
 

The oops happens because we're in enqueue_task_fair() and p->se->cfs_rq
is NULL.

The cfs_rq is NULL because we did set_task_rq(p, 2048), where 2048 is
NR_CPUS. That causes us to index past the end of the tg->cfs_rq array in
set_task_rq() and happen to get NULL.

We never should have done set_task_rq(p, 2048), because 2048 is >=
nr_cpu_ids, which means it's not a valid CPU number, and set_task_rq()
doesn't cope with that.

The reason we're calling set_task_rq() with CPU 2048 is because
in select_task_rq() we had tsk_nr_cpus_allowed() = 0, because
tsk_cpus_allowed(p) is an empty cpu mask.

That means we do in select_task_rq():
  cpu = cpumask_any(tsk_cpus_allowed(p));                                                                                                                                    

And when tsk_cpus_allowed(p) is empty cpumask_any() returns nr_cpu_ids,
causing cpu to be set to 2048 in my case.

select_task_rq() then does the check to see if it should use a fallback
rq:

if (unlikely(!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)) ||                                                                                                                        
	     !cpu_online(cpu)))
	cpu = select_fallback_rq(task_cpu(p), p);


But in both those checks we end up indexing off the end of the cpu mask,
because cpu is >= nr_cpu_ids. At least on my system they both return
true and so we return cpu == 2048.

The patch above is pretty clearly not the right fix, though maybe it's a
good safety measure.

Presumably we shouldn't be ending up with tsk_cpus_allowed() being
empty, but I haven't had time to track down why that's happening.

cheers
