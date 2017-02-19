Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2Wq5qFczDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:08:07 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA3enD015460
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:08:05 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28q729uhmg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:08:05 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 03:08:03 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 07/10] powerpc/mm/slice: Use mm task_size as max value of
 slice index
Date: Sun, 19 Feb 2017 15:37:14 +0530
In-Reply-To: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1487498837-12017-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the followup patch, we will increase the slice array sice to handle 512TB
range, but will limit the task size to 128TB. Avoid doing uncessary computation
and avoid doing slice mask related operation above task_size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slice.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index da67b91f46d3..f286b7839a12 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -145,7 +145,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 	if (mm->task_size <= SLICE_LOW_TOP)
 		return;
 
-	for (i = 0; i < SLICE_NUM_HIGH; i++)
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++)
 		if (!slice_high_has_vma(mm, i))
 			__set_bit(i, ret->high_slices);
 }
@@ -166,7 +166,7 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 			ret->low_slices |= 1u << i;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == psize)
@@ -174,15 +174,17 @@ static void slice_mask_for_size(struct mm_struct *mm, int psize, struct slice_ma
 	}
 }
 
-static int slice_check_fit(struct slice_mask mask, struct slice_mask available)
+static int slice_check_fit(struct mm_struct *mm,
+			   struct slice_mask mask, struct slice_mask available)
 {
 	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
+	unsigned long slice_count = GET_HIGH_SLICE_INDEX(mm->task_size);
 
 	bitmap_and(result, mask.high_slices,
-		   available.high_slices, SLICE_NUM_HIGH);
+		   available.high_slices, slice_count);
 
 	return (mask.low_slices & available.low_slices) == mask.low_slices &&
-		bitmap_equal(result, mask.high_slices, SLICE_NUM_HIGH);
+		bitmap_equal(result, mask.high_slices, slice_count);
 }
 
 static void slice_flush_segments(void *parm)
@@ -226,7 +228,7 @@ static void slice_convert(struct mm_struct *mm, struct slice_mask mask, int psiz
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (test_bit(i, mask.high_slices))
@@ -493,7 +495,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		/* Check if we fit in the good mask. If we do, we just return,
 		 * nothing else to do
 		 */
-		if (slice_check_fit(mask, good_mask)) {
+		if (slice_check_fit(mm, mask, good_mask)) {
 			slice_dbg(" fits good !\n");
 			return addr;
 		}
@@ -518,7 +520,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	slice_or_mask(&potential_mask, &good_mask);
 	slice_print_mask(" potential", potential_mask);
 
-	if ((addr != 0 || fixed) && slice_check_fit(mask, potential_mask)) {
+	if ((addr != 0 || fixed) && slice_check_fit(mm, mask, potential_mask)) {
 		slice_dbg(" fits potential !\n");
 		goto convert;
 	}
@@ -666,7 +668,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
 	mm->context.low_slices_psize = lpsizes;
 
 	hpsizes = mm->context.high_slices_psize;
-	for (i = 0; i < SLICE_NUM_HIGH; i++) {
+	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->task_size); i++) {
 		mask_index = i & 0x1;
 		index = i >> 1;
 		if (((hpsizes[index] >> (mask_index * 4)) & 0xf) == old_psize)
@@ -743,6 +745,6 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	slice_print_mask(" mask", mask);
 	slice_print_mask(" available", available);
 #endif
-	return !slice_check_fit(mask, available);
+	return !slice_check_fit(mm, mask, available);
 }
 #endif
-- 
2.7.4
