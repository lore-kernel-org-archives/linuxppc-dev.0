Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 1A99CDDFAA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:13:52 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 6ED0114311
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:52 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08109-04 for <linuxppc-dev@ozlabs.org>;
	Wed, 24 Oct 2007 01:13:50 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id BF619142C1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:13:50 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH 04/11] [POWERPC] Add generic support for MPC5200 based boards
To: linuxppc-dev@ozlabs.org
Date: Wed, 24 Oct 2007 01:13:27 +0200
Message-ID: <20071023231327.29359.28666.stgit@hekate.izotz.org>
In-Reply-To: <20071023231302.29359.27417.stgit@hekate.izotz.org>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for 'generic-mpc5200' compatible
boards which do not need a platform specific setup.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/platforms/52xx/Kconfig           |    8 ++-
 arch/powerpc/platforms/52xx/Makefile          |    1 
 arch/powerpc/platforms/52xx/generic_mpc5200.c |   63 +++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/generic_mpc5200.c


diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 2938d49..59c67b5 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -19,6 +19,12 @@ config PPC_MPC5200_BUGFIX
 
 	  It is safe to say 'Y' here
 
+config PPC_GENERIC_MPC5200
+	bool "Generic support for MPC5200 based boards"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select PPC_MPC5200
+	default n
+
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
 	depends on PPC_MULTIPLATFORM && PPC32
@@ -34,5 +40,3 @@ config PPC_LITE5200
 	select WANT_DEVICE_TREE
 	select PPC_MPC5200
 	default n
-
-
diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index 307dbc1..bea05df 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -6,6 +6,7 @@ obj-y				+= mpc52xx_pic.o mpc52xx_common.o
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 endif
 
+obj-$(CONFIG_PPC_GENERIC_MPC5200) += generic_mpc5200.o
 obj-$(CONFIG_PPC_EFIKA)		+= efika.o
 obj-$(CONFIG_PPC_LITE5200)	+= lite5200.o
 
diff --git a/arch/powerpc/platforms/52xx/generic_mpc5200.c b/arch/powerpc/platforms/52xx/generic_mpc5200.c
new file mode 100644
index 0000000..a4ec899
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/generic_mpc5200.c
@@ -0,0 +1,63 @@
+/*
+ * Support for 'generic-mpc5200' compatible platforms.
+ *
+ * Written by Marian Balakowicz <m8@semihalf.com>
+ * Copyright (C) 2007 Semihalf
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#undef DEBUG
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+
+/*
+ * Setup the architecture
+ */
+static void __init generic_mpc5200_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("generic_mpc5200_setup_arch()", 0);
+
+	/* Some mpc5200 & mpc5200b related configuration */
+	mpc5200_setup_xlb_arbiter();
+
+	/* Map wdt for mpc52xx_restart() */
+	mpc52xx_map_wdt();
+
+#ifdef CONFIG_PCI
+	mpc52xx_setup_pci();
+#endif
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init generic_mpc5200_probe(void)
+{
+	unsigned long node = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(node, "generic-mpc5200"))
+		return 0;
+	return 1;
+}
+
+define_machine(generic_mpc5200) {
+	.name		= "generic-mpc5200",
+	.probe		= generic_mpc5200_probe,
+	.setup_arch	= generic_mpc5200_setup_arch,
+	.init		= mpc52xx_declare_of_platform_devices,
+	.init_IRQ	= mpc52xx_init_irq,
+	.get_irq	= mpc52xx_get_irq,
+	.restart	= mpc52xx_restart,
+	.calibrate_decr	= generic_calibrate_decr,
+};
