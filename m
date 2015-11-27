Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C71E71A03BC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 15:45:47 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 21:45:45 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 32A9F1FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:33:54 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR4jgl528115062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:45:42 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR4jgOH016807
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:45:42 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powerpc/powernv: remove FW_FEATURE_OPAL and just use
 FW_FEATURE_OPALv3
Date: Fri, 27 Nov 2015 15:45:25 +1100
Message-Id: <1448599526-31073-4-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Long ago, only in the lab, there was OPALv1 and OPALv2. Now there is
just OPALv3, with nobody ever expecting anything on pre-OPALv3 to
be cared about or supported by mainline kernels.

So, let's remove FW_FEATURE_OPAL and instead use FW_FEATURE_OPALv3
exclusively.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h    | 3 +--
 arch/powerpc/mm/numa.c                 | 4 ++--
 arch/powerpc/platforms/powernv/opal.c  | 3 +--
 arch/powerpc/platforms/powernv/pci.c   | 2 +-
 arch/powerpc/platforms/powernv/setup.c | 8 +++-----
 arch/powerpc/sysdev/xics/ics-opal.c    | 2 +-
 drivers/i2c/busses/i2c-opal.c          | 2 +-
 drivers/rtc/rtc-opal.c                 | 2 +-
 drivers/tty/hvc/hvc_opal.c             | 2 +-
 9 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 50af5e5ea86f..3901e2ee3f16 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -46,7 +46,6 @@
 #define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
 #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
 #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
-#define FW_FEATURE_OPAL		ASM_CONST(0x0000000010000000)
 #define FW_FEATURE_SET_MODE	ASM_CONST(0x0000000040000000)
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
@@ -69,7 +68,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
-	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv3,
+	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPALv3,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e7fa76..06da32c6a007 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -297,7 +297,7 @@ static int __init find_min_common_depth(void)
 	int depth;
 	struct device_node *root;
 
-	if (firmware_has_feature(FW_FEATURE_OPAL))
+	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		root = of_find_node_by_path("/ibm,opal");
 	else
 		root = of_find_node_by_path("/rtas");
@@ -327,7 +327,7 @@ static int __init find_min_common_depth(void)
 
 	distance_ref_points_depth /= sizeof(int);
 
-	if (firmware_has_feature(FW_FEATURE_OPAL) ||
+	if (firmware_has_feature(FW_FEATURE_OPALv3) ||
 	    firmware_has_feature(FW_FEATURE_TYPE1_AFFINITY)) {
 		dbg("Using form 1 affinity\n");
 		form1_affinity = 1;
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 5ce51d9b4ca6..bcb6581ec75c 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -98,7 +98,6 @@ int __init early_init_dt_scan_opal(unsigned long node,
 	pr_debug("OPAL Entry = 0x%llx (sizep=%p runtimesz=%d)\n",
 		 opal.size, sizep, runtimesz);
 
-	powerpc_firmware_features |= FW_FEATURE_OPAL;
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
 		powerpc_firmware_features |= FW_FEATURE_OPALv3;
 		pr_info("OPAL V3 detected !\n");
@@ -180,7 +179,7 @@ static int __init opal_register_exception_handlers(void)
 #ifdef __BIG_ENDIAN__
 	u64 glue;
 
-	if (!(powerpc_firmware_features & FW_FEATURE_OPAL))
+	if (!(powerpc_firmware_features & FW_FEATURE_OPALv3))
 		return -ENODEV;
 
 	/* Hookup some exception handlers except machine check. We use the
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f2dd77234240..6041b795f593 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -786,7 +786,7 @@ void __init pnv_pci_init(void)
 	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
 	/* If we don't have OPAL, eg. in sim, just skip PCI probe */
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
 		return;
 
 	/* Look for IODA IO-Hubs. We don't support mixing IODA
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 80e7ed362ffa..d79b07f1b33b 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -49,7 +49,7 @@ static void __init pnv_setup_arch(void)
 	pnv_pci_init();
 
 	/* Setup RTC and NVRAM callbacks */
-	if (firmware_has_feature(FW_FEATURE_OPAL))
+	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		opal_nvram_init();
 
 	/* Enable NAP mode */
@@ -67,7 +67,7 @@ static void __init pnv_init_early(void)
 	opal_lpc_init();
 
 #ifdef CONFIG_HVC_OPAL
-	if (firmware_has_feature(FW_FEATURE_OPAL))
+	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		hvc_opal_init_early();
 	else
 #endif
@@ -92,8 +92,6 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
 	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		seq_printf(m, "firmware\t: OPAL v3\n");
-	else if (firmware_has_feature(FW_FEATURE_OPAL))
-		seq_printf(m, "firmware\t: OPAL v1\n");
 	else
 		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
@@ -277,7 +275,7 @@ static int __init pnv_probe(void)
 
 	hpte_init_native();
 
-	if (firmware_has_feature(FW_FEATURE_OPAL))
+	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		pnv_setup_machdep_opal();
 
 	pr_debug("PowerNV detected !\n");
diff --git a/arch/powerpc/sysdev/xics/ics-opal.c b/arch/powerpc/sysdev/xics/ics-opal.c
index 27c936c080a6..ac60ef2aff80 100644
--- a/arch/powerpc/sysdev/xics/ics-opal.c
+++ b/arch/powerpc/sysdev/xics/ics-opal.c
@@ -226,7 +226,7 @@ static long ics_opal_get_server(struct ics *ics, unsigned long vec)
 
 int __init ics_opal_init(void)
 {
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
 		return -ENODEV;
 
 	/* We need to patch our irq chip's EOI to point to the
diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index 75dd6d041241..39f99207400f 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -276,7 +276,7 @@ static struct platform_driver i2c_opal_driver = {
 
 static int __init i2c_opal_init(void)
 {
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
 		return -ENODEV;
 
 	return platform_driver_register(&i2c_opal_driver);
diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index df39ce02a99d..56da8e7ae83f 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -244,7 +244,7 @@ static struct platform_driver opal_rtc_driver = {
 
 static int __init opal_rtc_init(void)
 {
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
 		return -ENODEV;
 
 	return platform_driver_register(&opal_rtc_driver);
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 47b54c6aefd2..580369310e0d 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -255,7 +255,7 @@ static struct platform_driver hvc_opal_driver = {
 
 static int __init hvc_opal_init(void)
 {
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
+	if (!firmware_has_feature(FW_FEATURE_OPALv3))
 		return -ENODEV;
 
 	/* Register as a vio device to receive callbacks */
-- 
2.1.4
