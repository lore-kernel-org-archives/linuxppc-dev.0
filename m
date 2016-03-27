Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqqG37JGzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:30 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:28 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 44D513E40030
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:26 -0600 (MDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PPKL35717360
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:25:25 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8K8G9022293
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:20:09 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 27/65] powerpc/mm: Move hugetlb and THP related pmd accessors
 to pgtable.h
Date: Sun, 27 Mar 2016 13:53:35 +0530
Message-Id: <1459067053-10835-27-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here we create pgtable-64/4k.h and move pmd accessors that is common
between hash and radix there. We can't do much sharing with 4k linux
page size [1]. So for now it is empty. In later patches we will add
functions that does conditional hash/radix accessors there.

[1] 4k linux page size with hash config don't support THP.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    | 83 ---------------------
 arch/powerpc/include/asm/book3s/64/pgtable-4k.h  |  7 ++
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 94 ++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h     |  7 ++
 4 files changed, 108 insertions(+), 83 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable-64k.h

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index d60c431c96cb..173f35e9faef 100644
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
 	return (((pmd_val(pmd_a) ^ pmd_val(pmd_b)) & ~_PAGE_HPTEFLAGS) == 0);
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
index 18855437894f..e3a8fc469460 100644
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
