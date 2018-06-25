Return-Path: <aik@ozlabs.ru>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41DZZl5lFVzF16W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 13:35:58 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 31-v6so6146417plc.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 20:35:58 -0700 (PDT)
Date: Mon, 25 Jun 2018 13:35:48 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/7] powerpc/powernv: DMA operations for discontiguous
Message-ID: <20180625133548.471da8ac@aik.ozlabs.ibm.com>
In-Reply-To: <813333447.2569248.1529797982244.JavaMail.zimbra@raptorengineeringinc.com>
References: <813333447.2569248.1529797982244.JavaMail.zimbra@raptorengineeringinc.com>
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

On Sat, 23 Jun 2018 18:53:02 -0500 (CDT)
Timothy Pearson <tpearson@raptorengineering.com> wrote:

>  allocation
> 
> Cognitive DMA is a new set of DMA operations that solve some issues for
> devices that want to address more than 32 bits but can't address the 59
> bits required to enable direct DMA.
> 
> The previous implementation for POWER8/PHB3 worked around this by
> configuring a bypass from the default 32-bit address space into 64-bit
> address space.  This approach does not work for POWER9/PHB4 because
> regions of memory are discontiguous and many devices will be unable to
> address memory beyond the first node.

Why does not it work precisely? If we use 1GB pages, the table will be
able to cover all the memory.

> Instead, implement a new set of DMA operations that allocate TCEs as DMA
> mappings are requested so that all memory is addressable even when a
> one-to-one mapping between real addresses and DMA addresses isn't
> possible. 

Why does not dma_iommu_ops in this case? It is not limited by table
size or page size and should just work for this case too.

> These TCEs are the maximum size available on the platform,
> which is 256M on PHB3 and 1G on PHB4.


Do we have PHB3 systems with sparse memory to test this or it is dead
code?


