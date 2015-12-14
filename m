Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C5141A010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:26:28 +1100 (AEDT)
In-Reply-To: <1447122491-27573-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: Re: [v2] platforms/powernv: Add support for Nvlink NPUs
Message-Id: <20151214092627.D98A314030D@ozlabs.org>
Date: Mon, 14 Dec 2015 20:26:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alistair,

Just a few nitty things ...

On Tue, 2015-10-11 at 02:28:11 UTC, Alistair Popple wrote:
> NV-Link is a high speed interconnect that is used in conjunction with

Is it NV-Link or NVLink?

> a PCI-E connection to create an interface between CPU and GPU that
> provides very high data bandwidth. A PCI-E connection to a GPU is used
> as the control path to initiate and report status of large data
> transfers sent via the NV-Link.
> 
> On IBM Power systems the NV-Link hardware interface is very similar to
> the existing PHB3. This patch adds support for this new NPU PHB

NPU ?

> type. DMA operations on the NPU are not supported as this patch sets
> the TCE translation tables to be the same as the related GPU PCIe
> device for each Nvlink. Therefore all DMA operations are setup and
> controlled via the PCIe device.
> 
> EEH is not presently supported for the NPU devices, although it may be
> added in future.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> 
> This patch includes the following changes from v1:
>  - Minor variable name updates and code refactors suggested by Gavin
>  - Fixes for an issue with TCE cache invalidation
> 
>  arch/powerpc/include/asm/pci.h            |   4 +
>  arch/powerpc/platforms/powernv/Makefile   |   2 +-
>  arch/powerpc/platforms/powernv/npu-dma.c  | 339 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 132 +++++++++++-
>  arch/powerpc/platforms/powernv/pci.c      |   4 +
>  arch/powerpc/platforms/powernv/pci.h      |  19 ++
>  6 files changed, 488 insertions(+), 12 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/npu-dma.c
> 
> --
> 2.1.4
> 
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index 3453bd8..6f8065a 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -149,4 +149,8 @@ extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
>  extern void pcibios_scan_phb(struct pci_controller *hose);
> 
>  #endif	/* __KERNEL__ */
> +
> +extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
> +extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
> +
>  #endif /* __ASM_POWERPC_PCI_H */
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 1c8cdb6..ee774e8 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -4,7 +4,7 @@ obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
>  obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
> 
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
> -obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
> +obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o npu-dma.o
>  obj-$(CONFIG_EEH)	+= eeh-powernv.o
>  obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
>  obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> new file mode 100644
> index 0000000..a1e5ba5
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -0,0 +1,339 @@
> +/*
> + * This file implements the DMA operations for Nvlink devices. The NPU
> + * devices all point to the same iommu table as the parent PCI device.
> + *
> + * Copyright Alistair Popple, IBM Corporation 2015.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.

Can you drop the any later part, that's not generally true, see COPYING.

eg:

+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.

> + */
> +
> +#include <linux/export.h>
> +#include <linux/pci.h>
> +#include <linux/memblock.h>
> +
> +#include <asm/iommu.h>
> +#include <asm/pnv-pci.h>
> +#include <asm/msi_bitmap.h>
> +#include <asm/opal.h>
> +
> +#include "powernv.h"
> +#include "pci.h"
> +
> +static struct pci_dev *get_pci_dev(struct device_node *dn)
> +{
> +	return PCI_DN(dn)->pcidev;
> +}
> +
> +/* Given a NPU device get the associated PCI device. */
> +struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev)
> +{
> +	struct device_node *dn;
> +	struct pci_dev *gpdev;
> +
> +	/* Get assoicated PCI device */
> +	dn = of_parse_phandle(npdev->dev.of_node, "ibm,gpu", 0);
> +	if (!dn)
> +		return NULL;
> +
> +	gpdev = get_pci_dev(dn);
> +	of_node_put(dn);
> +
> +	return gpdev;
> +}
> +EXPORT_SYMBOL(pnv_pci_get_gpu_dev);
> +
> +/* Given the real PCI device get a linked NPU device. */
> +struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
> +{
> +	struct device_node *dn;
> +	struct pci_dev *npdev;
> +
> +	/* Get assoicated PCI device */
> +	dn = of_parse_phandle(gpdev->dev.of_node, "ibm,npu", index);
> +	if (!dn)
> +		return NULL;
> +
> +	npdev = get_pci_dev(dn);
> +	of_node_put(dn);
> +
> +	return npdev;
> +}
> +EXPORT_SYMBOL(pnv_pci_get_npu_dev);
> +
> +#define NPU_DMA_OP_UNSUPPORTED()					\
> +	dev_err_once(dev, "%s operation unsupported for Nvlink devices\n", \
> +		__func__)
> +
> +static void *dma_npu_alloc(struct device *dev, size_t size,
> +			   dma_addr_t *dma_handle, gfp_t flag,
> +			   struct dma_attrs *attrs)
> +{
> +	NPU_DMA_OP_UNSUPPORTED();
> +	return NULL;
> +}
> +
> +static void dma_npu_free(struct device *dev, size_t size,
> +			 void *vaddr, dma_addr_t dma_handle,
> +			 struct dma_attrs *attrs)
> +{
> +	NPU_DMA_OP_UNSUPPORTED();
> +}
> +
> +static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
> +				   unsigned long offset, size_t size,
> +				   enum dma_data_direction direction,
> +				   struct dma_attrs *attrs)
> +{
> +	NPU_DMA_OP_UNSUPPORTED();
> +	return 0;
> +}
> +
> +static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
> +			  int nelems, enum dma_data_direction direction,
> +			  struct dma_attrs *attrs)
> +{
> +	NPU_DMA_OP_UNSUPPORTED();
> +	return 0;
> +}
> +
> +static int dma_npu_dma_supported(struct device *dev, u64 mask)
> +{
> +	NPU_DMA_OP_UNSUPPORTED();
> +	return 0;
> +}
> +
> +static u64 dma_npu_get_required_mask(struct device *dev)
> +{
> +	NPU_DMA_OP_UNSUPPORTED();
> +	return 0;
> +}
> +
> +struct dma_map_ops dma_npu_ops = {
> +	.map_page		= dma_npu_map_page,
> +	.map_sg			= dma_npu_map_sg,
> +	.alloc			= dma_npu_alloc,
> +	.free			= dma_npu_free,
> +	.dma_supported		= dma_npu_dma_supported,
> +	.get_required_mask	= dma_npu_get_required_mask,
> +};
> +
> +/* Returns the PE assoicated with the PCI device of the given
> + * NPU. Returns the linked pci device if pci_dev != NULL.
> + */

