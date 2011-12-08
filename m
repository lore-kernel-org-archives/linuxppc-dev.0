Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A1C741007D6
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 11:04:30 +1100 (EST)
Received: from mail142-tx2 (localhost [127.0.0.1])	by
 mail142-tx2-R.bigfish.com (Postfix) with ESMTP id D66C15204DA	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 00:04:27 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.246])	by
 mail142-tx2.bigfish.com (Postfix) with ESMTP id 9667880046	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 00:04:27 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] [v2] powerpc/85xx: p1022ds: disable the NOR flash node if
 video is enabled
Date: Wed, 7 Dec 2011 18:04:24 -0600
Message-ID: <1323302665-26461-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale P1022 has a unique pin muxing "feature" where the DIU video
controller's video signals are muxed with 24 of the local bus address signals.
When the DIU is enabled, the bulk of the local bus is disabled, preventing
access to memory-mapped devices like NOR flash and the pixis FPGA.

Therefore, if the DIU is going to be enabled, then memory-mapped devices on
the localbus, like NOR flash, need to be disabled.

This also means that the localbus is not a 'simple-bus' any more, so remove
that string from the compatible node.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi |    6 ++-
 arch/powerpc/platforms/85xx/p1022_ds.c      |   71 +++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 16239b1..2a62edd 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -35,7 +35,11 @@
 &lbc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	compatible = "fsl,p1022-elbc", "fsl,elbc", "simple-bus";
+	/*
+	 * The localbus on the P1022 is not a simple-bus because of the eLBC
+	 * pin muxing when the DIU is enabled.
+	 */
+	compatible = "fsl,p1022-elbc", "fsl,elbc";
 	interrupts = <19 2 0 0>;
 };
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 2ec39f4..6c9638c 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -360,6 +360,49 @@ void __init p1022_ds_pic_init(void)
 void __init mpc85xx_smp_init(void);
 #endif
 
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+
+/*
+ * Disables a node in the device tree.
+ *
+ * This function is called before kmalloc() is available, so the 'new' object
+ * should be allocated in the global area.  The easiest way is to do that is
+ * to allocate one static local variable for each call to this function.
+ */
+static void __init disable_one_node(struct device_node *np, struct property *new)
+{
+	struct property *old;
+
+	old = of_find_property(np, new->name, NULL);
+	if (old)
+		prom_update_property(np, new, old);
+	else
+		prom_add_property(np, new);
+}
+
+/* TRUE if there is a "video=fslfb" command-line parameter. */
+static bool fslfb;
+
+/*
+ * Search for a "video=fslfb" command-line parameter, and set 'fslfb' to
+ * true if we find it.
+ *
+ * We need to use early_param() instead of __setup() because the normal
+ * __setup() gets called to late.  However, early_param() gets called very
+ * early, before the device tree is unflattened, so all we can do now is set a
+ * global variable.  Later on, p1022_ds_setup_arch() will use that variable
+ * to determine if we need to update the device tree.
+ */
+static int __init early_video_setup(char *options)
+{
+	fslfb = (strncmp(options, "fslfb:", 6) == 0);
+
+	return 0;
+}
+early_param("video", early_video_setup);
+
+#endif
+
 /*
  * Setup the architecture
  */
@@ -397,6 +440,34 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.set_monitor_port	= p1022ds_set_monitor_port;
 	diu_ops.set_pixel_clock		= p1022ds_set_pixel_clock;
 	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
+
+	/*
+	 * Disable the NOR flash node if there is video=fslfb... command-line
+	 * parameter.  When the DIU is active, NOR flash is unavailable, so we
+	 * have to delete the node before the MTD driver loads.
+	 */
+	if (fslfb) {
+		struct device_node *np =
+			of_find_compatible_node(NULL, NULL, "fsl,p1022-elbc");
+
+		if (np) {
+			np = of_find_compatible_node(np, NULL, "cfi-flash");
+			if (np) {
+				static struct property nor_status = {
+					.name = "status",
+					.value = "disabled",
+					.length = sizeof("disabled"),
+				};
+
+				pr_info("p1022ds: disabling %s node",
+					np->full_name);
+				disable_one_node(np, &nor_status);
+				of_node_put(np);
+			}
+		}
+
+	}
+
 #endif
 
 #ifdef CONFIG_SMP
-- 
1.7.3.4
