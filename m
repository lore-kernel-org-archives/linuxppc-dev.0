Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BF1D1A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 21:43:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 9 Jun 2015 21:43:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 993A52BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 21:43:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t59Bg6Wg59244642
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 21:42:15 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t59Bfgt1009422
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jun 2015 21:41:42 +1000
Message-ID: <5576D0D8.8070304@linux.vnet.ibm.com>
Date: Tue, 09 Jun 2015 17:11:12 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 7/9]powerpc/powernv: Event attr creation and PMU
 registration
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-8-git-send-email-maddy@linux.vnet.ibm.com>
 <1433293592.438.74.camel@axtens.net>
In-Reply-To: <1433293592.438.74.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 06:36 AM, Daniel Axtens wrote:
> On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
>> Patch adds common event attribute function and Nest pmu registration call.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Cc: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/nest-pmu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/nest-pmu.c b/arch/powerpc/perf/nest-pmu.c
>> index 514a0be..dd84fd7 100644
>> --- a/arch/powerpc/perf/nest-pmu.c
>> +++ b/arch/powerpc/perf/nest-pmu.c
>> @@ -244,6 +244,49 @@ static int update_pmu_ops(struct nest_pmu *pmu)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Populate event name and string in attribute
>> + */
>> +struct attribute *dev_str_attr(char *name, char *str)
>> +{
>> +	struct perf_pmu_events_attr *attr;
>> +
>> +	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
>> +
>> +	attr->event_str = (const char *)str;
> Erk. Two things:
>  - Is str const or not? If you're treating it as const here, should you
> pass that through the function signature?
>  - Who is responsible for the memory behind it? It looks like a caller
> can't construct str dynamically, pass it to this function and then free
> it, because that will invalidate attr->event_str. Is this documented?
Yes. Valid point. str should be and it is const. My bad, will fix the
function
signature.

>> +	attr->attr.attr.name = name;
>> +	attr->attr.attr.mode = 0444;
>> +	attr->attr.show = perf_event_sysfs_show;
>> +
>> +	return &attr->attr.attr;
> If you're returning the address of attr->attr.attr, then:
>  - why don't you just deal directly with struct attribute * in the
> function? Why an entire struct perf_pmu_events_attr *?
>  - with the function as written, if you return just &attr->attr.attr,
> don't attr->event_str and attr->attr.show get lost?

Kindly have should look at perf_event_sysfs_show function in
include/linux/perf_event.h.
Even though we return only &attr->attr.attr, we are not freeing the
memory of
perf_pmu_event_attr, hence will not be lost :) .
>> +}
>> +
>> +int update_events_in_group(
>> +	struct ppc64_nest_ima_events *p8_events, int idx,
>> +		struct nest_pmu *pmu)
>> +{
>> +	struct attribute_group *attr_group;
>> +	struct attribute **attrs;
>> +	int i;
>> +
>> +	attr_group = kzalloc(((sizeof(struct attribute *) * (idx + 1)) +
>> +				sizeof(*attr_group)), GFP_KERNEL);
>> +	if (!attr_group)
>> +		return -ENOMEM;
>> +
>> +	attrs = (struct attribute **)(attr_group + 1);
>> +	attr_group->name = "events";
>> +	attr_group->attrs = attrs;
>> +
>> +	for (i=0; i< idx; i++, p8_events++)
>> +		attrs[i] = dev_str_attr((char *)p8_events->ev_name,
>> +						(char *)p8_events->ev_value);
>> +
>> +	pmu->attr_groups[0] = attr_group;
>> +	return 0;
>> +}
> I'm very confused by what this function is trying to do. Could you add
> some comments? I'm particularly confused by the relationship between
> attrs and attr_group.

This function mainly creates a "event" attribute group for this PMU.
It does so with the list of event files parsed from the device tree
for this pmu in the nest_pmu_create function.

WIll add comments in the next version.

>> +
>> +
>>  static int nest_pmu_create(struct device_node *dev, int pmu_index)
>>  {
>>  	struct ppc64_nest_ima_events **p8_events_arr;
>> @@ -364,6 +407,15 @@ static int nest_pmu_create(struct device_node *dev, int pmu_index)
>>  		}
>>  	}
>>  
>> +	update_events_in_group(
>> +		(struct ppc64_nest_ima_events *)p8_events_arr,
>> +							idx, pmu_ptr);
>> +	update_pmu_ops(pmu_ptr);
>> +
>> +	/* Register the pmu */
>> +	perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
>> +	printk(KERN_INFO "Nest PMU %s Registered\n", pmu_ptr->pmu.name);
>> +
>>  	return 0;
>>  }
>>  
> Regards,
> Daniel
>
Apologizes on late response to this mail. Missed it.
Thanks for review
Maddy
