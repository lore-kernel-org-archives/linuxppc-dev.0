Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D1007DDE27
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jan 2008 07:42:46 +1100 (EST)
Message-ID: <47892645.5070003@pikatech.com>
Date: Sat, 12 Jan 2008 15:42:45 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] Warp Base Platform
References: <47852C41.8000506@pikatech.com><20080111115143.4ed89ab6@zod.rchland.ibm.com><4787FE23.7010201@pikatech.com>
	<200801120723.29393.sr@denx.de> <4789235E.1030901@pikatech.com>
In-Reply-To: <4789235E.1030901@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please ignore the last patch. I left in a debug to check 
that the non-ad7414 case works.

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3d8c..b3e4c35 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -469,7 +469,7 @@ config MCA
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
-		|| PPC_PS3
+		|| PPC_PS3 || 44x
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index d248013..a95409e 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -53,6 +53,19 @@ config RAINIER
 	help
 	  This option enables support for the AMCC PPC440GRX evaluation board.
 
+config WARP
+	bool "PIKA Warp"
+	depends on 44x
+	default n
+	select 440EP
+	help
+	  This option enables support for the PIKA Warp(tm) Appliance. The Warp
+          is a small computer replacement with up to 9 ports of FXO/FXS plus VOIP
+	  stations and trunks.
+
+	  See http://www.pikatechnologies.com/ and follow the "PIKA for Computer
+	  Telephony Developers" link for more information.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
@@ -75,6 +88,7 @@ config 440EP
 	select PPC_FPU
 	select IBM440EP_ERR42
 	select IBM_NEW_EMAC_ZMII
+	select USB_ARCH_HAS_OHCI
 
 config 440EPX
 	bool
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index a2a0dc1..7aaee9d 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -5,3 +5,5 @@ obj-$(CONFIG_BAMBOO)	+= bamboo.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
 obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
