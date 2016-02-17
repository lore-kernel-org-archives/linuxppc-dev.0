Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D6671A032C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:46:18 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:46:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DB6602CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:46:15 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3k70249610824
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:46:15 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jgoC019367
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:43 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 23/45] powerpc/powernv: Dynamically release PEs
Date: Wed, 17 Feb 2016 14:44:06 +1100
Message-Id: <1455680668-23298-24-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This support releasing PEs dynamically. Firstly, this moves
pnv_pci_ioda2_release_dma_pe() around, which is called to
release DMA resource on releasing IODA2 PE. Secondly, several
functions are implemented to release the consumed resources
on releasing the PE:

   * pnv_pci_ioda1_unset_window() to unset TVEs for the PE.
   * pnv_pci_ioda1_release_dma_pe() to unset TVEs for the PE and
     destroy the IOMMU table.
   * pnv_ioda_release_pe_seg() releases the consumed IO/M32/M64
     segments by the PE.

Lastly, this adds a reference count of PE, representing the number
of PCI devices associated with the PE. The reference count is
increased when PCI device joins the PE. It's decreased when PCI
device leaves the PE in pnv_pci_release_device(). When the count
becomes zero, its consumed resources are released by functions
as mentioned above. Note that the count is accessed concurrently.
So a "counter" with "int" type is enough here.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 236 ++++++++++++++++++++++++++----
 arch/powerpc/platforms/powernv/pci.h      |   1 +
 2 files changed, 209 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 077f9db..fa428a8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -119,6 +119,158 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static unsigned int pnv_pci_ioda_pe_dma_weight(struct pnv_ioda_pe *pe);
+static long pnv_pci_ioda1_unset_window(struct iommu_table_group *table_group,
+				       int num);
+static void pnv_pci_ioda1_release_dma_pe(struct pnv_ioda_pe *pe)
+{
+	struct iommu_table *tbl;
+	unsigned int weight = pnv_pci_ioda_pe_dma_weight(pe);
+	int64_t rc;
+
+	if (!weight)
+		return;
+
+	tbl = pe->table_group.tables[0];
+	rc = pnv_pci_ioda1_unset_window(&pe->table_group, 0);
+	if (rc)
+		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
+
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		WARN_ON(pe->table_group.group);
+	}
+
+	pnv_pci_ioda_table_free_pages(tbl);
+	iommu_free_table(tbl, "pnv");
+}
+
+static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
+				       int num);
+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
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
+	pnv_pci_ioda_table_free_pages(tbl);
+	iommu_free_table(tbl, "pnv");
+}
+
+static void pnv_ioda_release_pe_seg(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	int win, index, *segmap = NULL;
+	int64_t rc;
+
+	for (win = OPAL_M32_WINDOW_TYPE; win <= OPAL_IO_WINDOW_TYPE; win++) {
+		if (phb->type == PNV_PHB_IODA2 &&
+		    (win == OPAL_IO_WINDOW_TYPE || win == OPAL_M64_WINDOW_TYPE))
+			continue;
+
+		switch (win) {
+		case OPAL_IO_WINDOW_TYPE:
+			segmap = phb->ioda.io_segmap;
+			break;
+		case OPAL_M32_WINDOW_TYPE:
+			segmap = phb->ioda.m32_segmap;
+			break;
+		case OPAL_M64_WINDOW_TYPE:
+			segmap = phb->ioda.m64_segmap;
+			break;
+		}
+
+		for (index = 0; index < phb->ioda.total_pe_num; index++) {
+			if (segmap[index] != pe->pe_number)
+				continue;
+
+			if (win == OPAL_M64_WINDOW_TYPE)
+				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+						phb->ioda.reserved_pe_idx, win,
+						index / PNV_IODA1_M64_SEGS,
+						index % PNV_IODA1_M64_SEGS);
+			else
+				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+						phb->ioda.reserved_pe_idx, win,
+						0, index);
+			if (rc != OPAL_SUCCESS)
+				pe_warn(pe, "Error %ld unmapping (%d) segment#%d\n",
+					rc, win, index);
+
+			segmap[index] = IODA_INVALID_PE;
+		}
+	}
+}
+
+static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb,
+				   struct pnv_ioda_pe *pe);
+static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe);
+static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
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
+	/* Release DMA segments */
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
+
+	pnv_ioda_release_pe_seg(pe);
+	pnv_ioda_deconfigure_pe(pe->phb, pe);
+
+	pnv_ioda_free_pe(pe);
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
+	WARN_ON(--pe->device_count < 0);
+	if (pe->device_count == 0)
+		pnv_ioda_release_pe(pe);
+}
+
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
 	phb->ioda.pe_array[pe_no].phb = phb;
