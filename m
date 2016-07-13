Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDHx0L97zDqK1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:37:00 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YFxB037909
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:59 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452xrn1b8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:58 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:36:57 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 01/13] mm/hugetlb: Simplify hugetlb unmap
Date: Wed, 13 Jul 2016 15:06:32 +0530
In-Reply-To: <1468402604-5130-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402604-5130-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402604-5130-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For hugetlb like THP (and unlike regular page), we do tlb flush after
dropping ptl. Because of the above, we don't need to track force_flush
like we do now. Instead we can simply call tlb_remove_page() which
will do the flush if needed.

No functionality change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
NOTE: This patch is already applied to -mm tree

 mm/hugetlb.c | 54 +++++++++++++++++++++---------------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c1f3c0be150a..0352296502b1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3177,7 +3177,6 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			    unsigned long start, unsigned long end,
 			    struct page *ref_page)
 {
-	int force_flush = 0;
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
 	pte_t *ptep;
@@ -3196,19 +3195,22 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	tlb_start_vma(tlb, vma);
 	mmu_notifier_invalidate_range_start(mm, mmun_start, mmun_end);
 	address = start;
-again:
 	for (; address < end; address += sz) {
 		ptep = huge_pte_offset(mm, address);
 		if (!ptep)
 			continue;
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, &address, ptep))
-			goto unlock;
+		if (huge_pmd_unshare(mm, &address, ptep)) {
+			spin_unlock(ptl);
+			continue;
+		}
 
 		pte = huge_ptep_get(ptep);
-		if (huge_pte_none(pte))
-			goto unlock;
+		if (huge_pte_none(pte)) {
+			spin_unlock(ptl);
+			continue;
+		}
 
 		/*
 		 * Migrating hugepage or HWPoisoned hugepage is already
@@ -3216,7 +3218,8 @@ again:
 		 */
 		if (unlikely(!pte_present(pte))) {
 			huge_pte_clear(mm, address, ptep);
-			goto unlock;
+			spin_unlock(ptl);
+			continue;
 		}
 
 		page = pte_page(pte);
@@ -3226,9 +3229,10 @@ again:
 		 * are about to unmap is the actual page of interest.
 		 */
 		if (ref_page) {
-			if (page != ref_page)
-				goto unlock;
-
+			if (page != ref_page) {
+				spin_unlock(ptl);
+				continue;
+			}
 			/*
 			 * Mark the VMA as having unmapped its page so that
 			 * future faults in this VMA will fail rather than
@@ -3244,30 +3248,14 @@ again:
 
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		page_remove_rmap(page, true);
-		force_flush = !__tlb_remove_page(tlb, page);
-		if (force_flush) {
-			address += sz;
-			spin_unlock(ptl);
-			break;
-		}
-		/* Bail out after unmapping reference page if supplied */
-		if (ref_page) {
-			spin_unlock(ptl);
-			break;
-		}
-unlock:
+
 		spin_unlock(ptl);
-	}
-	/*
-	 * mmu_gather ran out of room to batch pages, we break out of
-	 * the PTE lock to avoid doing the potential expensive TLB invalidate
-	 * and page-free while holding it.
-	 */
-	if (force_flush) {
-		force_flush = 0;
-		tlb_flush_mmu(tlb);
-		if (address < end && !ref_page)
-			goto again;
+		tlb_remove_page(tlb, page);
+		/*
+		 * Bail out after unmapping reference page if supplied
+		 */
+		if (ref_page)
+			break;
 	}
 	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
 	tlb_end_vma(tlb, vma);
-- 
2.7.4
