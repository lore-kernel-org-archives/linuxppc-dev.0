Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 8421F1007F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:19 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 18/19] powerpc: wii: platform support
Date: Sun, 22 Nov 2009 23:01:49 +0100
Message-Id: <1258927311-4340-19-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add platform support for the Nintendo Wii video game console.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/Kconfig   |    8 +
 arch/powerpc/platforms/embedded6xx/Makefile  |    1 +
 arch/powerpc/platforms/embedded6xx/wii.c     |  270 ++++++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/wii_dev.c |   47 +++++
 4 files changed, 326 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/embedded6xx/wii.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/wii_dev.c

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index f207944..6e9b579 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -139,3 +139,11 @@ config STARLET_MINI
 
 	  If in doubt, say Y here.
 
+config WII
+	bool "Nintendo-Wii"
+	depends on EMBEDDED6xx
+	select GAMECUBE_COMMON
+	help
+	  Select WII if configuring for the Nintendo Wii.
+	  More information at: <http://gc-linux.sourceforge.net/>
+
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index f41a144..313a922 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_FLIPPER_PIC)	+= flipper-pic.o
 obj-$(CONFIG_GAMECUBE)		+= gamecube.o gamecube_dev.o
 obj-$(CONFIG_HLWD_PIC)		+= hlwd-pic.o
 obj-$(CONFIG_STARLET_MINI)	+= starlet-mipc.o
