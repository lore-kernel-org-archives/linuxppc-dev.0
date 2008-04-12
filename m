Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2A091DE1ED
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 04:03:27 +1000 (EST)
Date: Sat, 12 Apr 2008 14:03:25 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <linuxppc-dev@ozlabs.org>
Subject: PATCH 2/5] Platform code
Message-ID: <20080412140325.69e1df3b@lappy.seanm.ca>
In-Reply-To: <20080412134831.424480cf@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

diff --git a/arch/powerpc/platforms/44x/warp-nand.c b/arch/powerpc/platforms/44x/warp-nand.c
index 9150318..f70019d 100644
--- a/arch/powerpc/platforms/44x/warp-nand.c
+++ b/arch/powerpc/platforms/44x/warp-nand.c
@@ -2,7 +2,7 @@
  * PIKA Warp(tm) NAND flash specific routines
  *
  * Copyright (c) 2008 PIKA Technologies
- *   Sean MacLennan <smaclennan@pikatech.com>
+ *   Sean MacLennan <smaclennan at pikatech.com>
  */
 
 #include <linux/platform_device.h>
@@ -11,8 +11,10 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/ndfc.h>
+#include <linux/of_platform.h>
 #include <asm/machdep.h>
 
+
 #ifdef CONFIG_MTD_NAND_NDFC
 
 #define CS_NAND_0	1	/* use chip select 1 for NAND device 0 */
