Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0C5F1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 13:51:15 +1100 (AEDT)
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [150.101.137.143]) by ozlabs.org (Postfix) with ESMTP id 5B87F140271
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2015 13:51:15 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [v2] platforms/powernv: Add support for Nvlink NPUs
Date: Tue, 15 Dec 2015 13:46:56 +1100
Message-ID: <90636120.hOoEVr1fQq@new-mexico>
In-Reply-To: <20151214092627.D98A314030D@ozlabs.org>
References: <20151214092627.D98A314030D@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for the review Michael. I'll do a respin to address the comments below.

On Mon, 14 Dec 2015 20:26:27 Michael Ellerman wrote:
> Hi Alistair,
> 
> Just a few nitty things ...
> 
> On Tue, 2015-10-11 at 02:28:11 UTC, Alistair Popple wrote:
> > NV-Link is a high speed interconnect that is used in conjunction with
> 
> Is it NV-Link or NVLink?

I've seen NV-Link, NVLink and NVLINK in various bits of documentation and 
probably used a mixture of those variations myself. Will standardise on NVLink 
for OPAL and Linux.

> > a PCI-E connection to create an interface between CPU and GPU that
> > provides very high data bandwidth. A PCI-E connection to a GPU is used
> > as the control path to initiate and report status of large data
> > transfers sent via the NV-Link.
> > 
> > On IBM Power systems the NV-Link hardware interface is very similar to
> > the existing PHB3. This patch adds support for this new NPU PHB
> 
> NPU ?

NVLink Processing Unit.

> > type. DMA operations on the NPU are not supported as this patch sets
> > the TCE translation tables to be the same as the related GPU PCIe
> > device for each Nvlink. Therefore all DMA operations are setup and
> > controlled via the PCIe device.
> > 
> > EEH is not presently supported for the NPU devices, although it may be
> > added in future.
> > 
> > Signed-off-by: Alistair Popple <alistair@popple.id.au>
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > ---

<snip>

> > new file mode 100644
> > index 0000000..a1e5ba5
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> > @@ -0,0 +1,339 @@
> > +/*
> > + * This file implements the DMA operations for Nvlink devices. The NPU
> > + * devices all point to the same iommu table as the parent PCI device.
> > + *
> > + * Copyright Alistair Popple, IBM Corporation 2015.
> > + *
> > + * This program is free software; you can redistribute  it and/or modify 
it
> > + * under  the terms of  the GNU General  Public License as published by 
the
> > + * Free Software Foundation;  either version 2 of the  License, or (at 
your
> > + * option) any later version.
> 
> Can you drop the any later part, that's not generally true, see COPYING.
> 
> eg:
> 
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU Lesser General Public License
> + * as published by the Free Software Foundation.

Good point.

<snip>

> > +
> > +/* Returns the PE assoicated with the PCI device of the given
> > + * NPU. Returns the linked pci device if pci_dev != NULL.
> > + */
> 
> Can you reformat all your block comments the right way:
> 
> > +/*
> > + * Returns the PE assoicated with the PCI device of the given
> > + * NPU. Returns the linked pci device if pci_dev != NULL.
> > + */

Sure.

