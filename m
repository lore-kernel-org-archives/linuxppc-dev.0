Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtV0XnKzDrL7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 04/21] powerpc/mm: Do radix device tree scanning earlier
Date: Thu, 28 Jul 2016 00:18:00 +1000
Message-Id: <1469629097-30859-4-git-send-email-mpe@ellerman.id.au>
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

Like we just did for hash, split the device tree scanning parts out and
call them from mmu_early_init_devtree().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 1 +
 arch/powerpc/mm/init_64.c                | 4 +++-
 arch/powerpc/mm/pgtable-radix.c          | 3 +--
 3 files changed, 5 insertions(+), 3 deletions(-)

v3: Merged into this series.

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 358f1410dc0d..9ee00c2576d0 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -109,6 +109,7 @@ extern int mmu_io_psize;
 /* MMU initialization */
 void mmu_early_init_devtree(void);
 void hash__early_init_devtree(void);
+void radix__early_init_devtree(void);
 extern void radix_init_native(void);
 extern void hash__early_init_mmu(void);
 extern void radix__early_init_mmu(void);
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d023333c6c9a..e0ab33d20a10 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -427,7 +427,9 @@ void __init mmu_early_init_devtree(void)
 	if (disable_radix)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
 
-	if (!radix_enabled())
+	if (radix_enabled())
+		radix__early_init_devtree();
+	else
 		hash__early_init_devtree();
 }
 #endif /* CONFIG_PPC_STD_MMU_64 */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 003ff48a11b6..f34ccdbe0fbd 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -264,7 +264,7 @@ static int __init radix_dt_scan_page_sizes(unsigned long node,
 	return 1;
 }
 
-static void __init radix_init_page_sizes(void)
+void __init radix__early_init_devtree(void)
 {
 	int rc;
 
@@ -343,7 +343,6 @@ void __init radix__early_init_mmu(void)
 	__pte_frag_nr = H_PTE_FRAG_NR;
 	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
 
-	radix_init_page_sizes();
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
 		lpcr = mfspr(SPRN_LPCR);
-- 
2.7.4
