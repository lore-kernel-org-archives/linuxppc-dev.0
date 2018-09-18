Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8LN3qYNzF3FZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:32 +1000 (AEST)
Message-Id: <46776b09cde72f00997b7109c7ef0c50cc47c3ec.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 13/20] powerpc/book3s32: Remove CONFIG_BOOKE dependent code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:28 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

BOOK3S/32 cannot be BOOKE, so remove useless code

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 18 ------------------
 arch/powerpc/include/asm/book3s/32/pgtable.h | 14 --------------
 2 files changed, 32 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 701748132442..2639b4b7d67c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -47,8 +47,6 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 #define __pmd_free_tlb(tlb,x,a)		do { } while (0)
 /* #define pgd_populate(mm, pmd, pte)      BUG() */
 
-#ifndef CONFIG_BOOKE
-
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 				       pte_t *pte)
 {
@@ -62,22 +60,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 }
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
-#else
-
-static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
-				       pte_t *pte)
-{
-	*pmdp = __pmd((unsigned long)pte | _PMD_PRESENT);
-}
-
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pte_page)
-{
-	*pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | _PMD_PRESENT);
-}
-
-#define pmd_pgtable(pmd) pmd_page(pmd)
-#endif
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 5ffb7e3b211f..7a8a590f6b4c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -334,24 +334,10 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HASHPTE) == 0)
 
-/*
- * Note that on Book E processors, the pmd contains the kernel virtual
- * (lowmem) address of the pte page.  The physical address is less useful
- * because everything runs with translation enabled (even the TLB miss
- * handler).  On everything else the pmd contains the physical address
- * of the pte page.  -- paulus
- */
-#ifndef CONFIG_BOOKE
 #define pmd_page_vaddr(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
 	pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
-#else
-#define pmd_page_vaddr(pmd)	\
-	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
-#define pmd_page(pmd)		\
-	pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
-#endif
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
-- 
2.13.3
