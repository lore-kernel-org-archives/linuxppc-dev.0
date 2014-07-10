Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 866B01A018F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:34 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 8/9] powerpc: Remove CONFIG_POWER4
Date: Thu, 10 Jul 2014 12:29:25 +1000
Message-Id: <1404959366-17664-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
References: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although the name CONFIG_POWER4 suggests that it controls support for
power4 cpus, this symbol is actually misnamed.

It is a historical wart from the powermac code, which used to support
building a 32-bit kernel for power3. CONFIG_POWER4 was used in that
context to guard code that was 64-bit only.

In the powermac code we can just use CONFIG_PPC64 instead, and in other
places it is a synonym for CONFIG_PPC_BOOK3S_64.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h       |  2 +-
 arch/powerpc/platforms/Kconfig.cputype    | 12 +++------
 arch/powerpc/platforms/powermac/Kconfig   |  2 +-
 arch/powerpc/platforms/powermac/feature.c | 42 +++++++++++++++----------------
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index bff747eea06b..f1027481da0f 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -268,7 +268,7 @@ extern const char *powerpc_base_platform;
 #endif
 
 #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
-		     !defined(CONFIG_POWER4) && !defined(CONFIG_BOOKE))
+		     !defined(CONFIG_BOOKE))
 
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | \
 	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 798e6add1cae..f03e7d0d76f8 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -140,10 +140,6 @@ config 6xx
 	depends on PPC32 && PPC_BOOK3S
 	select PPC_HAVE_PMU_SUPPORT
 
-config POWER4
-	depends on PPC64 && PPC_BOOK3S
-	def_bool y
-
 config TUNE_CELL
 	bool "Optimize for Cell Broadband Engine"
 	depends on PPC64 && PPC_BOOK3S
@@ -240,7 +236,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on 6xx || POWER4 || (PPC_E500MC && PPC64)
+	depends on 6xx || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
@@ -256,7 +252,7 @@ config ALTIVEC
 
 config VSX
 	bool "VSX Support"
-	depends on POWER4 && ALTIVEC && PPC_FPU
+	depends on PPC_BOOK3S_64 && ALTIVEC && PPC_FPU
 	---help---
 
 	  This option enables kernel support for the Vector Scaler extensions
@@ -272,7 +268,7 @@ config VSX
 
 config PPC_ICSWX
 	bool "Support for PowerPC icswx coprocessor instruction"
-	depends on POWER4
+	depends on PPC_BOOK3S_64
 	default n
 	---help---
 
@@ -290,7 +286,7 @@ config PPC_ICSWX
 
 config PPC_ICSWX_PID
 	bool "icswx requires direct PID management"
-	depends on PPC_ICSWX && POWER4
+	depends on PPC_ICSWX
 	default y
 	---help---
 	  The PID register in server is used explicitly for ICSWX.  In
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 1afd10f67858..607124bae2e7 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -10,7 +10,7 @@ config PPC_PMAC
 
 config PPC_PMAC64
 	bool
-	depends on PPC_PMAC && POWER4
+	depends on PPC_PMAC && PPC64
 	select MPIC
 	select U3_DART
 	select MPIC_U3_HT_IRQS
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 63d82bbc05e9..1413e72bc2e1 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -158,7 +158,7 @@ static inline int simple_feature_tweak(struct device_node *node, int type,
 	return 0;
 }
 
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 
 static long ohare_htw_scc_enable(struct device_node *node, long param,
 				 long value)
@@ -1318,7 +1318,7 @@ intrepid_aack_delay_enable(struct device_node *node, long param, long value)
 }
 
 
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
 static long
 core99_read_gpio(struct device_node *node, long param, long value)
@@ -1338,7 +1338,7 @@ core99_write_gpio(struct device_node *node, long param, long value)
 	return 0;
 }
 
-#ifdef CONFIG_POWER4
+#ifdef CONFIG_PPC64
 static long g5_gmac_enable(struct device_node *node, long param, long value)
 {
 	struct macio_chip *macio = &macio_chips[0];
@@ -1550,9 +1550,9 @@ void g5_phy_disable_cpu1(void)
 	if (uninorth_maj == 3)
 		UN_OUT(U3_API_PHY_CONFIG_1, 0);
 }
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 
 
 #ifdef CONFIG_PM
