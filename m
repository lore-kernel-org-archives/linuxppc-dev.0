Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmMN3CDyzDqQJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:20 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:17:18 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 856CC3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:17:15 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396HFD242926188
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 23:17:15 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396HFgB021175
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 00:17:15 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 64/68] powerpc/mm/thp: Abstraction for THP functions
Date: Sat,  9 Apr 2016 11:44:00 +0530
Message-Id: <1460182444-2468-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    |  23 +++-
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h |  42 +------
 arch/powerpc/include/asm/book3s/64/pgtable.h     |  83 +++++++++++---
 arch/powerpc/mm/Makefile                         |   2 +-
 arch/powerpc/mm/pgtable-book3s64.c               | 123 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-hash64.c                 | 137 +++--------------------
 6 files changed, 231 insertions(+), 179 deletions(-)
 create mode 100644 arch/powerpc/mm/pgtable-book3s64.c

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f4a19914fdbe..f377177ee060 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -119,11 +119,6 @@ static inline int hlremap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
-					 unsigned long addr,
-					 pmd_t *pmdp,
-					 unsigned long clr,
-					 unsigned long set);
 static inline char *get_hpte_slot_array(pmd_t *pmdp)
 {
 	/*
@@ -193,6 +188,24 @@ static inline int hlpmd_same(pmd_t pmd_a, pmd_t pmd_b)
 	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
 }
 
+static inline pmd_t hlpmd_mkhuge(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE));
+}
+
+extern unsigned long hlpmd_hugepage_update(struct mm_struct *mm,
+					   unsigned long addr, pmd_t *pmdp,
+					   unsigned long clr, unsigned long set);
+extern pmd_t hlpmdp_collapse_flush(struct vm_area_struct *vma,
+				   unsigned long address, pmd_t *pmdp);
+extern void hlpgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+					 pgtable_t pgtable);
+extern pgtable_t hlpgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern void hlpmdp_huge_split_prepare(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp);
+extern pmd_t hlpmdp_huge_get_and_clear(struct mm_struct *mm,
+				       unsigned long addr, pmd_t *pmdp);
+extern int hl_has_transparent_hugepage(void);
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 028b8f6e002b..9ce80ddb0931 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -54,41 +54,6 @@ static inline int hugepd_ok(hugepd_t hpd)
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline int pmd_large(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_PTE);
-}
-
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
-}
-/*
- * For radix we should always find H_PAGE_HASHPTE zero. Hence
- * the below will work for radix too
- */
-static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pmd_t *pmdp)
-{
-	unsigned long old;
-
-	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
-		return 0;
-	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
-	return ((old & _PAGE_ACCESSED) != 0);
-}
-
-#define __HAVE_ARCH_PMDP_SET_WRPROTECT
-static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
-				      pmd_t *pmdp)
-{
-
-	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
-		return;
-
-	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
-}
-
 static inline int pmd_trans_huge(pmd_t pmd)
 {
 	if (radix_enabled())
@@ -103,6 +68,12 @@ static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 		return rpmd_same(pmd_a, pmd_b);
 	return hlpmd_same(pmd_a, pmd_b);
 }
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	return hlpmd_mkhuge(pmd);
+}
+
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
@@ -111,7 +82,6 @@ static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 	if (radix_enabled())
 		BUG();
 	return hlremap_4k_pfn(vma, addr, pfn, prot);
-
 }
 #endif	/* __ASSEMBLY__ */
 #endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e162122ee533..bb77ffe5f179 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -769,7 +769,6 @@ static inline int __meminit vmemmap_create_mapping(unsigned long start,
 static inline void vmemmap_remove_mapping(unsigned long start,
 					  unsigned long page_size)
 {
-
 	if (radix_enabled())
 		return rvmemmap_remove_mapping(start, page_size);
 	return hlvmemmap_remove_mapping(start, page_size);
@@ -825,11 +824,52 @@ extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		       pmd_t *pmdp, pmd_t pmd);
 extern void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 				 pmd_t *pmd);
