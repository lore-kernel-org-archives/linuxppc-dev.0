Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C58E1B70D9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 00:17:17 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o9DDHEPE006520
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 08:17:14 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] powerpc/fsl-booke: Add p5020 DS board support
Date: Wed, 13 Oct 2010 08:17:12 -0500
Message-Id: <1286975832-31895-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286975832-31895-1-git-send-email-galak@kernel.crashing.org>
References: <1286975832-31895-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The P5020DS is in the same family of boards as the P4080 DS and thus
shares the corenet_ds code.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Updated based on e5500 support patch

 arch/powerpc/platforms/85xx/Kconfig    |   13 ++++++
 arch/powerpc/platforms/85xx/Makefile   |    1 +
 arch/powerpc/platforms/85xx/p5020_ds.c |   69 ++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index ae25527..2830e0a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -181,6 +181,19 @@ config P4080_DS
 
 endif # PPC32
 
+config P5020_DS
+	bool "Freescale P5020 DS"
+	select DEFAULT_UIMAGE
+	select PPC_FSL_BOOK3E
+	select E500
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select MPC8xxx_GPIO
+	select HAS_RAPIDIO
+	help
+	  This option enables support for the P5020 DS board
+
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index c3ac071..dd70db7 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
+obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8560)     += sbc8560.o
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
new file mode 100644
index 0000000..7467b71
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -0,0 +1,69 @@
+/*
+ * P5020 DS Setup
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2009-2010 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/phy.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <linux/of_platform.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#include "corenet_ds.h"
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p5020_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P5020DS");
+}
+
+define_machine(p5020_ds) {
+	.name			= "P5020 DS",
+	.probe			= p5020_ds_probe,
+	.setup_arch		= corenet_ds_setup_arch,
+	.init_IRQ		= corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
+#ifdef CONFIG_PPC64
+	.get_irq		= mpic_get_irq,
+#else
+	.get_irq		= mpic_get_coreint_irq,
+#endif
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+machine_device_initcall(p5020_ds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(p5020_ds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.2.3
