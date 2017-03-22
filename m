Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwNx5CSkzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:37:37 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3T8sL098554
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:29 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vqjkxf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:37:29 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:37:28 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 02/17] powerpc/mm/slice: Update the function prototype
Date: Wed, 22 Mar 2017 09:06:48 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This avoid copying the slice_mask struct as function return value

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slice.c | 62 ++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index b3919b2e76d3..2396db6b3a05 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -75,19 +75,18 @@ static void slice_print_mask(const char *label, struct slice_mask mask) {}
 
 #endif
 
-static struct slice_mask slice_range_to_mask(unsigned long start,
-					     unsigned long len)
+static void slice_range_to_mask(unsigned long start, unsigned long len,
+				struct slice_mask *ret)
 {
 	unsigned long end = start + len - 1;
-	struct slice_mask ret;
 
-	ret.low_slices = 0;
-	bitmap_zero(ret.high_slices, SLICE_NUM_HIGH);
+	ret->low_slices = 0;
+	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	if (start < SLICE_LOW_TOP) {
 		unsigned long mend = min(end, (SLICE_LOW_TOP - 1));
 
-		ret.low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
+		ret->low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
 			- (1u << GET_LOW_SLICE_INDEX(start));
 	}
 
@@ -96,9 +95,8 @@ static struct slice_mask slice_range_to_mask(unsigned long start,
 		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
 		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
 
-		bitmap_set(ret.high_slices, start_index, count);
+		bitmap_set(ret->high_slices, start_index, count);
 	}
-	return ret;
 }
 
 static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
@@ -132,53 +130,47 @@ static int slice_high_has_vma(struct mm_struct *mm, unsigned long slice)
 	return !slice_area_is_free(mm, start, end - start);
 }
 
-static struct slice_mask slice_mask_for_free(struct mm_struct *mm)
+static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 {
-	struct slice_mask ret;
 	unsigned long i;
 
-	ret.low_slices = 0;
-	bitmap_zero(ret.high_slices, SLICE_NUM_HIGH);
+	ret->low_slices = 0;
+	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (!slice_low_has_vma(mm, i))
-			ret.low_slices |= 1u << i;
+			ret->low_slices |= 1u << i;
 
 	if (mm->task_size <= SLICE_LOW_TOP)
-		return ret;
+		return;
 
 	for (i = 0; i < SLICE_NUM_HIGH; i++)
 		if (!slice_high_has_vma(mm, i))
-			__set_bit(i, ret.high_slices);
-
-	return ret;
+			__set_bit(i, ret->high_slices);
 }
 
-static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
+static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_mask *ret)
 {
 	unsigned char *hpsizes;
 	int index, mask_index;
-	struct slice_mask ret;
 	unsigned long i;
 	u64 lpsizes;
 
-	ret.low_slices = 0;
-	bitmap_zero(ret.high_slices, SLICE_NUM_HIGH);
+	ret->low_slices = 0;
+	bitmap_zero(ret->high_slices, SLICE_NUM_HIGH);
 
 	lpsizes = mm->context.low_slices_psize;
 	for (i = 0; i < SLICE_NUM_LOW; i++)
 		if (((lpsizes >> (i * 4)) & 0xf) == psize)
-			ret.low_slices |= 1u << i;
+			ret->low_slices |= 1u << i;
 
 	hpsizes = mm->context.high_slices_psize;
 	for (i = 0; i < SLICE_NUM_HIGH; i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
-			__set_bit(i, ret.high_slices);
+			__set_bit(i, ret->high_slices);
 	}
-
-	return ret;
 }
 
 static int slice_check_fit(struct slice_mask mask, struct slice_mask available)
@@ -460,7 +452,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First make up a "good" mask of slices that have the right size
 	 * already
 	 */
-	good_mask = slice_mask_for_size(mm, psize);
+	slice_mask_for_size(mm, psize, &good_mask);
 	slice_print_mask(" good_mask", good_mask);
 
 	/*
@@ -485,7 +477,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 #ifdef CONFIG_PPC_64K_PAGES
 	/* If we support combo pages, we can allow 64k pages in 4k slices */
 	if (psize == MMU_PAGE_64K) {
-		compat_mask = slice_mask_for_size(mm, MMU_PAGE_4K);
+		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask);
 		if (fixed)
 			slice_or_mask(&good_mask, &compat_mask);
 	}
@@ -494,7 +486,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr != 0 || fixed) {
 		/* Build a mask for the requested range */
-		mask = slice_range_to_mask(addr, len);
+		slice_range_to_mask(addr, len, &mask);
 		slice_print_mask(" mask", mask);
 
 		/* Check if we fit in the good mask. If we do, we just return,
@@ -521,7 +513,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/* We don't fit in the good mask, check what other slices are
 	 * empty and thus can be converted
 	 */
-	potential_mask = slice_mask_for_free(mm);
+	slice_mask_for_free(mm, &potential_mask);
 	slice_or_mask(&potential_mask, &good_mask);
 	slice_print_mask(" potential", potential_mask);
 
@@ -564,7 +556,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (addr == -ENOMEM)
 		return -ENOMEM;
 
-	mask = slice_range_to_mask(addr, len);
+	slice_range_to_mask(addr, len, &mask);
 	slice_dbg(" found potential area at 0x%lx\n", addr);
 	slice_print_mask(" mask", mask);
 
@@ -696,9 +688,11 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
-	struct slice_mask mask = slice_range_to_mask(start, len);
+	struct slice_mask mask;
 
 	VM_BUG_ON(radix_enabled());
+
+	slice_range_to_mask(start, len, &mask);
 	slice_convert(mm, mask, psize);
 }
 
@@ -731,13 +725,13 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	if (radix_enabled())
 		return 0;
 
-	mask = slice_range_to_mask(addr, len);
-	available = slice_mask_for_size(mm, psize);
+	slice_range_to_mask(addr, len, &mask);
+	slice_mask_for_size(mm, psize, &available);
 #ifdef CONFIG_PPC_64K_PAGES
 	/* We need to account for 4k slices too */
 	if (psize == MMU_PAGE_64K) {
 		struct slice_mask compat_mask;
-		compat_mask = slice_mask_for_size(mm, MMU_PAGE_4K);
+		slice_mask_for_size(mm, MMU_PAGE_4K, &compat_mask);
 		slice_or_mask(&available, &compat_mask);
 	}
 #endif
-- 
2.7.4
