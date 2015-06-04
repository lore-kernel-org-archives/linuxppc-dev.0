Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B4CA1A0D3A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 19:53:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 19:53:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 41E0F357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 19:53:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t549rZoe56098966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 19:53:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t549rBxi015817
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 19:53:11 +1000
Message-ID: <55701FF1.7050803@linux.vnet.ibm.com>
Date: Thu, 04 Jun 2015 15:22:49 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 5/9]powerpc/powernv: nest pmu feature detection support
References: <1433260778-26497-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1433260778-26497-6-git-send-email-maddy@linux.vnet.ibm.com>
 <1433290876.438.46.camel@axtens.net>
In-Reply-To: <1433290876.438.46.camel@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 03 June 2015 05:51 AM, Daniel Axtens wrote:
> On Tue, 2015-06-02 at 21:29 +0530, Madhavan Srinivasan wrote:
>> Patch adds a device tree function to detect the nest pmu
>> support. Function will look for specific dt property "ibm,ima-chip"
>> as a detection mechanism for the nest pmu.
>>
>> For Nest pmu, device tree will have two set of information.
>> 1) Per-chip Homer address region for nest pmu counter collection area.
>> 2) Supported Nest PMUs and events
> What's HOMER?
Nest PMUs are configured via PORE engine interface and PORE Engine 
collections the Nest counter
value and updates in the main memory which is reserved for this use.

>>   
>> +static int nest_ima_detect_parse(void)
>> +{
>> +	const __be32 *gcid;
>> +	const __be64 *chip_ima_reg;
>> +	const __be64 *chip_ima_size;
>> +	struct device_node *dev;
>> +	int rc = -EINVAL, idx;
>> +
>> +	for_each_node_with_property(dev, "ibm,ima-chip") {
>> +		gcid = of_get_property(dev, "ibm,chip-id", NULL);
>> +		chip_ima_reg = of_get_property(dev, "reg", NULL);
>> +		chip_ima_size = of_get_property(dev, "size", NULL);
>> +		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
>> +			pr_err("%s: device %s missing property \n",
>> +				__func__, dev->full_name);
> This is not a particularly informative error message. It'd be good if it
> mentioned that it was for PMU.
Sure will changes.

>> +			return rc
>> +		}
>> +
>> +		idx = (uint32_t)be32_to_cpup(gcid);
>> +		p8_perchip_nest_info[idx].pbase = be64_to_cpup(chip_ima_reg);
>> +		p8_perchip_nest_info[idx].size = be64_to_cpup(chip_ima_size);
>> +		p8_perchip_nest_info[idx].vbase = (uint64_t)
>> +			phys_to_virt(p8_perchip_nest_info[idx].pbase);
>> +
>> +		rc = 0;
>> +	}
>> +
>> +	return rc;
> I'm not sure your rc handling is correct. As I understand it:
>   - Start with rc = -EINVAL.
>   - If your first node is missing a property, return -EINVAL.
>   - Once your first node succeeds, set rc = 0
>   - If any subsequent node is missing a property, return 0.
>   - Return 0 if any node is successfully processed, otherwise return
> -EINVAL.
Main loop is only for nodes with property "ibm,ima-chip".  Not all the 
nodes will have this
property.
> If that's what you intended (especially with regards to returning 0 when
> a subsequent node is missing a property), a comment explaining it would
> be great.
Yes. I will add comment explaining it. But i did add this in the commit 
message.

> Also, why bail out if a property is missing on any node? Why not try all
> of them and see if any succeed?
Only the Nest Unit nodes in the device tree will have this property. 
Commit has the
device tree hierarchy for the Nest instrumentation.  So if we dont find 
this property
then Nest instrumentation is not supported, hence bail out.
>
>> +}
>> +
>>   static int __init nest_pmu_init(void)
>>   {
>>   	int ret = 0;
>> @@ -256,6 +287,12 @@ static int __init nest_pmu_init(void)
>>   
>>   	cpumask_chip();
>>   
>> +	/*
>> +	 * Detect the Nest PMU feature
>> +	 */
>> +	if (nest_ima_detect_parse())
>> +		return 0;
>> +
>>   	return 0;
>>   }
> Zero is returned regardless of the output of nest_ima_detect_parse. Is
> that intentional? If so, do you need the 'if'?
No it should return "ret" which should be initialized to error value. 
WIll fix it

>>   device_initcall(nest_pmu_init);
> Regards,
> Daniel Axtens
>
Thanks for the review
MAddy