+obj-$(CONFIG_WII)		+= wii.o wii_dev.o
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
new file mode 100644
index 0000000..b0d7f52
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -0,0 +1,270 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/wii.c
+ *
+ * Nintendo Wii board-specific support
+ * Copyright (C) 2008-2009 The GameCube Linux Team
+ * Copyright (C) 2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+#define DRV_MODULE_NAME "rvl"
+#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/kexec.h>
+
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/starlet.h>
+#include <asm/starlet-mini.h>
+#include <asm/udbg.h>
+
+#include "flipper-pic.h"
+#include "usbgecko_udbg.h"
+
+
+static enum starlet_ipc_flavour starlet_ipc_flavour;
+
+enum starlet_ipc_flavour starlet_get_ipc_flavour(void)
+{
+	return starlet_ipc_flavour;
+}
+
+static void wii_spin(void)
+{
+	local_irq_disable();
+	for (;;)
+		cpu_relax();
+}
+
+#ifdef CONFIG_STARLET_MINI
+
+#define HW_RESETS_OF_COMPATIBLE	"nintendo,hollywood-resets"
+#define HW_GPIO_ALIAS		"hw_gpio"
+
+#define HW_GPIO_OUT		0
+#define HW_GPIO_DIR		4
+#define HW_GPIO_SHUTDOWN	(1<<1)
+
+static void __iomem *hw_resets;
+static void __iomem *hw_gpio;
+
+static int wii_setup_hw_resets(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int error = -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL, HW_RESETS_OF_COMPATIBLE);
+	if (!np) {
+		pr_err("no compatible node found for %s\n",
+		       HW_RESETS_OF_COMPATIBLE);
+		goto out;
+	}
+	error = of_address_to_resource(np, 0, &res);
+	if (error) {
+		pr_err("no valid reg found for %s\n", np->name);
+		goto out_put;
+	}
+
+	hw_resets = ioremap(res.start, res.end - res.start + 1);
+	if (hw_resets) {
+		pr_info("hw_resets at 0x%08x mapped to 0x%p\n",
+			res.start, hw_resets);
+	}
+
+out_put:
+	of_node_put(np);
+out:
+	return error;
+}
+
+static int wii_setup_hw_gpio(void)
+{
+	struct device_node *np;
+	struct resource res;
+	const char *path;
+	int error = -ENODEV;
+
+	np = of_find_node_by_name(NULL, "aliases");
+	if (!np) {
+		pr_err("unable to find node %s\n", "aliases");
+		goto out;
+	}
+
+	path = of_get_property(np, HW_GPIO_ALIAS, NULL);
+	of_node_put(np);
+	if (!path) {
+		pr_err("alias %s unknown\n", HW_GPIO_ALIAS);
+		goto out;
+	}
+
+	np = of_find_node_by_path(path);
+	if (!np) {
+		pr_err("node for alias %s unknown\n", HW_GPIO_ALIAS);
+		goto out;
+	}
+	error = of_address_to_resource(np, 0, &res);
+	if (error) {
+		pr_err("no valid reg found for %s\n", np->name);
+		goto out_put;
+	}
+
+	hw_gpio = ioremap(res.start, res.end - res.start + 1);
+	if (hw_gpio) {
+		pr_info("hw_gpio at 0x%08x mapped to 0x%p\n",
+			res.start, hw_gpio);
+	}
+
+out_put:
+	of_node_put(np);
+out:
+	return error;
+}
+
+static void wii_setup(void)
+{
+	wii_setup_hw_resets();
+	wii_setup_hw_gpio();
+}
+
+static void wii_restart(char *cmd)
+{
+	local_irq_disable();
+
+	if (hw_resets) {
+		/* clear the system reset pin to cause a reset */
+		clear_bit(0, hw_resets);
+	}
+	wii_spin();
+}
+
+static void wii_power_off(void)
+{
+	local_irq_disable();
+
+	if (hw_gpio) {
+		/* make sure that the poweroff GPIO is configured as output */
+		out_be32(hw_gpio + HW_GPIO_DIR,
+			 in_be32(hw_gpio + HW_GPIO_DIR) | HW_GPIO_SHUTDOWN);
+
+		/* drive the poweroff GPIO high */
+		out_be32(hw_gpio + HW_GPIO_OUT,
+			 in_be32(hw_gpio + HW_GPIO_OUT) | HW_GPIO_SHUTDOWN);
+	}
+	wii_spin();
+}
+
+#else
+
+static void wii_setup(void)
+{
+}
+
+static void wii_restart(char *cmd)
+{
+	wii_spin();
+}
+
+static void wii_power_off(void)
+{
+	wii_spin();
+}
+
+#endif /* CONFIG_STARLET_MINI */
+
+static void wii_halt(void)
+{
+	if (ppc_md.restart)
+		ppc_md.restart(NULL);
+	wii_spin();
+}
+
+static void wii_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: IBM\n");
+	seq_printf(m, "machine\t\t: Nintendo Wii\n");
+}
+
+static int wii_discover_ipc_flavour(void)
+{
+	struct mipc_infohdr *hdrp;
+	int error;
+
+	error = mipc_infohdr_get(&hdrp);
+	if (!error) {
+		mipc_infohdr_put(hdrp);
+		starlet_ipc_flavour = STARLET_IPC_MINI;
+		wii_setup();
+		ppc_md.restart = wii_restart;
+		ppc_md.power_off = wii_power_off;
+	}
+
+	return 0;
+}
+
+static void __init wii_setup_arch(void)
+{
+	ug_udbg_init();
+	wii_discover_ipc_flavour();
+}
+
+static void __init wii_init_early(void)
+{
+}
+
+static int __init wii_probe(void)
+{
+	unsigned long dt_root;
+
+	dt_root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(dt_root, "nintendo,wii"))
+		return 0;
+
+	return 1;
+}
+
+static void wii_shutdown(void)
+{
+	flipper_quiesce();
+}
+
+#ifdef CONFIG_KEXEC
+static int wii_machine_kexec_prepare(struct kimage *image)
+{
+	return 0;
+}
+
+static void wii_machine_kexec(struct kimage *image)
+{
+	default_machine_kexec(image);
+}
+#endif /* CONFIG_KEXEC */
+
+define_machine(wii) {
+	.name			= "wii",
+	.probe			= wii_probe,
+	.setup_arch		= wii_setup_arch,
+	.init_early		= wii_init_early,
+	.show_cpuinfo		= wii_show_cpuinfo,
+	.halt			= wii_halt,
+	.init_IRQ		= flipper_pic_probe,
+	.get_irq		= flipper_pic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+	.machine_shutdown	= wii_shutdown,
+#ifdef CONFIG_KEXEC
+	.machine_kexec_prepare	= wii_machine_kexec_prepare,
+	.machine_kexec		= wii_machine_kexec,
+#endif
+};
+
diff --git a/arch/powerpc/platforms/embedded6xx/wii_dev.c b/arch/powerpc/platforms/embedded6xx/wii_dev.c
new file mode 100644
index 0000000..903063e
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/wii_dev.c
@@ -0,0 +1,47 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/wii_dev.c
+ *
+ * Nintendo Wii platform device setup.
+ * Copyright (C) 2008-2009 The GameCube Linux Team
+ * Copyright (C) 2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+
+static struct of_device_id wii_of_bus[] = {
+	{ .compatible = "nintendo,hollywood", },
+#ifdef CONFIG_STARLET_MINI
+	{ .compatible = "twiizers,starlet-mini-ipc", },
+#endif
+	{ },
+};
+
+static int __init wii_device_probe(void)
+{
+	struct device_node *np;
+
+	if (!machine_is(wii))
+		return 0;
+
+	of_platform_bus_probe(NULL, wii_of_bus, NULL);
+
+	np = of_find_compatible_node(NULL, NULL, "nintendo,hollywood-mem2");
+	if (np) {
+		of_platform_device_create(np, NULL, NULL);
+		of_node_put(np);
+	}
+
+	return 0;
+}
+device_initcall(wii_device_probe);
+
-- 
1.6.3.3
