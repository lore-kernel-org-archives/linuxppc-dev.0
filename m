Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCFb1QkNzDrpf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:32:35 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkCFZ2tK3z9ryQ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:32:34 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/41] powerpc: Move FW feature probing out of pseries probe()
Date: Tue,  5 Jul 2016 15:03:48 +1000
Message-Id: <1467695057-12431-13-git-send-email-benh@kernel.crashing.org>
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

We move the function itself to pseries/firmware.c and call it along
with almost all other flat device-tree parsers from early_init_devtree()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/firmware.h       |  4 +++
 arch/powerpc/kernel/prom.c                |  6 +++++
 arch/powerpc/platforms/pseries/firmware.c | 44 +++++++++++++++++++++++++++++--
 arch/powerpc/platforms/pseries/pseries.h  |  5 ----
 arch/powerpc/platforms/pseries/setup.c    | 41 ----------------------------
 5 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index b062924..ae0d457 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -126,6 +126,10 @@ extern int fwnmi_active;
 
 extern unsigned int __start___fw_ftr_fixup, __stop___fw_ftr_fixup;
 
+int pseries_probe_fw_features(unsigned long node,
+			      const char *uname, int depth,
+			      void *data);
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_FIRMWARE_H */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 48434be..d10e786 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -57,6 +57,7 @@
 #include <asm/fadump.h>
 #include <asm/debug.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/firmware.h>
 
 #include <mm/mmu_decl.h>
 
@@ -740,8 +741,13 @@ void __init early_init_devtree(void *params)
 	/* Scan and build the list of machine check recoverable ranges */
 	of_scan_flat_dt(early_init_dt_scan_recoverable_ranges, NULL);
 #endif
+
 	epapr_paravirt_early_init();
 
+#ifdef CONFIG_PPC_PSERIES
+	/* Now try to figure out if we are running on LPAR */
+	of_scan_flat_dt(pseries_probe_fw_features, NULL);
+#endif
 	DBG(" <- early_init_devtree()\n");
 }
 
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 8c80588..d9a7f62 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -69,7 +69,8 @@ hypertas_fw_features_table[] = {
  * device-tree/ibm,hypertas-functions.  Ultimately this functionality may
  * be moved into prom.c prom_init().
  */
-void __init fw_hypertas_feature_init(const char *hypertas, unsigned long len)
+static void __init fw_hypertas_feature_init(const char *hypertas,
+					    unsigned long len)
 {
 	const char *s;
 	int i;
@@ -113,7 +114,7 @@ vec5_fw_features_table[] = {
 	{FW_FEATURE_PRRN,		OV5_PRRN},
 };
 
-void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
+static void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
 {
 	unsigned int index, feat;
 	int i;
@@ -131,3 +132,42 @@ void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
 
 	pr_debug(" <- fw_vec5_feature_init()\n");
 }
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+
+int __init pseries_probe_fw_features(unsigned long node,
+				     const char *uname, int depth,
+				     void *data)
+{
+	const char *prop;
+	int len;
+	static int hypertas_found;
+	static int vec5_found;
+
+	if (depth != 1)
+		return 0;
+
+	if (!strcmp(uname, "rtas") || !strcmp(uname, "rtas@0")) {
+		prop = of_get_flat_dt_prop(node, "ibm,hypertas-functions",
+					   &len);
+		if (prop) {
+			powerpc_firmware_features |= FW_FEATURE_LPAR;
+			fw_hypertas_feature_init(prop, len);
+		}
+
+		hypertas_found = 1;
+	}
+
+	if (!strcmp(uname, "chosen")) {
+		prop = of_get_flat_dt_prop(node, "ibm,architecture-vec-5",
+					   &len);
+		if (prop)
+			fw_vec5_feature_init(prop, len);
+
+		vec5_found = 1;
+	}
+
+	return hypertas_found && vec5_found;
+}
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 7aa83f0..58a89f9 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -20,11 +20,6 @@ extern void request_event_sources_irqs(struct device_node *np,
 
 #include <linux/of.h>
 
-extern void __init fw_hypertas_feature_init(const char *hypertas,
-					    unsigned long len);
-extern void __init fw_vec5_feature_init(const char *hypertas,
-					unsigned long len);
-
 struct pt_regs;
 
 extern int pSeries_system_reset_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9883bc7..f1fe7aa 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -732,45 +732,6 @@ static void pseries_power_off(void)
 	for (;;);
 }
 
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-
-static int __init pseries_probe_fw_features(unsigned long node,
-					    const char *uname, int depth,
-					    void *data)
-{
-	const char *prop;
-	int len;
-	static int hypertas_found;
-	static int vec5_found;
-
-	if (depth != 1)
-		return 0;
-
-	if (!strcmp(uname, "rtas") || !strcmp(uname, "rtas@0")) {
-		prop = of_get_flat_dt_prop(node, "ibm,hypertas-functions",
-					   &len);
-		if (prop) {
-			powerpc_firmware_features |= FW_FEATURE_LPAR;
-			fw_hypertas_feature_init(prop, len);
-		}
-
-		hypertas_found = 1;
-	}
-
-	if (!strcmp(uname, "chosen")) {
-		prop = of_get_flat_dt_prop(node, "ibm,architecture-vec-5",
-					   &len);
-		if (prop)
-			fw_vec5_feature_init(prop, len);
-
-		vec5_found = 1;
-	}
-
-	return hypertas_found && vec5_found;
-}
-
 static int __init pSeries_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -790,8 +751,6 @@ static int __init pSeries_probe(void)
 
 	pr_debug("pSeries detected, looking for LPAR capability...\n");
 
-	/* Now try to figure out if we are running on LPAR */
-	of_scan_flat_dt(pseries_probe_fw_features, NULL);
 
 #ifdef __LITTLE_ENDIAN__
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
-- 
2.7.4
