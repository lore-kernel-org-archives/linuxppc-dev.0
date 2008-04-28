Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E2911DE2B3
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 04:53:12 +1000 (EST)
Date: Mon, 28 Apr 2008 14:53:10 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Sean MacLennan" <seanm@seanm.ca>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080428145310.553b8271@lappy.seanm.ca>
In-Reply-To: <20080417152251.2bf07219@lappy.seanm.ca>
References: <20080417152251.2bf07219@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here is another version of the patch with Stephen Rothwell's and
Grant Likely's suggestions.

Cheers,
  Sean

PIKA Warp: Update platform code to support Rev B boards.
* Switched from 64M NOR/64M NAND to 4M NOR/256M NAND.
* Full DTM support including critical temperature.
* Added POST information.
* Removed LED function, moved to new LED driver.
* Moved ad7414 to new style I2C initialization.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

diff --git a/arch/powerpc/boot/cuboot-warp.c b/arch/powerpc/boot/cuboot-warp.c
index eb108a8..2178021 100644
--- a/arch/powerpc/boot/cuboot-warp.c
+++ b/arch/powerpc/boot/cuboot-warp.c
@@ -10,6 +10,7 @@
 #include "ops.h"
 #include "4xx.h"
 #include "cuboot.h"
+#include "stdio.h"
 
 #define TARGET_4xx
 #define TARGET_44x
@@ -17,14 +18,54 @@
 
 static bd_t bd;
 
-static void warp_fixups(void)
+static void warp_fixup_one_nor(u32 from, u32 to)
 {
-	unsigned long sysclk = 66000000;
+	void *devp;
+	char name[50];
+	u32 v[2];
+
+	sprintf(name, "/plb/opb/ebc/nor_flash@0,0/partition@%x", from);
+
+	devp = finddevice(name);
+	if (!devp)
+		return;
+
+	if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
+		v[0] = to;
+		setprop(devp, "reg", v, sizeof(v));
+
+		printf("NOR 64M fixup %x -> %x\r\n", from, to);
+	}
+}
+
 
-	ibm440ep_fixup_clocks(sysclk, 11059200, 50000000);
+static void warp_fixups(void)
+{
+	ibm440ep_fixup_clocks(66000000, 11059200, 50000000);
 	ibm4xx_sdram_fixup_memsize();
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+
+	/* Fixup for 64M flash on Rev A boards. */
+	if (bd.bi_flashsize == 0x4000000) {
+		void *devp;
+		u32 v[3];
+
+		devp = finddevice("/plb/opb/ebc/nor_flash@0,0");
+		if (!devp)
+			return;
+
+		/* Fixup the size */
+		if (getprop(devp, "reg", v, sizeof(v)) == sizeof(v)) {
+			v[2] = bd.bi_flashsize;
+			setprop(devp, "reg", v, sizeof(v));
+		}
+
+		/* Fixup parition offsets */
+		warp_fixup_one_nor(0x300000, 0x3f00000);
+		warp_fixup_one_nor(0x340000, 0x3f40000);
+		warp_fixup_one_nor(0x380000, 0x3f80000);
+	}
 }
 
 
diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index b04a52e..d124497 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -132,40 +132,33 @@
 
 				fpga@2,0 {
 					compatible = "pika,fpga";
-			   		reg = <2 0 2200>;
+			   		reg = <2 0 1000>;
 					interrupts = <18 8>;
 					interrupt-parent = <&UIC0>;
 				};
 
