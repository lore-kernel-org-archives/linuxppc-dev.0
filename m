Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 13 Jul 2006 17:52:21 +1000
Subject: [PATCH 7/7] iseries: Move iommu_table_cb into platforms/iseries
In-Reply-To: <1152777121.430402.3949688126.qpush@concordia>
Message-Id: <20060713075223.D1FC767BCD@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Although we pass the address of an iommu_table_cb to HvCallXm_getTceTableParms,
we don't actually need the structure definition anywhere except in the
iseries iommu code, so move the struct in there.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/iommu.c   |    1 +
 arch/powerpc/platforms/iseries/iommu.h   |   17 +++++++++++++++++
 include/asm-powerpc/iseries/hv_call_xm.h |   17 -----------------
 3 files changed, 18 insertions(+), 17 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/iommu.c
+++ to-merge/arch/powerpc/platforms/iseries/iommu.c
@@ -36,6 +36,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/iommu.h>
+#include "iommu.h"
 
 static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction)
Index: to-merge/arch/powerpc/platforms/iseries/iommu.h
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/iommu.h
+++ to-merge/arch/powerpc/platforms/iseries/iommu.h
@@ -32,4 +32,21 @@ extern void iommu_table_getparms_iSeries
 		unsigned char slotno, unsigned char virtbus,
 		struct iommu_table *tbl);
 
+/*
+ * Structure passed to HvCallXm_getTceTableParms
+ */
+struct iommu_table_cb {
+	unsigned long	itc_busno;	/* Bus number for this tce table */
+	unsigned long	itc_start;	/* Will be NULL for secondary */
+	unsigned long	itc_totalsize;	/* Size (in pages) of whole table */
+	unsigned long	itc_offset;	/* Index into real tce table of the
+					   start of our section */
+	unsigned long	itc_size;	/* Size (in pages) of our section */
+	unsigned long	itc_index;	/* Index of this tce table */
+	unsigned short	itc_maxtables;	/* Max num of tables for partition */
+	unsigned char	itc_virtbus;	/* Flag to indicate virtual bus */
+	unsigned char	itc_slotno;	/* IOA Tce Slot Index */
+	unsigned char	itc_rsvd[4];
+};
+
 #endif /* _PLATFORMS_ISERIES_IOMMU_H */
Index: to-merge/include/asm-powerpc/iseries/hv_call_xm.h
===================================================================
--- to-merge.orig/include/asm-powerpc/iseries/hv_call_xm.h
+++ to-merge/include/asm-powerpc/iseries/hv_call_xm.h
@@ -16,23 +16,6 @@
 #define HvCallXmSetTce			HvCallXm + 11
 #define HvCallXmSetTces			HvCallXm + 13
 
-/*
- * Structure passed to HvCallXm_getTceTableParms
- */
-struct iommu_table_cb {
-	unsigned long	itc_busno;	/* Bus number for this tce table */
-	unsigned long	itc_start;	/* Will be NULL for secondary */
-	unsigned long	itc_totalsize;	/* Size (in pages) of whole table */
-	unsigned long	itc_offset;	/* Index into real tce table of the
-					   start of our section */
-	unsigned long	itc_size;	/* Size (in pages) of our section */
-	unsigned long	itc_index;	/* Index of this tce table */
-	unsigned short	itc_maxtables;	/* Max num of tables for partition */
-	unsigned char	itc_virtbus;	/* Flag to indicate virtual bus */
-	unsigned char	itc_slotno;	/* IOA Tce Slot Index */
-	unsigned char	itc_rsvd[4];
-};
-
 static inline void HvCallXm_getTceTableParms(u64 cb)
 {
 	HvCall1(HvCallXmGetTceTableParms, cb);
