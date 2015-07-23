Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF95F1A02B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:16:56 +1000 (AEST)
Message-ID: <1437643015.29271.3.camel@ellerman.id.au>
Subject: Re: [PATCH v5 3/7] powerpc/powernv: Nest PMU detection and device
 tree parser
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 19:16:55 +1000
In-Reply-To: <55B081B2.4050001@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-4-git-send-email-maddy@linux.vnet.ibm.com>
 <1437536981.30906.9.camel@axtens.net> <55B081B2.4050001@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-23 at 11:24 +0530, Madhavan Srinivasan wrote:
> 
> On Wednesday 22 July 2015 09:19 AM, Daniel Axtens wrote:
> > Hi,
> >
> >> +static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
> >> +
> >> +static int nest_ima_dt_parser(void)
> >> +{
> >> +	const __be32 *gcid;
> >> +	const __be64 *chip_ima_reg;
> >> +	const __be64 *chip_ima_size;
> >> +	struct device_node *dev;
> >> +	struct perchip_nest_info *p8ni;
> >> +	int idx;
> >> +
> >> +	/*
> >> +	 * "nest-ima" folder contains two things,
> >> +	 * a) per-chip reserved memory region for Nest PMU Counter data
> >> +	 * b) Support Nest PMU units and their event files
> >> +	 */
> >> +	for_each_node_with_property(dev, "ibm,ima-chip") {
> >> +		gcid = of_get_property(dev, "ibm,chip-id", NULL);
> >> +		chip_ima_reg = of_get_property(dev, "reg", NULL);
> >> +		chip_ima_size = of_get_property(dev, "size", NULL);
> >> +
> >> +		if ((!gcid) || (!chip_ima_reg) || (!chip_ima_size)) {
> >> +			pr_err("Nest_PMU: device %s missing property\n",
> >> +							dev->full_name);
> >> +			return -ENODEV;
> >> +		}
> >> +
> >> +		/* chip id to save reserve memory region */
> >> +		idx = (uint32_t)be32_to_cpup(gcid);
> > So be32_to_cpup returns a __u32. You're casting to a uint32_t and then
> > assigning to an int.
> >  - Do you need the intermediate cast?
> >  - Should idx be an unsigned type?
> 
> my bad, sorry abt type case of uint to int.
> And your are right, idx can be __u32 (__u32 and uint32_t are same i
> guess). 

It should be u32. Don't use the uintx_t types in kernel code unless there's
some good reason for it.

The __u32 etc. types are for things that are exposed to userspace, which this
is not, so u32 is correct.

Having said that, this code should be using of_property_read_u32() etc.

And having said that, this is all based on a device tree binding that hasn't
been reviewed yet on the OPAL side, so it's subject to change too.

cheers
