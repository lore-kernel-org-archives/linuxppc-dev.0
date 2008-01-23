Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 1E5D3DDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 00:14:21 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so2048675fgg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 05:14:19 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1201091798.6341.49.camel@lappy>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201091798.6341.49.camel@lappy>
Content-Type: text/plain; charset=utf-8
Date: Wed, 23 Jan 2008 14:14:16 +0100
Message-Id: <1201094056.9052.52.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-23 at 13:36 +0100, Peter Zijlstra wrote:
> On Wed, 2008-01-23 at 13:18 +0100, Michel Dänzer wrote:
> > 
> > 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8 is first bad commit
> > commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8
> > Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Date:   Mon Oct 15 17:00:14 2007 +0200
> > 
> >     sched: another wakeup_granularity fix
> >     
> >     unit mis-match: wakeup_gran was used against a vruntime
> >     
> >     Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> >     Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > 
> > :040000 040000 61242d589b0082a417657807ed6329321340f7f3 bff39e49275324e15f37d2163157733580b7df1a M      kernel
> > 
> > 
> > Unfortunately, I don't understand how that can cause the misbehaviour
> > described above, and 2.6.24-rc8
> > (667984d9e481e43a930a478c588dced98cb61fea) with the patch below still
> > shows the problem. Any ideas Peter or Ingo (or anyone, really :)?
> > 
> > 
> > diff --git a/kernel/sched_fair.c b/kernel/sched_fair.c
> > index da7c061..a7cc22a 100644
> > --- a/kernel/sched_fair.c
> > +++ b/kernel/sched_fair.c
> > @@ -843,7 +843,6 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p)
> >  	struct task_struct *curr = rq->curr;
> >  	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
> >  	struct sched_entity *se = &curr->se, *pse = &p->se;
> > -	unsigned long gran;
> >  
> >  	if (unlikely(rt_prio(p->prio))) {
> >  		update_rq_clock(rq);
> > @@ -866,11 +865,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p)
> >  		pse = parent_entity(pse);
> >  	}
> >  
> > -	gran = sysctl_sched_wakeup_granularity;
> > -	if (unlikely(se->load.weight != NICE_0_LOAD))
> > -		gran = calc_delta_fair(gran, &se->load);
> >  
> > -	if (pse->vruntime + gran < se->vruntime)
> > +	if (pse->vruntime + sysctl_sched_wakeup_granularity < se->vruntime)
> >  		resched_task(curr);
> >  }
> >  
> 
> Most curious; are you sure its not a bisection problem?

Quite sure.

> Does ppc32 (or your instance thereof) have a high resolution
> sched_clock()?

I'm not sure (FWIW, we did get support for NO_HZ and HIGH_RES_TIMERS in
2.6.24-rc as well, but playing with these config options and even
reverting the code didn't seem to have any effect), can someone from the
linuxppc-dev list answer this?


> Another question, do you have:
>   CONFIG_FAIR_GROUP_SCHED=y
> 
> if so, does flipping that off have any effect?

I tried both, no difference that I could tell.


Is there any debugging information I could provide from running the test
on kernels built from at and before the change in question?


Thanks,


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
