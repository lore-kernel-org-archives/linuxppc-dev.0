Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzLMb2frdzDrF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 00:38:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH 2/6] powerpc/mm: Move disable_radix handling into
 mmu_early_init_devtree()
Date: Wed, 27 Jul 2016 00:38:11 +1000
Message-Id: <1469543895-27934-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469543895-27934-1-git-send-email-mpe@ellerman.id.au>
References: <1469543895-27934-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the handling of the disable_radix command line argument into the
newly created mmu_early_init_devtree().

It's an MMU option so it's preferable to have it in an mm related file,
and it also means platforms that don't support radix don't have to carry
the code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 13 -------------
 arch/powerpc/mm/init_64.c  | 11 +++++++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9686984e79c4..b4b6952e8991 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -647,14 +647,6 @@ static void __init early_reserve_mem(void)
 #endif
 }
 
-static bool disable_radix;
-static int __init parse_disable_radix(char *p)
-{
-	disable_radix = true;
-	return 0;
-}
-early_param("disable_radix", parse_disable_radix);
-
 void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
@@ -744,11 +736,6 @@ void __init early_init_devtree(void *params)
 	 */
 	spinning_secondaries = boot_cpu_count - 1;
 #endif
-	/*
-	 * now fixup radix MMU mode based on kernel command line
-	 */
-	if (disable_radix)
-		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
 
 	mmu_early_init_devtree();
 
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d0fb33ac3db2..0d51e6e25db5 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -413,7 +413,18 @@ EXPORT_SYMBOL_GPL(realmode_pfn_to_page);
 #endif /* CONFIG_SPARSEMEM_VMEMMAP/CONFIG_FLATMEM */
 
 #ifdef CONFIG_PPC_STD_MMU_64
+static bool disable_radix;
+static int __init parse_disable_radix(char *p)
+{
+	disable_radix = true;
+	return 0;
+}
+early_param("disable_radix", parse_disable_radix);
+
 void __init mmu_early_init_devtree(void)
 {
+	/* Disable radix mode based on kernel command line. */
+	if (disable_radix)
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
 }
 #endif /* CONFIG_PPC_STD_MMU_64 */
-- 
2.7.4
