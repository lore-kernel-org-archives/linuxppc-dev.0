Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41K19h2yB5zF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 18:48:07 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id h19-v6so2622203itf.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 01:48:07 -0700 (PDT)
Date: Mon, 2 Jul 2018 18:47:56 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 alistair@popple.id.au, tpearson@raptorengineering.com
Subject: Re: [PATCH 2/3] powerpc/powernv: DMA operations for discontiguous
 allocation
Message-ID: <20180702184756.72cfde38@aik.ozlabs.ibm.com>
In-Reply-To: <20180629073437.4060-3-ruscur@russell.cc>
References: <20180629073437.4060-1-ruscur@russell.cc>
 <20180629073437.4060-3-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 29 Jun 2018 17:34:36 +1000
Russell Currey <ruscur@russell.cc> wrote:

> DMA pseudo-bypass is a new set of DMA operations that solve some issues for
> devices that want to address more than 32 bits but can't address the 59
> bits required to enable direct DMA.
> 
> The previous implementation for POWER8/PHB3 worked around this by
> configuring a bypass from the default 32-bit address space into 64-bit
> address space.  This approach does not work for POWER9/PHB4 because
> regions of memory are discontiguous and many devices will be unable to
> address memory beyond the first node.
> 
> Instead, implement a new set of DMA operations that allocate TCEs as DMA
> mappings are requested so that all memory is addressable even when a
> one-to-one mapping between real addresses and DMA addresses isn't
> possible.  These TCEs are the maximum size available on the platform,
> which is 256M on PHB3 and 1G on PHB4.
> 
> Devices can now map any region of memory up to the maximum amount they can
> address according to the DMA mask set, in chunks of the largest available
> TCE size.
> 
> This implementation replaces the need for the existing PHB3 solution and
> should be compatible with future PHB versions.
> 
> It is, however, rather naive.  There is no unmapping, and as a result
> devices can eventually run out of space if they address their entire
> DMA mask worth of TCEs.  An implementation with unmap() will come in
> future (and requires a much more complex implementation), but this is a
> good start due to the drastic performance improvement.


Why does not dma_iommu_ops work in this case? I keep asking and yet no
comment in the commit log or mails...


> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/include/asm/dma-mapping.h    |   1 +
>  arch/powerpc/platforms/powernv/Makefile   |   2 +-
>  arch/powerpc/platforms/powernv/pci-dma.c  | 243 ++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |  82 +++-----
>  arch/powerpc/platforms/powernv/pci.h      |   7 +
>  5 files changed, 281 insertions(+), 54 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/pci-dma.c

Too generic file name for such a hack.


> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 8fa394520af6..354f435160f3 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -74,6 +74,7 @@ static inline unsigned long device_to_mask(struct device *dev)
>  extern struct dma_map_ops dma_iommu_ops;
>  #endif
>  extern const struct dma_map_ops dma_nommu_ops;
> +extern const struct dma_map_ops dma_pseudo_bypass_ops;
>  
>  static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>  {
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 703a350a7f4e..2467bdab3c13 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -6,7 +6,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
>  obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
>  
>  obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
> -obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
> +obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-dma.o
>  obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
>  obj-$(CONFIG_EEH)	+= eeh-powernv.o
>  obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
> diff --git a/arch/powerpc/platforms/powernv/pci-dma.c b/arch/powerpc/platforms/powernv/pci-dma.c
> new file mode 100644
> index 000000000000..79382627c7be
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/pci-dma.c
> @@ -0,0 +1,243 @@
> +/*
> + * DMA operations supporting pseudo-bypass for PHB3+
> + *
> + * Author: Russell Currey <ruscur@russell.cc>
> + *
> + * Copyright 2018 IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/memblock.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/hash.h>
> +
> +#include <asm/pci-bridge.h>
> +#include <asm/ppc-pci.h>
> +#include <asm/pnv-pci.h>
> +#include <asm/tce.h>
> +
> +#include "pci.h"
> +
> +/*
> + * This is a naive implementation that directly operates on TCEs, allocating
> + * on demand.  There is no locking or refcounts since no TCEs are ever removed
> + * and unmap does nothing.
> + */
> +static dma_addr_t dma_pseudo_bypass_get_address(struct device *dev,
> +					    phys_addr_t addr)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_ioda_pe *pe;
> +	u64 i, tce, ret, offset;
> +	__be64 entry;
> +
> +	offset = addr & ((1 << phb->ioda.max_tce_order) - 1);
> +
> +	pe = &phb->ioda.pe_array[pci_get_pdn(pdev)->pe_number];
> +
> +	/* look through the tracking table for a free entry */
> +	for (i = 0; i < pe->tce_count; i++) {
> +		/* skip between 2GB and 4GB */
> +		if ((i << phb->ioda.max_tce_order) >= 0x80000000 &&
> +		    (i << phb->ioda.max_tce_order) < 0x100000000)
> +			continue;
> +
> +		tce = be64_to_cpu(pe->tces[i]);
> +
> +		/* if the TCE is already valid (read + write) */
> +		if ((tce & 3) == 3) {
> +			/* check if we're already allocated, if not move on */
> +			if (tce >> phb->ioda.max_tce_order ==
> +			    addr >> phb->ioda.max_tce_order) {
> +				/* wait for the lock bit to clear */
> +				while (be64_to_cpu(pe->tces[i]) & 4)
> +					cpu_relax();
> +
> +				return (i << phb->ioda.max_tce_order) | offset;
> +			}
> +
> +			continue;
> +		}
> +
> +		/*
> +		 * The TCE isn't being used, so let's try and allocate it.
> +		 * Bits 0 and 1 are read/write, and we use bit 2 as a "lock"
> +		 * bit.  This is to prevent any race where the value is set in
> +		 * the TCE table but the invalidate/mb() hasn't finished yet.
> +		 */
> +		entry = cpu_to_be64((addr - offset) | 7);
> +		ret = cmpxchg(&pe->tces[i], tce, entry);
> +		if (ret != tce) {
> +			/* conflict, start looking again just in case */
> +			i--;
> +			continue;
> +		}
> +		pnv_pci_phb3_tce_invalidate(pe, 0, 0, addr - offset, 1);
> +		mb();
> +		/* clear the lock bit now that we know it's active */
> +		ret = cmpxchg(&pe->tces[i], entry, cpu_to_be64((addr - offset) | 3));
> +		if (ret != entry) {
> +			/* conflict, start looking again just in case */
> +			i--;
> +			continue;
> +		}
> +
> +		return (i << phb->ioda.max_tce_order) | offset;
> +	}
> +	/* If we get here, the table must be full, so error out. */
> +	return -1ULL;
> +}
> +
> +/*
> + * For now, don't actually do anything on unmap.
> + */
> +static void dma_pseudo_bypass_unmap_address(struct device *dev, dma_addr_t dma_addr)
> +{
> +}
> +
> +static int dma_pseudo_bypass_dma_supported(struct device *dev, u64 mask)
> +{
> +	/*
> +	 * Normally dma_supported() checks if the mask is capable of addressing
> +	 * all of memory.  Since we map physical memory in chunks that the
> +	 * device can address, the device will be able to address whatever it
> +	 * wants - just not all at once.
> +	 */
> +	return 1;
> +}
> +
> +static void *dma_pseudo_bypass_alloc_coherent(struct device *dev,
> +					  size_t size,
> +					  dma_addr_t *dma_handle,
> +					  gfp_t flag,
> +					  unsigned long attrs)
> +{
> +	void *ret;
> +	struct page *page;
> +	int node = dev_to_node(dev);
> +
> +	/* ignore region specifiers */
> +	flag &= ~(__GFP_HIGHMEM);
> +
> +	page = alloc_pages_node(node, flag, get_order(size));
> +	if (page == NULL)
> +		return NULL;
> +	ret = page_address(page);
> +	memset(ret, 0, size);
> +	*dma_handle = dma_pseudo_bypass_get_address(dev, __pa(ret));
> +
> +	return ret;
> +}
> +
> +static void dma_pseudo_bypass_free_coherent(struct device *dev,
> +					 size_t size,
> +					 void *vaddr,
> +					 dma_addr_t dma_handle,
> +					 unsigned long attrs)
> +{
> +	free_pages((unsigned long)vaddr, get_order(size));
> +}
> +
> +static int dma_pseudo_bypass_mmap_coherent(struct device *dev,
> +				       struct vm_area_struct *vma,
> +				       void *cpu_addr,
> +				       dma_addr_t handle,
> +				       size_t size,
> +				       unsigned long attrs)
> +{
> +	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> +
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       pfn + vma->vm_pgoff,
> +			       vma->vm_end - vma->vm_start,
> +			       vma->vm_page_prot);
> +}
> +
> +static inline dma_addr_t dma_pseudo_bypass_map_page(struct device *dev,
> +						struct page *page,
> +						unsigned long offset,
> +						size_t size,
> +						enum dma_data_direction dir,
> +						unsigned long attrs)
> +{
> +	BUG_ON(dir == DMA_NONE);
> +
> +	return dma_pseudo_bypass_get_address(dev, page_to_phys(page) + offset);
> +}
> +
> +static inline void dma_pseudo_bypass_unmap_page(struct device *dev,
> +					 dma_addr_t dma_address,
> +					 size_t size,
> +					 enum dma_data_direction direction,
> +					 unsigned long attrs)
> +{
> +	dma_pseudo_bypass_unmap_address(dev, dma_address);
> +}
> +
> +
> +static int dma_pseudo_bypass_map_sg(struct device *dev, struct scatterlist *sgl,
> +			     int nents, enum dma_data_direction direction,
> +			     unsigned long attrs)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		sg->dma_address = dma_pseudo_bypass_get_address(dev, sg_phys(sg));
> +		sg->dma_length = sg->length;
> +
> +		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
> +	}
> +
> +	return nents;
> +}
> +
> +static void dma_pseudo_bypass_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +				int nents, enum dma_data_direction direction,
> +				unsigned long attrs)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		dma_pseudo_bypass_unmap_address(dev, sg->dma_address);
> +	}
> +}
> +
> +static u64 dma_pseudo_bypass_get_required_mask(struct device *dev)
> +{
> +	/*
> +	 * there's no limitation on our end, the driver should just call
> +	 * set_mask() with as many bits as the device can address.
> +	 */
> +	return -1ULL;
> +}
> +
> +static int dma_pseudo_bypass_mapping_error(struct device *dev, dma_addr_t dma_addr)
> +{
> +	return dma_addr == -1ULL;




> +}
> +
> +
> +const struct dma_map_ops dma_pseudo_bypass_ops = {
> +	.alloc				= dma_pseudo_bypass_alloc_coherent,
> +	.free				= dma_pseudo_bypass_free_coherent,
> +	.mmap				= dma_pseudo_bypass_mmap_coherent,
> +	.map_sg				= dma_pseudo_bypass_map_sg,
> +	.unmap_sg			= dma_pseudo_bypass_unmap_sg,
> +	.dma_supported			= dma_pseudo_bypass_dma_supported,
> +	.map_page			= dma_pseudo_bypass_map_page,
> +	.unmap_page			= dma_pseudo_bypass_unmap_page,
> +	.get_required_mask		= dma_pseudo_bypass_get_required_mask,
> +	.mapping_error			= dma_pseudo_bypass_mapping_error,
> +};
> +EXPORT_SYMBOL(dma_pseudo_bypass_ops);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 17c590087279..d2ca214610fd 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1088,6 +1088,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>  	pe->pbus = NULL;
>  	pe->mve_number = -1;
>  	pe->rid = dev->bus->number << 8 | pdn->devfn;
> +	pe->tces = NULL;
>  
>  	pe_info(pe, "Associated device to PE\n");
>  
> @@ -1569,6 +1570,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>  		pe->mve_number = -1;
>  		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
>  			   pci_iov_virtfn_devfn(pdev, vf_index);
> +		pe->tces = NULL;
>  
>  		pe_info(pe, "VF %04d:%02d:%02d.%d associated with PE#%x\n",
>  			hose->global_number, pdev->bus->number,
> @@ -1774,43 +1776,22 @@ static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
>  	return true;
>  }
>  
> -/*
> - * Reconfigure TVE#0 to be usable as 64-bit DMA space.
> - *
> - * The first 4GB of virtual memory for a PE is reserved for 32-bit accesses.
> - * Devices can only access more than that if bit 59 of the PCI address is set
> - * by hardware, which indicates TVE#1 should be used instead of TVE#0.
> - * Many PCI devices are not capable of addressing that many bits, and as a
> - * result are limited to the 4GB of virtual memory made available to 32-bit
> - * devices in TVE#0.
> - *
> - * In order to work around this, reconfigure TVE#0 to be suitable for 64-bit
> - * devices by configuring the virtual memory past the first 4GB inaccessible
> - * by 64-bit DMAs.  This should only be used by devices that want more than
> - * 4GB, and only on PEs that have no 32-bit devices.
> - *
> - * Currently this will only work on PHB3 (POWER8).
> - */
> -static int pnv_pci_ioda_dma_64bit_bypass(struct pnv_ioda_pe *pe)
> +static int pnv_pci_pseudo_bypass_setup(struct pnv_ioda_pe *pe)
>  {
> -	u64 window_size, table_size, tce_count, addr;
> +	u64 tce_count, table_size, window_size;
> +	struct pnv_phb *p = pe->phb;
>  	struct page *table_pages;
> -	u64 tce_order = 28; /* 256MB TCEs */
>  	__be64 *tces;
> -	s64 rc;
> +	int rc = -ENOMEM;
>  
> -	/*
> -	 * Window size needs to be a power of two, but needs to account for
> -	 * shifting memory by the 4GB offset required to skip 32bit space.
> -	 */
> -	window_size = roundup_pow_of_two(memory_hotplug_max() + (1ULL << 32));
> -	tce_count = window_size >> tce_order;
> +	window_size = roundup_pow_of_two(memory_hotplug_max());
> +	tce_count = window_size >> p->ioda.max_tce_order;
>  	table_size = tce_count << 3;
>  
>  	if (table_size < PAGE_SIZE)
>  		table_size = PAGE_SIZE;
>  
> -	table_pages = alloc_pages_node(pe->phb->hose->node, GFP_KERNEL,
> +	table_pages = alloc_pages_node(p->hose->node, GFP_KERNEL,
>  				       get_order(table_size));


pnv_pci_ioda2_create_table() allocates the table, why does not it work for this task?


>  	if (!table_pages)
>  		goto err;
> @@ -1821,26 +1802,23 @@ static int pnv_pci_ioda_dma_64bit_bypass(struct pnv_ioda_pe *pe)
>  
>  	memset(tces, 0, table_size);
>  
> -	for (addr = 0; addr < memory_hotplug_max(); addr += (1 << tce_order)) {
> -		tces[(addr + (1ULL << 32)) >> tce_order] =
> -			cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
> -	}
> +	pe->tces = tces;
> +	pe->tce_count = tce_count;
>  
>  	rc = opal_pci_map_pe_dma_window(pe->phb->opal_id,
>  					pe->pe_number,
> -					/* reconfigure window 0 */
>  					(pe->pe_number << 1) + 0,
>  					1,
>  					__pa(tces),
>  					table_size,
> -					1 << tce_order);
> +					1 << p->ioda.max_tce_order);
>  	if (rc == OPAL_SUCCESS) {
> -		pe_info(pe, "Using 64-bit DMA iommu bypass (through TVE#0)\n");
> +		pe_info(pe, "TCE tables configured for pseudo-bypass\n");
>  		return 0;
>  	}
>  err:
> -	pe_err(pe, "Error configuring 64-bit DMA bypass\n");
> -	return -EIO;
> +	pe_err(pe, "error configuring pseudo-bypass\n");
> +	return rc;
>  }
>  
>  static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
> @@ -1851,7 +1829,6 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
>  	struct pnv_ioda_pe *pe;
>  	uint64_t top;
>  	bool bypass = false;
> -	s64 rc;
>  
>  	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
>  		return -ENODEV;
> @@ -1868,21 +1845,15 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
>  	} else {
>  		/*
>  		 * If the device can't set the TCE bypass bit but still wants
> -		 * to access 4GB or more, on PHB3 we can reconfigure TVE#0 to
> -		 * bypass the 32-bit region and be usable for 64-bit DMAs.
> -		 * The device needs to be able to address all of this space.
> +		 * to access 4GB or more, we need to use a different set of DMA
> +		 * operations with an indirect mapping.
>  		 */
>  		if (dma_mask >> 32 &&
> -		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
> -		    pnv_pci_ioda_pe_single_vendor(pe) &&
> -		    phb->model == PNV_PHB_MODEL_PHB3) {
> -			/* Configure the bypass mode */
> -			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
> -			if (rc)
> -				return rc;
> -			/* 4GB offset bypasses 32-bit space */
> -			set_dma_offset(&pdev->dev, (1ULL << 32));
> -			set_dma_ops(&pdev->dev, &dma_nommu_ops);
> +		    phb->model != PNV_PHB_MODEL_P7IOC &&
> +		    pnv_pci_ioda_pe_single_vendor(pe)) {
> +			if (!pe->tces)
> +				pnv_pci_pseudo_bypass_setup(pe);
> +			set_dma_ops(&pdev->dev, &dma_pseudo_bypass_ops);
>  		} else if (dma_mask >> 32 && dma_mask != DMA_BIT_MASK(64)) {
>  			/*
>  			 * Fail the request if a DMA mask between 32 and 64 bits
> @@ -2071,7 +2042,7 @@ static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
>  	__raw_writeq_be(val, invalidate);
>  }
>  
> -static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
> +void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
>  					unsigned shift, unsigned long index,
>  					unsigned long npages)
>  {
> @@ -2611,10 +2582,15 @@ static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>  static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
>  {
>  	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
> -						table_group);
> +					      table_group);
> +
>  	/* Store @tbl as pnv_pci_ioda2_unset_window() resets it */
>  	struct iommu_table *tbl = pe->table_group.tables[0];
>  
> +	if (pe->tces)
> +		free_pages((unsigned long)pe->tces,
> +			   get_order(pe->tce_count << 3));
> +
>  	pnv_pci_ioda2_set_bypass(pe, false);
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>  	if (pe->pbus)
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index c9952def5e93..56846ddc76a2 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -70,6 +70,10 @@ struct pnv_ioda_pe {
>  	bool			tce_bypass_enabled;
>  	uint64_t		tce_bypass_base;
>  
> +	/* TCE tables for DMA pseudo-bypass */
> +	__be64			*tces;
> +	u64			tce_count;


pnv_ioda_pe::table_group::tables[0] has a pointer to pages, a table size in entries and a page size, why duplicate all of this again?


> +
>  	/* MSIs. MVE index is identical for for 32 and 64 bit MSI
>  	 * and -1 if not supported. (It's actually identical to the
>  	 * PE number)
> @@ -211,6 +215,9 @@ extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
>  extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
>  		unsigned long *hpa, enum dma_data_direction *direction);
>  extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> +extern void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
> +					unsigned shift, unsigned long index,
> +					unsigned long npages);
>  
>  void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>  				unsigned char *log_buff);
> -- 
> 2.17.1
> 



--
Alexey
