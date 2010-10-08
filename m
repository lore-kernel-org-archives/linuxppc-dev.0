Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDFB7B7150
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:04 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J70ac005825
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:07:01 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/11] powerpc/fsl-booke: Add p3041 DS board support
Date: Fri,  8 Oct 2010 14:06:46 -0500
Message-Id: <1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The P3041DS is in the same family of boards as the P4080DS and thus
shares the corenet_ds code.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig    |   12 ++++++
 arch/powerpc/platforms/85xx/Makefile   |    1 +
 arch/powerpc/platforms/85xx/p3041_ds.c |   64 ++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index bea1f59..5bde1f2 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -153,6 +153,18 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board
 
+config P3041_DS
+	bool "Freescale P3041 DS"
+	select DEFAULT_UIMAGE
+	select PPC_FSL_BOOK3E
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select MPC8xxx_GPIO
+	select HAS_RAPIDIO
+	help
+	  This option enables support for the P3041 DS board
+
 config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index a2ec3f8..c3ac071 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
+obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
new file mode 100644
index 0000000..0ed52e1
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p3041_ds.c
@@ -0,0 +1,64 @@
+/*
+ * P3041 DS Setup
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
+static int __init p3041_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P3041DS");
+}
+
+define_machine(p3041_ds) {
+	.name			= "P3041 DS",
+	.probe			= p3041_ds_probe,
+	.setup_arch		= corenet_ds_setup_arch,
+	.init_IRQ		= corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_coreint_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+machine_device_initcall(p3041_ds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(p3041_ds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.2.3
