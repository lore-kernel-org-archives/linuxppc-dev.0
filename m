Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6DE0E1007D4
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2011 15:58:14 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
 by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id pA74pOPq024053
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:51:24 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA74tGVA2371730
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:55:16 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA74wD5k020789
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Nov 2011 15:58:13 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/powernv: Add TCE SW invalidation support
Date: Mon,  7 Nov 2011 15:55:59 +1100
Message-Id: <1320641761-4028-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1320641761-4028-1-git-send-email-benh@kernel.crashing.org>
References: <1320641761-4028-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is used for newer IO Hubs such as p7IOC.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/tce.h       |   10 +++-
 arch/powerpc/platforms/powernv/pci.c |   84 +++++++++++++++++++++++++++++-----
 2 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
index f663634..e01907d 100644
--- a/arch/powerpc/include/asm/tce.h
+++ b/arch/powerpc/include/asm/tce.h
@@ -26,10 +26,14 @@
 
 /*
  * Tces come in two formats, one for the virtual bus and a different
- * format for PCI
+ * format for PCI. We also use a separate value for SW invalidated
+ * PCI
  */
-#define TCE_VB  0
-#define TCE_PCI 1
+#define TCE_VB  		0
+#define TCE_PCI 		1
+#define TCE_PCI_SWINV_CREATE	2
+#define TCE_PCI_SWINV_FREE	4
+#define TCE_PCI_SWINV_PAIR	8
 
 /* TCE page size is 4096 bytes (1 << 12) */
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 85bb66d..8b90d94 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -257,12 +257,54 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
+
+static void pnv_tce_invalidate(struct iommu_table *tbl,
+			       u64 *startp, u64 *endp)
+{
+	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
+	unsigned long start, end, inc;
+
+	start = __pa(startp);
+	end = __pa(endp);
+
+
+	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
+	if (tbl->it_busno) {
+		start <<= 12;
+		end <<= 12;
+		inc = 128 << 12;
+		start |= tbl->it_busno;
+		end |= tbl->it_busno;
+	}
+	/* p7ioc-style invalidation, 2 TCEs per write */
+	else if (tbl->it_type & TCE_PCI_SWINV_PAIR) {
+		start |= (1ull << 63);
+		end |= (1ull << 63);
+		inc = 16;
+	}
+	/* Default (older HW) */
+	else
+		inc = 128;
+
+	end |= inc - 1;		/* round up end to be different than start */
+
+	mb(); /* Ensure above stores are visible */
+	while (start <= end) {
+		__raw_writeq(start, invalidate);
+		start += inc;
+	}
+	/* The iommu layer will do another mb() for us on build() and
+	 * we don't care on free()
+	 */
+}
+
+
 static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			 unsigned long uaddr, enum dma_data_direction direction,
 			 struct dma_attrs *attrs)
 {
 	u64 proto_tce;
-	u64 *tcep;
+	u64 *tcep, *tces;
 	u64 rpn;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
@@ -270,25 +312,33 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
 
-	tcep = ((u64 *)tbl->it_base) + index;
+	tces = tcep = ((u64 *)tbl->it_base) + index - tbl->it_offset;
+	rpn = __pa(uaddr) >> TCE_SHIFT;
 
-	while (npages--) {
-		/* can't move this out since we might cross LMB boundary */
-		rpn = (virt_to_abs(uaddr)) >> TCE_SHIFT;
-		*tcep = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+	while (npages--)
+		*(tcep++) = proto_tce | (rpn++ << TCE_RPN_SHIFT);
+
+	/* Some implementations won't cache invalid TCEs and thus may not
+	 * need that flush. We'll probably turn it_type into a bit mask
+	 * of flags if that becomes the case
+	 */
+	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
+		pnv_tce_invalidate(tbl, tces, tcep - 1);
 
-		uaddr += TCE_PAGE_SIZE;
-		tcep++;
-	}
 	return 0;
 }
 
 static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
-	u64 *tcep = ((u64 *)tbl->it_base) + index;
+	u64 *tcep, *tces;
+
+	tces = tcep = ((u64 *)tbl->it_base) + index - tbl->it_offset;
 
 	while (npages--)
 		*(tcep++) = 0;
+
+	if (tbl->it_type & TCE_PCI_SWINV_FREE)
+		pnv_tce_invalidate(tbl, tces, tcep - 1);
 }
 
 void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
@@ -308,13 +358,14 @@ static struct iommu_table * __devinit
 pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 {
 	struct iommu_table *tbl;
-	const __be64 *basep;
+	const __be64 *basep, *swinvp;
 	const __be32 *sizep;
 
 	basep = of_get_property(hose->dn, "linux,tce-base", NULL);
 	sizep = of_get_property(hose->dn, "linux,tce-size", NULL);
 	if (basep == NULL || sizep == NULL) {
-		pr_err("PCI: %s has missing tce entries !\n", hose->dn->full_name);
+		pr_err("PCI: %s has missing tce entries !\n",
+		       hose->dn->full_name);
 		return NULL;
 	}
 	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, hose->node);
@@ -323,6 +374,15 @@ pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
 				  be32_to_cpup(sizep), 0);
 	iommu_init_table(tbl, hose->node);
+
+	/* Deal with SW invalidated TCEs when needed (BML way) */
+	swinvp = of_get_property(hose->dn, "linux,tce-sw-invalidate-info",
+				 NULL);
+	if (swinvp) {
+		tbl->it_busno = swinvp[1];
+		tbl->it_index = (unsigned long)ioremap(swinvp[0], 8);
+		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
+	}
 	return tbl;
 }
 
-- 
1.7.7.1
