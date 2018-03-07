Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwx9D1Hz1zF1gd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 12:37:52 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id x1so304568pfh.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 17:37:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 06/10] powerpc/mm/slice: Switch to 3-operand slice bitops
 helpers
Date: Wed,  7 Mar 2018 11:37:14 +1000
Message-Id: <20180307013718.13749-7-npiggin@gmail.com>
In-Reply-To: <20180307013718.13749-1-npiggin@gmail.com>
References: <20180307013718.13749-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This converts the slice_mask bit operation helpers to be the usual
3-operand kind, which allows 2 inputs to set a different output
without an extra copy, which is used in the next patch.

Adds slice_copy_mask, which will be used in the next patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 0a5efa40e739..4b2fd37b727a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -429,25 +429,33 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
 		return slice_find_area_bottomup(mm, len, mask, psize, high_limit);
 }
 
-static inline void slice_or_mask(struct slice_mask *dst,
+static inline void slice_copy_mask(struct slice_mask *dst,
 					const struct slice_mask *src)
 {
-	dst->low_slices |= src->low_slices;
+	dst->low_slices = src->low_slices;
 	if (!SLICE_NUM_HIGH)
 		return;
-	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
-		  SLICE_NUM_HIGH);
+	bitmap_copy(dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
 }
 
-static inline void slice_andnot_mask(struct slice_mask *dst,
-					const struct slice_mask *src)
+static inline void slice_or_mask(struct slice_mask *dst,
+					const struct slice_mask *src1,
+					const struct slice_mask *src2)
 {
-	dst->low_slices &= ~src->low_slices;
+	dst->low_slices = src1->low_slices | src2->low_slices;
+	if (!SLICE_NUM_HIGH)
+		return;
+	bitmap_or(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
+}
 
+static inline void slice_andnot_mask(struct slice_mask *dst,
+					const struct slice_mask *src1,
+					const struct slice_mask *src2)
+{
+	dst->low_slices = src1->low_slices & ~src2->low_slices;
 	if (!SLICE_NUM_HIGH)
 		return;
-	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
-		      SLICE_NUM_HIGH);
+	bitmap_andnot(dst->high_slices, src1->high_slices, src2->high_slices, SLICE_NUM_HIGH);
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
@@ -562,7 +570,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (psize == MMU_PAGE_64K) {
 		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
 		if (fixed)
-			slice_or_mask(&good_mask, &compat_mask);
+			slice_or_mask(&good_mask, &good_mask, &compat_mask);
 	}
 #endif
 
@@ -594,7 +602,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * empty and thus can be converted
 	 */
 	slice_mask_for_free(mm, &potential_mask, high_limit);
-	slice_or_mask(&potential_mask, &good_mask);
+	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
 	slice_print_mask(" potential", &potential_mask);
 
 	if (addr != 0 || fixed) {
@@ -631,7 +639,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
-		slice_or_mask(&potential_mask, &compat_mask);
+		slice_or_mask(&potential_mask, &potential_mask, &compat_mask);
 		addr = slice_find_area(mm, len, &potential_mask,
 				       psize, topdown, high_limit);
 	}
@@ -645,8 +653,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	slice_print_mask(" mask", &mask);
 
  convert:
-	slice_andnot_mask(&mask, &good_mask);
-	slice_andnot_mask(&mask, &compat_mask);
+	slice_andnot_mask(&mask, &mask, &good_mask);
+	slice_andnot_mask(&mask, &mask, &compat_mask);
 	if (mask.low_slices ||
 	    (SLICE_NUM_HIGH &&
 	     !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH))) {
@@ -791,7 +799,7 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	if (psize == MMU_PAGE_64K) {
 		struct slice_mask compat_mask;
 		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
-		slice_or_mask(&available, &compat_mask);
+		slice_or_mask(&available, &available, &compat_mask);
 	}
 #endif
 
-- 
2.16.1
