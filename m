Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whnTb6X4mzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 20:09:07 +1000 (AEST)
Date: Tue, 6 Jun 2017 12:09:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v9 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
In-Reply-To: <1496665922-702-2-git-send-email-anju@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706061135490.1885@nanos>
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
 <1496665922-702-2-git-send-email-anju@linux.vnet.ibm.com>
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

On Mon, 5 Jun 2017, Anju T Sudhakar wrote:
> +static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
> +{
> +	struct imc_mem_info *ptr = pmu_ptr->mem_info;
> +
> +	if (!ptr)
> +		return;

That's pointless.

> +	for (; ptr; ptr++) {

  	for (ptr = pmu_ptr->mem_info; ptr; ptr++) {

will do the right thing.

> +		if (ptr->vbase[0] != 0)
> +			free_pages(ptr->vbase[0], 0);
> +	}

and kfree can be called with a NULL pointer.

> +	kfree(pmu_ptr->mem_info);
> +}
> +
> +/* Enabling of Core Engine needs a scom operation */
> +static void core_imc_control_enable(int *cpu_opal_rc)
> +{
> +	int rc;
> +
> +	rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE);
> +	if (rc)
> +		cpu_opal_rc[smp_processor_id()] = 1;
> +}
> +
> +/*
> + * Disabling of IMC Core Engine needs a scom operation
> + */
> +static void core_imc_control_disable(int *cpu_opal_rc)
> +{
> +	int rc;
> +
> +	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
> +	if (rc)
> +		cpu_opal_rc[smp_processor_id()] = 1;
> +}
> +
> +int core_imc_control(int operation)
> +{
> +	int cpu, *cpus_opal_rc;
> +
> +	/* Memory for OPAL call return value. */
> +	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
> +	if (!cpus_opal_rc)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Enable or disable the core IMC PMU on each core using the
> +	 * core_imc_cpumask.
> +	 */
> +	switch (operation) {
> +
> +	case IMC_COUNTER_DISABLE:
> +		on_each_cpu_mask(&core_imc_cpumask,
> +				(smp_call_func_t)core_imc_control_disable,
> +				cpus_opal_rc, 1);
> +		break;
> +	case IMC_COUNTER_ENABLE:
> +		on_each_cpu_mask(&core_imc_cpumask,
> +				(smp_call_func_t)core_imc_control_enable,
> +				cpus_opal_rc, 1);
> +		break;
> +	default:
> +		goto fail;
> +	}
> +	/* Check return value array for any OPAL call failure */
> +	for_each_cpu(cpu, &core_imc_cpumask) {
> +		if (cpus_opal_rc[cpu])
> +			goto fail;
> +	}
> +	return 0;
> +fail:
> +	if (cpus_opal_rc)
> +		kfree(cpus_opal_rc);
> +		return -EINVAL;
> +}

Interesting. You copied the other function and then implemented it
differently.

But, what's worse is that this is just duplicated code for no value. Both
the nest and core control functions call

    opal_imc_counters_xxxx(WHICH_COUNTER);

So the obvious thing to do is:

static struct cpumask imc_result_mask;
static DEFINE_MUTEX(imc_control_mutex);

static void opal_imc_XXX(void *which)
{
	if (opal_imc_counters_XXX((unsigned long) which))
		cpumask_set_cpu(smp_processor_id(), &imc_result_mask);
}

