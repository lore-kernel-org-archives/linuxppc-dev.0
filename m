Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:45:59 +1100
Subject: [PATCH 4/11] powerpc: Replace platform_is_lpar() with a firmware
	feature
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094630.E7AD067B21@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It has been decreed that platform numbers are evil, so as a step in that
direction, replace platform_is_lpar() with a FW_FEATURE_LPAR bit.

Currently FW_FEATURE_LPAR really means i/pSeries LPAR, in the future we might
have to clean that up if we need to be more specific about what LPAR actually
means. But that's another patch ...

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/hash_utils_64.c         |    4 ++--
 arch/powerpc/oprofile/op_model_power4.c |    3 ++-
 arch/powerpc/platforms/iseries/setup.c  |   10 +++++++---
 arch/powerpc/platforms/pseries/iommu.c  |    2 +-
 arch/powerpc/platforms/pseries/setup.c  |   11 +++++++----
 arch/powerpc/platforms/pseries/smp.c    |    2 +-
 arch/powerpc/platforms/pseries/xics.c   |    3 ++-
 include/asm-powerpc/firmware.h          |    7 ++++---
 include/asm-powerpc/processor.h         |    1 -
 9 files changed, 26 insertions(+), 17 deletions(-)

Index: to-merge/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/hash_utils_64.c
+++ to-merge/arch/powerpc/mm/hash_utils_64.c
@@ -422,7 +422,7 @@ void __init htab_initialize(void)
 
 	htab_hash_mask = pteg_count - 1;
 
