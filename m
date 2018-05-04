Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crzS42QszDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:33:55 +1000 (AEST)
Message-Id: <7f5c8870b0ad4b64cae354ad2e09ebdefa79bd06.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  01/17] powerpc/nohash: remove hash related code from nohash
 headers.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:33:52 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When nohash and book3s header were split, some hash related stuff
remained in the nohash header. This patch removes them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Removed the call to pte_young() as it fails, back to using PAGE_ACCESSED directly.

 arch/powerpc/include/asm/nohash/32/pgtable.h | 29 +++------------------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 16 ++----------
 arch/powerpc/include/asm/nohash/pgtable.h    | 38 +++-------------------------
 arch/powerpc/include/asm/nohash/pte-book3e.h |  1 -
 4 files changed, 10 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 03bbd1149530..140f8e74b478 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -133,7 +133,7 @@ extern int icache_44x_need_flush;
 #ifndef __ASSEMBLY__
 
 #define pte_clear(mm, addr, ptep) \
-	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
+	do { pte_update(ptep, ~0, 0); } while (0)
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
@@ -146,21 +146,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 
 /*
- * When flushing the tlb entry for a page, we also need to flush the hash
- * table entry.  flush_hash_pages is assembler (for speed) in hashtable.S.
- */
-extern int flush_hash_pages(unsigned context, unsigned long va,
-			    unsigned long pmdval, int count);
-
-/* Add an HPTE to the hash table */
-extern void add_hash_page(unsigned context, unsigned long va,
-			  unsigned long pmdval);
-
-/* Flush an entry from the TLB/hash table */
-extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
-			     unsigned long address);
-
-/*
  * PTE updates. This function is called whenever an existing
  * valid PTE is updated. This does -not- include set_pte_at()
  * which nowadays only sets a new PTE.
@@ -246,12 +231,6 @@ static inline int __ptep_test_and_clear_young(unsigned int context, unsigned lon
 {
 	unsigned long old;
 	old = pte_update(ptep, _PAGE_ACCESSED, 0);
-#if _PAGE_HASHPTE != 0
-	if (old & _PAGE_HASHPTE) {
-		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(context, addr, ptephys, 1);
-	}
-#endif
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
@@ -261,7 +240,7 @@ static inline int __ptep_test_and_clear_young(unsigned int context, unsigned lon
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep)
 {
-	return __pte(pte_update(ptep, ~_PAGE_HASHPTE, 0));
+	return __pte(pte_update(ptep, ~0, 0));
 }
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
@@ -289,7 +268,7 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PTE_SAME
-#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
+#define pte_same(A,B)	((pte_val(A) ^ pte_val(B)) == 0)
 
 /*
  * Note that on Book E processors, the pmd contains the kernel virtual
@@ -330,7 +309,7 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 /*
  * Encode and decode a swap entry.
  * Note that the bits we use in a PTE for representing a swap entry
- * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
+ * must not include the _PAGE_PRESENT bit.
  *   -- paulus
  */
 #define __swp_type(entry)		((entry).val & 0x1f)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 5c5f75d005ad..4f6f5a27bfb5 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -173,8 +173,6 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
-extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, unsigned long pte, int huge);
 
 /* Atomic PTE updates */
 static inline unsigned long pte_update(struct mm_struct *mm,
@@ -205,11 +203,6 @@ static inline unsigned long pte_update(struct mm_struct *mm,
 	if (!huge)
 		assert_pte_locked(mm, addr);
 
-#ifdef CONFIG_PPC_BOOK3S_64
-	if (old & _PAGE_HASHPTE)
-		hpte_need_flush(mm, addr, ptep, old, huge);
-#endif
-
 	return old;
 }
 
@@ -218,7 +211,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if ((pte_val(*ptep) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
+	if ((pte_val(*ptep) & _PAGE_ACCESSED) == 0)
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
@@ -312,7 +305,7 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PTE_SAME
-#define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
+#define pte_same(A,B)	((pte_val(A) ^ pte_val(B)) == 0)
 
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
@@ -324,11 +317,6 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 /* Encode and de-code a swap entry */
 #define MAX_SWAPFILES_CHECK() do { \
 	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
-	/*							\
-	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
-	 * We filter HPTEFLAGS on set_pte.			\
-	 */							\
-	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
 	} while (0)
 /*
  * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index c56de1e8026f..f2fe3cbe90af 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -148,37 +148,16 @@ extern void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, int percpu)
 {
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
+#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
 	/* Second case is 32-bit with 64-bit PTE.  In this case, we
 	 * can just store as long as we do the two halves in the right order
-	 * with a barrier in between. This is possible because we take care,
-	 * in the hash code, to pre-invalidate if the PTE was already hashed,
-	 * which synchronizes us with any concurrent invalidation.
-	 * In the percpu case, we also fallback to the simple update preserving
-	 * the hash bits
+	 * with a barrier in between.
+	 * In the percpu case, we also fallback to the simple update
 	 */
 	if (percpu) {
-		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-			      | (pte_val(pte) & ~_PAGE_HASHPTE));
+		*ptep = pte;
 		return;
 	}
-#if _PAGE_HASHPTE != 0
-	if (pte_val(*ptep) & _PAGE_HASHPTE)
-		flush_hash_entry(mm, ptep, addr);
-#endif
 	__asm__ __volatile__("\
 		stw%U0%X0 %2,%0\n\
 		eieio\n\
@@ -186,15 +165,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
 	: "r" (pte) : "memory");
 
-#elif defined(CONFIG_PPC_STD_MMU_32)
-	/* Third case is 32-bit hash table in UP mode, we need to preserve
-	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
-	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
-	 * and see we need to keep track that this PTE needs invalidating
-	 */
-	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-		      | (pte_val(pte) & ~_PAGE_HASHPTE));
-
 #else
 	/* Anything else just stores the PTE normally. That covers all 64-bit
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index ccee8eb509bb..9ff51b4c0cac 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -57,7 +57,6 @@
 #define _PAGE_USER		(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
 #define _PAGE_PRIVILEGED	(_PAGE_BAP_SR)
 
-#define _PAGE_HASHPTE	0
 #define _PAGE_BUSY	0
 
 #define _PAGE_SPECIAL	_PAGE_SW0
-- 
2.13.3
