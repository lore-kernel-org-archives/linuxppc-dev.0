Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7807A1A113E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 17:18:51 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 8 Dec 2015 23:18:49 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6D66538C8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 01:18:47 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB96IlwG28115142
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 06:18:47 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB96IkAO026050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Dec 2015 01:18:47 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] powerpc/powernv: Remove OPALv2 firmware define and
 references
Date: Wed,  9 Dec 2015 17:18:19 +1100
Message-Id: <1449641900-22089-3-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1449641900-22089-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1449641900-22089-1-git-send-email-stewart@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/firmware.h    | 4 +---
 arch/powerpc/platforms/powernv/opal.c  | 8 ++------
 arch/powerpc/platforms/powernv/setup.c | 4 ----
 arch/powerpc/platforms/powernv/smp.c   | 4 ++--
 4 files changed, 5 insertions(+), 15 deletions(-)

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
index faea1abaa785..5ce51d9b4ca6 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -100,7 +100,6 @@ int __init early_init_dt_scan_opal(unsigned long node,
 
 	powerpc_firmware_features |= FW_FEATURE_OPAL;
 	if (of_flat_dt_is_compatible(node, "ibm,opal-v3")) {
-		powerpc_firmware_features |= FW_FEATURE_OPALv2;
 		powerpc_firmware_features |= FW_FEATURE_OPALv3;
 		pr_info("OPAL V3 detected !\n");
 	} else {
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
index a9a8fa37a555..54583fc417be 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -92,10 +92,6 @@ static void pnv_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
 	if (firmware_has_feature(FW_FEATURE_OPALv3))
 		seq_printf(m, "firmware\t: OPAL v3\n");
-	else if (firmware_has_feature(FW_FEATURE_OPALv2))
-		seq_printf(m, "firmware\t: OPAL v2\n");
-	else if (firmware_has_feature(FW_FEATURE_OPAL))
-		seq_printf(m, "firmware\t: OPAL v1\n");
 	else
 		seq_printf(m, "firmware\t: BML\n");
 	of_node_put(root);
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
