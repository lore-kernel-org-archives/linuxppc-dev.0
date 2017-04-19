Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7JtV6jd5zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:00:02 +1000 (AEST)
Message-Id: <e1badb30cdc8035c6cd3eed40410c97b5e55e5bf.1492596044.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1492596044.git.christophe.leroy@c-s.fr>
References: <cover.1492596044.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc/mm: Ensure change_page_attr() doesn't invalidate
 pinned TLBs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Apr 2017 12:59:59 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__change_page_attr() uses flush_tlb_page().
flush_tlb_page() uses tlbie instruction, which also invalidates
pinned TLBs, which is not what we expect.

This patch modifies the implementation to use flush_tlb_kernel_range()
instead. This will make use of tlbia which will preserve pinned TLBs.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a65c0b4c0669..8e8940fad12f 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -325,7 +325,7 @@ get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 
-static int __change_page_attr(struct page *page, pgprot_t prot)
+static int __change_page_attr_noflush(struct page *page, pgprot_t prot)
 {
 	pte_t *kpte;
 	pmd_t *kpmd;
@@ -339,8 +339,6 @@ static int __change_page_attr(struct page *page, pgprot_t prot)
 	if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
 		return -EINVAL;
 	__set_pte_at(&init_mm, address, kpte, mk_pte(page, prot), 0);
-	wmb();
-	flush_tlb_page(NULL, address);
 	pte_unmap(kpte);
 
 	return 0;
@@ -355,13 +353,17 @@ static int change_page_attr(struct page *page, int numpages, pgprot_t prot)
 {
 	int i, err = 0;
 	unsigned long flags;
+	struct page *start = page;
 
 	local_irq_save(flags);
 	for (i = 0; i < numpages; i++, page++) {
-		err = __change_page_attr(page, prot);
+		err = __change_page_attr_noflush(page, prot);
 		if (err)
 			break;
 	}
+	wmb();
+	flush_tlb_kernel_range((unsigned long)page_address(start),
+			       (unsigned long)page_address(page));
 	local_irq_restore(flags);
 	return err;
 }
-- 
2.12.0
