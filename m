Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRGdH0QCqzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 20:13:54 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FADf9B077510
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 06:13:48 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ae6txtq2e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 06:13:47 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 15 May 2017 20:13:44 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4FADXI98126574
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 20:13:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4FAD1s8006177
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 20:13:02 +1000
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
To: Thomas Gleixner <tglx@linutronix.de>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1705101116380.1979@nanos>
Cc: mpe@ellerman.id.au, LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, Anton Blanchard <anton@samba.org>,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 15 May 2017 15:42:46 +0530
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1705101116380.1979@nanos>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f8972c0c-11db-fd43-09a3-200b90a34d3b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for delayed response.


On Wednesday 10 May 2017 05:39 PM, Thomas Gleixner wrote:
> On Thu, 4 May 2017, Anju T Sudhakar wrote:
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
> I have no idea what that comment tries to tell me and how it is related to
> the init function or the invoked opal_imc_counters_stop() function.

Yep will fix the comment.

>
>> +	 */
>> +	rc = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
>> +	if (rc)
>> +		cpu_opal_rc[smp_processor_id()] = 1;
>> +}
>> +
>> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
>> +{
>> +	int i;
>> +
>> +	for (i = 0;
>> +	     (per_nest_pmu_arr[i] != NULL) && (i < IMC_MAX_PMUS); i++)
>> +		perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
>> +							old_cpu, new_cpu);
> Bah, this is horrible to read.
>
> 	struct imc_pmu **pn = per_nest_pmu_arr;
> 	int i;
>
> 	for (i = 0; *pn && i < IMC_MAX_PMUS; i++, pn++)
> 		perf_pmu_migrate_context(&(*pn)->pmu, old_cpu, new_cpu);
>
> Hmm?

Yes this is better. Will update the code.

>
>> +}
>> +
>> +static int ppc_nest_imc_cpu_online(unsigned int cpu)
>> +{
>> +	int nid;
>> +	const struct cpumask *l_cpumask;
>> +	struct cpumask tmp_mask;
> You should not allocate cpumask on stack unconditionally. Either make that
> cpumask_var_t and use zalloc/free_cpumask_var() or simply make it
>
> 	static struct cpumask tmp_mask;
>
> That's fine, because this is serialized by the hotplug code already.

ok will fix it as suggested.

>
>> +
>> +	/* Find the cpumask of this node */
>> +	nid = cpu_to_node(cpu);
>> +	l_cpumask = cpumask_of_node(nid);
>> +
>> +	/*
>> +	 * If any of the cpu from this node is already present in the mask,
>> +	 * just return, if not, then set this cpu in the mask.
>> +	 */
>> +	if (!cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask)) {
>> +		cpumask_set_cpu(cpu, &nest_imc_cpumask);
>> +		nest_change_cpu_context(-1, cpu);
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ppc_nest_imc_cpu_offline(unsigned int cpu)
>> +{
>> +	int nid, target = -1;
>> +	const struct cpumask *l_cpumask;
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
> What disables the perf context if this was the last CPU on the node?

My bad. i did not understand this. Is this regarding the updates
of the "flags" in the perf_event and hw_perf_event structs?


>
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
> What's that for? Paranoia engineering?

No.  The idea here is to generate the cpu_mask attribute
field only for the first "nest" pmu and use the same
for other "nest" units.

>> +
>> +	/*
>> +	 * Memory for OPAL call return value.
>> +	 */
>> +	cpus_opal_rc = kzalloc((sizeof(int) * nr_cpu_ids), GFP_KERNEL);
>> +	if (!cpus_opal_rc)
>> +		goto fail;
>> +
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
> This is all unprotected against CPU hotplug.
>
>> +
>> +	/* Initialize Nest PMUs in each node using designated cpus */
>> +	on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_init,
>> +						(void *)cpus_opal_rc, 1);
> What does this check on nodes which are not yet online and become online
> later?

Idea here is, not to have the nest engines running always. Enable/start
them only when needed. So at init stage of the pmu setup, disable them.
That said, opal api call to disable is needed for a new node
that comes online at later stage.  Nice catch, Thanks

>
>> +	/* Check return value array for any OPAL call failure */
>> +	for_each_cpu(cpu, &nest_imc_cpumask) {
> Races against CPU hotplug as well.
>
>> +		if (cpus_opal_rc[cpu])
>> +			goto fail;
>> +	}
> Leaks cpus_opal_rc.
>
>> +
>> +	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
>> +			  "POWER_NEST_IMC_ONLINE",
> Please use a proper prefixed text here.
>
>> +			  ppc_nest_imc_cpu_online,
>> +			  ppc_nest_imc_cpu_offline);
>> +
>> +	return 0;
>> +
>> +fail:
>> +	if (cpus_opal_rc)
>> +		kfree(cpus_opal_rc);
>> +	return -ENODEV;
> But this whole function is completely overengineered. If you make that
> nest_init() part of the online function then this works also for nodes
> which come online later and it simplifies to:
>
> static int ppc_nest_imc_cpu_online(unsigned int cpu)
> {
> 	const struct cpumask *l_cpumask;
> 	static struct cpumask tmp_mask;
> 	int res;
>
> 	/* Get the cpumask of this node */
> 	l_cpumask = cpumask_of_node(cpu_to_node(cpu));
>
> 	/*
> 	 * If this is not the first online CPU on this node, then IMC is
> 	 * initialized already.
> 	 */
> 	if (cpumask_and(&tmp_mask, l_cpumask, &nest_imc_cpumask))
> 		return 0;
>
> 	/*
> 	 * If this fails, IMC is not usable.
> 	 *
> 	 * FIXME: Add a understandable comment what this actually does
> 	 * and why it can fail.
> 	 */
> 	res = opal_imc_counters_stop(OPAL_IMC_COUNTERS_NEST);
> 	if (res)
> 		return res;
>
> 	/* Make this CPU the designated target for counter collection */
> 	cpumask_set_cpu(cpu, &nest_imc_cpumask);
> 	nest_change_cpu_context(-1, cpu);
> 	return 0;
> }
>
> static int nest_pmu_cpumask_init(void)
> {
> 	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
> 				 "perf/powerpc/imc:online",
> 				 ppc_nest_imc_cpu_online,
> 				 ppc_nest_imc_cpu_offline);
> }
>
> Hmm?

