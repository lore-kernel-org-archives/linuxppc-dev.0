Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs9Pb2nPpzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 21:34:27 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2RAY7iN096274
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 06:34:18 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29dher6dx1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 06:34:18 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 27 Mar 2017 06:34:16 -0400
Subject: Re: [PATCH v5 06/13] powerpc/perf: IMC pmu cpumask and cpu hotplug
 support
To: ego@linux.vnet.ibm.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1489649707-8021-7-git-send-email-maddy@linux.vnet.ibm.com>
 <20170323115237.GA4897@in.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Mon, 27 Mar 2017 16:04:01 +0530
MIME-Version: 1.0
In-Reply-To: <20170323115237.GA4897@in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6f6064cd-a5ec-eb3e-fcce-494d952556e0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gautham,


Thank you for reviewing the patch.


On Thursday 23 March 2017 05:22 PM, Gautham R Shenoy wrote:
> Hi Hemant, Maddy,
>
> On Thu, Mar 16, 2017 at 01:05:00PM +0530, Madhavan Srinivasan wrote:
>> From: Hemant Kumar <hemant@linux.vnet.ibm.com>
>>
>> Adds cpumask attribute to be used by each IMC pmu. Only one cpu (any
>> online CPU) from each chip for nest PMUs is designated to read counters.
>>
>> On CPU hotplug, dying CPU is checked to see whether it is one of the
>> designated cpus, if yes, next online cpu from the same chip (for nest
>> units) is designated as new cpu to read counters. For this purpose, we
>> introduce a new state : CPUHP_AP_PERF_POWERPC_NEST_ONLINE.
>>
>> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Anton Blanchard <anton@samba.org>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Cc: Michael Neuling <mikey@neuling.org>
>> Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
>> Cc: Daniel Axtens <dja@axtens.net>
>> Cc: Stephane Eranian <eranian@google.com>
>> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/opal-api.h            |   3 +-
>>   arch/powerpc/include/asm/opal.h                |   3 +
>>   arch/powerpc/perf/imc-pmu.c                    | 163 ++++++++++++++++++++++++-
>>   arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
>>   include/linux/cpuhotplug.h                     |   1 +
>>   5 files changed, 169 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index a0aa285869b5..e1c3d4837857 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -168,7 +168,8 @@
>>   #define OPAL_INT_SET_MFRR			125
>>   #define OPAL_PCI_TCE_KILL			126
>>   #define OPAL_NMMU_SET_PTCR			127
>> -#define OPAL_LAST				127
>> +#define OPAL_NEST_IMC_COUNTERS_CONTROL		145
>> +#define OPAL_LAST				145
>>
>>   /* Device tree flags */
>>
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index 1ff03a6da76e..d93d08204243 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -227,6 +227,9 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
>>   			  uint64_t dma_addr, uint32_t npages);
>>   int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
>>
>> +int64_t opal_nest_imc_counters_control(uint64_t mode, uint64_t value1,
>> +				uint64_t value2, uint64_t value3);
>> +
>>   /* Internal functions */
>>   extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>>   				   int depth, void *data);
>> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
>> index f6f1ef9f56af..e46ff6d2a584 100644
>> --- a/arch/powerpc/perf/imc-pmu.c
>> +++ b/arch/powerpc/perf/imc-pmu.c
>> @@ -16,6 +16,7 @@
>> +static int ppc_nest_imc_cpu_online(unsigned int cpu)
>> +{
> I take it that 'cpu' is coming online.
>
>> +	int nid, fcpu, ncpu;
>> +	struct cpumask *l_cpumask, tmp_mask;
>> +
>> +	/* Fint the cpumask of this node */
>> +	nid = cpu_to_node(cpu);
>> +	l_cpumask = cpumask_of_node(nid);
>> +
>> +	/*
>> +	 * If any of the cpu from this node is already present in the mask,
>> +	 * just return, if not, then set this cpu in the mask.
>> +	 */
>> +	if (!cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask)) {
> In this case, none of the cpus in the node are in the mask. So we set
> and this cpu in the imc cpumask and return.
>
>> +		cpumask_set_cpu(cpu, &nest_imc_cpumask);
>> +		return 0;
>> +	}
> But this case implies that there is already a CPU from the node which
> is in the imc_cpumask. As per the comment above, we are supposed to
> just return. So why are we doing the following ?
>
> Either the comment above is incorrect or I am missing something here.
>
>> +
>> +	fcpu = cpumask_first(l_cpumask);
>> +	ncpu = cpumask_next(cpu, l_cpumask);
>> +	if (cpu == fcpu) {
>> +		if (cpumask_test_and_clear_cpu(ncpu, &nest_imc_cpumask)) {
>> +			cpumask_set_cpu(cpu, &nest_imc_cpumask);
>> +			nest_change_cpu_context(ncpu, cpu);
>> +		}
>> +	}
> It seems that we want to set only the smallest online cpu in the node
> in the nest_imc_cpumask. So, if the newly onlined cpu is the smallest,
> we replace the previous representative with cpu.

Yes. you are right. Here we are designating the smallest online cpu in 
the node in the
nest_imc_mask. The comment above is only for the 'if' code block.


> So, the comment above needs to be fixed.

Will update the comment to avoid confusion. :-)


