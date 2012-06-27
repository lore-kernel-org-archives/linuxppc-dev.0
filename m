Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6CDC100802
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 09:50:16 +1000 (EST)
Date: Wed, 27 Jun 2012 18:50:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/e500: add paravirt QEMU platform
Message-ID: <20120627235005.GB9100@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120627234851.GA9071@tyr.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This gives the kernel a paravirtualized machine to target, without
requiring both sides to pretend to be targeting a specific board
that likely has little to do with the host in KVM scenarios.  This
avoids the need to add new boards to QEMU just to be able to
run KVM on new CPUs.

As this is the first platform that can run with either e500v2 or
e500mc, CONFIG_PPC_E500MC is now a legitimately user configurable
option, so add a help text.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/Kconfig     |   16 +++++++
 arch/powerpc/platforms/85xx/Makefile    |    1 +
 arch/powerpc/platforms/85xx/qemu_e500.c |   66 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype  |    4 ++
 4 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/qemu_e500.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f000d81..7bbebe5 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -263,6 +263,22 @@ config P5020_DS
 	help
 	  This option enables support for the P5020 DS board
 
+config PPC_QEMU_E500
+	bool "QEMU generic e500 platform"
+	depends on EXPERIMENTAL
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for running as a QEMU guest using
+	  QEMU's generic e500 machine.  This is not required if you're
+	  using a QEMU machine that targets a specific board, such as
+	  mpc8544ds.
+
+	  Unlike most e500 boards that target a specific CPU, this
+	  platform works with any e500-family CPU that QEMU supports.
+	  Thus, you'll need to make sure CONFIG_PPC_E500MC is set or
+	  unset based on the emulated CPU (or actual host CPU in the case
+	  of KVM).
+
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 2125d4c..f841ac8 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
 obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
 obj-$(CONFIG_GE_IMP3A)	  += ge_imp3a.o
+obj-$(CONFIG_PPC_QEMU_E500) += qemu_e500.o
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
new file mode 100644
index 0000000..77c8d5d
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -0,0 +1,66 @@
+/*
+ * Paravirt target for a generic QEMU e500 machine
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
+#include <linux/of_fdt.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include "smp.h"
+#include "mpc85xx.h"
+
+void __init qemu_e500_pic_init(void)
+{
+	struct mpic *mpic;
+
+	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU,
+			0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	mpic_init(mpic);
+}
+
+static void __init qemu_e500_setup_arch(void)
+{
+	ppc_md.progress("qemu_e500_setup_arch()", 0);
+
+	fsl_pci_init();
+	mpc85xx_smp_init();
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init qemu_e500_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return !!of_flat_dt_is_compatible(root, "fsl,qemu-e500");
+}
+
+machine_device_initcall(qemu_e500, mpc85xx_common_publish_devices);
+
+define_machine(qemu_e500) {
+	.name			= "QEMU e500",
+	.probe			= qemu_e500_probe,
+	.setup_arch		= qemu_e500_setup_arch,
+	.init_IRQ		= qemu_e500_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 61c9550..30fd01d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -159,6 +159,10 @@ config PPC_E500MC
 	bool "e500mc Support"
 	select PPC_FPU
 	depends on E500
+	help
+	  This must be enabled for running on e500mc (and derivatives
+	  such as e5500/e6500), and must be disabled for running on
+	  e500v1 or e500v2.
 
 config PPC_FPU
 	bool
-- 
1.7.5.4
