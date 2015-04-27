Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3E641A0C02
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:20 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 16:39:19 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A1BAB2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:16 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R6d8Kr14221640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:39:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R6cgDt016101
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 16:38:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 05/21] powerpc/powernv: Improve DMA32 segment assignment
Date: Mon, 27 Apr 2015 16:37:37 +1000
Message-Id: <1430116673-22500-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For P7IOC, the whole available DMA32 space, which is below the
MEM32 space, is evenly divided into 256MB segments. How many
continuous segments assigned to one particular PE depends on
the PE's DMA weight that is figured out from the type of each
PCI devices contained in the PE, and PHB's DMA weight which is
accumulative DMA weight of PEs contained in the PHB. It means
that the PHB's DMA weight calculation depends on existing PEs,
which works perfectly now, but not hotplug friendly. As the
whole available DMA32 space can be assigned to one PE on PHB3,
so we don't have the issue on PHB3.

The patch improves DMA32 segment assignment by removing the
dependency of existing PEs to make the piece of logic friendly
to PCI hotplug. Besides, it's always worthy to trace the DMA32
segments consumed by one PE, which can be released at PCI
unplugging time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 204 ++++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci.h      |  24 +---
 2 files changed, 116 insertions(+), 112 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7e6e266..9ef745e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -976,8 +976,11 @@ static void pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
 	list_add_tail(&pe->dma_link, &phb->ioda.pe_dma_list);
 }
 
-static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
+static unsigned int pnv_ioda_dev_dma_weight(struct pci_dev *dev)
 {
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
 	/* This is quite simplistic. The "base" weight of a device
 	 * is 10. 0 means no DMA is to be accounted for it.
 	 */
@@ -990,14 +993,33 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 	if (dev->class == PCI_CLASS_SERIAL_USB_UHCI ||
 	    dev->class == PCI_CLASS_SERIAL_USB_OHCI ||
 	    dev->class == PCI_CLASS_SERIAL_USB_EHCI)
-		return 3;
+		return 3 * phb->ioda.tce32_count;
 
 	/* Increase the weight of RAID (includes Obsidian) */
 	if ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)
-		return 15;
+		return 15 * phb->ioda.tce32_count;
 
 	/* Default */
-	return 10;
+	return 10 * phb->ioda.tce32_count;
+}
+
+static int __pnv_ioda_phb_dma_weight(struct pci_dev *pdev, void *data)
+{
+	unsigned int *dma_weight = data;
+
+	*dma_weight += pnv_ioda_dev_dma_weight(pdev);
+	return 0;
+}
+
+static void pnv_ioda_phb_dma_weight(struct pnv_phb *phb)
+{
+	phb->ioda.dma_weight = 0;
+	if (!phb->hose->bus)
+		return;
+
+	pci_walk_bus(phb->hose->bus,
+		     __pnv_ioda_phb_dma_weight,
+		     &phb->ioda.dma_weight);
 }
 
 #ifdef CONFIG_PCI_IOV
@@ -1156,7 +1178,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 			continue;
 		}
 		pdn->pe_number = pe->pe_number;
-		pe->dma_weight += pnv_ioda_dma_weight(dev);
+		pe->dma_weight += pnv_ioda_dev_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_same_PE(dev->subordinate, pe);
 	}
@@ -1193,7 +1215,6 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
 	pe->pbus = bus;
 	pe->pdev = NULL;
-	pe->tce32_seg = -1;
 	pe->mve_number = -1;
 	pe->rid = bus->busn_res.start << 8;
 	pe->dma_weight = 0;
@@ -1223,14 +1244,6 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	/* Put PE to the list */
 	list_add_tail(&pe->list, &phb->ioda.pe_list);
 
-	/* Account for one DMA PE if at least one DMA capable device exist
-	 * below the bridge
-	 */
-	if (pe->dma_weight != 0) {
-		phb->ioda.dma_weight += pe->dma_weight;
-		phb->ioda.dma_pe_count++;
-	}
-
 	/* Link the PE */
 	pnv_ioda_link_pe_by_weight(phb, pe);
 }
@@ -1569,7 +1582,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		pe->flags = PNV_IODA_PE_VF;
 		pe->pbus = NULL;
 		pe->parent_dev = pdev;
-		pe->tce32_seg = -1;
 		pe->mve_number = -1;
 		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
 			   pci_iov_virtfn_devfn(pdev, vf_index);
@@ -1890,28 +1902,70 @@ void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
 }
 
