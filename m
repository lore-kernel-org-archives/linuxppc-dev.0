Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F6E71A0CBE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:49 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:46 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 81BB91258067
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:43 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDVZ966257026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:31 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDPWu031878
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:30 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 27/50] powerpc/powernv: Dynamically release PEs
Date: Thu,  5 Nov 2015 00:12:27 +1100
Message-Id: <1446642770-4681-28-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a reference count of PE, representing the number of PCI
devices associated with the PE. The reference count is increased
or decreased when PCI devices join or leave the PE. Once it becomes
zero, the PE together with its used resources (IO, MMIO, DMA, PELTM,
PELTV) are released to support PCI hot unplug.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 245 ++++++++++++++++++++++++++----
 arch/powerpc/platforms/powernv/pci.h      |   1 +
 2 files changed, 218 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0bb0056..dcffce5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -129,6 +129,215 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static void pnv_pci_ioda1_release_dma_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	struct iommu_table *tbl;
+	int start, count, i;
+	int64_t rc;
+
+	/* Search for the used DMA32 segments */
+	start = -1;
+	count = 0;
+	for (i = 0; i < phb->ioda.dma32_count; i++) {
+		if (phb->ioda.dma32_segmap[i] != pe->pe_number)
+			continue;
+
+		count++;
+		if (start < 0)
+			start = i;
+	}
+
+	if (!count)
+		return;
+
+	/* Unlink IOMMU table from group */
+	tbl = pe->table_group.tables[0];
+	pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		WARN_ON(pe->table_group.group);
+	}
+
+	/* Release IOMMU table */
+	pnv_pci_ioda2_table_free_pages(tbl);
+	iommu_free_table(tbl, of_node_full_name(pci_bus_to_OF_node(pe->pbus)));
+
+	/* Disable TVE */
+	for (i = start; i < start + count; i++) {
+		rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+						i, 0, 0ul, 0ul, 0ul);
+		if (rc)
+			pe_warn(pe, "Error %ld unmapping DMA32 seg#%d\n",
+				rc, i);
+
+		phb->ioda.dma32_segmap[i] = IODA_INVALID_PE;
+	}
+}
+
+static unsigned int pnv_pci_ioda_pe_dma_weight(struct pnv_ioda_pe *pe);
+static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
+		int num);
+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
+
+static void pnv_pci_ioda2_release_dma_pe(struct pnv_ioda_pe *pe)
+{
+	struct iommu_table *tbl;
+	unsigned int weight = pnv_pci_ioda_pe_dma_weight(pe);
+	int64_t rc;
+
+	if (!weight)
+		return;
+
+	tbl = pe->table_group.tables[0];
+	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+	if (rc)
+		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
+
+	pnv_pci_ioda2_set_bypass(pe, false);
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		WARN_ON(pe->table_group.group);
+	}
+
+	pnv_pci_ioda2_table_free_pages(tbl);
+	iommu_free_table(tbl, "pnv");
+}
+
+static void pnv_ioda_release_dma_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+
+	switch (phb->type) {
+	case PNV_PHB_IODA1:
+		pnv_pci_ioda1_release_dma_pe(pe);
+		break;
+	case PNV_PHB_IODA2:
+		pnv_pci_ioda2_release_dma_pe(pe);
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
+static void pnv_ioda_release_window(struct pnv_ioda_pe *pe, int win)
+{
+	struct pnv_phb *phb = pe->phb;
+	int index, *segmap = NULL;
+	int64_t rc;
+
+	switch (win) {
+	case OPAL_IO_WINDOW_TYPE:
+		segmap = phb->ioda.io_segmap;
+		break;
+	case OPAL_M32_WINDOW_TYPE:
+		segmap = phb->ioda.m32_segmap;
+		break;
+	case OPAL_M64_WINDOW_TYPE:
+		if (phb->type != PNV_PHB_IODA1)
+			return;
+		segmap = phb->ioda.m64_segmap;
+		break;
+	default:
+		return;
+	}
+
+	for (index = 0; index < phb->ioda.total_pe_num; index++) {
+		if (segmap[index] != pe->pe_number)
+			continue;
+
+		if (win == OPAL_M64_WINDOW_TYPE)
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					phb->ioda.reserved_pe_idx, win,
+					index / PNV_IODA1_M64_SEGS,
+					index % PNV_IODA1_M64_SEGS);
+		else
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					phb->ioda.reserved_pe_idx, win,
+					0, index);
+
+		if (rc != OPAL_SUCCESS)
+			pe_warn(pe, "Error %ld unmapping (%d) segment#%d\n",
+				rc, win, index);
+
+		segmap[index] = IODA_INVALID_PE;
+	}
+}
+
+static void pnv_ioda_release_pe_seg(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	int win;
+
+	for (win = OPAL_M32_WINDOW_TYPE; win <= OPAL_IO_WINDOW_TYPE; win++) {
+		if (phb->type == PNV_PHB_IODA2 && win == OPAL_IO_WINDOW_TYPE)
+			continue;
+
+		pnv_ioda_release_window(pe, win);
+	}
+}
+
+static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb,
+				   struct pnv_ioda_pe *pe);
+static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe);
+static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_ioda_pe *tmp, *slave;
+
+	/* Release slave PEs in compound PE */
+	if (pe->flags & PNV_IODA_PE_MASTER) {
+		list_for_each_entry_safe(slave, tmp, &pe->slaves, list)
+			pnv_ioda_release_pe(slave);
+	}
+
+	/* Remove the PE from the list */
+	list_del(&pe->list);
+
+	/* Release resources */
+	pnv_ioda_release_dma_pe(pe);
+	pnv_ioda_release_pe_seg(pe);
+	pnv_ioda_deconfigure_pe(pe->phb, pe);
+
+	pnv_ioda_free_pe(pe);
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
+	WARN_ON(pe->device_count < 0);
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
+
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
 	phb->ioda.pe_array[pe_no].phb = phb;
