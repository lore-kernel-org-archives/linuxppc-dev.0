Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwx986TJWzF1XV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 12:37:48 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e3so286673pga.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 17:37:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 05/10] powerpc/mm/slice: implement slice_check_range_fits
Date: Wed,  7 Mar 2018 11:37:13 +1000
Message-Id: <20180307013718.13749-6-npiggin@gmail.com>
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

Rather than build slice masks from a range then use that to check for
fit in a candidate mask, implement slice_check_range_fits that checks
if a range fits in a mask directly.

This allows several structures to be removed from stacks, and also we
don't expect a huge range in a lot of these cases, so building and
comparing a full mask is going to be more expensive than testing just
one or two bits of the range.

On POWER8, this increases vfork+exec+exit performance by 0.3%
and reduces time to mmap+munmap a 64kB page by 5%.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 62 +++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 3e199b9cbbfd..0a5efa40e739 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -174,26 +174,36 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
 #error "Must define the slice masks for page sizes supported by the platform"
 #endif
 
-static int slice_check_fit(struct mm_struct *mm,
-			   const struct slice_mask *mask,
-			   const struct slice_mask *available)
+static bool slice_check_range_fits(struct mm_struct *mm,
+			   const struct slice_mask *available,
+			   unsigned long start, unsigned long len)
 {
-	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
-	/*
-	 * Make sure we just do bit compare only to the max
-	 * addr limit and not the full bit map size.
-	 */
-	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+	unsigned long end = start + len - 1;
+	u64 low_slices = 0;
 
-	if (!SLICE_NUM_HIGH)
-		return (mask->low_slices & available->low_slices) ==
-		       mask->low_slices;
+	if (start < SLICE_LOW_TOP) {
+		unsigned long mend = min(end,
+					 (unsigned long)(SLICE_LOW_TOP - 1));
 
-	bitmap_and(result, mask->high_slices,
-		   available->high_slices, slice_count);
+		low_slices = (1u << (GET_LOW_SLICE_INDEX(mend) + 1))
+				- (1u << GET_LOW_SLICE_INDEX(start));
+	}
+	if ((low_slices & available->low_slices) != low_slices)
+		return false;
 
-	return (mask->low_slices & available->low_slices) == mask->low_slices &&
-		bitmap_equal(result, mask->high_slices, slice_count);
+	if (SLICE_NUM_HIGH && ((start + len) > SLICE_LOW_TOP)) {
+		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
+		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
+		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
+		unsigned long i;
+
+		for (i = start_index; i < start_index + count; i++) {
+			if (!test_bit(i, available->high_slices))
+				return false;
+		}
+	}
+
+	return true;
 }
 
 static void slice_flush_segments(void *parm)
@@ -558,14 +568,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr != 0 || fixed) {
-		/* Build a mask for the requested range */
-		slice_range_to_mask(addr, len, &mask);
-		slice_print_mask(" mask", &mask);
-
 		/* Check if we fit in the good mask. If we do, we just return,
 		 * nothing else to do
 		 */
-		if (slice_check_fit(mm, &mask, &good_mask)) {
+		if (slice_check_range_fits(mm, &good_mask, addr, len)) {
 			slice_dbg(" fits good !\n");
 			return addr;
 		}
@@ -591,10 +597,11 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	slice_or_mask(&potential_mask, &good_mask);
 	slice_print_mask(" potential", &potential_mask);
 
-	if ((addr != 0 || fixed) &&
-			slice_check_fit(mm, &mask, &potential_mask)) {
-		slice_dbg(" fits potential !\n");
-		goto convert;
+	if (addr != 0 || fixed) {
+		if (slice_check_range_fits(mm, &potential_mask, addr, len)) {
+			slice_dbg(" fits potential !\n");
+			goto convert;
+		}
 	}
 
 	/* If we have MAP_FIXED and failed the above steps, then error out */
@@ -772,13 +779,12 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len)
 {
-	struct slice_mask mask, available;
+	struct slice_mask available;
 	unsigned int psize = mm->context.user_psize;
 
 	if (radix_enabled())
 		return 0;
 
-	slice_range_to_mask(addr, len, &mask);
 	available = *slice_mask_for_size(mm, psize);
 #ifdef CONFIG_PPC_64K_PAGES
 	/* We need to account for 4k slices too */
@@ -795,6 +801,6 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	slice_print_mask(" mask", &mask);
 	slice_print_mask(" available", &available);
 #endif
-	return !slice_check_fit(mm, &mask, &available);
+	return !slice_check_range_fits(mm, &available, addr, len);
 }
 #endif
-- 
2.16.1
