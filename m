Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wd3nY2H56zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 18:40:01 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4V8d5Jn091609
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:39:55 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2asp2c38r5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:39:55 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 31 May 2017 04:39:53 -0400
Date: Wed, 31 May 2017 14:09:48 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] cpuidle-powernv: Allow Deep stop states that don't
 stop time
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <3429547945465851cfcbf81f6e762037c395c8ac.1494585671.git.ego@linux.vnet.ibm.com>
 <20170530171357.4e0b87a7@roar.ozlabs.ibm.com>
 <20170530105055.GD8563@in.ibm.com>
 <20170530211006.49ce9eff@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170530211006.49ce9eff@roar.ozlabs.ibm.com>
Message-Id: <20170531083948.GA19458@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 30, 2017 at 09:10:06PM +1000, Nicholas Piggin wrote:
> On Tue, 30 May 2017 16:20:55 +0530
> Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> 
> > On Tue, May 30, 2017 at 05:13:57PM +1000, Nicholas Piggin wrote:
> > > On Tue, 16 May 2017 14:19:48 +0530
> > > "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> > >   
> > > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > > 
> > > > The current code in the cpuidle-powernv intialization only allows deep
> > > > stop states (indicated by OPAL_PM_STOP_INST_DEEP) which lose timebase
> > > > (indicated by OPAL_PM_TIMEBASE_STOP). This assumption goes back to
> > > > POWER8 time where deep states used to lose the timebase. However, on
> > > > POWER9, we do have stop states that are deep (they lose hypervisor
> > > > state) but retain the timebase.
> > > > 
> > > > Fix the initialization code in the cpuidle-powernv driver to allow
> > > > such deep states.
> > > > 
> > > > Further, there is a bug in cpuidle-powernv driver with
> > > > CONFIG_TICK_ONESHOT=n where we end up incrementing the nr_idle_states
> > > > even if a platform idle state which loses time base was not added to
> > > > the cpuidle table.
> > > > 
> > > > Fix this by ensuring that the nr_idle_states variable gets incremented
> > > > only when the platform idle state was added to the cpuidle table.  
> > > 
> > > Should this be a separate patch? Stable?  
> > 
> > Ok. Will send it out separately.
> 
> Looks like mpe has merged this in next now. I just wonder if this
> particular bit would be relevant for POWER8 and therefore be a
> stable candidate? All the POWER9 idle fixes may not be suitable for
> stable.

I agree. The other POWER9 fixes aren't suitable for stable. I will
clean this patch alone based on your suggestion and mark it for
stable.

> 
> 
> > > > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > > > ---
> > > >  drivers/cpuidle/cpuidle-powernv.c | 16 ++++++++++------
> > > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > > > index 12409a5..45eaf06 100644
> > > > --- a/drivers/cpuidle/cpuidle-powernv.c
> > > > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > > > @@ -354,6 +354,7 @@ static int powernv_add_idle_states(void)
> > > >  
> > > >  	for (i = 0; i < dt_idle_states; i++) {
> > > >  		unsigned int exit_latency, target_residency;
> > > > +		bool stops_timebase = false;
> > > >  		/*
> > > >  		 * If an idle state has exit latency beyond
> > > >  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> > > > @@ -381,6 +382,9 @@ static int powernv_add_idle_states(void)
> > > >  			}
> > > >  		}
> > > >  
> > > > +		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
> > > > +			stops_timebase = true;
> > > > +
> > > >  		/*
> > > >  		 * For nap and fastsleep, use default target_residency
> > > >  		 * values if f/w does not expose it.
> > > > @@ -392,8 +396,7 @@ static int powernv_add_idle_states(void)
> > > >  			add_powernv_state(nr_idle_states, "Nap",
> > > >  					  CPUIDLE_FLAG_NONE, nap_loop,
> > > >  					  target_residency, exit_latency, 0, 0);
> > > > -		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
> > > > -				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> > > > +		} else if (has_stop_states && !stops_timebase) {
> > > >  			add_powernv_state(nr_idle_states, names[i],
> > > >  					  CPUIDLE_FLAG_NONE, stop_loop,
> > > >  					  target_residency, exit_latency,
> > > > @@ -405,8 +408,8 @@ static int powernv_add_idle_states(void)
> > > >  		 * within this config dependency check.
> > > >  		 */
> > > >  #ifdef CONFIG_TICK_ONESHOT
> > > > -		if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
> > > > -			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
> > > > +		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
> > > > +			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {  
> > > 
> > > Hmm, seems okay but readability is isn't the best with the ifdef and
> > > mixing power8 and 9 cases IMO.
> > > 
> > > Particularly with the nice regular POWER9 states, we're not doing much
> > > logic in this loop besides checking for the timebase stop flag, right?
> > > Would it be clearer if it was changed to something like this (untested
> > > quick hack)?  
> > 
> > Yes, this is very much doable. Some comments below.
> > 
> > > 
> > > ---
> > >  drivers/cpuidle/cpuidle-powernv.c | 76 +++++++++++++++++++--------------------
> > >  1 file changed, 37 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > > index 12409a519cc5..77291389f9ac 100644
> > > --- a/drivers/cpuidle/cpuidle-powernv.c
> > > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > > @@ -353,7 +353,9 @@ static int powernv_add_idle_states(void)
> > >  	}
> > > 
> > >  	for (i = 0; i < dt_idle_states; i++) {
> > > +		unsigned int cpuidle_flags = CPUIDLE_FLAG_NONE;
> > >  		unsigned int exit_latency, target_residency;
> > > +
> > >  		/*
> > >  		 * If an idle state has exit latency beyond
> > >  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> > > @@ -371,6 +373,16 @@ static int powernv_add_idle_states(void)
> > >  		else
> > >  			target_residency = 0;
> > > 
> > > +		if (flags[i] & OPAL_PM_TIMEBASE_STOP) {
> > > +			/*
> > > +			 * All cpuidle states with CPUIDLE_FLAG_TIMER_STOP set
> > > +			 * depend on CONFIG_TICK_ONESHOT.
> > > +			 */
> > > +			if (!IS_ENABLED(CONFIG_TICK_ONESHOT))
> > > +				continue;
> > > +			cpuidle_flags = CPUIDLE_FLAG_TIMER_STOP;  
> > 
> > Yes, this can be done. We just need to extend this condition to
> > (flags[i] & OPAL_PM_TIMEBASE_STOP || flags[i] &
> > OPAL_PM_SLEEP_ENABLED).
> > 
> > Even though all the recent versions of OPAL have OPAL_PM_TIMEBASE_STOP
> > set for states which have OPAL_PM_SLEEP_ENABLED, I am not sure if
> > that was always the case and which is why we have the fastsleep case
> > explicitly coded in the kernel.
> 
> Okay that makes sense, thanks for explaining.
> 
> Since your patches are now merged, it's a matter of preference,
> if you want to send any cleanup patches you can take any of my
> suggestions.
> 
> Thanks for the fixes!

I will incorporate your suggestion into a separate patch to do all the
device-tree parsing pertaining to the idle-bits in one place,
preferably arch/powerpc/platforms/powernv/idle.c and expose the parsed
output to any other subsystems such as cpuidle-powernv via an in
kernel data-structure. Today we do it at two separate place, once
during the idle-code initialization and another cpuidle-powernv driver
initialization.

--
Thanks and Regards
gautham.
