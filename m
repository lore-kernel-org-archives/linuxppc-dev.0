Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B1EC0DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 06:38:25 +1100 (EST)
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id lBKEsYnv025818
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 06:54:34 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] sbc8560: add basic support for Wind River SBC8560 as
	powerpc
Date: Thu, 20 Dec 2007 09:54:29 -0500
Message-Id: <11981624732110-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <442fe9c9343f3c694932bcdc5f819c493c33c76b.1198107769.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the basic support for the Wind River SBC8560 board, implemented
as powerpc.  It closely follows the implementation of the MPC8560ADS.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/85xx/Kconfig   |   11 +-
 arch/powerpc/platforms/85xx/Makefile  |    1 +
 arch/powerpc/platforms/85xx/sbc8560.c |  302 +++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 7748a3a..0eb497b 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -38,6 +38,13 @@ config MPC85xx_DS
 	help
 	  This option enables support for the MPC85xx DS (MPC8544 DS) board
 
+config SBC8560
+	bool "Wind River SBC8560"
+	select DEFAULT_UIMAGE
+	select PPC_CPM_NEW_BINDING
+	help
+	  This option enables support for the Wind River SBC8560 board
+
 endchoice
 
 config MPC8540
@@ -49,7 +56,7 @@ config MPC8540
 config MPC8560
 	bool
 	select CPM2
-	default y if MPC8560_ADS
+	default y if MPC8560_ADS || SBC8560
 
 config MPC85xx
 	bool
@@ -59,4 +66,4 @@ config MPC85xx
 	select FSL_PCI if PCI
 	select SERIAL_8250_SHARE_IRQ if SERIAL_8250
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
-		|| MPC85xx_MDS || MPC85xx_DS
+		|| MPC85xx_MDS || MPC85xx_DS || SBC8560
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 5eca920..c3f4d01 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
+obj-$(CONFIG_SBC8560) += sbc8560.o
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
new file mode 100644
index 0000000..6aef38b
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -0,0 +1,302 @@
+/*
+ * Wind River SBC8560 setup and early boot code.
+ *
+ * Copyright 2007 Wind River Systems Inc.
+ *
+ * By Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * Based largely on the MPC8560ADS support - Copyright 2005 Freescale Inc.
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
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpic.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#ifdef CONFIG_CPM2
+#include <asm/cpm2.h>
+#include <sysdev/cpm2_pic.h>
+#endif
+
+#ifdef CONFIG_PCI
+static int sbc8560_exclude_device(struct pci_controller *hose,
+				   u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+#endif /* CONFIG_PCI */
+
+#ifdef CONFIG_CPM2
+
+static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	int cascade_irq;
+
+	while ((cascade_irq = cpm2_get_irq()) >= 0) {
+		generic_handle_irq(cascade_irq);
+	}
+	desc->chip->eoi(irq);
+}
+
+#endif /* CONFIG_CPM2 */
+
+static void __init sbc8560_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+#ifdef CONFIG_CPM2
+	int irq;
+#endif
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if(of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Could not map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_CPM2
+	/* Setup CPM2 PIC */
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
+		return;
+	}
+	irq = irq_of_parse_and_map(np, 0);
+
+	cpm2_pic_init(np);
+	set_irq_chained_handler(irq, cpm2_cascade);
+#endif
+}
+
+/*
+ * Setup the architecture
+ */
+#ifdef CONFIG_CPM2
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static struct cpm_pin sbc8560_pins[] = {
+	/* SCC1 */
+	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* SCC2 */
+	{3, 26, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK14 */
+	{2, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY}, /* CLK13 */
+
+	/* FCC3 */
+	{1, 4, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 6, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 7, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 12, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 13, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 14, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 15, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 16, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK16 */
+	{2, 17, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* CLK15 */
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sbc8560_pins); i++) {
+		struct cpm_pin *pin = &sbc8560_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK15, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK16, CPM_CLK_TX);
+}
+#endif
+
+static void __init sbc8560_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("sbc8560_setup_arch()", 0);
+
+#ifdef CONFIG_CPM2
+	cpm2_reset();
+	init_ioports();
+#endif
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
+		fsl_add_bridge(np, 1);
+
+	ppc_md.pci_exclude_device = sbc8560_exclude_device;
+#endif
+}
+
+static void sbc8560_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Wind River\n");
+	seq_printf(m, "Machine\t\t: SBC8560\n");
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .type = "soc", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	if (!machine_is(sbc8560))
+		return 0;
+
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init sbc8560_probe(void)
+{
+        unsigned long root = of_get_flat_dt_root();
+
+        return of_flat_dt_is_compatible(root, "SBC8560");
+}
+
+#ifdef CONFIG_RTC_DRV_M48T59
+static int __init sbc8560_rtc_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	struct platform_device *rtc_dev;
+
+	np = of_find_node_by_type(NULL, "rtc");
+	if (np == NULL) {
+		printk("No RTC in DTB. Has it been eaten by wild dogs?\n");
+		return -ENODEV;
+	}
+
+	if (!of_device_is_compatible(np, "m48t59")) {
+		printk("Ignoring non-m48t59 compatible RTC\n");
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	of_address_to_resource(np, 0, &res);
+
+	printk("Found RTC (m48t59) at i/o 0x%x\n", res.start);
+
+	rtc_dev = platform_device_register_simple("rtc-m48t59", 0, &res, 1);
+
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
+
+	of_node_put(np);
+	return 0;
+}
+
+arch_initcall(sbc8560_rtc_init);
+
+#endif	/* M48T59 */
+
+define_machine(sbc8560) {
+	.name			= "SBC8560",
+	.probe			= sbc8560_probe,
+	.setup_arch		= sbc8560_setup_arch,
+	.init_IRQ		= sbc8560_pic_init,
+	.show_cpuinfo		= sbc8560_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.0.rc1.gf4b6c