+obj-$(CONFIG_WARP)	+= warp.o
+#obj-$(CONFIG_WARP)	+= warp-nand.o
diff --git a/arch/powerpc/platforms/44x/warp-nand.c b/arch/powerpc/platforms/44x/warp-nand.c
new file mode 100644
index 0000000..0053958
--- /dev/null
+++ b/arch/powerpc/platforms/44x/warp-nand.c
@@ -0,0 +1,92 @@
+/*
+ * PIKA Warp(tm) NAND flash specific routines
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/ndfc.h>
+
+
+#define CS_NAND_0	1	/* use chip select 1 for NAND device 0 */
+
+#define WARP_NAND_FLASH_REG_ADDR	0xD0000000UL
+#define WARP_NAND_FLASH_REG_SIZE	0x2000
+
+static struct resource warp_ndfc = {
+	.start = WARP_NAND_FLASH_REG_ADDR,
+	.end   = WARP_NAND_FLASH_REG_ADDR + WARP_NAND_FLASH_REG_SIZE,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct mtd_partition nand_parts[] = {
+	{
+		.name = "nand",
+		.offset = 0,
+		.size = MTDPART_SIZ_FULL,
+	}
+};
+
+struct ndfc_controller_settings warp_ndfc_settings = {
+	.ccr_settings = (NDFC_CCR_BS(CS_NAND_0) | NDFC_CCR_ARAC1),
+	.ndfc_erpn = 0,
+};
+
+static struct ndfc_chip_settings warp_chip0_settings = {
+	.bank_settings = 0x80002222,
+};
+
+struct platform_nand_ctrl warp_nand_ctrl = {
+	.priv = &warp_ndfc_settings,
+};
+
+static struct platform_device warp_ndfc_device = {
+	.name = "ndfc-nand",
+	.id = 0,
+	.dev = {
+		.platform_data = &warp_nand_ctrl,
+	},
+	.num_resources = 1,
+	.resource = &warp_ndfc,
+};
+
+static struct nand_ecclayout nand_oob_16 = {
+	.eccbytes = 3,
+	.eccpos = { 0, 1, 2, 3, 6, 7 },
+	.oobfree = { {.offset = 8, .length = 16} }
+};
+
+static struct platform_nand_chip warp_nand_chip0 = {
+	.nr_chips = 1,
+	.chip_offset = CS_NAND_0,
+	.nr_partitions = ARRAY_SIZE(nand_parts),
+	.partitions = nand_parts,
+	.chip_delay = 50,
+	.ecclayout = &nand_oob_16,
+	.priv = &warp_chip0_settings,
+};
+
+static struct platform_device warp_nand_device = {
+	.name = "ndfc-chip",
+	.id = 0,
+	.num_resources = 1,
+	.resource = &warp_ndfc,
+	.dev = {
+		.platform_data = &warp_nand_chip0,
+		.parent = &warp_ndfc_device.dev,
+	}
+};
+
+static int warp_setup_nand_flash(void)
+{
+	platform_device_register(&warp_ndfc_device);
+	platform_device_register(&warp_nand_device);
+
+	return 0;
+}
+device_initcall(warp_setup_nand_flash);
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
new file mode 100644
index 0000000..97d5c33
--- /dev/null
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -0,0 +1,186 @@
+/*
+ * PIKA Warp(tm) board specific routines
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/kthread.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+
+#include "44x.h"
+
+
+static __initdata struct of_device_id warp_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init warp_device_probe(void)
+{
+	of_platform_bus_probe(NULL, warp_of_bus, NULL);
+	return 0;
+}
+machine_device_initcall(warp, warp_device_probe);
+
+static int __init warp_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "pika,warp"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(warp) {
+	.name		= "Warp",
+	.probe 		= warp_probe,
+	.progress 	= udbg_progress,
+	.init_IRQ 	= uic_init_tree,
+	.get_irq 	= uic_get_irq,
+	.restart	= ppc44x_reset_system,
+	.calibrate_decr = generic_calibrate_decr,
+};
+
+
+#define LED_GREEN (0x80000000 >> 0)
+#define LED_RED   (0x80000000 >> 1)
+
+
+/* This is for the power LEDs 1 = on, 0 = off, -1 = leave alone */
+void warp_set_power_leds(int green, int red)
+{
+	static void __iomem *gpio_base = NULL;
+	unsigned leds;
+
+	if (gpio_base == NULL) {
+		struct device_node *np, *from;
+		int i;
+
+		/* Power LEDS are on the second GPIO controller */
+		for (from = NULL, i = 0; i < 2; ++i, from = np) {
+			np = of_find_compatible_node(from, NULL, "ibm,gpio-440EP");
+			if (np == NULL) {
+				printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
+				return;
+			}
+		}
+
+		gpio_base = of_iomap(np, 0);
+		if (gpio_base == NULL) {
+			printk(KERN_ERR __FILE__ ": Unable to map gpio");
+			return;
+		}
+	}
+
+
+	leds = in_be32(gpio_base);
+
+	switch (green) {
+	case 0: leds &= ~LED_GREEN; break;
+	case 1: leds |=  LED_GREEN; break;
+	}
+	switch (red) {
+	case 0: leds &= ~LED_RED; break;
+	case 1: leds |=  LED_RED; break;
+	}
+
+	out_be32(gpio_base, leds);
+}
+EXPORT_SYMBOL(warp_set_power_leds);
+
+
+#ifdef CONFIG_SENSORS_AD7414
+static int pika_dtm_thread(void __iomem *fpga)
+{
+	extern int ad7414_get_temp(int index);
+
+	while (!kthread_should_stop()) {
+		int temp = ad7414_get_temp(0);
+
+		out_be32(fpga, temp);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+	}
+
+	return 0;
+}
+
+static int pika_dtm_start(void __iomem *fpga)
+{
+	struct task_struct *dtm_thread;
+
+	dtm_thread = kthread_run(pika_dtm_thread, fpga + 0x20, "pika-dtm");
+	if (IS_ERR(dtm_thread)) {
+		printk(KERN_ERR __FILE__ ": Unable to start PIKA DTM thread\n");
+		return PTR_ERR(dtm_thread);
+	}
+
+	return 0;
+}
+#else
+static int pika_dtm_start(void __iomem *fpga)
+{
+	printk(KERN_WARNING "PIKA DTM disabled\n");
+	return 0;
+}
+#endif
+
+
+static int __devinit warp_fpga_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	void __iomem *fpga;
+	int irq;
+
+	np = of_find_compatible_node(NULL, NULL, "pika,fpga");
+	if (np == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to find fpga\n");
+		return -ENOENT;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq  == NO_IRQ) {
+		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+		return -EBUSY;
+	}
+
+	/* We do not call of_iomap here since it would map in the entire
+	 * fpga space, which is over 8k.
+	 */
+	if (of_address_to_resource(np, 0, &res)) {
+		printk(KERN_ERR __FILE__ ": Unable to get FPGA address\n");
+		return -ENOENT;
+	}
+	fpga = ioremap(res.start, 0x24);
+	if (fpga == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
+		return -ENOENT;
+	}
+
+	if (pika_dtm_start(fpga)) {
+		iounmap(fpga);
+		return -ENOENT;
+	}
+
+	/* SAM TODO: Start the watchdog here */
+
+	return 0;
+}
+device_initcall(warp_fpga_init);