@@ -724,7 +933,6 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 	return 0;
 }
 
-#ifdef CONFIG_PCI_IOV
 static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -759,9 +967,11 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
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
@@ -799,11 +1009,12 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	pe->pbus = NULL;
 	pe->pdev = NULL;
+#ifdef CONFIG_PCI_IOV
 	pe->parent_dev = NULL;
+#endif
 
 	return 0;
 }
-#endif /* CONFIG_PCI_IOV */
 
 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
@@ -985,6 +1196,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 			continue;
 
 		pdn->pe_number = pe->pe_number;
+		pnv_ioda_pe_get(pe);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_same_PE(dev->subordinate, pe);
 	}
@@ -1047,9 +1259,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 			bus->busn_res.start, pe->pe_number);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
-		/* XXX What do we do here ? */
-		pnv_ioda_free_pe(pe);
 		pe->pbus = NULL;
+		pnv_ioda_release_pe(pe);
 		return NULL;
 	}
 
@@ -1199,29 +1410,6 @@ m64_failed:
 	return -EBUSY;
 }
 
-static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
-		int num);
-static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
-
-static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
-{
-	struct iommu_table    *tbl;
-	int64_t               rc;
-
-	tbl = pe->table_group.tables[0];
-	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
-	if (rc)
-		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
-
-	pnv_pci_ioda2_set_bypass(pe, false);
-	if (pe->table_group.group) {
-		iommu_group_put(pe->table_group.group);
-		BUG_ON(pe->table_group.group);
-	}
-	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
-}
-
 static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 {
 	struct pci_bus        *bus;
@@ -1242,7 +1430,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 		if (pe->parent_dev != pdev)
 			continue;
 
-		pnv_pci_ioda2_release_dma_pe(pdev, pe);
+		pnv_pci_ioda2_release_dma_pe(pe);
 
 		/* Remove from list */
 		mutex_lock(&phb->ioda.pe_list_mutex);
@@ -3124,6 +3312,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 #endif
 	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.release_device		= pnv_pci_release_device,
 	.window_alignment	= pnv_pci_window_alignment,
 	.setup_bridge		= pnv_pci_setup_bridge,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index ef5271a..3bb10de 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -30,6 +30,7 @@ struct pnv_phb;
 struct pnv_ioda_pe {
 	unsigned long		flags;
 	struct pnv_phb		*phb;
+	int			device_count;
 
 	/* A PE can be associated with a single device or an
 	 * entire bus (& children). In the former case, pdev
-- 
2.1.0
