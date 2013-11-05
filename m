Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 881332C03D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 16:32:11 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: =?UTF-8?q?=5BPATCH=206/7=5D=20IBM=20Currituck=3A=20Clean=20up=20board=20specific=20code=20before=20adding=20Akebono=20code?=
Date: Tue,  5 Nov 2013 16:31:10 +1100
Message-Id: <1383629471-16979-6-git-send-email-alistair@popple.id.au>
In-Reply-To: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IBM Akebono code uses the same initialisation functions as the
earlier Currituck board. Rather than create a copy of this code for
Akebono we will instead integrate support for it into the same file as
the Currituck code.

This patch simply renames the file.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/44x/Makefile    |    2 +-
 arch/powerpc/platforms/44x/currituck.c |  233 --------------------------------
 arch/powerpc/platforms/44x/ppc476fpe.c |  233 ++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+), 234 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/currituck.c
 create mode 100644 arch/powerpc/platforms/44x/ppc476fpe.c

diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index d03833a..c4fe9cd 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
 obj-$(CONFIG_XILINX_ML510) += virtex_ml510.o
 obj-$(CONFIG_ISS4xx)	+= iss4xx.o
 obj-$(CONFIG_CANYONLANDS)+= canyonlands.o
-obj-$(CONFIG_CURRITUCK)	+= currituck.o
+obj-$(CONFIG_CURRITUCK)	+= ppc476fpe.o
diff --git a/arch/powerpc/platforms/44x/currituck.c b/arch/powerpc/platforms/44x/currituck.c
deleted file mode 100644
index 7f1b71a..0000000
--- a/arch/powerpc/platforms/44x/currituck.c
+++ /dev/null
@@ -1,233 +0,0 @@
-/*
- * Currituck board specific routines
- *
- * Copyright © 2011 Tony Breeds IBM Corporation
- *
- * Based on earlier code:
- *    Matt Porter <mporter@kernel.crashing.org>
- *    Copyright 2002-2005 MontaVista Software Inc.
- *
- *    Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- *    Copyright (c) 2003-2005 Zultys Technologies
- *
- *    Rewritten and ported to the merged powerpc tree:
- *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
- *    Copyright © 2011 David Kliekamp IBM Corporation
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/rtc.h>
-
-#include <asm/machdep.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/time.h>
-#include <asm/uic.h>
-#include <asm/ppc4xx.h>
-#include <asm/mpic.h>
-#include <asm/mmu.h>
-
-#include <linux/pci.h>
-
-static __initdata struct of_device_id ppc47x_of_bus[] = {
-	{ .compatible = "ibm,plb4", },
-	{ .compatible = "ibm,plb6", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-/* The EEPROM is missing and the default values are bogus.  This forces USB in
- * to EHCI mode */
-static void quirk_ppc_currituck_usb_fixup(struct pci_dev *dev)
-{
-	if (of_machine_is_compatible("ibm,currituck")) {
-		pci_write_config_dword(dev, 0xe0, 0x0114231f);
-		pci_write_config_dword(dev, 0xe4, 0x00006c40);
-	}
-}
-DECLARE_PCI_FIXUP_HEADER(0x1033, 0x0035, quirk_ppc_currituck_usb_fixup);
-
-static int __init ppc47x_device_probe(void)
-{
-	of_platform_bus_probe(NULL, ppc47x_of_bus, NULL);
-
-	return 0;
-}
-machine_device_initcall(ppc47x, ppc47x_device_probe);
-
-/* We can have either UICs or MPICs */
-static void __init ppc47x_init_irq(void)
-{
-	struct device_node *np;
-
-	/* Find top level interrupt controller */
-	for_each_node_with_property(np, "interrupt-controller") {
-		if (of_get_property(np, "interrupts", NULL) == NULL)
-			break;
-	}
-	if (np == NULL)
-		panic("Can't find top level interrupt controller");
-
-	/* Check type and do appropriate initialization */
-	if (of_device_is_compatible(np, "chrp,open-pic")) {
-		/* The MPIC driver will get everything it needs from the
-		 * device-tree, just pass 0 to all arguments
-		 */
-		struct mpic *mpic =
-			mpic_alloc(np, 0, MPIC_NO_RESET, 0, 0, " MPIC     ");
-		BUG_ON(mpic == NULL);
-		mpic_init(mpic);
-		ppc_md.get_irq = mpic_get_irq;
-	} else
-		panic("Unrecognized top level interrupt controller");
-}
-
-#ifdef CONFIG_SMP
-static void smp_ppc47x_setup_cpu(int cpu)
-{
-	mpic_setup_this_cpu();
-}
-
-static int smp_ppc47x_kick_cpu(int cpu)
-{
-	struct device_node *cpunode = of_get_cpu_node(cpu, NULL);
-	const u64 *spin_table_addr_prop;
-	u32 *spin_table;
-	extern void start_secondary_47x(void);
-
-	BUG_ON(cpunode == NULL);
-
-	/* Assume spin table. We could test for the enable-method in
-	 * the device-tree but currently there's little point as it's
-	 * our only supported method
-	 */
-	spin_table_addr_prop =
-		of_get_property(cpunode, "cpu-release-addr", NULL);
-
-	if (spin_table_addr_prop == NULL) {
-		pr_err("CPU%d: Can't start, missing cpu-release-addr !\n",
-		       cpu);
-		return 1;
-	}
-
-	/* Assume it's mapped as part of the linear mapping. This is a bit
-	 * fishy but will work fine for now
-	 *
-	 * XXX: Is there any reason to assume differently?
-	 */
-	spin_table = (u32 *)__va(*spin_table_addr_prop);
-	pr_debug("CPU%d: Spin table mapped at %p\n", cpu, spin_table);
-
-	spin_table[3] = cpu;
-	smp_wmb();
-	spin_table[1] = __pa(start_secondary_47x);
-	mb();
-
-	return 0;
-}
-
-static struct smp_ops_t ppc47x_smp_ops = {
-	.probe		= smp_mpic_probe,
-	.message_pass	= smp_mpic_message_pass,
-	.setup_cpu	= smp_ppc47x_setup_cpu,
-	.kick_cpu	= smp_ppc47x_kick_cpu,
-	.give_timebase	= smp_generic_give_timebase,
-	.take_timebase	= smp_generic_take_timebase,
-};
-
-static void __init ppc47x_smp_init(void)
-{
-	if (mmu_has_feature(MMU_FTR_TYPE_47x))
-		smp_ops = &ppc47x_smp_ops;
-}
-
-#else /* CONFIG_SMP */
-static void __init ppc47x_smp_init(void) { }
-#endif /* CONFIG_SMP */
-
-static void __init ppc47x_setup_arch(void)
-{
-
-	/* No need to check the DMA config as we /know/ our windows are all of
- 	 * RAM.  Lets hope that doesn't change */
-	swiotlb_detect_4g();
-
-	ppc47x_smp_init();
-}
-
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init ppc47x_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "ibm,currituck"))
-		return 0;
-
-	return 1;
-}
-
-static int board_rev = -1;
-static int __init ppc47x_get_board_rev(void)
-{
-	u8 fpga_reg0;
-	void *fpga;
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "ibm,currituck-fpga");
-	if (!np)
-		goto fail;
-
-	fpga = of_iomap(np, 0);
-	of_node_put(np);
-	if (!fpga)
-		goto fail;
-
-	fpga_reg0 = ioread8(fpga);
-	board_rev = fpga_reg0 & 0x03;
-	pr_info("%s: Found board revision %d\n", __func__, board_rev);
-	iounmap(fpga);
-	return 0;
-
-fail:
-	pr_info("%s: Unable to find board revision\n", __func__);
-	return 0;
-}
-machine_arch_initcall(ppc47x, ppc47x_get_board_rev);
-
-/* Use USB controller should have been hardware swizzled but it wasn't :( */
-static void ppc47x_pci_irq_fixup(struct pci_dev *dev)
-{
-	if (dev->vendor == 0x1033 && (dev->device == 0x0035 ||
-	                              dev->device == 0x00e0)) {
-		if (board_rev == 0) {
-			dev->irq = irq_create_mapping(NULL, 47);
-			pr_info("%s: Mapping irq %d\n", __func__, dev->irq);
-		} else if (board_rev == 2) {
-			dev->irq = irq_create_mapping(NULL, 49);
-			pr_info("%s: Mapping irq %d\n", __func__, dev->irq);
-		} else {
-			pr_alert("%s: Unknown board revision\n", __func__);
-		}
-	}
-}
-
-define_machine(ppc47x) {
-	.name			= "PowerPC 47x",
-	.probe			= ppc47x_probe,
-	.progress		= udbg_progress,
-	.init_IRQ		= ppc47x_init_irq,
-	.setup_arch		= ppc47x_setup_arch,
-	.pci_irq_fixup		= ppc47x_pci_irq_fixup,
-	.restart		= ppc4xx_reset_system,
-	.calibrate_decr		= generic_calibrate_decr,
-};
diff --git a/arch/powerpc/platforms/44x/ppc476fpe.c b/arch/powerpc/platforms/44x/ppc476fpe.c
new file mode 100644
index 0000000..c6c5a6f
--- /dev/null
+++ b/arch/powerpc/platforms/44x/ppc476fpe.c
@@ -0,0 +1,233 @@
+/*
+ * PowerPC 476FPE board specific routines
+ *
+ * Copyright © 2011 Tony Breeds IBM Corporation
+ *
+ * Based on earlier code:
+ *    Matt Porter <mporter@kernel.crashing.org>
+ *    Copyright 2002-2005 MontaVista Software Inc.
+ *
+ *    Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *    Copyright (c) 2003-2005 Zultys Technologies
+ *
+ *    Rewritten and ported to the merged powerpc tree:
+ *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *    Copyright © 2011 David Kliekamp IBM Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/ppc4xx.h>
+#include <asm/mpic.h>
+#include <asm/mmu.h>
+
+#include <linux/pci.h>
+
+static struct of_device_id ppc47x_of_bus[] __initdata = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,plb6", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+/* The EEPROM is missing and the default values are bogus.  This forces USB in
+ * to EHCI mode */
+static void quirk_ppc_currituck_usb_fixup(struct pci_dev *dev)
+{
+	if (of_machine_is_compatible("ibm,currituck")) {
+		pci_write_config_dword(dev, 0xe0, 0x0114231f);
+		pci_write_config_dword(dev, 0xe4, 0x00006c40);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(0x1033, 0x0035, quirk_ppc_currituck_usb_fixup);
+
+static int __init ppc47x_device_probe(void)
+{
+	of_platform_bus_probe(NULL, ppc47x_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(ppc47x, ppc47x_device_probe);
+
+/* We can have either UICs or MPICs */
+static void __init ppc47x_init_irq(void)
+{
+	struct device_node *np;
+
+	/* Find top level interrupt controller */
+	for_each_node_with_property(np, "interrupt-controller") {
+		if (of_get_property(np, "interrupts", NULL) == NULL)
+			break;
+	}
+	if (np == NULL)
+		panic("Can't find top level interrupt controller");
+
+	/* Check type and do appropriate initialization */
+	if (of_device_is_compatible(np, "chrp,open-pic")) {
+		/* The MPIC driver will get everything it needs from the
+		 * device-tree, just pass 0 to all arguments
+		 */
+		struct mpic *mpic =
+			mpic_alloc(np, 0, MPIC_NO_RESET, 0, 0, " MPIC     ");
+		BUG_ON(mpic == NULL);
+		mpic_init(mpic);
+		ppc_md.get_irq = mpic_get_irq;
+	} else
+		panic("Unrecognized top level interrupt controller");
+}
+
+#ifdef CONFIG_SMP
+static void smp_ppc47x_setup_cpu(int cpu)
+{
+	mpic_setup_this_cpu();
+}
+
+static int smp_ppc47x_kick_cpu(int cpu)
+{
+	struct device_node *cpunode = of_get_cpu_node(cpu, NULL);
+	const u64 *spin_table_addr_prop;
+	u32 *spin_table;
+	extern void start_secondary_47x(void);
+
+	BUG_ON(cpunode == NULL);
+
+	/* Assume spin table. We could test for the enable-method in
+	 * the device-tree but currently there's little point as it's
+	 * our only supported method
+	 */
+	spin_table_addr_prop =
+		of_get_property(cpunode, "cpu-release-addr", NULL);
+
+	if (spin_table_addr_prop == NULL) {
+		pr_err("CPU%d: Can't start, missing cpu-release-addr !\n",
+		       cpu);
+		return 1;
+	}
+
+	/* Assume it's mapped as part of the linear mapping. This is a bit
+	 * fishy but will work fine for now
+	 *
+	 * XXX: Is there any reason to assume differently?
+	 */
+	spin_table = (u32 *)__va(*spin_table_addr_prop);
+	pr_debug("CPU%d: Spin table mapped at %p\n", cpu, spin_table);
+
+	spin_table[3] = cpu;
+	smp_wmb();
+	spin_table[1] = __pa(start_secondary_47x);
+	mb();
+
+	return 0;
+}
+
+static struct smp_ops_t ppc47x_smp_ops = {
+	.probe		= smp_mpic_probe,
+	.message_pass	= smp_mpic_message_pass,
+	.setup_cpu	= smp_ppc47x_setup_cpu,
+	.kick_cpu	= smp_ppc47x_kick_cpu,
+	.give_timebase	= smp_generic_give_timebase,
+	.take_timebase	= smp_generic_take_timebase,
+};
+
+static void __init ppc47x_smp_init(void)
+{
+	if (mmu_has_feature(MMU_FTR_TYPE_47x))
+		smp_ops = &ppc47x_smp_ops;
+}
+
+#else /* CONFIG_SMP */
+static void __init ppc47x_smp_init(void) { }
+#endif /* CONFIG_SMP */
+
+static void __init ppc47x_setup_arch(void)
+{
+
+	/* No need to check the DMA config as we /know/ our windows are all of
+	 * RAM.  Lets hope that doesn't change */
+	swiotlb_detect_4g();
+
+	ppc47x_smp_init();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init ppc47x_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,currituck"))
+		return 0;
+
+	return 1;
+}
+
+static int board_rev = -1;
+static int __init ppc47x_get_board_rev(void)
+{
+	u8 fpga_reg0;
+	void *fpga;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "ibm,currituck-fpga");
+	if (!np)
+		goto fail;
+
+	fpga = of_iomap(np, 0);
+	of_node_put(np);
+	if (!fpga)
+		goto fail;
+
+	fpga_reg0 = ioread8(fpga);
+	board_rev = fpga_reg0 & 0x03;
+	pr_info("%s: Found board revision %d\n", __func__, board_rev);
+	iounmap(fpga);
+	return 0;
+
+fail:
+	pr_info("%s: Unable to find board revision\n", __func__);
+	return 0;
+}
+machine_arch_initcall(ppc47x, ppc47x_get_board_rev);
+
+/* Use USB controller should have been hardware swizzled but it wasn't :( */
+static void ppc47x_pci_irq_fixup(struct pci_dev *dev)
+{
+	if (dev->vendor == 0x1033 && (dev->device == 0x0035 ||
+				      dev->device == 0x00e0)) {
+		if (board_rev == 0) {
+			dev->irq = irq_create_mapping(NULL, 47);
+			pr_info("%s: Mapping irq %d\n", __func__, dev->irq);
+		} else if (board_rev == 2) {
+			dev->irq = irq_create_mapping(NULL, 49);
+			pr_info("%s: Mapping irq %d\n", __func__, dev->irq);
+		} else {
+			pr_alert("%s: Unknown board revision\n", __func__);
+		}
+	}
+}
+
+define_machine(ppc47x) {
+	.name			= "PowerPC 47x",
+	.probe			= ppc47x_probe,
+	.progress		= udbg_progress,
+	.init_IRQ		= ppc47x_init_irq,
+	.setup_arch		= ppc47x_setup_arch,
+	.pci_irq_fixup		= ppc47x_pci_irq_fixup,
+	.restart		= ppc4xx_reset_system,
+	.calibrate_decr		= generic_calibrate_decr,
+};
-- 
1.7.10.4
