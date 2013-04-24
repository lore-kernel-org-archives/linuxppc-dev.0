Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F0F902C0134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:37:55 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 05:37:50 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8FC876E8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:45 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O9bmaE39846092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:48 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O9blxP003668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:48 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/7] powerpc/powernv: TCE invalidation for PHB3
Date: Wed, 24 Apr 2013 17:37:37 +0800
Message-Id: <1366796259-29412-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/iommu.h            |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c   |   75 ++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    1 +
 arch/powerpc/platforms/powernv/pci.c        |   60 +++++----------------
 arch/powerpc/platforms/powernv/pci.h        |    6 ++-
 5 files changed, 93 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index cbfe678..0db308e 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -76,6 +76,7 @@ struct iommu_table {
 	struct iommu_pool large_pool;
 	struct iommu_pool pools[IOMMU_NR_POOLS];
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
+	void *sysdata;
 };
 
 struct scatterlist;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 32197af..9f4d323 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -448,6 +448,73 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 	}
 }
 
+void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
+				  u64 *startp, u64 *endp)
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
+void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
+				  u64 *startp, u64 *endp)
+{
+	unsigned long start, end, inc;
+	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
+	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
+					      tce32_table);
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
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
@@ -509,6 +576,9 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
 				  base << 28);
 
+	/* Hook the IOMMU table to PHB */
+	tbl->sysdata = phb;
+
 	/* OPAL variant of P7IOC SW invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
 	if (swinvp) {
@@ -519,8 +589,9 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
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
 
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index d5c066e..177ef26 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -167,6 +167,7 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
 
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
+	phb->p5ioc2.iommu_table.sysdata = phb;
 	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
 				  tce_mem, tce_size, 0);
 }
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index ea6a93d..f140c7a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -348,52 +348,11 @@ struct pci_ops pnv_pci_ops = {
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
 {
+	struct pnv_phb *phb = tbl->sysdata;
 	u64 proto_tce;
 	u64 *tcep, *tces;
 	u64 rpn;
@@ -413,14 +372,19 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	 * need that flush. We'll probably turn it_type into a bit mask
 	 * of flags if that becomes the case
 	 */
-	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		pnv_tce_invalidate(tbl, tces, tcep - 1);
+	if (tbl->it_type & TCE_PCI_SWINV_CREATE) {
+		if (phb->type == PNV_PHB_IODA1)
+			pnv_pci_ioda1_tce_invalidate(tbl, tces, tcep - 1);
+		else
+			pnv_pci_ioda2_tce_invalidate(tbl, tces, tcep - 1);
+	}
 
 	return 0;
 }
 
 static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
+	struct pnv_phb *phb = tbl->sysdata;
 	u64 *tcep, *tces;
 
 	tces = tcep = ((u64 *)tbl->it_base) + index - tbl->it_offset;
@@ -428,8 +392,12 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 	while (npages--)
 		*(tcep++) = 0;
 
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_tce_invalidate(tbl, tces, tcep - 1);
+	if (tbl->it_type & TCE_PCI_SWINV_CREATE) {
+		if (phb->type == PNV_PHB_IODA1)
+			pnv_pci_ioda1_tce_invalidate(tbl, tces, tcep - 1);
+		else
+			pnv_pci_ioda2_tce_invalidate(tbl, tces, tcep - 1);
+	}
 }
 
 static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index c6690b3..3cdc878 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -164,6 +164,8 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
-
-
+extern void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
+					 u64 *startp, u64 *endp);
+extern void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
+					 u64 *startp, u64 *endp);
 #endif /* __POWERNV_PCI_H */
-- 
1.7.5.4
