Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pxNd5kkCzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 23:27:29 +1000 (AEST)
Message-Id: <a0f9af0f829952b48669619282e3780509235b85.1534166756.git.christophe.leroy@c-s.fr>
In-Reply-To: <1cbc8dba537393edbb6384b67cbb123431ba6a32.1534166756.git.christophe.leroy@c-s.fr>
References: <1cbc8dba537393edbb6384b67cbb123431ba6a32.1534166756.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] powerpc/mm: remove ctor argument to pgtable_cache_add()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 13 Aug 2018 13:27:25 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As previous patch has removed all pgtable cache constructors,
lets remove it completely.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable.h |  2 +-
 arch/powerpc/mm/hugetlbpage.c      |  2 +-
 arch/powerpc/mm/init-common.c      | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 14c79a7dc855..d3195ac00a0b 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -72,7 +72,7 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 /* can we use this in kvm */
 unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
+void pgtable_cache_add(unsigned shift);
 void pgtable_cache_init(void);
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7296a42eb62e..72f31fc70b8e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -701,7 +701,7 @@ static int __init hugetlbpage_init(void)
 		 * use pgt cache for hugepd.
 		 */
 		if (pdshift > shift)
-			pgtable_cache_add(pdshift - shift, NULL);
+			pgtable_cache_add(pdshift - shift);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else if (!hugepte_cache) {
 			/*
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2ae15ff8f76f..8fb182aaf87d 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -35,7 +35,7 @@ EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
  * everything else.  Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+void pgtable_cache_add(unsigned shift)
 {
 	char *name;
 	unsigned long table_size = sizeof(void *) << shift;
@@ -63,7 +63,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor);
+	new = kmem_cache_create(name, table_size, align, 0, NULL);
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
@@ -76,15 +76,15 @@ EXPORT_SYMBOL_GPL(pgtable_cache_add);	/* used by kvm_hv module */
 
 void pgtable_cache_init(void)
 {
-	pgtable_cache_add(PGD_INDEX_SIZE, NULL);
+	pgtable_cache_add(PGD_INDEX_SIZE);
 
 	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
-		pgtable_cache_add(PMD_CACHE_INDEX, NULL);
+		pgtable_cache_add(PMD_CACHE_INDEX);
 	/*
 	 * In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index except with THP enabled
 	 * on book3s 64
 	 */
 	if (PUD_CACHE_INDEX && !PGT_CACHE(PUD_CACHE_INDEX))
-		pgtable_cache_add(PUD_CACHE_INDEX, NULL);
+		pgtable_cache_add(PUD_CACHE_INDEX);
 }
-- 
2.13.3
