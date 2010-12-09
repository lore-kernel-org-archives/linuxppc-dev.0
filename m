Return-Path: <nacc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03694B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 06:09:29 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB9Iplmj008644
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 13:51:49 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E915D72805D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 14:09:25 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB9J9Ojj2367562
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 14:09:24 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oB9J9Ncd020052
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Dec 2010 14:09:24 -0500
Date: Thu, 9 Dec 2010 11:09:20 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: sonnyrao@us.ibm.com, miltonm@bga.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 7/7 v2] ppc: add dynamic dma window support
Message-ID: <20101209190920.GB25003@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-8-git-send-email-nacc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288150518-4026-8-git-send-email-nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26.10.2010 [20:35:17 -0700], Nishanth Aravamudan wrote:
> If firmware allows us to map all of a partition's memory for DMA on a
> particular bridge, create a 1:1 mapping of that memory. Add hooks for
> dealing with hotplug events. Dyanmic DMA windows can use larger than the
> default page size, and we use the largest one possible.
> 
> Not-yet-signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> ---
> 
> I've tested this briefly on a machine with suitable firmware/hardware.
> Things seem to work well, but I want to do more exhaustive I/O testing
> before asking for upstream merging. I would really appreciate any
> feedback on the updated approach.
> 
> Specific questions:
> 
> Ben, did I hook into the dma_set_mask() platform callback as you
> expected? Anything I can do better or which perhaps might lead to
> gotchas later?
> 
> I've added a disable_ddw option, but perhaps it would be better to
> just disable the feature if iommu=force?

So for the final version, I probably should document this option in
kernel-parameters.txt w/ the patch, right?

<snip>

> +static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
> +					unsigned long num_pfn, const void *arg)
> +{
> +	const struct dynamic_dma_window_prop *maprange = arg;
> +	int rc;
> +	u64 tce_size, num_tce, dma_offset, next;
> +	u32 tce_shift;
> +	long limit;
> +
> +	tce_shift = be32_to_cpu(maprange->tce_shift);
> +	tce_size = 1ULL << tce_shift;
> +	next = start_pfn << PAGE_SHIFT;
> +	num_tce = num_pfn << PAGE_SHIFT;
> +
> +	/* round back to the beginning of the tce page size */
> +	num_tce += next & (tce_size - 1);
> +	next &= ~(tce_size - 1);
> +
> +	/* covert to number of tces */
> +	num_tce |= tce_size - 1;
> +	num_tce >>= tce_shift;
> +
> +	do {
> +		/*
> +		 * Set up the page with TCE data, looping through and setting
> +		 * the values.
> +		 */
> +		limit = min_t(long, num_tce, 512);
> +		dma_offset = next + be64_to_cpu(maprange->dma_base);
> +
> +		rc = plpar_tce_stuff(be64_to_cpu(maprange->liobn),
> +					    (u64)dma_offset,
> +					     0, limit);
> +		num_tce -= limit;
> +	} while (num_tce > 0 && !rc);
> +
> +	return rc;
> +}

There is a bit of a typo here, the liobn is a 32-bit value. I've fixed
this is up locally and will update it when I send out the final version
of this patch.

I'm finding that on dlpar remove of adapters running in slots supporting
64-bit DMA, that the plpar_tce_stuff is failing. Can you think of a
reason why? It looks basically the same as the put_indirect below...