Yes this make sense. But we need to first designate a cpu in each
chip at init setup and use opal api to disable the engine in the same.
So probably, after cpuhp_setup_state, can we do that?

>
>> +static void nest_imc_start(int *cpu_opal_rc)
>> +{
>> +	int rc;
>> +
>> +	/* Enable nest engine */
>> +	rc = opal_imc_counters_start(OPAL_IMC_COUNTERS_NEST);
>> +	if (rc)
>> +		cpu_opal_rc[smp_processor_id()] = 1;
>> +
>> +}
>> +
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
> This function leaks cpus_opal_rc on each invocation. Great stuff!

Yep. Have fixed it and daniel also pointed out the
same in this review comments.

>
>> +	switch (operation) {
>> +
>> +	case	IMC_COUNTER_ENABLE:
>> +			/* Initialize Nest PMUs in each node using designated cpus */
>> +			on_each_cpu_mask(&nest_imc_cpumask, (smp_call_func_t)nest_imc_start,
> How is that supposed to work? This is called from interrupt disabled
> context. on_each_cpu_mask() must not be called from there. And in the worst
> case this is called not only from interrupt disabled context but from a smp
> function call .....

Indent here is to make sure nest engines running/enabled only
when needed and disabled rest of the time. So we added a
reserved/release logic to enable/diable the nest engine in the recent
version of the patchset. And my bad, could have done better
incase of testing this logic.

That said, we did hit "WARN_ON_ONCE" in smp_call_* with this version
of the patchset which you were spot on. So have moved the
reserved/release logic to *event_init(). Something like this, to the
latest internal version of the patchset.

@@ -74,7 +305,20 @@ static int nest_imc_event_init(struct perf_event *event)
  	 */
  	event->hw.event_base = pcni->vbase[config/PAGE_SIZE] +
  							(config & ~PAGE_MASK);
-
+	/*
+	 * Nest pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the nest counters.
+	 * If not, just increment the count in nest_events.
+	 */
+	if (atomic_inc_return(&nest_events) == 1) {
+		mutex_lock(&imc_nest_reserve);
+		rc = nest_imc_control(IMC_COUNTER_ENABLE);
+		mutex_unlock(&imc_nest_reserve);
+		if (rc) {
+			pr_err("IMC: Unable to start the counters\n");
+			return -EBUSY;
+		}
+	}
+	event->destroy = nest_imc_counters_release;
  	return 0;
  }


> Aside of that. What's the point of these type casts? If your function does
> not have the signature of a smp function call function, then you should fix
> that. If it has, then the type cast is just crap.

yes. Will fix the casting part.

>
>> +						(void *)cpus_opal_rc, 1);
> Ditto for this. Casting to (void *) is pointless.
>
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
> So this just checks whether the disable/enable was successful, but what's
> the consequence? Counters stay half enabled or disabled depending on which
> of the CPUs failed.
>
> This whole result array dance is just useless as you are solely printing
> stuff at the call site. So I assume those calls are not supposed to fail,
> so you can do the print in the function itself and get rid of all this
> cpus_opal_rc hackery. Though that's the least of your worries, see above.

Yes. As I mentioned before, have moved the reserve/release
logic to the *event_init(). And apart from printing debug message
on the opal call failure, also return with -EBUSY in the *event_init()
incase of opal call failure.

>> +	}
>> +	return 0;
>> +}
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
> How is that supposed to work? pmu->start() and pmu->stop() are called with
> interrupts disabled. Locking a mutex there is a NONO.
>
>> +		rc = nest_imc_control(IMC_COUNTER_ENABLE);
>> +		mutex_unlock(&imc_nest_reserve);
>> +		if (rc)
>> +			pr_err("IMC: Unbale to start the counters\n");
>> +	}
>>   	imc_event_start(event, flags);
>>   }
>>   
>>   static void nest_imc_event_stop(struct perf_event *event, int flags)
>>   {
>> +	int rc;
>> +
>>   	imc_event_stop(event, flags);
>> +	/*
>> +	 * See if we need to disable the nest PMU.
>> +	 * If no events are currently in use, then we have to take a
>> +	 * mutex to ensure that we don't race with another task doing
>> +	 * enable or disable the nest counters.
>> +	 */
>> +	if (atomic_dec_return(&nest_events) == 0) {
>> +		mutex_lock(&imc_nest_reserve);
> See above.
>
>> +		rc = nest_imc_control(IMC_COUNTER_DISABLE);
>> +		mutex_unlock(&imc_nest_reserve);
>> +		if (rc)
>> +			pr_err("IMC: Disable counters failed\n");
>> +	}
>>   }
> I have no idea how that survived any form of testing ....

yes could have done better incase of testing the reserve/release
logic it but that said, have identified and fixed the issues in the
latest internal version of the patchset with more test runs and will
post it out soon.

Thanks for your review comments.

Maddy
>
> Thanks,
>
> 	tglx
>
