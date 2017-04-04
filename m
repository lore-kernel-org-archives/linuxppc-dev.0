Return-Path: <dja@axtens.net>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxx221GZ6zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 14:34:02 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so34446135pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 21:34:02 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, benh@kernel.crashing.org,
 paulus@samba.org, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 06/11] powerpc/perf: IMC pmu cpumask and cpu hotplug
 support
In-Reply-To: <1491231308-15282-7-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1491231308-15282-7-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 04 Apr 2017 14:33:56 +1000
Message-ID: <8760iklrkb.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> From: Hemant Kumar <hemant@linux.vnet.ibm.com>
>
> Adds cpumask attribute to be used by each IMC pmu. Only one cpu (any
> online CPU) from each chip for nest PMUs is designated to read counters.
>
> On CPU hotplug, dying CPU is checked to see whether it is one of the
> designated cpus, if yes, next online cpu from the same chip (for nest
> units) is designated as new cpu to read counters. For this purpose, we
> introduce a new state : CPUHP_AP_PERF_POWERPC_NEST_ONLINE.
>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h            |  13 ++-
>  arch/powerpc/include/asm/opal.h                |   3 +
>  arch/powerpc/perf/imc-pmu.c                    | 155 ++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>  include/linux/cpuhotplug.h                     |   1 +
>  5 files changed, 171 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index a0aa285869b5..23fc51e9d71d 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -168,7 +168,8 @@
>  #define OPAL_INT_SET_MFRR			125
>  #define OPAL_PCI_TCE_KILL			126
>  #define OPAL_NMMU_SET_PTCR			127
> -#define OPAL_LAST				127
> +#define OPAL_NEST_IMC_COUNTERS_CONTROL		149

A couple of things:

 - why is this 149 rather than 128?

 - CONTROL seems like it's inviting a very broad and under-specified
   API. I notice most of the other opal calls are reasonably narrow:
   often defining two calls for get/set rather than a single control
   call.

I don't have cycles to review the OPAL/skiboot side and I'm very much
open to being convinced here, I just want to avoid the situation where
we're passing around complicated data structures in a way that is
difficult to synchronise if we could avoid it.

> +#define OPAL_LAST				149
>  
>  /* Device tree flags */
>  
> @@ -928,6 +929,16 @@ enum {
>  	OPAL_PCI_TCE_KILL_ALL,
>  };
>  
> +/* Operation argument to OPAL_NEST_IMC_COUNTERS_CONTROL */
> +enum {
> +	OPAL_NEST_IMC_PRODUCTION_MODE = 1,
> +};
If there's only one mode, why do we need to specify it? As far as I can
tell no extra mode is added later in the series...

... looking at the opal-side patches, would it be better to just specify
the modes you intend to support in future here, and rely on opal
returning OPAL_PARAMETER when they're not supported?
> +
> +enum {
> +	OPAL_NEST_IMC_STOP,
> +	OPAL_NEST_IMC_START,
> +};
Again, would it be better to have a stop/start call rather than a
generic control call? 

Also, the enum values (STOP=0, START=1) seem to be switched vs OPAL,
where https://patchwork.ozlabs.org/patch/746292/ has STOP=1, START=0. Or
am I missing something?

> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __OPAL_API_H */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 1ff03a6da76e..d93d08204243 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -227,6 +227,9 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
>  			  uint64_t dma_addr, uint32_t npages);
>  int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
>  
> +int64_t opal_nest_imc_counters_control(uint64_t mode, uint64_t value1,
> +				uint64_t value2, uint64_t value3);
> +

This prototype does not make me feel better about the state of the API.

Looking at the opal side, I would be much more comfortable if you could
nail down what you intend to have these support now, even if OPAL bails
with OPAL_PARAMETER if they're specified.

Also I think u64 and u32 are preferred, although I see the rest of the
file uses the long form.

>  /* Internal functions */
>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>  				   int depth, void *data);
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index bd5bf66bd920..b28835b861b3 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -17,6 +17,7 @@
>  
>  struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>  struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
> +static cpumask_t nest_imc_cpumask;
>  
>  /* Needed for sanity check */
>  extern u64 nest_max_offset;
> @@ -32,6 +33,152 @@ static struct attribute_group imc_format_group = {
>  	.attrs = imc_format_attrs,
>  };
>  
> +/* Get the cpumask printed to a buffer "buf" */
> +static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	cpumask_t *active_mask;
> +
> +	active_mask = &nest_imc_cpumask;
> +	return cpumap_print_to_pagebuf(true, buf, active_mask);
> +}
> +
> +static DEVICE_ATTR(cpumask, S_IRUGO, imc_pmu_cpumask_get_attr, NULL);
> +
Out of curiosity, how do you know imc_pmu_cpumask_get_attr is called
with a large enough buffer? (How does cpumap_print_to_pagebuf know it's
not overrunning the buffer when it's not taking a length parameter? I
realise this is not your code but it's midly terrifying.)

> +static struct attribute *imc_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group imc_pmu_cpumask_attr_group = {
> +	.attrs = imc_pmu_cpumask_attrs,
> +};
> +
> +/*
> + * nest_init : Initializes the nest imc engine for the current chip.
> + */
> +static void nest_init(int *loc)
> +{
> +	int rc;
> +
> +	rc = opal_nest_imc_counters_control(OPAL_NEST_IMC_PRODUCTION_MODE,
> +					    OPAL_NEST_IMC_START, 0, 0);
So OPAL is supposed to figure out which CPU to start based on the CPU
that is currently running when you call into OPAL? I assume that's fine,
but you probably want to document that. (Perhaps on the OPAL side - I
spent a while looking for a parameter indicating the chip to work on!)

> +	if (rc)
> +		loc[smp_processor_id()] = 1;

loc is not a very helpful name here. Looking further down the patch it
seems you pass cpus_opal_rc in as a parameter; maybe something like
cpu_rcs or something?

> +}
> +
> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
> +{
> +	int i;
> +
> +	for (i = 0;
> +	     (per_nest_pmu_arr[i] != NULL) && (i < IMC_MAX_PMUS); i++)
> +		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
> +							old_cpu, new_cpu);
> +}

