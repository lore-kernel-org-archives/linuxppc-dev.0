Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdplx4pQBzF0gg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 21:57:01 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1AAsBgH052410
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:56:59 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1x5jspyu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:56:59 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 10 Feb 2018 05:56:58 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/5] powerpc/mm/slice: Update documentation in the file.
Date: Sat, 10 Feb 2018 16:26:40 +0530
In-Reply-To: <20180210105643.11857-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180210105643.11857-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180210105643.11857-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will make code changes in the next patch. To make the review easier split
the documentation update in to a seperate patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slice.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 98b53d48968f..259bbda9a222 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -478,7 +478,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * already
 	 */
 	slice_mask_for_size(mm, psize, &good_mask, high_limit);
-	slice_print_mask(" good_mask", good_mask);
+	slice_print_mask("Mask for page size", good_mask);
 
 	/*
 	 * Here "good" means slices that are already the right page size,
@@ -507,15 +507,17 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			slice_or_mask(&good_mask, &compat_mask);
 	}
 #endif
-
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr != 0 || fixed) {
-		/* Build a mask for the requested range */
+		/*
+		 * Build a mask for the requested range
+		 */
 		slice_range_to_mask(addr, len, &mask);
-		slice_print_mask(" mask", mask);
+		slice_print_mask("Request range mask", mask);
 
-		/* Check if we fit in the good mask. If we do, we just return,
-		 * nothing else to do
+		/*
+		 * Check if we fit in the good mask. If we do, we just
+		 * return, nothing else to do
 		 */
 		if (slice_check_fit(mm, mask, good_mask)) {
 			slice_dbg(" fits good !\n");
@@ -553,8 +555,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		return -EBUSY;
 
 	slice_dbg(" search...\n");
-
-	/* If we had a hint that didn't work out, see if we can fit
+	/*
+	 * If we had a hint that didn't work out, see if we can fit
 	 * anywhere in the good area.
 	 */
 	if (addr) {
@@ -573,7 +575,16 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			       psize, topdown, high_limit);
 
 #ifdef CONFIG_PPC_64K_PAGES
+	/*
+	 * If we didn't request for fixed mapping, we never looked at
+	 * compat area. Now that we are not finding space, let's look
+	 * at the 4K slice also.
+	 */
 	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
+		/*
+		 * mask variable is free here. Use that for compat
+		 * size mask.
+		 */
 		/* retry the search with 4k-page slices included */
 		slice_or_mask(&potential_mask, &compat_mask);
 		addr = slice_find_area(mm, len, potential_mask,
-- 
2.14.3
