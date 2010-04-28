Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0494B7D4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Apr 2010 17:23:01 +1000 (EST)
Subject: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 17:22:55 +1000
Message-ID: <1272439375.24542.94.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So we tried to speed things up a bit using flush_hash_pages() directly
but that falls over on 603 of course meaning we fail to flush the TLB
properly and we may even end up having it corrupt memory randomly by
accessing a hash table that doesn't exist.

This removes the "optimization" by always going through flush_tlb_page()
for now at least.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Somebody with a 603 or e300 core based FSL SoC to try this out for me ?

It's obviously completely untested :-)

Cheers,
Ben.

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index b9243e7..95774b4 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -385,11 +385,7 @@ static int __change_page_attr(struct page *page, pgprot_t prot)
 		return -EINVAL;
 	__set_pte_at(&init_mm, address, kpte, mk_pte(page, prot), 0);
 	wmb();
-#ifdef CONFIG_PPC_STD_MMU
-	flush_hash_pages(0, address, pmd_val(*kpmd), 1);
-#else
 	flush_tlb_page(NULL, address);
-#endif
 	pte_unmap(kpte);
 
 	return 0;