-static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
-				      struct pnv_ioda_pe *pe, unsigned int base,
-				      unsigned int segs)
+static int pnv_pci_ioda1_dma_segment_alloc(struct pnv_phb *phb,
+					   struct pnv_ioda_pe *pe)
+{
+	unsigned int weight, base, segs;
+
+	/* We shouldn't already have 32-bits DMA associated */
+	if (WARN_ON(pe->tce32_seg_start || pe->tce32_seg_end))
+		return -EEXIST;
+
+	/* Needn't setup TCE table for non-DMA capable PE */
+	weight = pe->dma_weight;
+	if (!weight)
+		return -ENODEV;
+
+	/* Calculate the DMA segments that PE needs. It's guaranteed
+	 * that the PE will have one segment at least.
+	 */
+	if (weight < phb->ioda.dma_weight / phb->ioda.tce32_count)
+		weight = phb->ioda.dma_weight / phb->ioda.tce32_count;
+	segs = (weight * phb->ioda.tce32_count) / phb->ioda.dma_weight;
+
+	/* Reserve the DMA segments with back-off way, which should
+	 * give us one segment at least.
+	 */
+	do {
+		base = bitmap_find_next_zero_area(phb->ioda.tce32_segmap,
+						  phb->ioda.tce32_count,
+						  0, segs, 0);
+		if (base < phb->ioda.tce32_count)
+			bitmap_set(phb->ioda.tce32_segmap, base, segs);
+	} while ((base > phb->ioda.tce32_count) && (--segs));
+
+	/* There are possibly no DMA32 segments */
+	if (!segs)
+		return -ENODEV;
+
+	pe->tce32_seg_start = base;
+	pe->tce32_seg_end = base + segs;
+	return 0;
+}
+
+static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
+				       struct pnv_ioda_pe *pe)
 {
 
 	struct page *tce_mem = NULL;
 	const __be64 *swinvp;
 	struct iommu_table *tbl;
-	unsigned int i;
-	int64_t rc;
 	void *addr;
+	unsigned int base, segs, i;
+	int64_t rc;
 
 	/* XXX FIXME: Handle 64-bit only DMA devices */
 	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
-	/* XXX FIXME: Allocate multi-level tables on PHB3 */
 
-	/* We shouldn't already have a 32-bit DMA associated */
-	if (WARN_ON(pe->tce32_seg >= 0))
+	/* Allocate TCE32 segments */
+	if (pnv_pci_ioda1_dma_segment_alloc(phb, pe)) {
+		pe_err(pe, " Cannot setting up 32-bits TCE table\n");
 		return;
+	}
 
-	/* Grab a 32-bit TCE table */
-	pe->tce32_seg = base;
+	/* Build a 32-bits TCE table */
+	base = pe->tce32_seg_start;
+	segs = pe->tce32_seg_end - pe->tce32_seg_start;
 	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
 		(base << 28), ((base + segs) << 28) - 1);
 
@@ -1943,6 +1997,10 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		}
 	}
 
+	/* Print some info */
+	pe_info(pe, "DMA weight %d, assigned (%d %d) DMA32 segments\n",
+		pe->dma_weight, base, segs);
+
 	/* Setup linux iommu table */
 	tbl = pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
@@ -1981,8 +2039,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	return;
  fail:
 	/* XXX Failure: Try to fallback to 64-bit only ? */
-	if (pe->tce32_seg >= 0)
-		pe->tce32_seg = -1;
+	bitmap_clear(phb->ioda.tce32_segmap, base, segs);
+	pe->tce32_seg_start = pe->tce32_seg_end = 0;
 	if (tce_mem)
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
@@ -2051,11 +2109,10 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	int64_t rc;
 
 	/* We shouldn't already have a 32-bit DMA associated */
-	if (WARN_ON(pe->tce32_seg >= 0))
+	if (WARN_ON(pe->tce32_seg_end > pe->tce32_seg_start))
 		return;
 
 	/* The PE will reserve all possible 32-bits space */
-	pe->tce32_seg = 0;
 	end = (1 << ilog2(phb->ioda.m32_pci_base));
 	tce_table_size = (end / 0x1000) * 8;
 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
@@ -2066,7 +2123,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				   get_order(tce_table_size));
 	if (!tce_mem) {
 		pe_err(pe, "Failed to allocate a 32-bit TCE memory\n");
-		goto fail;
+		return;
 	}
 	addr = page_address(tce_mem);
 	memset(addr, 0, tce_table_size);
@@ -2079,11 +2136,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 					pe->pe_number << 1, 1, __pa(addr),
 					tce_table_size, 0x1000);
 	if (rc) {
+		__free_pages(tce_mem, get_order(tce_table_size));
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
-		goto fail;
+		return;
 	}
 
+	/* Print some info */
+	pe->tce32_seg_end = pe->tce32_seg_start + 1;
+	pe_info(pe, "Assigned DMA32 space\n");
+
 	/* Setup linux iommu table */
 	tbl = pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
