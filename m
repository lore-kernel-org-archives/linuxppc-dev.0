Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1488D2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:27:00 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 2/3] powerpc/e500: add paravirt QEMU platform
Date: Tue, 10 Jul 2012 19:26:48 -0500
Message-ID: <1341966409-22660-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1341966409-22660-1-git-send-email-scottwood@freescale.com>
References: <1341966409-22660-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>
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
v2: Added a comment about the flexible nature of this platform, and
rebased on Kumar's next

 arch/powerpc/platforms/85xx/Kconfig     |   16 +++++++
 arch/powerpc/platforms/85xx/Makefile    |    1 +
 arch/powerpc/platforms/85xx/qemu_e500.c |   72 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype  |    4 ++
 4 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/qemu_e500.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index dddb3e5..159c01e 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -254,6 +254,22 @@ config P5020_DS
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
index 30652e0..3dfe811 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
 obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
 obj-$(CONFIG_GE_IMP3A)	  += ge_imp3a.o
+obj-$(CONFIG_PPC_QEMU_E500) += qemu_e500.o
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
new file mode 100644
index 0000000..95a2e53
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -0,0 +1,72 @@
+/*
+ * Paravirt target for a generic QEMU e500 machine
+ *
+ * This is intended to be a flexible device-tree-driven platform, not fixed
+ * to a particular piece of hardware or a particular spec of virtual hardware,
+ * beyond the assumption of an e500-family CPU.  Some things are still hardcoded
+ * here, such as MPIC, but this is a limitation of the current code rather than
+ * an interface contract with QEMU.
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
