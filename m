Return-Path: <michael@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 14 Jul 2006 14:25:33 +1000
Subject: [PATCH] iseries: Move iommu_table_cb into platforms/iseries
In-Reply-To: <20060713075223.D1FC767BCD@ozlabs.org>
Message-Id: <20060714042533.5B00967B22@ozlabs.org>
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

 arch/powerpc/platforms/iseries/iommu.c   |   17 +++++++++++++++++
 include/asm-powerpc/iseries/hv_call_xm.h |   17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/iommu.c
+++ to-merge/arch/powerpc/platforms/iseries/iommu.c
@@ -88,6 +88,23 @@ static void tce_free_iSeries(struct iomm
 }
 
 /*
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
+/*
  * Call Hv with the architected data structure to get TCE table info.
  * info. Put the returned data into the Linux representation of the
  * TCE table data.
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
