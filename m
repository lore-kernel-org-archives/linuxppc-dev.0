Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CF091A0ACD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 20:04:04 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 15:34:02 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CCF95394004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 15:34:00 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t54A3xw244105832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 15:33:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t54A3w5c021076
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 15:33:59 +0530
Message-ID: <55702289.8090401@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 15:33:53 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 6/9]powerpc/powernv: dt parser function for nest pmu
 and its events
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-7-git-send-email-maddy@linux.vnet.ibm.com>
 <1433292378.438.58.camel@axtens.net>
In-Reply-To: <1433292378.438.58.camel@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 06:16 AM, Daniel Axtens wrote:
>> +static int nest_pmu_create(struct device_node *dev, int pmu_index)
>> +{
>> +	struct ppc64_nest_ima_events **p8_events_arr;
>> +	struct ppc64_nest_ima_events *p8_events;
>> +	struct property *pp;
>> +	char *buf;
>> +	const __be32 *lval;
>> +	u32 val;
>> +	int len, idx = 0;
>> +	struct nest_pmu *pmu_ptr;
>> +	const char *start, *end;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	pmu_ptr = kzalloc(sizeof(struct nest_pmu), GFP_KERNEL);
>> +	if (!pmu_ptr)
>> +		return -ENOMEM;
>> +
>> +	/* Needed for hotplug/migration */
>> +	per_nestpmu_arr[pmu_index] = pmu_ptr;
>> +
>> +	p8_events_arr = kzalloc((sizeof(struct ppc64_nest_ima_events) * 64),
>> +								GFP_KERNEL);
>> +	if (!p8_events_arr)
>> +		return -ENOMEM;
>> +	p8_events = (struct ppc64_nest_ima_events *)p8_events_arr;
> I think you're trying to get the first element of the array here: why
> not just `p8_events = p8_events_arr[0];`?
Yes. Will change it.
>> +
>> +	/*
>> +	 * Loop through each property
>> +	 */
>> +	for_each_property_of_node(dev, pp) {
>> +		start = pp->name;
>> +		end = start + strlen(start);
>> +		len = strlen(start);
>> +
>> +		if (!strcmp(pp->name, "name")) {
>> +			if (!pp->value ||
>> +			   (strnlen(pp->value, pp->length) >= pp->length))
>> +				return -EINVAL;
>> +
>> +			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
>> +			if (!buf)
>> +				return -ENOMEM;
>> +
>> +			sprintf(buf, "Nest_%s", (char *)pp->value);
>> +			pmu_ptr->pmu.name = (char *)buf;
>> +			pmu_ptr->attr_groups[1] = &p8_nest_format_group;
>> +			pmu_ptr->attr_groups[2] = &cpumask_nest_pmu_attr_group;
>> +		}
>> +
>> +		/* Skip these, we dont need it */
>> +		if (!strcmp(pp->name, "name") ||
>> +		    !strcmp(pp->name, "phandle") ||
>> +		    !strcmp(pp->name, "device_type") ||
>> +		    !strcmp(pp->name, "linux,phandle"))
>> +			continue;
>> +
>> +		buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
>> +		if (!buf)
>> +			return -ENOMEM;
>> +
>> +		if (strncmp(pp->name, "unit.", 5) == 0) {
>> +			start += 5;
>> +			len = strlen(start);
>> +			strncpy(buf, start, strlen(start));
> You've just saved strlen(start), you could just use len. This also
> applies in the next case below.
Yes. That is true.

>> +			p8_events->ev_name = buf;
>> +
>> +			if (!pp->value ||
>> +                            (strnlen(pp->value, pp->length) >= pp->length))
>> +				return -EINVAL;
> The strnlen will never be greater than pp->length, so the only case this
> will hit is if strnlen(pp->value, pp->length) == pp->length. This also
> applies again below.

True will change it.
>
>> +
>> +			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
>> +			if (!buf)
>> +				return -ENOMEM;
>> +
>> +			strncpy(buf, (const char *)pp->value, pp->length);
>> +			p8_events->ev_value = buf;
>> +			idx++;
>> +			p8_events++;
>> +
>> +		} else if (strncmp(pp->name, "scale.", 6) == 0) {
>> +			start += 6;
>> +			len = strlen(start);
>> +			strncpy(buf, start, strlen(start));
>> +			p8_events->ev_name = buf;
>> +
>> +			if (!pp->value ||
>> +			   (strnlen(pp->value, pp->length) >= pp->length))
>> +				return -EINVAL;
>> +
>> +			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
>> +			if (!buf)
>> +				return -ENOMEM;
>> +
>> +			strncpy(buf, (const char *)pp->value, pp->length);
>> +			p8_events->ev_value = buf;
>> +			idx++;
>> +			p8_events++;
>> +
>> +		} else {
>> +			strncpy(buf, start, len);
> This is the only case where you actually use the orignal version of len.
> This makes me think you could drop the variable entirely and just use
> strlen(start) in all cases. I also don't see where `end` is used
> anywhere in this function: could that be dropped?
Correct. I guess we can drop both len and end. I used "end" for my 
prints during debug.

>> +			p8_events->ev_name = buf;
>> +			lval = of_get_property(dev, pp->name, NULL);
>> +			val = (uint32_t)be32_to_cpup(lval);
>> +
>> +			/*
>> +			* Use DT property value as the event
>> +			*/
> I'm not sure if this is my mailer, but it looks like lines 2 and 3 of
> that comment need to be indented to line up under the * in the first
> line.
No, it is not your mail :). Will fix the indentation.

>> +			buf = kzalloc(MAX_PMU_NAME_LEN, GFP_KERNEL);
>> +			if (!buf)
>> +                                return -ENOMEM;
>> +
>> +			sprintf(buf,"event=0x%x", val);
>> +			p8_events->ev_value = buf;
>> +			p8_events++;
>> +			idx++;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> @@ -288,7 +427,7 @@ static int __init nest_pmu_init(void)
>>   	cpumask_chip();
>>   
>>   	/*
>> -	 * Detect the Nest PMU feature
>> +	 * Detect the Nest PMU feature and register the pmus
>>   	 */
>>   	if (nest_ima_detect_parse())
>>   		return 0;
> As the changed comment indicates, this function changes the behaviour of
> nest_ima_detect_parse. Given that it's a new function introduced by this
> patch series, maybe it should also change names.
>
Ok will fix it.
Thanks for the review.
Maddy
