Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whlTs3VpxzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 18:39:13 +1000 (AEST)
Date: Tue, 6 Jun 2017 10:39:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v9 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
In-Reply-To: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706061016110.1885@nanos>
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
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
> +/*
> + * nest_imc_stop : Does OPAL call to stop nest engine.
> + */
> +static void nest_imc_stop(int *cpu_opal_rc)
> +{
> +	int rc;
> +
> +	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
> +	if (rc)
> +		cpu_opal_rc[smp_processor_id()] = 1;

What's wrong with just assigning the result directly?

> +/* nest_imc_start: Does the OPAL call to enable nest counters. */
> +static void nest_imc_start(int *cpu_opal_rc)
> +{
> +	int rc;
> +
> +	rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_NEST);
> +	if (rc)
> +		cpu_opal_rc[smp_processor_id()] = 1;
> +}
> +
> +/*
> + * nest_imc_control: Function to start and stop nest imc engine.
> + *		     The function is primarily called from event init
> + * 		     and event destroy.

As I don't see other call sites, what's the secondary usage?

> + */
> +static int nest_imc_control(int operation)
> +{
> +	int *cpus_opal_rc, cpu;
> +
> +	/*
> +	 * Memory for OPAL call return value.
> +	 */
> +	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
> +	if (!cpus_opal_rc)
> +		return -ENOMEM;
> +	switch (operation) {
> +	case IMC_COUNTER_ENABLE:
> +			/* Initialize Nest PMUs in each node using designated cpus */
> +			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_imc_start,
> +						cpus_opal_rc, 1);

That's one indentation level too deep. 

> +			break;
> +	case IMC_COUNTER_DISABLE:
> +			/* Disable the counters */
> +			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_imc_stop,
> +						cpus_opal_rc, 1);
> +			break;
> +	default:
> +		kfree(cpus_opal_rc);
> +		return -EINVAL;
> +
> +	}
> +
> +	/* Check return value array for any OPAL call failure */
> +	for_each_cpu(cpu, &nest_imc_cpumask) {
> +		if (cpus_opal_rc[cpu]) {
> +			kfree(cpus_opal_rc);
> +			return -ENODEV;
> +		}
> +	}
> +	kfree(cpus_opal_rc);

So you have THREE places where you do kfree(cpus_opal_rc). Sigh.

You can spare that hole alloc/free dance by simply having

static struct cpumask nest_imc_result;

	mutex_lock(&imc_nest_reserve);
	memset(&nest_imc_result, 0, sizeof(nest_imc_result));

	switch (op) {
	case IMC_COUNTER_ENABLE:
		on_each_cpu_mask(&nest_imc_cpumask, nest_imc_start, NULL, 1);
		break;
	....
	}

	res = cpumask_empty(&nest_imc_result) ? 0 : -ENODEV;
	mutex_unlock(&imc_nest_reserve);
	return res;

And in the start/stop functions:

	if (opal_imc_counters_xxx(OPAL_IMC_COUNTERS_NEST))
		cpumask_set_cpu(smp_processor_id(), &nest_imc_result);

> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
> +{
> +	struct imc_pmu **pn = per_nest_pmu_arr;
> +	int i;
> +
> +	if (old_cpu < 0 || new_cpu < 0)
> +		return;
> +
> +	for (i = 0; *pn && i < IMC_MAX_PMUS; i++, pn++)
> +		perf_pmu_migrate_context(&(*pn)->pmu, old_cpu, new_cpu);
> +
> +}
> +
> +static int ppc_nest_imc_cpu_offline(unsigned int cpu)
> +{
> +	int nid, target = -1;
> +	const struct cpumask *l_cpumask;
> +
> +	/*
> +	 * Check in the designated list for this cpu. Dont bother
> +	 * if not one of them.
> +	 */
> +	if (!cpumask_test_and_clear_cpu(cpu, &nest_imc_cpumask))
> +		return 0;
> +
> +	/*
> +	 * Now that this cpu is one of the designated,
> +	 * find a next cpu a) which is online and b) in same chip.
> +	 */
> +	nid = cpu_to_node(cpu);
> +	l_cpumask = cpumask_of_node(nid);
> +	target = cpumask_next(cpu, l_cpumask);

So if the outgoing CPU is the highest numbered CPU on the node, then
cpumask_next() will not find a CPU, while there still might be other lower
numbered CPUs online in the node.

	target = cpumask_any_but(l_cpumask, cpu);

is what you want.

> +
> +	/*
> +	 * Update the cpumask with the target cpu and
> +	 * migrate the context if needed
> +	 */
> +	if (target >= 0 && target < nr_cpu_ids) {
> +		cpumask_set_cpu(target, &nest_imc_cpumask);
> +		nest_change_cpu_context(cpu, target);
> +	} else {
> +		target = -1;
> +		opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
> +		nest_change_cpu_context(cpu, target);

Why are you calling nest_change_cpu_context()? You already know that it
will return immediately due to target < 0.

> +	}
> +	return 0;
> +}
> +
> +static int ppc_nest_imc_cpu_online(unsigned int cpu)
> +{
> +	const struct cpumask *l_cpumask;
> +	static struct cpumask tmp_mask;
> +	int res;
> +
> +	/* Get the cpumask of this node */
> +	l_cpumask = cpumask_of_node(cpu_to_node(cpu));
> +
> +	/*
> +	 * If this is not the first online CPU on this node, then
> +	 * just return.
> +	 */
> +	if (cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask))
> +		return 0;
> +
> +	/*
> +	 * If this is the first online cpu on this node
> +	 * disable the nest counters by making an OPAL call.
> +	 */
> +	res = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
> +	if (res)
> +		return res;
> +
> +	/* Make this CPU the designated target for counter collection */
> +	cpumask_set_cpu(cpu, &nest_imc_cpumask);
> +	nest_change_cpu_context(-1, cpu);

Ditto

>  static int nest_imc_event_init(struct perf_event *event)
>  {
> -	int chip_id;
> +	int chip_id, rc;
>  	u32 config = event->attr.config;
>  	struct imc_mem_info *pcni;
>  	struct imc_pmu *pmu;
> @@ -80,6 +277,20 @@ static int nest_imc_event_init(struct perf_event *event)
>  	 * "chip_id" and add "config" to it".
>  	 */
>  	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] + (config & ~PAGE_MASK);
> +	/*
> +	 * Nest pmu units are enabled only when it is used.
> +	 * See if this is triggered for the first time.
> +	 * If yes, take the mutex lock and enable the nest counters.
> +	 * If not, just increment the count in nest_events.
> +	 */
> +	if (atomic_inc_return(&nest_events) == 1) {
> +		mutex_lock(&imc_nest_reserve);
> +		rc = nest_imc_control(IMC_COUNTER_ENABLE);
> +		mutex_unlock(&imc_nest_reserve);
> +		if (rc)
> +			pr_err("IMC: Unable to start the counters\n");

So if that fails, nest_events will stay incremented. Is that on purpose?

> +	}
> +	event->destroy = nest_imc_counters_release;
>  	return 0;

And this happily returns success even if the enable call failed ....

Thanks,

	tglx