> Devices can now map any region of memory up to the maximum amount they can
> address according to the DMA mask set, in chunks of the largest available
> TCE size.
> 
> This implementation replaces the need for the existing PHB3 solution and
> should be compatible with future PHB versions.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/include/asm/dma-mapping.h    |   1 +
>  arch/powerpc/platforms/powernv/Makefile   |   2 +-
>  arch/powerpc/platforms/powernv/pci-dma.c  | 319 ++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c | 102 +++----
>  arch/powerpc/platforms/powernv/pci.h      |   7 +
>  5 files changed, 381 insertions(+), 50 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/pci-dma.c
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
> index 000000000000..1d5409be343e
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/pci-dma.c
> @@ -0,0 +1,319 @@
> +/*
> + * DMA operations supporting pseudo-bypass for PHB3+

License header is missing, run scripts/checkpatch.pl before posting.


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
> +/* select and allocate a TCE using the bitmap */
> +static int dma_pseudo_bypass_select_tce(struct pnv_ioda_pe *pe, phys_addr_t addr)
> +{
> +	int tce;
> +	__be64 old, new;
> +
> +	spin_lock(&pe->tce_alloc_lock);
> +	tce = bitmap_find_next_zero_area(pe->tce_bitmap,
> +					 pe->tce_count,
> +					 0,
> +					 1,
> +					 0);
> +	bitmap_set(pe->tce_bitmap, tce, 1);
> +	old = pe->tces[tce];
> +	new = cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
> +	pe->tces[tce] = new;
> +	pe_info(pe, "allocating TCE %i 0x%016llx (old 0x%016llx)\n",
> +		tce, new, old);
> +	spin_unlock(&pe->tce_alloc_lock);
> +
> +	return tce;
> +}
> +
> +/*
> + * The tracking table for assigning TCEs has two entries per TCE.
> + * - @entry1 contains the physical address and the smallest bit indicates
> + *     if it's currently valid.
> + * - @entry2 contains the DMA address returned in the upper 34 bits, and a
> + *     refcount in the lower 30 bits.
> + */
> +static dma_addr_t dma_pseudo_bypass_get_address(struct device *dev,
> +					    phys_addr_t addr)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_ioda_pe *pe;
> +        u64 i, entry1, entry2, dma_prefix, tce, ret;
> +	u64 offset = addr & ((1 << phb->ioda.max_tce_order) - 1);
> +
> +	pe = &phb->ioda.pe_array[pci_get_pdn(pdev)->pe_number];
> +
> +	/* look through the tracking table for a free entry */
> +	for (i = 0; i < pe->tce_count; i++) {
> +		entry1 = pe->tce_tracker[i * 2];
> +		entry2 = pe->tce_tracker[i * 2 + 1];
> +		dma_prefix = entry2 >> 34;


Magic value of 34?


> +
> +		/* if the address is the same and the entry is valid */
> +		if (entry1 == ((addr - offset) | 1)) {
> +			/* all we need to do here is increment the refcount */
> +			ret = cmpxchg(&pe->tce_tracker[i * 2 + 1],
> +				      entry2, entry2 + 1);
> +			if (ret != entry2) {
> +				/* conflict, start looking again just in case */
> +				i--;
> +				continue;
> +			}
> +			return (dma_prefix << phb->ioda.max_tce_order) | offset;
> +		/* if the entry is invalid then we want to replace it */
> +		} else if (!(entry1 & 1)) {
> +			/* set the real address, note that it isn't valid yet */
> +			ret = cmpxchg(&pe->tce_tracker[i * 2],
> +				      entry1, (addr - offset));
> +			if (ret != entry1) {
> +				/* conflict, start looking again */
> +				i--;
> +				continue;
> +			}
> +
> +			/* now we can allocate a TCE */
> +			tce = dma_pseudo_bypass_select_tce(pe, addr - offset);
> +
> +			/* set new value, including TCE index and new refcount */
> +			ret = cmpxchg(&pe->tce_tracker[i * 2 + 1],
> +				      entry2, tce << 34 | 1);
> +			if (ret != entry2) {
> +				/*
> +				 * XXX In this case we need to throw out
> +				 * everything, including the TCE we just
> +				 * allocated.  For now, just leave it.
> +				 */
> +				i--;
> +				continue;
> +			}
> +
> +			/* now set the valid bit */
> +			ret = cmpxchg(&pe->tce_tracker[i * 2],
> +				      (addr - offset), (addr - offset) | 1);
> +			if (ret != (addr - offset)) {
> +				/*
> +				 * XXX Same situation as above.  We'd probably
> +				 * want to null out entry2 as well.
> +				 */
> +				i--;
> +				continue;
> +			}
> +			return (tce << phb->ioda.max_tce_order) | offset;
> +		/* it's a valid entry but not ours, keep looking */
> +		} else {
> +			continue;
> +		}
> +	}
> +	/* If we get here, the table must be full, so error out. */
> +	return -1ULL;
> +}
> +
> +/*
> + * For the moment, unmapping just decrements the refcount and doesn't actually
> + * remove the TCE.  This is because it's very likely that a previously allocated
> + * TCE will be used again, and this saves having to invalidate it.
> + *
> + * TODO implement some kind of garbage collection that clears unused TCE entries
> + * once the table reaches a certain size.
> + */
> +static void dma_pseudo_bypass_unmap_address(struct device *dev, dma_addr_t dma_addr)
> +{
> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_ioda_pe *pe;
> +	u64 i, entry1, entry2, dma_prefix, refcount;
> +
> +	pe = &phb->ioda.pe_array[pci_get_pdn(pdev)->pe_number];
> +
> +	for (i = 0; i < pe->tce_count; i++) {
> +		entry1 = pe->tce_tracker[i * 2];
> +		entry2 = pe->tce_tracker[i * 2 + 1];
> +		dma_prefix = entry2 >> 34;
> +		refcount = entry2 & ((1 << 30) - 1);
> +
> +		/* look through entry2 until we find our address */
> +		if (dma_prefix == (dma_addr >> phb->ioda.max_tce_order)) {
> +			refcount--;
> +			cmpxchg(&pe->tce_tracker[i * 2 + 1], entry2, (dma_prefix << 34) | refcount);
> +			if (!refcount) {
> +				/*
> +				 * Here is where we would remove the valid bit
> +				 * from entry1, clear the entry in the TCE table
> +				 * and invalidate the TCE - but we want to leave
> +				 * them until the table fills up (for now).
> +				 */
> +			}
> +			break;
> +		}
> +	}
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
> +	/* XXX I don't know if this is necessary (or even desired) */
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		__dma_sync_page(page, offset, size, dir);
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
> +		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
> +			continue;
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


No need in curly braces.

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
> index bcb3bfce072a..7ecc186493ca 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -25,6 +25,7 @@
>  #include <linux/iommu.h>
>  #include <linux/rculist.h>
>  #include <linux/sizes.h>
> +#include <linux/vmalloc.h>
>  
>  #include <asm/sections.h>
>  #include <asm/io.h>
> @@ -1088,6 +1089,9 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>  	pe->pbus = NULL;
>  	pe->mve_number = -1;
>  	pe->rid = dev->bus->number << 8 | pdn->devfn;
> +	pe->tces = NULL;
> +	pe->tce_tracker = NULL;
> +	pe->tce_bitmap = NULL;
>  
>  	pe_info(pe, "Associated device to PE\n");
>  
> @@ -1569,6 +1573,9 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>  		pe->mve_number = -1;
>  		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
>  			   pci_iov_virtfn_devfn(pdev, vf_index);
> +		pe->tces = NULL;
> +		pe->tce_tracker = NULL;
> +		pe->tce_bitmap = NULL;
>  
>  		pe_info(pe, "VF %04d:%02d:%02d.%d associated with PE#%x\n",
>  			hose->global_number, pdev->bus->number,
> @@ -1774,43 +1781,40 @@ static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
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
> +	int bitmap_size, tracker_entries;
> +
> +	/*
> +	 * XXX These are factors for scaling the size of the TCE table, and
> +	 * the table that tracks these allocations.  These should eventually
> +	 * be kernel command line options with defaults above 1, for situations
> +	 * where your memory expands after the machine has booted.
> +	 */
> +	int tce_size_factor = 1;
> +	int tracking_table_factor = 1;

I'd drop these for now, add them later.

>  
>  	/*
> -	 * Window size needs to be a power of two, but needs to account for
> -	 * shifting memory by the 4GB offset required to skip 32bit space.
> +	 * The window size covers all of memory (and optionally more), with
> +	 * enough tracker entries to cover them all being allocated.  So we
> +	 * create enough TCEs to cover all of memory at once.
>  	 */
> -	window_size = roundup_pow_of_two(memory_hotplug_max() + (1ULL << 32));
> -	tce_count = window_size >> tce_order;
> +	window_size = roundup_pow_of_two(tce_size_factor * memory_hotplug_max());
> +	tracker_entries = (tracking_table_factor * memory_hotplug_max()) >>
> +		p->ioda.max_tce_order;
> +	tce_count = window_size >> p->ioda.max_tce_order;
> +	bitmap_size = BITS_TO_LONGS(tce_count) * sizeof(unsigned long);
>  	table_size = tce_count << 3;
>  
>  	if (table_size < PAGE_SIZE)
>  		table_size = PAGE_SIZE;
>  
> -	table_pages = alloc_pages_node(pe->phb->hose->node, GFP_KERNEL,
> +	table_pages = alloc_pages_node(p->hose->node, GFP_KERNEL,
>  				       get_order(table_size));


table_pages memory leaks if the device is used by VFIO.


>  	if (!table_pages)
>  		goto err;
> @@ -1821,26 +1825,33 @@ static int pnv_pci_ioda_dma_64bit_bypass(struct pnv_ioda_pe *pe)
>  
>  	memset(tces, 0, table_size);
>  
> -	for (addr = 0; addr < memory_hotplug_max(); addr += (1 << tce_order)) {
> -		tces[(addr + (1ULL << 32)) >> tce_order] =
> -			cpu_to_be64(addr | TCE_PCI_READ | TCE_PCI_WRITE);
> -	}
> +	pe->tces = tces;
> +	pe->tce_count = tce_count;
> +	pe->tce_bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +	/* The tracking table has two u64s per TCE */
> +	pe->tce_tracker = vzalloc(sizeof(u64) * 2 * tracker_entries);
> +	spin_lock_init(&pe->tce_alloc_lock);
> +
> +	/* mark the first 4GB as reserved so this can still be used for 32bit */
> +	bitmap_set(pe->tce_bitmap, 0, 1ULL << (32 - p->ioda.max_tce_order));
> +
> +	pe_info(pe, "pseudo-bypass sizes: tracker %d bitmap %d TCEs %lld\n",
> +		tracker_entries, bitmap_size, tce_count);
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

Is there any reason not to use the existing iommu_table_group_ops API
for tracking whatever was programmed into TVT?

I'd really love see this be based on top of 
https://patchwork.ozlabs.org/patch/923868/


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
> @@ -1851,7 +1862,6 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
>  	struct pnv_ioda_pe *pe;
>  	uint64_t top;
>  	bool bypass = false;
> -	s64 rc;
>  
>  	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
>  		return -ENODEV;
> @@ -1868,21 +1878,15 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
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
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index c9952def5e93..83492aba90f1 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -70,6 +70,13 @@ struct pnv_ioda_pe {
>  	bool			tce_bypass_enabled;
>  	uint64_t		tce_bypass_base;
>  
> +	/* TCE tables for DMA pseudo-bypass */
> +	__be64			*tces;
> +	u64			tce_count;
> +	unsigned long		*tce_bitmap;
> +	u64			*tce_tracker; // 2 u64s per TCE
> +	spinlock_t		tce_alloc_lock;


Can we please not duplicate pe->table_group here? That thing has array
of iommu_table's with locks and everything.


> +
>  	/* MSIs. MVE index is identical for for 32 and 64 bit MSI
>  	 * and -1 if not supported. (It's actually identical to the
>  	 * PE number)
> -- 
> 2.17.1



--
Alexey
