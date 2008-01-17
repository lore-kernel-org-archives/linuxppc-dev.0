Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2C0AADDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 07:23:23 +1100 (EST)
Message-ID: <478FB93A.7040505@pikatech.com>
Date: Thu, 17 Jan 2008 15:23:22 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Warp Watchdog
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The taco, er warp, has a watchdog timer built into the fpga. The 
watchdog is very trivial and very tied to the warp. I have put it has 
part of the platform code rather than a standalone module.

Two reasons for this: one, once started it can't be stopped. A module 
unload would be fatal ;) Two, it is so closely tied to the taco that it 
really has no use otherwise.

The platform always starts the watchdog, assuming you asked for the 
watchdog, but does not enable it until hit from user mode.

What is the general feeling about this implementation? I am not 
submitting this for inclusion in the kernel right now, just feeling out 
what others think.

Cheers,
   Sean

diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
new file mode 100644
index 0000000..a8b0d2c
--- /dev/null
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -0,0 +1,270 @@
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
+	return of_flat_dt_is_compatible(root, "pika,warp");
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
+		struct device_node *np;
+
+		/* Power LEDS are on the second GPIO controller */
+		np = of_find_compatible_node(NULL, NULL, "ibm,gpio-440EP");
+		if (np)
+			np = of_find_compatible_node(np, NULL, "ibm,gpio-440EP");
+		if (np == NULL) {
+			printk(KERN_ERR __FILE__ ": Unable to find gpio\n");
+			return;
+		}
+
+		gpio_base = of_iomap(np, 0);
+		of_node_put(np);
+		if (gpio_base == NULL) {
+			printk(KERN_ERR __FILE__ ": Unable to map gpio");
+			return;
+		}
+	}
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
+#ifdef CONFIG_WARP_WATCHDOG
+
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+
+static void __iomem *wd_fpga;
+
+static inline void warpwd_ping(void)
+{
+	unsigned reset = in_be32(wd_fpga + 0x14);
+	out_be32(wd_fpga + 0x14, reset);
+}
+
+static int warpwd_open(struct inode *inode, struct file *file)
+{
+	unsigned reset;
+
+	/* Enable the watchdog. Note this is an implicit ping. */
+	reset = in_be32(wd_fpga + 0x14);
+	reset |= 0xf80; /* enable with max timeout - 15 seconds */
+	out_be32(wd_fpga + 0x14, reset);
+
+	return 0;
+}
+
+static int warpwd_release(struct inode *inode, struct file *file)
+{
+	warpwd_ping(); /* one last time */
+	return 0;
+}
+
+static ssize_t warpwd_write(struct file *file, const char __user *buf, size_t count,
+							loff_t *ppos)
+{
+	warpwd_ping();
+	return count;
+}
+
+/* We support the bare minimum to be conformant. */
+static int warpwd_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+						unsigned long arg)
+{
+	if (cmd == WDIOC_KEEPALIVE) {
+		warpwd_ping();
+		return 0;
+	} else
+		return -EINVAL;
+}
+
+static const struct file_operations warpwd_fops = {
+	.owner		= THIS_MODULE,
+	.open		= warpwd_open,
+	.release	= warpwd_release,
+	.write		= warpwd_write,
+	.ioctl		= warpwd_ioctl,
+};
+
+static struct miscdevice warpwd_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &warpwd_fops,
+};
+
+static int __init warpwd_init(void __iomem *fpga)
+{
+	int ret;
+
+	wd_fpga = fpga;
+
+	ret = misc_register(&warpwd_miscdev);
+	if (ret) {
+		printk(KERN_ERR "warpwd: cannot register miscdev on minor=%d (err=%d)\n",
+			   WATCHDOG_MINOR, ret);
+		return ret;
+	}
+
+	return 0;
+}
+#else
+static init __init warpwd_init(void __iomem *fpga)
+{
+	printk(KERN_WARNING "Warp watchdog disabled\n");
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
+		of_node_put(np);
+		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+		return -EBUSY;
+	}
+
+	/* We do not call of_iomap here since it would map in the entire
+	 * fpga space, which is over 8k.
+	 */
+	if (of_address_to_resource(np, 0, &res)) {
+		of_node_put(np);
+		printk(KERN_ERR __FILE__ ": Unable to get FPGA address\n");
+		return -ENOENT;
+	}
+	of_node_put(np);
+
+	fpga = ioremap(res.start, 0x24);
+	if (fpga == NULL) {
+		printk(KERN_ERR __FILE__ ": Unable to map FPGA\n");
+		return -ENOENT;
+	}
+
+	pika_dtm_start(fpga);
+
+	warpwd_init(fpga);
+
+	return 0;
+}
+device_initcall(warp_fpga_init);