Can you reformat all your block comments the right way:

> +/*
> + * Returns the PE assoicated with the PCI device of the given
> + * NPU. Returns the linked pci device if pci_dev != NULL.
> + */

> +static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct pnv_ioda_pe *npe,
> +						  struct pci_dev **gpdev)
> +{
> +	struct pnv_phb *phb;
> +	struct pci_controller *hose;

I thought we were trying to use phb rather than hose these days, but dunno.

> +	struct pci_dev *pdev;
> +	struct pnv_ioda_pe *pe;
> +	struct pci_dn *pdn;
> +
> +	if (npe->flags & PNV_IODA_PE_PEER) {
> +		pe = npe->peers[0];
> +		pdev = pe->pdev;
> +	} else {
> +		pdev = pnv_pci_get_gpu_dev(npe->pdev);
> +		if (!pdev)
> +			return NULL;
> +
> +		pdn = pci_get_pdn(pdev);
> +		if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
> +			return NULL;
> +
> +		hose = pci_bus_to_host(pdev->bus);
> +		phb = hose->private_data;
> +		pe = &phb->ioda.pe_array[pdn->pe_number];
> +	}
> +
> +	if (gpdev)
> +		*gpdev = pdev;
> +
> +	return pe;
> +}
> +
> +void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe)
> +{
> +	struct pnv_phb *phb = npe->phb;
> +
> +	/* We can only invalidate the whole cache on NPU */
> +	unsigned long val = (0x8ull << 60);

Are these masks and shifts documented anywhere?

> +	if (phb->type != PNV_PHB_NPU ||
> +	    !phb->ioda.tce_inval_reg ||
> +	    !(npe->flags & PNV_IODA_PE_DEV))
> +		return;

Should any of those ever happen, or could this be a WARN_ON() ?

> +	mb(); /* Ensure above stores are visible */

What stores?

> +	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
> +}
> +
> +void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
> +				struct iommu_table *tbl,
> +				unsigned long index,
> +				unsigned long npages,
> +				bool rm)
> +{
> +	struct pnv_phb *phb = npe->phb;
> +
> +	/* We can only invalidate the whole cache on NPU */
> +	unsigned long val = (0x8ull << 60);
> +
> +	if (phb->type != PNV_PHB_NPU ||
> +	    !phb->ioda.tce_inval_reg ||
> +	    !(npe->flags & PNV_IODA_PE_DEV))
> +		return;

Ditto.

> +
> +	mb();

What's the mb doing?

> +	if (rm)
> +		__asm__ __volatile__("stdcix %0,0,%1" : :
> +				"r"(cpu_to_be64(val)),
> +				"r" (phb->ioda.tce_inval_reg_phys) :
> +				"memory");

I see this in pci-ioda.c as __raw_rm_writeq(). Can you put that in a shared
header and use it?

> +	else
> +		__raw_writeq(cpu_to_be64(val),
> +			phb->ioda.tce_inval_reg);
> +}
> +
> +void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
> +{
> +	struct pnv_ioda_pe *gpe;
> +	struct pci_dev *gpdev;
> +	int i, avail = -1;
> +
> +	if (!npe->pdev || !(npe->flags & PNV_IODA_PE_DEV))
> +		return;
> +
> +	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
> +	if (!gpe)
> +		return;
> +
> +	/* Nothing to do if the PEs are already connected */

Should that comment be on the if below instead?

> +	for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
> +		if (avail < 0 && !gpe->peers[i])
> +			avail = i;
> +
> +		if (gpe->peers[i] == npe)
> +			return;
> +	}
> +
> +	if (WARN_ON(avail < 0))
> +		return;
> +
> +	gpe->peers[avail] = npe;
> +	gpe->flags |= PNV_IODA_PE_PEER;

