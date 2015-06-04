Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 883601A0BC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 18:30:57 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 14:00:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AA29D394005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 14:00:49 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t548UmbA60293290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 14:00:48 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t547dNUA030073
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 13:09:24 +0530
Message-ID: <55700CA9.7000501@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 14:00:33 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 3/9]powerpc/powernv: Add cpu hotplug support
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-4-git-send-email-maddy@linux.vnet.ibm.com>
 <1433288296.438.30.camel@axtens.net>
In-Reply-To: <1433288296.438.30.camel@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 05:08 AM, Daniel Axtens wrote:
> On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
>> Patch adds cpu hotplug support. First online cpu in a node is picked as
>> designated thread to read the Nest pmu counter data, and at the time of
>> hotplug, next online cpu from the same node is picked up.
> I'm not sure I understand this commit message. I think I understand the
> first half - I think you're trying to say: "At boot, the first online
I will rephrase it.

> CPU in a node is picked as the designated thread to read the Nest PMU
> counter data." I'm not sure I understand the second half: "picked up"
> how and for what?
When the designated thread is hotplugged, next online cpu in the
same node is picked up as the designated thread to read the PMU counter 
data.

> (I did eventually figure it out by reading the patch, but it'd be really
> nice to have it spelled out nicely in the commit message.)
Sure. Will fix the commit message.

>> +static void nest_exit_cpu(int cpu)
>> +{
>> +	int i, nid, target = -1;
>> +	const struct cpumask *l_cpumask;
>> +	int src_chipid;
>> +
>> +	if (!cpumask_test_and_clear_cpu(cpu, &cpu_mask_nest_pmu))
>> +		return;
>> +
>> +	nid = cpu_to_node(cpu);
>> +	src_chipid = topology_physical_package_id(cpu);
>> +	l_cpumask = cpumask_of_node(nid);
>> +	for_each_cpu(i, l_cpumask) {
>> +		if (i == cpu)
>> +			continue;
>> +		if (src_chipid == topology_physical_package_id(i)) {
>> +			target = i;
>> +			break;
>> +		}
>> +	}
> Some comments here would really help. I think you're looking for the
> first CPU that's (a) not the cpu you're removing and (b) on the same
> physical package, so sharing the same nest, but it took me a lot of
> staring at the code to figure it out.
My bad. I will comment it.

>> +
>> +	cpumask_set_cpu(target, &cpu_mask_nest_pmu);
>> +	nest_change_cpu_context (cpu, target);
>> +	return;
> Return is redundant here and in several other functions in this patch.
Ok.

>> +}
>> +
>> +static void nest_init_cpu(int cpu)
>> +{
>> +	int i, src_chipid;
>> +
>> +	src_chipid = topology_physical_package_id(cpu);
>> +	for_each_cpu(i, &cpu_mask_nest_pmu)
>> +		if (src_chipid == topology_physical_package_id(i))
>> +			return;
>> +
>> +	cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
>> +	nest_change_cpu_context ( -1, cpu);
> Weird extra spaces here.
Yes. Nice catch. Will fix it.

>> +	return;
>> +}
> This function could also do with a comment: AFAICT, you've structured
> the function so that it only calls nest_change_cpu_context if you've
> picked up a cpu on a physical package that previously didn't have a nest
> pmu thread on it.
>
>> +
>> +static int nest_cpu_notifier(struct notifier_block *self,
>> +				unsigned long action, void *hcpu)
>> +{
>> +	unsigned int cpu = (long)hcpu;
> What's with this cast? You cast it to a long and then assign it to an
> unsigned int?

Facepalm. My bad, will fix it.
>> +
>> +	switch (action & ~CPU_TASKS_FROZEN) {
>> +	case CPU_DOWN_FAILED:
> Is it necessary to move the thread back if the CPU fails to go down?
No. not need.
> You've moved it to another online CPU already; what's the benefit of
> paying the time-penalty to move it back?
Why should go through that. Because, there is no restriction saying only 
the first
cpu has to read it, why should we complicate it further instead of 
moving to another
cpu in the same node.

>> +	case CPU_STARTING:
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
>>   
> Now, I don't know the details of CPU hotplug _at all_, so this may be
> stupid, but what happens if you hotplug a lot of CPUs all at once? Is
> everything properly serialised or is this going to race and end up with
> either multiple cpus trying to do PMU or no cpus?
I did test the code with hotplug test. If all the cpus in the node is 
offlined,
then we will have no cpus designated for that node.

Thanks for review
Maddy
> Regards,
> Daniel Axtens
>
>
