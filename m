Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy6722kzDqBF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 32/70] powerpc/mm: Move hugetlb and THP related pmd
 accessors to pgtable.h
Date: Fri, 29 Apr 2016 23:25:55 +1000
Message-Id: <1461936393-10131-32-git-send-email-mpe@ellerman.id.au>
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

Here we create pgtable-64/4k.h and move pmd accessors that are common
between hash and radix there. We can't do much sharing with 4K Linux
page size because 4K Linux page size with hash config doesn't support
THP. So for now it is empty. In later patches we will add functions that
does conditional hash/radix accessors there.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    | 83 ---------------------
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h  |  7 ++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 94 ++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h     |  7 ++
 4 files changed, 108 insertions(+), 83 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-64k.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 7d2a9b6a55ca..d4e1f1f5322f 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -118,57 +118,6 @@ static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
 #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
 #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 
-#ifdef CONFIG_HUGETLB_PAGE
-/*
- * We have PGD_INDEX_SIZ = 12 and PTE_INDEX_SIZE = 8, so that we can have
- * 16GB hugepage pte in PGD and 16MB hugepage pte at PMD;
- *
- * Defined in such a way that we can optimize away code block at build time
- * if CONFIG_HUGETLB_PAGE=n.
- */
-static inline int pmd_huge(pmd_t pmd)
-{
-	/*
-	 * leaf pte for huge page
-	 */
-	return !!(pmd_val(pmd) & _PAGE_PTE);
-}
-
-static inline int pud_huge(pud_t pud)
-{
-	/*
-	 * leaf pte for huge page
-	 */
-	return !!(pud_val(pud) & _PAGE_PTE);
-}
-
-static inline int pgd_huge(pgd_t pgd)
-{
-	/*
-	 * leaf pte for huge page
-	 */
-	return !!(pgd_val(pgd) & _PAGE_PTE);
-}
-#define pgd_huge pgd_huge
-
-#ifdef CONFIG_DEBUG_VM
-extern int hugepd_ok(hugepd_t hpd);
-#define is_hugepd(hpd)               (hugepd_ok(hpd))
-#else
-/*
- * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't
- * need to setup hugepage directory for them. Our pte and page directory format
- * enable us to have this enabled.
- */
-static inline int hugepd_ok(hugepd_t hpd)
-{
-	return 0;
-}
-#define is_hugepd(pdep)			0
-#endif /* CONFIG_DEBUG_VM */
-
-#endif /* CONFIG_HUGETLB_PAGE */
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern unsigned long pmd_hugepage_update(struct mm_struct *mm,
 					 unsigned long addr,
@@ -239,44 +188,12 @@ static inline int pmd_trans_huge(pmd_t pmd)
 		  (_PAGE_PTE | H_PAGE_THP_HUGE));
 }
 
-static inline int pmd_large(pmd_t pmd)
-{
-	return !!(pmd_val(pmd) & _PAGE_PTE);
-}
-
-static inline pmd_t pmd_mknotpresent(pmd_t pmd)
-{
-	return __pmd(pmd_val(pmd) & ~_PAGE_PRESENT);
-}
-
 #define __HAVE_ARCH_PMD_SAME
 static inline int pmd_same(pmd_t pmd_a, pmd_t pmd_b)
 {
 	return (((pmd_raw(pmd_a) ^ pmd_raw(pmd_b)) & ~cpu_to_be64(_PAGE_HPTEFLAGS)) == 0);
 }
 
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
 #endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-4k.h b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
new file mode 100644
index 000000000000..423735f897f5
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-4k.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H
+#define _ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H
+/*
+ * hash 4k can't share hugetlb and also doesn't support THP
+ */
+
+#endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
new file mode 100644
index 000000000000..ceadc2fd408f
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -0,0 +1,94 @@
+#ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H
+#define _ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H
+
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_HUGETLB_PAGE
+/*
+ * We have PGD_INDEX_SIZ = 12 and PTE_INDEX_SIZE = 8, so that we can have
+ * 16GB hugepage pte in PGD and 16MB hugepage pte at PMD;
+ *
+ * Defined in such a way that we can optimize away code block at build time
+ * if CONFIG_HUGETLB_PAGE=n.
+ */
+static inline int pmd_huge(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page
+	 */
+	return !!(pmd_val(pmd) & _PAGE_PTE);
+}
+
+static inline int pud_huge(pud_t pud)
+{
+	/*
+	 * leaf pte for huge page
+	 */
+	return !!(pud_val(pud) & _PAGE_PTE);
+}
+
+static inline int pgd_huge(pgd_t pgd)
+{
+	/*
+	 * leaf pte for huge page
+	 */
+	return !!(pgd_val(pgd) & _PAGE_PTE);
+}
+#define pgd_huge pgd_huge
+
+#ifdef CONFIG_DEBUG_VM
+extern int hugepd_ok(hugepd_t hpd);
+#define is_hugepd(hpd)               (hugepd_ok(hpd))
+#else
+/*
+ * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't
+ * need to setup hugepage directory for them. Our pte and page directory format
+ * enable us to have this enabled.
+ */
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	return 0;
+}
+#define is_hugepd(pdep)			0
+#endif /* CONFIG_DEBUG_VM */
+
+#endif /* CONFIG_HUGETLB_PAGE */
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
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
+}
+
+#endif /*  CONFIG_TRANSPARENT_HUGEPAGE */
+#endif	/* __ASSEMBLY__ */
+#endif /*_ASM_POWERPC_BOOK3S_64_PGTABLE_64K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index bb0639a8c250..a22b47844f2f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -206,6 +206,13 @@ extern unsigned long __pgd_table_size;
 
 #include <asm/book3s/64/hash.h>
 #include <asm/book3s/64/radix.h>
+
+#ifdef CONFIG_PPC_64K_PAGES
+#include <asm/book3s/64/pgtable-64k.h>
+#else
+#include <asm/book3s/64/pgtable-4k.h>
+#endif
+
 #include <asm/barrier.h>
 
 /*
-- 
2.5.0
