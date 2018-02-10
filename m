Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdl5d0hldzF0fr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 19:12:04 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id o13so2546735pli.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 00:12:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 4/5] powerpc/mm/slice: Use const pointers to cached slice
 masks where possible
Date: Sat, 10 Feb 2018 18:11:38 +1000
Message-Id: <20180210081139.27236-5-npiggin@gmail.com>
In-Reply-To: <20180210081139.27236-1-npiggin@gmail.com>
References: <20180210081139.27236-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The slice_mask cache was a basic conversion which copied the slice
mask into caller's structures, because that's how the original code
worked. In most cases the pointer can be used directly instead, saving
a copy and an on-stack structure.

This also converts the slice_mask bit operation helpers to be the usual
3-operand kind, which is clearer to work with. And we remove some
unnecessary intermediate bitmaps, reducing stack and copy overhead
further.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 78 ++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 98497c105d7d..b2e6c7667bc5 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -430,25 +430,28 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 		return slice_find_area_bottomup(mm, len, mask, psize, high_limit);
 }
 
-static inline void slice_or_mask(struct slice_mask *dst,
+static inline void slice_copy_mask(struct slice_mask *dst,
 					const struct slice_mask *src)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
+	dst->low_slices = src->low_slices;
+	bitmap_copy(dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
+}
 
-	dst->low_slices |= src->low_slices;
-	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
-	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+static inline void slice_or_mask(struct slice_mask *dst,
+					const struct slice_mask *src1,
+					const struct slice_mask *src2)
+{
+	dst->low_slices = src1->low_slices | src2->low_slices;
+	bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
 }
 
 static inline void slice_andnot_mask(struct slice_mask *dst,
-					const struct slice_mask *src)
+					const struct slice_mask *src1,
+					const struct slice_mask *src2)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-
-	dst->low_slices &= ~src->low_slices;
+	dst->low_slices = src1->low_slices & ~src2->low_slices;
 
-	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
-	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
+	bitmap_andnot(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
@@ -461,10 +464,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 				      unsigned long flags, unsigned int psize,
 				      int topdown)
 {
-	struct slice_mask mask;
 	struct slice_mask good_mask;
 	struct slice_mask potential_mask;
-	struct slice_mask compat_mask;
+	const struct slice_mask *maskp;
+	const struct slice_mask *compat_maskp = NULL;
 	int fixed = (flags & MAP_FIXED);
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long page_size = 1UL << pshift;
@@ -503,9 +506,6 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	potential_mask.low_slices = 0;
 	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
 
-	compat_mask.low_slices = 0;
-	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
-
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
 	BUG_ON(mm->context.slb_addr_limit == 0);
@@ -528,7 +528,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
-	good_mask = *slice_mask_for_size(mm, psize);
+	maskp = slice_mask_for_size(mm, psize);
 	slice_print_mask(" good_mask", &good_mask);
 
 	/*
@@ -553,11 +553,16 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If we support combo pages, we can allow 64k pages in 4k slices */
 	if (psize == MMU_PAGE_64K) {
-		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
+		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
 		if (fixed)
-			slice_or_mask(&good_mask, &compat_mask);
-	}
+			slice_or_mask(&good_mask, maskp, compat_maskp);
+		else
+			slice_copy_mask(&good_mask, maskp);
+	} else
 #endif
+	{
+		slice_copy_mask(&good_mask, maskp);
+	}
 
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr || fixed) {
@@ -587,7 +592,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * empty and thus can be converted
 	 */
 	slice_mask_for_free(mm, &potential_mask, high_limit);
-	slice_or_mask(&potential_mask, &good_mask);
+	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
 	slice_print_mask(" potential", &potential_mask);
 
 	if (addr || fixed) {
@@ -624,7 +629,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
-		slice_or_mask(&potential_mask, &compat_mask);
+		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
 		addr = slice_find_area(mm, len, &potential_mask,
 				       psize, topdown, high_limit);
 	}
@@ -633,15 +638,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (addr == -ENOMEM)
 		return -ENOMEM;
 
-	slice_range_to_mask(addr, len, &mask);
+	slice_range_to_mask(addr, len, &potential_mask);
 	slice_dbg(" found potential area at 0x%lx\n", addr);
-	slice_print_mask(" mask", &mask);
+	slice_print_mask(" mask", maskp);
 
  convert:
-	slice_andnot_mask(&mask, &good_mask);
-	slice_andnot_mask(&mask, &compat_mask);
-	if (mask.low_slices || !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
-		slice_convert(mm, &mask, psize);
+	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask);
+	if (compat_maskp && !fixed)
+		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp);
+	if (potential_mask.low_slices ||
+		!bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH)) {
+		slice_convert(mm, &potential_mask, psize);
 		if (psize > MMU_PAGE_BASE)
 			on_each_cpu(slice_flush_segments, mm, 1);
 	}
@@ -799,19 +806,22 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len)
 {
-	struct slice_mask available;
+	const struct slice_mask *maskp;
 	unsigned int psize = mm->context.user_psize;
 
 	if (radix_enabled())
 		return 0;
 
-	available = *slice_mask_for_size(mm, psize);
+	maskp = slice_mask_for_size(mm, psize);
 #ifdef CONFIG_PPC_64K_PAGES
 	/* We need to account for 4k slices too */
 	if (psize == MMU_PAGE_64K) {
-		struct slice_mask compat_mask;
-		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
-		slice_or_mask(&available, &compat_mask);
+		const struct slice_mask *compat_maskp;
+		struct slice_mask available;
+
+		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
+		slice_or_mask(&available, maskp, compat_maskp);
+		return !slice_check_range_fits(mm, &available, addr, len);
 	}
 #endif
 
@@ -821,6 +831,6 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	slice_print_mask(" mask", &mask);
 	slice_print_mask(" available", &available);
 #endif
-	return !slice_check_range_fits(mm, &available, addr, len);
+	return !slice_check_range_fits(mm, maskp, addr, len);
 }
 #endif
-- 
2.15.1
