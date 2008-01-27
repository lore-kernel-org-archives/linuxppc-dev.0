Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id ABF09DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 03:13:48 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1209738fgg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 08:13:33 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: vatsa@linux.vnet.ibm.com
In-Reply-To: <20080126050757.GB14177@linux.vnet.ibm.com>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy> <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Sun, 27 Jan 2008 17:13:29 +0100
Message-Id: <1201450409.1931.23.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-26 at 10:39 +0530, Srivatsa Vaddagiri wrote:
> On Sat, Jan 26, 2008 at 03:13:54PM +1100, Benjamin Herrenschmidt wrote:
> 
> > > Also were the dd process and the niced processes running under 
> > > different user ids? If so, that is expected behavior, that we divide 
> > > CPU equally among users first and then among the processes within each user.

Note that in my test case, the niced infinite loop constantly burns
significantly more than 50% of the cycles; X and its clients never need
more than 20% (high estimate) each to move windows smoothly. So even
under the premise above, it should be possible to have smooth
interaction with X while there is a CPU hog in another group, shouldn't
it?


> > Not that it seems that Michel reported far worse behaviour than what I
> > saw, including pretty hickup'ish X behaviour even without the fair group
> > scheduler compared to 2.6.23. It might be because he's running X niced
> > to -1 (I leave X at 0 and let the scheduler deal with it in general)
> > though.
> 
> Hmm ..with X niced to -1, it should get more cpu power leading to a
> better desktop experience.

FWIW, -1 or 0 for X doesn't seem to make any difference for this
problem.

(I've had X at -1 because a long time ago, when it was at 0 some 3D
games could starve it to the point that their input would be delayed)


> Michel,
> 	You had reported that commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8 
> was the cause for this bad behavior. 

Well, it may not be the cause, but that's where the hickups with
CONFIG_FAIR_USER_SCHED disabled first manifest themselves, yes.

> Do you see behavior change (from good->bad) immediately after applying that patch 
> during your bisect process?

Yes, confirmed by trying that commit and its parent again.


> > > 1. Run niced tasks as root. This would bring X and niced tasks in the
> > > same "scheduler group" domain, which would give X much more CPU power
> > > when compared to niced tasks.

Running the niced CPU hog as root or my user instead of as nobody didn't
seem to make a difference, maybe because the X session requires
interaction between processes having different uids, and disturbing
either is sufficient.

> > > 2. Keep the niced tasks running under a non-root uid, but increase root users 
> > >    cpu share.
> > >         # echo 8192 > /sys/kernel/uids/0/cpu_share
> > > 
> > >    This should bump up root user's priority for running on CPU and also 
> > >    give a better desktop experience.

I didn't try 8192, but bumping the shares of root and my user up to 4096
didn't seem to help much if at all. Decreasing the share of the user
running the niced CPU hog to 1 resulted in more or less the same
behaviour as  with CONFIG_FAIR_USER_SCHED disabled.

> > > The group scheduler's SMP-load balance in 2.6.24 is not the best it
> > > could be. sched-devel has a better load balancer, which I am presuming
> > > will go into 2.6.25 soon.

FWIW, the scheduler changes merged after 2.6.24 don't seem to help at
all for my test:

With CONFIG_FAIR_USER_SCHED enabled, X still becomes unusable.

With CONFIG_FAIR_USER_SCHED disabled, X remains mostly usable, but there
are still hickups that weren't there with 2.6.23. (BTW, the hickups seem
related to top running in the terminal window I'm trying to move;
without top running, there are no hickups when moving the window. With
2.6.23, there are no hickups even with top running)

Note that my test case is an exaggerated example constructed from worse
(than with 2.6.23) interactive behaviour I've been seeing with my
day-to-day X session. This isn't just a theoretical problem.


> > > In this case, I suspect that's not the issue.  If X and the niced processes are 
> > > running under different uids, this (niced processes getting more cpu power) is 
> > > on expected lines. Will wait for Ben to confirm this. 
> > 
> > I would suggest turning the fair group scheduler to default n in stable
> > for now.
> 
> I would prefer to have CONFIG_FAIR_GROUP_SCHED +
> CONFIG_FAIR_CGROUP_SCHED on by default. Can you pls let me know how you
> think is the desktop experience with that combination?

Seems to be the same as with CONFIG_FAIR_GROUP_SCHED disabled
completely.


In summary, there are two separate problems with similar symptoms, which
had me confused at times:

      * With CONFIG_FAIR_USER_SCHED disabled, there are severe
        interactivity hickups with a niced CPU hog and top running. This
        started with commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8. 
      * With CONFIG_FAIR_USER_SCHED enabled, X becomes basically
        unusable with a niced CPU hog, with or without top running. I
        don't know when this started, possibly when this option was
        first introduced.

I don't personally care too much about the latter problem - I can live
well without that option. But it would be nice if the former problem
could be fixed (and the default changed from  CONFIG_FAIR_USER_SCHED to
CONFIG_FAIR_CGROUP_SCHED) in 2.6.24.x.

FWIW, the patch below (which reverts commit
810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8) restores 2.6.24 interactivity
to the same level as 2.6.23 here with CONFIG_FAIR_USER_SCHED disabled
(my previous report to the contrary was with CONFIG_FAIR_USER_SCHED
enabled because I didn't yet realize the difference it makes), but I
don't know if that's the real fix.


diff --git a/kernel/sched_fair.c b/kernel/sched_fair.c
index da7c061..a7cc22a 100644
--- a/kernel/sched_fair.c
+++ b/kernel/sched_fair.c
@@ -843,7 +843,6 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p)
 	struct task_struct *curr = rq->curr;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se, *pse = &p->se;
-	unsigned long gran;
 
 	if (unlikely(rt_prio(p->prio))) {
 		update_rq_clock(rq);
@@ -866,11 +865,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p)
 		pse = parent_entity(pse);
 	}
 
-	gran = sysctl_sched_wakeup_granularity;
-	if (unlikely(se->load.weight != NICE_0_LOAD))
-		gran = calc_delta_fair(gran, &se->load);
 
-	if (pse->vruntime + gran < se->vruntime)
+	if (pse->vruntime + sysctl_sched_wakeup_granularity < se->vruntime)
 		resched_task(curr);
 }
 


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
