Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DE441A0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:04:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 16:04:10 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 183322BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:04:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N63wkA52953174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:04:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N63Yoa000918
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:03:34 +1000
Message-ID: <55B083A2.4030404@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 11:33:14 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 4/7] powerpc/powernv: detect supported nest pmus and
 its events
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-5-git-send-email-maddy@linux.vnet.ibm.com>
 <1437538064.30906.20.camel@axtens.net>
In-Reply-To: <1437538064.30906.20.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 July 2015 09:37 AM, Daniel Axtens wrote:
>  
>>  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
>> +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
>> +
>> +static int nest_event_info(struct property *pp, char *name,
>> +			struct nest_ima_events *p8_events, int string, u32 val)
> 'int string' is a bit confusing. 'bool is_string' might be clearer, but
> I think it would be even better still to have different functions for
> string and non-string cases, especially because you only need val in the
> non-string case.

I would perfer to be a single function, since most of the code is same
just of the sting or val part. yes. We can make is as is_string and will
add
comment explaining what is done here? 

> That will also allow you to give the functions clearer names. I think
> the function is populating the event with info from the dt property (in
> the string case) or the val argument (non-string case) - maybe the names
> could reflect that somehow?
>> +{
>> +	char *buf;
>> +
>
>> +
>> +static int nest_pmu_create(struct device_node *dev, int pmu_index)
>> +{
>> +	struct nest_ima_events **p8_events_arr, *p8_events;
>> +	struct nest_pmu *pmu_ptr;
>> +	struct property *pp;
>> +	char *buf, *start;
>> +	const __be32 *lval;
>> +	u32 val;
>> +	int idx = 0, ret;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	/* memory for nest pmus */
>> +	pmu_ptr = kzalloc(sizeof(struct nest_pmu), GFP_KERNEL);
>> +	if (!pmu_ptr)
>> +		return -ENOMEM;
>> +
>> +	/* Needed for hotplug/migration */
>> +	per_nest_pmu_arr[pmu_index] = pmu_ptr;
>> +
>> +	/* memory for nest pmu events */
>> +	p8_events_arr = kzalloc((sizeof(struct nest_ima_events) * 64),
>> +								GFP_KERNEL);
>> +	if (!p8_events_arr)
>> +		return -ENOMEM;
>> +	p8_events = (struct nest_ima_events *)p8_events_arr;
> I'm still quite uncomfortable with this.
>  - Why * 64? Should it be * P8_NEST_MAX_EVENTS_SUPPORTED? Or is it a
> different constant?

Yes it should be P8_NEST_MAX_EVENTS_SUPPORTED, and it should be
define as 64. Missed it to replace the macro. Nice catch.

>  - p8_events = p8_events_arr[0] would be clearer
>
>> +
>> +	/*
>> +	 * Loop through each property
>> +	 */
>> +	for_each_property_of_node(dev, pp) {
>> +		start = pp->name;
>> +
>> +		if (!strcmp(pp->name, "name")) {
>> +			if (!pp->value ||
>> +			   (strnlen(pp->value, pp->length) == pp->length) ||
>> +			   (pp->length > P8_NEST_MAX_PMU_NAME_LEN))
>> +				return -EINVAL;
>> +
>> +			buf = kzalloc(P8_NEST_MAX_PMU_NAME_LEN, GFP_KERNEL);
>> +			if (!buf)
>> +				return -ENOMEM;
>> +
>> +			/* Save the name to register it later */
>> +			sprintf(buf, "Nest_%s", (char *)pp->value);
>> +			pmu_ptr->pmu.name = (char *)buf;
>> +			continue;
>> +		}
>> +
>> +		/* Skip these, we dont need it */
> "don't" instead of "dont".

Will change it.

>> +		if (!strcmp(pp->name, "phandle") ||
>> +		    !strcmp(pp->name, "device_type") ||
>> +		    !strcmp(pp->name, "linux,phandle"))
>> +			continue;
>> +
>> +		if (strncmp(pp->name, "unit.", 5) == 0) {
>> +			/* Skip first few chars in the name */
> The whole comment is pretty uninformative, as is the similar comment
> below. If you need a comment at all, maybe something along the lines of
> "Strip the prefix because <reason we don't need/want the prefix>"?

Yes will change it. Thanks

>> +			start += 5;
>> +			ret = nest_event_info(pp, start, p8_events++, 1, 0);
>> +		} else if (strncmp(pp->name, "scale.", 6) == 0) {
>> +			/* Skip first few chars in the name */
>> +			start += 6;
>> +			ret = nest_event_info(pp, start, p8_events++, 1, 0);
>> +		} else {
>> +			lval = of_get_property(dev, pp->name, NULL);
>> +			val = (uint32_t)be32_to_cpup(lval);
>> +
>> +			ret = nest_event_info(pp, start, p8_events++, 0, val);
>> +		}
>> +
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* book keeping */
>> +		idx++;
> You don't seem to use idx in this function, apart from incrementing it
> here...?

Used in next patch.

>> +	}
>> +
>> +	return 0;
>> +}
>
