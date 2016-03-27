Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqq41zCXzDqFX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:20 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:25:18 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3F1F5C90041
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:25:10 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PETc22872104
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:25:14 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8JvHS022155
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:19:57 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 22/65] powerpc/mm: Move page table index and and vaddr to
 pgtable.h
Date: Sun, 27 Mar 2016 13:53:30 +0530
Message-Id: <1459067053-10835-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Now that the page table size is a variable, we can move these to
generic pgtable.h

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 15 ---------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 9485797f4468..833a897a0794 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -93,18 +93,8 @@
 
 #ifndef __ASSEMBLY__
 #define	pmd_bad(pmd)		(pmd_val(pmd) & PMD_BAD_BITS)
-#define pmd_page_vaddr(pmd)	__va(pmd_val(pmd) & ~PMD_MASKED_BITS)
 
 #define	pud_bad(pud)		(pud_val(pud) & PUD_BAD_BITS)
-#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
-
-/* Pointers in the page table tree are physical addresses */
-#define __pgtable_ptr_val(ptr)	__pa(ptr)
-
-#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
-#define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
-#define pmd_index(address) (((address) >> (PMD_SHIFT)) & (PTRS_PER_PMD - 1))
-#define pte_index(address) (((address) >> (PAGE_SHIFT)) & (PTRS_PER_PTE - 1))
 
 extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, unsigned long pte, int huge);
@@ -177,11 +167,6 @@ static inline int pgd_bad(pgd_t pgd)
 
 #define __HAVE_ARCH_PTE_SAME
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
-static inline unsigned long pgd_page_vaddr(pgd_t pgd)
-{
-	return (unsigned long)__va(pgd_val(pgd) & ~PGD_MASKED_BITS);
-}
-
 
 /* Generic accessors to PTE bits */
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0; }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index ef080bd5fce7..b4d72ab609df 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -534,6 +534,18 @@ static inline pgd_t pte_pgd(pte_t pte)
 
 extern struct page *pgd_page(pgd_t pgd);
 
+/* Pointers in the page table tree are physical addresses */
+#define __pgtable_ptr_val(ptr)	__pa(ptr)
+
+#define pmd_page_vaddr(pmd)	__va(pmd_val(pmd) & ~PMD_MASKED_BITS)
+#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
+#define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
+
+#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
+#define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
+#define pmd_index(address) (((address) >> (PMD_SHIFT)) & (PTRS_PER_PMD - 1))
+#define pte_index(address) (((address) >> (PAGE_SHIFT)) & (PTRS_PER_PTE - 1))
+
 /*
  * Find an entry in a page-table-directory.  We combine the address region
  * (the high order N bits) and the pgd portion of the address.
-- 
2.5.0
