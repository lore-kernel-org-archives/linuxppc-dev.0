Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 8D6651008B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:12 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 12/19] powerpc: gamecube: platform support
Date: Sun, 22 Nov 2009 23:01:43 +0100
Message-Id: <1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
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
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add platform support for the Nintendo GameCube video game console.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/Kconfig        |    8 ++
 arch/powerpc/platforms/embedded6xx/Makefile       |    1 +
 arch/powerpc/platforms/embedded6xx/gamecube.c     |  112 +++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/gamecube_dev.c |   34 ++++++
 4 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube_dev.c

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 29a98c6..efb2ea1 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -114,3 +114,11 @@ config FLIPPER_PIC
 	depends on GAMECUBE_COMMON
 	default y
 
+config GAMECUBE
+	bool "Nintendo-GameCube"
+	depends on EMBEDDED6xx
+	select GAMECUBE_COMMON
+	help
+	  Select GAMECUBE if configuring for the Nintendo GameCube.
+	  More information at: <http://gc-linux.sourceforge.net/>
+
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 35258fd..b0324ed 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
 obj-$(CONFIG_PPC_C2K)		+= c2k.o
 obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
 obj-$(CONFIG_FLIPPER_PIC)	+= flipper-pic.o
+obj-$(CONFIG_GAMECUBE)		+= gamecube.o gamecube_dev.o
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
new file mode 100644
index 0000000..8045a23
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -0,0 +1,112 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/gamecube.c
+ *
+ * Nintendo GameCube board-specific support
+ * Copyright (C) 2004-2009 The GameCube Linux Team
+ * Copyright (C) 2007,2008,2009 Albert Herranz
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
+#include <linux/irq.h>
+#include <linux/kexec.h>
+#include <linux/seq_file.h>
+
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+
+#include "flipper-pic.h"
+#include "usbgecko_udbg.h"
+
+
+static void gamecube_restart(char *cmd)
+{
+	local_irq_disable();
+	flipper_platform_reset();
+	/* spin until power button pressed */
+	for (;;)
+		cpu_relax();
+}
+
+static void gamecube_power_off(void)
+{
+	local_irq_disable();
+	/* spin until power button pressed */
+	for (;;)
+		cpu_relax();
+}
+
+static void gamecube_halt(void)
+{
+	gamecube_restart(NULL);
+}
+
+static void gamecube_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: IBM\n");
+	seq_printf(m, "machine\t\t: Nintendo GameCube\n");
+}
+
+static void gamecube_setup_arch(void)
+{
+	/* currently not used */
+}
+
+static void __init gamecube_init_early(void)
+{
+	ug_udbg_init();
+}
+
+static int __init gamecube_probe(void)
+{
+	unsigned long dt_root;
+
+	dt_root = of_get_flat_dt_root();
+	if (!of_flat_dt_is_compatible(dt_root, "nintendo,gamecube"))
+		return 0;
+
+	return 1;
+}
+
+static void gamecube_shutdown(void)
+{
+	/* currently not used */
+}
+
+#ifdef CONFIG_KEXEC
+static int gamecube_kexec_prepare(struct kimage *image)
+{
+	return 0;
+}
+#endif /* CONFIG_KEXEC */
+
+
+define_machine(gamecube) {
+	.name			= "gamecube",
+	.probe			= gamecube_probe,
+	.setup_arch		= gamecube_setup_arch,
+	.init_early		= gamecube_init_early,
+	.show_cpuinfo		= gamecube_show_cpuinfo,
+	.restart		= gamecube_restart,
+	.power_off		= gamecube_power_off,
+	.halt			= gamecube_halt,
+	.init_IRQ		= flipper_pic_probe,
+	.get_irq		= flipper_pic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+	.machine_shutdown	= gamecube_shutdown,
+#ifdef CONFIG_KEXEC
+	.machine_kexec_prepare	= gamecube_kexec_prepare,
+	.machine_kexec		= default_machine_kexec,
+#endif
+};
+
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube_dev.c b/arch/powerpc/platforms/embedded6xx/gamecube_dev.c
new file mode 100644
index 0000000..13e1f73
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/gamecube_dev.c
@@ -0,0 +1,34 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/gamecube_dev.c
+ *
+ * Nintendo GameCube platform device setup.
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
+static struct of_device_id gamecube_of_bus[] = {
+	{ .compatible = "nintendo,flipper", },
+	{ },
+};
+
+static int __init gamecube_device_probe(void)
+{
+	if (!machine_is(gamecube))
+		return 0;
+
+	of_platform_bus_probe(NULL, gamecube_of_bus, NULL);
+	return 0;
+}
+device_initcall(gamecube_device_probe);
-- 
1.6.3.3
