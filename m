Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqNFr2r0szDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:35:28 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 10:35:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1FAA02BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:35:03 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K0YtMS34013396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:35:03 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K0YTDB004892
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:34:30 +1000
Date: Wed, 20 Apr 2016 10:34:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 16/45] powerpc/powernv: Remove DMA32 PE list
Message-ID: <20160420003404.GB15693@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-17-git-send-email-gwshan@linux.vnet.ibm.com>
 <570E0A7C.70103@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570E0A7C.70103@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 06:59:40PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>PEs are put into PHB DMA32 list (phb->ioda.pe_dma_list) according
>>to their DMA32 weight. The PEs on the list are iterated to setup
>>their TCE32 tables at system booting time. The list is used for
>>once and there is for keep having it.
>
>"there is no need to keep it" may be?
>

Sorry, I should have fixed it in early revision. Will fix it
up in next revision.

>>
>>This moves the logic calculating DMA32 weight of PHB and PE to
>>pnv_ioda_setup_dma() to drop PHB's DMA32 list. Also, every PE
>>traces the consumed DMA32 segment by @tce32_seg and @tce32_segcount
>>are useless and they're removed.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>
>Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>with few comments below...
>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 168 +++++++++++++-----------------
>>  arch/powerpc/platforms/powernv/pci.h      |  19 ----
>>  2 files changed, 75 insertions(+), 112 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index e60cff6..0fc2309 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -886,44 +886,6 @@ out:
>>  	return 0;
>>  }
>>
>>-static void pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
>>-				       struct pnv_ioda_pe *pe)
>>-{
>>-	struct pnv_ioda_pe *lpe;
>>-
>>-	list_for_each_entry(lpe, &phb->ioda.pe_dma_list, dma_link) {
>>-		if (lpe->dma_weight < pe->dma_weight) {
>>-			list_add_tail(&pe->dma_link, &lpe->dma_link);
>>-			return;
>>-		}
>>-	}
>>-	list_add_tail(&pe->dma_link, &phb->ioda.pe_dma_list);
>>-}
>>-
>>-static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
>>-{
>>-	/* This is quite simplistic. The "base" weight of a device
>>-	 * is 10. 0 means no DMA is to be accounted for it.
>>-	 */
>>-
>>-	/* If it's a bridge, no DMA */
>>-	if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL)
>>-		return 0;
>>-
>>-	/* Reduce the weight of slow USB controllers */
>>-	if (dev->class == PCI_CLASS_SERIAL_USB_UHCI ||
>>-	    dev->class == PCI_CLASS_SERIAL_USB_OHCI ||
>>-	    dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>>-		return 3;
>>-
>>-	/* Increase the weight of RAID (includes Obsidian) */
>>-	if ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)
>>-		return 15;
>>-
>>-	/* Default */
>>-	return 10;
>>-}
>>-
>>  #ifdef CONFIG_PCI_IOV
>>  static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>  {
>>@@ -1028,7 +990,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>>  	pe->flags = PNV_IODA_PE_DEV;
>>  	pe->pdev = dev;
>>  	pe->pbus = NULL;
>>-	pe->tce32_seg = -1;
>>  	pe->mve_number = -1;
>>  	pe->rid = dev->bus->number << 8 | pdn->devfn;
>>
>>@@ -1044,16 +1005,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>>  		return NULL;
>>  	}
>>
>>-	/* Assign a DMA weight to the device */
>>-	pe->dma_weight = pnv_ioda_dma_weight(dev);
>>-	if (pe->dma_weight != 0) {
>>-		phb->ioda.dma_weight += pe->dma_weight;
>>-		phb->ioda.dma_pe_count++;
>>-	}
>>-
>>-	/* Link the PE */
>>-	pnv_ioda_link_pe_by_weight(phb, pe);
>>-
>>  	return pe;
>>  }
>>
>>@@ -1071,7 +1022,6 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>>  		}
>>  		pdn->pcidev = dev;
>>  		pdn->pe_number = pe->pe_number;
>>-		pe->dma_weight += pnv_ioda_dma_weight(dev);
>>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
>>  			pnv_ioda_setup_same_PE(dev->subordinate, pe);
>>  	}
>>@@ -1108,10 +1058,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>  	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>>  	pe->pbus = bus;
>>  	pe->pdev = NULL;
>>-	pe->tce32_seg = -1;
>>  	pe->mve_number = -1;
>>  	pe->rid = bus->busn_res.start << 8;
>>-	pe->dma_weight = 0;
>>
>>  	if (all)
>>  		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
>>@@ -1133,17 +1081,6 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>
>>  	/* Put PE to the list */
>>  	list_add_tail(&pe->list, &phb->ioda.pe_list);
>>-
>>-	/* Account for one DMA PE if at least one DMA capable device exist
>>-	 * below the bridge
>>-	 */
>>-	if (pe->dma_weight != 0) {
>>-		phb->ioda.dma_weight += pe->dma_weight;
>>-		phb->ioda.dma_pe_count++;
>>-	}
>>-
>>-	/* Link the PE */
>>-	pnv_ioda_link_pe_by_weight(phb, pe);
>>  }
>>
>>  static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
>>@@ -1184,7 +1121,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
>>  			rid = npu_pdev->bus->number << 8 | npu_pdn->devfn;
>>  			npu_pdn->pcidev = npu_pdev;
>>  			npu_pdn->pe_number = pe_num;
>>-			pe->dma_weight += pnv_ioda_dma_weight(npu_pdev);
>>  			phb->ioda.pe_rmap[rid] = pe->pe_number;
>>
>>  			/* Map the PE to this link */
>>@@ -1532,7 +1468,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>>  		pe->flags = PNV_IODA_PE_VF;
>>  		pe->pbus = NULL;
>>  		pe->parent_dev = pdev;
>>-		pe->tce32_seg = -1;
>>  		pe->mve_number = -1;
>>  		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
>>  			   pci_iov_virtfn_devfn(pdev, vf_index);
>>@@ -2023,6 +1958,54 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>>  	.free = pnv_ioda2_table_free,
>>  };
>>
>>+static int pnv_pci_ioda_dev_dma_weight(struct pci_dev *dev, void *data)
>>+{
>>+	unsigned int *weight = (unsigned int *)data;
>>+
>>+	/* This is quite simplistic. The "base" weight of a device
>>+	 * is 10. 0 means no DMA is to be accounted for it.
>>+	 */
>>+	if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL)
>>+		return 0;
>>+
>>+	if (dev->class == PCI_CLASS_SERIAL_USB_UHCI ||
>>+	    dev->class == PCI_CLASS_SERIAL_USB_OHCI ||
>>+	    dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>>+		*weight += 3;
>>+	else if ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)
>>+		*weight += 15;
>>+	else
>>+		*weight += 10;
>>+
>>+	return 0;
>>+}
>>+
>>+static unsigned int pnv_pci_ioda_pe_dma_weight(struct pnv_ioda_pe *pe)
>>+{
>>+	unsigned int weight = 0;
>>+
>>+	if ((pe->flags & PNV_IODA_PE_DEV) && pe->pdev) {
>>+		pnv_pci_ioda_dev_dma_weight(pe->pdev, &weight);
>>+	} else if ((pe->flags & PNV_IODA_PE_BUS) && pe->pbus) {
>>+		struct pci_dev *pdev;
>>+
>>+		list_for_each_entry(pdev, &pe->pbus->devices, bus_list)
>>+			pnv_pci_ioda_dev_dma_weight(pdev, &weight);
>>+	} else if ((pe->flags & PNV_IODA_PE_BUS_ALL) && pe->pbus) {
>>+		pci_walk_bus(pe->pbus, pnv_pci_ioda_dev_dma_weight, &weight);
>>+	}
>>+
>>+	return weight;
>>+}
>>+
>>+static unsigned int pnv_pci_ioda_total_dma_weight(struct pnv_phb *phb)
>
>
>s/pnv_pci_ioda_total_dma_weight/pnv_pci_ioda1_phb_dma_weight/ ? "total" does
>not say much. Or just merge it into pnv_pci_ioda1_setup_dma_pe() as it is
>useless for anything but IODA1.
>