-extern int has_transparent_hugepage(void);
+extern int hl_has_transparent_hugepage(void);
+static inline int has_transparent_hugepage(void)
+{
+	return hl_has_transparent_hugepage();
+}
 
-static inline pmd_t pmd_mkhuge(pmd_t pmd)
+static inline unsigned long
+pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
+		    unsigned long clr, unsigned long set)
 {
-	return __pmd(pmd_val(pmd) | (_PAGE_PTE | H_PAGE_THP_HUGE));
+	return hlpmd_hugepage_update(mm, addr, pmdp, clr, set);
+}
+
+static inline int pmd_large(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_PTE);
+}
+
+static inline pmd_t pmd_mknotpresent(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
+}
+/*
+ * For radix we should always find H_PAGE_HASHPTE zero. Hence
+ * the below will work for radix too
+ */
+static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pmd_t *pmdp)
+{
+	unsigned long old;
+
+	if ((pmd_val(*pmdp) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pmd_hugepage_update(mm, addr, pmdp, _PAGE_ACCESSED, 0);
+	return ((old & _PAGE_ACCESSED) != 0);
+}
+
+#define __HAVE_ARCH_PMDP_SET_WRPROTECT
+static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pmd_t *pmdp)
+{
+
+	if ((pmd_val(*pmdp) & _PAGE_WRITE) == 0)
+		return;
+
+	pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
 }
 
 #define __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
@@ -842,26 +882,43 @@ extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 				     unsigned long address, pmd_t *pmdp);
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
-extern pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
-				     unsigned long addr, pmd_t *pmdp);
+static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pmd_t *pmdp)
+{
+	return hlpmdp_huge_get_and_clear(mm, addr, pmdp);
+}
 
-extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
-				 unsigned long address, pmd_t *pmdp);
+static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
+					unsigned long address, pmd_t *pmdp)
+{
+	return hlpmdp_collapse_flush(vma, address, pmdp);
+}
 #define pmdp_collapse_flush pmdp_collapse_flush
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
-extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				       pgtable_t pgtable);
+static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
+					      pmd_t *pmdp, pgtable_t pgtable)
+{
+	return hlpgtable_trans_huge_deposit(mm, pmdp, pgtable);
+}
+
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
-extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
+						    pmd_t *pmdp)
+{
+	return hlpgtable_trans_huge_withdraw(mm, pmdp);
+}
 
 #define __HAVE_ARCH_PMDP_INVALIDATE
 extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
 
 #define __HAVE_ARCH_PMDP_HUGE_SPLIT_PREPARE