@@ -2120,76 +2182,30 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	/* Also create a bypass window */
 	if (!pnv_iommu_bypass_disabled)
 		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
-
-	return;
-fail:
-	if (pe->tce32_seg >= 0)
-		pe->tce32_seg = -1;
-	if (tce_mem)
-		__free_pages(tce_mem, get_order(tce_table_size));
 }
 
-static void pnv_ioda_setup_dma(struct pnv_phb *phb)
+void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
+			       struct pnv_ioda_pe *pe)
 {
-	struct pci_controller *hose = phb->hose;
-	unsigned int residual, remaining, segs, tw, base;
-	struct pnv_ioda_pe *pe;
-
-	/* If we have more PE# than segments available, hand out one
-	 * per PE until we run out and let the rest fail. If not,
-	 * then we assign at least one segment per PE, plus more based
-	 * on the amount of devices under that PE
+	/* Recalculate the PHB's total DMA weight, which depends on
+	 * PCI devices. That means the PCI devices beneath the PHB
+	 * should have been probed successfully. Otherwise, the
+	 * calculated PHB's DMA weight won't be accurate.
 	 */
-	if (phb->ioda.dma_pe_count > phb->ioda.tce32_count)
-		residual = 0;
-	else
-		residual = phb->ioda.tce32_count -
-			phb->ioda.dma_pe_count;
+	pnv_ioda_phb_dma_weight(phb);
 
-	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
-		hose->global_number, phb->ioda.tce32_count);
-	pr_info("PCI: %d PE# for a total weight of %d\n",
-		phb->ioda.dma_pe_count, phb->ioda.dma_weight);
-
-	/* Walk our PE list and configure their DMA segments, hand them
-	 * out one base segment plus any residual segments based on
-	 * weight
-	 */
-	remaining = phb->ioda.tce32_count;
-	tw = phb->ioda.dma_weight;
-	base = 0;
-	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
-		if (!pe->dma_weight)
-			continue;
-		if (!remaining) {
-			pe_warn(pe, "No DMA32 resources available\n");
-			continue;
-		}
-		segs = 1;
-		if (residual) {
-			segs += ((pe->dma_weight * residual)  + (tw / 2)) / tw;
-			if (segs > remaining)
-				segs = remaining;
-		}
+	if (phb->type == PNV_PHB_IODA1)
+		pnv_pci_ioda1_setup_dma_pe(phb, pe);
+	else if (phb->type == PNV_PHB_IODA2)
+		pnv_pci_ioda2_setup_dma_pe(phb, pe);
+}
 
-		/*
-		 * For IODA2 compliant PHB3, we needn't care about the weight.
-		 * The all available 32-bits DMA space will be assigned to
-		 * the specific PE.
-		 */
-		if (phb->type == PNV_PHB_IODA1) {
-			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
-				pe->dma_weight, segs);
-			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
-		} else {
-			pe_info(pe, "Assign DMA32 space\n");
-			segs = 0;
-			pnv_pci_ioda2_setup_dma_pe(phb, pe);
-		}
+static void pnv_ioda_setup_dma(struct pnv_phb *phb)
+{
+	struct pnv_ioda_pe *pe;
 
-		remaining -= segs;
-		base += segs;
-	}
+	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
+		pnv_pci_ioda_setup_dma_pe(phb, pe);
 }
 
 #ifdef CONFIG_PCI_MSI
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f604bb7..2784951 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -58,15 +58,11 @@ struct pnv_ioda_pe {
 	unsigned long		m32_segmap[8];
 	unsigned long		m64_segmap[8];
 
-	/* "Weight" assigned to the PE for the sake of DMA resource
-	 * allocations
-	 */
-	unsigned int		dma_weight;
-
-	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
-	int			tce32_seg;
-	int			tce32_segcount;
+	/* 32-bits DMA */
 	struct iommu_table	*tce32_table;
+	unsigned int		dma_weight;
+	unsigned int		tce32_seg_start;
+	unsigned int		tce32_seg_end;
 	phys_addr_t		tce_inval_reg_phys;
 
 	/* 64-bit TCE bypass region */
@@ -183,17 +179,9 @@ struct pnv_phb {
 			unsigned char		pe_rmap[0x10000];
 
 			/* 32-bit TCE tables allocation */
-			unsigned long		tce32_count;
-
-			/* Total "weight" for the sake of DMA resources
-			 * allocation
-			 */
 			unsigned int		dma_weight;
-			unsigned int		dma_pe_count;
-
-			/* Sorted list of used PE's, sorted at
-			 * boot for resource allocation purposes
-			 */
+			unsigned long		tce32_count;
+			unsigned long		tce32_segmap[8];
 			struct list_head	pe_dma_list;
 		} ioda;
 	};
-- 
2.1.0
