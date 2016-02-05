Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 977571A006D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 05:12:06 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 5 Feb 2016 11:12:04 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DF43219D804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 11:00:00 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u15IC1Wa14155864
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Feb 2016 11:12:01 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u15IBwpE028283
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Feb 2016 11:12:01 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Fix Multi hit ERAT cause by recent THP update
Date: Fri,  5 Feb 2016 23:41:40 +0530
Message-Id: <1454695900-9282-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With ppc64 we use the deposted pgtable_t to store the hash pte slot
information. We should not withdraw the deposited pgtable_t without
marking the pmd none. This ensure that low level hash fault handling
will skip this huge pte and we will handle them at upper levels. We
do take page table lock there and we can serialize against a parallel
THP split there. Hence mark the pte none (ie, remove __PAGE_USER) before
splitting the huge pmd.

Also make sure we wait for irq disable section in other cpus to finish
before flipping a huge pte entry with a regular pmd entry. Code paths
like find_linux_pte_or_hugepte depend on irq disable to get
a stable pte_t pointer. A parallel thp split need to make sure we
don't convert a pmd pte to a regular pmd entry without waiting for the
irq disable section to finish.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  4 ++++
 arch/powerpc/mm/pgtable_64.c                 | 36 +++++++++++++++++++++++++++-
 include/asm-generic/pgtable.h                |  8 +++++++
 mm/huge_memory.c                             |  1 +
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8d1c41d28318..0415856941e0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -281,6 +281,10 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 
+#define __HAVE_ARCH_PMDP_HUGE_SPLITTING_FLUSH
+extern void pmdp_huge_splitting_flush(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp);
+
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
 static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 3124a20d0fab..d80a23a92f95 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -646,6 +646,31 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	return pgtable;
 }
 
+void pmdp_huge_splitting_flush(struct vm_area_struct *vma,
+			       unsigned long address, pmd_t *pmdp)
+{
+	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+
+#ifdef CONFIG_DEBUG_VM
+	BUG_ON(REGION_ID(address) != USER_REGION_ID);
+#endif
+	/*
+	 * We can't mark the pmd none here, because that will cause a race
+	 * against exit_mmap. We need to continue mark pmd TRANS HUGE, while
+	 * we spilt, but at the same time we wan't rest of the ppc64 code
+	 * not to insert hash pte on this, because we will be modifying
+	 * the deposited pgtable in the caller of this function. Hence
+	 * clear the _PAGE_USER so that we move the fault handling to
+	 * higher level function and that will serialize against ptl.
+	 * We need to flush existing hash pte entries here even though,
+	 * the translation is still valid, because we will withdraw
+	 * pgtable_t after this.
+	 */
+	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_USER, 0);
+	return;
+}
+
+
 /*
  * set a new huge pmd. We should not be called for updating
  * an existing pmd entry. That should go via pmd_hugepage_update.
@@ -663,10 +688,19 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
 }
 
+/*
+ * We use this to invalidate a pmdp entry before switching from a
+ * hugepte to regular pmd entry.
+ */
 void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
+	pmd_hugepage_update(vma->vm_mm, address, pmdp, ~0UL, 0);
+	/*
+	 * This ensures that generic code that rely on IRQ disabling
+	 * to prevent a parallel THP split work as expected.
+	 */
+	kick_all_cpus_sync();
 }
 
 /*
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 0b3c0d39ef75..388065c79795 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -239,6 +239,14 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_HUGE_SPLITTING_FLUSH
+static inline void pmdp_huge_splitting_flush(struct vm_area_struct *vma,
+					     unsigned long address, pmd_t *pmdp)
+{
+	return;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 36c070167b71..b52d16a86e91 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2860,6 +2860,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	young = pmd_young(*pmd);
 	dirty = pmd_dirty(*pmd);
 
+	pmdp_huge_splitting_flush(vma, haddr, pmd);
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
 	pmd_populate(mm, &_pmd, pgtable);
 
-- 
2.5.0
