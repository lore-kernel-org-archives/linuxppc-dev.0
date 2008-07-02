Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5379DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 03:42:55 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m62HgoFc001947
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 12:42:51 -0500
Date: Wed, 2 Jul 2008 12:42:50 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/86xx: Refactor pic init
Message-ID: <Pine.LNX.4.64.0807021242260.10323@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved the pic initialization into its own common file and out of the board
code.  Also fixed the OF reference counting on the mpic node.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

in my powerpc-next tree.

- k

 arch/powerpc/platforms/86xx/Makefile       |    1 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   26 +--------
 arch/powerpc/platforms/86xx/mpc86xx.h      |    3 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   64 +----------------------
 arch/powerpc/platforms/86xx/pic.c          |   78 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/sbc8641d.c     |   25 +---------
 6 files changed, 86 insertions(+), 111 deletions(-)
 create mode 100644 arch/powerpc/platforms/86xx/pic.c

diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 1b9b4a9..8fee37d 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 86xx linux kernel.
 #

+obj-y				:= pic.o
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
 obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index eb16208..3072530 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -39,6 +39,8 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>

+#include "mpc86xx.h"
+
 static unsigned char *pixis_bdcfg0, *pixis_arch;

 static struct of_device_id __initdata mpc8610_ids[] = {
@@ -56,28 +58,6 @@ static int __init mpc8610_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);

-static void __init mpc86xx_hpcd_init_irq(void)
-{
-	struct mpic *mpic1;
-	struct device_node *np;
-	struct resource res;
-
-	/* Determine PIC address. */
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL)
-		return;
-	of_address_to_resource(np, 0, &res);
-
-	/* Alloc mpic structure and per isu has 16 INT entries. */
-	mpic1 = mpic_alloc(np, res.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET |
-			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
-			0, 256, " MPIC     ");
-	BUG_ON(mpic1 == NULL);
-
-	mpic_init(mpic1);
-}
-
 #ifdef CONFIG_PCI
 static void __devinit quirk_uli1575(struct pci_dev *dev)
 {
@@ -405,7 +385,7 @@ define_machine(mpc86xx_hpcd) {
 	.name			= "MPC86xx HPCD",
 	.probe			= mpc86xx_hpcd_probe,
 	.setup_arch		= mpc86xx_hpcd_setup_arch,
-	.init_IRQ		= mpc86xx_hpcd_init_irq,
+	.init_IRQ		= mpc86xx_init_irq,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h b/arch/powerpc/platforms/86xx/mpc86xx.h
index 525ffa1..08efb57 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx.h
+++ b/arch/powerpc/platforms/86xx/mpc86xx.h
@@ -15,6 +15,7 @@
  * mpc86xx_* files. Mostly for use by mpc86xx_setup().
  */

-extern void __init mpc86xx_smp_init(void);
+extern void mpc86xx_smp_init(void);
+extern void mpc86xx_init_irq(void);

 #endif	/* __MPC86XX_H__ */
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index f13704a..7916599 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -28,7 +28,6 @@
 #include <asm/prom.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
-#include <asm/i8259.h>

 #include <asm/mpic.h>

@@ -46,67 +45,6 @@
 #endif

 #ifdef CONFIG_PCI
-static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned int cascade_irq = i8259_irq();
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
-}
-#endif	/* CONFIG_PCI */
-
-static void __init
-mpc86xx_hpcn_init_irq(void)
-{
-	struct mpic *mpic1;
-	struct device_node *np;
-	struct resource res;
-#ifdef CONFIG_PCI
-	struct device_node *cascade_node = NULL;
-	int cascade_irq;
-#endif
-
-	/* Determine PIC address. */
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL)
-		return;
-	of_address_to_resource(np, 0, &res);
-
-	/* Alloc mpic structure and per isu has 16 INT entries. */
-	mpic1 = mpic_alloc(np, res.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " MPIC     ");
-	BUG_ON(mpic1 == NULL);
-
-	mpic_init(mpic1);
-
-#ifdef CONFIG_PCI
-	/* Initialize i8259 controller */
-	for_each_node_by_type(np, "interrupt-controller")
-		if (of_device_is_compatible(np, "chrp,iic")) {
-			cascade_node = np;
-			break;
-		}
-	if (cascade_node == NULL) {
-		printk(KERN_DEBUG "mpc86xxhpcn: no ISA interrupt controller\n");
-		return;
-	}
-
-	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (cascade_irq == NO_IRQ) {
-		printk(KERN_ERR "mpc86xxhpcn: failed to map cascade interrupt");
-		return;
-	}
-	DBG("mpc86xxhpcn: cascade mapped to irq %d\n", cascade_irq);
-
-	i8259_init(cascade_node, 0);
-	of_node_put(cascade_node);
-
-	set_irq_chained_handler(cascade_irq, mpc86xx_8259_cascade);
-#endif
-}
-
-#ifdef CONFIG_PCI
 extern int uses_fsl_uli_m1575;
 extern int uli_exclude_device(struct pci_controller *hose,
 				u_char bus, u_char devfn);
