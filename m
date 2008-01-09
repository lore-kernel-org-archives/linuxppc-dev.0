Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 42655DE068
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 05:54:22 +1100 (EST)
Message-ID: <4785185D.4020001@pikatech.com>
Date: Wed, 09 Jan 2008 13:54:21 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/2] Base Warp Platform support
References: <477F0C46.6080900@pikatech.com>
	<1199517639.7291.45.camel@pasglop><4783C7DD.1050202@pikatech.com>
	<478504BF.2000908@pikatech.com>
In-Reply-To: <478504BF.2000908@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ooops. Guess I am not perfect after all ;)

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ arch/powerpc/platforms/44x/warp.c	2008-01-08 17:59:48.000000000 -0500
@@ -0,0 +1,239 @@
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
+#define WARP_GPIO_BASE 0xEF600B00ULL
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
+
+	return 0;
+}
+machine_device_initcall(warp, warp_device_probe);
+
+static int __init warp_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if(!of_flat_dt_is_compatible(root, "pika,warp"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(warp) {
+	.name 				= "Warp",
+	.probe 				= warp_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc44x_reset_system,
+	.calibrate_decr 	= generic_calibrate_decr,
+};
+
+/* This is for the power LEDs 1 = on, 0 = off, -1 = leave alone */
+void warp_set_power_leds(int green, int red)
+{
+	static void *gpio_base = NULL;
+	unsigned leds;
+
+	if(gpio_base == NULL) {
+		if((gpio_base = ioremap(WARP_GPIO_BASE, 0x148)) == NULL) {
+			printk("ERROR: Unable to remap GPIO base.\n");
+			return;
+		}
+	}
+
+	leds = readl(gpio_base + 0x100);
+
+	switch(green) {
+	case 0: leds &= ~0x80; break;
+	case 1: leds |=  0x80; break;
+	}
+	switch(red) {
+	case 0: leds &= ~0x40; break;
+	case 1: leds |=  0x40; break;
+	}
+
+	writel(leds, gpio_base + 0x100);
+}
+EXPORT_SYMBOL(warp_set_power_leds);
+
+
+static int pika_dtm_thread(void *fpga)
+{
+	extern int ad7414_get_temp(int index);
+
+	while(!kthread_should_stop()) {
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
+
+static int __devinit warp_fpga_init(void)
+{
+	struct device_node *np;
+	void *fpga;
+	int irq;
+	struct resource res;
+	struct task_struct *dtm_thread;
+
+	if((np = of_find_compatible_node(NULL, NULL, "pika,fpga")) == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to find fpga\n");
+		return -ENOENT;
+	}
+
+	if((irq = irq_of_parse_and_map(np, 0)) == NO_IRQ) {
+		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+		return -EBUSY;
+	}
+
+	/* We do not call of_iomap here since it would map in the entire
+	 * fpga space, which is over 8k.
+	 */
+	if(of_address_to_resource(np, 0, &res) ||
+	   (fpga = ioremap(res.start, 0x24)) == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
+		return -ENOENT;
+	}
+
+	/* Turn off the line LEDs */
+	out_be32(fpga + 8, 0);
+
+	dtm_thread = kthread_run(pika_dtm_thread, fpga + 0x20, "pika-dtm");
+
+	if(IS_ERR(dtm_thread)) {
+		iounmap(fpga);
+		printk(KERN_ERR __FILE__ ": Unable to start PIKA DTM thread\n");
+		return PTR_ERR(dtm_thread);
+	}
+
+	return 0;
+}
+device_initcall(warp_fpga_init);
+
+#define NAND_FLASH
+#ifdef NAND_FLASH
+/* --- All of this code is for the NAND flash */
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
+static int warp_setup_flash(void)
+{
+	platform_device_register(&warp_ndfc_device);
+	platform_device_register(&warp_nand_device);
+
+	return 0;
+}
+device_initcall(warp_setup_flash);
+
+#endif /* NAND_FLASH */