@@ -35,13 +37,23 @@ static struct mtd_partition nand_parts[] = {
 	{
 		.name   = "root",
 		.offset = 0x0200000,
-		.size   = 0x3400000
+		.size   = 0x3E00000
+	},
+	{
+		.name   = "persistent",
+		.offset = 0x4000000,
+		.size   = 0x4000000
 	},
 	{
-		.name   = "user",
-		.offset = 0x3600000,
-		.size   = 0x0A00000
+		.name   = "persistent1",
+		.offset = 0x8000000,
+		.size   = 0x4000000
 	},
+	{
+		.name   = "persistent2",
+		.offset = 0xC000000,
+		.size   = 0x4000000
+	}
 };
 
 struct ndfc_controller_settings warp_ndfc_settings = {
@@ -67,19 +79,15 @@ static struct platform_device warp_ndfc_device = {
 	.resource = &warp_ndfc,
 };
 
-static struct nand_ecclayout nand_oob_16 = {
-	.eccbytes = 3,
-	.eccpos = { 0, 1, 2, 3, 6, 7 },
-	.oobfree = { {.offset = 8, .length = 16} }
-};
-
+/* Do NOT set the ecclayout: let it default so it is correct for both
+ * 64M and 256M flash chips.
+ */
 static struct platform_nand_chip warp_nand_chip0 = {
 	.nr_chips = 1,
 	.chip_offset = CS_NAND_0,
 	.nr_partitions = ARRAY_SIZE(nand_parts),
 	.partitions = nand_parts,
-	.chip_delay = 50,
-	.ecclayout = &nand_oob_16,
+	.chip_delay = 20,
 	.priv = &warp_chip0_settings,
 };
 
@@ -96,6 +104,23 @@ static struct platform_device warp_nand_device = {
 
 static int warp_setup_nand_flash(void)
 {
+	struct device_node *np;
+
+	/* Try to detect a rev A based on NOR size. */
+	np = of_find_compatible_node(NULL, NULL, "cfi-flash");
+	if (np) {
+		struct property *pp;
+
+		pp = of_find_property(np, "reg", NULL);
+		if (pp && (pp->length == 12)) {
+			u32 *v = pp->value;
+			if (v[2] == 0x4000000)
+				/* Rev A = 64M NAND */
+				warp_nand_chip0.nr_partitions = 2;
+		}
+		of_node_put(np);
+	}
+
 	platform_device_register(&warp_ndfc_device);
 	platform_device_register(&warp_nand_device);
 
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 39cf615..6deffad 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -2,7 +2,7 @@
  * PIKA Warp(tm) board specific routines
  *
  * Copyright (c) 2008 PIKA Technologies
- *   Sean MacLennan <smaclennan@pikatech.com>
+ *   Sean MacLennan <smaclennan at pikatech.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -12,6 +12,9 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/kthread.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/pika.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -27,6 +30,18 @@ static __initdata struct of_device_id warp_of_bus[] = {
 	{},
 };
 
+static __initdata struct i2c_board_info warp_i2c_info[] = {
+	{ I2C_BOARD_INFO("ad7414", 0x4a) }
+};
+
+static int __init warp_arch_init(void)
+{
+	/* This should go away once support is moved to the dts. */
+	i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
+	return 0;
+}
+machine_arch_initcall(warp, warp_arch_init);
+
 static int __init warp_device_probe(void)
 {
 	of_platform_bus_probe(NULL, warp_of_bus, NULL);
@@ -52,61 +67,183 @@ define_machine(warp) {
 };
 
 
-#define LED_GREEN (0x80000000 >> 0)
-#define LED_RED   (0x80000000 >> 1)
+/* I am not sure this is the best place for this... */
+static int __init warp_post_info(void)
+{
+	struct device_node *np;
+	void __iomem *fpga;
+	u32 post1, post2;
+
+	/* Sighhhh... POST information is in the sd area. */
+	np = of_find_compatible_node(NULL, NULL, "pika,fpga-sd");
+	if (np == NULL)
+		return -ENOENT;
+
+	fpga = of_iomap(np, 0);
+	of_node_put(np);
+	if (fpga == NULL)
+		return -ENOENT;
+
+	post1 = in_be32(fpga + 0x40);
+	post2 = in_be32(fpga + 0x44);
+
+	iounmap(fpga);
+
+	if (post1 || post2)
+		printk(KERN_INFO "Warp POST %08x %08x\n", post1, post2);
+	else
+		printk(KERN_INFO "Warp POST OK\n");
+
+	return 0;
+}
+machine_late_initcall(warp, warp_post_info);
+
+
+#ifdef CONFIG_SENSORS_AD7414
+
+static LIST_HEAD(dtm_shutdown_list);
+static void __iomem *dtm_fpga;
+
+struct dtm_shutdown {
+	struct list_head list;
+	void (*func)(void *arg);
+	void *arg;
+};
+
+
+int dtm_register_shutdown(void (*func)(void *arg), void *arg)
+{
+	struct dtm_shutdown *shutdown;
+
+	shutdown = kmalloc(sizeof(struct dtm_shutdown), GFP_KERNEL);
+	if (shutdown == NULL)
+		return -ENOMEM;
+
+	shutdown->func = func;
+	shutdown->arg = arg;
 
+	list_add(&shutdown->list, &dtm_shutdown_list);
+
+	return 0;
+}
+EXPORT_SYMBOL(dtm_register_shutdown);
 
-/* This is for the power LEDs 1 = on, 0 = off, -1 = leave alone */
-void warp_set_power_leds(int green, int red)
+int dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
 {
-	static void __iomem *gpio_base = NULL;
-	unsigned leds;
-
-	if (gpio_base == NULL) {
-		struct device_node *np;
-
-		/* Power LEDS are on the second GPIO controller */
-		np = of_find_compatible_node(NULL, NULL, "ibm,gpio-440EP");
-		if (np)
-			np = of_find_compatible_node(np, NULL, "ibm,gpio-440EP");
-		if (np == NULL) {
-			printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
-			return;
-		}
+	struct dtm_shutdown *shutdown;
 
-		gpio_base = of_iomap(np, 0);
-		of_node_put(np);
-		if (gpio_base == NULL) {
-			printk(KERN_ERR __FILE__ ": Unable to map gpio");
-			return;
+	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
+		if (shutdown->func == func && shutdown->arg == arg) {
+			list_del(&shutdown->list);
+			kfree(shutdown);
+			return 0;
 		}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(dtm_unregister_shutdown);
+
+static long wdt_keepalive(long time)
+{
+	if (dtm_fpga) {
+		unsigned reset = in_be32(dtm_fpga + 0x14);
+		out_be32(dtm_fpga + 0x14, reset);
 	}
 
-	leds = in_be32(gpio_base);
+	return 0;
+}
+
+static irqreturn_t temp_isr(int irq, void *context)
+{
+	struct dtm_shutdown *shutdown;
+
+	/* Run through the shutdown list. */
+	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
+		shutdown->func(shutdown->arg);
+
+	panic_timeout = 1800;
+	panic_blink = wdt_keepalive;
+	panic("Critical Temperature Shutdown");
+	return IRQ_HANDLED;
+}
+
+static void pika_setup_critical_temp(struct i2c_client *client)
+{
+	struct device_node *np;
+	int irq, rc;
+
+	/* These registers are in 1 degree increments. */
+	i2c_smbus_write_byte_data(client, 2, 55); /* Thigh */
+	i2c_smbus_write_byte_data(client, 3, 50); /* Tlow */
 
-	switch (green) {
-	case 0: leds &= ~LED_GREEN; break;
-	case 1: leds |=  LED_GREEN; break;
+	np = of_find_compatible_node(NULL, NULL, "adi,ad7414");
+	if (np == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to find ad7414\n");
+		return;
 	}
-	switch (red) {
-	case 0: leds &= ~LED_RED; break;
-	case 1: leds |=  LED_RED; break;
+
+	irq = irq_of_parse_and_map(np, 0);
+	of_node_put(np);
+	if (irq  == NO_IRQ) {
+		printk(KERN_ERR __FILE__ ": Unable to get ad7414 irq\n");
+		return;
 	}
 
-	out_be32(gpio_base, leds);
+	rc = request_irq(irq, temp_isr, 0, "ad7414", NULL);
+	if (rc) {
+		printk(KERN_ERR __FILE__
+		       ": Unable to request ad7414 irq %d = %d\n", irq, rc);
+		return;
+	}
 }
-EXPORT_SYMBOL(warp_set_power_leds);
 
+static inline void pika_dtm_check_fan(void __iomem *fpga)
+{
+	static int fan_state;
+	u32 fan = in_be32(fpga + 0x34) & (1 << 14);
+
+	if (fan_state != fan) {
+		fan_state = fan;
+		if (fan)
+			printk(KERN_WARNING "Fan rotation error detected."
+				   " Please check hardware.\n");
+	}
+}
 
-#ifdef CONFIG_SENSORS_AD7414
 static int pika_dtm_thread(void __iomem *fpga)
 {
-	extern int ad7414_get_temp(int index);
+	struct i2c_adapter *adap;
+	struct i2c_client *client;
+
+	/* We loop in case either driver was compiled as a module and
+	 * has not been insmoded yet.
+	 */
+	while (!(adap = i2c_get_adapter(0))) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+	}
+
+	while (1) {
+		list_for_each_entry(client, &adap->clients, list)
+			if (client->addr == 0x4a)
+				goto found_it;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+	}
+
+found_it:
+	i2c_put_adapter(adap);
+
+	pika_setup_critical_temp(client);
+
+	printk(KERN_INFO "PIKA DTM thread running.\n");
 
 	while (!kthread_should_stop()) {
-		int temp = ad7414_get_temp(0);
+		u16 temp = swab16(i2c_smbus_read_word_data(client, 0));
+		out_be32(fpga + 0x20, temp);
 
-		out_be32(fpga, temp);
+		pika_dtm_check_fan(fpga);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ);
@@ -115,37 +252,28 @@ static int pika_dtm_thread(void __iomem *fpga)
 	return 0;
 }
 
+
 static int __init pika_dtm_start(void)
 {
 	struct task_struct *dtm_thread;
 	struct device_node *np;
-	struct resource res;
-	void __iomem *fpga;
 
 	np = of_find_compatible_node(NULL, NULL, "pika,fpga");
 	if (np == NULL)
 		return -ENOENT;
 
-	/* We do not call of_iomap here since it would map in the entire
-	 * fpga space, which is over 8k.
-	 */
-	if (of_address_to_resource(np, 0, &res)) {
-		of_node_put(np);
-		return -ENOENT;
-	}
+	dtm_fpga = of_iomap(np, 0);
 	of_node_put(np);
-
-	fpga = ioremap(res.start, 0x24);
-	if (fpga == NULL)
+	if (dtm_fpga == NULL)
 		return -ENOENT;
 
-	dtm_thread = kthread_run(pika_dtm_thread, fpga + 0x20, "pika-dtm");
+	dtm_thread = kthread_run(pika_dtm_thread, dtm_fpga, "pika-dtm");
 	if (IS_ERR(dtm_thread)) {
-		iounmap(fpga);
+		iounmap(dtm_fpga);
 		return PTR_ERR(dtm_thread);
 	}
 
 	return 0;
 }
-device_initcall(pika_dtm_start);
+machine_late_initcall(warp, pika_dtm_start);
 #endif
