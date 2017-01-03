Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttJSQ6jfSzDqDx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 02:55:34 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g1so33915312pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 07:55:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix pgtable pmd cache init
Date: Wed,  4 Jan 2017 01:55:17 +1000
Message-Id: <20170103155517.24347-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
mixed up PMD_INDEX_SIZE and PMD_CACHE_INDEX a couple of times. This
resulted in 64s/hash/4k configs to panic at boot with a false positive
error check.

Fix that and simplify error handling by moving the check to the caller.

Fixes: 9b081e10805cd ("powerpc: port 64 bits pgtable_cache to 32 bits")
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/hugetlbpage.c |  6 +-----
 arch/powerpc/mm/init-common.c | 11 +++--------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 289df38fb7e0..f21f6b907d99 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -810,12 +810,8 @@ static int __init hugetlbpage_init(void)
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.
 		 */
-		if (pdshift > shift) {
+		if (pdshift > shift)
 			pgtable_cache_add(pdshift - shift, NULL);
-			if (!PGT_CACHE(pdshift - shift))
-				panic("hugetlbpage_init(): could not create "
-				      "pgtable cache for %d bit pagesize\n", shift);
-		}
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else if (!hugepte_cache) {
 			/*
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index a175cd82ae8c..1a3be5ae1d07 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -80,6 +80,8 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	new = kmem_cache_create(name, table_size, align, 0, ctor);
 	kfree(name);
 	pgtable_cache[shift - 1] = new;
+	if (!new)
+		panic("Could not allocate pgtable cache for order %d", shift);
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
 }
 
@@ -88,7 +90,7 @@ void pgtable_cache_init(void)
 {
 	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
 
-	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
+	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
 		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
 	/*
 	 * In all current configs, when the PUD index exists it's the
@@ -97,11 +99,4 @@ void pgtable_cache_init(void)
 	 */
 	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
 		pgtable_cache_add(PUD_INDEX_SIZE, pud_ctor);
-
-	if (!PGT_CACHE(PGD_INDEX_SIZE))
-		panic("Couldn't allocate pgd cache");
-	if (PMD_INDEX_SIZE && !PGT_CACHE(PMD_INDEX_SIZE))
-		panic("Couldn't allocate pmd pgtable caches");
-	if (PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE))
-		panic("Couldn't allocate pud pgtable caches");
 }
-- 
2.11.0
