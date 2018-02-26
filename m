Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqkFw6Xd9zF19T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 01:08:52 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QE4TO7059086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 09:08:49 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gcg9k1e2x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 09:08:49 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 09:08:47 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 2/4] powerpc/mm/slice: Reduce the stack usage in
 slice_get_unmapped_area
Date: Mon, 26 Feb 2018 19:38:24 +0530
In-Reply-To: <20180226140826.11641-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180226140826.11641-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180226140826.11641-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch kill potential_mask and compat_mask variable and instead use tmp_mask
so that we can reduce the stack usage. This is required so that we can increase
the high_slices bitmap to a larger value.

The patch does result in extra computation in final stage, where it ends up
recomputing the compat mask again.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slice.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 259bbda9a222..832c681c341a 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -413,8 +413,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 {
 	struct slice_mask mask;
 	struct slice_mask good_mask;
-	struct slice_mask potential_mask;
-	struct slice_mask compat_mask;
+	struct slice_mask tmp_mask;
 	int fixed = (flags & MAP_FIXED);
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long page_size = 1UL << pshift;
@@ -449,11 +448,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	bitmap_zero(mask.high_slices, SLICE_NUM_HIGH);
 
 	/* silence stupid warning */;
-	potential_mask.low_slices = 0;
-	bitmap_zero(potential_mask.high_slices, SLICE_NUM_HIGH);
-
-	compat_mask.low_slices = 0;
-	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
+	tmp_mask.low_slices = 0;
+	bitmap_zero(tmp_mask.high_slices, SLICE_NUM_HIGH);
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
@@ -502,9 +498,11 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If we support combo pages, we can allow 64k pages in 4k slices */
 	if (psize == MMU_PAGE_64K) {
-		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask, high_limit);
+		slice_mask_for_size(mm, MMU_PAGE_4K, &tmp_mask, high_limit);
 		if (fixed)
-			slice_or_mask(&good_mask, &compat_mask);
+			slice_or_mask(&good_mask, &tmp_mask);
+
+		slice_print_mask("Mask for compat page size", tmp_mask);
 	}
 #endif
 	/* First check hint if it's valid or if we have MAP_FIXED */
@@ -541,11 +539,11 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * We don't fit in the good mask, check what other slices are
 	 * empty and thus can be converted
 	 */
-	slice_mask_for_free(mm, &potential_mask, high_limit);
-	slice_or_mask(&potential_mask, &good_mask);
-	slice_print_mask(" potential", potential_mask);
+	slice_mask_for_free(mm, &tmp_mask, high_limit);
+	slice_or_mask(&tmp_mask, &good_mask);
+	slice_print_mask("Free area/potential ", tmp_mask);
 
-	if ((addr != 0 || fixed) && slice_check_fit(mm, mask, potential_mask)) {
+	if ((addr != 0 || fixed) && slice_check_fit(mm, mask, tmp_mask)) {
 		slice_dbg(" fits potential !\n");
 		goto convert;
 	}
@@ -571,7 +569,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* Now let's see if we can find something in the existing slices
 	 * for that size plus free slices
 	 */
-	addr = slice_find_area(mm, len, potential_mask,
+	addr = slice_find_area(mm, len, tmp_mask,
 			       psize, topdown, high_limit);
 
 #ifdef CONFIG_PPC_64K_PAGES
@@ -585,9 +583,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 * mask variable is free here. Use that for compat
 		 * size mask.
 		 */
+		slice_mask_for_size(mm, MMU_PAGE_4K, &mask, high_limit);
 		/* retry the search with 4k-page slices included */
-		slice_or_mask(&potential_mask, &compat_mask);
-		addr = slice_find_area(mm, len, potential_mask,
+		slice_or_mask(&tmp_mask, &mask);
+		addr = slice_find_area(mm, len, tmp_mask,
 				       psize, topdown, high_limit);
 	}
 #endif
@@ -600,8 +599,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	slice_print_mask(" mask", mask);
 
  convert:
+	slice_mask_for_size(mm, MMU_PAGE_4K, &tmp_mask, high_limit);
 	slice_andnot_mask(&mask, &good_mask);
-	slice_andnot_mask(&mask, &compat_mask);
+	slice_andnot_mask(&mask, &tmp_mask);
 	if (mask.low_slices || !bitmap_empty(mask.high_slices, SLICE_NUM_HIGH)) {
 		slice_convert(mm, mask, psize);
 		if (psize > MMU_PAGE_BASE)
-- 
2.14.3
