Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D6171A0EF1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 19:16:32 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 22 Jun 2015 19:16:30 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 890333578055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 19:16:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5M9GJo531916136
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 19:16:27 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5M9FsZk004737
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 19:15:55 +1000
Message-ID: <5587D21C.8080303@linux.vnet.ibm.com>
Date: Mon, 22 Jun 2015 14:45:08 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
CC: Peter Zijlstra <peterz@infradead.org>, rusty@rustcorp.com.au,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 7/7]powerpc/powernv: nest pmu cpumask and cpu hotplug
 support
References: <1433999874-2043-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433999874-2043-8-git-send-email-maddy@linux.vnet.ibm.com>
 <557FC1F9.5010607@linux.vnet.ibm.com>
In-Reply-To: <557FC1F9.5010607@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 16 June 2015 11:58 AM, Preeti U Murthy wrote:
> On 06/11/2015 10:47 AM, Madhavan Srinivasan wrote:
>> Adds cpumask attribute to be used by each nest pmu since nest
>> units are per-chip. Only one cpu (first online cpu) from each node/chip
>> is designated to read counters.
>>
>> On cpu hotplug, dying cpu is checked to see whether it is one of the
>> designated cpus, if yes, next online cpu from the same node/chip is designated
>> as new cpu to read counters.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Anton Blanchard <anton@samba.org>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Cc: Stephane Eranian <eranian@google.com>
>> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>> +static void nest_change_cpu_context(int old_cpu, int new_cpu)
>> +{
>> +	int i;
>> +
>> +	if (new_cpu >= 0) {
>> +		for (i = 0; per_nest_pmu_arr[i] != NULL; i++)
>> +			perf_pmu_migrate_context(&per_nest_pmu_arr[i]->pmu,
>> +							old_cpu, new_cpu);
>> +	}
>> +}
>> +
>> +static void nest_exit_cpu(int cpu)
>> +{
>> +	int i, nid, target = -1;
>> +	const struct cpumask *l_cpumask;
>> +	int src_chipid;
>> +
>> +	/*
>> +	 * Check in the designated list for this cpu. Dont bother
>> +	 * if not one of them.
>> +	 */
>> +	if (!cpumask_test_and_clear_cpu(cpu, &cpu_mask_nest_pmu))
>> +		return;
>> +
>> +	/*
>> +	 * Now that this cpu is one of the designated,
>> +	 * find a new cpu a) which is not dying and
> This comment is not right. nest_exit_cpu() is called in the hotplug
> path, so another cpu cannot be dying in parallel. Hotplug operations are
> done serially. The comment ought to be "a) which is online" instead.
Ok will change it.

>> +	 * b) is in same node/chip.
> node is not the same as a chip right ? And you are interested in cpus on
> the same chip alone. So shouldn't the above comment be b) in the same chip ?
I was hoping it to be, but i will change  comment to chip.

>> +	 */
>> +	nid = cpu_to_node(cpu);
>> +	src_chipid = topology_physical_package_id(cpu);
> What is the relation between a node and a chip ? Can't we have a
> function which returns the cpumask of a chip straight away, since that
> is what you seem to be more interested in ? You can then simply choose
> the next cpu in this cpumask rather than going through the below loop.
>
Make sense. I can separate it out.

>> +	l_cpumask = cpumask_of_node(nid);
>> +	for_each_cpu(i, l_cpumask) {
>> +		if (i == cpu)
>> +			continue;
>> +		if (src_chipid == topology_physical_package_id(i)) {
>> +			target = i;
>> +			break;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Update the cpumask with the target cpu and
>> +	 * migrate the context if needed
>> +	 */
>> +	if (target >= 0) {
> You already check for target >= 0 here. So you don't need to check for
> new_cpu >= 0 in nest_change_cpu_context() above ?
I guess i was way too cautious :) Will change it

>> +		cpumask_set_cpu(target, &cpu_mask_nest_pmu);
>> +		nest_change_cpu_context (cpu, target);
>> +	}
>> +}
>> +
>> +static void nest_init_cpu(int cpu)
>> +{
>> +	int i, src_chipid;
>> +
>> +	/*
>> +	 * Search for any existing designated thread from
>> +	 * the incoming cpu's node/chip. If found, do nothing.
>> +	 */
>> +	src_chipid = topology_physical_package_id(cpu);
>> +	for_each_cpu(i, &cpu_mask_nest_pmu)
>> +		if (src_chipid == topology_physical_package_id(i))
>> +			return;
>> +
>> +	/*
>> +	 * Make incoming cpu as a designated thread for
>> +	 * this node/chip
>> +	 */
>> +	cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
> Why can't we simply check if cpu is the first one coming online in the
> chip and designate it as the cpu_mask_nest_pmu for that chip ? If it is
> not the first cpu, it means that another cpu in the same chip already
> took over this duty and it needn't bother.
Looks to be right. let me try it out.

> And shouldn't we also call nest_init() on this cpu, just like you do in
> cpumask_chip() on all cpu_mask_nest_pmu cpus ?
Yes. I missed that. We should init. Nice catch.

>> +}
>> +
>> +static int nest_cpu_notifier(struct notifier_block *self,
>> +				unsigned long action, void *hcpu)
>> +{
>> +	long cpu = (long)hcpu;
>> +
>> +	switch (action & ~CPU_TASKS_FROZEN) {
>> +	case CPU_DOWN_FAILED:
> Why do we need to handle the DOWN_FAILED case ? In DOWN_PREPARE, you
> have ensured that the function moves on to another cpu. So even if the
> offline failed, its no issue. The duty is safely taken over.
>
>> +	case CPU_STARTING:
> I would suggest initializing nest in the CPU_ONLINE stage. This is
> because CPU_STARTING phase can fail. In that case, we will be
> unnecessarily initializing nest pre-maturely. CPU_ONLINE phase assures
> that the cpu is successfully online and you can then initiate nest.
Ok sure. Will do that.

>> +		nest_init_cpu(cpu);
>> +		break;
>> +	case CPU_DOWN_PREPARE:
>> +		nest_exit_cpu(cpu);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block nest_cpu_nb = {
>> +	.notifier_call  = nest_cpu_notifier,
>> +	.priority       = CPU_PRI_PERF + 1,
>> +};
>> +
>> +void cpumask_chip(void)
> This name ^^ is not apt IMO. You are initiating the cpumask necessary
> for nest pmu. So why not call it nest_pmu_cpumask_init() ?

Ok.
>> +{
>> +	const struct cpumask *l_cpumask;
>> +	int cpu, nid;
>> +
>> +	if (!cpumask_empty(&cpu_mask_nest_pmu))
> When can this condition become true ?
My bad. This code ended up here from the initial RFC patch, but after
reviewing this again, i dont think this is needed. Once again nice catch.

>> +		return;
>> +
>> +	cpu_notifier_register_begin();
>> +
>> +	/*
>> +	 * Nest PMUs are per-chip counters. So designate a cpu
>> +	 * from each node/chip for counter collection.
>> +	 */
>> +	for_each_online_node(nid) {
>> +		l_cpumask = cpumask_of_node(nid);
>> +
>> +		/* designate first online cpu in this node */
>> +		cpu = cpumask_first(l_cpumask);
>> +		cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
>> +	}
>> +
>> +	/* Initialize Nest PMUs in each node using designated cpus */
>> +	on_each_cpu_mask(&cpu_mask_nest_pmu, (smp_call_func_t)nest_init, NULL, 1);
>> +
>> +	__register_cpu_notifier(&nest_cpu_nb);
>> +
>> +	cpu_notifier_register_done();
>> +}
> Regards
> Preeti U Murthy
