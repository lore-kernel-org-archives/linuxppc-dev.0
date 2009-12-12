Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id C17E1B7C65
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 03:32:10 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 09/22] powerpc: gamecube: platform support
Date: Sat, 12 Dec 2009 17:31:42 +0100
Message-Id: <1260635515-7478-10-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
References: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
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
 arch/powerpc/platforms/embedded6xx/Kconfig    |    8 ++
 arch/powerpc/platforms/embedded6xx/Makefile   |    1 +
 arch/powerpc/platforms/embedded6xx/gamecube.c |  118 +++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube.c

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 464e414..e318ced 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -107,3 +107,11 @@ config USBGECKO_UDBG
 
 	  If in doubt, say N here.
 
+config GAMECUBE
+	bool "Nintendo-GameCube"
+	depends on EMBEDDED6xx
+	select GAMECUBE_COMMON
+	help
+	  Select GAMECUBE if configuring for the Nintendo GameCube.
+	  More information at: <http://gc-linux.sourceforge.net/>
+
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index b80f47c..9365edd 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
 obj-$(CONFIG_PPC_C2K)		+= c2k.o
 obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
 obj-$(CONFIG_GAMECUBE_COMMON)	+= flipper-pic.o
+obj-$(CONFIG_GAMECUBE)		+= gamecube.o
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
new file mode 100644
index 0000000..1106fd9
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -0,0 +1,118 @@
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
+#include <linux/of_platform.h>
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
+static void gamecube_spin(void)
+{
+	/* spin until power button pressed */
+	for (;;)
+		cpu_relax();
+}
+
+static void gamecube_restart(char *cmd)
+{
+	local_irq_disable();
+	flipper_platform_reset();
+	gamecube_spin();
+}
+
+static void gamecube_power_off(void)
+{
+	local_irq_disable();
+	gamecube_spin();
+}
+
+static void gamecube_halt(void)
+{
+	gamecube_restart(NULL);
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
+	flipper_quiesce();
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
+	.init_early		= gamecube_init_early,
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
+#endif
+};
+
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
+
-- 
1.6.3.3
