Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyj6xKNzDqBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 67/70] powerpc/mm/radix: Add radix THP callbacks
Date: Fri, 29 Apr 2016 23:26:30 +1000
Message-Id: <1461936393-10131-67-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

The deposited pgtable_t is a pte fragment hence we cannot use page->lru
for linking then together. We use the first two 64 bits for pte fragment
as list_head type to link all deposited fragments together. On withdraw
we properly zero then out.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h |   2 +
 arch/powerpc/include/asm/book3s/64/pgtable.h     |  16 ++++
 arch/powerpc/include/asm/book3s/64/radix.h       |  22 +++++
 arch/powerpc/mm/pgtable-book3s64.c               |   2 +-
 arch/powerpc/mm/pgtable-radix.c                  | 117 +++++++++++++++++++++++
 5 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 79331cf77613..793ecd5ea301 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -71,6 +71,8 @@ static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 
 static inline pmd_t pmd_mkhuge(pmd_t pmd)
 {
+	if (radix_enabled())
+		return radix__pmd_mkhuge(pmd);
 	return hash__pmd_mkhuge(pmd);
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 5f290d39e563..1b09ba0c2d1d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -827,6 +827,8 @@ extern void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 extern int hash__has_transparent_hugepage(void);
 static inline int has_transparent_hugepage(void)
 {
+	if (radix_enabled())
+		return radix__has_transparent_hugepage();
 	return hash__has_transparent_hugepage();
 }
 
@@ -834,6 +836,8 @@ static inline unsigned long
 pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
 		    unsigned long clr, unsigned long set)
 {
+	if (radix_enabled())
+		return radix__pmd_hugepage_update(mm, addr, pmdp, clr, set);
 	return hash__pmd_hugepage_update(mm, addr, pmdp, clr, set);
 }
 
@@ -885,12 +889,16 @@ extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pmd_t *pmdp)
 {
+	if (radix_enabled())
+		return radix__pmdp_huge_get_and_clear(mm, addr, pmdp);
 	return hash__pmdp_huge_get_and_clear(mm, addr, pmdp);
 }
 
 static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp)
 {
+	if (radix_enabled())
+		return radix__pmdp_collapse_flush(vma, address, pmdp);
 	return hash__pmdp_collapse_flush(vma, address, pmdp);
 }
 #define pmdp_collapse_flush pmdp_collapse_flush
@@ -899,6 +907,8 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
 					      pmd_t *pmdp, pgtable_t pgtable)
 {
+	if (radix_enabled())
+		return radix__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
 	return hash__pgtable_trans_huge_deposit(mm, pmdp, pgtable);
 }
 
@@ -906,6 +916,8 @@ static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
 static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
 						    pmd_t *pmdp)
 {
+	if (radix_enabled())
+		return radix__pgtable_trans_huge_withdraw(mm, pmdp);
 	return hash__pgtable_trans_huge_withdraw(mm, pmdp);
 }
 
@@ -917,6 +929,8 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 static inline void pmdp_huge_split_prepare(struct vm_area_struct *vma,
 					   unsigned long address, pmd_t *pmdp)
 {
+	if (radix_enabled())
+		return radix__pmdp_huge_split_prepare(vma, address, pmdp);
 	return hash__pmdp_huge_split_prepare(vma, address, pmdp);
 }
 
