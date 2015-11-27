Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63B961A013E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2015 15:45:47 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Nov 2015 21:45:44 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 78AC23E40041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:45:42 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAR4jgXW20054236
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:45:42 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAR4jgLR003065
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 21:45:42 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/powernv: Remove OPALv2 firmware define and
 references
Date: Fri, 27 Nov 2015 15:45:24 +1100
Message-Id: <1448599526-31073-3-git-send-email-stewart@linux.vnet.ibm.com>
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

OPALv2 only ever existed in the lab and didn't escape to the world.
All OPAL systems in the wild are OPALv3.

The probability of there being an OPALv2 system still powered on
anywhere inside IBM is approximately zero, let alone anyone
expecting to run mainline kernels.

So, start to remove references to OPALv2.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/firmware.h    |  4 +---
 arch/powerpc/platforms/powernv/opal.c  | 10 +++-------
 arch/powerpc/platforms/powernv/setup.c |  2 --
 arch/powerpc/platforms/powernv/smp.c   |  4 ++--
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index e05808a328db..50af5e5ea86f 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -47,7 +47,6 @@
 #define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
 #define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
 #define FW_FEATURE_OPAL		ASM_CONST(0x0000000010000000)
-#define FW_FEATURE_OPALv2	ASM_CONST(0x0000000020000000)
 #define FW_FEATURE_SET_MODE	ASM_CONST(0x0000000040000000)
 #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
@@ -70,8 +69,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
-	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv2 |
-		FW_FEATURE_OPALv3,
+	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL | FW_FEATURE_OPALv3,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
 	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
 	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index ad691fc15309..5ce51d9b4ca6 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -100,11 +100,10 @@ int __init early_init_dt_scan_opal(unsigned long node,
 
 	powerpc_firmware_features |= FW_FEATURE_OPAL;
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
-		powerpc_firmware_features |= FW_FEATURE_OPALv2;
 		powerpc_firmware_features |= FW_FEATURE_OPALv3;
 		pr_info("OPAL V3 detected !\n");
 	} else {
-		panic("OPAL != V3 detected, no longer supported.\n")
+		panic("OPAL != V3 detected, no longer supported.\n");
 	}
 
 	/* Reinit all cores with the right endian */
@@ -349,7 +348,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	 * enough room and be done with it
 	 */
 	spin_lock_irqsave(&opal_write_lock, flags);
-	if (firmware_has_feature(FW_FEATURE_OPALv2)) {
+	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
 		rc = opal_console_write_buffer_space(vtermno, &olen);
 		len = be64_to_cpu(olen);
 		if (rc || len < total_len) {
@@ -693,10 +692,7 @@ static int __init opal_init(void)
 	}
 
 	/* Register OPAL consoles if any ports */
-	if (firmware_has_feature(FW_FEATURE_OPALv2))
-		consoles = of_find_node_by_path("/ibm,opal/consoles");
-	else
-		consoles = of_node_get(opal_node);
+	consoles = of_find_node_by_path("/ibm,opal/consoles");
 	if (consoles) {
 		for_each_child_of_node(consoles, np) {
 			if (strcmp(np->name, "serial"))
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index a9a8fa37a555..80e7ed362ffa 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -92,8 +92,6 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
 	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		seq_printf(m, "firmware\t: OPAL v3\n");
-	else if (firmware_has_feature(FW_FEATURE_OPALv2))
-		seq_printf(m, "firmware\t: OPAL v2\n");
 	else if (firmware_has_feature(FW_FEATURE_OPAL))
 		seq_printf(m, "firmware\t: OPAL v1\n");
 	else
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index ca264833ee64..9b968a315103 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -65,10 +65,10 @@ static int pnv_smp_kick_cpu(int nr)
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
 	/*
-	 * If we already started or OPALv2 is not supported, we just
+	 * If we already started or OPALv3 is not supported, we just
 	 * kick the CPU via the PACA
 	 */
-	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPALv2))
+	if (paca[nr].cpu_start || !firmware_has_feature(FW_FEATURE_OPALv3))
 		goto kick;
 
 	/*
-- 
2.1.4
