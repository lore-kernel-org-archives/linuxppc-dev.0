Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tGxfq410hzDvZl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 02:00:51 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uADEwtw3104325
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 10:00:48 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26ppvqfff0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 10:00:48 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 13 Nov 2016 10:00:47 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, benh@au1.ibm.com, michaele@au1.ibm.com,
 michael.neuling@au1.ibm.com, paulus@au1.ibm.com,
 "Kirill A . Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 1/2] mm: move vma_is_anonymous check within
 pmd_move_must_withdraw
Date: Sun, 13 Nov 2016 20:30:24 +0530
Message-Id: <20161113150025.17942-1-aneesh.kumar@linux.vnet.ibm.com>
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  3 ++-
 include/asm-generic/pgtable.h                | 12 ------------
 mm/huge_memory.c                             | 18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 9fd77f8794a0..700301bc5190 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1009,7 +1009,8 @@ static inline void pmdp_huge_split_prepare(struct vm_area_struct *vma,
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
 static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
-					 struct spinlock *old_pmd_ptl)
+					 struct spinlock *old_pmd_ptl,
+					 struct vm_area_struct *vma)
 {
 	if (radix_enabled())
 		return false;
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
index cdcd25cb30fe..54f265ec902e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1424,6 +1424,21 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return 1;
 }
 
+#ifndef pmd_move_must_withdraw
+static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
+					 spinlock_t *old_pmd_ptl,
+					 struct vm_area_struct *vma)
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
@@ -1458,8 +1473,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
-		if (pmd_move_must_withdraw(new_ptl, old_ptl) &&
-				vma_is_anonymous(vma)) {
+		if (pmd_move_must_withdraw(new_ptl, old_ptl, vma)) {
 			pgtable_t pgtable;
 			pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
-- 
2.10.2