static int imc_control(unsigned long which, bool start)
{
	smp_call_func_t *fn;
	int res;

	mutex_lock(&imc_control_mutex);
	memset(&imc_result_mask, 0, sizeof(imc_result_mask));
	
	switch (which) {
	case OPAL_IMC_COUNTERS_CORE:
	case OPAL_IMC_COUNTERS_NEST:
		break;
	default:
		res = -EINVAL;
		goto out;
	}

	fn = start ? opal_imc_start : opal_imc_stop;

	on_each_cpu_mask(&core_imc_cpumask, fn, (void *) which, 1);

	res = cpumask_empty(&nest_imc_result) ? 0 : -ENODEV;
out:
	mutex_unlock(&imc_control_mutex);
	return res;

That would allow sharing of too much code, right?

> +/*
> + * core_imc_mem_init : Initializes memory for the current core.
> + *
> + * Uses alloc_pages_exact_nid() and uses the returned address as an argument to
> + * an opal call to configure the pdbar. The address sent as an argument is
> + * converted to physical address before the opal call is made. This is the
> + * base address at which the core imc counters are populated.
> + */
> +static int  __meminit core_imc_mem_init(int cpu, int size)
> +{
> +	int phys_id, rc = 0, core_id = (cpu / threads_per_core);
> +	struct imc_mem_info *mem_info = NULL;

What's that NULL initialization for?

> +
> +	phys_id = topology_physical_package_id(cpu);
> +	/*
> +	 * alloc_pages_exact_nid() will allocate memory for core in the
> +	 * local node only.
> +	 */
> +	mem_info = &core_imc_pmu->mem_info[core_id];
> +	mem_info->id = core_id;
> +	mem_info->vbase[0] = (u64) alloc_pages_exact_nid(phys_id,
> +				(size_t)size, GFP_KERNEL | __GFP_ZERO);

That allocation is guaranteed not to fail?

> +	rc = opal_imc_counters_init(OPAL_IMC_COUNTERS_CORE,
> +				(u64)virt_to_phys((void *)mem_info->vbase[0]),
> +				get_hard_smp_processor_id(cpu));
> +	if (rc) {
> +		kfree(&mem_info->vbase[0]);

Freeing memory allocated with alloc_pages_exact_nid() via kfree() is an
interesting approach.

> +		mem_info->vbase[0] = 0;

   		mem_info->vbase[0] = NULL;
  
> +	}
> +	return rc;
> +}
> +
> +bool is_core_imc_mem_inited(int cpu)
> +{
> +	struct imc_mem_info *mem_info = NULL;
> +	int core_id = (cpu / threads_per_core);
> +
> +	mem_info = &core_imc_pmu->mem_info[core_id];
> +	if ((mem_info->id == core_id) && (mem_info->vbase[0] != 0))

  != NULL

> +		return true;
> +	return false;
> +}
> +
> +/*
> + * imc_mem_init : Function to support memory allocation for core imc.
> + */
> +static int imc_mem_init(struct imc_pmu *pmu_ptr)
> +{
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
> +
> +static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
> +{
> +	if (!core_imc_pmu)
> +		return;

Why is that called if core_imc_pmu == NULL?

> +	if (old_cpu < 0 || new_cpu < 0)
> +		return;

And again, like in the previous one. Why is that called at all if any of
those is < 0?

> +	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
> +}

> +static int ppc_core_imc_cpu_online(unsigned int cpu)
> +{
> +	const struct cpumask *l_cpumask;
> +	static struct cpumask tmp_mask;
> +	int ret = 0;
> +
> +	/* Get the cpumask for this core */
> +	l_cpumask = cpu_sibling_mask(cpu);
> +
> +	/* If a cpu for this core is already set, then, don't do anything */
> +	if (cpumask_and(&tmp_mask, l_cpumask, &core_imc_cpumask))
> +		return 0;
> +
> +	if (!is_core_imc_mem_inited(cpu)) {
> +		ret = core_imc_mem_init(cpu, core_imc_pmu->counter_mem_size);
> +		if (ret) {
> +			pr_info("core_imc memory allocation for cpu %d failed\n", cpu);
> +			return ret;
> +		}
> +	} else
> +		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);

The else clause wants to have curly brackets as well.

> +
> +	/* set the cpu in the mask, and change the context */
> +	cpumask_set_cpu(cpu, &core_imc_cpumask);
> +	core_imc_change_cpu_context(-1, cpu);

Sigh

> +	return 0;
> +}
> +
> +static int ppc_core_imc_cpu_offline(unsigned int cpu)
> +{
> +	int target;
> +	unsigned int ncpu;
> +
> +	/*
> +	 * clear this cpu out of the mask, if not present in the mask,
> +	 * don't bother doing anything.
> +	 */
> +	if (!cpumask_test_and_clear_cpu(cpu, &core_imc_cpumask))
> +		return 0;
> +
> +	/* Find any online cpu in that core except the current "cpu" */
> +	ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
> +
> +	if (ncpu >= 0 && ncpu < nr_cpu_ids) {
> +		target = ncpu;
> +		cpumask_set_cpu(target, &core_imc_cpumask);
> +	} else {
> +		opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
> +		target = -1;
> +	}
> +
> +	/* migrate the context */
> +	core_imc_change_cpu_context(cpu, target);

It's really weird that more or less identical functions (aside of the mask
and the counter) are implemented differently. In this version you use
cpumask_any_but() correctly.

> +
> +	return 0;
> +}

> +static int core_imc_event_init(struct perf_event *event)
> +{

...

> +	/*
> +	 * Core pmu units are enabled only when it is used.
> +	 * See if this is triggered for the first time.
> +	 * If yes, take the mutex lock and enable the core counters.
> +	 * If not, just increment the count in core_events.
> +	 */
> +	if (atomic_inc_return(&core_events) == 1) {
> +		mutex_lock(&imc_core_reserve);
> +		rc = core_imc_control(IMC_COUNTER_ENABLE);
> +		mutex_unlock(&imc_core_reserve);
> +		if (rc)
> +			pr_err("IMC: Unable to start the counters\n");
> +	}
> +	event->destroy = core_imc_counters_release;
> +	return 0;

That's at least consistently returning success even if the counter start
failed.

Thanks,

	tglx
