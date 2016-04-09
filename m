Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmKJ5dyhzDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:15:32 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:15:31 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B471B3E4001C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:15:28 -0600 (MDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396FSbE37486612
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:15:28 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396FRNW021782
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:15:27 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 24/68] powerpc/mm: Move page table index and and vaddr to
 pgtable.h
Date: Sat,  9 Apr 2016 11:43:20 +0530
Message-Id: <1460182444-2468-25-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index f30f40443343..3e64a7b13036 100644
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
