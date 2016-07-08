Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4YR4NXkzDrK2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:37:47 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm4YQ6P3Bz9s5Q
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 16:37:46 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/14] powerpc/powernv/pci: Remove SWINV constants and
 obsolete TCE code
Date: Fri,  8 Jul 2016 16:37:13 +1000
Message-Id: <1467959838-6900-9-git-send-email-benh@kernel.crashing.org>
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

We have some obsolete code in pnv_pci_p7ioc_tce_invalidate()
to handle some internal lab tools that have stopped being
useful a long time ago. Remove that along with the definition
and test for the TCE_PCI_SWINV_* flags whose value is basically
always the same.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/tce.h            |  3 --
 arch/powerpc/platforms/powernv/pci-ioda.c | 50 +++++++------------------------
 2 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
index 743f36b..12e3629 100644
--- a/arch/powerpc/include/asm/tce.h
+++ b/arch/powerpc/include/asm/tce.h
@@ -31,9 +31,6 @@
  */
 #define TCE_VB			0
 #define TCE_PCI			1
-#define TCE_PCI_SWINV_CREATE	2
-#define TCE_PCI_SWINV_FREE	4
-#define TCE_PCI_SWINV_PAIR	8
 
 /* TCE page size is 4096 bytes (1 << 12) */
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index afb1c5e..dc13c14 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1739,29 +1739,15 @@ static void pnv_pci_p7ioc_tce_invalidate(struct iommu_table *tbl,
 		(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
 		pe->phb->ioda.tce_inval_reg;
 	unsigned long start, end, inc;
-	const unsigned shift = tbl->it_page_shift;
 
 	start = __pa(((__be64 *)tbl->it_base) + index - tbl->it_offset);
 	end = __pa(((__be64 *)tbl->it_base) + index - tbl->it_offset +
 			npages - 1);
 
-	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
-	if (tbl->it_busno) {
-		start <<= shift;
-		end <<= shift;
-		inc = 128ull << shift;
-		start |= tbl->it_busno;
-		end |= tbl->it_busno;
-	} else if (tbl->it_type & TCE_PCI_SWINV_PAIR) {
-		/* p7ioc-style invalidation, 2 TCEs per write */
-		start |= (1ull << 63);
-		end |= (1ull << 63);
-		inc = 16;
-        } else {
-		/* Default (older HW) */
-                inc = 128;
-	}
-
+	/* p7ioc-style invalidation, 2 TCEs per write */
+	start |= (1ull << 63);
+	end |= (1ull << 63);
+	inc = 16;
         end |= inc - 1;	/* round up end to be different than start */
 
         mb(); /* Ensure above stores are visible */
@@ -1787,7 +1773,7 @@ static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
 	int ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
 			attrs);
 
-	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
+	if (!ret)
 		pnv_pci_p7ioc_tce_invalidate(tbl, index, npages, false);
 
 	return ret;
@@ -1799,8 +1785,7 @@ static int pnv_ioda1_tce_xchg(struct iommu_table *tbl, long index,
 {
 	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
 
-	if (!ret && (tbl->it_type &
-			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
+	if (!ret)
 		pnv_pci_p7ioc_tce_invalidate(tbl, index, 1, false);
 
 	return ret;
@@ -1812,8 +1797,7 @@ static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
 {
 	pnv_tce_free(tbl, index, npages);
 
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_p7ioc_tce_invalidate(tbl, index, npages, false);
+	pnv_pci_p7ioc_tce_invalidate(tbl, index, npages, false);
 }
 
 static struct iommu_table_ops pnv_ioda1_iommu_ops = {
@@ -1916,7 +1900,7 @@ static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
 	int ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
 			attrs);
 
-	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
+	if (!ret)
 		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
 
 	return ret;
@@ -1928,8 +1912,7 @@ static int pnv_ioda2_tce_xchg(struct iommu_table *tbl, long index,
 {
 	long ret = pnv_tce_xchg(tbl, index, hpa, direction);
 
-	if (!ret && (tbl->it_type &
-			(TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE)))
+	if (!ret)
 		pnv_pci_ioda2_tce_invalidate(tbl, index, 1, false);
 
 	return ret;
@@ -1941,8 +1924,7 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
 {
 	pnv_tce_free(tbl, index, npages);
 
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
+	pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
 }
 
 static void pnv_ioda2_table_free(struct iommu_table *tbl)
@@ -2111,12 +2093,6 @@ found:
 				  base * PNV_IODA1_DMA32_SEGSIZE,
 				  IOMMU_PAGE_SHIFT_4K);
 
-	/* OPAL variant of P7IOC SW invalidated TCEs */
-	if (phb->ioda.tce_inval_reg)
-		tbl->it_type |= (TCE_PCI_SWINV_CREATE |
-				 TCE_PCI_SWINV_FREE   |
-				 TCE_PCI_SWINV_PAIR);
-
 	tbl->it_ops = &pnv_ioda1_iommu_ops;
 	pe->table_group.tce32_start = tbl->it_offset << tbl->it_page_shift;
 	pe->table_group.tce32_size = tbl->it_size << tbl->it_page_shift;
@@ -2239,8 +2215,6 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 	}
 
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
-	if (pe->phb->ioda.tce_inval_reg)
-		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 
 	*ptbl = tbl;
 
@@ -2289,10 +2263,6 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	if (!pnv_iommu_bypass_disabled)
 		pnv_pci_ioda2_set_bypass(pe, true);
 
-	/* OPAL variant of PHB3 invalidated TCEs */
-	if (pe->phb->ioda.tce_inval_reg)
-		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
-
 	/*
 	 * Setting table base here only for carrying iommu_group
 	 * further down to let iommu_add_device() do the job.
-- 
2.7.4
