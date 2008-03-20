Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id EC7A6DDE04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 15:33:48 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <262bc32afdde978922b9500c2a83f7c7ed6e4043.1205987625.git.tony@bakeyournoodle.com>
In-Reply-To: <63cdefde19cb2a4adc17ed771f21261673428ce7.1205987625.git.tony@bakeyournoodle.com>
References: <63cdefde19cb2a4adc17ed771f21261673428ce7.1205987625.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/2] Force 4K IOPages when eHEA is present in the machine.
Date: Thu, 20 Mar 2008 15:33:45 +1100 (EST)
Cc: Olof Johansson <olof@lixom.net>, Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

eHEA doesn't work with 64k iopages, If an eHEA /can/ be present in the system
limit iopages to 4k.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/mm/hash_utils_64.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 590f1f6..4fd5e8a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -302,14 +302,37 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	return 0;
 }
 
+#if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_PPC_64K_PAGES)
+static int __init scan_dt_for_ehea(unsigned long node, const char *uname,
+                                  int depth, void *data)
+{
+	if (depth != 0)
+		return 0;
+
+	if (of_flat_dt_search(node, "HEA ", "ibm,drc-names"))
+		return 1;
+
+	return 0;
+}
+#endif
+
+
 static void __init htab_init_page_sizes(void)
 {
 	int rc;
+#ifdef CONFIG_PPC_64K_PAGES
+	int has_ehea = 0;
+#endif
 
 	/* Default to 4K pages only */
 	memcpy(mmu_psize_defs, mmu_psize_defaults_old,
 	       sizeof(mmu_psize_defaults_old));
 
+#if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_PPC_64K_PAGES)
+	/* Scan to see if this system can have an EHEA, if so we'll
+	 * demote io_psize to 4K */
+	has_ehea = of_scan_flat_dt(scan_dt_for_ehea, NULL);
+#endif
 	/*
 	 * Try to find the available page sizes in the device-tree
 	 */
@@ -351,9 +374,10 @@ static void __init htab_init_page_sizes(void)
 		mmu_vmalloc_psize = MMU_PAGE_64K;
 		if (mmu_linear_psize == MMU_PAGE_4K)
 			mmu_linear_psize = MMU_PAGE_64K;
-		if (cpu_has_feature(CPU_FTR_CI_LARGE_PAGE))
-			mmu_io_psize = MMU_PAGE_64K;
-		else
+		if (cpu_has_feature(CPU_FTR_CI_LARGE_PAGE)) {
+			if (!has_ehea)
+				mmu_io_psize = MMU_PAGE_64K;
+		} else
 			mmu_ci_restrictions = 1;
 	}
 #endif /* CONFIG_PPC_64K_PAGES */
-- 
1.5.4.3
