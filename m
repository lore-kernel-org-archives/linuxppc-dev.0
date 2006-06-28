Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 52A1567B44
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 19:50:50 +1000 (EST)
Date: Wed, 28 Jun 2006 02:50:36 -0700
To: paulus@samba.org
Subject: [PATCH] powerpc: U4 DART improvements
Message-ID: <20060628095036.GG5130@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Better late than never...

Respin based on previous comment. Only remaining issue last time was an
extra mb() that I've taken out.


---

Implement single-entry TLB invalidations in the U4 DART.

Simple benchmarking with loopback flood pings of various sizes show that
the previous flush-all code will spend ~5% of the time in flush, while
the new selective invalidations will spend about an order of magnitude
less in the same code path.

This could possibly mean that invalidations larger than, say, 16
entries would better be handled in bulk, but until we have a workload
that actually shows problems or bottlenecks let's keep doing single
invalidations at all mapping sizes.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: linux-2.6/arch/powerpc/sysdev/dart.h
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/dart.h
+++ linux-2.6/arch/powerpc/sysdev/dart.h
@@ -47,8 +47,12 @@
 /* U4 registers */
 #define DART_BASE_U4_BASE_MASK	0xffffff
 #define DART_BASE_U4_BASE_SHIFT	0
-#define DART_CNTL_U4_FLUSHTLB	0x20000000
 #define DART_CNTL_U4_ENABLE	0x80000000
+#define DART_CNTL_U4_IONE	0x40000000
+#define DART_CNTL_U4_FLUSHTLB	0x20000000
+#define DART_CNTL_U4_IDLE	0x10000000
+#define DART_CNTL_U4_PAR_EN	0x08000000
+#define DART_CNTL_U4_IONE_MASK	0x07ffffff
 #define DART_SIZE_U4_SIZE_MASK	0x1fff
 #define DART_SIZE_U4_SIZE_SHIFT	0
 
Index: linux-2.6/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/dart_iommu.c
+++ linux-2.6/arch/powerpc/sysdev/dart_iommu.c
@@ -101,8 +101,8 @@ retry:
 	if (l == (1L << limit)) {
 		if (limit < 4) {
 			limit++;
-		        reg = DART_IN(DART_CNTL);
-		        reg &= ~inv_bit;
+			reg = DART_IN(DART_CNTL);
+			reg &= ~inv_bit;
 			DART_OUT(DART_CNTL, reg);
 			goto retry;
 		} else
@@ -111,11 +111,39 @@ retry:
 	}
 }
 
+static inline void dart_tlb_invalidate_one(unsigned long bus_rpn)
+{
+	unsigned int reg;
+	unsigned int l, limit;
+
+	reg = DART_CNTL_U4_ENABLE | DART_CNTL_U4_IONE |
+		(bus_rpn & DART_CNTL_U4_IONE_MASK);
+	DART_OUT(DART_CNTL, reg);
+
+	limit = 0;
+wait_more:
+	l = 0;
+	while ((DART_IN(DART_CNTL) & DART_CNTL_U4_IONE) && l < (1L << limit)) {
+		rmb();
+		l++;
+	}
+
+	if (l == (1L << limit)) {
+		if (limit < 4) {
+			limit++;
+			goto wait_more;
+		} else
+			panic("DART: TLB did not flush after waiting a long "
+			      "time. Buggy U4 ?");
+	}
+}
+
 static void dart_flush(struct iommu_table *tbl)
 {
-	if (dart_dirty)
+	if (dart_dirty) {
 		dart_tlb_invalidate_all();
-	dart_dirty = 0;
+		dart_dirty = 0;
+	}
 }
 
 static void dart_build(struct iommu_table *tbl, long index,
@@ -124,6 +152,7 @@ static void dart_build(struct iommu_tabl
 {
 	unsigned int *dp;
 	unsigned int rpn;
+	long l;
 
 	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
 
@@ -135,7 +164,8 @@ static void dart_build(struct iommu_tabl
 	/* On U3, all memory is contigous, so we can move this
 	 * out of the loop.
 	 */
-	while (npages--) {
+	l = npages;
+	while (l--) {
 		rpn = virt_to_abs(uaddr) >> DART_PAGE_SHIFT;
 
 		*(dp++) = DARTMAP_VALID | (rpn & DARTMAP_RPNMASK);
@@ -143,7 +173,14 @@ static void dart_build(struct iommu_tabl
 		uaddr += DART_PAGE_SIZE;
 	}
 
-	dart_dirty = 1;
+	if (dart_is_u4) {
+		rpn = index;
+		mb(); /* make sure all updates have reached memory */
+		while (npages--)
+			dart_tlb_invalidate_one(rpn++);
+	} else {
+		dart_dirty = 1;
+	}
 }
 
 
