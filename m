Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 403xG82lhDzDqYx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:06:24 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2IB4RA7127792
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 07:06:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gsgab15jm-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 07:06:20 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 18 Mar 2018 05:06:20 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 1/4] powerpc/mm/slice: Consolidate the return path for the
 function.
Date: Sun, 18 Mar 2018 16:35:55 +0530
In-Reply-To: <20180318110558.30493-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180318110558.30493-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180318110558.30493-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the follow up patch, on finding a free area we will need to do allocated
extra contexts as needed. Consolidating the return path for
slice_get_unmapped_area makes it easy.

Split into a separate patch to make review easy.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slice.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 15a857772617..f64bfe8bae57 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -585,7 +585,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 */
 		if (slice_check_range_fits(mm, &good_mask, addr, len)) {
 			slice_dbg(" fits good !\n");
-			return addr;
+			newaddr = addr;
+			goto return_addr;
 		}
 	} else {
 		/* Now let's see if we can find something in the existing
@@ -598,7 +599,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 			 * we thus return directly
 			 */
 			slice_dbg(" found area at 0x%lx\n", newaddr);
-			return newaddr;
+			goto return_addr;
 		}
 	}
 	/*
@@ -612,6 +613,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (addr || fixed) {
 		if (slice_check_range_fits(mm, &potential_mask, addr, len)) {
 			slice_dbg(" fits potential !\n");
+			newaddr = addr;
 			goto convert;
 		}
 	}
@@ -626,34 +628,34 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * anywhere in the good area.
 	 */
 	if (addr) {
-		addr = slice_find_area(mm, len, &good_mask,
-				       psize, topdown, high_limit);
-		if (addr != -ENOMEM) {
-			slice_dbg(" found area at 0x%lx\n", addr);
-			return addr;
+		newaddr = slice_find_area(mm, len, &good_mask,
+					  psize, topdown, high_limit);
+		if (newaddr != -ENOMEM) {
+			slice_dbg(" found area at 0x%lx\n", newaddr);
+			goto return_addr;
 		}
 	}
 
 	/* Now let's see if we can find something in the existing slices
 	 * for that size plus free slices
 	 */
-	addr = slice_find_area(mm, len, &potential_mask,
-			       psize, topdown, high_limit);
+	newaddr = slice_find_area(mm, len, &potential_mask,
+				  psize, topdown, high_limit);
 
 #ifdef CONFIG_PPC_64K_PAGES
-	if (addr == -ENOMEM && psize == MMU_PAGE_64K) {
+	if (newaddr == -ENOMEM && psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
 		slice_or_mask(&potential_mask, &potential_mask, compat_maskp, high_slices);
-		addr = slice_find_area(mm, len, &potential_mask,
-				       psize, topdown, high_limit);
+		newaddr = slice_find_area(mm, len, &potential_mask,
+					  psize, topdown, high_limit);
 	}
 #endif
 
-	if (addr == -ENOMEM)
+	if (newaddr == -ENOMEM)
 		return -ENOMEM;
 
-	slice_range_to_mask(addr, len, &potential_mask, high_slices);
-	slice_dbg(" found potential area at 0x%lx\n", addr);
+	slice_range_to_mask(newaddr, len, &potential_mask, high_slices);
+	slice_dbg(" found potential area at 0x%lx\n", newaddr);
 	slice_print_mask(" mask", &potential_mask);
 
  convert:
@@ -667,7 +669,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		if (psize > MMU_PAGE_BASE)
 			on_each_cpu(slice_flush_segments, mm, 1);
 	}
-	return addr;
+
+return_addr:
+	return newaddr;
 
 }
 EXPORT_SYMBOL_GPL(slice_get_unmapped_area);
-- 
2.14.3
