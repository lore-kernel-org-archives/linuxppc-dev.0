Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlBX50tY8zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 15:03:15 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id bx7so26585757pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 22:03:15 -0700 (PDT)
Date: Wed, 13 Apr 2016 10:33:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
Message-ID: <20160413050310.GE19433@vireshk-i7>
References: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460484386-28389-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460484386-28389-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Comments mostly on the coding standards which you have *not* followed.

Also, please run checkpatch --strict next time you send patches
upstream.

On 12-04-16, 23:36, Akshay Adiga wrote:
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> +#define MAX_RAMP_DOWN_TIME				5120
> +#define ramp_down_percent(time)		((time * time)>>18)

You need spaces around >>

> +
> +/*Interval after which the timer is queued to bring down global pstate*/

Bad comment style, should be /* ... */

> +#define GPSTATE_TIMER_INTERVAL				2000
> +/*
> + * global_pstate_info :

This is bad as well.. See how doc style comments are written at
separate places.

> + *	per policy data structure to maintain history of global pstates
> + *
> + * @highest_lpstate : the local pstate from which we are ramping down

No space required before :

> + * @elapsed_time : time in ms spent in ramping down from highest_lpstate
> + * @last_sampled_time : time from boot in ms when global pstates were last set
> + * @last_lpstate , last_gpstate : last set values for local and global pstates
> + * @timer : is used for ramping down if cpu goes idle for a long time with
> + *	global pstate held high
> + * @gpstate_lock : a spinlock to maintain synchronization between routines
> + *	called by the timer handler and governer's target_index calls
> + */
> +struct global_pstate_info {
> +	int highest_lpstate;
> +	unsigned int elapsed_time;
> +	unsigned int last_sampled_time;
> +	int last_lpstate;
> +	int last_gpstate;
> +	spinlock_t gpstate_lock;
> +	struct timer_list timer;
> +};
> +
> +/*
> + * While resetting we don't want "timer" fields to be set to zero as we
> + * may lose track of timer and will not be able to cleanly remove it
> + */
> +#define reset_gpstates(policy)   memset(policy->driver_data, 0,\
> +					sizeof(struct global_pstate_info)-\
> +					sizeof(struct timer_list)-\
> +					sizeof(spinlock_t))

That's super *ugly*. Why don't you create a simple routine which will
set the 5 integer variables to 0 in a straight forward way ?

> @@ -348,14 +395,17 @@ static void set_pstate(void *freq_data)
>  	unsigned long val;
>  	unsigned long pstate_ul =
>  		((struct powernv_smp_call_data *) freq_data)->pstate_id;
> +	unsigned long gpstate_ul =
> +		((struct powernv_smp_call_data *) freq_data)->gpstate_id;

Remove these unnecessary casts and do:

struct powernv_smp_call_data *freq_data = data; //Name func arg as data

And then use freq_data->*.

>  
>  	val = get_pmspr(SPRN_PMCR);
>  	val = val & 0x0000FFFFFFFFFFFFULL;
>  
>  	pstate_ul = pstate_ul & 0xFF;
> +	gpstate_ul = gpstate_ul & 0xFF;
>  
>  	/* Set both global(bits 56..63) and local(bits 48..55) PStates */
> -	val = val | (pstate_ul << 56) | (pstate_ul << 48);
> +	val = val | (gpstate_ul << 56) | (pstate_ul << 48);

>  /*

You need /** here. See comments everywhere please, they are mostly
done in a wrong way.

> + * calcuate_global_pstate:
> + *
> + * @elapsed_time : elapsed time in milliseconds
> + * @local_pstate : new local pstate
> + * @highest_lpstate : pstate from which its ramping down
> + *
> + * Finds the appropriate global pstate based on the pstate from which its
> + * ramping down and the time elapsed in ramping down. It follows a quadratic
> + * equation which ensures that it reaches ramping down to pmin in 5sec.
> + */
> +inline int calculate_global_pstate(unsigned int elapsed_time,
> +		int highest_lpstate, int local_pstate)

Not aligned properly, checkpatch --strict will tell you what to do.

> +{
> +	int pstate_diff;
> +
> +	/*
> +	 * Using ramp_down_percent we get the percentage of rampdown
> +	 * that we are expecting to be dropping. Difference between
> +	 * highest_lpstate and powernv_pstate_info.min will give a absolute
> +	 * number of how many pstates we will drop eventually by the end of
> +	 * 5 seconds, then just scale it get the number pstates to be dropped.
> +	 */
> +	pstate_diff =  ((int)ramp_down_percent(elapsed_time) *
> +			(highest_lpstate - powernv_pstate_info.min))/100;
> +
> +	/* Ensure that global pstate is >= to local pstate */
> +	if (highest_lpstate - pstate_diff < local_pstate)
> +		return local_pstate;
> +	else
> +		return (highest_lpstate - pstate_diff);

Unnecessary ().

> +}
> +
> +inline int queue_gpstate_timer(struct global_pstate_info *gpstates)

