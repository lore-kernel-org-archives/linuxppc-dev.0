Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F5E2DDEC0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 01:25:47 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7RFPhDR002406
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 10:25:44 -0500
Date: Mon, 27 Aug 2007 10:25:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: Renamed mpc8544_ds.c to mpc85xx_ds.c
Message-ID: <Pine.LNX.4.64.0708271025170.15438@blarg.am.freescale.net>
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

Renamed the mpc8544_ds.c board code to mpc85xx_ds.c to make it more
generic in prep for other boards based on the same platform.

---

Posted for review.

 arch/powerpc/platforms/85xx/Kconfig      |    8 +-
 arch/powerpc/platforms/85xx/Makefile     |    2 +-
 arch/powerpc/platforms/85xx/mpc8544_ds.c |  186 ------------------------------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |  186 ++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 191 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/mpc8544_ds.c
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_ds.c

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f620171..b8476b2 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -29,13 +29,13 @@ config MPC85xx_MDS
 	help
 	  This option enables support for the MPC85xx MDS board

-config MPC8544_DS
-	bool "Freescale MPC8544 DS"
+config MPC85xx_DS
+	bool "Freescale MPC85xx DS"
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575
 	help
-	  This option enables support for the MPC8544 DS board
+	  This option enables support for the MPC85xx DS (MPC8544 DS) board

 endchoice

