Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A19BE1A074F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:33 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9921B3940060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:29 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIeTf55701966
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:29 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIeSmL013481
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 12/31] powerpc/mm: Move PTE bits from generic functions to
 hash64 functions.
Date: Tue, 13 Oct 2015 00:09:56 +0530
Message-Id: <1444675215-19484-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

functions which operate on pte bits are moved to hash*.h and other
generic functions are moved to pgtable.h

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 177 ++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/hash.h    | 144 +++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h |   6 +
 arch/powerpc/include/asm/book3s/pgtable.h    | 198 ---------------------------
 4 files changed, 327 insertions(+), 198 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 9e47515b2e01..affcbfc14e3a 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -294,6 +294,183 @@ void pgtable_cache_init(void);
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep,
 		      pmd_t **pmdp);
 
+/* Generic accessors to PTE bits */
+static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
+static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
+static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
+static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
+static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
+
+static inline int pte_present(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_PRESENT;
+}
+
+/* Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ *
+ * Even if PTEs can be unsigned long long, a PFN is always an unsigned
+ * long for now.
+ */
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
+		     pgprot_val(pgprot));
+}
+
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return pte_val(pte) >> PTE_RPN_SHIFT;
+}
+
+/* Generic modifiers for PTE bits */
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_RW);
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
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
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
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
+
+
+
+/* This low level function performs the actual PTE insertion
+ * Setting the PTE depends on the MMU type and other factors. It's
+ * an horrible mess that I'm not going to try to clean up now but
+ * I'm keeping it in one place rather than spread around
+ */
+static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, int percpu)
+{
+#if defined(CONFIG_PPC_STD_MMU_32) && defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
+	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
+	 * helper pte_update() which does an atomic update. We need to do that
+	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
+	 * per-CPU PTE such as a kmap_atomic, we do a simple update preserving
+	 * the hash bits instead (ie, same as the non-SMP case)
+	 */
+	if (percpu)
+		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
+			      | (pte_val(pte) & ~_PAGE_HASHPTE));
+	else
+		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
+
+#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+	/* Second case is 32-bit with 64-bit PTE.  In this case, we
+	 * can just store as long as we do the two halves in the right order
+	 * with a barrier in between. This is possible because we take care,
+	 * in the hash code, to pre-invalidate if the PTE was already hashed,
+	 * which synchronizes us with any concurrent invalidation.
+	 * In the percpu case, we also fallback to the simple update preserving
+	 * the hash bits
+	 */
+	if (percpu) {
+		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
+			      | (pte_val(pte) & ~_PAGE_HASHPTE));
+		return;
+	}
+	if (pte_val(*ptep) & _PAGE_HASHPTE)
+		flush_hash_entry(mm, ptep, addr);
+	__asm__ __volatile__("\
+		stw%U0%X0 %2,%0\n\
+		eieio\n\
+		stw%U0%X0 %L2,%1"
+	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
+	: "r" (pte) : "memory");
+
+#elif defined(CONFIG_PPC_STD_MMU_32)
+	/* Third case is 32-bit hash table in UP mode, we need to preserve
+	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
+	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
+	 * and see we need to keep track that this PTE needs invalidating
+	 */
+	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
+		      | (pte_val(pte) & ~_PAGE_HASHPTE));
+
+#else
+#error "Not supported "
+#endif
+}
+
+/*
+ * Macro to mark a page protection value as "uncacheable".
+ */
+
+#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU)
+
+static inline pgprot_t pgprot_noncached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_NO_CACHE | _PAGE_GUARDED);
+}
+
+static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_NO_CACHE);
+}
+
+static inline pgprot_t pgprot_cached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_COHERENT);
+}
+
+static inline pgprot_t pgprot_cached_wthru(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_COHERENT | _PAGE_WRITETHRU);
+}
+
+static inline pgprot_t pgprot_cached_noncoherent(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
+}
+
+static inline pgprot_t pgprot_writecombine(pgprot_t prot)
+{
+	return pgprot_noncached_wc(prot);
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_PPC32_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 954062beca9e..5416d71db08e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -485,6 +485,150 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	pmd_hugepage_update(mm, addr, pmdp, _PAGE_RW, 0);
 }
 
+/* Generic accessors to PTE bits */
+static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
+static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
+static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
+static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
+static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
+
+#ifdef CONFIG_NUMA_BALANCING
+/*
+ * These work without NUMA balancing but the kernel does not care. See the
+ * comment in include/asm-generic/pgtable.h . On powerpc, this will only
+ * work for user pages and always return true for kernel pages.
+ */
+static inline int pte_protnone(pte_t pte)
+{
+	return (pte_val(pte) &
+		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
+static inline int pte_present(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_PRESENT;
+}
+
+/* Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ *
+ * Even if PTEs can be unsigned long long, a PFN is always an unsigned
+ * long for now.
+ */
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
+		     pgprot_val(pgprot));
+}
+
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return pte_val(pte) >> PTE_RPN_SHIFT;
+}
+
+/* Generic modifiers for PTE bits */
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_RW);
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
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
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
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+}
+
+/* This low level function performs the actual PTE insertion
+ * Setting the PTE depends on the MMU type and other factors. It's
+ * an horrible mess that I'm not going to try to clean up now but
+ * I'm keeping it in one place rather than spread around
+ */
+static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, int percpu)
+{
+	/*
+	 * Anything else just stores the PTE normally. That covers all 64-bit
+	 * cases, and 32-bit non-hash with 32-bit PTEs.
+	 */
+	*ptep = pte;
+}
+/*
+ * Macro to mark a page protection value as "uncacheable".
+ */
+
+#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU)
+
+static inline pgprot_t pgprot_noncached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_NO_CACHE | _PAGE_GUARDED);
+}
+
+static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_NO_CACHE);
+}
+
+static inline pgprot_t pgprot_cached(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_COHERENT);
+}
+
+static inline pgprot_t pgprot_cached_wthru(pgprot_t prot)
+{
+	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
+			_PAGE_COHERENT | _PAGE_WRITETHRU);
+}
+
+static inline pgprot_t pgprot_cached_noncoherent(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
+}
+
+static inline pgprot_t pgprot_writecombine(pgprot_t prot)
+{
+	return pgprot_noncached_wc(prot);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp, unsigned long old_pmd);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index aac630b4a15e..f2ace2cac7bb 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -201,6 +201,12 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+#ifdef CONFIG_NUMA_BALANCING
+static inline int pmd_protnone(pmd_t pmd)
+{
+	return pte_protnone(pmd_pte(pmd));
+}
+#endif /* CONFIG_NUMA_BALANCING */
 
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index e156a6c9d84c..8b0f4a29259a 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -9,215 +9,17 @@
 
 #define FIRST_USER_ADDRESS	0UL
 #ifndef __ASSEMBLY__
