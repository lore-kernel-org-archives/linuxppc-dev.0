Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EBEC1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 16:19:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 5/5] powerpc/mm: Drop CONFIG_PPC_HAS_HASH_64K
Date: Fri,  7 Aug 2015 16:19:47 +1000
Message-Id: <1438928387-6454-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
References: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The relation between CONFIG_PPC_HAS_HASH_64K and CONFIG_PPC_64K_PAGES is
painfully complicated.

But if we rearrange it enough we can see that PPC_HAS_HASH_64K
essentially depends on PPC_STD_MMU_64 && PPC_64K_PAGES.

We can then notice that PPC_HAS_HASH_64K is used in files that are only
built for PPC_STD_MMU_64, meaning it's equivalent to PPC_64K_PAGES.

So replace all uses and drop it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig            |  6 ------
 arch/powerpc/mm/hash_low_64.S   |  4 ++--
 arch/powerpc/mm/hash_utils_64.c | 12 ++++++------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3a4ba2809201..1e69dee29be3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -514,11 +514,6 @@ config NODES_SPAN_OTHER_NODES
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
-config PPC_HAS_HASH_64K
-	bool
-	depends on PPC64
-	default n
-
 config STDBINUTILS
 	bool "Using standard binutils settings"
 	depends on 44x
@@ -566,7 +561,6 @@ config PPC_16K_PAGES
 config PPC_64K_PAGES
 	bool "64k page size"
 	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
-	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
 
 config PPC_256K_PAGES
 	bool "256k page size"
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 463174a4a647..3b49e3295901 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -701,7 +701,7 @@ htab_pte_insert_failure:
 
 #endif /* CONFIG_PPC_64K_PAGES */
 
-#ifdef CONFIG_PPC_HAS_HASH_64K
+#ifdef CONFIG_PPC_64K_PAGES
 
 /*****************************************************************************
  *                                                                           *
@@ -993,7 +993,7 @@ ht64_pte_insert_failure:
 	b	ht64_bail
 
 
-#endif /* CONFIG_PPC_HAS_HASH_64K */
+#endif /* CONFIG_PPC_64K_PAGES */
 
 
 /*****************************************************************************
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5ec987f65b2c..aee70171355b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -640,7 +640,7 @@ extern u32 ht64_call_hpte_updatepp[];
 
 static void __init htab_finish_init(void)
 {
-#ifdef CONFIG_PPC_HAS_HASH_64K
+#ifdef CONFIG_PPC_64K_PAGES
 	patch_branch(ht64_call_hpte_insert1,
 		ppc_function_entry(ppc_md.hpte_insert),
 		BRANCH_SET_LINK);
@@ -653,7 +653,7 @@ static void __init htab_finish_init(void)
 	patch_branch(ht64_call_hpte_updatepp,
 		ppc_function_entry(ppc_md.hpte_updatepp),
 		BRANCH_SET_LINK);
-#endif /* CONFIG_PPC_HAS_HASH_64K */
+#endif /* CONFIG_PPC_64K_PAGES */
 
 	patch_branch(htab_call_hpte_insert1,
 		ppc_function_entry(ppc_md.hpte_insert),
@@ -1151,12 +1151,12 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		check_paca_psize(ea, mm, psize, user_region);
 #endif /* CONFIG_PPC_64K_PAGES */
 
-#ifdef CONFIG_PPC_HAS_HASH_64K
+#ifdef CONFIG_PPC_64K_PAGES
 	if (psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
 				     flags, ssize);
 	else
-#endif /* CONFIG_PPC_HAS_HASH_64K */
+#endif /* CONFIG_PPC_64K_PAGES */
 	{
 		int spp = subpage_protection(mm, ea);
 		if (access & spp)
@@ -1264,12 +1264,12 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 		update_flags |= HPTE_LOCAL_UPDATE;
 
 	/* Hash it in */
-#ifdef CONFIG_PPC_HAS_HASH_64K
+#ifdef CONFIG_PPC_64K_PAGES
 	if (mm->context.user_psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
 				     update_flags, ssize);
 	else
-#endif /* CONFIG_PPC_HAS_HASH_64K */
+#endif /* CONFIG_PPC_64K_PAGES */
 		rc = __hash_page_4K(ea, access, vsid, ptep, trap, update_flags,
 				    ssize, subpage_protection(mm, ea));
 
-- 
2.1.4
