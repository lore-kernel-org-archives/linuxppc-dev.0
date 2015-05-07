Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDAD51A1949
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 03:52:00 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 7 May 2015 13:51:57 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EB9D9C90043
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:43:03 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t47HptXX61997264
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 17:51:55 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t47Hpsf0021851
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2015 13:51:55 -0400
Message-ID: <554BA634.50307@linux.vnet.ibm.com>
Date: Thu, 07 May 2015 23:21:48 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com,
 daniel.lezcano@linaro.org
Subject: Re: [RESEND PATCH] cpuidle: Handle tick_broadcast_enter() failure
 gracefully
References: <20150507173803.25119.90827.stgit@preeti.in.ibm.com>
In-Reply-To: <20150507173803.25119.90827.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2015 11:09 PM, Preeti U Murthy wrote:
> When a CPU has to enter an idle state where tick stops, it makes a call
> to tick_broadcast_enter(). The call will fail if this CPU is the
> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
> handles this CPU.  This is not convincing because not only are we not
> aware what the arch cpuidle code does, but we also do not account for
> the idle state residency time and usage of such a CPU.
> 
> This scenario can be handled better by simply asking the cpuidle
> governor to choose an idle state where in ticks do not stop. To
> accommodate this change move the setting of runqueue idle state from the
> core to the cpuidle driver, else the rq->idle_state will be set wrong.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Rebased on the latest linux-pm/bleeding-edge

Kindly ignore this. I have sent the rebase as V2.
[PATCH V2] cpuidle: Handle tick_broadcast_enter() failure gracefully

The below patch is not updated.

