Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgDKZ2BYwzF0rY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 05:12:34 +1100 (AEDT)
Message-Id: <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
In-Reply-To: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice size to
 limit bitmap operations
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 12 Feb 2018 19:12:30 +0100 (CET)
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
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 111 ++++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index b8b691369c29..683ff4604ab4 100644
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
-	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	if (start < SLICE_LOW_TOP) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
@@ -76,6 +75,7 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
+	slice_bitmap_zero(ret->high_slices, high_slices);
 	if ((start + len) > SLICE_LOW_TOP) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
@@ -119,28 +119,27 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 }
 
 static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
-				unsigned long high_limit)
+				unsigned long high_slices)
 {
 	unsigned long i;
 
 	ret->low_slices = 0;
-	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (!high_slices)
 		return;
 
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
+	slice_bitmap_zero(ret->high_slices, high_slices);
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
@@ -148,18 +147,17 @@ static void calc_slice_mask_for_size(struct mm_struct *mm, int psize,
 	u64 lpsizes;
 
 	ret->low_slices = 0;
-	slice_bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (((lpsizes >> (i * 4)) & 0xf) == psize)
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (!high_slices)
 		return;
 
+	slice_bitmap_zero(ret->high_slices, high_slices);
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++) {
+	for (i = 0; i < high_slices; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
@@ -168,16 +166,15 @@ static void calc_slice_mask_for_size(struct mm_struct *mm, int psize,
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
 
@@ -198,17 +195,16 @@ static const struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int ps
 	BUG();
 }
 #elif defined(CONFIG_PPC_8xx)
-static void recalc_slice_mask_cache(struct mm_struct *mm)
+static void recalc_slice_mask_cache(struct mm_struct *mm, unsigned long high_slices)
 {
-	unsigned long l = mm->context.slb_addr_limit;
 #ifdef CONFIG_PPC_16K_PAGES
-	calc_slice_mask_for_size(mm, MMU_PAGE_16K, &mm->context.mask_16k, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_16K, &mm->context.mask_16k, high_slices);
 #else
-	calc_slice_mask_for_size(mm, MMU_PAGE_4K, &mm->context.mask_4k, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_4K, &mm->context.mask_4k, high_slices);
 #endif
 #ifdef CONFIG_HUGETLB_PAGE
-	calc_slice_mask_for_size(mm, MMU_PAGE_512K, &mm->context.mask_512k, l);
-	calc_slice_mask_for_size(mm, MMU_PAGE_8M, &mm->context.mask_8m, l);
+	calc_slice_mask_for_size(mm, MMU_PAGE_512K, &mm->context.mask_512k, high_slices);
+	calc_slice_mask_for_size(mm, MMU_PAGE_8M, &mm->context.mask_8m, high_slices);
 #endif
 }
 
@@ -290,6 +286,7 @@ static void slice_convert(struct mm_struct *mm,
 	unsigned char *hpsizes;
 	u64 lpsizes;
 	unsigned long i, flags;
+	unsigned long high_slices;
 
 	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
 	slice_print_mask(" mask", mask);
@@ -309,7 +306,8 @@ static void slice_convert(struct mm_struct *mm,
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
+	high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+	for (i = 0; i < high_slices; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (test_bit(i, mask->high_slices))
@@ -322,7 +320,7 @@ static void slice_convert(struct mm_struct *mm,
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
-	recalc_slice_mask_cache(mm);
+	recalc_slice_mask_cache(mm, high_slices);
 
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
@@ -469,29 +467,32 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 }
 
 static inline void slice_copy_mask(struct slice_mask *dst,
-					const struct slice_mask *src)
+					const struct slice_mask *src,
+					unsigned long high_slices)
 {
 	dst->low_slices = src->low_slices;
-	slice_bitmap_copy(dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
+	slice_bitmap_copy(dst->high_slices, src->high_slices, high_slices);
 }
 
 static inline void slice_or_mask(struct slice_mask *dst,
-				 const struct slice_mask *src1,
-				 const struct slice_mask *src2)
+					const struct slice_mask *src1,
+					const struct slice_mask *src2,
+					unsigned long high_slices)
 {
 	dst->low_slices = src1->low_slices | src2->low_slices;
 	slice_bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices,
-			SLICE_NUM_HIGH);
+			high_slices);
 }
 
 static inline void slice_andnot_mask(struct slice_mask *dst,
-				     const struct slice_mask *src1,
-				     const struct slice_mask *src2)
+					const struct slice_mask *src1,
+					const struct slice_mask *src2,
+					unsigned long high_slices)
 {
 	dst->low_slices = src1->low_slices & ~src2->low_slices;
 
 	slice_bitmap_andnot(dst->high_slices, src1->high_slices,
-			    src2->high_slices, SLICE_NUM_HIGH);
+			    src2->high_slices, high_slices);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
@@ -514,6 +515,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	struct mm_struct *mm = current->mm;
 	unsigned long newaddr;
 	unsigned long high_limit;
+	unsigned long high_slices;
 
 	high_limit = DEFAULT_MAP_WINDOW;
 	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
@@ -530,13 +532,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
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
@@ -544,7 +547,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	/* silence stupid warning */;
 	potential_mask.low_slices = 0;
-	slice_bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
+	slice_bitmap_zero(potential_mask.high_slices, high_slices);
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
@@ -595,13 +598,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
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
@@ -631,8 +634,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * We don't fit in the good mask, check what other slices are
 	 * empty and thus can be converted
 	 */
-	slice_mask_for_free(mm, &potential_mask, high_limit);
-	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
+	slice_mask_for_free(mm, &potential_mask, high_slices);
+	slice_or_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
 	slice_print_mask(" potential", &potential_mask);
 
 	if (addr || fixed) {
@@ -669,7 +672,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
-		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
+		slice_or_mask(&potential_mask, &potential_mask, compat_maskp, high_slices);
 		addr = slice_find_area(mm, len, &potential_mask,
 				       psize, topdown, high_limit);
 	}
@@ -678,16 +681,16 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
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
-	    !slice_bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH)) {
+	    !slice_bitmap_empty(potential_mask.high_slices, high_slices)) {
 		slice_convert(mm, &potential_mask, psize);
 		if (psize > MMU_PAGE_BASE)
 			on_each_cpu(slice_flush_segments, mm, 1);
@@ -764,6 +767,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	int index, mask_index;
 	unsigned char *hpsizes;
 	unsigned long flags, lpsizes;
+	unsigned long high_slices;
 	unsigned int old_psize;
 	int i;
 
@@ -789,7 +793,8 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+	for (i = 0; i < high_slices; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == old_psize)
@@ -805,7 +810,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 		  (unsigned long)mm->context.low_slices_psize,
 		  (unsigned long)mm->context.high_slices_psize);
 
-	recalc_slice_mask_cache(mm);
+	recalc_slice_mask_cache(mm, high_slices);
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 	return;
  bail:
@@ -816,10 +821,12 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
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
 
@@ -858,9 +865,11 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
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
2.13.3