> +static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
> +					unsigned long num_pfn, const void *arg)
> +{
> +	const struct dynamic_dma_window_prop *maprange = arg;
> +	u64 *tcep, tce_size, num_tce, dma_offset, next, proto_tce, liobn;
> +	u32 tce_shift;
> +	u64 rc = 0;
> +	long l, limit;
> +
> +	local_irq_disable();	/* to protect tcep and the page behind it */
> +	tcep = __get_cpu_var(tce_page);
> +
> +	if (!tcep) {
> +		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
> +		if (!tcep) {
> +			local_irq_enable();
> +			return -ENOMEM;
> +		}
> +		__get_cpu_var(tce_page) = tcep;
> +	}
> +
> +	proto_tce = TCE_PCI_READ | TCE_PCI_WRITE;
> +
> +	liobn = (u64)be32_to_cpu(maprange->liobn);
> +	tce_shift = be32_to_cpu(maprange->tce_shift);
> +	tce_size = 1ULL << tce_shift;
> +	next = start_pfn << PAGE_SHIFT;
> +	num_tce = num_pfn << PAGE_SHIFT;
> +
> +	/* round back to the beginning of the tce page size */
> +	num_tce += next & (tce_size - 1);
> +	next &= ~(tce_size - 1);
> +
> +	/* covert to number of tces */
> +	num_tce |= tce_size - 1;
> +	num_tce >>= tce_shift;
> +
> +	/* We can map max one pageful of TCEs at a time */
> +	do {
> +		/*
> +		 * Set up the page with TCE data, looping through and setting
> +		 * the values.
> +		 */
> +		limit = min_t(long, num_tce, 4096/TCE_ENTRY_SIZE);
> +		dma_offset = next + be64_to_cpu(maprange->dma_base);
> +
> +		for (l = 0; l < limit; l++) {
> +			tcep[l] = proto_tce | next;
> +			next += tce_size;
> +		}
> +
> +		rc = plpar_tce_put_indirect(liobn,
> +					    (u64)dma_offset,
> +					    (u64)virt_to_abs(tcep),
> +					    limit);
> +
> +		num_tce -= limit;
> +	} while (num_tce > 0 && !rc);
> +                printk("plpar_tce_put_indirect for offset 0x%llx and tcep[0] 0x%llx returned %llu\n",
> +                                (u64)dma_offset, tcep[0], rc);
> +

I'll cleanup the debugging on the final version too.

<snip>

> +static void remove_ddw(struct device_node *np)
> +{
> +	struct dynamic_dma_window_prop *dwp;
> +	struct property *win64;
> +	const u32 *ddr_avail;
> +        u64 liobn;
> +	int len, ret;
> +
> +	ddr_avail = of_get_property(np, "ibm,ddw-applicable", &len);
> +	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
> +	if (!win64 || !ddr_avail || len < 3 * sizeof(u32))
> +		return;
> +
> +	dwp = win64->value;
> +        liobn = (u64)be32_to_cpu(dwp->liobn);
> +
> +	/* clear the whole window, note the arg is in kernel pages */
> +	ret = tce_clearrange_multi_pSeriesLP(0,
> +		1ULL << (be32_to_cpu(dwp->window_shift) - PAGE_SHIFT), dwp);
> +	if (ret)
> +		pr_warning("%s failed to clear tces in window.\n",
> +			 np->full_name);
> +        else
> +		pr_warning("%s successfully cleared tces in window.\n",
> +			 np->full_name);
> +
> +	ret = rtas_call(ddr_avail[2], 1, 1, NULL, liobn);
> +	if (ret)
> +		pr_warning("%s: failed to remove direct window: rtas returned "
> +			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> +			np->full_name, ret, ddr_avail[2], liobn);
> +	else
> +		pr_warning("%s: successfully removed direct window: rtas returned "
> +			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> +			np->full_name, ret, ddr_avail[2], liobn);
> +
> +	ret = prom_remove_property(np, win64);
> +	if (ret)
> +		pr_warning("%s: failed to remove direct window property (%i)\n",
> +			np->full_name, ret);
> +	else
> +		pr_warning("%s: successfully removed direct window property (%i)\n",
> +			np->full_name, ret);
> +}

When this function gets called on dlpar remove of an adapter, it throws
a proc warning because the property has already been removed from
/proc/device-tree (but not the kernel representation) before the
notifiers get called:

static int pSeries_reconfig_remove_node(struct device_node *np)
{
        struct device_node *parent, *child;

        parent = of_get_parent(np);
        if (!parent)
                return -EINVAL;

        if ((child = of_get_next_child(np, NULL))) {
                of_node_put(child);
                of_node_put(parent);
                return -EBUSY;
        }

        remove_node_proc_entries(np);

        blocking_notifier_call_chain(&pSeries_reconfig_chain,
                            PSERIES_RECONFIG_REMOVE, np);
        of_detach_node(np);

        of_node_put(parent);
        of_node_put(np); /* Must decrement the refcount */
        return 0;
}

Am I reading that correctly? Should I add a paramter to remove_ddw that
specifies if it is being called from the reconfig notifier (or perhaps
just whether it needs to remove the property)?

Also, just so I understand, it doesn't seem like dlpar provides an
option for the notifier chain to indicate failure (e.g., the tce stuff
failing above) and prevent the dlpar operation. AFAICT after discussing
with the firmware folks, it's actually non-fatal for the TCEs not to be
cleared during the dlpar remove, but seems like it might indicate an
issue if it happens in the field?

Otherwise, I've hit no problems testing this series under load. Once I
get some feedback on these questions, I'll roll out a new version,
hopefully tomorrow, that can be accepted.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
