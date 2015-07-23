Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72111A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:27:51 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 19:27:51 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A3D323578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:27:48 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N9RfTW56754396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:27:49 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N9RF2U000733
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:27:16 +1000
Message-ID: <55B0B344.4040407@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 14:56:28 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/7] powerpc/powernv: Nest PMU detection and device
 tree parser
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-4-git-send-email-maddy@linux.vnet.ibm.com>
 <1437536981.30906.9.camel@axtens.net> <55B081B2.4050001@linux.vnet.ibm.com>
 <1437643015.29271.3.camel@ellerman.id.au>
In-Reply-To: <1437643015.29271.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 23 July 2015 02:46 PM, Michael Ellerman wrote:
> On Thu, 2015-07-23 at 11:24 +0530, Madhavan Srinivasan wrote:
>> On Wednesday 22 July 2015 09:19 AM, Daniel Axtens wrote:
>>> Hi,
>>>
>>>> +static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
>>>> +
>>>> +static int nest_ima_dt_parser(void)
>>>> +{
>>>> +	const __be32 *gcid;
>>>> +	const __be64 *chip_ima_reg;
>>>> +	const __be64 *chip_ima_size;
>>>> +	struct device_node *dev;
>>>> +	struct perchip_nest_info *p8ni;
>>>> +	int idx;
>>>> +
>>>> +	/*
>>>> +	 * "nest-ima" folder contains two things,
>>>> +	 * a) per-chip reserved memory region for Nest PMU Counter data
>>>> +	 * b) Support Nest PMU units and their event files
>>>> +	 */
>>>> +	for_each_node_with_property(dev, "ibm,ima-chip") {
>>>> +		gcid = of_get_property(dev, "ibm,chip-id", NULL);
>>>> +		chip_ima_reg = of_get_property(dev, "reg", NULL);
>>>> +		chip_ima_size = of_get_property(dev, "size", NULL);
>>>> +
>>>> +		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
>>>> +			pr_err("Nest_PMU: device %s missing property\n",
>>>> +							dev->full_name);
>>>> +			return -ENODEV;
>>>> +		}
>>>> +
>>>> +		/* chip id to save reserve memory region */
>>>> +		idx = (uint32_t)be32_to_cpup(gcid);
>>> So be32_to_cpup returns a __u32. You're casting to a uint32_t and then
>>> assigning to an int.
>>>  - Do you need the intermediate cast?
>>>  - Should idx be an unsigned type?
>> my bad, sorry abt type case of uint to int.
>> And your are right, idx can be __u32 (__u32 and uint32_t are same i
>> guess). 
> It should be u32. Don't use the uintx_t types in kernel code unless there's
> some good reason for it.
>
> The __u32 etc. types are for things that are exposed to userspace, which this
> is not, so u32 is correct.
>
> Having said that, this code should be using of_property_read_u32() etc.

Ok will change it to use of_property_read_u32.

> And having said that, this is all based on a device tree binding that hasn't
> been reviewed yet on the OPAL side, so it's subject to change too.

Have posted new version in the skiboot mailinglist based on the reviews.
hoping to get it reviewed soon.

Maddy
> cheers
>
>