-	if (platform_is_lpar()) {
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		/* Using a hypervisor which owns the htab */
 		htab_address = NULL;
 		_SDR1 = 0; 
@@ -517,7 +517,7 @@ void __init htab_initialize(void)
 
 void htab_initialize_secondary(void)
 {
-	if (!platform_is_lpar())
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		mtspr(SPRN_SDR1, _SDR1);
 }
 
Index: to-merge/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- to-merge.orig/arch/powerpc/oprofile/op_model_power4.c
+++ to-merge/arch/powerpc/oprofile/op_model_power4.c
@@ -10,6 +10,7 @@
 #include <linux/oprofile.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <asm/firmware.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/processor.h>
@@ -232,7 +233,7 @@ static unsigned long get_pc(struct pt_re
 	mmcra = mfspr(SPRN_MMCRA);
 
 	/* Were we in the hypervisor? */
-	if (platform_is_lpar() && (mmcra & MMCRA_SIHV))
+	if (firmware_has_feature(FW_FEATURE_LPAR) && (mmcra & MMCRA_SIHV))
 		/* function descriptor madness */
 		return *((unsigned long *)hypervisor_bucket);
 
Index: to-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/setup.c
+++ to-merge/arch/powerpc/platforms/iseries/setup.c
@@ -303,8 +303,6 @@ static void __init iSeries_init_early(vo
 {
 	DBG(" -> iSeries_init_early()\n");
 
-	ppc64_firmware_features = FW_FEATURE_ISERIES;
-
 	ppc64_interrupt_controller = IC_ISERIES;
 
 #if defined(CONFIG_BLK_DEV_INITRD)
@@ -711,7 +709,13 @@ void __init iSeries_init_IRQ(void) { }
 
 static int __init iseries_probe(int platform)
 {
-	return PLATFORM_ISERIES_LPAR == platform;
+	if (PLATFORM_ISERIES_LPAR != platform)
+		return 0;
+
+	ppc64_firmware_features |= FW_FEATURE_ISERIES;
+	ppc64_firmware_features |= FW_FEATURE_LPAR;
+
+	return 1;
 }
 
 struct machdep_calls __initdata iseries_md = {
Index: to-merge/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/iommu.c
+++ to-merge/arch/powerpc/platforms/pseries/iommu.c
@@ -580,7 +580,7 @@ void iommu_init_early_pSeries(void)
 		return;
 	}
 
-	if (platform_is_lpar()) {
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		if (firmware_has_feature(FW_FEATURE_MULTITCE)) {
 			ppc_md.tce_build = tce_buildmulti_pSeriesLP;
 			ppc_md.tce_free	 = tce_freemulti_pSeriesLP;
Index: to-merge/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/setup.c
+++ to-merge/arch/powerpc/platforms/pseries/setup.c
@@ -246,7 +246,7 @@ static void __init pSeries_setup_arch(vo
 		ppc_md.idle_loop = default_idle;
 	}
 
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
 	else
 		ppc_md.enable_pmcs = power4_enable_pmcs;
@@ -324,12 +324,12 @@ static void __init pSeries_init_early(vo
 
 	fw_feature_init();
 	
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
 	else
 		hpte_init_native();
 
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		find_udbg_vterm();
 
 	if (firmware_has_feature(FW_FEATURE_DABR))
@@ -385,6 +385,9 @@ static int __init pSeries_probe(int plat
 	 * it here ...
 	 */
 
+	if (platform == PLATFORM_PSERIES_LPAR)
+		ppc64_firmware_features |= FW_FEATURE_LPAR;
+
 	return 1;
 }
 
@@ -524,7 +527,7 @@ static void pseries_shared_idle(void)
 
 static int pSeries_pci_probe_mode(struct pci_bus *bus)
 {
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		return PCI_PROBE_DEVTREE;
 	return PCI_PROBE_NORMAL;
 }
Index: to-merge/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/smp.c
+++ to-merge/arch/powerpc/platforms/pseries/smp.c
@@ -443,7 +443,7 @@ void __init smp_init_pSeries(void)
 	smp_ops->cpu_die = pSeries_cpu_die;
 
 	/* Processors can be added/removed only on LPAR */
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
 #endif
 
Index: to-merge/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/pseries/xics.c
+++ to-merge/arch/powerpc/platforms/pseries/xics.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/radix-tree.h>
 #include <linux/cpu.h>
+#include <asm/firmware.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -536,7 +537,7 @@ nextnode:
 		of_node_put(np);
 	}
 
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ops = &pSeriesLP_ops;
 	else {
 #ifdef CONFIG_SMP
Index: to-merge/include/asm-powerpc/firmware.h
===================================================================
--- to-merge.orig/include/asm-powerpc/firmware.h
+++ to-merge/include/asm-powerpc/firmware.h
@@ -41,6 +41,7 @@
 #define FW_FEATURE_MULTITCE	(1UL<<19)
 #define FW_FEATURE_SPLPAR	(1UL<<20)
 #define FW_FEATURE_ISERIES	(1UL<<21)
+#define FW_FEATURE_LPAR		(1UL<<22)
 
 enum {
 #ifdef CONFIG_PPC64
@@ -51,10 +52,10 @@ enum {
 		FW_FEATURE_MIGRATE | FW_FEATURE_PERFMON | FW_FEATURE_CRQ |
 		FW_FEATURE_VIO | FW_FEATURE_RDMA | FW_FEATURE_LLAN |
 		FW_FEATURE_BULK | FW_FEATURE_XDABR | FW_FEATURE_MULTITCE |
-		FW_FEATURE_SPLPAR,
+		FW_FEATURE_SPLPAR | FW_FEATURE_LPAR,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
-	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES,
-	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES,
+	FW_FEATURE_ISERIES_POSSIBLE = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
+	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
 	FW_FEATURE_POSSIBLE =
 #ifdef CONFIG_PPC_PSERIES
 		FW_FEATURE_PSERIES_POSSIBLE |
Index: to-merge/include/asm-powerpc/processor.h
===================================================================
--- to-merge.orig/include/asm-powerpc/processor.h
+++ to-merge/include/asm-powerpc/processor.h
@@ -52,7 +52,6 @@
 #ifdef __KERNEL__
 #define platform_is_pseries()	(_machine == PLATFORM_PSERIES || \
 				 _machine == PLATFORM_PSERIES_LPAR)
-#define platform_is_lpar()	(!!(_machine & PLATFORM_LPAR))
 
 #if defined(CONFIG_PPC_MULTIPLATFORM)
 extern int _machine;
