Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id CBCA41A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 23:52:58 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure
 gracefully
Date: Fri, 08 May 2015 16:18:02 +0200
Message-ID: <8680371.ymYIEaFYPT@vostro.rjw.lan>
In-Reply-To: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
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

On Friday, May 08, 2015 01:05:32 PM Preeti U Murthy wrote:
> When a CPU has to enter an idle state where tick stops, it makes a call
> to tick_broadcast_enter(). The call will fail if this CPU is the
> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
> handles this CPU.  This is not convincing because not only do we not
> know what the arch cpuidle code does, but we also do not account for the
> idle state residency time and usage of such a CPU.
> 
> This scenario can be handled better by simply choosing an idle state
> where in ticks do not stop. To accommodate this change move the setting
> of runqueue idle state from the core to the cpuidle driver, else the
> rq->idle_state will be set wrong.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Changes from V2: https://lkml.org/lkml/2015/5/7/78
> Introduce a function in cpuidle core to select an idle state where ticks do not
> stop rather than going through the governors.
> 
> Changes from V1: https://lkml.org/lkml/2015/5/7/24
> Rebased on the latest linux-pm/bleeding-edge branch
> 
>  drivers/cpuidle/cpuidle.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/sched.h     |   16 ++++++++++++++++
>  kernel/sched/core.c       |   17 +++++++++++++++++
>  kernel/sched/fair.c       |    2 +-
>  kernel/sched/idle.c       |    6 ------
>  kernel/sched/sched.h      |   24 ------------------------
>  6 files changed, 77 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 8c24f95..d1af760 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/suspend.h>
>  #include <linux/tick.h>
> +#include <linux/sched.h>
>  #include <trace/events/power.h>
>  
>  #include "cpuidle.h"
> @@ -146,6 +147,36 @@ int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	return index;
>  }
>  
> +/*
> + * find_tick_valid_state - select a state where tick does not stop
> + * @dev: cpuidle device for this cpu
> + * @drv: cpuidle driver for this cpu
> + */
> +static int find_tick_valid_state(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv)
> +{
> +	int i, ret = -1;
> +
> +	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> +		struct cpuidle_state *s = &drv->states[i];
> +		struct cpuidle_state_usage *su = &dev->states_usage[i];
> +
> +		/*
> +		 * We do not explicitly check for latency requirement
> +		 * since it is safe to assume that only shallower idle
> +		 * states will have the CPUIDLE_FLAG_TIMER_STOP bit
> +		 * cleared and they will invariably meet the latency
> +		 * requirement.
> +		 */
> +		if (s->disabled || su->disable ||
> +			(s->flags & CPUIDLE_FLAG_TIMER_STOP))
> +			continue;
> +
> +		ret = i;
> +	}
> +	return ret;
> +}
> +
>  /**
>   * cpuidle_enter_state - enter the state and update stats
>   * @dev: cpuidle device for this cpu
> @@ -168,10 +199,17 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	 * CPU as a broadcast timer, this call may fail if it is not available.
>  	 */
>  	if (broadcast && tick_broadcast_enter()) {
> -		default_idle_call();
> -		return -EBUSY;
> +		index = find_tick_valid_state(dev, drv);

Well, the new state needs to be deeper than the old one or you may violate the
governor's choice and this doesn't guarantee that.

Also I don't quite see a reason to duplicate the find_deepest_state() functionality
here.

> +		if (index < 0) {
> +			default_idle_call();
> +			return -EBUSY;
> +		}
> +		target_state = &drv->states[index];
>  	}
>  
> +	/* Take note of the planned idle state. */
> +	idle_set_state(smp_processor_id(), target_state);

And I wouldn't do this either.

The behavior here is pretty much as though the driver demoted the state chosen
by the governor and we don't call idle_set_state() again in those cases.

> +
>  	trace_cpu_idle_rcuidle(index, dev->cpu);
>  	time_start = ktime_get();

Overall, something like the patch below (untested) should work I suppose?

---
 drivers/cpuidle/cpuidle.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -73,17 +73,19 @@ int cpuidle_play_dead(void)
 }
 
 static int find_deepest_state(struct cpuidle_driver *drv,
-			      struct cpuidle_device *dev, bool freeze)
+			      struct cpuidle_device *dev, bool freeze,
+			      int limit, unsigned int flags_to_avoid)
 {
 	unsigned int latency_req = 0;
 	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
 
-	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
+	for (i = CPUIDLE_DRIVER_STATE_START; i < limit; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
 		if (s->disabled || su->disable || s->exit_latency <= latency_req
-		    || (freeze && !s->enter_freeze))
+		    || (freeze && !s->enter_freeze)
+		    || (s->flags & flags_to_avoid))
 			continue;
 
 		latency_req = s->exit_latency;
@@ -100,7 +102,7 @@ static int find_deepest_state(struct cpu
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev)
 {
-	return find_deepest_state(drv, dev, false);
+	return find_deepest_state(drv, dev, false, drv->state_count, 0);
 }
 
 static void enter_freeze_proper(struct cpuidle_driver *drv,
@@ -139,7 +141,7 @@ int cpuidle_enter_freeze(struct cpuidle_
 	 * that interrupts won't be enabled when it exits and allows the tick to
 	 * be frozen safely.
 	 */
-	index = find_deepest_state(drv, dev, true);
+	index = find_deepest_state(drv, dev, true, drv->state_count, 0);
 	if (index >= 0)
 		enter_freeze_proper(drv, dev, index);
 
@@ -168,8 +170,13 @@ int cpuidle_enter_state(struct cpuidle_d
 	 * CPU as a broadcast timer, this call may fail if it is not available.
 	 */
 	if (broadcast && tick_broadcast_enter()) {
-		default_idle_call();
-		return -EBUSY;
+		index = find_deepest_state(drv, dev, false, index,
+					   CPUIDLE_FLAG_TIMER_STOP);
+		if (index < 0) {
+			default_idle_call();
+			return -EBUSY;
+		}
+		target_state = &drv->states[index];
 	}
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