@@ -1864,7 +1864,7 @@ core99_sleep_state(struct device_node *node, long param, long value)
 	return 0;
 }
 
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
 static long
 generic_dev_can_wake(struct device_node *node, long param, long value)
@@ -1906,7 +1906,7 @@ static struct feature_table_entry any_features[] = {
 	{ 0, NULL }
 };
 
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 
 /* OHare based motherboards. Currently, we only use these on the
  * 2400,3400 and 3500 series powerbooks. Some older desktops seem
@@ -2056,7 +2056,7 @@ static struct feature_table_entry intrepid_features[] = {
 	{ 0, NULL }
 };
 
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 
 /* G5 features
  */
@@ -2074,10 +2074,10 @@ static struct feature_table_entry g5_features[] = {
 	{ 0, NULL }
 };
 
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
 static struct pmac_mb_def pmac_mb_defs[] = {
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 	/*
 	 * Desktops
 	 */
@@ -2342,7 +2342,7 @@ static struct pmac_mb_def pmac_mb_defs[] = {
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 	{	"PowerMac7,2",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,
@@ -2373,7 +2373,7 @@ static struct pmac_mb_def pmac_mb_defs[] = {
 		0,
 	},
 #endif /* CONFIG_PPC64 */
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 };
 
 /*
@@ -2441,7 +2441,7 @@ static int __init probe_motherboard(void)
 
 	/* Fallback to selection depending on mac-io chip type */
 	switch(macio->type) {
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 	    case macio_grand_central:
 		pmac_mb.model_id = PMAC_TYPE_PSURGE;
 		pmac_mb.model_name = "Unknown PowerSurge";
@@ -2475,7 +2475,7 @@ static int __init probe_motherboard(void)
 		pmac_mb.model_name = "Unknown Intrepid-based";
 		pmac_mb.features = intrepid_features;
 		break;
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 	case macio_keylargo2:
 		pmac_mb.model_id = PMAC_TYPE_UNKNOWN_K2;
 		pmac_mb.model_name = "Unknown K2-based";
@@ -2486,13 +2486,13 @@ static int __init probe_motherboard(void)
 		pmac_mb.model_name = "Unknown Shasta-based";
 		pmac_mb.features = g5_features;
 		break;
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 	default:
 		ret = -ENODEV;
 		goto done;
 	}
 found:
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 	/* Fixup Hooper vs. Comet */
 	if (pmac_mb.model_id == PMAC_TYPE_HOOPER) {
 		u32 __iomem * mach_id_ptr = ioremap(0xf3000034, 4);
@@ -2546,9 +2546,9 @@ found:
 	 */
 	powersave_lowspeed = 1;
 
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 	powersave_nap = 1;
-#endif  /* CONFIG_POWER4 */
+#endif  /* CONFIG_PPC64 */
 
 	/* Check for "mobile" machine */
 	if (model && (strncmp(model, "PowerBook", 9) == 0
@@ -2786,7 +2786,7 @@ set_initial_features(void)
 		MACIO_BIS(OHARE_FCR, OH_IOBUS_ENABLE);
 	}
 
-#ifdef CONFIG_POWER4
+#ifdef CONFIG_PPC64
 	if (macio_chips[0].type == macio_keylargo2 ||
 	    macio_chips[0].type == macio_shasta) {
 #ifndef CONFIG_SMP
@@ -2826,7 +2826,7 @@ set_initial_features(void)
 			np = of_find_node_by_name(np, "firewire");
 		}
 	}
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 
 	if (macio_chips[0].type == macio_keylargo ||
 	    macio_chips[0].type == macio_pangea ||
@@ -2895,7 +2895,7 @@ set_initial_features(void)
 		MACIO_BIC(HEATHROW_FCR, HRW_SOUND_POWER_N);
 	}
 
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
 	/* On all machines, switch modem & serial ports off */
 	for_each_node_by_name(np, "ch-a")
-- 
1.9.1
