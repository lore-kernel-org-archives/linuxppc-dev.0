Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2E582C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:55:24 +1100 (EST)
Received: from mail23-tx2 (localhost [127.0.0.1])	by mail23-tx2-R.bigfish.com
 (Postfix) with ESMTP id 5B30E4801B8	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 15 Mar 2013 07:55:20 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.235])	by
 mail23-tx2.bigfish.com (Postfix) with ESMTP id CA1EB10006D	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 07:55:17 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 5/6] powerpc/fsl-booke: Add B4_QDS board support
Date: Fri, 15 Mar 2013 13:25:08 +0530
Message-ID: <1363334109-21922-5-git-send-email-shaveta@freescale.com>
In-Reply-To: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add support for B4 board's personalities in board file
  b4_qds.c, It is common for B4 personalities B4860 and B4420QDS
- Add B4QDS support in Kconfig and Makefile

B4860QDS is a high-performance computing evaluation, development and
test platform supporting the B4860 QorIQ Power Architecture processor,
with following major features:

    - Four dual-threaded e6500 Power Architecture processors
      organized in one cluster-each core runs up to 1.8 GHz
    - Two DDR3/3L controllers for high-speed memory interface each
      runs at up to 1866.67 MHz
    - CoreNet fabric that fully supports coherency using MESI protocol
      between the e6500 cores, SC3900 FVP cores, memories and
      external interfaces.
    - Data Path Acceleration Architecture having FMAN, QMan, BMan, SEC 5.3 and RMAN
    - Large internal cache memory with snooping and stashing capabilities
    - Sixteen 10-GHz SerDes lanes that serve:
        - Two SRIO interfaces. Each supports up to 4 lanes and
          a total of up to 8 lanes
        - Up to 8-lanes Common Public Radio Interface (CPRI) controller
          for glue-less antenna connection
        - Two 10-Gbit Ethernet controllers (10GEC)
        - Six 1G/2.5-Gbit Ethernet controllers for network communications
        - PCI Express controller
        - Debug (Aurora)
    - Various system peripherals

B4420 is a reduced personality of B4860 with fewer core/clusters(both SC3900 and e6500),
fewer DDR controllers, fewer serdes lanes, fewer SGMII interfaces and reduced target frequencies.

Key differences between B4860 and B4420:
B4420 has:
    - Fewer e6500 cores:
        1 cluster with 2 e6500 cores
    - Fewer SC3900 cores/clusters:
        1 cluster with 2 SC3900 cores per cluster
    - Single DDRC
    - 2X 4 lane serdes
    - 3 SGMII interfaces
    - no sRIO
    - no 10G

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig  |   16 +++++
 arch/powerpc/platforms/85xx/Makefile |    1 +
 arch/powerpc/platforms/85xx/b4_qds.c |  102 ++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/b4_qds.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 31dc066..7bbd522 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -262,6 +262,22 @@ config SGY_CTS1000
 
 endif # PPC32
 
+config B4_QDS
+	bool "Freescale B4 QDS"
+	select DEFAULT_UIMAGE
+	select E500
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select MPC8xxx_GPIO
+	select HAS_RAPIDIO
+	select PPC_EPAPR_HV_PIC
+	help
+	  This option enables support for the B4 QDS board
+	  The B4 application development system B4 QDS is a complete
+	  debugging environment intended for engineers developing
+	  applications for the B4.
+
 config P5020_DS
 	bool "Freescale P5020 DS"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 712e233..a12ae2d 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SMP) += smp.o
 obj-y += common.o
 
 obj-$(CONFIG_BSC9131_RDB) += bsc913x_rdb.o
+obj-$(CONFIG_B4_QDS)   += b4_qds.o corenet_ds.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/b4_qds.c b/arch/powerpc/platforms/85xx/b4_qds.c
new file mode 100644
index 0000000..0c6702f
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/b4_qds.c
@@ -0,0 +1,102 @@
+/*
+ * B4 QDS Setup
+ * Should apply for QDS platform of B4860 and it's personalities.
+ * viz B4860/B4420/B4220QDS
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
+static int __init b4_qds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if ((of_flat_dt_is_compatible(root, "fsl,B4860QDS")) ||
+		(of_flat_dt_is_compatible(root, "fsl,B4420QDS")) ||
+			(of_flat_dt_is_compatible(root, "fsl,B4220QDS")))
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if ((of_flat_dt_is_compatible(root, "fsl,B4860QDS-hv")) ||
+		(of_flat_dt_is_compatible(root, "fsl,B4420QDS-hv")) ||
+			(of_flat_dt_is_compatible(root, "fsl,B4220QDS-hv"))) {
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
+define_machine(b4_qds) {
+	.name			= "B4 QDS",
+	.probe			= b4_qds_probe,
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
+machine_arch_initcall(b4_qds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(b4_qds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.6.GIT
