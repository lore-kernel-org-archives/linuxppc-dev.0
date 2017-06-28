Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyY7w64PMzDr1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 05:41:32 +1000 (AEST)
Date: Wed, 28 Jun 2017 21:41:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v11 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
In-Reply-To: <1498676291-24002-2-git-send-email-anju@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706282104290.1890@nanos>
References: <1498676291-24002-1-git-send-email-anju@linux.vnet.ibm.com>
 <1498676291-24002-2-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017, Anju T Sudhakar wrote:
> +static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
> +{
> +	struct imc_mem_info *ptr;
> +
> +	for (ptr = pmu_ptr->mem_info; ptr; ptr++) {
> +		if (ptr->vbase[0])
> +			free_pages((u64)ptr->vbase[0], 0);
> +	}

This loop is broken beyond repair. If pmu_ptr->mem_info is not NULL, then
ptr will happily increment to the point where it wraps around to
NULL. Oh well.

> +	kfree(pmu_ptr->mem_info);

> +bool is_core_imc_mem_inited(int cpu)

This function is global because?

> +{
> +	struct imc_mem_info *mem_info;
> +	int core_id = (cpu / threads_per_core);
> +
> +	mem_info = &core_imc_pmu->mem_info[core_id];
> +	if ((mem_info->id == core_id) && (mem_info->vbase[0] != NULL))
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * imc_mem_init : Function to support memory allocation for core imc.
> + */
> +static int imc_mem_init(struct imc_pmu *pmu_ptr)
> +{

The function placement is horrible. This function belongs to the pmu init
stuff and wants to be placed there and not five pages away in the middle of
unrelated functions.

> +	int nr_cores;
> +
> +	if (pmu_ptr->imc_counter_mmaped)
> +		return 0;
> +	nr_cores = num_present_cpus() / threads_per_core;
> +	pmu_ptr->mem_info = kzalloc((sizeof(struct imc_mem_info) * nr_cores), GFP_KERNEL);
> +	if (!pmu_ptr->mem_info)
> +		return -ENOMEM;
> +	return 0;
> +}
> +static int core_imc_event_init(struct perf_event *event)
> +{
> +	int core_id, rc;
> +	u64 config = event->attr.config;
> +	struct imc_mem_info *pcmi;
> +	struct imc_pmu *pmu;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* Sampling not supported */
> +	if (event->hw.sample_period)
> +		return -EINVAL;
> +
> +	/* unsupported modes and filters */
> +	if (event->attr.exclude_user   ||
> +	    event->attr.exclude_kernel ||
> +	    event->attr.exclude_hv     ||
> +	    event->attr.exclude_idle   ||
> +	    event->attr.exclude_host   ||
> +	    event->attr.exclude_guest)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	event->hw.idx = -1;
> +	pmu = imc_event_to_pmu(event);
> +
> +	/* Sanity check for config (event offset and rvalue) */
> +	if (((config & IMC_EVENT_OFFSET_MASK) > pmu->counter_mem_size) ||
> +	    ((config & IMC_EVENT_RVALUE_MASK) != 0))
> +		return -EINVAL;
> +
> +	if (!is_core_imc_mem_inited(event->cpu))
> +		return -ENODEV;
> +
> +	core_id = event->cpu / threads_per_core;
> +	pcmi = &pmu->mem_info[core_id];
> +	if ((pcmi->id != core_id) || (!pcmi->vbase[0]))
> +		return -ENODEV;
> +
> +	event->hw.event_base = (u64)pcmi->vbase[0] + (config & IMC_EVENT_OFFSET_MASK);
> +	/*
> +	 * Core pmu units are enabled only when it is used.
> +	 * See if this is triggered for the first time.
> +	 * If yes, take the mutex lock and enable the core counters.
> +	 * If not, just increment the count in core_events.
> +	 */
> +	if (atomic_inc_return(&core_events[core_id]) == 1) {
> +		mutex_lock(&imc_core_reserve);
> +		rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE,
> +					     get_hard_smp_processor_id(event->cpu));
> +		mutex_unlock(&imc_core_reserve);

That machinery here is racy as hell in several aspects.

CPU0 	       	       	       	       CPU1

atomic_inc_ret(core_events[0]) -> 1

preemption()
			       	       atomic_inc_ret(core_events[0]) -> 2
				       return 0;
				       
				       Uses the event, without counters
				       being started until the preempted
				       task comes on the CPU again.

Here is another one:

CPU0 	       	       	       	       CPU1

atomic_dec_ret(core_events[0]) -> 0
				       atomic_inc_ret(core_events[1] -> 1
				       mutex_lock();
mutex_lock()			       start counter();
				       mutex_unlock()

stop_counter();
mutex_unlock();
				       Yay, another stale event!

Brilliant stuff that, or maybe not so much.

> +		if (rc) {
> +			atomic_dec_return(&core_events[core_id]);

What's the point of using atomic_dec_return here if you ignore the return
value? Not that it matters much as the whole logic is crap anyway.

> +			pr_err("IMC: Unable to start the counters for core %d\n", core_id);
> +			return -ENODEV;
> +		}
> +	}
> @@ -410,22 +658,38 @@ int init_imc_pmu(struct imc_events *events, int idx,
>  		 struct imc_pmu *pmu_ptr)
>  {
>  	int ret = -ENODEV;
> +

Sure ret needs to stay initialized, just in case imc_mem_init() does not
return anything magically, right?

> +	ret = imc_mem_init(pmu_ptr);
> +	if (ret)
> +		goto err_free;
>  	/* Add cpumask and register for hotplug notification */
> -	if (atomic_inc_return(&nest_pmus) == 1) {
> -		/*
> -		 * Nest imc pmu need only one cpu per chip, we initialize the
> -		 * cpumask for the first nest imc pmu and use the same for the rest.
> -		 * To handle the cpuhotplug callback unregister, we track
> -		 * the number of nest pmus registers in "nest_pmus".
> -		 * "nest_imc_cpumask_initialized" is set to zero during cpuhotplug
> -		 * callback unregister.
> -		 */
> -		ret = nest_pmu_cpumask_init();
> +	switch (pmu_ptr->domain) {
> +	case IMC_DOMAIN_NEST:
> +		if (atomic_inc_return(&nest_pmus) == 1) {
> +			/*
> +			 * Nest imc pmu need only one cpu per chip, we initialize
> +			 * the cpumask for the first nest imc pmu and use the
> +			 * same for the rest.
> +			 * To handle the cpuhotplug callback unregister, we track
> +			 * the number of nest pmus registers in "nest_pmus".
> +			 * "nest_imc_cpumask_initialized" is set to zero during
> +			 * cpuhotplug callback unregister.
> +			 */
> +			ret = nest_pmu_cpumask_init();
> +			if (ret)
> +				goto err_free;
> +			mutex_lock(&imc_nest_inited_reserve);
> +			nest_imc_cpumask_initialized = 1;
> +			mutex_unlock(&imc_nest_inited_reserve);
> +		}
> +		break;
> +	case IMC_DOMAIN_CORE:
> +		ret = core_imc_pmu_cpumask_init();
>  		if (ret)
> -			goto err_free;
> -		mutex_lock(&imc_nest_inited_reserve);
> -		nest_imc_cpumask_initialized = 1;
> -		mutex_unlock(&imc_nest_inited_reserve);
> +			return ret;

Oh, so now you replaced the goto with ret. What is actually taking care of
the cleanup if that fails?

> +		break;
> +	default:
> +		return -1;	/* Unknown domain */
>  	}
>  	ret = update_events_in_group(events, idx, pmu_ptr);
>  	if (ret)
> @@ -459,5 +723,10 @@ int init_imc_pmu(struct imc_events *events, int idx,
>  			mutex_unlock(&imc_nest_inited_reserve);
>  		}
>  	}
> +	/* For core_imc, we have allocated memory, we need to free it */
> +	if (pmu_ptr->domain == IMC_DOMAIN_CORE) {
> +		cleanup_all_core_imc_memory(pmu_ptr);
> +		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE);

Cute. You cleanuo the memory stuff and then you let the hotplug core invoke
the offline callbacks which then deal with freed memory. 

Thanks,

	tglx
