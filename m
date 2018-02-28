Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrmqP3YL1zF0gX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 18:08:00 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1S74UI0111456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 02:07:58 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gdn2vwdjs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 02:07:58 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 28 Feb 2018 07:07:55 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
In-Reply-To: <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
Date: Wed, 28 Feb 2018 12:37:50 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3jda8xl.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I also noticed that the slice mask printing use wrong variables now. I
guess this should take care of it

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index fef3f36b0b73..6b3575c39668 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -535,8 +535,6 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 * already
 	 */
 	maskp = slice_mask_for_size(mm, psize);
-	slice_print_mask(" good_mask", &good_mask);
-
 	/*
 	 * Here "good" means slices that are already the right page size,
 	 * "compat" means slices that have a compatible page size (i.e.
@@ -569,6 +567,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	{
 		slice_copy_mask(&good_mask, maskp, high_slices);
 	}
+	slice_print_mask(" good_mask", &good_mask);
+	slice_print_mask(" compat_mask", compat_maskp);
 
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr || fixed) {
@@ -646,7 +646,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	slice_range_to_mask(addr, len, &potential_mask, high_slices);
 	slice_dbg(" found potential area at 0x%lx\n", addr);
-	slice_print_mask(" mask", maskp);
+	slice_print_mask(" mask", &potential_mask);
 
  convert:
 	slice_andnot_mask(&potential_mask, &potential_mask, &good_mask, high_slices);
@@ -836,13 +836,6 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 		return !slice_check_range_fits(mm, &available, addr, len);
 	}
 #endif
-
-#if 0 /* too verbose */
-	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
-		 mm, addr, len);
-	slice_print_mask(" mask", &mask);
-	slice_print_mask(" available", &available);
-#endif
 	return !slice_check_range_fits(mm, maskp, addr, len);
 }
 #endif
