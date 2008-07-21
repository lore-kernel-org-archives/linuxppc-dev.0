Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 37478DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 17:05:46 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [3/5] replace CONFIG_POWER4 by CONFIG_PPC64
Date: Mon, 21 Jul 2008 08:45:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807210845.20778.marvin24@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch replaces all occurrences of CONFIG_POWER4 by CONFIG_PPC64 since it 
is redundant.

Subject: [PATCH] replace CONFIG_POWER4 by CONFIG_PPC64

---
 arch/powerpc/Makefile                     |    2 +-
 arch/powerpc/configs/cell_defconfig       |    1 -
 arch/powerpc/configs/celleb_defconfig     |    1 -
 arch/powerpc/configs/g5_defconfig         |    1 -
 arch/powerpc/configs/iseries_defconfig    |    1 -
 arch/powerpc/configs/maple_defconfig      |    1 -
 arch/powerpc/configs/pasemi_defconfig     |    1 -
 arch/powerpc/configs/ppc64_defconfig      |    1 -
 arch/powerpc/configs/ps3_defconfig        |    1 -
 arch/powerpc/configs/pseries_defconfig    |    1 -
 arch/powerpc/mm/ppc_mmu_32.c              |    2 +-
 arch/powerpc/platforms/Kconfig.cputype    |    4 ---
 arch/powerpc/platforms/powermac/feature.c |   42 +++++++++++++---------------
 include/asm-powerpc/cputable.h            |    2 +-
 include/asm-powerpc/mmu_context.h         |    6 +---
 15 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9155c93..624a896 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -118,7 +118,7 @@ endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
-cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
+cpu-as-$(CONFIG_PPC64)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
diff --git a/arch/powerpc/configs/cell_defconfig 
b/arch/powerpc/configs/cell_defconfig
index 579e996..42290e8 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -10,7 +10,6 @@ CONFIG_PPC64=y
 #
 # CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
-CONFIG_POWER4=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/celleb_defconfig 
b/arch/powerpc/configs/celleb_defconfig
index c2761a7..a405836 100644
--- a/arch/powerpc/configs/celleb_defconfig
+++ b/arch/powerpc/configs/celleb_defconfig
@@ -10,7 +10,6 @@ CONFIG_PPC64=y
 #
 # CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
-CONFIG_POWER4=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/g5_defconfig 
b/arch/powerpc/configs/g5_defconfig
index 0ccc6e4..747088a 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -9,7 +9,6 @@ CONFIG_PPC64=y
 # Processor support
 #
 CONFIG_POWER4_ONLY=y
-CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/iseries_defconfig 
b/arch/powerpc/configs/iseries_defconfig
index 5237a6b..1b46033 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -10,7 +10,6 @@ CONFIG_PPC64=y
 #
 # CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
-CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 # CONFIG_ALTIVEC is not set
diff --git a/arch/powerpc/configs/maple_defconfig 
b/arch/powerpc/configs/maple_defconfig
index 7a166a3..4becb7b 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -9,7 +9,6 @@ CONFIG_PPC64=y
 # Processor support
 #
 CONFIG_POWER4_ONLY=y
-CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 # CONFIG_ALTIVEC is not set
diff --git a/arch/powerpc/configs/pasemi_defconfig 
b/arch/powerpc/configs/pasemi_defconfig
index 199e5f5..d816a3a 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -9,7 +9,6 @@ CONFIG_PPC64=y
 # Processor support
 #
 CONFIG_POWER4_ONLY=y
-CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/ppc64_defconfig 
b/arch/powerpc/configs/ppc64_defconfig
index 953d840..22276d2 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -10,7 +10,6 @@ CONFIG_PPC64=y
 #
 # CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
-CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/ps3_defconfig 
b/arch/powerpc/configs/ps3_defconfig
index 2015c69..52a0895 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -10,7 +10,6 @@ CONFIG_PPC64=y
 #
 # CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