This may be an incredibly misinformed question, but if you have 2
sockets, will this migrate things from both nests onto one? (I'm happy
to take you on trust if you just want to say 'no' without a detailed
explanation.)

> +
> +static int ppc_nest_imc_cpu_online(unsigned int cpu)
> +{
> +	int nid;
> +	const struct cpumask *l_cpumask;
> +	struct cpumask tmp_mask;
> +
> +	/* Find the cpumask of this node */
> +	nid = cpu_to_node(cpu);
> +	l_cpumask = cpumask_of_node(nid);
> +
> +	/*
> +	 * If any of the cpu from this node is already present in the mask,
> +	 * just return, if not, then set this cpu in the mask.
> +	 */
> +	if (!cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask)) {
> +		cpumask_set_cpu(cpu, &nest_imc_cpumask);
> +		return 0;
> +	}
> +
> +	return 0;
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
> +
> +	/*
> +	 * Update the cpumask with the target cpu and
> +	 * migrate the context if needed
> +	 */
> +	if (target >= 0 && target < nr_cpu_ids) {
> +		cpumask_set_cpu(target, &nest_imc_cpumask);
> +		nest_change_cpu_context(cpu, target);
> +	}
> +	return 0;
> +}
> +
> +static int nest_pmu_cpumask_init(void)
> +{
> +	const struct cpumask *l_cpumask;
> +	int cpu, nid;
> +	int *cpus_opal_rc;
> +
> +	if (!cpumask_empty(&nest_imc_cpumask))
> +		return 0;
> +
> +	/*
> +	 * Memory for OPAL call return value.
> +	 */
> +	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
> +	if (!cpus_opal_rc)
> +		goto fail;
> +
> +	/*
> +	 * Nest PMUs are per-chip counters. So designate a cpu
> +	 * from each chip for counter collection.
> +	 */
> +	for_each_online_node(nid) {
> +		l_cpumask = cpumask_of_node(nid);
> +
> +		/* designate first online cpu in this node */
> +		cpu = cpumask_first(l_cpumask);
> +		cpumask_set_cpu(cpu, &nest_imc_cpumask);
> +	}
> +
> +	/* Initialize Nest PMUs in each node using designated cpus */
> +	on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_init,
> +						(void *)cpus_opal_rc, 1);
> +
> +	/* Check return value array for any OPAL call failure */
> +	for_each_cpu(cpu, &nest_imc_cpumask) {
> +		if (cpus_opal_rc[cpu])
> +			goto fail;
> +	}
> +
> +	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
> +			  "POWER_NEST_IMC_ONLINE",
> +			  ppc_nest_imc_cpu_online,
> +			  ppc_nest_imc_cpu_offline);
> +
Shouldn't you be freeing cpus_opal_rc here?
> +	return 0;
> +
> +fail:
Also, shouldn't you be freeing cpus_opal_rc here? (if allocated)

> +	return -ENODEV;
> +}
> +
>  static int nest_imc_event_init(struct perf_event *event)
>  {
>  	int chip_id;
> @@ -70,7 +217,7 @@ static int nest_imc_event_init(struct perf_event *event)
>  	 * and then add to it.
>  	 */
>  	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] +
> -							(config & ~PAGE_MASK);
> +		(config & ~PAGE_MASK);

This hunk should either be dropped or squashed.

>  
>  	return 0;
>  }
> @@ -139,6 +286,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
>  	pmu->pmu.stop = imc_event_stop;
>  	pmu->pmu.read = imc_perf_event_update;
>  	pmu->attr_groups[1] = &imc_format_group;
> +	pmu->attr_groups[2] = &imc_pmu_cpumask_attr_group;
>  	pmu->pmu.attr_groups = pmu->attr_groups;
>  
>  	return 0;
> @@ -206,6 +354,11 @@ int init_imc_pmu(struct imc_events *events, int idx,
>  {
>  	int ret = -ENODEV;
>  
> +	/* Add cpumask and register for hotplug notification */
> +	ret = nest_pmu_cpumask_init();
If cpumask_init() also registers for hotplug, perhaps it should have a
more inclusive name.

Or, maybe better to move hotplug setup out of cpumask_init.
> +	if (ret)
> +		return ret;
> +
>  	ret = update_events_in_group(events, idx, pmu_ptr);
>  	if (ret)
>  		goto err_free;
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index da8a0f7a035c..b7208d8e6cc0 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -301,3 +301,4 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
>  OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
>  OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
>  OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
> +OPAL_CALL(opal_nest_imc_counters_control,	OPAL_NEST_IMC_COUNTERS_CONTROL);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 62d240e962f0..cfb0cedc72af 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -136,6 +136,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_CCI_ONLINE,
>  	CPUHP_AP_PERF_ARM_CCN_ONLINE,
>  	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
> +	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
This powerpc enum is in the middle of a set of ARM ones. Should it be
after all the arm ones?

If it's an enum, hopefully order doesn't matter...

>  	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>  	CPUHP_AP_WORKQUEUE_ONLINE,
>  	CPUHP_AP_RCUTREE_ONLINE,
> --
> 2.7.4

Regards,
Daniel
