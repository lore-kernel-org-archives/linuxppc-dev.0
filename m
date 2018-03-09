Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyWyW5CMszF1pv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 02:49:07 +1100 (AEDT)
Message-Id: <a371a405643b73b023c26cd1d2256f8f37c68a11.1520468013.git.christophe.leroy@c-s.fr>
In-Reply-To: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4.14 3/4] powerpc/mm/slice: Enhance for supporting PPC32
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  9 Mar 2018 16:49:03 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Upstream db3a528db41caaa6dfd4c64e9f5efb1c81a80467

In preparation for the following patch which will fix an issue on
the 8xx by re-using the 'slices', this patch enhances the
'slices' implementation to support 32 bits CPUs.

On PPC32, the address space is limited to 4Gbytes, hence only the low
slices will be used.

The high slices use bitmaps. As bitmap functions are not prepared to
handle bitmaps of size 0, this patch ensures that bitmap functions
are called only when SLICE_NUM_HIGH is not nul.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/nohash/32/slice.h | 18 +++++++++++++++
 arch/powerpc/include/asm/slice.h           |  4 +++-
 arch/powerpc/mm/slice.c                    | 37 +++++++++++++++++++++++-------
 3 files changed, 50 insertions(+), 9 deletions(-)
 create mode 100644 arch/powerpc/include/asm/nohash/32/slice.h

diff --git a/arch/powerpc/include/asm/nohash/32/slice.h b/arch/powerpc/include/asm/nohash/32/slice.h
new file mode 100644
index 000000000000..95d532e18092
--- /dev/null
+++ b/arch/powerpc/include/asm/nohash/32/slice.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_NOHASH_32_SLICE_H
+#define _ASM_POWERPC_NOHASH_32_SLICE_H
+
+#ifdef CONFIG_PPC_MM_SLICES
+
+#define SLICE_LOW_SHIFT		28
+#define SLICE_LOW_TOP		(0x100000000ull)
+#define SLICE_NUM_LOW		(SLICE_LOW_TOP >> SLICE_LOW_SHIFT)
+#define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
+
+#define SLICE_HIGH_SHIFT	0
+#define SLICE_NUM_HIGH		0ul
+#define GET_HIGH_SLICE_INDEX(addr)	(addr & 0)
+
+#endif /* CONFIG_PPC_MM_SLICES */
+
+#endif /* _ASM_POWERPC_NOHASH_32_SLICE_H */
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index 17c5a5d8c418..172711fadb1c 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -4,8 +4,10 @@
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/slice.h>
-#else
+#elif defined(CONFIG_PPC64)
 #include <asm/nohash/64/slice.h>
+#elif defined(CONFIG_PPC_MMU_NOHASH)
+#include <asm/nohash/32/slice.h>
 #endif
 
 #ifdef CONFIG_PPC_MM_SLICES
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index a7ac600f71c6..5b2d392a1a5e 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -73,10 +73,12 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 	unsigned long end = start + len - 1;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
+	if (SLICE_NUM_HIGH)
+		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	if (start < SLICE_LOW_TOP) {
-		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
+		unsigned long mend = min(end,
+					 (unsigned long)(SLICE_LOW_TOP - 1));
 
 		ret->low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
 			- (1u << GET_LOW_SLICE_INDEX(start));
@@ -113,11 +115,13 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 	unsigned long start = slice << SLICE_HIGH_SHIFT;
 	unsigned long end = start + (1ul << SLICE_HIGH_SHIFT);
 
+#ifdef CONFIG_PPC64
 	/* Hack, so that each addresses is controlled by exactly one
 	 * of the high or low area bitmaps, the first high area starts
 	 * at 4GB, not 0 */
 	if (start == 0)
 		start = SLICE_LOW_TOP;
+#endif
 
 	return !slice_area_is_free(mm, start, end - start);
 }
@@ -127,7 +131,8 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 	unsigned long i;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
+	if (SLICE_NUM_HIGH)
+		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (!slice_low_has_vma(mm, i))
@@ -149,7 +154,8 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 	u64 lpsizes;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
+	if (SLICE_NUM_HIGH)
+		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
@@ -171,6 +177,10 @@ static int slice_check_fit(struct mm_struct *mm,
 	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
 	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.addr_limit);
 
+	if (!SLICE_NUM_HIGH)
+		return (mask.low_slices & available.low_slices) ==
+		       mask.low_slices;
+
 	bitmap_and(result, mask.high_slices,
 		   available.high_slices, slice_count);
 
@@ -180,6 +190,7 @@ static int slice_check_fit(struct mm_struct *mm,
 
 static void slice_flush_segments(void *parm)
 {
+#ifdef CONFIG_PPC64
 	struct mm_struct *mm = parm;
 	unsigned long flags;
 
@@ -191,6 +202,7 @@ static void slice_flush_segments(void *parm)
 	local_irq_save(flags);
 	slb_flush_and_rebolt();
 	local_irq_restore(flags);
+#endif
 }
 
 static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psize)
@@ -380,6 +392,8 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
 {
 	dst->low_slices |= src->low_slices;
+	if (!SLICE_NUM_HIGH)
+		return;
 	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
 		  SLICE_NUM_HIGH);
 }
@@ -388,6 +402,8 @@ static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *
 {
 	dst->low_slices &= ~src->low_slices;
 
+	if (!SLICE_NUM_HIGH)
+		return;
 	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
 		      SLICE_NUM_HIGH);
 }
@@ -431,14 +447,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * init different masks
 	 */
 	mask.low_slices = 0;
-	bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
 
 	/* silence stupid warning */;
 	potential_mask.low_slices = 0;
-	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
 
 	compat_mask.low_slices = 0;
-	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
+
+	if (SLICE_NUM_HIGH) {
+		bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
+		bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
+		bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
+	}
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
@@ -584,7 +603,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
  convert:
 	slice_andnot_mask(&mask, &good_mask);
 	slice_andnot_mask(&mask, &compat_mask);
-	if (mask.low_slices || !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
+	if (mask.low_slices ||
+	    (SLICE_NUM_HIGH &&
+	     !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH))) {
 		slice_convert(mm, mask, psize);
 		if (psize > MMU_PAGE_BASE)
 			on_each_cpu(slice_flush_segments, mm, 1);
-- 
2.13.3
