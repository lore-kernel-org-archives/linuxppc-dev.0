Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: LPAR is a firmware feature
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 16:38:13 +1100
Message-Id: <1137217093.4854.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make LPAR a firmware feature and stop testing for the LPAR bit in
_machine.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This is the patch posted earlier by Michael Ellerman extracted from his
series as it's a pre-requisite to the next patch I'm posting.

>From linuxppc64-dev-bounces@ozlabs.org Fri Jan 13 00:41:00 2006
Return-Path: <linuxppc64-dev-bounces@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45]) by gate.crashing.org
	(8.12.8/8.12.8) with ESMTP id k0D6exWG008949; Fri, 13 Jan 2006 00:41:00
	-0600
Received: from ozlabs.org (localhost [127.0.0.1]) by ozlabs.org (Postfix)
	with ESMTP id 0D000689E2; Fri, 13 Jan 2006 17:47:13 +1100 (EST)
X-Original-To: linuxppc64-dev@ozlabs.org
Delivered-To: linuxppc64-dev@ozlabs.org
Received: by ozlabs.org (Postfix, from userid 1034) id E3A786893F; Fri, 13
	Jan 2006 17:47:06 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc64-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 13 Jan 2006 17:46:57 +1100
Subject: [PATCH 3/10] powerpc: Replace platform_is_lpar() with a firmware
	feature
In-Reply-To: <1137134815.491678.995063725775.qpush@concordia>
Message-Id: <20060113064706.E3A786893F@ozlabs.org>
X-BeenThere: linuxppc64-dev@ozlabs.org
X-Mailman-Version: 2.1.6
Precedence: list
List-Id: 64-bit Linux on PowerPC Developers Mail List
	<linuxppc64-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc64-dev>
List-Post: <mailto:linuxppc64-dev@ozlabs.org>
List-Help: <mailto:linuxppc64-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc64-dev>,
	<mailto:linuxppc64-dev-request@ozlabs.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linuxppc64-dev-bounces@ozlabs.org
Errors-To: linuxppc64-dev-bounces@ozlabs.org
X-Spam-Checker-Version: SpamAssassin 3.0.1 (2004-10-22) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.0.1
Status:   
X-Evolution-Source: pop://benh@localhost:10110/
Content-Transfer-Encoding: 8bit

It has been decreed that platform numbers are evil, so as a step in that
direction, replace platform_is_lpar() with a FW_FEATURE_LPAR bit.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Index: linux-work/include/asm-powerpc/firmware.h
===================================================================
--- linux-work.orig/include/asm-powerpc/firmware.h	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/include/asm-powerpc/firmware.h	2006-01-14 15:18:42.000000000 +1100
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
Index: linux-work/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_utils_64.c	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/arch/powerpc/mm/hash_utils_64.c	2006-01-14 15:30:24.000000000 +1100
@@ -421,7 +421,7 @@ void __init htab_initialize(void)
 
 	htab_hash_mask = pteg_count - 1;
 
-	if (platform_is_lpar()) {
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		/* Using a hypervisor which owns the htab */
 		htab_address = NULL;
 		_SDR1 = 0; 
@@ -516,7 +516,7 @@ void __init htab_initialize(void)
 
 void htab_initialize_secondary(void)
 {
-	if (!platform_is_lpar())
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		mtspr(SPRN_SDR1, _SDR1);
 }
 
Index: linux-work/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- linux-work.orig/arch/powerpc/oprofile/op_model_power4.c	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/arch/powerpc/oprofile/op_model_power4.c	2006-01-14 15:18:42.000000000 +1100
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
 
Index: linux-work/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/iommu.c	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/iommu.c	2006-01-14 15:18:42.000000000 +1100
@@ -582,7 +582,7 @@ void iommu_init_early_pSeries(void)
 		return;
 	}
 
-	if (platform_is_lpar()) {
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		if (firmware_has_feature(FW_FEATURE_MULTITCE)) {
 			ppc_md.tce_build = tce_buildmulti_pSeriesLP;
 			ppc_md.tce_free	 = tce_freemulti_pSeriesLP;
Index: linux-work/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/setup.c	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/setup.c	2006-01-14 15:30:40.000000000 +1100
@@ -246,7 +246,7 @@ static void __init pSeries_setup_arch(vo
 		ppc_md.idle_loop = default_idle;
 	}
 
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
 	else
 		ppc_md.enable_pmcs = power4_enable_pmcs;
@@ -275,7 +275,6 @@ static void __init fw_feature_init(void)
 
 	DBG(" -> fw_feature_init()\n");
 
-	ppc64_firmware_features = 0;
 	dn = of_find_node_by_path("/rtas");
 	if (dn == NULL) {
 		printk(KERN_ERR "WARNING ! Cannot find RTAS in device-tree !\n");
@@ -373,7 +372,7 @@ static void __init pSeries_init_early(vo
 
 	fw_feature_init();
 	
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_lpar();
 	else {
 		hpte_init_native();
@@ -381,7 +380,7 @@ static void __init pSeries_init_early(vo
 			     get_property(of_chosen, "linux,iommu-off", NULL));
 	}
 
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		find_udbg_vterm();
 
 	if (firmware_has_feature(FW_FEATURE_DABR))
@@ -437,6 +436,9 @@ static int __init pSeries_probe(int plat
 	 * it here ...
 	 */
 
+	if (platform == PLATFORM_PSERIES_LPAR)
+		ppc64_firmware_features |= FW_FEATURE_LPAR;
+
 	return 1;
 }
 
@@ -578,7 +580,7 @@ static void pseries_shared_idle(void)
 
 static int pSeries_pci_probe_mode(struct pci_bus *bus)
 {
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		return PCI_PROBE_DEVTREE;
 	return PCI_PROBE_NORMAL;
 }
Index: linux-work/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/smp.c	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/smp.c	2006-01-14 15:18:42.000000000 +1100
@@ -443,7 +443,7 @@ void __init smp_init_pSeries(void)
 	smp_ops->cpu_die = pSeries_cpu_die;
 
 	/* Processors can be added/removed only on LPAR */
-	if (platform_is_lpar())
+	if (firmware_has_feature(FW_FEATURE_LPAR))
 		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
 #endif
 
Index: linux-work/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/xics.c	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/xics.c	2006-01-14 15:18:42.000000000 +1100
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
Index: linux-work/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/iseries/setup.c	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/arch/powerpc/platforms/iseries/setup.c	2006-01-14 15:30:24.000000000 +1100
@@ -303,8 +303,6 @@ static void __init iSeries_init_early(vo
 {
 	DBG(" -> iSeries_init_early()\n");
 
-	ppc64_firmware_features = FW_FEATURE_ISERIES;
-
 	ppc64_interrupt_controller = IC_ISERIES;
 
 #if defined(CONFIG_BLK_DEV_INITRD)
@@ -710,7 +708,13 @@ void __init iSeries_init_IRQ(void) { }
 
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
Index: linux-work/include/asm-powerpc/processor.h
===================================================================
--- linux-work.orig/include/asm-powerpc/processor.h	2006-01-14 15:18:12.000000000 +1100
+++ linux-work/include/asm-powerpc/processor.h	2006-01-14 15:30:24.000000000 +1100
@@ -52,7 +52,6 @@
 #ifdef __KERNEL__
 #define platform_is_pseries()	(_machine == PLATFORM_PSERIES || \
 				 _machine == PLATFORM_PSERIES_LPAR)
-#define platform_is_lpar()	(!!(_machine & PLATFORM_LPAR))
 
 #if defined(CONFIG_PPC_MULTIPLATFORM)
 extern int _machine;