Looks like many of the function you wrote now should be marked
'static' as well.

> +{
> +	unsigned int timer_interval;
> +
> +	/* Setting up timer to fire after GPSTATE_TIMER_INTERVAL ms, But

Bad style again:

/*
 * ...
 * ...
 */

> +	 * if it exceeds MAX_RAMP_DOWN_TIME ms for ramp down time.
> +	 * Set timer such that it fires exactly at MAX_RAMP_DOWN_TIME
> +	 * seconds of ramp down time.
> +	 */
> +	if ((gpstates->elapsed_time + GPSTATE_TIMER_INTERVAL)
> +							 > MAX_RAMP_DOWN_TIME)

Align '>' right below the second (

> +		timer_interval = MAX_RAMP_DOWN_TIME - gpstates->elapsed_time;
> +	else
> +		timer_interval = GPSTATE_TIMER_INTERVAL;
> +
> +	return  mod_timer_pinned(&(gpstates->timer), jiffies +

() not required.

> +				msecs_to_jiffies(timer_interval));
> +}

blank line required.

> +/*
> + * gpstate_timer_handler
> + *
> + * @data: pointer to cpufreq_policy on which timer was queued
> + *
> + * This handler brings down the global pstate closer to the local pstate
> + * according quadratic equation. Queues a new timer if it is still not equal
> + * to local pstate
> + */
> +void gpstate_timer_handler(unsigned long data)
> +{
> +	struct cpufreq_policy *policy = (struct cpufreq_policy *) data;

no need to cast.

> +	struct global_pstate_info *gpstates = (struct global_pstate_info *)
> +							policy->driver_data;

same here.

> +	unsigned int time_diff = jiffies_to_msecs(jiffies)
> +					- gpstates->last_sampled_time;
> +	struct powernv_smp_call_data freq_data;
> +	int ret;
> +
> +	ret = spin_trylock(&gpstates->gpstate_lock);

no need of 'ret' for just this, simply do: if (!spin_trylock())...

> +	if (!ret)
> +		return;
> +
> +	gpstates->last_sampled_time += time_diff;
> +	gpstates->elapsed_time += time_diff;
> +	freq_data.pstate_id = gpstates->last_lpstate;
> +	if ((gpstates->last_gpstate == freq_data.pstate_id) ||
> +			(gpstates->elapsed_time > MAX_RAMP_DOWN_TIME)) {
> +		freq_data.gpstate_id = freq_data.pstate_id;
> +		reset_gpstates(policy);
> +		gpstates->highest_lpstate = freq_data.pstate_id;
> +	} else {
> +		freq_data.gpstate_id = calculate_global_pstate(

You can't break a line after ( of a function call :)

Let it go beyond 80 columns if it has to.

> +			gpstates->elapsed_time, gpstates->highest_lpstate,
> +			freq_data.pstate_id);
> +	}
> +
> +	/* If local pstate is equal to global pstate, rampdown is over

Bad style again.

> +	 * So timer is not required to be queued.
> +	 */
> +	if (freq_data.gpstate_id != freq_data.pstate_id)
> +		ret = queue_gpstate_timer(gpstates);

ret not used.

> +
> +	gpstates->last_gpstate = freq_data.gpstate_id;
> +	gpstates->last_lpstate = freq_data.pstate_id;
> +
> +	/* Timer may get migrated to a different cpu on cpu hot unplug */
> +	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> +	spin_unlock(&gpstates->gpstate_lock);
> +}
> +
> +

Remove extra blank line.

> +/*
>   * powernv_cpufreq_target_index: Sets the frequency corresponding to
>   * the cpufreq table entry indexed by new_index on the cpus in the
>   * mask policy->cpus
> @@ -432,23 +585,88 @@ next:
>  static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  					unsigned int new_index)
>  {
> +	int ret;
>  	struct powernv_smp_call_data freq_data;
> -
> +	unsigned int cur_msec;
> +	unsigned long flags;
> +	struct global_pstate_info *gpstates = (struct global_pstate_info *)
> +						policy->driver_data;
>  	if (unlikely(rebooting) && new_index != get_nominal_index())
>  		return 0;
>  
>  	if (!throttled)
>  		powernv_cpufreq_throttle_check(NULL);
>  
> +	cur_msec = jiffies_to_msecs(get_jiffies_64());
> +
> +	/*spinlock taken*/

Drop these useless comments, we know what you are doing.

> +	spin_lock_irqsave(&gpstates->gpstate_lock, flags);
>  	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
>  
> +	/*First time call */
> +	if (!gpstates->last_sampled_time) {
> +		freq_data.gpstate_id = freq_data.pstate_id;
> +		gpstates->highest_lpstate = freq_data.pstate_id;
> +		goto gpstates_done;
> +	}
> +
> +	/*Ramp down*/

Rather explain what you are doing and how you are doing it here.

> +	if (gpstates->last_gpstate > freq_data.pstate_id) {
> +		gpstates->elapsed_time += cur_msec -
> +					gpstates->last_sampled_time;
> +		/* If its has been ramping down for more than 5seconds
> +		 * we should be reseting all global pstate related data.
> +		 * Set it equal to local pstate to start fresh.
> +		 */
> +		if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
> +			freq_data.gpstate_id = freq_data.pstate_id;
> +			reset_gpstates(policy);
> +			gpstates->highest_lpstate = freq_data.pstate_id;
> +			freq_data.gpstate_id = freq_data.pstate_id;
> +		} else {
> +		/* elaspsed_time is less than 5 seconds, continue to rampdown*/
> +			freq_data.gpstate_id = calculate_global_pstate(
> +			gpstates->elapsed_time,
> +			gpstates->highest_lpstate, freq_data.pstate_id);
> +
> +		}
> +

remove blank line.

> +	} else {
> +		/*Ramp up*/
> +		reset_gpstates(policy);
> +		gpstates->highest_lpstate = freq_data.pstate_id;
> +		freq_data.gpstate_id = freq_data.pstate_id;
> +	}
> +
> +	/* If local pstate is equal to global pstate, rampdown is over
> +	 * So timer is not required to be queued.
> +	 */
> +	if (freq_data.gpstate_id != freq_data.pstate_id)
> +		ret = queue_gpstate_timer(gpstates);