> > +static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct pnv_ioda_pe 
*npe,
> > +						  struct pci_dev **gpdev)
> > +{
> > +	struct pnv_phb *phb;
> > +	struct pci_controller *hose;
> 
> I thought we were trying to use phb rather than hose these days, but dunno.

I'm not sure I follow - what do you mean here?

hose = pci_bus_to_host(pdev->bus);
phb = hose->private_data;

Seems to be a fairly typical pattern in pci-ioda.c to get the struct pnv_phb 
from a struct pci_dev. Is there an alternative I should be using instead?

> > +	struct pci_dev *pdev;
> > +	struct pnv_ioda_pe *pe;
> > +	struct pci_dn *pdn;
> > +
> > +	if (npe->flags & PNV_IODA_PE_PEER) {
> > +		pe = npe->peers[0];
> > +		pdev = pe->pdev;
> > +	} else {
> > +		pdev = pnv_pci_get_gpu_dev(npe->pdev);
> > +		if (!pdev)
> > +			return NULL;
> > +
> > +		pdn = pci_get_pdn(pdev);
> > +		if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
> > +			return NULL;
> > +
> > +		hose = pci_bus_to_host(pdev->bus);
> > +		phb = hose->private_data;
> > +		pe = &phb->ioda.pe_array[pdn->pe_number];
> > +	}
> > +
> > +	if (gpdev)
> > +		*gpdev = pdev;
> > +
> > +	return pe;
> > +}
> > +
> > +void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe)
> > +{
> > +	struct pnv_phb *phb = npe->phb;
> > +
> > +	/* We can only invalidate the whole cache on NPU */
> > +	unsigned long val = (0x8ull << 60);
> 
> Are these masks and shifts documented anywhere?

Not publicly afaik, but it would be good to add the definitions here so I'll 
add the #define's for that register.

> > +	if (phb->type != PNV_PHB_NPU ||
> > +	    !phb->ioda.tce_inval_reg ||
> > +	    !(npe->flags & PNV_IODA_PE_DEV))
> > +		return;
> 
> Should any of those ever happen, or could this be a WARN_ON() ?

Nope. WARN_ON() would be best.

> > +	mb(); /* Ensure above stores are visible */
> 
> What stores?

TCE invalidation requires a write to the TCE table in system memory before 
invalidating the NPU TCE cache by writing values to the tce_inval_reg. The 
barrier ensures that any writes to the TCE table (which occur in the callers 
of this function) are visible to the NPU prior to invalidating the cache.

At least I assume that's what it's there for - to be honest I copied it and 
the vague comment from pnv_pci_ioda2_do_tce_invalidate(). I will add a more 
descriptive comment for NPU :)

> > +	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
> > +}
> > +
> > +void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
> > +				struct iommu_table *tbl,
> > +				unsigned long index,
> > +				unsigned long npages,
> > +				bool rm)
> > +{
> > +	struct pnv_phb *phb = npe->phb;
> > +
> > +	/* We can only invalidate the whole cache on NPU */
> > +	unsigned long val = (0x8ull << 60);
> > +
> > +	if (phb->type != PNV_PHB_NPU ||
> > +	    !phb->ioda.tce_inval_reg ||
> > +	    !(npe->flags & PNV_IODA_PE_DEV))
> > +		return;
> 
> Ditto.
> 
> > +
> > +	mb();
> 
> What's the mb doing?

As above.

> > +	if (rm)
> > +		__asm__ __volatile__("stdcix %0,0,%1" : :
> > +				"r"(cpu_to_be64(val)),
> > +				"r" (phb->ioda.tce_inval_reg_phys) :
> > +				"memory");
> 
> I see this in pci-ioda.c as __raw_rm_writeq(). Can you put that in a shared
> header and use it?

Sure.

> > +	else
> > +		__raw_writeq(cpu_to_be64(val),
> > +			phb->ioda.tce_inval_reg);
> > +}
> > +
> > +void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
> > +{
> > +	struct pnv_ioda_pe *gpe;
> > +	struct pci_dev *gpdev;
> > +	int i, avail = -1;
> > +
> > +	if (!npe->pdev || !(npe->flags & PNV_IODA_PE_DEV))
> > +		return;
> > +
> > +	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
> > +	if (!gpe)
> > +		return;
> > +
> > +	/* Nothing to do if the PEs are already connected */
> 
> Should that comment be on the if below instead?

Yep. And it looks like that block could be simplified a bit as well.

> > +	for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
> > +		if (avail < 0 && !gpe->peers[i])
> > +			avail = i;
> > +
> > +		if (gpe->peers[i] == npe)
> > +			return;
> > +	}
> > +
> > +	if (WARN_ON(avail < 0))
> > +		return;
> > +
> > +	gpe->peers[avail] = npe;
> > +	gpe->flags |= PNV_IODA_PE_PEER;
> 
> I don't see any locking around peers, I assume we're only called single
> threaded? What about hot plug?

It should only be called single threaded. Hot plug is not supported at the 
moment.

> > +
> > +	/* We assume that the NPU devices only have a single peer PE
> > +	 * (the GPU PCIe device PE). */
> > +	npe->peers[0] = gpe;
> 
> How did we ensure avail wasn't 0 ?

We don't. This is the npe (ie. the NVLink PE) which only ever has a single 
peer PE which is the GPU PE (ie. gpe). In other words we never assign anything 
to npe->peers[avail] (although we do to gpe->peers[avail]).

