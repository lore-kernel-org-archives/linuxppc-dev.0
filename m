Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 45BA167B34
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 05:15:24 +1000 (EST)
Date: Sun, 30 Apr 2006 14:14:30 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powermac: U4 DART improvements
Message-ID: <20060430191430.GU5518@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Jimi Xenidis posted Xen drivers that do individual TLB shootdowns on U4
DART on Friday:

http://lists.xensource.com/archives/html/xen-ppc-devel/2006-04/msg00085.html

We haven't been able to do it before since we didn't know any register
layouts past what Darwin used. So now we can implement individual
teardown.

This boots happily on my quad at home, but I'd appreciate more testing
by people who have U4-based machines. Also, if someone feels like doing
some benchmarking to find the breakeven point between full invalidation
and individual shootdowns, that'd be cool.

Patch below.

---

Implement single-entry TLB invalidations in the U4 DART.

At some point it makes more sense to invalidate the whole TLB instead of
individual entries. I picked a breakpoint at 32 entries, but it might make
sense to move it if benchmarking shows it to be too high or low.


Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/sysdev/dart.h b/arch/powerpc/sysdev/dart.h
index c2d0576..1c8817c 100644
--- a/arch/powerpc/sysdev/dart.h
+++ b/arch/powerpc/sysdev/dart.h
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
 
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 38087bd..66b6e21 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
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
@@ -111,6 +111,34 @@ retry:
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
+	mb();
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
 	if (dart_dirty)
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
@@ -143,7 +173,18 @@ static void dart_build(struct iommu_tabl
 		uaddr += DART_PAGE_SIZE;
 	}
 
-	dart_dirty = 1;
+
+	/* Pick 32 entries as a random point at which it makes more sense to
+	 * invalidate the whole TLB. FIXME: Benchmark and pick a better number.
+	 */
+	if (dart_is_u4 && npages > 32) {
+		rpn = index;
+		mb(); /* make sure all updates have reached memory */
+		while (npages--)
+			dart_tlb_invalidate_one(rpn++);
+	} else {
+		dart_dirty = 1;
+	}
 }
 
 
