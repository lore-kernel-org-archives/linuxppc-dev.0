Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C8ECDDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 16:06:21 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l9466GTD027642
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 01:06:17 -0500
Date: Thu, 4 Oct 2007 01:05:49 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx/86xx: refactor RSTCR reset code
Message-ID: <Pine.LNX.4.64.0710040105130.8976@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On the majority of 85xx & 86xx we have a register that's ability to
assert HRESET_REQ to reset the board.  We refactored that code so it
can be shared between both platforms into fsl_soc.c and removed all
the duplication in each platform directory.

---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    6 +++
 arch/powerpc/platforms/85xx/Makefile       |    1 -
 arch/powerpc/platforms/85xx/misc.c         |   55 ----------------------------
 arch/powerpc/platforms/85xx/mpc85xx.h      |   17 ---------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |    3 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |    5 +--
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    5 +--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    4 +--
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   19 +---------
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h |   21 -----------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   20 +----------
 arch/powerpc/sysdev/fsl_soc.c              |   38 +++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h              |    1 +
 13 files changed, 53 insertions(+), 142 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/misc.c
 delete mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
 delete mode 100644 arch/powerpc/platforms/86xx/mpc8641_hpcn.h

Some code reduction for once :)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index f797662..3677659 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -214,6 +214,12 @@
 			device_type = "open-pic";
 			big-endian;
 		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
 	};

 	pcie@f8008000 {
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 25bd9e2..5eca920 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -1,7 +1,6 @@
 #
 # Makefile for the PowerPC 85xx linux kernel.
 #
-obj-$(CONFIG_PPC_85xx)	+= misc.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/misc.c b/arch/powerpc/platforms/85xx/misc.c
deleted file mode 100644
index 4fe376e..0000000
--- a/arch/powerpc/platforms/85xx/misc.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * MPC85xx generic code.
- *
- * Maintained by Kumar Gala (see MAINTAINERS for contact information)
- *
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/irq.h>
-#include <linux/module.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <sysdev/fsl_soc.h>
-
-static __be32 __iomem *rstcr;
-
-extern void abort(void);
-
-static int __init mpc85xx_rstcr(void)
-{
-	struct device_node *np;
-	np = of_find_node_by_name(NULL, "global-utilities");
-	if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {
-		const u32 *prop = of_get_property(np, "reg", NULL);
-		if (prop) {
-			/* map reset control register
-			 * 0xE00B0 is offset of reset control register
-			 */
-			rstcr = ioremap(get_immrbase() + *prop + 0xB0, 0xff);
-			if (!rstcr)
-				printk (KERN_EMERG "Error: reset control "
-						"register not mapped!\n");
-		}
-	} else
-		printk (KERN_INFO "rstcr compatible register does not exist!\n");
-	if (np)
-		of_node_put(np);
-	return 0;
-}
-
-arch_initcall(mpc85xx_rstcr);
-
-void mpc85xx_restart(char *cmd)
-{
-	local_irq_disable();
-	if (rstcr)
-		/* set reset control register */
-		out_be32(rstcr, 0x2);	/* HRESET_REQ */
-	abort();
-}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
deleted file mode 100644
index 5b34dee..0000000
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * arch/powerpc/platforms/85xx/mpc85xx.h
- *
- * MPC85xx soc definitions/function decls
- *
- * Maintainer: Kumar Gala <kumar.gala@freescale.com>
- *
- * Copyright 2005 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-extern void mpc85xx_restart(char *);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index acb1ef9..378a244 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -30,7 +30,6 @@

 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include "mpc85xx.h"

 #ifdef CONFIG_CPM2
 #include <linux/fs_enet_pd.h>
@@ -249,7 +248,7 @@ define_machine(mpc85xx_ads) {
 	.init_IRQ		= mpc85xx_ads_pic_init,
 	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= mpc85xx_restart,
+	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index abc85b8..afe5868 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -46,7 +46,6 @@

 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include "mpc85xx.h"

 static int cds_pci_slot = 2;
 static volatile u8 *cadmus;
@@ -96,7 +95,7 @@ static void mpc85xx_cds_restart(char *cmd)
 	 *  If we can't find the VIA chip (maybe the P2P bridge is disabled)
 	 *  or the VIA chip reset didn't work, just use the default reset.
 	 */
-	mpc85xx_restart(NULL);
+	fsl_rstcr_restart(NULL);
 }

 static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
@@ -343,7 +342,7 @@ define_machine(mpc85xx_cds) {
 	.restart	= mpc85xx_cds_restart,
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #else
-	.restart	= mpc85xx_restart,
+	.restart	= fsl_rstcr_restart,
 #endif
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index d60bb2b..772e8de 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -33,7 +33,6 @@

 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include "mpc85xx.h"

 #undef DEBUG

@@ -211,7 +210,7 @@ define_machine(mpc8544_ds) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= mpc85xx_restart,
+	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -225,7 +224,7 @@ define_machine(mpc8572_ds) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= mpc85xx_restart,
+	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index f8b6b08..00f4c3a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -50,8 +50,6 @@
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>

-#include "mpc85xx.h"
-
 #undef DEBUG
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -200,7 +198,7 @@ define_machine(mpc85xx_mds) {
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
-	.restart	= mpc85xx_restart,
+	.restart	= fsl_rstcr_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index c794d88..6390895 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -37,8 +37,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>

-#define MPC86XX_RSTCR_OFFSET	(0xe00b0)	/* Reset Control Register */
-
 void __init
 mpc86xx_hpcd_init_irq(void)
 {
@@ -187,21 +185,6 @@ static int __init mpc86xx_hpcd_probe(void)
 	return 0;
 }

-void
-mpc86xx_restart(char *cmd)
-{
-	void __iomem *rstcr;
-
-	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);
-
-	local_irq_disable();
-
-	/* Assert reset request to Reset Control Register */
-	out_be32(rstcr, 0x2);
-
-	/* not reached */
-}
-
 long __init
 mpc86xx_time_init(void)
 {
@@ -225,7 +208,7 @@ define_machine(mpc86xx_hpcd) {
 	.setup_arch		= mpc86xx_hpcd_setup_arch,
 	.init_IRQ		= mpc86xx_hpcd_init_irq,
 	.get_irq		= mpic_get_irq,
-	.restart		= mpc86xx_restart,
+	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
deleted file mode 100644
index 41e554c..0000000
--- a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * MPC8641 HPCN board definitions
- *
- * Copyright 2006 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * Author: Xianghua Xiao <x.xiao@freescale.com>
- */
-
-#ifndef __MPC8641_HPCN_H__
-#define __MPC8641_HPCN_H__
-
-#include <linux/init.h>
-
-#define MPC86XX_RSTCR_OFFSET	(0xe00b0)	/* Reset Control Register */
-
-#endif	/* __MPC8641_HPCN_H__ */
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 6879b83..32a531a 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -35,7 +35,6 @@
 #include <sysdev/fsl_soc.h>

 #include "mpc86xx.h"
-#include "mpc8641_hpcn.h"

 #undef DEBUG

@@ -196,23 +195,6 @@ static int __init mpc86xx_hpcn_probe(void)
 	return 0;
 }

-
-void
-mpc86xx_restart(char *cmd)
-{
-	void __iomem *rstcr;
-
-	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);
-
-	local_irq_disable();
-
-	/* Assert reset request to Reset Control Register */
-	out_be32(rstcr, 0x2);
-
-	/* not reached */
-}
-
-
 long __init
 mpc86xx_time_init(void)
 {
@@ -237,7 +219,7 @@ define_machine(mpc86xx_hpcn) {
 	.init_IRQ		= mpc86xx_hpcn_init_irq,
 	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= mpc86xx_restart,
+	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index c765d7a..f16d432 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1298,3 +1298,41 @@ err:

 	return spi_register_board_info(board_infos, num_board_infos);
 }
+
+#if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
+static __be32 __iomem *rstcr;
+
+static int __init setup_rstcr(void)
+{
+	struct device_node *np;
+	np = of_find_node_by_name(NULL, "global-utilities");
+	if ((np && of_get_property(np, "fsl,has-rstcr", NULL))) {
+		const u32 *prop = of_get_property(np, "reg", NULL);
+		if (prop) {
+			/* map reset control register
+			 * 0xE00B0 is offset of reset control register
+			 */
+			rstcr = ioremap(get_immrbase() + *prop + 0xB0, 0xff);
+			if (!rstcr)
+				printk (KERN_EMERG "Error: reset control "
+						"register not mapped!\n");
+		}
+	} else
+		printk (KERN_INFO "rstcr compatible register does not exist!\n");
+	if (np)
+		of_node_put(np);
+	return 0;
+}
+
+arch_initcall(setup_rstcr);
+
+void fsl_rstcr_restart(char *cmd)
+{
+	local_irq_disable();
+	if (rstcr)
+		/* set reset control register */
+		out_be32(rstcr, 0x2);	/* HRESET_REQ */
+
+	while (1) ;
+}
+#endif
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 618d91d..63e7db3 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -15,5 +15,6 @@ extern int fsl_spi_init(struct spi_board_info *board_infos,
 			void (*activate_cs)(u8 cs, u8 polarity),
 			void (*deactivate_cs)(u8 cs, u8 polarity));

+extern void fsl_rstcr_restart(char *cmd);
 #endif
 #endif
-- 
1.5.2.4
