Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD3A51A1CF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:37 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 502812BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764DRuA21823576
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764D1qh012942
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 23/42] powerpc/powernv: Release PEs dynamically
Date: Thu,  6 Aug 2015 14:11:28 +1000
Message-Id: <1438834307-26960-24-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the refcount to PE, which represents number of PCI
devices contained in the PE. When last device leaves from the
PE, the PE together with its consumed resources (IO, DMA, PELTM,
PELTV) are released, to support PCI hotplug.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 233 +++++++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/pci.h      |   3 +
 2 files changed, 217 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d2697a3..13d8a5b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -132,6 +132,53 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static void pnv_pci_ioda_release_pe_dma(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	struct iommu_table *tbl;
+	int seg;
+	int64_t rc;
+
+	/* No DMA32 segments allocated */
+	if (pe->dma32_seg == PNV_INVALID_SEGMENT ||
+	    pe->dma32_segcount <= 0) {
+		pe->dma32_seg = PNV_INVALID_SEGMENT;
+		pe->dma32_segcount = 0;
+		return;
+	}
+
+	/* Unlink IOMMU table from group */
+	tbl = pe->table_group.tables[0];
+	pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		BUG_ON(pe->table_group.group);
+	}
+
+	/* Release IOMMU table */
+	free_pages(tbl->it_base,
+		get_order(TCE32_TABLE_SIZE * pe->dma32_segcount));
+	iommu_free_table(tbl,
+		of_node_full_name(pci_bus_to_OF_node(pe->pbus)));
+
+	/* Disable TVE */
+	for (seg = pe->dma32_seg;
+	     seg < pe->dma32_seg + pe->dma32_segcount;
+	     seg++) {
+		rc = opal_pci_map_pe_dma_window(phb->opal_id,
+				pe->pe_number, seg, 0, 0ul, 0ul, 0ul);
+		if (rc)
+			pe_warn(pe, "Error %ld unmapping DMA32 seg#%d\n",
+				rc, seg);
+	}
+
+	/* Free the DMA32 segments */
+	bitmap_clear(phb->ioda.dma32_segmap,
+		pe->dma32_seg, pe->dma32_segcount);
+	pe->dma32_seg = PNV_INVALID_SEGMENT;
+	pe->dma32_segcount = 0;
+}
+
 static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
@@ -199,13 +246,15 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 		pe->tce_bypass_enabled = enable;
 }
 
-#ifdef CONFIG_PCI_IOV
-static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev,
-					 struct pnv_ioda_pe *pe)
+static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 {
 	struct iommu_table    *tbl;
+	struct device_node    *dn;
 	int64_t               rc;
 
+	if (pe->dma32_seg == PNV_INVALID_SEGMENT)
+		return;
+
 	tbl = pe->table_group.tables[0];
 	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (rc)
@@ -216,10 +265,91 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev,
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
 	}
+
+	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
+		dn = pci_bus_to_OF_node(pe->pbus);
+	else if (pe->flags & PNV_IODA_PE_DEV)
+		dn = pci_device_to_OF_node(pe->pdev);
+#ifdef CONFIG_PCI_IOV
+	else if (pe->flags & PNV_IODA_PE_VF)
+		dn = pci_device_to_OF_node(pe->parent_dev);
+#endif
+	else
+		dn = NULL;
+
 	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
+	iommu_free_table(tbl, of_node_full_name(dn));
+	pe->dma32_seg = PNV_INVALID_SEGMENT;
+}
+
+static void pnv_ioda_release_pe_dma(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+
+	switch (phb->type) {
+	case PNV_PHB_IODA1:
+		pnv_pci_ioda_release_pe_dma(pe);
+		break;
+	case PNV_PHB_IODA2:
+		pnv_pci_ioda2_release_pe_dma(pe);
+		break;
+	default:
+		pr_warn("%s: Cannot release DMA for PHB type %d\n",
+			__func__, phb->type);
+	}
+}
+
+static void pnv_ioda_release_pe_one_seg(struct pnv_ioda_pe *pe, int win)
+{
+	struct pnv_phb *phb = pe->phb;
+	unsigned long *segmap = NULL;
+	unsigned long *pe_segmap = NULL;
+	int segno, limit, mod = 0;
+
+	switch (win) {
+	case OPAL_IO_WINDOW_TYPE:
+		segmap = phb->ioda.io_segmap;
+		pe_segmap = pe->io_segmap;
+		break;
+	case OPAL_M32_WINDOW_TYPE:
+		segmap = phb->ioda.m32_segmap;
+		pe_segmap = pe->m32_segmap;
+		break;
+	case OPAL_M64_WINDOW_TYPE:
+		if (phb->type != PNV_PHB_IODA1)
+			return;
+		segmap = phb->ioda.m64_segmap;
+		pe_segmap = pe->m64_segmap;
+		mod = 8;
+		break;
+	default:
+		return;
+	}
+
+	segno = -1;
+	limit = phb->ioda.total_pe_num;
+	while ((segno = find_next_bit(pe_segmap, limit, segno + 1)) < limit) {
+		if (mod > 0)
+			opal_pci_map_pe_mmio_window(phb->opal_id,
+				phb->ioda.reserved_pe_idx, win,
+				segno / mod, segno % mod);
+		else
+			opal_pci_map_pe_mmio_window(phb->opal_id,
+					phb->ioda.reserved_pe_idx, win,
+					0, segno);
+
+		clear_bit(segno, pe_segmap);
+		clear_bit(segno, segmap);
+	}
+}
+
+static void pnv_ioda_release_pe_seg(struct pnv_ioda_pe *pe)
+{
+	int win;
+
+	for (win = OPAL_M32_WINDOW_TYPE; win <= OPAL_IO_WINDOW_TYPE; win++)
+		pnv_ioda_release_pe_one_seg(pe, win);
 }