I don't see any locking around peers, I assume we're only called single
threaded? What about hot plug?

> +
> +	/* We assume that the NPU devices only have a single peer PE
> +	 * (the GPU PCIe device PE). */
> +	npe->peers[0] = gpe;

How did we ensure avail wasn't 0 ?

> +	npe->flags |= PNV_IODA_PE_PEER;
> +}
> +
> +/* For the NPU we want to point the TCE table at the same table as the
> + * real PCI device.
> + */
> +static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
> +{
> +	struct pnv_phb *phb = npe->phb;
> +	struct pci_dev *gpdev;
> +	struct pnv_ioda_pe *gpe;
> +	void *addr;
> +	unsigned int size;
> +	int64_t rc;
> +
> +	/* Find the assoicated PCI devices and get the dma window
> +	 * information from there.
> +	 */
> +	if (!npe->pdev || !(npe->flags & PNV_IODA_PE_DEV))
> +		return;
> +
> +	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
> +	if (!gpe)
> +		return;
> +
> +	addr = (void *)gpe->table_group.tables[0]->it_base;
> +	size = gpe->table_group.tables[0]->it_size << 3;
> +	rc = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> +					npe->pe_number, 1, __pa(addr),
> +					size, 0x1000);
> +	if (rc != OPAL_SUCCESS)
> +		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
> +			__func__, rc, phb->hose->global_number, npe->pe_number);
> +
> +	/* We don't initialise npu_pe->tce32_table as we always use
> +	 * dma_npu_ops which are nops.
> +	 */
> +	set_dma_ops(&npe->pdev->dev, &dma_npu_ops);
> +}
> +
> +/* Enable/disable bypass mode on the NPU. The NPU only supports one
> + * window per brick, so bypass needs to be explicity enabled or

brick?

> + * disabled. Unlike for a PHB3 bypass and non-bypass modes can't be
> + * active at the same time.
> + */
> +int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enabled)

enabled should be "enable", you're asking for it to be enabled, it's not
already enabled.

> +{
> +	struct pnv_phb *phb = npe->phb;
> +	int64_t rc = 0;
> +
> +	if (phb->type != PNV_PHB_NPU || !npe->pdev)
> +		return -EINVAL;
> +
> +	if (enabled) {
> +		/* Enable the bypass window */
> +		phys_addr_t top = memblock_end_of_DRAM();
> +
> +		npe->tce_bypass_base = 0;
> +		top = roundup_pow_of_two(top);
> +		dev_info(&npe->pdev->dev, "Enabling bypass for PE %d\n",
> +			 npe->pe_number);
> +		rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
> +					npe->pe_number, npe->pe_number,
> +					npe->tce_bypass_base, top);
> +	} else {
> +		/* Disable the bypass window by replacing it with the
> +		 * TCE32 window.
> +		 */
> +		pnv_npu_disable_bypass(npe);
> +	}
> +
> +	return rc;
> +}
> +
> +int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	struct pci_dn *pdn = pci_get_pdn(npdev);
> +	struct pnv_ioda_pe *npe, *gpe;
> +	struct pci_dev *gpdev;
> +	uint64_t top;
> +	bool bypass = false;
> +
> +	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
> +		return -ENXIO;
> +
> +	/* We only do bypass if it's enabled on the linked device */
> +	npe = &phb->ioda.pe_array[pdn->pe_number];
> +	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
> +	if (!gpe)
> +		return -ENODEV;
> +
> +	if (gpe->tce_bypass_enabled) {
> +		top = gpe->tce_bypass_base + memblock_end_of_DRAM() - 1;
> +		bypass = (dma_mask >= top);
> +	}
> +
> +	if (bypass)
> +		dev_info(&npdev->dev, "Using 64-bit DMA iommu bypass\n");
> +	else
> +		dev_info(&npdev->dev, "Using 32-bit DMA via iommu\n");
> +
> +	pnv_npu_dma_set_bypass(npe, bypass);
> +	*npdev->dev.dma_mask = dma_mask;
> +
> +	return 0;
> +}
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 42b4bb2..8bed20d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -781,7 +781,8 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>  	}
> 
>  	/* Configure PELTV */
> -	pnv_ioda_set_peltv(phb, pe, true);
> +	if (phb->type != PNV_PHB_NPU)

Why not?

> +		pnv_ioda_set_peltv(phb, pe, true);
> 
>  	/* Setup reverse map */
>  	for (rid = pe->rid; rid < rid_end; rid++)

cheers