@@ -715,7 +867,6 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 	return 0;
 }
 
-#ifdef CONFIG_PCI_IOV
 static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -750,9 +901,11 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
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
@@ -790,11 +943,12 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
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
@@ -1031,6 +1185,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 		if (pdn->pe_number != IODA_INVALID_PE)
 			continue;
 
+		pe->device_count++;
 		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
@@ -1095,9 +1250,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 			bus->busn_res.start, pe->pe_number);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
-		/* XXX What do we do here ? */
-		pnv_ioda_free_pe(pe);
 		pe->pbus = NULL;
+		pnv_ioda_release_pe(pe);
 		return NULL;
 	}
 
@@ -1333,29 +1487,6 @@ m64_failed:
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
-	pnv_pci_ioda_table_free_pages(tbl);
-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
-}
-
 static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 {
 	struct pci_bus        *bus;
@@ -1376,7 +1507,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 		if (pe->parent_dev != pdev)
 			continue;
 
-		pnv_pci_ioda2_release_dma_pe(pdev, pe);
+		pnv_pci_ioda2_release_dma_pe(pe);
 
 		/* Remove from list */
 		mutex_lock(&phb->ioda.pe_list_mutex);
@@ -1780,6 +1911,16 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 	 */
 }
 
+static void pnv_pci_ioda1_tce_invalidate_entire(struct pnv_ioda_pe *pe)
+{
+	struct iommu_table *tbl = pe->table_group.tables[0];
+
+	if (!tbl)
+		return;
+
+	pnv_pci_ioda1_tce_invalidate(tbl, tbl->it_offset, tbl->it_size, false);
+}
+
 static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
 		long npages, unsigned long uaddr,
 		enum dma_data_direction direction,
@@ -2144,6 +2285,44 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	}
 }
 
+static long pnv_pci_ioda1_unset_window(struct iommu_table_group *table_group,
+				       int num)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+					      table_group);
+	struct pnv_phb *phb = pe->phb;
+	int start, count, i;
+	long rc = OPAL_SUCCESS;
+
+	pe_info(pe, "Removing DMA window #%d\n", num);
+
+	/* Search the used DMA32 segments */
+	start = -1;
+	count = 0;
+	for (i = 0; i < phb->ioda.dma32_count; i++) {
+		if (phb->ioda.dma32_segmap[i] != pe->pe_number)
+			continue;
+
+		if (count++ == 0)
+			start = i;
+	}
+
+	if (!count)
+		return OPAL_SUCCESS;
+
+	for (i = start; i < start + count; i++)
+		rc |= opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+						 i, 0, 0ul, 0ul, 0ul);
+	if (rc)
+		pe_warn(pe, "Failure %ld unmapping TVEs\n");
+	else
+		pnv_pci_ioda1_tce_invalidate_entire(pe);
+
+	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
+
+	return rc;
+}
+
 static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 		int num, struct iommu_table *tbl)
 {
@@ -3318,6 +3497,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 #endif
 	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.release_device		= pnv_pci_release_device,
 	.window_alignment	= pnv_pci_window_alignment,
 	.setup_bridge		= pnv_pci_setup_bridge,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 01f2428..0cddde3 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -31,6 +31,7 @@ struct pnv_phb;
 struct pnv_ioda_pe {
 	unsigned long		flags;
 	struct pnv_phb		*phb;
+	int			device_count;
 
 #define PNV_IODA_MAX_PEER_PES	8
 	struct pnv_ioda_pe	*peers[PNV_IODA_MAX_PEER_PES];
-- 
2.1.0
