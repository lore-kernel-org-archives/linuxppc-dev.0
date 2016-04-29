Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy037NtzDqBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 25/70] powerpc/mm: Move pte accessors that operate on
 common pte bits to pgtable.h
Date: Fri, 29 Apr 2016 23:25:48 +1000
Message-Id: <1461936393-10131-25-git-send-email-mpe@ellerman.id.au>
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

These pte functions will remain the same between radix and hash. Move
them to pgtable.h.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 205 --------------------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 209 +++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 205 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 19f9e6ea46f4..04c004d62f49 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -135,66 +135,6 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	return old;
 }
 
-/*
- * We currently remove entries from the hashtable regardless of whether
- * the entry was young or dirty.
- *
- * We should be more intelligent about this but for the moment we override
- * these functions and force a tlb flush unconditionally
- */
-static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pte_t *ptep)
-{
-	unsigned long old;
-
-	if ((pte_val(*ptep) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
-		return 0;
-	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
-	return (old & _PAGE_ACCESSED) != 0;
-}
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define ptep_test_and_clear_young(__vma, __addr, __ptep)		   \
-({									   \
-	int __r;							   \
-	__r = __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep); \
-	__r;								   \
-})
-
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
-				      pte_t *ptep)
-{
-
-	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
-		return;
-
-	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
-}
-
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
-		return;
-
-	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
-}
-
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long addr, pte_t *ptep)
-{
-	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, 0);
-	return __pte(old);
-}
-
-static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
-			     pte_t * ptep)
-{
-	pte_update(mm, addr, ptep, ~0UL, 0, 0);
-}
-
-
 /* Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to flush the hash entry
  */
@@ -237,112 +177,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 
 
 /* Generic accessors to PTE bits */
-static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);}
-static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
-static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
-static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0; }
-static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
-
-#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-static inline bool pte_soft_dirty(pte_t pte)
-{
-	return !!(pte_val(pte) & _PAGE_SOFT_DIRTY);
-}
-static inline pte_t pte_mksoft_dirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
-}
-
-static inline pte_t pte_clear_soft_dirty(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_SOFT_DIRTY);
-}
-#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
-
-#ifdef CONFIG_NUMA_BALANCING
-/*
- * These work without NUMA balancing but the kernel does not care. See the
- * comment in include/asm-generic/pgtable.h . On powerpc, this will only
- * work for user pages and always return true for kernel pages.
- */
-static inline int pte_protnone(pte_t pte)
-{
-	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
-		(_PAGE_PRESENT | _PAGE_PRIVILEGED);
-}
-#endif /* CONFIG_NUMA_BALANCING */
-
-static inline int pte_present(pte_t pte)
-{
-	return !!(pte_val(pte) & _PAGE_PRESENT);
-}
-
-/* Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- *
- * Even if PTEs can be unsigned long long, a PFN is always an unsigned
- * long for now.
- */
-static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
-{
-	return __pte((((pte_basic_t)(pfn) << PAGE_SHIFT) & PTE_RPN_MASK) |
-		     pgprot_val(pgprot));
-}
-
-static inline unsigned long pte_pfn(pte_t pte)
-{
-	return (pte_val(pte) & PTE_RPN_MASK) >> PAGE_SHIFT;
-}
-
-/* Generic modifiers for PTE bits */
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_WRITE);
-}
-
-static inline pte_t pte_mkclean(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
-}
-
-static inline pte_t pte_mkold(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
-}
-
-static inline pte_t pte_mkwrite(pte_t pte)
-{
-	/*
-	 * write implies read, hence set both
-	 */
-	return __pte(pte_val(pte) | _PAGE_RW);
-}
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
-}
-
-static inline pte_t pte_mkyoung(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
-}
-
-static inline pte_t pte_mkspecial(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_SPECIAL);
-}
-
-static inline pte_t pte_mkhuge(pte_t pte)
-{
-	return pte;
-}
-
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-{
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
-}
 
 /* This low level function performs the actual PTE insertion
  * Setting the PTE depends on the MMU type and other factors. It's
@@ -359,46 +194,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	*ptep = pte;
 }
 
-#define _PAGE_CACHE_CTL	(_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
-
-#define pgprot_noncached pgprot_noncached
-static inline pgprot_t pgprot_noncached(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_NON_IDEMPOTENT);
-}
-
-#define pgprot_noncached_wc pgprot_noncached_wc
-static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_TOLERANT);
-}
-
-#define pgprot_cached pgprot_cached
-static inline pgprot_t pgprot_cached(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL));
-}
-
-#define pgprot_writecombine pgprot_writecombine
-static inline pgprot_t pgprot_writecombine(pgprot_t prot)
-{
-	return pgprot_noncached_wc(prot);
-}
-/*
- * check a pte mapping have cache inhibited property
- */
-static inline bool pte_ci(pte_t pte)
-{
-	unsigned long pte_v = pte_val(pte);
-
-	if (((pte_v & _PAGE_CACHE_CTL) == _PAGE_TOLERANT) ||
-	    ((pte_v & _PAGE_CACHE_CTL) == _PAGE_NON_IDEMPOTENT))
-		return true;
-	return false;
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp, unsigned long old_pmd);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 47e2e7750eae..7ec176674b78 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -201,6 +201,215 @@
 
 #endif /* __real_pte */
 