@@ -925,6 +939,8 @@ struct spinlock;
 static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 					 struct spinlock *old_pmd_ptl)
 {
+	if (radix_enabled())
+		return false;
 	/*
 	 * Archs like ppc64 use pgtable to store per pmd
 	 * specific information. So when we switch the pmd,
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index f4709024b466..937d4e247ac3 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -196,6 +196,28 @@ static inline int radix__pmd_trans_huge(pmd_t pmd)
 	return !!(pmd_val(pmd) & _PAGE_PTE);
 }
 
+static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) | _PAGE_PTE);
+}
+static inline void radix__pmdp_huge_split_prepare(struct vm_area_struct *vma,
+					    unsigned long address, pmd_t *pmdp)
+{
+	/* Nothing to do for radix. */
+	return;
+}
+
+extern unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
+					  pmd_t *pmdp, unsigned long clr,
+					  unsigned long set);
+extern pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma,
+				  unsigned long address, pmd_t *pmdp);
+extern void radix__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+					pgtable_t pgtable);
+extern pgtable_t radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
+				      unsigned long addr, pmd_t *pmdp);
+extern int radix__has_transparent_hugepage(void);
 #endif
 
 extern int __meminit radix__vmemmap_create_mapping(unsigned long start,
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index d566a250164d..eb4451144746 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -69,7 +69,7 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
 	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
-
+	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	/*
 	 * This ensures that generic code that rely on IRQ disabling
 	 * to prevent a parallel THP split work as expected.
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index a5a5253c3ea1..18b2c11604fa 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -19,6 +19,8 @@
 #include <asm/mmu.h>
 #include <asm/firmware.h>
 
+#include <trace/events/thp.h>
+
 static int native_update_partition_table(u64 patb1)
 {
 	partition_tb->patb1 = cpu_to_be64(patb1);
@@ -407,3 +409,118 @@ void radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
 }
 #endif
 #endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+
+unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
+				  pmd_t *pmdp, unsigned long clr,
+				  unsigned long set)
+{
+	unsigned long old;
+
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(!radix__pmd_trans_huge(*pmdp));
+	assert_spin_locked(&mm->page_table_lock);
+#endif
+
+	old = radix__pte_update(mm, addr, (pte_t *)pmdp, clr, set, 1);
+	trace_hugepage_update(addr, old, clr, set);
+
+	return old;
+}
+
+pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
+			pmd_t *pmdp)
+
+{
+	pmd_t pmd;
+
+	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
+	/*
+	 * khugepaged calls this for normal pmd
+	 */
+	pmd = *pmdp;
+	pmd_clear(pmdp);
+	/*FIXME!!  Verify whether we need this kick below */
+	kick_all_cpus_sync();
+	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	return pmd;
+}
+
+/*
+ * For us pgtable_t is pte_t *. Inorder to save the deposisted
+ * page table, we consider the allocated page table as a list
+ * head. On withdraw we need to make sure we zero out the used
+ * list_head memory area.
+ */
+void radix__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+				 pgtable_t pgtable)
+{
+        struct list_head *lh = (struct list_head *) pgtable;
+
+        assert_spin_locked(pmd_lockptr(mm, pmdp));
+
+        /* FIFO */
+        if (!pmd_huge_pte(mm, pmdp))
+                INIT_LIST_HEAD(lh);
+        else
+                list_add(lh, (struct list_head *) pmd_huge_pte(mm, pmdp));
+        pmd_huge_pte(mm, pmdp) = pgtable;
+}
+
+pgtable_t radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+{
+        pte_t *ptep;
+        pgtable_t pgtable;
+        struct list_head *lh;
+
+        assert_spin_locked(pmd_lockptr(mm, pmdp));
+
+        /* FIFO */
+        pgtable = pmd_huge_pte(mm, pmdp);
+        lh = (struct list_head *) pgtable;
+        if (list_empty(lh))
+                pmd_huge_pte(mm, pmdp) = NULL;
+        else {
+                pmd_huge_pte(mm, pmdp) = (pgtable_t) lh->next;
+                list_del(lh);
+        }
+        ptep = (pte_t *) pgtable;
+        *ptep = __pte(0);
+        ptep++;
+        *ptep = __pte(0);
+        return pgtable;
+}
+
+
+pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
+			       unsigned long addr, pmd_t *pmdp)
+{
+	pmd_t old_pmd;
+	unsigned long old;
+
+	old = radix__pmd_hugepage_update(mm, addr, pmdp, ~0UL, 0);
+	old_pmd = __pmd(old);
+	/*
+	 * Serialize against find_linux_pte_or_hugepte which does lock-less
+	 * lookup in page tables with local interrupts disabled. For huge pages
+	 * it casts pmd_t to pte_t. Since format of pte_t is different from
+	 * pmd_t we want to prevent transit from pmd pointing to page table
+	 * to pmd pointing to huge page (and back) while interrupts are disabled.
+	 * We clear pmd to possibly replace it with page table pointer in
+	 * different code paths. So make sure we wait for the parallel
+	 * find_linux_pte_or_hugepage to finish.
+	 */
+	kick_all_cpus_sync();
+	return old_pmd;
+}
+
+int radix__has_transparent_hugepage(void)
+{
+	/* For radix 2M at PMD level means thp */
+	if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
+		return 1;
+	return 0;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
2.5.0