Thanks,

Anju
>> +
>> +	return 0;
>> +}
>> +
>> +static int ppc_nest_imc_cpu_offline(unsigned int cpu)
>> +{
>> +	int nid, target = -1;
>> +	struct cpumask *l_cpumask;
>> +
>> +	/*
>> +	 * Check in the designated list for this cpu. Dont bother
>> +	 * if not one of them.
>> +	 */
>> +	if (!cpumask_test_and_clear_cpu(cpu, &nest_imc_cpumask))
>> +		return 0;
>> +
>> +	/*
>> +	 * Now that this cpu is one of the designated,
>> +	 * find a next cpu a) which is online and b) in same chip.
>> +	 */
>> +	nid = cpu_to_node(cpu);
>> +	l_cpumask = cpumask_of_node(nid);
>> +	target = cpumask_next(cpu, l_cpumask);
>> +
>> +	/*
>> +	 * Update the cpumask with the target cpu and
>> +	 * migrate the context if needed
>> +	 */
>> +	if (target >= 0 && target <= nr_cpu_ids) {
>> +		cpumask_set_cpu(target, &nest_imc_cpumask);
>> +		nest_change_cpu_context(cpu, target);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int nest_pmu_cpumask_init(void)
>> +{
>> +	const struct cpumask *l_cpumask;
>> +	int cpu, nid;
>> +	int *cpus_opal_rc;
>> +
>> +	if (!cpumask_empty(&nest_imc_cpumask))
>> +		return 0;
>> +
> 	
>> +	/*
>> +	 * Nest PMUs are per-chip counters. So designate a cpu
>> +	 * from each chip for counter collection.
>> +	 */
>> +	for_each_online_node(nid) {
>> +		l_cpumask = cpumask_of_node(nid);
>> +
>> +		/* designate first online cpu in this node */
>> +		cpu = cpumask_first(l_cpumask);
>> +		cpumask_set_cpu(cpu, &nest_imc_cpumask);
>> +	}
>> +
>
> What happens if a cpu in nest_imc_cpumask goes offline at this point ?
>
> Is that possible ?
>
>> +	/*
>> +	 * Memory for OPAL call return value.
>> +	 */
>> +	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
>> +	if (!cpus_opal_rc)
>> +		goto fail;
>> +
>> +	/* Initialize Nest PMUs in each node using designated cpus */
>> +	on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_init,
>> +						(void *)cpus_opal_rc, 1);
>> +
>> +	/* Check return value array for any OPAL call failure */
>> +	for_each_cpu(cpu, &nest_imc_cpumask) {
>> +		if (cpus_opal_rc[cpu])
>> +			goto fail;
>> +	}
>> +
>> +	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
>> +			  "POWER_NEST_IMC_ONLINE",
>> +			  ppc_nest_imc_cpu_online,
>> +			  ppc_nest_imc_cpu_offline);
>> +
>> +	return 0;
>> +
>> +fail:
>> +	return -ENODEV;
>> +}
>> +
>>   static int nest_imc_event_init(struct perf_event *event)
>>   {
>>   	int chip_id;
>> @@ -63,7 +218,7 @@ static int nest_imc_event_init(struct perf_event *event)
>>   	chip_id = topology_physical_package_id(event->cpu);
>>   	pcni = &nest_perchip_info[chip_id];
>>   	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] +
>> -							(config & ~PAGE_MASK);
>> +		(config & ~PAGE_MASK);
>>
>>   	return 0;
>>   }
>> @@ -122,6 +277,7 @@ static int update_pmu_ops(struct imc_pmu *pmu)
>>   	pmu->pmu.stop = imc_event_stop;
>>   	pmu->pmu.read = imc_perf_event_update;
>>   	pmu->attr_groups[1] = &imc_format_group;
>> +	pmu->attr_groups[2] = &imc_pmu_cpumask_attr_group;
>>   	pmu->pmu.attr_groups = pmu->attr_groups;
>>
>>   	return 0;
>> @@ -189,6 +345,11 @@ int init_imc_pmu(struct imc_events *events, int idx,
>>   {
>>   	int ret = -ENODEV;
>>
>> +	/* Add cpumask and register for hotplug notification */
>> +	ret = nest_pmu_cpumask_init();
>> +	if (ret)
>> +		return ret;
>> +
>>   	ret = update_events_in_group(events, idx, pmu_ptr);
>>   	if (ret)
>>   		goto err_free;
>> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> index da8a0f7a035c..b7208d8e6cc0 100644
>> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
>> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
>> @@ -301,3 +301,4 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
>>   OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
>>   OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
>>   OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
>> +OPAL_CALL(opal_nest_imc_counters_control,	OPAL_NEST_IMC_COUNTERS_CONTROL);
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 62d240e962f0..cfb0cedc72af 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -136,6 +136,7 @@ enum cpuhp_state {
>>   	CPUHP_AP_PERF_ARM_CCI_ONLINE,
>>   	CPUHP_AP_PERF_ARM_CCN_ONLINE,
>>   	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>> +	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
>>   	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>>   	CPUHP_AP_WORKQUEUE_ONLINE,
>>   	CPUHP_AP_RCUTREE_ONLINE,
>> -- 
>> 2.7.4
>>