+/*
+ * For hash even if we have _PAGE_ACCESSED = 0, we do a pte_update.
+ * We currently remove entries from the hashtable regardless of whether
+ * the entry was young or dirty.
+ *
+ * We should be more intelligent about this but for the moment we override
+ * these functions and force a tlb flush unconditionally
+ * For radix: H_PAGE_HASHPTE should be zero. Hence we can use the same
+ * function for both hash and radix.
+ */
+static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
+					      unsigned long addr, pte_t *ptep)
+{
+	unsigned long old;
+
+	if ((pte_val(*ptep) & (_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
+		return 0;
+	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
+	return (old & _PAGE_ACCESSED) != 0;
+}
+
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define ptep_test_and_clear_young(__vma, __addr, __ptep)	\
+({								\
+	int __r;						\
+	__r = __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep); \
+	__r;							\
+})
+
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep)
+{
+
+	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
+		return;
+
+	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	if ((pte_val(*ptep) & _PAGE_WRITE) == 0)
+		return;
+
+	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
+}
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long addr, pte_t *ptep)
+{
+	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, 0);
+	return __pte(old);
+}
+
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
+			     pte_t * ptep)
+{
+	pte_update(mm, addr, ptep, ~0UL, 0, 0);
+}
+static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_WRITE);}
+static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
+static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
+static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
+static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
+
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline bool pte_soft_dirty(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_SOFT_DIRTY);
+}
+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_SOFT_DIRTY);
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
+#ifdef CONFIG_NUMA_BALANCING
+/*
+ * These work without NUMA balancing but the kernel does not care. See the
+ * comment in include/asm-generic/pgtable.h . On powerpc, this will only
+ * work for user pages and always return true for kernel pages.
+ */
+static inline int pte_protnone(pte_t pte)
+{
+	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PRIVILEGED)) ==
+		(_PAGE_PRESENT | _PAGE_PRIVILEGED);
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
+static inline int pte_present(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_PRESENT);
+}
+/*
+ * Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ *
+ * Even if PTEs can be unsigned long long, a PFN is always an unsigned
+ * long for now.
+ */
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	return __pte((((pte_basic_t)(pfn) << PAGE_SHIFT) & PTE_RPN_MASK) |
+		     pgprot_val(pgprot));
+}
+
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return (pte_val(pte) & PTE_RPN_MASK) >> PAGE_SHIFT;
+}
+
+/* Generic modifiers for PTE bits */
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_WRITE);
+}
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkold(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	/*
+	 * write implies read, hence set both
+	 */
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_mkspecial(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+}
+
+static inline pte_t pte_mkhuge(pte_t pte)
+{
+	return pte;
+}
+
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	/* FIXME!! check whether this need to be a conditional */
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
+
+#define _PAGE_CACHE_CTL	(_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
+
+#define pgprot_noncached pgprot_noncached
+static inline pgprot_t pgprot_noncached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_NON_IDEMPOTENT);
+}
+
+#define pgprot_noncached_wc pgprot_noncached_wc
+static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_TOLERANT);
+}
+
+#define pgprot_cached pgprot_cached
+static inline pgprot_t pgprot_cached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL));
+}
+
+#define pgprot_writecombine pgprot_writecombine
+static inline pgprot_t pgprot_writecombine(pgprot_t prot)
+{
+	return pgprot_noncached_wc(prot);
+}
+/*
+ * check a pte mapping have cache inhibited property
+ */
+static inline bool pte_ci(pte_t pte)
+{
+	unsigned long pte_v = pte_val(pte);
+
+	if (((pte_v & _PAGE_CACHE_CTL) == _PAGE_TOLERANT) ||
+	    ((pte_v & _PAGE_CACHE_CTL) == _PAGE_NON_IDEMPOTENT))
+		return true;
+	return false;
+}
+
 static inline void pmd_set(pmd_t *pmdp, unsigned long val)
 {
 	*pmdp = __pmd(val);
-- 
2.5.0
