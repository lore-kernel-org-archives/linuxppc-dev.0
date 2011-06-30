Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: software invalidate TCEs on pseries
Date: Thu, 30 Jun 2011 16:58:33 +1000
Message-ID: <23422.1309417113@neuling.org>
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

Some pseries IOMMUs cache TCEs but don't snoop when the TCEs are changed
in memory, hence we need manually invalidate in software.

This adds code to do the invalidate.  It keys off a device tree property
to say where the to do the MMIO for the invalidate and some information
on what the format of the invalidate including some magic routing info.

it_busno get overloaded with this magic routing info and it_index with
the MMIO address for the invalidate command.

This then gets hooked into the building and freeing of TCEs.

This is only useful on bare metal pseries.  pHyp takes care of this when
virtualised.

Based on patch from Milton with cleanups from Mikey.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/tce.h         |    8 ++--
 arch/powerpc/platforms/pseries/iommu.c |   61 ++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 8 deletions(-)

Index: linux-ozlabs/arch/powerpc/include/asm/tce.h
===================================================================
--- linux-ozlabs.orig/arch/powerpc/include/asm/tce.h
+++ linux-ozlabs/arch/powerpc/include/asm/tce.h
@@ -26,10 +26,12 @@
 
 /*
  * Tces come in two formats, one for the virtual bus and a different
- * format for PCI
+ * format for PCI.  PCI TCEs can have hardware or software maintianed
+ * coherency.
  */
-#define TCE_VB  0
-#define TCE_PCI 1
+#define TCE_VB			0
+#define TCE_PCI			1
+#define TCE_PCI_SW_INVAL	2
 
 /* TCE page size is 4096 bytes (1 << 12) */
 
Index: linux-ozlabs/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-ozlabs.orig/arch/powerpc/platforms/pseries/iommu.c
+++ linux-ozlabs/arch/powerpc/platforms/pseries/iommu.c
@@ -51,13 +51,42 @@
 #include "plpar_wrappers.h"
 
 
+static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
+				      u64 *startp, u64 *endp)
+{
+	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
+	unsigned long start, end, inc;
+
+	start = __pa(startp);
+	end = __pa(endp);
+	inc = L1_CACHE_BYTES; /* invalidate a cacheline of TCEs at a time */
+
+	/* If this is non-zero, change the format.  We shift the
+	 * address and or in the magic from the device tree. */
+	if (tbl->it_busno) {
+		start <<= 12;
+		end <<= 12;
+		inc <<= 12;
+		start |= tbl->it_busno;
+		end |= tbl->it_busno;
+	}
+
+	end |= inc - 1; /* round up end to be different than start */
+
+	mb(); /* Make sure TCEs in memory are written */
+	while (start <= end) {
+		out_be64(invalidate, start);
+		start += inc;
+	}
+}
+
 static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
 			      enum dma_data_direction direction,
 			      struct dma_attrs *attrs)
 {
 	u64 proto_tce;
-	u64 *tcep;
+	u64 *tcep, *tces;
 	u64 rpn;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
@@ -65,7 +94,7 @@ static int tce_build_pSeries(struct iomm
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
 
-	tcep = ((u64 *)tbl->it_base) + index;
+	tces = tcep = ((u64 *)tbl->it_base) + index;
 
 	while (npages--) {
 		/* can't move this out since we might cross MEMBLOCK boundary */
@@ -75,18 +104,24 @@ static int tce_build_pSeries(struct iomm
 		uaddr += TCE_PAGE_SIZE;
 		tcep++;
 	}
+
+	if (tbl->it_type == TCE_PCI_SW_INVAL)
+		tce_invalidate_pSeries_sw(tbl, tces, tcep - 1);
 	return 0;
 }
 
 
 static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 {
-	u64 *tcep;
+	u64 *tcep, *tces;
 
-	tcep = ((u64 *)tbl->it_base) + index;
+	tces = tcep = ((u64 *)tbl->it_base) + index;
 
 	while (npages--)
 		*(tcep++) = 0;
+
+	if (tbl->it_type == TCE_PCI_SW_INVAL)
+		tce_invalidate_pSeries_sw(tbl, tces, tcep - 1);
 }
 
 static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
@@ -424,7 +459,7 @@ static void iommu_table_setparms(struct
 				 struct iommu_table *tbl)
 {
 	struct device_node *node;
-	const unsigned long *basep;
+	const unsigned long *basep, *sw_inval;
 	const u32 *sizep;
 
 	node = phb->dn;
@@ -461,6 +496,22 @@ static void iommu_table_setparms(struct
 	tbl->it_index = 0;
 	tbl->it_blocksize = 16;
 	tbl->it_type = TCE_PCI;
+
+	sw_inval = of_get_property(node, "linux,tce-sw-invalidate-info", NULL);
+	if (sw_inval) {
+		/*
+		 * This property contains information on how to
+		 * invalidate the TCE entry.  The first property is
+		 * the base MMIO address used to invalidate entries.
+		 * The second property tells us the format of the TCE
+		 * invalidate (whether it needs to be shifted) and
+		 * some magic routing info to add to our invalidate
+		 * command.
+		 */
+		tbl->it_index = (unsigned long) ioremap(sw_inval[0], 8);
+		tbl->it_busno = sw_inval[1]; /* overload this with magic */
+		tbl->it_type = TCE_PCI_SW_INVAL;
+	}
 }
 
 /*
