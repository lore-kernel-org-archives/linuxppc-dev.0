Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F8LJ2Z9GzF3Fw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 02:57:28 +1000 (AEST)
Message-Id: <9f7d38d6928b00f53f61717884305ac30278237b.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 11/20] powerpc/mm: don't use pte_alloc_one_kernel() before
 slab is available
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 18 Sep 2018 16:57:24 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the same way as PPC64, let's handle pte allocation directly
in kernel_map_page() when slab is not available.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 5877f5aa8f5d..6c8a07624773 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -43,18 +43,9 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-__ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte;
-
-	if (slab_is_available()) {
-		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	} else {
-		pte = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
-		if (pte)
-			clear_page(pte);
-	}
-	return pte;
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 
 pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -222,7 +213,21 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
+static __init pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
+{
+	if (!pmd_present(*pmdp)) {
+		pte_t *ptep = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
+
+		if (!ptep)
+			return NULL;
+
+		clear_page(ptep);
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+	}
+	return pte_offset_kernel(pmdp, va);
+}
+
+__ref int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 {
 	pmd_t *pd;
 	pte_t *pg;
@@ -231,7 +236,10 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 	/* Use upper 10 bits of VA to index the first level map */
 	pd = pmd_offset(pud_offset(pgd_offset_k(va), va), va);
 	/* Use middle 10 bits of VA to index the second-level map */
-	pg = pte_alloc_kernel(pd, va);
+	if (slab_is_available())
+		pg = pte_alloc_kernel(pd, va);
+	else
+		pg = early_pte_alloc_kernel(pd, va);
 	if (pg != 0) {
 		err = 0;
 		/* The PTE should never be already set nor present in the
-- 
2.13.3
