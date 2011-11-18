Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E74FAB722D
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2011 04:50:08 +1100 (EST)
Received: from mail34-tx2 (localhost.localdomain [127.0.0.1])	by
 mail34-tx2-R.bigfish.com (Postfix) with ESMTP id B93F415D84BC	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 17:49:48 +0000 (UTC)
Received: from TX2EHSMHS047.bigfish.com (unknown [10.9.14.239])	by
 mail34-tx2.bigfish.com (Postfix) with ESMTP id 5CE36748051	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 17:49:48 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <scottwood@freescale.com>,
 <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] powerpc/85xx: p1022ds: disable the NOR flash node if
 video is enabled
Date: Fri, 18 Nov 2011 11:49:59 -0600
Message-ID: <1321638601-6861-1-git-send-email-timur@freescale.com>
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

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |   70 ++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index fda1571..e0280e2 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -270,6 +270,54 @@ void __init p1022_ds_pic_init(void)
 void __init mpc85xx_smp_init(void);
 #endif
 
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+
+/*
+ * Disables a node in the device tree.
+ *
+ * This function is called before kmalloc() is available, and it's only called
+ * once, so we instead of allocating the new property object via the bootmem
+ * allocator, we just create a static local variable.
+ */
+static void __init disable_one_node(struct device_node *np)
+{
+	struct property *old;
+	static struct property new = {
+		.name = "status",
+		.value = "disabled",
+		.length = sizeof("disabled"),
+	};
+
+	old = of_find_property(np, new.name, NULL);
+	if (old)
+		prom_update_property(np, &new, old);
+	else
+		prom_add_property(np, &new);
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
@@ -307,6 +355,28 @@ static void __init p1022_ds_setup_arch(void)
 	diu_ops.set_monitor_port	= p1022ds_set_monitor_port;
 	diu_ops.set_pixel_clock		= p1022ds_set_pixel_clock;
 	diu_ops.valid_monitor_port	= p1022ds_valid_monitor_port;
+
+	/*
+	 * Delete the NOR flash node if there is video=fslfb... command-line
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
+				pr_info("p1022ds: disabling %s node",
+					np->full_name);
+				disable_one_node(np);
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
