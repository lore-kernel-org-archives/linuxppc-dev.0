Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 2A9341A09CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 05:01:16 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH 2/4] powerpc32: properly clear page table when 0 is not a good
 default PTE value
Message-Id: <20141210180037.C46001A5D62@localhost.localdomain>
Date: Wed, 10 Dec 2014 19:00:37 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some HW invert some PTE bits. In some case, __pte(0) is not 0 so the PTEs shall
be properly set prior to being used.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/mm/pgtable_32.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a349089..71a2821 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -96,6 +96,14 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 #endif
 }
 
+static inline void pte_alloc_clear(pte_t *pte)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		pte[i] = __pte(0);
+}
+
 __init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte;
@@ -109,18 +117,24 @@ __init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long add
 		if (pte)
 			clear_page(pte);
 	}
+	if (pte && !pte_none(*pte))
+		pte_alloc_clear(pte);
 	return pte;
 }
 
 pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *ptepage;
+	pte_t *pte;
 
 	gfp_t flags = GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO;
 
 	ptepage = alloc_pages(flags, 0);
 	if (!ptepage)
 		return NULL;
+	pte = (pte_t *)pfn_to_kaddr(page_to_pfn(ptepage));
+	if (!pte_none(*pte))
+		pte_alloc_clear(pte);
 	if (!pgtable_page_ctor(ptepage)) {
 		__free_page(ptepage);
 		return NULL;
-- 
2.1.0