@@ -237,7 +175,7 @@ define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
 	.probe			= mpc86xx_hpcn_probe,
 	.setup_arch		= mpc86xx_hpcn_setup_arch,
-	.init_IRQ		= mpc86xx_hpcn_init_irq,
+	.init_IRQ		= mpc86xx_init_irq,
 	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
new file mode 100644
index 0000000..8881c5d
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2008 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/mpic.h>
+#include <asm/i8259.h>
+
+#ifdef CONFIG_PPC_I8259
+static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq = i8259_irq();
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+	desc->chip->eoi(irq);
+}
+#endif	/* CONFIG_PPC_I8259 */
+
+void __init mpc86xx_init_irq(void)
+{
+	struct mpic *mpic;
+	struct device_node *np;
+	struct resource res;
+#ifdef CONFIG_PPC_I8259
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+#endif
+
+	/* Determine PIC address. */
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL)
+		return;
+	of_address_to_resource(np, 0, &res);
+
+	mpic = mpic_alloc(np, res.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET |
+			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
+			0, 256, " MPIC     ");
+	of_node_put(np);
+	BUG_ON(mpic == NULL);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_PPC_I8259
+	/* Initialize i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+		if (of_device_is_compatible(np, "chrp,iic")) {
+			cascade_node = np;
+			break;
+		}
+
+	if (cascade_node == NULL) {
+		printk(KERN_DEBUG "Could not find i8259 PIC\n");
+		return;
+	}
+
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (cascade_irq == NO_IRQ) {
+		printk(KERN_ERR "Failed to map cascade interrupt\n");
+		return;
+	}
+
+	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
+	set_irq_chained_handler(cascade_irq, mpc86xx_8259_cascade);
+#endif
+}
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 510a06e..00e6fad 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -38,29 +38,6 @@
 #include "mpc86xx.h"

 static void __init
-sbc8641_init_irq(void)
-{
-	struct mpic *mpic1;
-	struct device_node *np;
-	struct resource res;
-
-	/* Determine PIC address. */
-	np = of_find_node_by_type(NULL, "open-pic");
-	if (np == NULL)
-		return;
-	of_address_to_resource(np, 0, &res);
-
-	/* Alloc mpic structure and per isu has 16 INT entries. */
-	mpic1 = mpic_alloc(np, res.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " MPIC     ");
-	of_node_put(np);
-	BUG_ON(mpic1 == NULL);
-
-	mpic_init(mpic1);
-}
-
-static void __init
 sbc8641_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -151,7 +128,7 @@ define_machine(sbc8641) {
 	.name			= "SBC8641D",
 	.probe			= sbc8641_probe,
 	.setup_arch		= sbc8641_setup_arch,
-	.init_IRQ		= sbc8641_init_irq,
+	.init_IRQ		= mpc86xx_init_irq,
 	.show_cpuinfo		= sbc8641_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
-- 
1.5.5.1
