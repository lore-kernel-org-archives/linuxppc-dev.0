Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC5NS1bH9zDvfC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 19:35:03 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA77x54a139708
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 03:35:01 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26jmx2ub46-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 03:35:01 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 01:35:00 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, "Kirill A . Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/2] mm: move vma_is_anonymous check within
 pmd_move_must_withdraw
Date: Mon,  7 Nov 2016 14:04:40 +0530
Message-Id: <20161107083441.21901-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Architectures like ppc64 want to use page table deposit/withraw
even with huge pmd dax entries. Allow arch to override the
vma_is_anonymous check by moving that to pmd_move_must_withdraw
function

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/asm-generic/pgtable.h | 12 ------------
 mm/huge_memory.c              | 17 +++++++++++++++--
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index c4f8fd2fd384..324990273ad2 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -653,18 +653,6 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 }
 #endif
 
-#ifndef pmd_move_must_withdraw
-static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
-					 spinlock_t *old_pmd_ptl)
-{
-	/*
-	 * With split pmd lock we also need to move preallocated
-	 * PTE page table if new_pmd is on different PMD page table.
-	 */
-	return new_pmd_ptl != old_pmd_ptl;
-}
-#endif
-
 /*
  * This function is meant to be used by sites walking pagetables with
  * the mmap_sem hold in read mode to protect against MADV_DONTNEED and
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cdcd25cb30fe..1ac1b0ca63c4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1424,6 +1424,20 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return 1;
 }
 
+#ifndef pmd_move_must_withdraw
+static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
+					 spinlock_t *old_pmd_ptl)
+{
+	/*
+	 * With split pmd lock we also need to move preallocated
+	 * PTE page table if new_pmd is on different PMD page table.
+	 *
+	 * We also don't deposit and withdraw tables for file pages.
+	 */
+	return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
+}
+#endif
+
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		  unsigned long new_addr, unsigned long old_end,
 		  pmd_t *old_pmd, pmd_t *new_pmd)
@@ -1458,8 +1472,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
-		if (pmd_move_must_withdraw(new_ptl, old_ptl) &&
-				vma_is_anonymous(vma)) {
+		if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
 			pgtable_t pgtable;
 			pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
-- 
2.10.2