-CONFIG_POWER4=y
 CONFIG_TUNE_CELL=y
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/pseries_defconfig 
b/arch/powerpc/configs/pseries_defconfig
index e163059..e0194e7 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -10,7 +10,6 @@ CONFIG_PPC64=y
 #
 # CONFIG_POWER4_ONLY is not set
 CONFIG_BATS64=y
-CONFIG_POWER4=y
 # CONFIG_TUNE_CELL is not set
 CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c53145f..c3509c8 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -74,7 +74,7 @@ unsigned long p_mapped_by_bats(phys_addr_t pa)
 
 unsigned long __init mmu_mapin_ram(void)
 {
-#ifdef CONFIG_POWER4
+#ifdef CONFIG_PPC64
 	return 0;
 #else
 	unsigned long tot, bl, done;
diff --git a/arch/powerpc/platforms/Kconfig.cputype 
b/arch/powerpc/platforms/Kconfig.cputype
index b343fdb..5af2123 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -119,10 +119,6 @@ config BATS64
 	depends on PPC64
 	def_bool y if !POWER4_ONLY
 
-config POWER4
-	depends on PPC64
-	def_bool y
-
 config POWER4_ONLY
 	depends on PPC64
 	def_bool y if TUNE_POWER4 && OPT_EXCLUSIVE
diff --git a/arch/powerpc/platforms/powermac/feature.c 
b/arch/powerpc/platforms/powermac/feature.c
index 5169ecc..608b793 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -155,7 +155,7 @@ static inline int simple_feature_tweak(struct device_node 
*node, int type,
 	return 0;
 }
 
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 
 static long ohare_htw_scc_enable(struct device_node *node, long param,
 				 long value)
@@ -1315,7 +1315,7 @@ intrepid_aack_delay_enable(struct device_node *node, 
long param, long value)
 }
 
 
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
 static long
 core99_read_gpio(struct device_node *node, long param, long value)
@@ -1335,7 +1335,7 @@ core99_write_gpio(struct device_node *node, long param, 
long value)
 	return 0;
 }
 
-#ifdef CONFIG_POWER4
+#ifdef CONFIG_PPC64
 static long g5_gmac_enable(struct device_node *node, long param, long value)
 {
 	struct macio_chip *macio = &macio_chips[0];
@@ -1547,9 +1547,9 @@ void g5_phy_disable_cpu1(void)
 	if (uninorth_maj == 3)
 		UN_OUT(U3_API_PHY_CONFIG_1, 0);
 }
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 
 
 #ifdef CONFIG_PM
@@ -1861,7 +1861,7 @@ core99_sleep_state(struct device_node *node, long param, 
long value)
 	return 0;
 }
 
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
 static long
 generic_dev_can_wake(struct device_node *node, long param, long value)
@@ -1903,7 +1903,7 @@ static struct feature_table_entry any_features[] = {
 	{ 0, NULL }
 };
 
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 
 /* OHare based motherboards. Currently, we only use these on the
  * 2400,3400 and 3500 series powerbooks. Some older desktops seem
@@ -2053,7 +2053,7 @@ static struct feature_table_entry intrepid_features[] = 
{
 	{ 0, NULL }
 };
 
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 
 /* G5 features
  */
