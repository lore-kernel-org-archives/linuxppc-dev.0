Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F25642C018B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 15:21:24 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 26 Apr 2013 01:21:21 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id ACA4638C801A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 01:21:12 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3Q5LCUw272322
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 01:21:12 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3Q5LBlm018235
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 01:21:12 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/6] powerpc/powernv: TCE invalidation for PHB3
Date: Fri, 26 Apr 2013 13:21:00 +0800
Message-Id: <1366953662-9473-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366953662-9473-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366953662-9473-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The TCE should be invalidated while it's created or free'd. The
approach to do that for IODA1 and IODA2 compliant PHBs are different.
So the patch differentiate them with different functions called to
do that for IODA1 and IODA2 compliant PHBs. It's notable that the
PCI address is used to invalidate the corresponding TCE on IODA2
compliant PHB3.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   85 ++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c      |   48 +---------------
 arch/powerpc/platforms/powernv/pci.h      |    6 ++-
 3 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3f88c51..1c7e808 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -89,6 +89,7 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 			return IODA_INVALID_PE;
 	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
 
+	phb->ioda.pe_array[pe].phb = phb;
 	phb->ioda.pe_array[pe].pe_number = pe;
 	return pe;
 }
@@ -449,6 +450,85 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 	}
 }
 
+static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
+					 u64 *startp, u64 *endp)
+{
+	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
+	unsigned long start, end, inc;
+
+	start = __pa(startp);
+	end = __pa(endp);
+
+	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
+	if (tbl->it_busno) {
+		start <<= 12;
+		end <<= 12;
+		inc = 128 << 12;
+		start |= tbl->it_busno;
+		end |= tbl->it_busno;
+	} else if (tbl->it_type & TCE_PCI_SWINV_PAIR) {
+		/* p7ioc-style invalidation, 2 TCEs per write */
+		start |= (1ull << 63);
+		end |= (1ull << 63);
+		inc = 16;
+        } else {
+		/* Default (older HW) */
+                inc = 128;
+	}
+
+        end |= inc - 1;	/* round up end to be different than start */
+
+        mb(); /* Ensure above stores are visible */
+        while (start <= end) {
+                __raw_writeq(start, invalidate);
+                start += inc;
+        }
+
+	/*
+	 * The iommu layer will do another mb() for us on build()
+	 * and we don't care on free()
+	 */
+}
+
+static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
+					 struct iommu_table *tbl,
+					 u64 *startp, u64 *endp)
+{
+	unsigned long start, end, inc;
+	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
+
+	/* We'll invalidate DMA address in PE scope */
+	start = 0x2ul << 60;
+	start |= (pe->pe_number & 0xFF);
+	end = start;
+
+	/* Figure out the start, end and step */
+	inc = tbl->it_offset + (((u64)startp - tbl->it_base) / sizeof(u64));
+	start |= (inc << 12);
+	inc = tbl->it_offset + (((u64)endp - tbl->it_base) / sizeof(u64));
+	end |= (inc << 12);
+	inc = (0x1ul << 12);
+	mb();
+
+	while (start <= end) {
+		__raw_writeq(start, invalidate);
+		start += inc;
+	}
+}
+
+void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
+				 u64 *startp, u64 *endp)
+{
+	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
+					      tce32_table);
+	struct pnv_phb *phb = pe->phb;
+
+	if (phb->type == PNV_PHB_IODA1)
+		pnv_pci_ioda1_tce_invalidate(tbl, startp, endp);
+	else
+		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp);
+}
+
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
@@ -520,8 +600,9 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		 */
 		tbl->it_busno = 0;
 		tbl->it_index = (unsigned long)ioremap(be64_to_cpup(swinvp), 8);
-		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE
-			| TCE_PCI_SWINV_PAIR;
+		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
+		if (phb->type == PNV_PHB_IODA1)
+			tbl->it_type |= TCE_PCI_SWINV_PAIR;
 	}
 	iommu_init_table(tbl, phb->hose->node);
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 861e185..55dfca844 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -329,48 +329,6 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
-
-static void pnv_tce_invalidate(struct iommu_table *tbl,
-			       u64 *startp, u64 *endp)
-{
-	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
-	unsigned long start, end, inc;
-
-	start = __pa(startp);
-	end = __pa(endp);
-
-
-	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
-	if (tbl->it_busno) {
-		start <<= 12;
-		end <<= 12;
-		inc = 128 << 12;
-		start |= tbl->it_busno;
-		end |= tbl->it_busno;
-	}
-	/* p7ioc-style invalidation, 2 TCEs per write */
-	else if (tbl->it_type & TCE_PCI_SWINV_PAIR) {
-		start |= (1ull << 63);
-		end |= (1ull << 63);
-		inc = 16;
-	}
-	/* Default (older HW) */
-	else
-		inc = 128;
-
-	end |= inc - 1;		/* round up end to be different than start */
-
-	mb(); /* Ensure above stores are visible */
-	while (start <= end) {
-		__raw_writeq(start, invalidate);
-		start += inc;
-	}
-	/* The iommu layer will do another mb() for us on build() and
-	 * we don't care on free()
-	 */
-}
-
-
 static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			 unsigned long uaddr, enum dma_data_direction direction,
 			 struct dma_attrs *attrs)
@@ -395,7 +353,7 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	 * of flags if that becomes the case
 	 */
 	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		pnv_tce_invalidate(tbl, tces, tcep - 1);
+		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1);
 
 	return 0;
 }
@@ -409,8 +367,8 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 	while (npages--)
 		*(tcep++) = 0;
 
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_tce_invalidate(tbl, tces, tcep - 1);
+	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
+		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1);
 }
 
 static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3c552b3..48dc4bb 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -23,8 +23,10 @@ enum pnv_phb_model {
 #define PNV_IODA_PE_BUS_ALL	(1 << 2)	/* PE has subordinate buses	*/
 
 /* Data associated with a PE, including IOMMU tracking etc.. */
+struct pnv_phb;
 struct pnv_ioda_pe {
 	unsigned long		flags;
+	struct pnv_phb		*phb;
 
 	/* A PE can be associated with a single device or an
 	 * entire bus (& children). In the former case, pdev
@@ -154,6 +156,6 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
-
-
+extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
+					u64 *startp, u64 *endp);
 #endif /* __POWERNV_PCI_H */
-- 
1.7.5.4
