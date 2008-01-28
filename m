Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C49C3DDD0A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 19:56:49 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1201450409.1931.23.camel@thor.sulgenrain.local>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy> <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jan 2008 09:50:36 +0100
Message-Id: <1201510236.6149.24.camel@lappy>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, vatsa@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-01-27 at 17:13 +0100, Michel Dänzer wrote:

> In summary, there are two separate problems with similar symptoms, which
> had me confused at times:
> 
>       * With CONFIG_FAIR_USER_SCHED disabled, there are severe
>         interactivity hickups with a niced CPU hog and top running. This
>         started with commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8. 

The revert at the bottom causes the wakeup granularity to shrink for +
nice and to grow for - nice. That is, it becomes easier to preempt a +
nice task, and harder to preempt a - nice task.

I think we originally had that; didn't comment it, forgot the reason
changed it because the units didn't match. Another reason might have
been the more difficult preemption of - nice tasks. That might - niced
tasks to cause horrible latencies - Ingo, any recollection?

Are you perhaps running with a very low HZ (HZ=100)? (If wakeup
preemption fails, tick preemption will take over).

Also, could you try lowering:
  /proc/sys/kernel/sched_wakeup_granularity_ns

>       * With CONFIG_FAIR_USER_SCHED enabled, X becomes basically
>         unusable with a niced CPU hog, with or without top running. I
>         don't know when this started, possibly when this option was
>         first introduced.

Srivatsa found an issue that might explain the very bad behaviour under
group scheduling. But I gather you're not at all interested in this
feature?

> FWIW, the patch below (which reverts commit
> 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8) restores 2.6.24 interactivity
> to the same level as 2.6.23 here with CONFIG_FAIR_USER_SCHED disabled
> (my previous report to the contrary was with CONFIG_FAIR_USER_SCHED
> enabled because I didn't yet realize the difference it makes), but I
> don't know if that's the real fix.
> 
> 
> diff --git a/kernel/sched_fair.c b/kernel/sched_fair.c
> index da7c061..a7cc22a 100644
> --- a/kernel/sched_fair.c
> +++ b/kernel/sched_fair.c
> @@ -843,7 +843,6 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p)
>  	struct task_struct *curr = rq->curr;
>  	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
>  	struct sched_entity *se = &curr->se, *pse = &p->se;
> -	unsigned long gran;
>  
>  	if (unlikely(rt_prio(p->prio))) {
>  		update_rq_clock(rq);
> @@ -866,11 +865,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p)
>  		pse = parent_entity(pse);
>  	}
>  
> -	gran = sysctl_sched_wakeup_granularity;
> -	if (unlikely(se->load.weight != NICE_0_LOAD))
> -		gran = calc_delta_fair(gran, &se->load);
>  
> -	if (pse->vruntime + gran < se->vruntime)
> +	if (pse->vruntime + sysctl_sched_wakeup_granularity < se->vruntime)
>  		resched_task(curr);
>  }