add a blank line here

> +gpstates_done:
> +	gpstates->last_sampled_time = cur_msec;
> +	gpstates->last_gpstate = freq_data.gpstate_id;
> +	gpstates->last_lpstate = freq_data.pstate_id;
> +
>  	/*
>  	 * Use smp_call_function to send IPI and execute the
>  	 * mtspr on target CPU.  We could do that without IPI
>  	 * if current CPU is within policy->cpus (core)
>  	 */
>  	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> +	spin_unlock_irqrestore(&gpstates->gpstate_lock, flags);
> +	return 0;
> +}
>  
> +static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)

Add this after the init() routine.

> +{
> +	int base;
> +	struct global_pstate_info *gpstates = (struct global_pstate_info *)

Unnecessary cast.

> +						policy->driver_data;
> +	base = cpu_first_thread_sibling(policy->cpu);
> +	del_timer_sync(&gpstates->timer);
> +	kfree(policy->driver_data);
> +	pr_info("freed driver_data cpu %d\n", base);

may be a blank line here.

>  	return 0;
>  }
>  
> @@ -456,6 +674,7 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int base, i;
>  	struct kernfs_node *kn;
> +	struct global_pstate_info *gpstates;
>  
>  	base = cpu_first_thread_sibling(policy->cpu);
>  
> @@ -475,6 +694,21 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	} else {
>  		kernfs_put(kn);
>  	}

blank line here.

> +	gpstates =  kzalloc(sizeof(struct global_pstate_info), GFP_KERNEL);

sizeof(*gpstates).

> +	if (!gpstates) {
> +		pr_err("Could not allocate global_pstate_info\n");

print not required

> +		return -ENOMEM;
> +	}

blank line here

> +	policy->driver_data = gpstates;
> +
> +	/* initialize timer */
> +	init_timer_deferrable(&gpstates->timer);
> +	gpstates->timer.data = (unsigned long) policy;
> +	gpstates->timer.function = gpstate_timer_handler;
> +	gpstates->timer.expires = jiffies +
> +				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
> +
> +	pr_info("Added global_pstate_info & timer for %d cpu\n", base);
>  	return cpufreq_table_validate_and_show(policy, powernv_freqs);

Who will free gpstates if this fails ?

>  }
>  
> @@ -612,6 +846,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>  	.name		= "powernv-cpufreq",
>  	.flags		= CPUFREQ_CONST_LOOPS,
>  	.init		= powernv_cpufreq_cpu_init,
> +	.exit		= powernv_cpufreq_cpu_exit,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= powernv_cpufreq_target_index,
>  	.get		= powernv_cpufreq_get,
> -- 
> 2.5.5

-- 
viresh