-extern void pmdp_huge_split_prepare(struct vm_area_struct *vma,
-				    unsigned long address, pmd_t *pmdp);
+static inline void pmdp_huge_split_prepare(struct vm_area_struct *vma,
+					   unsigned long address, pmd_t *pmdp)
+{
+	return hlpmdp_huge_split_prepare(vma, address, pmdp);
+}
 
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 47511dd00599..f2cea6d5e764 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
-obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y) mmu_context_book3s64.o
+obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
new file mode 100644
index 000000000000..168f2fa92fb1
--- /dev/null
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright IBM Corporation, 2016
+ * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#include <linux/sched.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
+
+#include "mmu_decl.h"
+#include <trace/events/thp.h>
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * This is called when relaxing access to a hugepage. It's also called in the page
+ * fault path when we don't hit any of the major fault cases, ie, a minor
+ * update of _PAGE_ACCESSED, _PAGE_DIRTY, etc... The generic code will have
+ * handled those two for us, we additionally deal with missing execute
+ * permission here on some processors
+ */
+int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp, pmd_t entry, int dirty)
+{
+	int changed;
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(!pmd_trans_huge(*pmdp));
+	assert_spin_locked(&vma->vm_mm->page_table_lock);
+#endif
+	changed = !pmd_same(*(pmdp), entry);
+	if (changed) {
+		__ptep_set_access_flags(pmdp_ptep(pmdp), pmd_pte(entry));
+		/*
+		 * Since we are not supporting SW TLB systems, we don't
+		 * have any thing similar to flush_tlb_page_nohash()
+		 */
+	}
+	return changed;
+}
+
+int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+			      unsigned long address, pmd_t *pmdp)
+{
+	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
+}
+/*
+ * set a new huge pmd. We should not be called for updating
+ * an existing pmd entry. That should go via pmd_hugepage_update.
+ */
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd)
+{
+#ifdef CONFIG_DEBUG_VM
+	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
+	assert_spin_locked(&mm->page_table_lock);
+	WARN_ON(!pmd_trans_huge(pmd));
+#endif
+	trace_hugepage_set_pmd(addr, pmd_val(pmd));
+	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
+}
+/*
+ * We use this to invalidate a pmdp entry before switching from a
+ * hugepte to regular pmd entry.
+ */
+void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		     pmd_t *pmdp)
+{
+	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
+
+	/*
+	 * This ensures that generic code that rely on IRQ disabling
+	 * to prevent a parallel THP split work as expected.
+	 */
+	kick_all_cpus_sync();
+}
+
+static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
+{
+	return __pmd(pmd_val(pmd) | pgprot_val(pgprot));
+}
+
+pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
+{
+	unsigned long pmdv;
+
+	pmdv = (pfn << PAGE_SHIFT) & PTE_RPN_MASK;
+	return pmd_set_protbits(__pmd(pmdv), pgprot);
+}
+
+pmd_t mk_pmd(struct page *page, pgprot_t pgprot)
+{
+	return pfn_pmd(page_to_pfn(page), pgprot);
+}
+
+pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+	unsigned long pmdv;
+
+	pmdv = pmd_val(pmd);
+	pmdv &= _HPAGE_CHG_MASK;
+	return pmd_set_protbits(__pmd(pmdv), newprot);
+}
+
+/*
+ * This is called at the end of handling a user page fault, when the
+ * fault has been handled by updating a HUGE PMD entry in the linux page tables.
+ * We use it to preload an HPTE into the hash table corresponding to
+ * the updated linux HUGE PMD entry.
+ */
+void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
+			  pmd_t *pmd)
+{
+	return;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index a11fde8ac274..bb5b4815284a 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -102,35 +102,9 @@ int hlmap_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-/*
- * This is called when relaxing access to a hugepage. It's also called in the page
- * fault path when we don't hit any of the major fault cases, ie, a minor
- * update of _PAGE_ACCESSED, _PAGE_DIRTY, etc... The generic code will have
- * handled those two for us, we additionally deal with missing execute
- * permission here on some processors
- */
-int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
-			  pmd_t *pmdp, pmd_t entry, int dirty)
-{
-	int changed;
-#ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp));
-	assert_spin_locked(&vma->vm_mm->page_table_lock);
-#endif
-	changed = !pmd_same(*(pmdp), entry);
-	if (changed) {
-		__ptep_set_access_flags(pmdp_ptep(pmdp), pmd_pte(entry));
-		/*
-		 * Since we are not supporting SW TLB systems, we don't
-		 * have any thing similar to flush_tlb_page_nohash()
-		 */
-	}
-	return changed;
-}
-
-unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
-				  pmd_t *pmdp, unsigned long clr,
-				  unsigned long set)
+unsigned long hlpmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
+				    pmd_t *pmdp, unsigned long clr,
+				    unsigned long set)
 {
 
 	unsigned long old, tmp;
@@ -163,8 +137,8 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	return old;
 }
 
-pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
-			  pmd_t *pmdp)
+pmd_t hlpmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
+			    pmd_t *pmdp)
 {
 	pmd_t pmd;
 
@@ -203,24 +177,11 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 }
 
 /*
- * We currently remove entries from the hashtable regardless of whether
- * the entry was young or dirty.
- *
- * We should be more intelligent about this but for the moment we override
- * these functions and force a tlb flush unconditionally
- */
-int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long address, pmd_t *pmdp)
-{
-	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
-}
-
-/*
  * We want to put the pgtable in pmd and use pgtable for tracking
  * the base page size hptes
  */
