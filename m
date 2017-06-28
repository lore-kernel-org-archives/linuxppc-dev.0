Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wy4zs6q2lzDr47
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 11:32:57 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id e199so6854972pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 18:32:57 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v4 4/6] powerpc/mm: Add devmap support for ppc64
Date: Wed, 28 Jun 2017 11:32:34 +1000
Message-Id: <20170628013236.413-4-oohall@gmail.com>
In-Reply-To: <20170628013236.413-1-oohall@gmail.com>
References: <20170628013236.413-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the devmap bit on PTEs and PMDs for PPC64 Book3S.  This
is used to differentiate device backed memory from transparent huge
pages since they are handled in more or less the same manner by the core
mm code.

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v1 -> v2: Properly differentiate THP and PMD Devmap entries. The
mm core assumes that pmd_trans_huge() and pmd_devmap() are mutually
exclusive and v1 had pmd_trans_huge() being true on a devmap pmd.

v2 -> v3:
	Remove setting of _PAGE_SPECIAL in pmd_mkdevmap()
	Make pud_pfn() a BUILD_BUG()
	Remove unnecessary _PAGE_DEVMAP check in hash__pmd_trans_huge()

v3 -> v4:
	Moved pud_pfn() outside #ifdef THP. This is required to work
	around a build breakage.
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 45 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/radix.h   |  2 +-
 arch/powerpc/mm/hugetlbpage.c                |  2 +-
 arch/powerpc/mm/pgtable-book3s64.c           |  4 +--
 arch/powerpc/mm/pgtable-hash64.c             |  4 ++-
 arch/powerpc/mm/pgtable-radix.c              |  3 +-
 arch/powerpc/mm/pgtable_64.c                 |  2 +-
 7 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 85bc9875c3be..c0737c86a362 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -5,6 +5,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/mmdebug.h>
+#include <linux/bug.h>
 #endif
 
 /*
@@ -79,6 +80,9 @@
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
+#define _PAGE_DEVMAP		_RPAGE_SW1 /* software: ZONE_DEVICE page */
+#define __HAVE_ARCH_PTE_DEVMAP
+
 /*
  * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
  * Instead of fixing all of them, add an alternate define which
@@ -599,6 +603,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_mkdevmap(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
+}
+
+static inline int pte_devmap(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	/* FIXME!! check whether this need to be a conditional */
@@ -1146,6 +1160,37 @@ static inline bool arch_needs_pgtable_deposit(void)
 	return true;
 }
 
+
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)
+{
+	return __pmd(pmd_val(pmd) | (_PAGE_PTE | _PAGE_DEVMAP));
+}
+
+static inline int pmd_devmap(pmd_t pmd)
+{
+	return pte_devmap(pmd_pte(pmd));
+}
+
+static inline int pud_devmap(pud_t pud)
+{
+	return 0;
+}
+
+static inline int pgd_devmap(pgd_t pgd)
+{
+	return 0;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static inline const int pud_pfn(pud_t pud)
+{
+	/*
+	 * Currently all calls to pud_pfn() are gated around a pud_devmap()
+	 * check so this should never be used. If it grows another user we
+	 * want to know about it.
+	 */
+	BUILD_BUG();
+	return 0;
+}
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index ac16d1943022..ba43754e96d2 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -252,7 +252,7 @@ static inline int radix__pgd_bad(pgd_t pgd)
 
 static inline int radix__pmd_trans_huge(pmd_t pmd)
 {
-	return !!(pmd_val(pmd) & _PAGE_PTE);
+	return (pmd_val(pmd) & (_PAGE_PTE | _PAGE_DEVMAP)) == _PAGE_PTE;
 }
 
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index ceeab69cf7fc..5c4645e73cc8 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -945,7 +945,7 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 			if (pmd_none(pmd))
 				return NULL;
 
-			if (pmd_trans_huge(pmd)) {
+			if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
 				if (is_thp)
 					*is_thp = true;
 				ret_pte = (pte_t *) pmdp;
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 5fcb3dd74c13..31eed8fa8e99 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -32,7 +32,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp));
+	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
 	assert_spin_locked(&vma->vm_mm->page_table_lock);
 #endif
 	changed = !pmd_same(*(pmdp), entry);
@@ -59,7 +59,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
 	assert_spin_locked(&mm->page_table_lock);
-	WARN_ON(!pmd_trans_huge(pmd));
+	WARN_ON(!(pmd_trans_huge(pmd) || pmd_devmap(pmd)));
 #endif
 	trace_hugepage_set_pmd(addr, pmd_val(pmd));
 	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 8b85a14b08ea..7456cde4dbce 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -109,7 +109,7 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp));
+	WARN_ON(!hash__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
 	assert_spin_locked(&mm->page_table_lock);
 #endif
 
@@ -141,6 +141,7 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(pmd_trans_huge(*pmdp));
+	VM_BUG_ON(pmd_devmap(*pmdp));
 
 	pmd = *pmdp;
 	pmd_clear(pmdp);
@@ -221,6 +222,7 @@ void hash__pmdp_huge_split_prepare(struct vm_area_struct *vma,
 {
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(REGION_ID(address) != USER_REGION_ID);
+	VM_BUG_ON(pmd_devmap(*pmdp));
 
 	/*
 	 * We can't mark the pmd none here, because that will cause a race
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6c062f92b9e4..5bf40e7ff448 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -691,7 +691,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!radix__pmd_trans_huge(*pmdp));
+	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
 	assert_spin_locked(&mm->page_table_lock);
 #endif
 
@@ -709,6 +709,7 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
+	VM_BUG_ON(pmd_devmap(*pmdp));
 	/*
 	 * khugepaged calls this for normal pmd
 	 */
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 8d2d6742a465..b792ea537b1c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -323,7 +323,7 @@ struct page *pud_page(pud_t pud)
  */
 struct page *pmd_page(pmd_t pmd)
 {
-	if (pmd_trans_huge(pmd) || pmd_huge(pmd))
+	if (pmd_trans_huge(pmd) || pmd_huge(pmd) || pmd_devmap(pmd))
 		return pte_page(pmd_pte(pmd));
 	return virt_to_page(pmd_page_vaddr(pmd));
 }
-- 
2.9.4
