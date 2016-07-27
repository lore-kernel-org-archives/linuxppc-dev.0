Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtT1jVkzDrL7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 03/21] powerpc/mm: Do hash device tree scanning earlier
Date: Thu, 28 Jul 2016 00:17:59 +1000
Message-Id: <1469629097-30859-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/mm/hash_utils_64.c          | 15 +++++++++------
 arch/powerpc/mm/init_64.c                |  3 +++
 3 files changed, 13 insertions(+), 6 deletions(-)

v3: Merged into this series.

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
index 1ff11c1bb182..5f922e93af25 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -759,12 +759,6 @@ static void __init htab_initialize(void)
 
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
@@ -885,6 +879,15 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
+void __init hash__early_init_devtree(void)
+{
+	/* Initialize segment sizes */
+	htab_init_seg_sizes();
+
+	/* Initialize page sizes */
+	htab_init_page_sizes();
+}
+
 void __init hash__early_init_mmu(void)
 {
 	/*
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
