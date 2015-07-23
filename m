Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34CDA1A02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 15:55:57 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 15:55:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3B8022CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 15:55:51 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N5thm41245516
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 15:55:51 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N5tIwJ026586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 15:55:18 +1000
Message-ID: <55B081B2.4050001@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 11:24:58 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/7] powerpc/powernv: Nest PMU detection and device
 tree parser
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-4-git-send-email-maddy@linux.vnet.ibm.com>
 <1437536981.30906.9.camel@axtens.net>
In-Reply-To: <1437536981.30906.9.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 July 2015 09:19 AM, Daniel Axtens wrote:
> Hi,
>
>> +static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
>> +
>> +static int nest_ima_dt_parser(void)
>> +{
>> +	const __be32 *gcid;
>> +	const __be64 *chip_ima_reg;
>> +	const __be64 *chip_ima_size;
>> +	struct device_node *dev;
>> +	struct perchip_nest_info *p8ni;
>> +	int idx;
>> +
>> +	/*
>> +	 * "nest-ima" folder contains two things,
>> +	 * a) per-chip reserved memory region for Nest PMU Counter data
>> +	 * b) Support Nest PMU units and their event files
>> +	 */
>> +	for_each_node_with_property(dev, "ibm,ima-chip") {
>> +		gcid = of_get_property(dev, "ibm,chip-id", NULL);
>> +		chip_ima_reg = of_get_property(dev, "reg", NULL);
>> +		chip_ima_size = of_get_property(dev, "size", NULL);
>> +
>> +		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
>> +			pr_err("Nest_PMU: device %s missing property\n",
>> +							dev->full_name);
>> +			return -ENODEV;
>> +		}
>> +
>> +		/* chip id to save reserve memory region */
>> +		idx = (uint32_t)be32_to_cpup(gcid);
> So be32_to_cpup returns a __u32. You're casting to a uint32_t and then
> assigning to an int.
>  - Do you need the intermediate cast?
>  - Should idx be an unsigned type?

my bad, sorry abt type case of uint to int.
And your are right, idx can be __u32 (__u32 and uint32_t are same i
guess). 

>> +
>> +		/*
>> +		 * Using a local variable to make it compact and
>> +		 * easier to read
>> +		 */
> We probably don't need this comment. But a better variable name would be
> helpful! 

I dont want a long name since i end up with 80 char limit warning.
but let me see.

>> +		p8ni = &p8_nest_perchip_info[idx];
>> +		p8ni->pbase = be64_to_cpup(chip_ima_reg);
>> +		p8ni->size = be64_to_cpup(chip_ima_size);
>> +		p8ni->vbase = (uint64_t) phys_to_virt(p8ni->pbase);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init nest_pmu_init(void)
>> +{
>> +	int ret = -ENODEV;
>> +
>> +	/*
>> +	 * Lets do this only if we are hypervisor
>> +	 */
>> +	if (!cur_cpu_spec->oprofile_cpu_type ||
>> +	    !(strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8") == 0) ||
>> +	    !cpu_has_feature(CPU_FTR_HVMODE))
>> +		return ret;
>> +
> I'm still really uncomfortable with doing this via oprofile_cpu_type.
> If the kernel is compiled without oprofile support, will that get
> populated?

I checked the per thread pmu register code and it all does the name.
But that should not stop nest pmu to enable. So probability,
I can carry only the HV mode check and drop the oprofile check.

>
> I'm also curious about why we need checking for power8 at all. We
> already know we're not going to run on hardware without a nest PMU
> because of the device tree check below. 
> What happens if there's a future generation of chip that supports nest
> PMUs?
>
> If it's really important to check versions in this function, maybe you
> could put a version property in the ibm,ima-chip node?

True. I should not checkout power8 now, since we enable based on device tree
entries for Nest pmu.

>> +	/*
>> +	 * Nest PMU information is grouped under "nest-ima" node
>> +	 * of the top-level device-tree directory. Detect Nest PMU
>> +	 * by the "ibm,ima-chip" property.
>> +	 */
>> +	if (!of_find_node_with_property(NULL, "ibm,ima-chip"))
>> +		return ret;
>> +
>> +	/*
>> +	 * Parse device-tree for Nest PMU information
>> +	 */
>> +	ret = nest_ima_dt_parser();
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +device_initcall(nest_pmu_init);
