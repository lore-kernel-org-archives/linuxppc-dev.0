Return-Path: <a.p.zijlstra@chello.nl>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3234DDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 23:36:41 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1201090699.9052.39.camel@thor.sulgenrain.local>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=utf-8
Date: Wed, 23 Jan 2008 13:36:38 +0100
Message-Id: <1201091798.6341.49.camel@lappy>
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


On Wed, 2008-01-23 at 13:18 +0100, Michel Dänzer wrote:
> On Tue, 2008-01-22 at 15:56 +0100, Michel Dänzer wrote:
> > On Fri, 2008-01-18 at 13:34 +0100, Michel Dänzer wrote:
> > > This is on a PowerBook5,8.
> > > 
> > > In a nutshell, things seem more sluggish in general than with 2.6.23.
> > > But in particular, processes running at nice levels >0 can get most of
> > > the CPU cycles available, slowing down processes running at nice level
> > > 0.
> > 
> > The canonical test case I've come up with is to run an infinite loop
> > with
> > 
> > sudo -u nobody nice -n 19 sh -c 'while true; do true; done'
> > 
> > This makes my X session (X server running at nice level -1, clients at
> > 0) unusably sluggish (it can even take several seconds to process ctrl-c
> > to interrupt the infinite loop) with 2.6.24-rc but works as expected
> > with 2.6.23.
> > 
> > Anybody else seeing this?
> > 
> > 
> > > I've seen this since .24-rc5 (the first .24-rc I tried), and it's still
> > > there with -rc8. I'd be surprised if this kind of behaviour remained
> > > unfixed for that long if it affected x86, so  I presume it's powerpc
> > > specific.
> > 
> > Or maybe not... I've bisected this down to the scheduler changes
> > between
> > df3d80f5a5c74168be42788364d13cf6c83c7b9c/23fd50450a34f2558070ceabb0bfebc1c9604af5 and b5869ce7f68b233ceb81465a7644be0d9a5f3dbb .
> 
> Finished bisecting now. And the winner is...
> 
> 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8 is first bad commit
> commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8
> Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date:   Mon Oct 15 17:00:14 2007 +0200
> 
>     sched: another wakeup_granularity fix
>     
>     unit mis-match: wakeup_gran was used against a vruntime
>     
>     Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>     Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> :040000 040000 61242d589b0082a417657807ed6329321340f7f3 bff39e49275324e15f37d2163157733580b7df1a M      kernel
> 
> 
> Unfortunately, I don't understand how that can cause the misbehaviour
> described above, and 2.6.24-rc8
> (667984d9e481e43a930a478c588dced98cb61fea) with the patch below still
> shows the problem. Any ideas Peter or Ingo (or anyone, really :)?
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
>  

Most curious; are you sure its not a bisection problem?

Does ppc32 (or your instance thereof) have a high resolution
sched_clock()?
