Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMbqz04sFzDqKF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 20:55:26 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v49AroAA105685
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 May 2017 06:55:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aavrtfave-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 May 2017 06:55:15 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 9 May 2017 06:55:14 -0400
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
To: Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <87shkfqvx6.fsf@possimpible.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Tue, 9 May 2017 16:24:59 +0530
MIME-Version: 1.0
In-Reply-To: <87shkfqvx6.fsf@possimpible.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c1090cbf-9b09-0a72-c925-44e394d1767e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,


On Monday 08 May 2017 07:42 PM, Daniel Axtens wrote:
> Hi all,
>
> I've had a look at the API as it was a big thing I didn't like in the
> earlier version.
>
> I am much happier with this one.
>
> Some comments:
>
>   - I'm no longer subscribed to skiboot but I've had a look at the
>     patches on that side:
>
>      * in patch 9 should opal_imc_counters_init return something other
>        than OPAL_SUCCESS in the case on invalid arguments? Maybe
>        OPAL_PARAMETER? (I think you fix this in a later patch anyway?)
>
>      * in start/stop, should there be some sort of write barrier to make
>        sure the cb->imc_chip_command actually gets written out to memory
>        at the time we expect?
>
> The rest of my comments are in line.
>
>> Adds cpumask attribute to be used by each IMC pmu. Only one cpu (any
>> online CPU) from each chip for nest PMUs is designated to read counters.
>>
>> On CPU hotplug, dying CPU is checked to see whether it is one of the
>> designated cpus, if yes, next online cpu from the same chip (for nest
>> units) is designated as new cpu to read counters. For this purpose, we
>> introduce a new state : CPUHP_AP_PERF_POWERPC_NEST_ONLINE.
>>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/imc-pmu.h             |   4 +
>>   arch/powerpc/include/asm/opal-api.h            |  12 +-
>>   arch/powerpc/include/asm/opal.h                |   4 +
>>   arch/powerpc/perf/imc-pmu.c                    | 248 ++++++++++++++++++++++++-
>>   arch/powerpc/platforms/powernv/opal-wrappers.S |   3 +
>>   include/linux/cpuhotplug.h                     |   1 +
> Who owns this? get_maintainer.pl doesn't give me anything helpful
> here... Do we need an Ack from anyone?
>
>>   6 files changed, 266 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
>> index 6bbe184..1478d0f 100644
>> --- a/arch/powerpc/include/asm/imc-pmu.h
>> +++ b/arch/powerpc/include/asm/imc-pmu.h
>> @@ -92,6 +92,10 @@ struct imc_pmu {
>>   #define IMC_DOMAIN_NEST		1
>>   #define IMC_DOMAIN_UNKNOWN	-1
>>   
>> +#define IMC_COUNTER_ENABLE	1
>> +#define IMC_COUNTER_DISABLE	0
> I'm not sure these constants are particularly useful any more, but I'll
> have more to say on that later.
>
>> +
>> +
>>   extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>>   extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
>>   extern int __init init_imc_pmu(struct imc_events *events,int idx, struct imc_pmu *pmu_ptr);
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index a0aa285..ce863d9 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -168,7 +168,10 @@
>>   #define OPAL_INT_SET_MFRR			125
>>   #define OPAL_PCI_TCE_KILL			126
>>   #define OPAL_NMMU_SET_PTCR			127
>> -#define OPAL_LAST				127
>> +#define OPAL_IMC_COUNTERS_INIT			149
>> +#define OPAL_IMC_COUNTERS_START			150
>> +#define OPAL_IMC_COUNTERS_STOP			151
> Yay, this is heaps better!
>
>> +#define OPAL_LAST				151
>>   
>>   /* Device tree flags */
>>   
>> @@ -928,6 +931,13 @@ enum {
>>   	OPAL_PCI_TCE_KILL_ALL,
>>   };
>>   
>> +/* Argument to OPAL_IMC_COUNTERS_*  */
>> +enum {
>> +	OPAL_IMC_COUNTERS_NEST = 1,
>> +	OPAL_IMC_COUNTERS_CORE = 2,
>> +	OPAL_IMC_COUNTERS_THREAD = 3,
>> +};
>> +
>>   #endif /* __ASSEMBLY__ */
>>   
>>   #endif /* __OPAL_API_H */
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index 1ff03a6..9c16ec6 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -227,6 +227,10 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
>>   			  uint64_t dma_addr, uint32_t npages);
>>   int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
>>   
>> +int64_t opal_imc_counters_init(uint32_t type, uint64_t address);
> This isn't called anywhere in this patch... including (worryingly) in
> the init function...
>
>> +int64_t opal_imc_counters_start(uint32_t type);
>> +int64_t opal_imc_counters_stop(uint32_t type);
>> +
>>   /* Internal functions */
>>   extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>>   				   int depth, void *data);
>> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
>> index f09a37a..40792424 100644
>> --- a/arch/powerpc/perf/imc-pmu.c
>> +++ b/arch/powerpc/perf/imc-pmu.c
>> @@ -18,6 +18,11 @@
>>   
>>   struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
>>   struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
>> +static cpumask_t nest_imc_cpumask;
>> +
>> +static atomic_t nest_events;
>> +/* Used to avoid races in calling enable/disable nest-pmu units*/
> You need a space here between s and * ----------------------------^

