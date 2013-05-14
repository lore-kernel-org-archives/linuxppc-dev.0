Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B29E72C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 15:53:31 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r4E5rQnA030187
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 00:53:27 -0500
Message-ID: <1368510806.31689.13.camel@pasglop>
Subject: [PATCH 1/2] powerpc/powernv: Detect OPAL v3 API version
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 14 May 2013 15:53:26 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Future firmwares will support that new version. We need that
to properly fix CPU starting under OPAL with kexec.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/firmware.h    |    4 +++-
 arch/powerpc/include/asm/opal.h        |    3 ++-
 arch/powerpc/platforms/powernv/opal.c  |    6 +++++-
 arch/powerpc/platforms/powernv/setup.c |    4 +++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 0df5464..681bc03 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -52,6 +52,7 @@
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
+#define FW_FEATURE_OPALv3	ASM_CONST(0x0000000400000000)
 
 #ifndef __ASSEMBLY__
 
@@ -69,7 +70,8 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
-	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2,
+	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2 |
+		FW_FEATURE_OPALv3,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index b2906ad..cbb9305 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -243,7 +243,8 @@ enum OpalMCE_TlbErrorType {
 
 enum OpalThreadStatus {
 	OPAL_THREAD_INACTIVE = 0x0,
-	OPAL_THREAD_STARTED = 0x1
+	OPAL_THREAD_STARTED = 0x1,
+	OPAL_THREAD_UNAVAILABLE = 0x2 /* opal-v3 */
 };
 
 enum OpalPciBusCompare {
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 27907cb..628c564 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -56,7 +56,11 @@ int __init early_init_dt_scan_opal(unsigned long node,
 		 opal.entry, entryp, entrysz);
 
 	powerpc_firmware_features |= FW_FEATURE_OPAL;
-	if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
+	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
+		powerpc_firmware_features |= FW_FEATURE_OPALv2;
+		powerpc_firmware_features |= FW_FEATURE_OPALv3;
+		printk("OPAL V3 detected !\n");
+	} else if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
 		powerpc_firmware_features |= FW_FEATURE_OPALv2;
 		printk("OPAL V2 detected !\n");
 	} else {
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index c20381c..d4459bf 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -78,7 +78,9 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	if (root)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
-	if (firmware_has_feature(FW_FEATURE_OPALv2))
+	if (firmware_has_feature(FW_FEATURE_OPALv3))
+		seq_printf(m, "firmware\t: OPAL v3\n");
+	else if (firmware_has_feature(FW_FEATURE_OPALv2))
 		seq_printf(m, "firmware\t: OPAL v2\n");
 	else if (firmware_has_feature(FW_FEATURE_OPAL))
 		seq_printf(m, "firmware\t: OPAL v1\n");
