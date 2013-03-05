Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07C1C2C0376
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 10:16:07 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r25NG52w024148
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Mar 2013 17:16:05 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] powerpc/fsl-booke: Add initial T4240QDS board support
Date: Tue,  5 Mar 2013 17:15:59 -0600
Message-Id: <1362525360-23136-7-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-6-git-send-email-galak@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-4-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-5-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-6-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some minor changes to the common corenet_ds.c code are needed to support
the T4240QDS:
* Add support for "fsl,qoriq-pcie-v3.0" controller
* Bump max # of IRQs to 512 (T4240 supports more interrupts than
  previous SoCs).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/Kconfig      |   17 ++++++
 arch/powerpc/platforms/85xx/Makefile     |    1 +
 arch/powerpc/platforms/85xx/corenet_ds.c |    5 +-
 arch/powerpc/platforms/85xx/t4240_qds.c  |   98 ++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index a0dcd57..31dc066 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -305,6 +305,23 @@ config PPC_QEMU_E500
 	  unset based on the emulated CPU (or actual host CPU in the case
 	  of KVM).
 
+if PPC64
+
+config T4240_QDS
+	bool "Freescale T4240 QDS"
+	select DEFAULT_UIMAGE
+	select E500
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
+	select HAS_RAPIDIO
+	select PPC_EPAPR_HV_PIC
+	help
+	  This option enables support for the T4240 QDS board
+
+endif
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 07d0dbb..712e233 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    += p5020_ds.o corenet_ds.o
 obj-$(CONFIG_P5040_DS)    += p5040_ds.o corenet_ds.o
+obj-$(CONFIG_T4240_QDS)   += t4240_qds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 6f355d8..c59c617 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -40,7 +40,7 @@ void __init corenet_ds_pic_init(void)
 	if (ppc_md.get_irq == mpic_get_coreint_irq)
 		flags |= MPIC_ENABLE_COREINT;
 
-	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
+	mpic = mpic_alloc(NULL, 0, flags, 0, 512, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 
 	mpic_init(mpic);
@@ -83,6 +83,9 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "fsl,qoriq-pcie-v2.4",
 	},
+	{
+		.compatible	= "fsl,qoriq-pcie-v3.0",
+	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",
diff --git a/arch/powerpc/platforms/85xx/t4240_qds.c b/arch/powerpc/platforms/85xx/t4240_qds.c
new file mode 100644
index 0000000..5998e9f
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/t4240_qds.c
@@ -0,0 +1,98 @@
+/*
+ * T4240 QDS Setup
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+#include <asm/ehv_pic.h>
+
+#include "corenet_ds.h"
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init t4240_qds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_is_compatible(root, "fsl,T4240QDS"))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_is_compatible(root, "fsl,T4240QDS-hv")) {
+		ppc_md.init_IRQ = ehv_pic_init;
+		ppc_md.get_irq = ehv_pic_get_irq;
+		ppc_md.restart = fsl_hv_restart;
+		ppc_md.power_off = fsl_hv_halt;
+		ppc_md.halt = fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase = NULL;
+		smp_85xx_ops.take_timebase = NULL;
+#endif
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(t4240_qds) {
+	.name			= "T4240 QDS",
+	.probe			= t4240_qds_probe,
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
+#ifdef CONFIG_PPC64
+	.power_save		= book3e_idle,
+#else
+	.power_save		= e500_idle,
+#endif
+};
+
+machine_arch_initcall(t4240_qds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(t4240_qds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.9.7
