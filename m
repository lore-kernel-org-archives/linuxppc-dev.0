Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44B0ADDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:13:24 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6S6DIuk009064
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 01:13:19 -0500
Subject: [PATCH] powerpc: Disable 64K huge page support when doing 64K SPU
	mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 16:13:18 +1000
Message-Id: <1217225598.11188.169.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 64K SPU local store mapping feature is incompatible with the
64K huge pages support due to the inability of some parts of
the memory management to differenciate between them while they
use a different page table format.

For now, disable 64K huge pages when CONFIG_SPU_FS_64K_LS,
in the long run, this can be fixed by making this feature use
the hugetlb page table format.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hugetlbpage.c	2008-07-28 15:57:48.000000000 +1000
+++ linux-work/arch/powerpc/mm/hugetlbpage.c	2008-07-28 15:59:25.000000000 +1000
@@ -736,14 +736,21 @@ static int __init hugetlbpage_init(void)
 
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -ENODEV;
+
 	/* Add supported huge page sizes.  Need to change HUGE_MAX_HSTATE
 	 * and adjust PTE_NONCACHE_NUM if the number of supported huge page
 	 * sizes changes.
 	 */
 	set_huge_psize(MMU_PAGE_16M);
-	set_huge_psize(MMU_PAGE_64K);
 	set_huge_psize(MMU_PAGE_16G);
 
+	/* Temporarily disable support for 64K huge pages when 64K SPU local
+	 * store support is enabled as the current implementation conflicts.
+	 */
+#ifndef CONFIG_SPU_FS_64K_LS
+	set_huge_psize(MMU_PAGE_64K);
+#endif
+
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		if (mmu_huge_psizes[psize]) {
 			huge_pgtable_cache(psize) = kmem_cache_create(