-void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pgtable)
+void hlpgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+				  pgtable_t pgtable)
 {
 	pgtable_t *pgtable_slot;
 	assert_spin_locked(&mm->page_table_lock);
@@ -238,7 +199,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	smp_wmb();
 }
 
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+pgtable_t hlpgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 {
 	pgtable_t pgtable;
 	pgtable_t *pgtable_slot;
@@ -258,8 +219,8 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	return pgtable;
 }
 
-void pmdp_huge_split_prepare(struct vm_area_struct *vma,
-			     unsigned long address, pmd_t *pmdp)
+void hlpmdp_huge_split_prepare(struct vm_area_struct *vma,
+			       unsigned long address, pmd_t *pmdp)
 {
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(REGION_ID(address) != USER_REGION_ID);
@@ -279,39 +240,6 @@ void pmdp_huge_split_prepare(struct vm_area_struct *vma,
 	pmd_hugepage_update(vma->vm_mm, address, pmdp, 0, _PAGE_PRIVILEGED);
 }
 
-
-/*
- * set a new huge pmd. We should not be called for updating
- * an existing pmd entry. That should go via pmd_hugepage_update.
- */
-void set_pmd_at(struct mm_struct *mm, unsigned long addr,
-		pmd_t *pmdp, pmd_t pmd)
-{
-#ifdef CONFIG_DEBUG_VM
-	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
-	assert_spin_locked(&mm->page_table_lock);
-	WARN_ON(!pmd_trans_huge(pmd));
-#endif
-	trace_hugepage_set_pmd(addr, pmd_val(pmd));
-	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
-}
-
-/*
- * We use this to invalidate a pmdp entry before switching from a
- * hugepte to regular pmd entry.
- */
-void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
-		     pmd_t *pmdp)
-{
-	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
-
-	/*
-	 * This ensures that generic code that rely on IRQ disabling
-	 * to prevent a parallel THP split work as expected.
-	 */
-	kick_all_cpus_sync();
-}
-
 /*
  * A linux hugepage PMD was changed and the corresponding hash table entries
  * neesd to be flushed.
@@ -351,47 +279,8 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 	return flush_hash_hugepage(vsid, addr, pmdp, psize, ssize, flags);
 }
 
-static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
-{
-	return __pmd(pmd_val(pmd) | pgprot_val(pgprot));
-}
-
-pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
-{
-	unsigned long pmdv;
-
-	pmdv = (pfn << PAGE_SHIFT) & PTE_RPN_MASK;
-	return pmd_set_protbits(__pmd(pmdv), pgprot);
-}
-
-pmd_t mk_pmd(struct page *page, pgprot_t pgprot)
-{
-	return pfn_pmd(page_to_pfn(page), pgprot);
-}
-
-pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
-{
-	unsigned long pmdv;
-
-	pmdv = pmd_val(pmd);
-	pmdv &= _HPAGE_CHG_MASK;
-	return pmd_set_protbits(__pmd(pmdv), newprot);
-}
-
-/*
- * This is called at the end of handling a user page fault, when the
- * fault has been handled by updating a HUGE PMD entry in the linux page tables.
- * We use it to preload an HPTE into the hash table corresponding to
- * the updated linux HUGE PMD entry.
- */
-void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
-			  pmd_t *pmd)
-{
-	return;
-}
-
-pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pmd_t *pmdp)
+pmd_t hlpmdp_huge_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pmd_t *pmdp)
 {
 	pmd_t old_pmd;
 	pgtable_t pgtable;
@@ -426,7 +315,7 @@ pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 	return old_pmd;
 }
 
-int has_transparent_hugepage(void)
+int hl_has_transparent_hugepage(void)
 {
 
 	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
-- 
2.5.0
