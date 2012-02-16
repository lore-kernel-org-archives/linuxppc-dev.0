Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6DE131007D4
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 11:25:56 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] [v4] powerpc/85xx: p1022ds: disable the NOR flash node if
 video is enabled
Date: Wed, 15 Feb 2012 18:25:47 -0600
Message-ID: <1329351948-20581-1-git-send-email-timur@freescale.com>
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
index ff9ed1d..16f27c7 100644
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
index b0984ad..bbdb38c 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -251,6 +251,49 @@ void __init p1022_ds_pic_init(void)
 	mpic_init(mpic);
 }
 
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
@@ -288,6 +331,34 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.set_monitor_port	= p1022ds_set_monitor_port;
 	diu_ops.set_pixel_clock		= p1022ds_set_pixel_clock;
 	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
+
+	/*
+	 * Disable the NOR flash node if there is video=fslfb... command-line
+	 * parameter.  When the DIU is active, NOR flash is unavailable, so we
+	 * have to disable the node before the MTD driver loads.
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
 
 	mpc85xx_smp_init();
-- 
1.7.3.4