@@ -2071,10 +2071,10 @@ static struct feature_table_entry g5_features[] = {
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
@@ -2335,12 +2335,11 @@ static struct pmac_mb_def pmac_mb_defs[] = {
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 	{	"PowerMac7,2",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,
 	},
-#ifdef CONFIG_PPC64
 	{	"PowerMac7,3",			"PowerMac G5",
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,
@@ -2366,7 +2365,6 @@ static struct pmac_mb_def pmac_mb_defs[] = {
 		0,
 	},
 #endif /* CONFIG_PPC64 */
-#endif /* CONFIG_POWER4 */
 };
 
 /*
@@ -2434,7 +2432,7 @@ static int __init probe_motherboard(void)
 
 	/* Fallback to selection depending on mac-io chip type */
 	switch(macio->type) {
-#ifndef CONFIG_POWER4
+#ifndef CONFIG_PPC64
 	    case macio_grand_central:
 		pmac_mb.model_id = PMAC_TYPE_PSURGE;
 		pmac_mb.model_name = "Unknown PowerSurge";
@@ -2468,7 +2466,7 @@ static int __init probe_motherboard(void)
 		pmac_mb.model_name = "Unknown Intrepid-based";
 		pmac_mb.features = intrepid_features;
 		break;
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 	case macio_keylargo2:
 		pmac_mb.model_id = PMAC_TYPE_UNKNOWN_K2;
 		pmac_mb.model_name = "Unknown K2-based";
@@ -2479,13 +2477,13 @@ static int __init probe_motherboard(void)
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
@@ -2539,9 +2537,9 @@ found:
 	 */
 	powersave_lowspeed = 1;
 
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 	powersave_nap = 1;
-#endif  /* CONFIG_POWER4 */
+#endif  /* CONFIG_PPC64 */
 
 	/* Check for "mobile" machine */
 	if (model && (strncmp(model, "PowerBook", 9) == 0
@@ -2772,7 +2770,7 @@ set_initial_features(void)
 		MACIO_BIS(OHARE_FCR, OH_IOBUS_ENABLE);
 	}
 
-#ifdef CONFIG_POWER4
+#ifdef CONFIG_PPC64
 	if (macio_chips[0].type == macio_keylargo2 ||
 	    macio_chips[0].type == macio_shasta) {
 #ifndef CONFIG_SMP
@@ -2812,7 +2810,7 @@ set_initial_features(void)
 			np = of_find_node_by_name(np, "firewire");
 		}
 	}
-#else /* CONFIG_POWER4 */
+#else /* CONFIG_PPC64 */
 
 	if (macio_chips[0].type == macio_keylargo ||
 	    macio_chips[0].type == macio_pangea ||
@@ -2882,7 +2880,7 @@ set_initial_features(void)
 		MACIO_BIC(HEATHROW_FCR, HRW_SOUND_POWER_N);
 	}
 
-#endif /* CONFIG_POWER4 */
+#endif /* CONFIG_PPC64 */
 
 	/* On all machines, switch modem & serial ports off */
 	for_each_node_by_name(np, "ch-a")
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 0ef9abc..97fdbaf 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -257,7 +257,7 @@ extern void do_feature_fixups(unsigned long value, void 
*fixup_start,
 #endif
 
 #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
-		     !defined(CONFIG_POWER4) && !defined(CONFIG_BOOKE))
+		     !defined(CONFIG_PPC64) && !defined(CONFIG_BOOKE))
 
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | CPU_FTR_HPTE_TABLE | 
\
 	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
diff --git a/include/asm-powerpc/mmu_context.h 
b/include/asm-powerpc/mmu_context.h
index 9102b8b..bc4386b 100644
--- a/include/asm-powerpc/mmu_context.h
+++ b/include/asm-powerpc/mmu_context.h
@@ -173,9 +173,7 @@ static inline void switch_mm(struct mm_struct *prev, 
struct mm_struct *next,
 #ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 	asm volatile ("dssall;\n"
-#ifndef CONFIG_POWER4
-	 "sync;\n" /* G4 needs a sync here, G5 apparently not */
-#endif
+	 "sync;\n" /* G4 needs a sync here */
 	 : : );
 #endif /* CONFIG_ALTIVEC */
 
@@ -201,7 +199,7 @@ static inline void switch_mm(struct mm_struct *prev, 
struct mm_struct *next,
 extern void mmu_context_init(void);
 
 
-#else
+#else /* CONFIG_PPC64 */
 
 #include <linux/kernel.h>	
 #include <linux/mm.h>	
-- 
1.5.6.2