+				fpga@2,4000 {
+					compatible = "pika,fpga-sd";
+					reg = <2 4000 A00>;
+				};
+
 				nor_flash@0,0 {
-					compatible = "amd,s29gl512n", "cfi-flash";
+					compatible = "amd,s29gl032a", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 0 4000000>;
+					reg = <0 0 400000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
-					partition@0 {
-						label = "kernel";
-						reg = <0 180000>;
-					};
-					partition@180000 {
-						label = "root";
-						reg = <180000 3480000>;
-					};
-					partition@3600000 {
-						label = "user";
-						reg = <3600000 900000>;
-					};
-					partition@3f00000 {
+					partition@300000 {
 						label = "fpga";
-						reg = <3f00000 40000>;
+						reg = <300000 40000>;
 					};
-					partition@3f40000 {
+					partition@340000 {
 						label = "env";
-						reg = <3f40000 40000>;
+						reg = <340000 40000>;
 					};
-					partition@3f80000 {
+					partition@380000 {
 						label = "u-boot";
-						reg = <3f80000 80000>;
+						reg = <380000 80000>;
 					};
 				};
 			};
@@ -186,6 +179,16 @@
 				reg = <ef600700 14>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <2 4>;
+				index = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ad7414@4a {
+					compatible = "adi,ad7414";
+					reg = <4a>;
+					interrupts = <19 8>;
+					interrupt-parent = <&UIC0>;
+				};
 			};
 
 			GPIO0: gpio@ef600b00 {
@@ -196,8 +199,22 @@
 			GPIO1: gpio@ef600c00 {
 				compatible = "ibm,gpio-440ep";
 				reg = <ef600c00 48>;
+
+			};
+
+			led@31 {
+				compatible = "linux,gpio-led";
+				linux,name = "green";
+				gpios = <&GPIO1 31>;
+			};
+	
+			led@30 {
+				compatible = "linux,gpio-led";
+				linux,name = "red";
+				gpios = <&GPIO1 30>;
 			};
 
+
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
 				reg = <ef600d00 c>;
diff --git a/arch/powerpc/platforms/44x/warp-nand.c b/arch/powerpc/platforms/44x/warp-nand.c
index 9150318..d293c70 100644
--- a/arch/powerpc/platforms/44x/warp-nand.c
+++ b/arch/powerpc/platforms/44x/warp-nand.c
@@ -11,8 +11,10 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/ndfc.h>
+#include <linux/of.h>
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
index 39cf615..8f7d016 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -12,6 +12,10 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/kthread.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/pika.h>
+#include <linux/delay.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -27,6 +31,18 @@ static __initdata struct of_device_id warp_of_bus[] = {
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
@@ -52,61 +68,232 @@ define_machine(warp) {
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
+static void __iomem *gpio_base;
+
+
+struct dtm_shutdown {
+	struct list_head list;
+	void (*func)(void *arg);
+	void *arg;
+};
 
 
-/* This is for the power LEDs 1 = on, 0 = off, -1 = leave alone */
-void warp_set_power_leds(int green, int red)
+int dtm_register_shutdown(void (*func)(void *arg), void *arg)
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
+	struct dtm_shutdown *shutdown;
+
+	shutdown = kmalloc(sizeof(struct dtm_shutdown), GFP_KERNEL);
+	if (shutdown == NULL)
+		return -ENOMEM;
+
+	shutdown->func = func;
+	shutdown->arg = arg;
+
+	list_add(&shutdown->list, &dtm_shutdown_list);
+
+	return 0;
+}
+
+int dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
+{
+	struct dtm_shutdown *shutdown;
+
+	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
+		if (shutdown->func == func && shutdown->arg == arg) {
+			list_del(&shutdown->list);
+			kfree(shutdown);
+			return 0;
+		}
+
+	return -EINVAL;
+}
+
+static irqreturn_t temp_isr(int irq, void *context)
+{
+	struct dtm_shutdown *shutdown;
+
+	local_irq_disable();
+
+	/* Run through the shutdown list. */
+	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
+		shutdown->func(shutdown->arg);
+
+	printk(KERN_EMERG "\n\nCritical Temperature Shutdown\n");
+
+	while (1) {
+		if (dtm_fpga) {
+			unsigned reset = in_be32(dtm_fpga + 0x14);
+			out_be32(dtm_fpga + 0x14, reset);
 		}
 
-		gpio_base = of_iomap(np, 0);
-		of_node_put(np);
-		if (gpio_base == NULL) {
-			printk(KERN_ERR __FILE__ ": Unable to map gpio");
-			return;
+		if (gpio_base) {
+			unsigned leds = in_be32(gpio_base);
+
+			/* green off, red toggle */
+			leds &= ~0x80000000;
+			leds ^=  0x40000000;
+
+			out_be32(gpio_base, leds);
 		}
+
+		mdelay(500);
+	}
+}
+
+static int pika_setup_leds(void)
+{
+	struct device_node *np;
+	const u32 *gpios;
+	int lenp;
+
+	np = of_find_compatible_node(NULL, NULL, "linux,gpio-led");
+	if (!np) {
+		printk(KERN_ERR __FILE__ ": Unable to find gpio-led\n");
+		return -ENOENT;
 	}
 
-	leds = in_be32(gpio_base);
+	gpios = of_get_property(np, "gpios", &lenp);
+	of_node_put(np);
+	if (!gpios || lenp != 8) {
+		printk(KERN_ERR __FILE__
+		       ": Unable to get gpios property (%d)\n", lenp);
+		return -ENOENT;
+	}
 
-	switch (green) {
-	case 0: leds &= ~LED_GREEN; break;
-	case 1: leds |=  LED_GREEN; break;
+	np = of_find_node_by_phandle(gpios[0]);
+	if (!np) {
+		printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
+		return -ENOENT;
 	}
-	switch (red) {
-	case 0: leds &= ~LED_RED; break;
-	case 1: leds |=  LED_RED; break;
+
+	gpio_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!gpio_base) {
+		printk(KERN_ERR __FILE__ ": Unable to map gpio");
+		return -ENOMEM;
 	}
 
-	out_be32(gpio_base, leds);
+	return 0;
 }
-EXPORT_SYMBOL(warp_set_power_leds);
 
+static void pika_setup_critical_temp(struct i2c_client *client)
+{
+	struct device_node *np;
+	int irq, rc;
+
+	/* Do this before enabling critical temp interrupt since we
+	 * may immediately interrupt.
+	 */
+	pika_setup_leds();
+
+	/* These registers are in 1 degree increments. */
+	i2c_smbus_write_byte_data(client, 2, 65); /* Thigh */
+	i2c_smbus_write_byte_data(client, 3, 55); /* Tlow */
+
+	np = of_find_compatible_node(NULL, NULL, "adi,ad7414");
+	if (np == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to find ad7414\n");
+		return;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	of_node_put(np);
+	if (irq  == NO_IRQ) {
+		printk(KERN_ERR __FILE__ ": Unable to get ad7414 irq\n");
+		return;
+	}
+
+	rc = request_irq(irq, temp_isr, 0, "ad7414", NULL);
+	if (rc) {
+		printk(KERN_ERR __FILE__
+		       ": Unable to request ad7414 irq %d = %d\n", irq, rc);
+		return;
+	}
+}
+
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
@@ -115,37 +302,44 @@ static int pika_dtm_thread(void __iomem *fpga)
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
+
+#else /* !CONFIG_SENSORS_AD7414 */
+
+int dtm_register_shutdown(void (*func)(void *arg), void *arg)
+{
+	return 0;
+}
+
+int dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
+{
+	return 0;
+}
+
 #endif
+
+EXPORT_SYMBOL(dtm_register_shutdown);
+EXPORT_SYMBOL(dtm_unregister_shutdown);
