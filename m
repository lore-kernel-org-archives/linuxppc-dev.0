Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 786681A0DDC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 18:08:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 18:08:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 53F332BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 18:08:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5487DXb39911672
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 18:07:22 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5486mom019658
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 18:06:49 +1000
Message-ID: <55700701.7050301@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 13:36:25 +0530
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
Subject: Re: [PATCH v1 2/9]powerpc/powernv: nest pmu init function with cpumask
 attr
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-3-git-send-email-maddy@linux.vnet.ibm.com>
 <1433286889.438.13.camel@axtens.net>
In-Reply-To: <1433286889.438.13.camel@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 04:44 AM, Daniel Axtens wrote:
> On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
>> Patch creates a file "nest-pmu-c" to contain nest pmu related functions.
> "nest-pmu.c"
>> Patch adds nest pmu init function and cpumask function since Nest pmu units
>> are per-chip. First online cpu for a given node is picked as
>> designated thread to read the counter data.
>>
>> Subsequent patch adds the hotplug support.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Cc: Stephane Eranian <eranian@google.com>
>> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/perf/nest-pmu.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 arch/powerpc/perf/nest-pmu.c
>>
>> diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
>> new file mode 100644
>> index 0000000..d4413bb
>> --- /dev/null
>> +++ b/arch/powerpc/perf/nest-pmu.c
>> @@ -0,0 +1,70 @@
>> +/*
>> + * Nest Performance Monitor counter support for POWER8 processors.
>> + *
>> + * Copyright 2015 Madhavan Srinivasan, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
> Again, I think this is supposed to be v2 only.
>
>> +#include "nest-pmu.h"
>> +
>> +static cpumask_t cpu_mask_nest_pmu;
>> +
>> +static ssize_t cpumask_nest_pmu_get_attr(struct device *dev,
>> +				struct device_attribute *attr, char *buf)
>> +{
>> +	return cpumap_print_to_pagebuf(true, buf, &cpu_mask_nest_pmu);
>> +}
>> +
>> +static DEVICE_ATTR(cpumask, S_IRUGO, cpumask_nest_pmu_get_attr, NULL);
>> +
>> +static struct attribute *cpumask_nest_pmu_attrs[] = {
>> +	&dev_attr_cpumask.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group cpumask_nest_pmu_attr_group = {
>> +	.attrs = cpumask_nest_pmu_attrs,
>> +};
>> +
>> +void cpumask_chip(void)
>> +{
>> +	const struct cpumask *l_cpumask;
>> +	int cpu, nid;
>> +
>> +	if (!cpumask_empty(&cpu_mask_nest_pmu)) {
>> +		printk(KERN_INFO "cpumask not empty\n");
>> +		return;
>> + 	}
>> +
>> +	cpu_notifier_register_begin();
>> +	for_each_online_node(nid) {
>> +		l_cpumask = cpumask_of_node(nid);
>> +		cpu = cpumask_first(l_cpumask);
>> +		cpumask_set_cpu(cpu, &cpu_mask_nest_pmu);
>> +	}
>> +
>> +	cpu_notifier_register_done();
>> +}
> It's not clear from the name of this function what it does. I don't
> think I actually understand what it does: it appears to register a
> notifier on the first cpu of each node; maybe that should be reflected
> in the name.

My bad. Hotplug notification registration happens in the next patch.
could merge both as single patch.

>
>> +static int __init nest_pmu_init(void)
>> +{
>> +	int ret = 0;
>> +
>> +	/*
>> +	 * Lets do this only if we are hypervisor
>> +	 */
>> +	if (!cur_cpu_spec->oprofile_cpu_type ||
>> +	   strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") ||
>> +	   !cpu_has_feature(CPU_FTR_HVMODE))
>> +		return ret;
>> +
>> +	cpumask_chip();
>> +
>> +	return 0;
>> +}
>   - Where is ret set? I can only see it set when it's defined: the if
> statment doesn't change the value of ret as far as I can see...
Yes. It should have set to error value. Will fix it.

>   - Would it be clearer if you said
>          !(strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") == 0)
>     That would make it clearer that you're trying to get a list of
> possible failure conditions.
>   
Yes. Sure will change it.

>   - Is there really no better way to check if a CPU is a power 8 than an
> string comparison?
One other way I can think of is using PVR (Processor Version Register), 
but then will end up having multiple checks for Power8 itself, so this 
is lot simpler.

>> +device_initcall(nest_pmu_init);
> Regards,
> Daniel Axtens
Thanks for the review
Maddy
