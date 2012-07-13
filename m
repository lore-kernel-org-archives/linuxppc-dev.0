Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 095ED2C030A
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2012 05:28:50 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: p1022ds: disable the NAND flash node if video
 is enabled
Date: Fri, 13 Jul 2012 14:28:42 -0500
Message-ID: <1342207722-2315-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale P1022 has a unique pin muxing "feature" where the DIU video
controller's video signals are muxed with 24 of the local bus address signals.
When the DIU is enabled, the bulk of the local bus is disabled, preventing
access to memory-mapped devices like NAND flash and the pixis FPGA.

Therefore, if the DIU is going to be enabled, then memory-mapped devices on
the localbus, like NAND flash, need to be disabled.

This patch is similar to "powerpc/85xx: p1022ds: disable the NOR flash node
if video is enabled", except that it disables the NAND flash node instead.
This PIXIS node needs to remain enabled because it is used by platform code
to switch into indirect mode.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |   58 +++++++++++++++++++++-----------
 1 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 89ee02c..5ca2823a 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -419,18 +419,6 @@ void __init p1022_ds_pic_init(void)
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
-/*
- * Disables a node in the device tree.
- *
- * This function is called before kmalloc() is available, so the 'new' object
- * should be allocated in the global area.  The easiest way is to do that is
- * to allocate one static local variable for each call to this function.
- */
-static void __init disable_one_node(struct device_node *np, struct property *new)
-{
-	prom_update_property(np, new);
-}
-
 /* TRUE if there is a "video=fslfb" command-line parameter. */
 static bool fslfb;
 
@@ -493,28 +481,58 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
 
 	/*
-	 * Disable the NOR flash node if there is video=fslfb... command-line
-	 * parameter.  When the DIU is active, NOR flash is unavailable, so we
-	 * have to disable the node before the MTD driver loads.
+	 * Disable the NOR and NAND flash nodes if there is video=fslfb...
+	 * command-line parameter.  When the DIU is active, the localbus is
+	 * unavailable, so we have to disable these nodes before the MTD
+	 * driver loads.
 	 */
 	if (fslfb) {
 		struct device_node *np =
 			of_find_compatible_node(NULL, NULL, "fsl,p1022-elbc");
 
 		if (np) {
-			np = of_find_compatible_node(np, NULL, "cfi-flash");
-			if (np) {
+			struct device_node *np2;
+
+			of_node_get(np);
+			np2 = of_find_compatible_node(np, NULL, "cfi-flash");
+			if (np2) {
 				static struct property nor_status = {
 					.name = "status",
 					.value = "disabled",
 					.length = sizeof("disabled"),
 				};
 
+				/*
+				 * prom_update_property() is called before
+				 * kmalloc() is available, so the 'new' object
+				 * should be allocated in the global area.
+				 * The easiest way is to do that is to
+				 * allocate one static local variable for each
+				 * call to this function.
+				 */
+				pr_info("p1022ds: disabling %s node",
+					np2->full_name);
+				prom_update_property(np2, &nor_status);
+				of_node_put(np2);
+			}
+
+			of_node_get(np);
+			np2 = of_find_compatible_node(np, NULL,
+						      "fsl,elbc-fcm-nand");
+			if (np2) {
+				static struct property nand_status = {
+					.name = "status",
+					.value = "disabled",
+					.length = sizeof("disabled"),
+				};
+
 				pr_info("p1022ds: disabling %s node",
-					np->full_name);
-				disable_one_node(np, &nor_status);
-				of_node_put(np);
+					np2->full_name);
+				prom_update_property(np2, &nand_status);
+				of_node_put(np2);
 			}
+
+			of_node_put(np);
 		}
 
 	}
-- 
1.7.3.4
