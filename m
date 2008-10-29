Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF26DDDF7C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 08:19:02 +1100 (EST)
Message-Id: <200810292118.m9TLIU7J018621@imap1.linux-foundation.org>
Subject: [patch 1/1] powerpc: hugetlb pgtable cache access cleanup
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Wed, 29 Oct 2008 14:18:30 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	kniht@linux.vnet.ibm.com, nickpiggin@yahoo.com.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Tollefson <kniht@linux.vnet.ibm.com>

Cleaned up use of macro.  We now reference the pgtable_cache array
directly instead of using a macro.

Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/mm/hugetlbpage.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff -puN arch/powerpc/mm/hugetlbpage.c~powerpc-hugetlb-pgtable-cache-access-cleanup arch/powerpc/mm/hugetlbpage.c
--- a/arch/powerpc/mm/hugetlbpage.c~powerpc-hugetlb-pgtable-cache-access-cleanup
+++ a/arch/powerpc/mm/hugetlbpage.c
@@ -53,8 +53,7 @@ unsigned int mmu_huge_psizes[MMU_PAGE_CO
 
 /* Subtract one from array size because we don't need a cache for 4K since
  * is not a huge page size */
-#define huge_pgtable_cache(psize)	(pgtable_cache[HUGEPTE_CACHE_NUM \
-							+ psize-1])
+#define HUGE_PGTABLE_INDEX(psize)	(HUGEPTE_CACHE_NUM + psize - 1)
 #define HUGEPTE_CACHE_NAME(psize)	(huge_pgtable_cache_name[psize])
 
 static const char *huge_pgtable_cache_name[MMU_PAGE_COUNT] = {
@@ -113,7 +112,7 @@ static inline pte_t *hugepte_offset(huge
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			   unsigned long address, unsigned int psize)
 {
-	pte_t *new = kmem_cache_zalloc(huge_pgtable_cache(psize),
+	pte_t *new = kmem_cache_zalloc(pgtable_cache[HUGE_PGTABLE_INDEX(psize)],
 				      GFP_KERNEL|__GFP_REPEAT);
 
 	if (! new)
@@ -121,7 +120,7 @@ static int __hugepte_alloc(struct mm_str
 
 	spin_lock(&mm->page_table_lock);
 	if (!hugepd_none(*hpdp))
-		kmem_cache_free(huge_pgtable_cache(psize), new);
+		kmem_cache_free(pgtable_cache[HUGE_PGTABLE_INDEX(psize)], new);
 	else
 		hpdp->pd = (unsigned long)new | HUGEPD_OK;
 	spin_unlock(&mm->page_table_lock);
@@ -760,13 +759,14 @@ static int __init hugetlbpage_init(void)
 
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		if (mmu_huge_psizes[psize]) {
-			huge_pgtable_cache(psize) = kmem_cache_create(
-						HUGEPTE_CACHE_NAME(psize),
-						HUGEPTE_TABLE_SIZE(psize),
-						HUGEPTE_TABLE_SIZE(psize),
-						0,
-						NULL);
-			if (!huge_pgtable_cache(psize))
+			pgtable_cache[HUGE_PGTABLE_INDEX(psize)] =
+				kmem_cache_create(
+					HUGEPTE_CACHE_NAME(psize),
+					HUGEPTE_TABLE_SIZE(psize),
+					HUGEPTE_TABLE_SIZE(psize),
+					0,
+					NULL);
+			if (!pgtable_cache[HUGE_PGTABLE_INDEX(psize)])
 				panic("hugetlbpage_init(): could not create %s"\
 				      "\n", HUGEPTE_CACHE_NAME(psize));
 		}
_