@@ -58,4 +58,4 @@ config MPC85xx
 	select FSL_PCI if PCI
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
-		|| MPC85xx_MDS || MPC8544_DS
+		|| MPC85xx_MDS || MPC85xx_DS
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index d70f2d0..25bd9e2 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -5,5 +5,5 @@ obj-$(CONFIG_PPC_85xx)	+= misc.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
-obj-$(CONFIG_MPC8544_DS)  += mpc8544_ds.o
+obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
deleted file mode 100644
index 0f834d8..0000000
--- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- * MPC8544 DS Board Setup
- *
- * Author Xianghua Xiao (x.xiao@freescale.com)
- * Roy Zang <tie-fei.zang@freescale.com>
- * 	- Add PCI/PCI Exprees support
- * Copyright 2007 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/kdev_t.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/interrupt.h>
-
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpc85xx.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/mpic.h>
-#include <asm/i8259.h>
-
-#include <sysdev/fsl_soc.h>
-#include <sysdev/fsl_pci.h>
-#include "mpc85xx.h"
-
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
-#else
-#define DBG(fmt, args...)
-#endif
-
-#ifdef CONFIG_PPC_I8259
-static void mpc8544_8259_cascade(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned int cascade_irq = i8259_irq();
-
-	if (cascade_irq != NO_IRQ) {
-		generic_handle_irq(cascade_irq);
-	}
-	desc->chip->eoi(irq);
-}
-#endif	/* CONFIG_PPC_I8259 */
-
-void __init mpc8544_ds_pic_init(void)
-{
-	struct mpic *mpic;
-	struct resource r;
-	struct device_node *np = NULL;
-#ifdef CONFIG_PPC_I8259
-	struct device_node *cascade_node = NULL;
-	int cascade_irq;
-#endif
-
-	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
-		printk(KERN_ERR "Could not find open-pic node\n");
-		return;
-	}
-
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "Failed to map mpic register space\n");
-		of_node_put(np);
-		return;
-	}
-
-	mpic = mpic_alloc(np, r.start,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
-	BUG_ON(mpic == NULL);
-
-	mpic_init(mpic);
-
-#ifdef CONFIG_PPC_I8259
-	/* Initialize the i8259 controller */
-	for_each_node_by_type(np, "interrupt-controller")
-	    if (of_device_is_compatible(np, "chrp,iic")) {
-		cascade_node = np;
-		break;
-	}
-
-	if (cascade_node == NULL) {
-		printk(KERN_DEBUG "Could not find i8259 PIC\n");
-		return;
-	}
-
-	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (cascade_irq == NO_IRQ) {
-		printk(KERN_ERR "Failed to map cascade interrupt\n");
-		return;
-	}
-
-	DBG("mpc8544ds: cascade mapped to irq %d\n", cascade_irq);
-
-	i8259_init(cascade_node, 0);
-	of_node_put(cascade_node);
-
-	set_irq_chained_handler(cascade_irq, mpc8544_8259_cascade);
-#endif	/* CONFIG_PPC_I8259 */
-}
-
-#ifdef CONFIG_PCI
-extern int uses_fsl_uli_m1575;
-extern int uli_exclude_device(struct pci_controller *hose,
-				u_char bus, u_char devfn);
-
-static int mpc85xx_exclude_device(struct pci_controller *hose,
-				   u_char bus, u_char devfn)
-{
-	struct device_node* node;
-	struct resource rsrc;
-
-	node = (struct device_node *)hose->arch_data;
-	of_address_to_resource(node, 0, &rsrc);
-
-	if ((rsrc.start & 0xfffff) == 0xb000) {
-		return uli_exclude_device(hose, bus, devfn);
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-#endif	/* CONFIG_PCI */
-
-/*
- * Setup the architecture
- */
-static void __init mpc8544_ds_setup_arch(void)
-{
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc8544_ds_setup_arch()", 0);
-
-#ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
-		struct resource rsrc;
-		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == 0xb000)
-			fsl_add_bridge(np, 1);
-		else
-			fsl_add_bridge(np, 0);
-	}
-	uses_fsl_uli_m1575 = 1;
-	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
-#endif
-
-	printk("MPC8544 DS board from Freescale Semiconductor\n");
-}
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init mpc8544_ds_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "MPC8544DS");
-}
-
-define_machine(mpc8544_ds) {
-	.name			= "MPC8544 DS",
-	.probe			= mpc8544_ds_probe,
-	.setup_arch		= mpc8544_ds_setup_arch,
-	.init_IRQ		= mpc8544_ds_pic_init,
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.get_irq		= mpic_get_irq,
-	.restart		= mpc85xx_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= udbg_progress,
-};
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
new file mode 100644
index 0000000..0f834d8
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -0,0 +1,186 @@
+/*
+ * MPC8544 DS Board Setup
+ *
+ * Author Xianghua Xiao (x.xiao@freescale.com)
+ * Roy Zang <tie-fei.zang@freescale.com>
+ * 	- Add PCI/PCI Exprees support
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc85xx.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <asm/i8259.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include "mpc85xx.h"
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+#ifdef CONFIG_PPC_I8259
+static void mpc8544_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq = i8259_irq();
+
+	if (cascade_irq != NO_IRQ) {
+		generic_handle_irq(cascade_irq);
+	}
+	desc->chip->eoi(irq);
+}
+#endif	/* CONFIG_PPC_I8259 */
+
+void __init mpc8544_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+#ifdef CONFIG_PPC_I8259
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+#endif
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			  MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_PPC_I8259
+	/* Initialize the i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+	    if (of_device_is_compatible(np, "chrp,iic")) {
+		cascade_node = np;
+		break;
+	}
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
+	DBG("mpc8544ds: cascade mapped to irq %d\n", cascade_irq);
+
+	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
+	set_irq_chained_handler(cascade_irq, mpc8544_8259_cascade);
+#endif	/* CONFIG_PPC_I8259 */
+}
+
+#ifdef CONFIG_PCI
+extern int uses_fsl_uli_m1575;
+extern int uli_exclude_device(struct pci_controller *hose,
+				u_char bus, u_char devfn);
+
+static int mpc85xx_exclude_device(struct pci_controller *hose,
+				   u_char bus, u_char devfn)
+{
+	struct device_node* node;
+	struct resource rsrc;
+
+	node = (struct device_node *)hose->arch_data;
+	of_address_to_resource(node, 0, &rsrc);
+
+	if ((rsrc.start & 0xfffff) == 0xb000) {
+		return uli_exclude_device(hose, bus, devfn);
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+#endif	/* CONFIG_PCI */
+
+/*
+ * Setup the architecture
+ */
+static void __init mpc8544_ds_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8544_ds_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 0xb000)
+			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
+	}
+	uses_fsl_uli_m1575 = 1;
+	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
+#endif
+
+	printk("MPC8544 DS board from Freescale Semiconductor\n");
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc8544_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "MPC8544DS");
+}
+
+define_machine(mpc8544_ds) {
+	.name			= "MPC8544 DS",
+	.probe			= mpc8544_ds_probe,
+	.setup_arch		= mpc8544_ds_setup_arch,
+	.init_IRQ		= mpc8544_ds_pic_init,
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+	.get_irq		= mpic_get_irq,
+	.restart		= mpc85xx_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.2.4
