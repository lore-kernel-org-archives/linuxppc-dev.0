Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwcwj3jt6zF1GF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:25:57 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g8so3597676pgv.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 05:25:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 09/10] powerpc/mm/slice: use the dynamic high slice size to
 limit bitmap operations
Date: Tue,  6 Mar 2018 23:25:06 +1000
Message-Id: <20180306132507.10649-10-npiggin@gmail.com>
In-Reply-To: <20180306132507.10649-1-npiggin@gmail.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
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

Perormance numbers aren't changed significantly, this may change
with larger address spaces or different mmap access patterns that
require more slice mask building.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 75 +++++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 086c31b8b982..507d17e2cfcd 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -61,14 +61,12 @@ static void slice_print_mask(const char *label, const struct slice_mask *mask) {
 #endif
 
 static void slice_range_to_mask(unsigned long start, unsigned long len,
-				struct slice_mask *ret)
+				struct slice_mask *ret,
+				unsigned long high_slices)
 {
 	unsigned long end = start + len - 1;
 
 	ret->low_slices = 0;
-	if (SLICE_NUM_HIGH)
-		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	if (start < SLICE_LOW_TOP) {
 		unsigned long mend = min(end,
 					 (unsigned long)(SLICE_LOW_TOP - 1));
@@ -77,6 +75,10 @@ static void slice_range_to_mask(unsigned long start, unsigned long len,
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
+	if (!SLICE_NUM_HIGH)
+		return;
+
+	bitmap_zero(ret->high_slices, high_slices);
 	if ((start + len) > SLICE_LOW_TOP) {
 		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
@@ -120,22 +122,20 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 }
 
 static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
-				unsigned long high_limit)
+				unsigned long high_slices)
 {
 	unsigned long i;
 
 	ret->low_slices = 0;
-	if (SLICE_NUM_HIGH)
-		bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
-
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (high_limit <= SLICE_LOW_TOP)
+	if (!SLICE_NUM_HIGH || !high_slices)
 		return;
 
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(high_limit); i++)
+	bitmap_zero(ret->high_slices, high_slices);
+	for (i = 0; i < high_slices; i++)
 		if (!slice_high_has_vma(mm, i))
 			__set_bit(i, ret->high_slices);
 }
@@ -232,6 +232,7 @@ static void slice_convert(struct mm_struct *mm,
 {
 	int index, mask_index;
 	/* Write the new slice psize bits */
+	unsigned long high_slices;
 	unsigned char *hpsizes, *lpsizes;
 	struct slice_mask *psize_mask, *old_mask;
 	unsigned long i, flags;
@@ -267,7 +268,8 @@ static void slice_convert(struct mm_struct *mm,
 	}
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
+	high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+	for (i = 0; SLICE_NUM_HIGH && i < high_slices; i++) {
 		if (!test_bit(i, mask->high_slices))
 			continue;
 
@@ -434,32 +436,37 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 }
 
 static inline void slice_copy_mask(struct slice_mask *dst,
-					const struct slice_mask *src)
+					const struct slice_mask *src,
+					unsigned long high_slices)
 {
 	dst->low_slices = src->low_slices;
 	if (!SLICE_NUM_HIGH)
 		return;
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
 	if (!SLICE_NUM_HIGH)
 		return;
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
 	if (!SLICE_NUM_HIGH)
 		return;
-	bitmap_andnot(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
+	bitmap_andnot(dst->high_slices, src1->high_slices, src2->high_slices,
+			high_slices);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
@@ -482,6 +489,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	struct mm_struct *mm = current->mm;
 	unsigned long newaddr;
 	unsigned long high_limit;
+	unsigned long high_slices;
 
 	high_limit = DEFAULT_MAP_WINDOW;
 	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
@@ -498,6 +506,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			return -ENOMEM;
 	}
 
+	high_slices = GET_HIGH_SLICE_INDEX(high_limit);
 	if (high_limit > mm->context.slb_addr_limit) {
 		/*
 		 * Increasing the slb_addr_limit does not require
@@ -557,13 +566,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
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
 	slice_print_mask(" good_mask", &good_mask);
 	if (compat_maskp)
@@ -596,8 +605,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * We don't fit in the good mask, check what other slices are
 	 * empty and thus can be converted
 	 */
-	slice_mask_for_free(mm, &potential_mask, high_limit);
-	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
+	slice_mask_for_free(mm, &potential_mask, high_slices);
+	slice_or_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
 	slice_print_mask(" potential", &potential_mask);
 
 	if (addr || fixed) {
@@ -634,7 +643,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
-		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
+		slice_or_mask(&potential_mask, &potential_mask, compat_maskp, high_slices);
 		addr = slice_find_area(mm, len, &potential_mask,
 				       psize, topdown, high_limit);
 	}
@@ -643,17 +652,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (addr == -ENOMEM)
 		return -ENOMEM;
 
-	slice_range_to_mask(addr, len, &potential_mask);
+	slice_range_to_mask(addr, len, &potential_mask, high_slices);
 	slice_dbg(" found potential area at 0x%lx\n", addr);
 	slice_print_mask(" mask", &potential_mask);
 
  convert:
-	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask);
+	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
 	if (compat_maskp && !fixed)
-		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp);
+		slice_andnot_mask(&potential_mask, &potential_mask, compat_maskp, high_slices);
 	if (potential_mask.low_slices ||
 		(SLICE_NUM_HIGH &&
-		 !bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH))) {
+		 !bitmap_empty(potential_mask.high_slices, high_slices))) {
 		slice_convert(mm, &potential_mask, psize);
 		if (psize > MMU_PAGE_BASE)
 			on_each_cpu(slice_flush_segments, mm, 1);
@@ -727,7 +736,9 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	mm->context.user_psize = psize;
 
 	/*
-	 * Set all slice psizes to the default.
+	 * Set all slice psizes to the default. High slices could
+	 * be initialised up to slb_addr_limit if we ensure to
+	 * initialise the rest of them as slb_addr_limit is expanded.
 	 */
 	lpsizes = mm->context.low_slices_psize;
 	memset(lpsizes, (psize << 4) | psize, SLICE_NUM_LOW >> 1);
@@ -748,10 +759,12 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
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
 
@@ -790,9 +803,11 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
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
2.16.1
