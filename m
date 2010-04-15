Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH 5/5] sched: make fix_small_imbalance work with asymmetric
	packing
In-reply-to: <1271208670.2834.55.camel@sbs-t61.sc.intel.com>
References: <20100409062119.10AC5CBB6D@localhost.localdomain>
	<1271161769.4807.1283.camel@twins>
	<1271208670.2834.55.camel@sbs-t61.sc.intel.com>
Date: Thu, 15 Apr 2010 15:06:31 +1000
Message-ID: <10091.1271307991@neuling.org>
Cc: Gautham R Shenoy <ego@in.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <1271208670.2834.55.camel@sbs-t61.sc.intel.com> you wrote:
> On Tue, 2010-04-13 at 05:29 -0700, Peter Zijlstra wrote:
> > On Fri, 2010-04-09 at 16:21 +1000, Michael Neuling wrote:
> > > With the asymmetric packing infrastructure, fix_small_imbalance is
> > > causing idle higher threads to pull tasks off lower threads.  
> > > 
> > > This is being caused by an off-by-one error.  
> > > 
> > > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > > ---
> > > I'm not sure this is the right fix but without it, higher threads pull
> > > tasks off the lower threads, then the packing pulls it back down, etc
> > > etc and tasks bounce around constantly.
> > 
> > Would help if you expand upon the why/how it manages to get pulled up.
> > 
> > I can't immediately spot anything wrong with the patch, but then that
> > isn't my favourite piece of code either.. Suresh, any comments?
> > 
> 
> Sorry didn't pay much attention to this patchset. But based on the
> comments from Michael and looking at this patchset, it has SMT/MC
> implications. I will review and run some tests and get back in a day.
> 
> As far as this particular patch is concerned, original code is coming
> from Ingo's original CFS code commit (dd41f596) and the below hunk
> pretty much explains what the change is about.
> 
> -               if (max_load - this_load >= busiest_load_per_task * imbn) {
> +               if (max_load - this_load + SCHED_LOAD_SCALE_FUZZ >=
> +                                       busiest_load_per_task * imbn) {
> 
> So the below proposed change will probably break what the above
> mentioned commit was trying to achieve, which is: for fairness reasons
> we were bouncing the small extra load (between the max_load and
> this_load) around.

Actually, you can drop this patch.  

In the process of clarifying why it was needed for the changelog, I
discovered I don't actually need it.  

Sorry about that.

Mikey

> 
> > > ---
> > > 
> > >  kernel/sched_fair.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6-ozlabs/kernel/sched_fair.c
> > > ===================================================================
> > > --- linux-2.6-ozlabs.orig/kernel/sched_fair.c
> > > +++ linux-2.6-ozlabs/kernel/sched_fair.c
> > > @@ -2652,7 +2652,7 @@ static inline void fix_small_imbalance(s
> > >  						 * SCHED_LOAD_SCALE;
> > >  	scaled_busy_load_per_task /= sds->busiest->cpu_power;
> > >  
> > > -	if (sds->max_load - sds->this_load + scaled_busy_load_per_task >=
> > > +	if (sds->max_load - sds->this_load + scaled_busy_load_per_task >
> > >  			(scaled_busy_load_per_task * imbn)) {
> > >  		*imbalance = sds->busiest_load_per_task;
> > >  		return;
> > 
> 
> thanks,
> suresh
> 