Sure. I will correct this.  :)
>
>> +static DEFINE_MUTEX(imc_nest_reserve);
>>   
>>   /* Needed for sanity check */
>>   extern u64 nest_max_offset;
>> @@ -33,6 +38,160 @@ static struct attribute_group imc_format_group = {
>>   	.attrs = imc_format_attrs,
>>   };
>>   
>> +/* Get the cpumask printed to a buffer "buf" */
>> +static ssize_t imc_pmu_cpumask_get_attr(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	cpumask_t *active_mask;
>> +
>> +	active_mask = &nest_imc_cpumask;
>> +	return cpumap_print_to_pagebuf(true, buf, active_mask);
>> +}
>> +
>> +static DEVICE_ATTR(cpumask, S_IRUGO, imc_pmu_cpumask_get_attr, NULL);
>> +
>> +static struct attribute *imc_pmu_cpumask_attrs[] = {
>> +	&dev_attr_cpumask.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group imc_pmu_cpumask_attr_group = {
>> +	.attrs = imc_pmu_cpumask_attrs,
>> +};
>> +
>> +/*
>> + * nest_init : Initializes the nest imc engine for the current chip.
>> + * by default the nest engine is disabled.
>> + */
>> +static void nest_init(int *cpu_opal_rc)
>> +{
>> +	int rc;
>> +
>> +	/*
>> +	 * OPAL figures out which CPU to start based on the CPU that is
>> +	 * currently running when we call into OPAL
>> +	 */
>> +	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
> Why isn't this the init call? If this is correct, a comment explaning it
> would be helpful.

Basically init call is meant for any hardware initialization, that we need.
Here in case of nest, we are disabling the counters initially.
We enable them only during perf init.

I will document this here.

>> +	if (rc)
>> +		cpu_opal_rc[smp_processor_id()] = 1;
>> +}
>> +
>
>> +static int nest_imc_control(int operation)
>> +{
>> +	int *cpus_opal_rc, cpu;
>> +
>> +	/*
>> +	 * Memory for OPAL call return value.
>> +	 */
>> +	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
>> +	if (!cpus_opal_rc)
>> +		return -ENOMEM;
>> +	switch (operation) {
>> +
>> +	case	IMC_COUNTER_ENABLE:
>> +			/* Initialize Nest PMUs in each node using designated cpus */
>> +			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_imc_start,
>> +						(void *)cpus_opal_rc, 1);
>> +			break;
>> +	case	IMC_COUNTER_DISABLE:
>> +			/* Disable the counters */
>> +			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_init,
>> +						(void *)cpus_opal_rc, 1);
>> +			break;
>> +	default: return -EINVAL;
>> +
>> +	}
>> +
>> +	/* Check return value array for any OPAL call failure */
>> +	for_each_cpu(cpu, &nest_imc_cpumask) {
>> +		if (cpus_opal_rc[cpu])
>> +			return -ENODEV;
>> +	}
>> +	return 0;
>> +}
> Two things:
>
>   - It doesn't look like you're freeing cpus_opal_rc anywhere - have I
>     missed it?

yes. we have to free cpus_opal_rc here. Will fix this.
>   - Would it be better to split this function into two: so instead of
>     passing in `operation`, you just have a nest_imc_enable and
>     nest_imc_disable? All the call sites I can see call this with a
>     constant parameter anyway. Perhaps it could even be refactored into
>     nest_imc_event_start/stop and this method could be removed
>     entirely...
>
>     (I haven't checked if you use this in future patches or if it gets
>     expanded and makes sense to keep the function this way.)
>

We can avoid some code duplication if we wrap nest-imc enable/disable into
a single function. That is why I preferred this way. I can give proper 
documentation for
this to avoid further confusion.


>> +
>>   static void imc_event_start(struct perf_event *event, int flags)
>>   {
>>   	/*
>> @@ -129,19 +333,44 @@ static void imc_event_stop(struct perf_event *event, int flags)
>>   	imc_perf_event_update(event);
>>   }
>>   
>> -/*
>> - * The wrapper function is provided here, since we will have reserve
>> - * and release lock for imc_event_start() in the following patch.
>> - * Same in case of imc_event_stop().
>> - */
>>   static void nest_imc_event_start(struct perf_event *event, int flags)
>>   {
>> +	int rc;
>> +
>> +	/*
>> +	 * Nest pmu units are enabled only when it is used.
>> +	 * See if this is triggered for the first time.
>> +	 * If yes, take the mutex lock and enable the nest counters.
>> +	 * If not, just increment the count in nest_events.
>> +	 */
>> +	if (atomic_inc_return(&nest_events) == 1) {
>> +		mutex_lock(&imc_nest_reserve);
>> +		rc = nest_imc_control(IMC_COUNTER_ENABLE);
>> +		mutex_unlock(&imc_nest_reserve);
>> +		if (rc)
>> +			pr_err("IMC: Unbale to start the counters\n");
> Spelling: s/Unbale/Unable/ ----------^
Will correct here. Thanks for mentioning. :-)

>> +	}
>>   	imc_event_start(event, flags);
>>   }
>>
> Overall I'm much happer with this now, good work :)
>
> Regards,
> Daniel
>



Thanks and Regards,
-Anju
