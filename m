Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjHZX6HB1zDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:45:08 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v575iIEt153577
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 01:45:06 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2awy7mm13t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Jun 2017 01:45:05 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 6 Jun 2017 23:45:05 -0600
Subject: Re: [PATCH v9 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
 <1496665922-702-2-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706061135490.1885@nanos>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Wed, 7 Jun 2017 11:14:49 +0530
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706061135490.1885@nanos>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <692e037d-5367-208f-ac6f-8fd43e1643ba@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

On Tuesday 06 June 2017 03:39 PM, Thomas Gleixner wrote:
> On Mon, 5 Jun 2017, Anju T Sudhakar wrote:
>> +static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
>> +{
>> +	struct imc_mem_info *ptr = pmu_ptr->mem_info;
>> +
>> +	if (!ptr)
>> +		return;
> That's pointless.

No, it is not.  We may end up here from imc_mem_init() when the memory 
allocation for
pmu_ptr->mem_info fails. So in that case we can just return from here, 
and kfree wont be
called with a NULL pointer.

>> +	for (; ptr; ptr++) {
>    	for (ptr = pmu_ptr->mem_info; ptr; ptr++) {
>
> will do the right thing.
>
>> +		if (ptr->vbase[0] != 0)
>> +			free_pages(ptr->vbase[0], 0);
>> +	}
> and kfree can be called with a NULL pointer.
>
>> +	kfree(pmu_ptr->mem_info);
>> +}
>> +
>> +/* Enabling of Core Engine needs a scom operation */
>> +static void core_imc_control_enable(int *cpu_opal_rc)
>> +{
>> +	int rc;
>> +
>> +	rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE);
>> +	if (rc)
>> +		cpu_opal_rc[smp_processor_id()] = 1;
>> +}
>> +
>> +/*
>> + * Disabling of IMC Core Engine needs a scom operation
>> + */
>> +static void core_imc_control_disable(int *cpu_opal_rc)
>> +{
>> +	int rc;
>> +
>> +	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE);
>> +	if (rc)
>> +		cpu_opal_rc[smp_processor_id()] = 1;
>> +}
>> +
>> +int core_imc_control(int operation)
>> +{
>> +	int cpu, *cpus_opal_rc;
>> +
>> +	/* Memory for OPAL call return value. */
>> +	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
>> +	if (!cpus_opal_rc)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Enable or disable the core IMC PMU on each core using the
>> +	 * core_imc_cpumask.
>> +	 */
>> +	switch (operation) {
>> +
>> +	case IMC_COUNTER_DISABLE:
>> +		on_each_cpu_mask(&core_imc_cpumask,
>> +				(smp_call_func_t)core_imc_control_disable,
>> +				cpus_opal_rc, 1);
>> +		break;
>> +	case IMC_COUNTER_ENABLE:
>> +		on_each_cpu_mask(&core_imc_cpumask,
>> +				(smp_call_func_t)core_imc_control_enable,
>> +				cpus_opal_rc, 1);
>> +		break;
>> +	default:
>> +		goto fail;
>> +	}
>> +	/* Check return value array for any OPAL call failure */
>> +	for_each_cpu(cpu, &core_imc_cpumask) {
>> +		if (cpus_opal_rc[cpu])
>> +			goto fail;
>> +	}
>> +	return 0;
>> +fail:
>> +	if (cpus_opal_rc)
>> +		kfree(cpus_opal_rc);
>> +		return -EINVAL;
>> +}
> Interesting. You copied the other function and then implemented it
> differently.
>
> But, what's worse is that this is just duplicated code for no value. Both
> the nest and core control functions call
>
>      opal_imc_counters_xxxx(WHICH_COUNTER);
>
> So the obvious thing to do is:
>
> static struct cpumask imc_result_mask;
> static DEFINE_MUTEX(imc_control_mutex);
>
> static void opal_imc_XXX(void *which)
> {
> 	if (opal_imc_counters_XXX((unsigned long) which))
> 		cpumask_set_cpu(smp_processor_id(), &imc_result_mask);
> }
>
> static int imc_control(unsigned long which, bool start)
> {
> 	smp_call_func_t *fn;
> 	int res;
>
> 	mutex_lock(&imc_control_mutex);
> 	memset(&imc_result_mask, 0, sizeof(imc_result_mask));
> 	
> 	switch (which) {
> 	case OPAL_IMC_COUNTERS_CORE:
> 	case OPAL_IMC_COUNTERS_NEST:
> 		break;
> 	default:
> 		res = -EINVAL;
> 		goto out;
> 	}
>
> 	fn = start ? opal_imc_start : opal_imc_stop;
>
> 	on_each_cpu_mask(&core_imc_cpumask, fn, (void *) which, 1);
>
> 	res = cpumask_empty(&nest_imc_result) ? 0 : -ENODEV;
> out:
> 	mutex_unlock(&imc_control_mutex);
> 	return res;
>
> That would allow sharing of too much code, right?

Yes. This looks really good. Thanks!
I will rework the code.

>> +/*
>> + * core_imc_mem_init : Initializes memory for the current core.
>> + *
>> + * Uses alloc_pages_exact_nid() and uses the returned address as an argument to
>> + * an opal call to configure the pdbar. The address sent as an argument is
>> + * converted to physical address before the opal call is made. This is the
>> + * base address at which the core imc counters are populated.
>> + */
>> +static int  __meminit core_imc_mem_init(int cpu, int size)
>> +{
>> +	int phys_id, rc = 0, core_id = (cpu / threads_per_core);
>> +	struct imc_mem_info *mem_info = NULL;
> What's that NULL initialization for?
>
>> +
>> +	phys_id = topology_physical_package_id(cpu);
>> +	/*
>> +	 * alloc_pages_exact_nid() will allocate memory for core in the
>> +	 * local node only.
>> +	 */
>> +	mem_info = &core_imc_pmu->mem_info[core_id];
>> +	mem_info->id = core_id;
>> +	mem_info->vbase[0] = (u64) alloc_pages_exact_nid(phys_id,
>> +				(size_t)size, GFP_KERNEL | __GFP_ZERO);
> That allocation is guaranteed not to fail?

Nice catch. We need a check here. Will fix this.


Thanks and Regards,

Anju