-#endif /* CONFIG_PCI_IOV */
 
 static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
 				  struct pnv_ioda_pe *parent,
@@ -325,7 +455,6 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 	return 0;
 }
 
-#ifdef CONFIG_PCI_IOV
 static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -373,9 +502,11 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		}
 		rid_end = pe->rid + (count << 8);
 	} else {
+#ifdef CONFIG_PCI_IOV
 		if (pe->flags & PNV_IODA_PE_VF)
 			parent = pe->parent_dev;
 		else
+#endif
 			parent = pe->pdev->bus->self;
 		bcomp = OpalPciBusAll;
 		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
@@ -415,11 +546,72 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	pe->pbus = NULL;
 	pe->pdev = NULL;
+#ifdef CONFIG_PCI_IOV
 	pe->parent_dev = NULL;
+#endif
 
 	return 0;
 }
-#endif /* CONFIG_PCI_IOV */
+
+static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	struct pnv_ioda_pe *tmp, *slave;
+
+	/* Release slave PEs in compound PE */
+	if (pe->flags & PNV_IODA_PE_MASTER) {
+		list_for_each_entry_safe(slave, tmp, &pe->slaves, list)
+			pnv_ioda_release_pe(pe);
+	}
+
+	/* Remove the PE from the list */
+	list_del(&pe->list);
+
+	/* Release resources */
+	pnv_ioda_release_pe_dma(pe);
+	pnv_ioda_release_pe_seg(pe);
+	pnv_ioda_deconfigure_pe(pe->phb, pe);
+
+	/* Release PE number */
+	clear_bit(pe->pe_number, phb->ioda.pe_alloc);
+}
+
+static inline struct pnv_ioda_pe *pnv_ioda_pe_get(struct pnv_ioda_pe *pe)
+{
+	if (!pe)
+		return NULL;
+
+	pe->device_count++;
+	return pe;
+}
+
+static inline void pnv_ioda_pe_put(struct pnv_ioda_pe *pe)
+{
+	if (!pe)
+		return;
+
+	pe->device_count--;
+	BUG_ON(pe->device_count < 0);
+	if (pe->device_count == 0)
+		pnv_ioda_release_pe(pe);
+}
+
+static void pnv_pci_release_device(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	struct pnv_ioda_pe *pe;
+
+	if (pdev->is_virtfn)
+		return;
+
+	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
+		return;
+
+	pe = &phb->ioda.pe_array[pdn->pe_number];
+	pnv_ioda_pe_put(pe);
+}
 
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
@@ -466,6 +658,7 @@ static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 	return pnv_ioda_init_pe(phb, pe);
 }
 
+#ifdef CONFIG_PCI_IOV
 static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
 {
 	WARN_ON(phb->ioda.pe_array[pe].pdev);
@@ -473,6 +666,7 @@ static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
 	memset(&phb->ioda.pe_array[pe], 0, sizeof(struct pnv_ioda_pe));
 	clear_bit(pe, phb->ioda.pe_alloc);
 }