> > +	npe->flags |= PNV_IODA_PE_PEER;
> > +}
> > +
> > +/* For the NPU we want to point the TCE table at the same table as the
> > + * real PCI device.
> > + */
> > +static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
> > +{
> > +	struct pnv_phb *phb = npe->phb;
> > +	struct pci_dev *gpdev;
> > +	struct pnv_ioda_pe *gpe;
> > +	void *addr;
> > +	unsigned int size;
> > +	int64_t rc;
> > +
> > +	/* Find the assoicated PCI devices and get the dma window
> > +	 * information from there.
> > +	 */
> > +	if (!npe->pdev || !(npe->flags & PNV_IODA_PE_DEV))
> > +		return;
> > +
> > +	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
> > +	if (!gpe)
> > +		return;
> > +
> > +	addr = (void *)gpe->table_group.tables[0]->it_base;
> > +	size = gpe->table_group.tables[0]->it_size << 3;
> > +	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> > +					npe->pe_number, 1, __pa(addr),
> > +					size, 0x1000);
> > +	if (rc != OPAL_SUCCESS)
> > +		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
> > +			__func__, rc, phb->hose->global_number, npe-
>pe_number);
> > +
> > +	/* We don't initialise npu_pe->tce32_table as we always use
> > +	 * dma_npu_ops which are nops.
> > +	 */
> > +	set_dma_ops(&npe->pdev->dev, &dma_npu_ops);
> > +}
> > +
> > +/* Enable/disable bypass mode on the NPU. The NPU only supports one
> > + * window per brick, so bypass needs to be explicity enabled or
> 
> brick?

Link. Brick is an old term which should have been removed, obviously I missed 
this one.

> > + * disabled. Unlike for a PHB3 bypass and non-bypass modes can't be
> > + * active at the same time.
> > + */
> > +int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enabled)
> 
> enabled should be "enable", you're asking for it to be enabled, it's not
> already enabled.

Yep.

> > +{
> > +	struct pnv_phb *phb = npe->phb;
> > +	int64_t rc = 0;
> > +
> > +	if (phb->type != PNV_PHB_NPU || !npe->pdev)
> > +		return -EINVAL;
> > +
> > +	if (enabled) {
> > +		/* Enable the bypass window */
> > +		phys_addr_t top = memblock_end_of_DRAM();
> > +
> > +		npe->tce_bypass_base = 0;
> > +		top = roundup_pow_of_two(top);
> > +		dev_info(&npe->pdev->dev, "Enabling bypass for PE %d\n",
> > +			 npe->pe_number);
> > +		rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
> > +					npe->pe_number, npe->pe_number,
> > +					npe->tce_bypass_base, top);
> > +	} else {
> > +		/* Disable the bypass window by replacing it with the
> > +		 * TCE32 window.
> > +		 */
> > +		pnv_npu_disable_bypass(npe);
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
> > +{
> > +	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
> > +	struct pnv_phb *phb = hose->private_data;
> > +	struct pci_dn *pdn = pci_get_pdn(npdev);
> > +	struct pnv_ioda_pe *npe, *gpe;
> > +	struct pci_dev *gpdev;
> > +	uint64_t top;
> > +	bool bypass = false;
> > +
> > +	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
> > +		return -ENXIO;
> > +
> > +	/* We only do bypass if it's enabled on the linked device */
> > +	npe = &phb->ioda.pe_array[pdn->pe_number];
> > +	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
> > +	if (!gpe)
> > +		return -ENODEV;
> > +
> > +	if (gpe->tce_bypass_enabled) {
> > +		top = gpe->tce_bypass_base + memblock_end_of_DRAM() - 1;
> > +		bypass = (dma_mask >= top);
> > +	}
> > +
> > +	if (bypass)
> > +		dev_info(&npdev->dev, "Using 64-bit DMA iommu bypass\n");
> > +	else
> > +		dev_info(&npdev->dev, "Using 32-bit DMA via iommu\n");
> > +
> > +	pnv_npu_dma_set_bypass(npe, bypass);
> > +	*npdev->dev.dma_mask = dma_mask;
> > +
> > +	return 0;
> > +}
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c 
b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index 42b4bb2..8bed20d 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -781,7 +781,8 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, 
struct pnv_ioda_pe *pe)
> >  	}
> > 
> >  	/* Configure PELTV */
> > -	pnv_ioda_set_peltv(phb, pe, true);
> > +	if (phb->type != PNV_PHB_NPU)
> 
> Why not?

Because NPUs don't support it. I will add a comment to that effect.

> > +		pnv_ioda_set_peltv(phb, pe, true);
> > 
> >  	/* Setup reverse map */
> >  	for (rid = pe->rid; rid < rid_end; rid++)
> 
> cheers
