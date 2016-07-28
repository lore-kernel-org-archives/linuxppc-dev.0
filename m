Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0Wg03gm9zDrPh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 22:40:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, bsingharora@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v4] powerpc/mm: Do hash device tree scanning earlier
Date: Thu, 28 Jul 2016 22:40:35 +1000
Message-Id: <1469709635-21112-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-3-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-3-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently MMU initialisation (early_init_mmu()) consists of a mixture of
scanning the device tree, setting MMU feature bits, and then also doing
actual initialisation of MMU data structures.

We'd like to decouple the setting of the MMU features from the actual
setup. So split out the device tree scanning, and associated code, and
call it from mmu_init_early_devtree().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
 arch/powerpc/mm/hash_utils_64.c          | 53 ++++++++++++++++----------------
 arch/powerpc/mm/init_64.c                |  3 ++
 3 files changed, 31 insertions(+), 26 deletions(-)

v4: Split htab_init_page_sizes() into two parts, the bit that needs to scan the
    device tree (now htab_scan_page_sizes()), and the rest.
    Fold htab_init_seg_sizes() into hash__early_init_devtree().

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 4eb4bd019716..358f1410dc0d 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -108,6 +108,7 @@ extern int mmu_io_psize;
 
 /* MMU initialization */
 void mmu_early_init_devtree(void);
+void hash__early_init_devtree(void);
 extern void radix_init_native(void);
 extern void hash__early_init_mmu(void);
 extern void radix__early_init_mmu(void);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b78b5d211278..1a96b284b1a6 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -363,11 +363,6 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
 	return 0;
 }
 
-static void __init htab_init_seg_sizes(void)
-{
-	of_scan_flat_dt(htab_dt_scan_seg_sizes, NULL);
-}
-
 static int __init get_idx_from_shift(unsigned int shift)
 {
 	int idx = -1;
@@ -539,7 +534,7 @@ static bool might_have_hea(void)
 
 #endif /* #ifdef CONFIG_PPC_64K_PAGES */
 
-static void __init htab_init_page_sizes(void)
+static void __init htab_scan_page_sizes(void)
 {
 	int rc;
 
@@ -554,17 +549,23 @@ static void __init htab_init_page_sizes(void)
 	 * Try to find the available page sizes in the device-tree
 	 */
 	rc = of_scan_flat_dt(htab_dt_scan_page_sizes, NULL);
-	if (rc != 0)  /* Found */
-		goto found;
-
-	/*
-	 * Not in the device-tree, let's fallback on known size
-	 * list for 16M capable GP & GR
-	 */
-	if (mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (rc == 0 && mmu_has_feature(MMU_FTR_16M_PAGE)) {
+		/*
+		 * Nothing in the device-tree, but the CPU supports 16M pages,
+		 * so let's fallback on a known size list for 16M capable CPUs.
+		 */
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
-found:
+	}
+
+#ifdef CONFIG_HUGETLB_PAGE
+	/* Reserve 16G huge page memory sections for huge pages */
+	of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
+#endif /* CONFIG_HUGETLB_PAGE */
+}
+
+static void __init htab_init_page_sizes(void)
+{
 	if (!debug_pagealloc_enabled()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
@@ -630,11 +631,6 @@ found:
 	       ,mmu_psize_defs[mmu_vmemmap_psize].shift
 #endif
 	       );
-
-#ifdef CONFIG_HUGETLB_PAGE
-	/* Reserve 16G huge page memory sections for huge pages */
-	of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
-#endif /* CONFIG_HUGETLB_PAGE */
 }
 
 static int __init htab_dt_scan_pftsize(unsigned long node,
@@ -759,12 +755,6 @@ static void __init htab_initialize(void)
 
 	DBG(" -> htab_initialize()\n");
 
-	/* Initialize segment sizes */
-	htab_init_seg_sizes();
-
-	/* Initialize page sizes */
-	htab_init_page_sizes();
-
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
 		mmu_kernel_ssize = MMU_SEGSIZE_1T;
 		mmu_highuser_ssize = MMU_SEGSIZE_1T;
@@ -885,8 +875,19 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
+void __init hash__early_init_devtree(void)
+{
+	/* Initialize segment sizes */
+	of_scan_flat_dt(htab_dt_scan_seg_sizes, NULL);
+
+	/* Initialize page sizes */
+	htab_scan_page_sizes();
+}
+
 void __init hash__early_init_mmu(void)
 {
+	htab_init_page_sizes();
+
 	/*
 	 * initialize page table size
 	 */
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 0d51e6e25db5..d023333c6c9a 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -426,5 +426,8 @@ void __init mmu_early_init_devtree(void)
 	/* Disable radix mode based on kernel command line. */
 	if (disable_radix)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
+
+	if (!radix_enabled())
+		hash__early_init_devtree();
 }
 #endif /* CONFIG_PPC_STD_MMU_64 */
-- 
2.7.4