-
-/* Generic accessors to PTE bits */
-static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_RW);}
-static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY); }
-static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
-static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
-static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
-static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
-
-#ifdef CONFIG_NUMA_BALANCING
-/*
- * These work without NUMA balancing but the kernel does not care. See the
- * comment in include/asm-generic/pgtable.h . On powerpc, this will only
- * work for user pages and always return true for kernel pages.
- */
-static inline int pte_protnone(pte_t pte)
-{
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
-}
-
-static inline int pmd_protnone(pmd_t pmd)
-{
-	return pte_protnone(pmd_pte(pmd));
-}
-#endif /* CONFIG_NUMA_BALANCING */
-
-static inline int pte_present(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_PRESENT;
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
-	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
-		     pgprot_val(pgprot));
-}
-
-static inline unsigned long pte_pfn(pte_t pte)
-{
-	return pte_val(pte) >> PTE_RPN_SHIFT;
-}
-
-/* Generic modifiers for PTE bits */
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_RW);
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
-	return __pte(pte_val(pte) | _PAGE_RW);
-}
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
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
-
-
 /* Insert a PTE, top-level function is out of line. It uses an inline
  * low level function in the respective pgtable-* files
  */
 extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		       pte_t pte);
 
-/* This low level function performs the actual PTE insertion
- * Setting the PTE depends on the MMU type and other factors. It's
- * an horrible mess that I'm not going to try to clean up now but
- * I'm keeping it in one place rather than spread around
- */
-static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte, int percpu)
-{
-#if defined(CONFIG_PPC_STD_MMU_32) && defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
-	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
-	 * helper pte_update() which does an atomic update. We need to do that
-	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
-	 * per-CPU PTE such as a kmap_atomic, we do a simple update preserving
-	 * the hash bits instead (ie, same as the non-SMP case)
-	 */
-	if (percpu)
-		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-			      | (pte_val(pte) & ~_PAGE_HASHPTE));
-	else
-		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
-
-#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
-	/* Second case is 32-bit with 64-bit PTE.  In this case, we
-	 * can just store as long as we do the two halves in the right order
-	 * with a barrier in between. This is possible because we take care,
-	 * in the hash code, to pre-invalidate if the PTE was already hashed,
-	 * which synchronizes us with any concurrent invalidation.
-	 * In the percpu case, we also fallback to the simple update preserving
-	 * the hash bits
-	 */
-	if (percpu) {
-		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-			      | (pte_val(pte) & ~_PAGE_HASHPTE));
-		return;
-	}
-	if (pte_val(*ptep) & _PAGE_HASHPTE)
-		flush_hash_entry(mm, ptep, addr);
-	__asm__ __volatile__("\
-		stw%U0%X0 %2,%0\n\
-		eieio\n\
-		stw%U0%X0 %L2,%1"
-	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
-	: "r" (pte) : "memory");
-
-#elif defined(CONFIG_PPC_STD_MMU_32)
-	/* Third case is 32-bit hash table in UP mode, we need to preserve
-	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
-	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
-	 * and see we need to keep track that this PTE needs invalidating
-	 */
-	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-		      | (pte_val(pte) & ~_PAGE_HASHPTE));
-
-#else
-	/* Anything else just stores the PTE normally. That covers all 64-bit
-	 * cases, and 32-bit non-hash with 32-bit PTEs.
-	 */
-	*ptep = pte;
-#endif
-}
-
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 				 pte_t *ptep, pte_t entry, int dirty);
 
-/*
- * Macro to mark a page protection value as "uncacheable".
- */
-
-#define _PAGE_CACHE_CTL	(_PAGE_COHERENT | _PAGE_GUARDED | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU)
-
-static inline pgprot_t pgprot_noncached(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_NO_CACHE | _PAGE_GUARDED);
-}
-
-static inline pgprot_t pgprot_noncached_wc(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_NO_CACHE);
-}
-
-static inline pgprot_t pgprot_cached(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_COHERENT);
-}
-
-static inline pgprot_t pgprot_cached_wthru(pgprot_t prot)
-{
-	return __pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) |
-			_PAGE_COHERENT | _PAGE_WRITETHRU);
-}
-
-static inline pgprot_t pgprot_cached_noncoherent(pgprot_t prot)
-{
-	return __pgprot(pgprot_val(prot) & ~_PAGE_CACHE_CTL);
-}
-
-static inline pgprot_t pgprot_writecombine(pgprot_t prot)
-{
-	return pgprot_noncached_wc(prot);
-}
-
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
-- 
2.5.0