+#endif
 
 static int pnv_ioda1_init_m64(struct pnv_phb *phb)
 {
@@ -1177,6 +1371,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 		if (pdn->pe_number != IODA_INVALID_PE)
 			continue;
 
+		pnv_ioda_pe_get(pe);
 		pdn->pe_number = pe->pe_number;
 		pe->dma32_weight += pnv_ioda_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
@@ -1231,7 +1426,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
 	pe->pbus = bus;
 	pe->pdev = NULL;
-	pe->dma32_seg = -1;
+	pe->dma32_seg = PNV_INVALID_SEGMENT;
 	pe->mve_number = -1;
 	pe->rid = bus->busn_res.start << 8;
 	pe->dma32_weight = 0;
@@ -1244,9 +1439,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 			bus->busn_res.start, pe->pe_number);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
-		/* XXX What do we do here ? */
-		pnv_ioda_free_pe(phb, pe->pe_number);
 		pe->pbus = NULL;
+		pnv_ioda_release_pe(pe);
 		return NULL;
 	}
 
@@ -1449,14 +1643,14 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		if ((pe->flags & PNV_IODA_PE_MASTER) &&
 		    (pe->flags & PNV_IODA_PE_VF)) {
 			list_for_each_entry_safe(s, sn, &pe->slaves, list) {
-				pnv_pci_ioda2_release_dma_pe(pdev, s);
+				pnv_pci_ioda2_release_dma_pe(s);
 				list_del(&s->list);
 				pnv_ioda_deconfigure_pe(phb, s);
 				pnv_ioda_free_pe(phb, s->pe_number);
 			}
 		}
 
-		pnv_pci_ioda2_release_dma_pe(pdev, pe);
+		pnv_pci_ioda2_release_pe_dma(pe);
 
 		/* Remove from list */
 		mutex_lock(&phb->ioda.pe_list_mutex);
@@ -1532,7 +1726,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		pe->flags = PNV_IODA_PE_VF;
 		pe->pbus = NULL;
 		pe->parent_dev = pdev;
-		pe->dma32_seg = -1;
+		pe->dma32_seg = PNV_INVALID_SEGMENT;
 		pe->mve_number = -1;
 		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
 			   pci_iov_virtfn_devfn(pdev, vf_index);
@@ -1995,7 +2189,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	/* XXX FIXME: Allocate multi-level tables on PHB3 */
 
 	/* We shouldn't already have a 32-bit DMA associated */
-	if (WARN_ON(pe->dma32_seg >= 0))
+	if (WARN_ON(pe->dma32_seg != PNV_INVALID_SEGMENT))
 		return;
 
 	tbl = pnv_pci_table_alloc(phb->hose->node);
@@ -2066,10 +2260,10 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	return;
  fail:
 	/* XXX Failure: Try to fallback to 64-bit only ? */
-	if (pe->dma32_seg >= 0) {
+	if (pe->dma32_seg != PNV_INVALID_SEGMENT) {
 		bitmap_clear(phb->ioda.dma32_segmap,
 			     pe->dma32_seg, pe->dma32_segcount);
-		pe->dma32_seg = -1;
+		pe->dma32_seg = PNV_INVALID_SEGMENT;
 		pe->dma32_segcount = 0;
 	}
 
@@ -2416,7 +2610,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	int64_t rc;
 
 	/* We shouldn't already have a 32-bit DMA associated */
-	if (WARN_ON(pe->dma32_seg >= 0))
+	if (WARN_ON(pe->dma32_seg != PNV_INVALID_SEGMENT))
 		return;
 
 	/* TVE #1 is selected by PCI address bit 59 */
@@ -2443,8 +2637,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 	rc = pnv_pci_ioda2_setup_default_config(pe);
 	if (rc) {
-		if (pe->dma32_seg >= 0)
-			pe->dma32_seg = -1;
+		if (pe->dma32_seg != PNV_INVALID_SEGMENT)
+			pe->dma32_seg = PNV_INVALID_SEGMENT;
 		return;
 	}
 
@@ -3183,6 +3377,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
        .teardown_msi_irqs = pnv_teardown_msi_irqs,
 #endif
        .enable_device_hook = pnv_pci_enable_device_hook,
+	.release_device = pnv_pci_release_device,
        .window_alignment = pnv_pci_window_alignment,
 	.setup_bridge = pnv_pci_setup_bridge,
        .reset_secondary_bus = pnv_pci_reset_secondary_bus,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f8e6022..2058f06 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -25,11 +25,14 @@ enum pnv_phb_model {
 #define PNV_IODA_PE_SLAVE	(1 << 4)	/* Slave PE in compound case	*/
 #define PNV_IODA_PE_VF		(1 << 5)	/* PE for one VF 		*/
 
+#define PNV_INVALID_SEGMENT	(-1)
+
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_phb;
 struct pnv_ioda_pe {
 	unsigned long		flags;
 	struct pnv_phb		*phb;
+	int			device_count;
 
 	/* A PE can be associated with a single device or an
 	 * entire bus (& children). In the former case, pdev
-- 
2.1.0
