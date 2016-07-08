Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4YQ3m3MzDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:46 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4YP3hW0z9s5Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:45 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/14] powerpc/powernv/pci: Rename TCE invalidation calls
Date: Fri,  8 Jul 2016 16:37:12 +1000
Message-Id: <1467959838-6900-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TCE invalidation functions are fairly implementation specific,
and while the IODA specs more/less describe the register, in practice
various implementation workarounds may be required. So name the
functions after the target PHB.

Note today and for the foreseeable future, there's a 1:1 relationship
between an IODA version and a PHB implementation. There exist another
variant of IODA1 (Torrent) but we never supported in with OPAL and
never will.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/npu-dma.c  |  8 +++----
 arch/powerpc/platforms/powernv/pci-ioda.c | 36 +++++++++++++++----------------
 arch/powerpc/platforms/powernv/pci.h      |  4 +---
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 0459e10..4383a5f 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -180,7 +180,7 @@ long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		pe_err(npe, "Failed to configure TCE table, err %lld\n", rc);
 		return rc;
 	}
-	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+	pnv_pci_phb3_tce_invalidate_entire(phb, false);
 
 	/* Add the table to the list so its TCE cache will get invalidated */
 	pnv_pci_link_table_and_group(phb->hose->node, num,
@@ -204,7 +204,7 @@ long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
 		pe_err(npe, "Unmapping failed, ret = %lld\n", rc);
 		return rc;
 	}
-	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+	pnv_pci_phb3_tce_invalidate_entire(phb, false);
 
 	pnv_pci_unlink_table_and_group(npe->table_group.tables[num],
 			&npe->table_group);
@@ -270,7 +270,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 			0 /* bypass base */, top);
 
 	if (rc == OPAL_SUCCESS)
-		pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+		pnv_pci_phb3_tce_invalidate_entire(phb, false);
 
 	return rc;
 }
@@ -334,7 +334,7 @@ void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
 		pe_err(npe, "Failed to disable bypass, err %lld\n", rc);
 		return;
 	}
-	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
+	pnv_pci_phb3_tce_invalidate_entire(npe->phb, false);
 }
 
 struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 092b2e6..afb1c5e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1727,7 +1727,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	}
 }
 
-static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
+static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
 	struct iommu_table_group_link *tgl = list_first_entry_or_null(
@@ -1788,7 +1788,7 @@ static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
 			attrs);
 
 	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
-		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
+		pnv_pci_p7ioc_tce_invalidate(tbl, index, npages, false);
 
 	return ret;
 }
@@ -1801,7 +1801,7 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
 
 	if (!ret && (tbl->it_type &
 			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
-		pnv_pci_ioda1_tce_invalidate(tbl, index, 1, false);
+		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, false);
 
 	return ret;
 }
@@ -1813,7 +1813,7 @@ static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
 	pnv_tce_free(tbl, index, npages);
 
 	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
+		pnv_pci_p7ioc_tce_invalidate(tbl, index, npages, false);
 }
 
 static struct iommu_table_ops pnv_ioda1_iommu_ops = {
@@ -1825,13 +1825,13 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
-#define TCE_KILL_INVAL_ALL  PPC_BIT(0)
-#define TCE_KILL_INVAL_PE   PPC_BIT(1)
-#define TCE_KILL_INVAL_TCE  PPC_BIT(2)
+#define PHB3_TCE_KILL_INVAL_ALL		PPC_BIT(0)
+#define PHB3_TCE_KILL_INVAL_PE		PPC_BIT(1)
+#define PHB3_TCE_KILL_INVAL_ONE		PPC_BIT(2)
 
-void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
+void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
 {
-	const unsigned long val = TCE_KILL_INVAL_ALL;
+	const unsigned long val = PHB3_TCE_KILL_INVAL_ALL;
 
 	mb(); /* Ensure previous TCE table stores are visible */
 	if (rm)
@@ -1842,10 +1842,10 @@ void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
 		__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
 }
 
-static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
+static inline void pnv_pci_phb3_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
-	unsigned long val = TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
+	unsigned long val = PHB3_TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
 	struct pnv_phb *phb = pe->phb;
 
 	if (!phb->ioda.tce_inval_reg)
@@ -1855,14 +1855,14 @@ static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
 }
 
-static void pnv_pci_ioda2_do_tce_invalidate(unsigned pe_number, bool rm,
+static void pnv_pci_phb3_tce_invalidate(unsigned pe_number, bool rm,
 		__be64 __iomem *invalidate, unsigned shift,
 		unsigned long index, unsigned long npages)
 {
 	unsigned long start, end, inc;
 
 	/* We'll invalidate DMA address in PE scope */
-	start = TCE_KILL_INVAL_TCE;
+	start = PHB3_TCE_KILL_INVAL_ONE;
 	start |= (pe_number & 0xFF);
 	end = start;
 
@@ -1899,10 +1899,10 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 			 * per TCE entry so we have to invalidate
 			 * the entire cache for it.
 			 */
-			pnv_pci_ioda2_tce_invalidate_entire(pe->phb, rm);
+			pnv_pci_phb3_tce_invalidate_entire(pe->phb, rm);
 			continue;
 		}
-		pnv_pci_ioda2_do_tce_invalidate(pe->pe_number, rm,
+		pnv_pci_phb3_tce_invalidate(pe->pe_number, rm,
 			invalidate, tbl->it_page_shift,
 			index, npages);
 	}
@@ -2178,7 +2178,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 
 	pnv_pci_link_table_and_group(phb->hose->node, num,
 			tbl, &pe->table_group);
-	pnv_pci_ioda2_tce_invalidate_pe(pe);
+	pnv_pci_phb3_tce_invalidate_pe(pe);
 
 	return 0;
 }
@@ -2322,7 +2322,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 	if (ret)
 		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
 	else
-		pnv_pci_ioda2_tce_invalidate_pe(pe);
+		pnv_pci_phb3_tce_invalidate_pe(pe);
 
 	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
 
@@ -3447,7 +3447,7 @@ static void pnv_pci_ioda1_release_pe_dma(struct pnv_ioda_pe *pe)
 	if (rc != OPAL_SUCCESS)
 		return;
 
-	pnv_pci_ioda1_tce_invalidate(tbl, tbl->it_offset, tbl->it_size, false);
+	pnv_pci_p7ioc_tce_invalidate(tbl, tbl->it_offset, tbl->it_size, false);
 	if (pe->table_group.group) {
 		iommu_group_put(pe->table_group.group);
 		WARN_ON(pe->table_group.group);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3a97990..8666471 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -203,8 +203,6 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_init_npu_phb(struct device_node *np);
-extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-					__be64 *startp, __be64 *endp, bool rm);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
 extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
 
@@ -224,7 +222,7 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
-extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
+extern void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
 extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		struct iommu_table *tbl);
-- 
2.7.4