Nice suggestion. I will merge it to pnv_pci_ioda1_setup_dma_pe().

>>+{
>>+	unsigned int weight = 0;
>>+
>>+	pci_walk_bus(phb->hose->bus, pnv_pci_ioda_dev_dma_weight, &weight);
>>+	return weight;
>>+}
>>+
>>  static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>  				       struct pnv_ioda_pe *pe,
>>  				       unsigned int base,
>>@@ -2039,17 +2022,12 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>  	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
>>  	/* XXX FIXME: Allocate multi-level tables on PHB3 */
>>
>>-	/* We shouldn't already have a 32-bit DMA associated */
>>-	if (WARN_ON(pe->tce32_seg >= 0))
>>-		return;
>>-
>>  	tbl = pnv_pci_table_alloc(phb->hose->node);
>>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>>  			pe->pe_number);
>>  	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
>>
>>  	/* Grab a 32-bit TCE table */
>>-	pe->tce32_seg = base;
>>  	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
>>  		base * PNV_IODA1_DMA32_SEGSIZE,
>>  		(base + segs) * PNV_IODA1_DMA32_SEGSIZE - 1);
>>@@ -2116,8 +2094,6 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>  	return;
>>   fail:
>>  	/* XXX Failure: Try to fallback to 64-bit only ? */
>>-	if (pe->tce32_seg >= 0)
>>-		pe->tce32_seg = -1;
>>  	if (tce_mem)
>>  		__free_pages(tce_mem, get_order(tce32_segsz * segs));
>>  	if (tbl) {
>>@@ -2528,10 +2504,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  {
>>  	int64_t rc;
>>
>>-	/* We shouldn't already have a 32-bit DMA associated */
>>-	if (WARN_ON(pe->tce32_seg >= 0))
>>-		return;
>>-
>>  	/* TVE #1 is selected by PCI address bit 59 */
>>  	pe->tce_bypass_base = 1ull << 59;
>>
>>@@ -2539,7 +2511,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  			pe->pe_number);
>>
>>  	/* The PE will reserve all possible 32-bits space */
>>-	pe->tce32_seg = 0;
>>  	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>>  		phb->ioda.m32_pci_base);
>>
>>@@ -2555,11 +2526,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  #endif
>>
>>  	rc = pnv_pci_ioda2_setup_default_config(pe);
>>-	if (rc) {
>>-		if (pe->tce32_seg >= 0)
>>-			pe->tce32_seg = -1;
>>+	if (rc)
>>  		return;
>>-	}
>>
>>  	if (pe->flags & PNV_IODA_PE_DEV)
>>  		iommu_add_device(&pe->pdev->dev);
>>@@ -2570,24 +2538,32 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>  {
>>  	struct pci_controller *hose = phb->hose;
>>-	unsigned int residual, remaining, segs, tw, base;
>>+	unsigned int weight, total_weight, dma_pe_count;
>>+	unsigned int residual, remaining, segs, base;
>>  	struct pnv_ioda_pe *pe;
>>
>>+	total_weight = pnv_pci_ioda_total_dma_weight(phb);
>>+	dma_pe_count = 0;
>>+	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>+		weight = pnv_pci_ioda_pe_dma_weight(pe);
>>+		if (weight > 0)
>>+			dma_pe_count++;
>>+	}
>>+
>>  	/* If we have more PE# than segments available, hand out one
>>  	 * per PE until we run out and let the rest fail. If not,
>>  	 * then we assign at least one segment per PE, plus more based
>>  	 * on the amount of devices under that PE
>>  	 */
>>-	if (phb->ioda.dma_pe_count > phb->ioda.tce32_count)
>>+	if (dma_pe_count > phb->ioda.tce32_count)
>>  		residual = 0;
>>  	else
>>-		residual = phb->ioda.tce32_count -
>>-			phb->ioda.dma_pe_count;
>>+		residual = phb->ioda.tce32_count - dma_pe_count;
>>
>>  	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
>>  		hose->global_number, phb->ioda.tce32_count);
>>  	pr_info("PCI: %d PE# for a total weight of %d\n",
>>-		phb->ioda.dma_pe_count, phb->ioda.dma_weight);
>>+		dma_pe_count, total_weight);
>>
>>  	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>
>>@@ -2596,18 +2572,20 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>  	 * weight
>>  	 */
>>  	remaining = phb->ioda.tce32_count;
>>-	tw = phb->ioda.dma_weight;
>>  	base = 0;
>>-	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>-		if (!pe->dma_weight)
>>+	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>+		weight = pnv_pci_ioda_pe_dma_weight(pe);
>>+		if (!weight)
>>  			continue;
>>+
>>  		if (!remaining) {
>>  			pe_warn(pe, "No DMA32 resources available\n");
>>  			continue;
>>  		}
>>  		segs = 1;
>>  		if (residual) {
>>-			segs += ((pe->dma_weight * residual)  + (tw / 2)) / tw;
>>+			segs += ((weight * residual) + (total_weight / 2)) /
>>+				total_weight;
>>  			if (segs > remaining)
>>  				segs = remaining;
>>  		}
>>@@ -2619,7 +2597,7 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>  		 */
>>  		if (phb->type == PNV_PHB_IODA1) {
>>  			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
>>-				pe->dma_weight, segs);
>>+				weight, segs);
>>  			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
>>  		} else if (phb->type == PNV_PHB_IODA2) {
>>  			pe_info(pe, "Assign DMA32 space\n");
>>@@ -3156,13 +3134,18 @@ static void pnv_npu_ioda_fixup(void)
>>  	struct pci_controller *hose, *tmp;
>>  	struct pnv_phb *phb;
>>  	struct pnv_ioda_pe *pe;
>>+	unsigned int weight;
>>
>>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>  		phb = hose->private_data;
>>  		if (phb->type != PNV_PHB_NPU)
>>  			continue;
>>
>>-		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>+		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>+			weight = pnv_pci_ioda_pe_dma_weight(pe);
>>+			if (!weight)
>>+				continue;
>
>Is this even possible for NPU PE to get weight==0? WARN_ON()? BUG_ON()?
>

It's impossible and worthy to have a WARN_ON() here. Will address it
in next revision.

>>+
>>  			enable_bypass = dma_get_mask(&pe->pdev->dev) ==
>>  				DMA_BIT_MASK(64);
>>  			pnv_npu_init_dma_pe(pe);
>>@@ -3443,7 +3426,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	phb->ioda.pe_array = aux + pemap_off;
>>  	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>>
>>-	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
>>  	INIT_LIST_HEAD(&phb->ioda.pe_list);
>>  	mutex_init(&phb->ioda.pe_list_mutex);
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 1d8e775..e90bcbe 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -53,14 +53,7 @@ struct pnv_ioda_pe {
>>  	/* PE number */
>>  	unsigned int		pe_number;
>>
>>-	/* "Weight" assigned to the PE for the sake of DMA resource
>>-	 * allocations
>>-	 */
>>-	unsigned int		dma_weight;
>>-
>>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>>-	int			tce32_seg;
>>-	int			tce32_segcount;
>>  	struct iommu_table_group table_group;
>>
>>  	/* 64-bit TCE bypass region */
>>@@ -78,7 +71,6 @@ struct pnv_ioda_pe {
>>  	struct list_head	slaves;
>>
>>  	/* Link in list of PE#s */
>>-	struct list_head	dma_link;
>>  	struct list_head	list;
>>  };
>>
>>@@ -173,17 +165,6 @@ struct pnv_phb {
>>  		/* 32-bit TCE tables allocation */
>>  		unsigned long		tce32_count;
>>
>>-		/* Total "weight" for the sake of DMA resources
>>-		 * allocation
>>-		 */
>>-		unsigned int		dma_weight;
>>-		unsigned int		dma_pe_count;
>>-
>>-		/* Sorted list of used PE's, sorted at
>>-		 * boot for resource allocation purposes
>>-		 */
>>-		struct list_head	pe_dma_list;
>>-
>>  		/* TCE cache invalidate registers (physical and
>>  		 * remapped)
>>  		 */
>>
>
>
>-- 
>Alexey
>
