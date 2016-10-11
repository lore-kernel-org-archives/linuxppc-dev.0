Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stbh065RHzDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 23:21:20 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id r16so652359pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 05:21:20 -0700 (PDT)
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
To: Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3f7ddc83-fcd3-79c4-81b6-ec3c4de53be6@gmail.com>
Date: Tue, 11 Oct 2016 23:21:09 +1100
MIME-Version: 1.0
In-Reply-To: <87a8eb5dwa.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/10/16 22:22, Michael Ellerman wrote:
> Tejun Heo <tj@kernel.org> writes:
> 
>> Hello, Michael.
>>
>> On Mon, Oct 10, 2016 at 09:22:55PM +1100, Michael Ellerman wrote:
>>> This patch seems to be causing one of my Power8 boxes not to boot.
>>>
>>> Specifically commit 3347fa092821 ("workqueue: make workqueue available
>>> early during boot") in linux-next.
>>>
>>> If I revert this on top of next-20161005 then the machine boots again.
>>>
>>> I've attached the oops below. It looks like the cfs_rq of p->se is NULL?
>>
>> Hah, weird that it's arch dependent, or maybe it's just different
>> config options.  Most likely, it's caused by workqueue_init() call
>> being moved too early.  Can you please try the following patch and see
>> whether the problem goes away?
> 
> No that doesn't help.
> 
> What does is this:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 94732d1ab00a..4e79549d242f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1614,7 +1614,8 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
>  	 * [ this allows ->select_task() to simply return task_cpu(p) and
>  	 *   not worry about this generic constraint ]
>  	 */
> -	if (unlikely(!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)) ||
> +	if (unlikely(cpu >= nr_cpu_ids ||
> +		     !cpumask_test_cpu(cpu, tsk_cpus_allowed(p)) ||
>  		     !cpu_online(cpu)))
>  		cpu = select_fallback_rq(task_cpu(p), p);
>  
> 
> The oops happens because we're in enqueue_task_fair() and p->se->cfs_rq
> is NULL.
> 
> The cfs_rq is NULL because we did set_task_rq(p, 2048), where 2048 is
> NR_CPUS. That causes us to index past the end of the tg->cfs_rq array in
> set_task_rq() and happen to get NULL.
> 
> We never should have done set_task_rq(p, 2048), because 2048 is >=
> nr_cpu_ids, which means it's not a valid CPU number, and set_task_rq()
> doesn't cope with that.
> 
> The reason we're calling set_task_rq() with CPU 2048 is because
> in select_task_rq() we had tsk_nr_cpus_allowed() = 0, because
> tsk_cpus_allowed(p) is an empty cpu mask.
> 
> That means we do in select_task_rq():
>   cpu = cpumask_any(tsk_cpus_allowed(p));                                                                                                                                    
> 
> And when tsk_cpus_allowed(p) is empty cpumask_any() returns nr_cpu_ids,
> causing cpu to be set to 2048 in my case.
> 
> select_task_rq() then does the check to see if it should use a fallback
> rq:
> 
> if (unlikely(!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)) ||                                                                                                                        
> 	     !cpu_online(cpu)))
> 	cpu = select_fallback_rq(task_cpu(p), p);
> 
> 
> But in both those checks we end up indexing off the end of the cpu mask,
> because cpu is >= nr_cpu_ids. At least on my system they both return
> true and so we return cpu == 2048.
> 
> The patch above is pretty clearly not the right fix, though maybe it's a
> good safety measure.
> 
> Presumably we shouldn't be ending up with tsk_cpus_allowed() being
> empty, but I haven't had time to track down why that's happening.
> 
> cheers
> 

+peterz

FYI: I see the samething on my cpu as well, its just that I get lucky
and cpu_online(cpu) returns false.

I think from a functional perspective we may want to get some additional
debug checks for places where the cpumask is empty early during boot.

Looks like there is a dependency between cpumasks and cpus coming online.
I wonder if we can hit similar issues during hotplug

FWIW, your patch looks correct to me, though one might argue that
cpumask_test_cpu() is a better place to fix it

Balbir Singh
