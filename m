Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdl5h5L0bzF0gG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 19:12:08 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id q79so2238195pfl.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 00:12:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 5/5] powerpc/mm/slice: use the dynamic high slice size to
 limit bitmap operations
Date: Sat, 10 Feb 2018 18:11:39 +1000
Message-Id: <20180210081139.27236-6-npiggin@gmail.com>
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

The number of high slices a process might use now depends on its
address space size, and what allocation address it has requested.

This patch uses that limit throughout call chains where possible,
rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
This saves some cost for processes that don't use very large address
spaces.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 98 +++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index b2e6c7667bc5..bec68ea07e29 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -61,13 +61,12 @@ static void slice_print_mask(const char *label, const struct slice_mask *mask) {
 #endif
 
 static void slice_range_to_mask(unsigned long start, unsigned long len,
-				struct slice_mask *ret)
+				struct slice_mask *ret,
+				unsigned long high_slices)
 {
 	unsigned long end = start + len - 1;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	if (start < SLICE_LOW_TOP) {
 		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
 
@@ -75,6 +74,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
+	bitmap_zero(ret->high_slices, high_slices);
 	if ((start + len) > SLICE_LOW_TOP) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
@@ -116,28 +116,27 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 }
 
 static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
-				unsigned long high_limit)
+				unsigned long high_slices)
 {
 	unsigned long i;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (!high_slices)
 		return;
 
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
+	bitmap_zero(ret->high_slices, high_slices);
+	for (i = 0; i < high_slices; i++)
 		if (!slice_high_has_vma(mm, i))
 			__set_bit(i, ret->high_slices);
 }
 
 static void calc_slice_mask_for_size(struct mm_struct *mm, int psize,
 				struct slice_mask *ret,
-				unsigned long high_limit)
+				unsigned long high_slices)
 {
 	unsigned char *hpsizes;
 	int index, mask_index;
@@ -145,18 +144,17 @@ static void calc_slice_mask_for_size(struct mm_struct *mm, int psize,
 	u64 lpsizes;
 
 	ret->low_slices = 0;
-	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (((lpsizes >> (i * 4)) & 0xf) == psize)
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (!high_slices)
 		return;
 
+	bitmap_zero(ret->high_slices, high_slices);
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++) {
+	for (i = 0; i < high_slices; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
@@ -165,16 +163,15 @@ static void calc_slice_mask_for_size(struct mm_struct *mm, int psize,
 }
 
 #ifdef CONFIG_PPC_BOOK3S_64
-static void recalc_slice_mask_cache(struct mm_struct *mm)
+static void recalc_slice_mask_cache(struct mm_struct *mm, unsigned long high_slices)
 {
-	unsigned long l = mm->context.slb_addr_limit;
-	calc_slice_mask_for_size(mm, MMU_PAGE_4K, &mm->context.mask_4k, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_4K, &mm->context.mask_4k, high_slices);
 #ifdef CONFIG_PPC_64K_PAGES
-	calc_slice_mask_for_size(mm, MMU_PAGE_64K, &mm->context.mask_64k, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_64K, &mm->context.mask_64k, high_slices);
 #endif
 #ifdef CONFIG_HUGETLB_PAGE
-	calc_slice_mask_for_size(mm, MMU_PAGE_16M, &mm->context.mask_16m, l);
-	calc_slice_mask_for_size(mm, MMU_PAGE_16G, &mm->context.mask_16g, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_16M, &mm->context.mask_16m, high_slices);
+	calc_slice_mask_for_size(mm, MMU_PAGE_16G, &mm->context.mask_16g, high_slices);
 #endif
 }
 
@@ -252,6 +249,7 @@ static void slice_convert(struct mm_struct *mm,
 	unsigned char *hpsizes;
 	u64 lpsizes;
 	unsigned long i, flags;
+	unsigned long high_slices;
 
 	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
 	slice_print_mask(" mask", mask);
@@ -271,7 +269,8 @@ static void slice_convert(struct mm_struct *mm,
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
+	high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+	for (i = 0; i < high_slices; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (test_bit(i, mask->high_slices))
@@ -284,7 +283,7 @@ static void slice_convert(struct mm_struct *mm,
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
-	recalc_slice_mask_cache(mm);
+	recalc_slice_mask_cache(mm, high_slices);
 
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
@@ -431,27 +430,32 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 }
 
 static inline void slice_copy_mask(struct slice_mask *dst,
-					const struct slice_mask *src)
+					const struct slice_mask *src,
+					unsigned long high_slices)
 {
 	dst->low_slices = src->low_slices;
-	bitmap_copy(dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
+	bitmap_copy(dst->high_slices, src->high_slices, high_slices);
 }
 
 static inline void slice_or_mask(struct slice_mask *dst,
 					const struct slice_mask *src1,
-					const struct slice_mask *src2)
+					const struct slice_mask *src2,
+					unsigned long high_slices)
 {
 	dst->low_slices = src1->low_slices | src2->low_slices;
-	bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
+	bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices,
+			high_slices);
 }
 
 static inline void slice_andnot_mask(struct slice_mask *dst,
 					const struct slice_mask *src1,
-					const struct slice_mask *src2)
+					const struct slice_mask *src2,
+					unsigned long high_slices)
 {
 	dst->low_slices = src1->low_slices & ~src2->low_slices;
 
-	bitmap_andnot(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
+	bitmap_andnot(dst->high_slices, src1->high_slices, src2->high_slices,
+			high_slices);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
@@ -474,6 +478,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	struct mm_struct *mm = current->mm;
 	unsigned long newaddr;
 	unsigned long high_limit;
+	unsigned long high_slices;
 
 	high_limit = DEFAULT_MAP_WINDOW;
 	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
@@ -490,13 +495,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			return -ENOMEM;
 	}
 
+	high_slices = GET_HIGH_SLICE_INDEX(high_limit);
 	if (high_limit > mm->context.slb_addr_limit) {
 		unsigned long flags;
 
 		mm->context.slb_addr_limit = high_limit;
 
 		spin_lock_irqsave(&slice_convert_lock, flags);
-		recalc_slice_mask_cache(mm);
+		recalc_slice_mask_cache(mm, high_slices);
 		spin_unlock_irqrestore(&slice_convert_lock, flags);
 
 		on_each_cpu(slice_flush_segments, mm, 1);
@@ -504,7 +510,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	/* silence stupid warning */;
 	potential_mask.low_slices = 0;
-	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
+	bitmap_zero(potential_mask.high_slices, high_slices);
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
@@ -555,13 +561,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (psize == MMU_PAGE_64K) {
 		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
 		if (fixed)
-			slice_or_mask(&good_mask, maskp, compat_maskp);
+			slice_or_mask(&good_mask, maskp, compat_maskp, high_slices);
 		else
-			slice_copy_mask(&good_mask, maskp);
+			slice_copy_mask(&good_mask, maskp, high_slices);
 	} else
 #endif
 	{
-		slice_copy_mask(&good_mask, maskp);
+		slice_copy_mask(&good_mask, maskp, high_slices);
 	}
 
 	/* First check hint if it's valid or if we have MAP_FIXED */
@@ -591,8 +597,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * We don't fit in the good mask, check what other slices are
 	 * empty and thus can be converted
 	 */
-	slice_mask_for_free(mm, &potential_mask, high_limit);
-	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
+	slice_mask_for_free(mm, &potential_mask, high_slices);
+	slice_or_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
 	slice_print_mask(" potential", &potential_mask);
 
 	if (addr || fixed) {
@@ -629,7 +635,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
-		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
+		slice_or_mask(&potential_mask, &potential_mask, compat_maskp, high_slices);
 		addr = slice_find_area(mm, len, &potential_mask,
 				       psize, topdown, high_limit);
 	}
@@ -638,16 +644,16 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (addr == -ENOMEM)
 		return -ENOMEM;
 
-	slice_range_to_mask(addr, len, &potential_mask);
+	slice_range_to_mask(addr, len, &potential_mask, high_slices);
 	slice_dbg(" found potential area at 0x%lx\n", addr);
 	slice_print_mask(" mask", maskp);
 
  convert:
-	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask);
+	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
 	if (compat_maskp && !fixed)
-		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp);
+		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp, high_slices);
 	if (potential_mask.low_slices ||
-		!bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH)) {
+		!bitmap_empty(potential_mask.high_slices, high_slices)) {
 		slice_convert(mm, &potential_mask, psize);
 		if (psize > MMU_PAGE_BASE)
 			on_each_cpu(slice_flush_segments, mm, 1);
@@ -724,6 +730,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	int index, mask_index;
 	unsigned char *hpsizes;
 	unsigned long flags, lpsizes;
+	unsigned long high_slices;
 	unsigned int old_psize;
 	int i;
 
@@ -749,7 +756,8 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+	for (i = 0; i < high_slices; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == old_psize)
@@ -765,7 +773,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
-	recalc_slice_mask_cache(mm);
+	recalc_slice_mask_cache(mm, high_slices);
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 	return;
  bail:
@@ -776,10 +784,12 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
 	struct slice_mask mask;
+	unsigned long high_slices;
 
 	VM_BUG_ON(radix_enabled());
 
-	slice_range_to_mask(start, len, &mask);
+	high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+	slice_range_to_mask(start, len, &mask, high_slices);
 	slice_convert(mm, &mask, psize);
 }
 
@@ -818,9 +828,11 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	if (psize == MMU_PAGE_64K) {
 		const struct slice_mask *compat_maskp;
 		struct slice_mask available;
+		unsigned long high_slices;
 
 		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
-		slice_or_mask(&available, maskp, compat_maskp);
+		high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+		slice_or_mask(&available, maskp, compat_maskp, high_slices);
 		return !slice_check_range_fits(mm, &available, addr, len);
 	}
 #endif
-- 
2.15.1
