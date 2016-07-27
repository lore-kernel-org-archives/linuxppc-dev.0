Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtf1shRzDrLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 12/21] powerpc/mm: Convert early cpu/mmu feature check to
 use the new helpers
Date: Thu, 28 Jul 2016 00:18:08 +1000
Message-Id: <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This switches early feature checks to use the non static key variant of
the function. In later patches we will be switching cpu_has_feature()
and mmu_has_feature() to use static keys and we can use them only after
static key/jump label is initialized. Any check for feature before jump
label init should be done using this new helper.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 4 ++--
 arch/powerpc/kernel/paca.c               | 2 +-
 arch/powerpc/kernel/setup_64.c           | 4 ++--
 arch/powerpc/mm/hash_utils_64.c          | 6 +++---
 arch/powerpc/mm/init_64.c                | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

v3: Add/remove some sites now that we're rebased on the early MMU init series.

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 70c995870297..6deda6ecc4f7 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -116,7 +116,7 @@ extern void hash__early_init_mmu_secondary(void);
 extern void radix__early_init_mmu_secondary(void);
 static inline void early_init_mmu_secondary(void)
 {
-	if (radix_enabled())
+	if (__radix_enabled())
 		return radix__early_init_mmu_secondary();
 	return hash__early_init_mmu_secondary();
 }
@@ -128,7 +128,7 @@ extern void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 static inline void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 					      phys_addr_t first_memblock_size)
 {
-	if (radix_enabled())
+	if (__radix_enabled())
 		return radix__setup_initial_memory_limit(first_memblock_base,
 						   first_memblock_size);
 	return hash__setup_initial_memory_limit(first_memblock_base,
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 93dae296b6be..1b0b89e80824 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -184,7 +184,7 @@ void setup_paca(struct paca_struct *new_paca)
 	 * if we do a GET_PACA() before the feature fixups have been
 	 * applied
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE))
+	if (__cpu_has_feature(CPU_FTR_HVMODE))
 		mtspr(SPRN_SPRG_HPACA, local_paca);
 #endif
 	mtspr(SPRN_SPRG_PACA, local_paca);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 984696136f96..86ffab4c427b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -227,8 +227,8 @@ static void __init configure_exceptions(void)
 			opal_configure_cores();
 
 		/* Enable AIL if supported, and we are in hypervisor mode */
-		if (cpu_has_feature(CPU_FTR_HVMODE) &&
-		    cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		if (__cpu_has_feature(CPU_FTR_HVMODE) &&
+		    __cpu_has_feature(CPU_FTR_ARCH_207S)) {
 			unsigned long lpcr = mfspr(SPRN_LPCR);
 			mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
 		}
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5f922e93af25..3aad12fb9d2f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -530,7 +530,7 @@ static bool might_have_hea(void)
 	 * we will never see an HEA ethernet device.
 	 */
 #ifdef CONFIG_IBMEBUS
-	return !cpu_has_feature(CPU_FTR_ARCH_207S) &&
+	return !__cpu_has_feature(CPU_FTR_ARCH_207S) &&
 		!firmware_has_feature(FW_FEATURE_SPLPAR);
 #else
 	return false;
@@ -561,7 +561,7 @@ static void __init htab_init_page_sizes(void)
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
 	 */
-	if (mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (__mmu_has_feature(MMU_FTR_16M_PAGE))
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
 found:
@@ -591,7 +591,7 @@ found:
 		mmu_vmalloc_psize = MMU_PAGE_64K;
 		if (mmu_linear_psize == MMU_PAGE_4K)
 			mmu_linear_psize = MMU_PAGE_64K;
-		if (mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
+		if (__mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
 			/*
 			 * When running on pSeries using 64k pages for ioremap
 			 * would stop us accessing the HEA ethernet. So if we
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 6259f5db525b..c21d160088fa 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -427,7 +427,7 @@ void __init mmu_early_init_devtree(void)
 	if (disable_radix)
 		cur_cpu_spec->mmu_features &= ~MMU_FTR_TYPE_RADIX;
 
-	if (radix_enabled())
+	if (__radix_enabled())
 		radix__early_init_devtree();
 	else
 		hash__early_init_devtree();
-- 
2.7.4
