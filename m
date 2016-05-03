Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhgs49XRzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:21 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:19 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 828FB3940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:53:15 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNE6L24772818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:14 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNBJG023576
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:14 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 10/22] powerpc/powernv: Dynamically release PE
Date: Tue,  3 May 2016 23:22:41 +1000
Message-Id: <1462281773-26438-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This supports releasing PEs dynamically. A reference count is
introduced to PE representing number of PCI devices associated
with the PE. The reference count is increased when PCI device
joins the PE and decreased when PCI device leaves the PE in
pnv_pci_release_device(). When the count becomes zero, the PE
and its consumed resources are released. Note that the count
is accessed concurrently. So a counter with "int" type is enough
here.

In order to release the sources consumed by the PE, couple of
helper functions are introduced as below:

   * pnv_pci_ioda1_unset_window() - Unset IODA1 DMA32 window
   * pnv_pci_ioda1_release_dma_pe() - Release IODA1 DMA32 segments
   * pnv_pci_ioda2_release_dma_pe() - Release IODA2 DMA resource
   * pnv_ioda_release_pe_seg() - Unmap IO/M32/M64 segments

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 174 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |   1 +
 2 files changed, 175 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b32021b..ee56ed2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1037,6 +1037,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 		if (pdn->pe_number != IODA_INVALID_PE)
 			continue;
 
+		pe->device_count++;
 		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
@@ -3302,6 +3303,178 @@ static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
+static long pnv_pci_ioda1_unset_window(struct iommu_table_group *table_group,
+				       int num)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group,
+					      struct pnv_ioda_pe, table_group);
+	struct pnv_phb *phb = pe->phb;
+	unsigned int idx;
+	long rc;
+
+	pe_info(pe, "Removing DMA window #%d\n", num);
+	for (idx = 0; idx < phb->ioda.dma32_count; idx++) {
+		if (phb->ioda.dma32_segmap[idx] != pe->pe_number)
+			continue;
+
+		rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+						idx, 0, 0ul, 0ul, 0ul);
+		if (rc != OPAL_SUCCESS) {
+			pe_warn(pe, "Failure %ld unmapping DMA32 segment#%d\n",
+				rc, idx);
+			return rc;
+		}
+
+		phb->ioda.dma32_segmap[idx] = IODA_INVALID_PE;
+	}
+
+	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
+	return OPAL_SUCCESS;
+}
+
+static void pnv_pci_ioda1_release_dma_pe(struct pnv_ioda_pe *pe)
+{
+	unsigned int weight = pnv_pci_ioda_pe_dma_weight(pe);
+	struct iommu_table *tbl = pe->table_group.tables[0];
+	int64_t rc;
+
+	if (!weight)
+		return;
+
+	rc = pnv_pci_ioda1_unset_window(&pe->table_group, 0);
+	if (rc != OPAL_SUCCESS)
+		return;
+
+	pnv_pci_ioda1_tce_invalidate(tbl, tbl->it_offset, tbl->it_size, false);
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		WARN_ON(pe->table_group.group);
+	}
+
+	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
+	iommu_free_table(tbl, "pnv");
+}
+
+static void pnv_pci_ioda2_release_dma_pe(struct pnv_ioda_pe *pe)
+{
+	struct iommu_table *tbl = pe->table_group.tables[0];
+	unsigned int weight = pnv_pci_ioda_pe_dma_weight(pe);
+#ifdef CONFIG_IOMMU_API
+	int64_t rc;
+#endif
+
+	if (!weight)
+		return;
+
+#ifdef CONFIG_IOMMU_API
+	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+	if (rc)
+		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
+#endif
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
+static void pnv_ioda_free_pe_seg(struct pnv_ioda_pe *pe,
+				 unsigned short win,
+				 unsigned int *map)
+{
+	struct pnv_phb *phb = pe->phb;
+	int idx;
+	int64_t rc;
+
+	for (idx = 0; idx < phb->ioda.total_pe_num; idx++) {
+		if (map[idx] != pe->pe_number)
+			continue;
+
+		if (win == OPAL_M64_WINDOW_TYPE)
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					phb->ioda.reserved_pe_idx, win,
+					idx / PNV_IODA1_M64_SEGS,
+					idx % PNV_IODA1_M64_SEGS);
+		else
+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
+					phb->ioda.reserved_pe_idx, win, 0, idx);
+
+		if (rc != OPAL_SUCCESS)
+			pe_warn(pe, "Error %ld unmapping (%d) segment#%d\n",
+				rc, win, idx);
+
+		map[idx] = IODA_INVALID_PE;
+	}
+}
+
+static void pnv_ioda_release_pe_seg(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+
+	if (phb->type == PNV_PHB_IODA1) {
+		pnv_ioda_free_pe_seg(pe, OPAL_IO_WINDOW_TYPE,
+				     phb->ioda.io_segmap);
+		pnv_ioda_free_pe_seg(pe, OPAL_M32_WINDOW_TYPE,
+				     phb->ioda.m32_segmap);
+		pnv_ioda_free_pe_seg(pe, OPAL_M64_WINDOW_TYPE,
+				     phb->ioda.m64_segmap);
+	} else if (phb->type == PNV_PHB_IODA2) {
+		pnv_ioda_free_pe_seg(pe, OPAL_M32_WINDOW_TYPE,
+				     phb->ioda.m32_segmap);
+	}
+}
+
+static void pnv_ioda_release_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+	struct pnv_ioda_pe *slave, *tmp;
+
+	/* Release slave PEs in compound PE */
+	if (pe->flags & PNV_IODA_PE_MASTER) {
+		list_for_each_entry_safe(slave, tmp, &pe->slaves, list)
+			pnv_ioda_release_pe(slave);
+	}
+
+	list_del(&pe->list);
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
 static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -3318,6 +3491,7 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 #endif
 	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.release_device		= pnv_pci_release_device,
 	.window_alignment	= pnv_pci_window_alignment,
 	.setup_bridge		= pnv_pci_setup_bridge,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index a81bf01..dda5fa7 100644
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
