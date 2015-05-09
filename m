Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 6AFF61A0E65
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 04:22:59 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure
 gracefully
Date: Sat, 09 May 2015 20:48:04 +0200
Message-ID: <3489917.ZU0EhIItEx@vostro.rjw.lan>
In-Reply-To: <4263013.jBGApPfu4h@vostro.rjw.lan>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
 <554D9FDC.6090608@linux.vnet.ibm.com> <4263013.jBGApPfu4h@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rlippert@google.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 peterz@infradead.org, linus.walleij@linaro.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, May 09, 2015 08:46:20 PM Rafael J. Wysocki wrote:
> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
> > Hi Rafael,
> > 
> > On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
> > >> +/*
> > >> + * find_tick_valid_state - select a state where tick does not stop
> > >> + * @dev: cpuidle device for this cpu
> > >> + * @drv: cpuidle driver for this cpu
> > >> + */
> > >> +static int find_tick_valid_state(struct cpuidle_device *dev,
> > >> +				struct cpuidle_driver *drv)
> > >> +{
> > >> +	int i, ret = -1;
> > >> +
> > >> +	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> > >> +		struct cpuidle_state *s = &drv->states[i];
> > >> +		struct cpuidle_state_usage *su = &dev->states_usage[i];
> > >> +
> > >> +		/*
> > >> +		 * We do not explicitly check for latency requirement
> > >> +		 * since it is safe to assume that only shallower idle
> > >> +		 * states will have the CPUIDLE_FLAG_TIMER_STOP bit
> > >> +		 * cleared and they will invariably meet the latency
> > >> +		 * requirement.
> > >> +		 */
> > >> +		if (s->disabled || su->disable ||
> > >> +			(s->flags & CPUIDLE_FLAG_TIMER_STOP))
> > >> +			continue;
> > >> +
> > >> +		ret = i;
> > >> +	}
> > >> +	return ret;
> > >> +}
> > >> +
> > >>  /**
> > >>   * cpuidle_enter_state - enter the state and update stats
> > >>   * @dev: cpuidle device for this cpu
> > >> @@ -168,10 +199,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> > >>  	 * CPU as a broadcast timer, this call may fail if it is not available.
> > >>  	 */
> > >>  	if (broadcast && tick_broadcast_enter()) {
> > >> -		default_idle_call();
> > >> -		return -EBUSY;
> > >> +		index = find_tick_valid_state(dev, drv);
> > > 
> > > Well, the new state needs to be deeper than the old one or you may violate the
> > > governor's choice and this doesn't guarantee that.
> > 
> > The comment above in find_tick_valid_state() explains why we are bound
> > to choose a shallow idle state. I think its safe to assume that any
> > state deeper than this one, would have the CPUIDLE_FLAG_TIMER_STOP flag
> > set and hence would be skipped.
> > 
> > Your patch relies on the assumption that the idle states are arranged in
> > the increasing order of exit_latency/in the order of shallow to deep.
> > This is not guaranteed, is it?
> 
> No, it isn't, which is a good point.  There's no reason to rely on that
> assumption, so appended is an updated version of the patch using a latency
> limit instead of an index limit.

And the patch *is* actually appended this time, sorry.


---
 drivers/cpuidle/cpuidle.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -73,7 +73,10 @@ int cpuidle_play_dead(void)
 }
 
 static int find_deepest_state(struct cpuidle_driver *drv,
-			      struct cpuidle_device *dev, bool freeze)
+			      struct cpuidle_device *dev,
+			      unsigned int max_latency,
+			      unsigned int forbidden_flags,
+			      bool freeze)
 {
 	unsigned int latency_req = 0;
 	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
@@ -83,6 +86,8 @@ static int find_deepest_state(struct cpu
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
 		if (s->disabled || su->disable || s->exit_latency <= latency_req
+		    || s->exit_latency > max_latency
+		    || (s->flags & forbidden_flags)
 		    || (freeze && !s->enter_freeze))
 			continue;
 
@@ -100,7 +105,7 @@ static int find_deepest_state(struct cpu
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev)
 {
-	return find_deepest_state(drv, dev, false);
+	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
 }
 
 static void enter_freeze_proper(struct cpuidle_driver *drv,
@@ -139,7 +144,7 @@ int cpuidle_enter_freeze(struct cpuidle_
 	 * that interrupts won't be enabled when it exits and allows the tick to
 	 * be frozen safely.
 	 */
-	index = find_deepest_state(drv, dev, true);
+	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
 	if (index >= 0)
 		enter_freeze_proper(drv, dev, index);
 
@@ -168,8 +173,13 @@ int cpuidle_enter_state(struct cpuidle_d
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
 	if (broadcast && tick_broadcast_enter()) {
-		default_idle_call();
-		return -EBUSY;
+		index = find_deepest_state(drv, dev, target_state->exit_latency,
+					   CPUIDLE_FLAG_TIMER_STOP, false);
+		if (index < 0) {
+			default_idle_call();
+			return -EBUSY;
+		}
+		target_state = &drv->states[index];
 	}
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
