Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 93EFBDDF70
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 07:58:29 +1000 (EST)
Date: Mon, 6 Apr 2009 17:58:25 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Update Warp to use leds-gpio driver
Message-ID: <20090406175825.76bb969c@lappy.seanm.ca>
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

Now that leds-gpio is a proper OF platform driver, the Warp can use
the leds-gpio driver rather than the old out-of-kernel driver.

One side-effect is the leds-gpio driver always turns the leds off
while the old driver left them alone. So we have to set them back to
the correct settings.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index 7e183ff..01bfb56 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -1,7 +1,7 @@
 /*
  * Device Tree Source for PIKA Warp
  *
- * Copyright (c) 2008 PIKA Technologies
+ * Copyright (c) 2008-2009 PIKA Technologies
  *   Sean MacLennan <smaclennan@pikatech.com>
  *
  * This file is licensed under the terms of the GNU General Public
@@ -158,7 +158,7 @@
 
 					partition@0 {
 						label = "splash";
-						reg = <0x00000000 0x00020000>;
+						reg = <0x00000000 0x00010000>;
 					};
 					partition@300000 {
 						label = "fpga";
@@ -244,28 +244,27 @@
 			};
 
 			GPIO0: gpio@ef600b00 {
-				compatible = "ibm,gpio-440ep";
+				compatible = "ibm,ppc4xx-gpio";
 				reg = <0xef600b00 0x00000048>;
 				#gpio-cells = <2>;
 				gpio-controller;
 			};
 
 			GPIO1: gpio@ef600c00 {
-				compatible = "ibm,gpio-440ep";
+				compatible = "ibm,ppc4xx-gpio";
 				reg = <0xef600c00 0x00000048>;
 				#gpio-cells = <2>;
 				gpio-controller;
+			};
 
-				led@31 {
-					compatible = "linux,gpio-led";
-					linux,name = ":green:";
-					gpios = <&GPIO1 31 0>;
-				};		
-	
-				led@30 {	
-					compatible = "linux,gpio-led";
-					linux,name = ":red:";
-					gpios = <&GPIO1 30 0>;
+			power-leds {
+				compatible = "gpio-leds";
+				green {
+					gpios = <&GPIO1 0 0>;
+					default-state = "on";
+				};
+				red {
+					gpios = <&GPIO1 1 0>;
 				};
 			};
 
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 960edf8..c511880 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -1,7 +1,7 @@
 /*
  * PIKA Warp(tm) board specific routines
  *
- * Copyright (c) 2008 PIKA Technologies
+ * Copyright (c) 2008-2009 PIKA Technologies
  *   Sean MacLennan <smaclennan@pikatech.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -15,6 +15,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/of_gpio.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -23,6 +24,7 @@
 #include <asm/uic.h>
 #include <asm/ppc4xx.h>
 
+
 static __initdata struct of_device_id warp_of_bus[] = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
@@ -55,6 +57,8 @@ define_machine(warp) {
 };
 
 
+static u32 post_info;
+
 /* I am not sure this is the best place for this... */
 static int __init warp_post_info(void)
 {
@@ -77,21 +81,21 @@ static int __init warp_post_info(void)
 
 	iounmap(fpga);
 
-	if (post1 || post2)
+	if (post1 || post2) {
 		printk(KERN_INFO "Warp POST %08x %08x\n", post1, post2);
-	else
+		post_info = 1;
+	} else
 		printk(KERN_INFO "Warp POST OK\n");
 
 	return 0;
 }
-machine_late_initcall(warp, warp_post_info);
 
 
 #ifdef CONFIG_SENSORS_AD7414
 
 static LIST_HEAD(dtm_shutdown_list);
 static void __iomem *dtm_fpga;
-static void __iomem *gpio_base;
+static unsigned green_led, red_led;
 
 
 struct dtm_shutdown {
@@ -134,14 +138,17 @@ int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
 static irqreturn_t temp_isr(int irq, void *context)
 {
 	struct dtm_shutdown *shutdown;
+	int value = 1;
 
 	local_irq_disable();
 
+	gpio_set_value(green_led, 0);
+
 	/* Run through the shutdown list. */
 	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
 		shutdown->func(shutdown->arg);
 
-	printk(KERN_EMERG "\n\nCritical Temperature Shutdown\n");
+	printk(KERN_EMERG "\n\nCritical Temperature Shutdown\n\n");
 
 	while (1) {
 		if (dtm_fpga) {
@@ -149,52 +156,34 @@ static irqreturn_t temp_isr(int irq, void *context)
 			out_be32(dtm_fpga + 0x14, reset);
 		}
 
-		if (gpio_base) {
-			unsigned leds = in_be32(gpio_base);
-
-			/* green off, red toggle */
-			leds &= ~0x80000000;
-			leds ^=  0x40000000;
-
-			out_be32(gpio_base, leds);
-		}
-
+		gpio_set_value(red_led, value);
+		value ^= 1;
 		mdelay(500);
 	}
 }
 
 static int pika_setup_leds(void)
 {
-	struct device_node *np;
-	const u32 *gpios;
-	int len;
+	struct device_node *np, *child;
 
-	np = of_find_compatible_node(NULL, NULL, "linux,gpio-led");
+	np = of_find_compatible_node(NULL, NULL, "gpio-leds");
 	if (!np) {
-		printk(KERN_ERR __FILE__ ": Unable to find gpio-led\n");
-		return -ENOENT;
-	}
-
-	gpios = of_get_property(np, "gpios", &len);
-	of_node_put(np);
-	if (!gpios || len < 4) {
-		printk(KERN_ERR __FILE__
-		       ": Unable to get gpios property (%d)\n", len);
+		printk(KERN_ERR __FILE__ ": Unable to find leds\n");
 		return -ENOENT;
 	}
 
-	np = of_find_node_by_phandle(gpios[0]);
-	if (!np) {
-		printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
-		return -ENOENT;
-	}
+	for_each_child_of_node(np, child)
+		if (strcmp(child->name, "green") == 0) {
+			green_led = of_get_gpio(child, 0);
+			/* Turn back on the green LED */
+			gpio_set_value(green_led, 1);
+		} else if (strcmp(child->name, "red") == 0) {
+			red_led = of_get_gpio(child, 0);
+			/* Set based on post */
+			gpio_set_value(red_led, post_info);
+		}
 
-	gpio_base = of_iomap(np, 0);
 	of_node_put(np);
-	if (!gpio_base) {
-		printk(KERN_ERR __FILE__ ": Unable to map gpio");
-		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -270,10 +259,10 @@ static int pika_dtm_thread(void __iomem *fpga)
 	}
 
 found_it:
-	i2c_put_adapter(adap);
-
 	pika_setup_critical_temp(client);
 
+	i2c_put_adapter(adap);
+
 	printk(KERN_INFO "PIKA DTM thread running.\n");
 
 	while (!kthread_should_stop()) {
@@ -311,6 +300,9 @@ static int __init pika_dtm_start(void)
 	if (dtm_fpga == NULL)
 		return -ENOENT;
 
+	/* Must get post info before thread starts. */
+	warp_post_info();
+
 	dtm_thread = kthread_run(pika_dtm_thread, dtm_fpga, "pika-dtm");
 	if (IS_ERR(dtm_thread)) {
 		iounmap(dtm_fpga);
@@ -333,6 +325,8 @@ int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
 	return 0;
 }
 
+machine_late_initcall(warp, warp_post_info);
+
 #endif
 
 EXPORT_SYMBOL(pika_dtm_register_shutdown);