Regards
Preeti U Murthy
> 
>  drivers/cpuidle/cpuidle.c          |   21 +++++++++++++++++----
>  drivers/cpuidle/governors/ladder.c |   13 ++++++++++---
>  drivers/cpuidle/governors/menu.c   |    6 +++++-
>  include/linux/cpuidle.h            |    6 +++---
>  include/linux/sched.h              |   16 ++++++++++++++++
>  kernel/sched/core.c                |   17 +++++++++++++++++
>  kernel/sched/fair.c                |    2 +-
>  kernel/sched/idle.c                |    8 +-------
>  kernel/sched/sched.h               |   24 ------------------------
>  9 files changed, 70 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 61c417b..8f5657e 100644
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
> @@ -167,8 +168,15 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	 * local timer will be shut down.  If a local timer is used from another
>  	 * CPU as a broadcast timer, this call may fail if it is not available.
>  	 */
> -	if (broadcast && tick_broadcast_enter())
> -		return -EBUSY;
> +	if (broadcast && tick_broadcast_enter()) {
> +		index = cpuidle_select(drv, dev, !broadcast);
> +		if (index < 0)
> +			return -EBUSY;
> +		target_state = &drv->states[index];
> +	}
> +
> +	/* Take note of the planned idle state. */
> +	idle_set_state(smp_processor_id(), target_state);
> 
>  	trace_cpu_idle_rcuidle(index, dev->cpu);
>  	time_start = ktime_get();
> @@ -178,6 +186,9 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	time_end = ktime_get();
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> 
> +	/* The cpu is no longer idle or about to enter idle. */
> +	idle_set_state(smp_processor_id(), NULL);
> +
>  	if (broadcast) {
>  		if (WARN_ON_ONCE(!irqs_disabled()))
>  			local_irq_disable();
> @@ -213,12 +224,14 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>   *
>   * @drv: the cpuidle driver
>   * @dev: the cpuidle device
> + * @timer_stop_valid: allow selection of idle state where tick stops
>   *
>   * Returns the index of the idle state.
>   */
> -int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +int cpuidle_select(struct cpuidle_driver *drv,
> +			struct cpuidle_device *dev, int timer_stop_valid)
>  {
> -	return cpuidle_curr_governor->select(drv, dev);
> +	return cpuidle_curr_governor->select(drv, dev, timer_stop_valid);
>  }
> 
>  /**
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index 401c010..c437322 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -62,9 +62,10 @@ static inline void ladder_do_selection(struct ladder_device *ldev,
>   * ladder_select_state - selects the next state to enter
>   * @drv: cpuidle driver
>   * @dev: the CPU
> + * @timer_stop_valid: allow selection of idle state where tick stops
>   */
>  static int ladder_select_state(struct cpuidle_driver *drv,
> -				struct cpuidle_device *dev)
> +				struct cpuidle_device *dev, int timer_stop_valid)
>  {
>  	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
>  	struct ladder_device_state *last_state;
> @@ -86,6 +87,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
>  	    !drv->states[last_idx + 1].disabled &&
>  	    !dev->states_usage[last_idx + 1].disable &&
>  	    last_residency > last_state->threshold.promotion_time &&
> +	    !(!timer_stop_valid && (drv->states[last_idx + 1].flags & CPUIDLE_FLAG_TIMER_STOP)) &&
>  	    drv->states[last_idx + 1].exit_latency <= latency_req) {
>  		last_state->stats.promotion_count++;
>  		last_state->stats.demotion_count = 0;
> @@ -99,11 +101,14 @@ static int ladder_select_state(struct cpuidle_driver *drv,
>  	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
>  	    (drv->states[last_idx].disabled ||
>  	    dev->states_usage[last_idx].disable ||
> +	    (!timer_stop_valid && (drv->states[last_idx].flags & CPUIDLE_FLAG_TIMER_STOP)) ||
>  	    drv->states[last_idx].exit_latency > latency_req)) {
>  		int i;
> 
>  		for (i = last_idx - 1; i > CPUIDLE_DRIVER_STATE_START; i--) {
> -			if (drv->states[i].exit_latency <= latency_req)
> +			if (drv->states[i].exit_latency <= latency_req &&
> +				!(!timer_stop_valid &&
> +					(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP)))
>  				break;
>  		}
>  		ladder_do_selection(ldev, last_idx, i);
> @@ -114,7 +119,9 @@ static int ladder_select_state(struct cpuidle_driver *drv,
>  	    last_residency < last_state->threshold.demotion_time) {
>  		last_state->stats.demotion_count++;
>  		last_state->stats.promotion_count = 0;
> -		if (last_state->stats.demotion_count >= last_state->threshold.demotion_count) {
> +		if (last_state->stats.demotion_count >= last_state->threshold.demotion_count &&
> +			!(!timer_stop_valid &&
> +				(drv->states[last_idx - 1].flags & CPUIDLE_FLAG_TIMER_STOP))) {
>  			ladder_do_selection(ldev, last_idx, last_idx - 1);
>  			return last_idx - 1;
>  		}
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index b8a5fa1..900404f 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -280,8 +280,10 @@ again:
>   * menu_select - selects the next idle state to enter
>   * @drv: cpuidle driver containing state data
>   * @dev: the CPU
> + * @timer_stop_valid: allow selection of idle state where tick stops
>   */
> -static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> +static int menu_select(struct cpuidle_driver *drv,
> +			struct cpuidle_device *dev, int timer_stop_valid)
>  {
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
>  	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
> @@ -349,6 +351,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  			continue;
>  		if (s->exit_latency > latency_req)
>  			continue;
> +		if (!timer_stop_valid && (s->flags & CPUIDLE_FLAG_TIMER_STOP))
> +			continue;
> 
>  		data->last_state_idx = i;
>  	}
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 9c5e892..d7c1734 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -129,7 +129,7 @@ extern bool cpuidle_not_available(struct cpuidle_driver *drv,
>  				  struct cpuidle_device *dev);
> 
>  extern int cpuidle_select(struct cpuidle_driver *drv,
> -			  struct cpuidle_device *dev);
> +			  struct cpuidle_device *dev, int timer_stop_valid);
>  extern int cpuidle_enter(struct cpuidle_driver *drv,
>  			 struct cpuidle_device *dev, int index);
>  extern void cpuidle_reflect(struct cpuidle_device *dev, int index);
> @@ -163,7 +163,7 @@ static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
>  					 struct cpuidle_device *dev)
>  {return true; }
>  static inline int cpuidle_select(struct cpuidle_driver *drv,
> -				 struct cpuidle_device *dev)
> +				 struct cpuidle_device *dev, int timer_stop_valid)
>  {return -ENODEV; }
>  static inline int cpuidle_enter(struct cpuidle_driver *drv,
>  				struct cpuidle_device *dev, int index)
> @@ -223,7 +223,7 @@ struct cpuidle_governor {
>  					struct cpuidle_device *dev);
> 
>  	int  (*select)		(struct cpuidle_driver *drv,
> -					struct cpuidle_device *dev);
> +					struct cpuidle_device *dev, int timer_stop_valid);
>  	void (*reflect)		(struct cpuidle_device *dev, int index);
> 
>  	struct module 		*owner;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8222ae4..ff4e2df 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -45,6 +45,7 @@ struct sched_param {
>  #include <linux/rcupdate.h>
>  #include <linux/rculist.h>
>  #include <linux/rtmutex.h>
> +#include <linux/cpuidle.h>
> 
>  #include <linux/time.h>
>  #include <linux/param.h>
> @@ -901,6 +902,21 @@ enum cpu_idle_type {
>  	CPU_MAX_IDLE_TYPES
>  };
> 
> +#ifdef CONFIG_CPU_IDLE
> +extern void idle_set_state(int cpu, struct cpuidle_state *idle_state);
> +extern struct cpuidle_state *idle_get_state(int cpu);
> +#else
> +static inline void idle_set_state(int cpu,
> +				  struct cpuidle_state *idle_state)
> +{
> +}
> +
> +static inline struct cpuidle_state *idle_get_state(int cpu)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  /*
>   * Increase resolution of cpu_capacity calculations
>   */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f9123a8..427e190 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3231,6 +3231,23 @@ struct task_struct *idle_task(int cpu)
>  	return cpu_rq(cpu)->idle;
>  }
> 
> +#ifdef CONFIG_CPU_IDLE
> +void idle_set_state(int cpu, struct cpuidle_state *idle_state)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	rq->idle_state = idle_state;
> +}
> +
> +struct cpuidle_state *idle_get_state(int cpu)
> +{
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	WARN_ON(!rcu_read_lock_held());
> +	return rq->idle_state;
> +}
> +#endif /* CONFIG_CPU_IDLE */
> +
>  /**
>   * find_process_by_pid - find a process with a matching PID value.
>   * @pid: the pid in question.
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ffeaa41..211ef9a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4709,7 +4709,7 @@ find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
>  	for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
>  		if (idle_cpu(i)) {
>  			struct rq *rq = cpu_rq(i);
> -			struct cpuidle_state *idle = idle_get_state(rq);
> +			struct cpuidle_state *idle = idle_get_state(i);
>  			if (idle && idle->exit_latency < min_exit_latency) {
>  				/*
>  				 * We give priority to a CPU whose idle state
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index fefcb1f..5bd766c 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -131,7 +131,7 @@ static void cpuidle_idle_call(void)
>  		/*
>  		 * Ask the cpuidle framework to choose a convenient idle state.
>  		 */
> -		next_state = cpuidle_select(drv, dev);
> +		next_state = cpuidle_select(drv, dev, 1);
>  	}
>  	/* Fall back to the default arch idle method on errors. */
>  	if (next_state < 0)
> @@ -149,9 +149,6 @@ static void cpuidle_idle_call(void)
>  		goto exit_idle;
>  	}
> 
> -	/* Take note of the planned idle state. */
> -	idle_set_state(this_rq(), &drv->states[next_state]);
> -
>  	/*
>  	 * Enter the idle state previously returned by the governor decision.
>  	 * This function will block until an interrupt occurs and will take
> @@ -159,9 +156,6 @@ static void cpuidle_idle_call(void)
>  	 */
>  	entered_state = cpuidle_enter(drv, dev, next_state);
> 
> -	/* The cpu is no longer idle or about to enter idle. */
> -	idle_set_state(this_rq(), NULL);
> -
>  	if (entered_state == -EBUSY)
>  		goto use_default;
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e0e1299..2c56caa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1253,30 +1253,6 @@ static inline void idle_exit_fair(struct rq *rq) { }
> 
>  #endif
> 
> -#ifdef CONFIG_CPU_IDLE
> -static inline void idle_set_state(struct rq *rq,
> -				  struct cpuidle_state *idle_state)
> -{
> -	rq->idle_state = idle_state;
> -}
> -
> -static inline struct cpuidle_state *idle_get_state(struct rq *rq)
> -{
> -	WARN_ON(!rcu_read_lock_held());
> -	return rq->idle_state;
> -}
> -#else
> -static inline void idle_set_state(struct rq *rq,
> -				  struct cpuidle_state *idle_state)
> -{
> -}
> -
> -static inline struct cpuidle_state *idle_get_state(struct rq *rq)
> -{
> -	return NULL;
> -}
> -#endif
> -
>  extern void sysrq_sched_debug_show(void);
>  extern void sched_init_granularity(void);
>  extern void update_max_interval(void);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
