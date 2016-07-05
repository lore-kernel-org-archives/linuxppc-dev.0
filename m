Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBfB63ryzDqyC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:05:22 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBf75MvLz9sCY
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:05:16 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/41] powerpc/64: Move MMU backend selection out of platform
 code
Date: Tue,  5 Jul 2016 15:03:51 +1000
Message-Id: <1467695057-12431-16-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We move it into early_mmu_init() based on firmware features. For PS3,
we have to move the setting of these into early_init_devtree().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/ps3.h          |  2 ++
 arch/powerpc/kernel/prom.c              |  7 +++++++
 arch/powerpc/mm/hash_utils_64.c         | 14 ++++++++++++++
 arch/powerpc/mm/pgtable-radix.c         |  1 +
 arch/powerpc/platforms/cell/setup.c     |  1 -
 arch/powerpc/platforms/maple/setup.c    |  1 -
 arch/powerpc/platforms/pasemi/setup.c   |  2 --
 arch/powerpc/platforms/powermac/setup.c |  4 ----
 arch/powerpc/platforms/powernv/setup.c  |  5 -----
 arch/powerpc/platforms/ps3/setup.c      | 15 +++++++++------
 arch/powerpc/platforms/pseries/setup.c  |  7 -------
 11 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index a1bc7e7..a19f831 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -526,4 +526,6 @@ void ps3_sync_irq(int node);
 u32 ps3_get_hw_thread_id(int cpu);
 u64 ps3_get_spe_id(void *arg);
 
+void ps3_early_mm_init(void);
+
 #endif
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d10e786..5d59f11 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -748,6 +748,13 @@ void __init early_init_devtree(void *params)
 	/* Now try to figure out if we are running on LPAR */
 	of_scan_flat_dt(pseries_probe_fw_features, NULL);
 #endif
+
+#ifdef CONFIG_PPC_PS3
+	/* Identify PS3 firmware */
+	if (of_flat_dt_is_compatible(of_get_flat_dt_root(), "sony,ps3"))
+		powerpc_firmware_features |= FW_FEATURE_PS3_POSSIBLE;
+#endif
+
 	DBG(" <- early_init_devtree()\n");
 }
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2bea864..839e1ad 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -58,6 +58,7 @@
 #include <asm/firmware.h>
 #include <asm/tm.h>
 #include <asm/trace.h>
+#include <asm/ps3.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -854,6 +855,11 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
+void __init __weak hpte_init_lpar(void)
+{
+	panic("FW_FEATURE_LPAR set but no LPAR support compiled\n");
+}
+
 void __init hash__early_init_mmu(void)
 {
 	/*
@@ -886,6 +892,14 @@ void __init hash__early_init_mmu(void)
 	vmemmap = (struct page *)H_VMEMMAP_BASE;
 	ioremap_bot = IOREMAP_BASE;
 
+	/* Select appropriate backend */
+	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
+		ps3_early_mm_init();
+	else if (firmware_has_feature(FW_FEATURE_LPAR))
+		hpte_init_lpar();
+	else
+		hpte_init_native();
+
 	/* Initialize the MMU Hash table and create the linear mapping
 	 * of memory. Has to be done before SLB initialization as this is
 	 * currently where the page size encoding is obtained.
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c939e6e..6624b7b 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -339,6 +339,7 @@ void __init radix__early_init_mmu(void)
 
 	radix_init_page_sizes();
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+		radix_init_native();
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
 		radix_init_partition_table();
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 36cff28..e342f78 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -261,7 +261,6 @@ static int __init cell_probe(void)
 	    !of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
 		return 0;
 
-	hpte_init_native();
 	pm_power_off = rtas_power_off;
 
 	return 1;
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 3cd625d..a56828c 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -304,7 +304,6 @@ static int __init maple_probe(void)
 	    !of_flat_dt_is_compatible(root, "Momentum,Apache"))
 		return 0;
 
-	hpte_init_native();
 	pm_power_off = maple_power_off;
 
 	return 1;
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d71b2c7..7605bc6 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -426,8 +426,6 @@ static int __init pas_probe(void)
 	    !of_flat_dt_is_compatible(root, "pasemi,pwrficient"))
 		return 0;
 
-	hpte_init_native();
-
 	alloc_iobmap_l2();
 
 	return 1;
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 43d02c2..5801889 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -597,10 +597,6 @@ static int __init pmac_probe(void)
 	    !of_flat_dt_is_compatible(root, "MacRISC"))
 		return 0;
 
-#ifdef CONFIG_PPC64
-	hpte_init_native();
-#endif
-
 #ifdef CONFIG_PPC32
 	/* isa_io_base gets set in pmac_pci_init */
 	ISA_DMA_THRESHOLD = ~0L;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ee6430b..15e3b8b 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -273,11 +273,6 @@ static int __init pnv_probe(void)
 	if (!of_flat_dt_is_compatible(root, "ibm,powernv"))
 		return 0;
 
-	if (IS_ENABLED(CONFIG_PPC_RADIX_MMU) && radix_enabled())
-		radix_init_native();
-	else if (IS_ENABLED(CONFIG_PPC_STD_MMU_64))
-		hpte_init_native();
-
 	if (firmware_has_feature(FW_FEATURE_OPAL))
 		pnv_setup_machdep_opal();
 
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 799c858..e5ee80d 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -226,9 +226,17 @@ static void __init ps3_progress(char *s, unsigned short hex)
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static int __init ps3_probe(void)
+void __init ps3_early_mm_init(void)
 {
 	unsigned long htab_size;
+
+	ps3_mm_init();
+	ps3_mm_vas_create(&htab_size);
+	ps3_hpte_init(htab_size);
+}
+
+static int __init ps3_probe(void)
+{
 	unsigned long dt_root;
 
 	DBG(" -> %s:%d\n", __func__, __LINE__);
@@ -237,12 +245,7 @@ static int __init ps3_probe(void)
 	if (!of_flat_dt_is_compatible(dt_root, "sony,ps3"))
 		return 0;
 
-	powerpc_firmware_features |= FW_FEATURE_PS3_POSSIBLE;
-
 	ps3_os_area_save_params();
-	ps3_mm_init();
-	ps3_mm_vas_create(&htab_size);
-	ps3_hpte_init(htab_size);
 	pm_power_off = ps3_power_off;
 
 	DBG(" <- %s:%d\n", __func__, __LINE__);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1543be0..0509723 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -760,13 +760,6 @@ static int __init pSeries_probe(void)
 	    of_flat_dt_is_compatible(root, "IBM,CBEA"))
 		return 0;
 
-	pr_debug("pSeries detected, looking for LPAR capability...\n");
-
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		hpte_init_lpar();
-	else
-		hpte_init_native();
-
 	pm_power_off = pseries_power_off;
 
 	pr_debug("Machine is%s LPAR !\n",
-- 
2.7.4
