Return-Path: <jonsmirl@gmail.com>
Received: from vms046pub.verizon.net (vms046pub.verizon.net [206.46.252.46])
	by ozlabs.org (Postfix) with ESMTP id 92821DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 09:21:39 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JSH00DVLSMVOWB2@vms046.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 15:20:55 -0600 (CST)
Date: Mon, 03 Dec 2007 16:20:38 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 3/4] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
In-reply-to: <20071203212032.23543.3453.stgit@terra.home>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20071203212038.23543.78791.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071203212032.23543.3453.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert MPC i2c driver from being a platform_driver to an open firmware version. Error returns were improved. Routine names were changed from fsl_ to mpc_ to make them match the file name.
---

 arch/powerpc/sysdev/fsl_soc.c |   96 ---------------------
 drivers/i2c/busses/i2c-mpc.c  |  185 +++++++++++++++++++++++++++--------------
 2 files changed, 123 insertions(+), 158 deletions(-)


diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index e4c766e..d6ef264 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -318,102 +318,6 @@ err:
 
 arch_initcall(gfar_of_init);
 
-#ifdef CONFIG_I2C_BOARDINFO
-#include <linux/i2c.h>
-
-static void __init of_register_i2c_devices(struct device_node *adap_node,
-					   int bus_num)
-{
-	struct device_node *node = NULL;
-	const char *compatible;
-
-	while ((node = of_get_next_child(adap_node, node))) {
-		struct i2c_board_info info = {};
-		const u32 *addr;
-		int len;
-
-		addr = of_get_property(node, "reg", &len);
-		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-			printk(KERN_WARNING "fsl_soc.c: invalid i2c device entry\n");
-			continue;
-		}
-
-		info.irq = irq_of_parse_and_map(node, 0);
-		if (info.irq == NO_IRQ)
-			info.irq = -1;
-
-		compatible = of_get_property(node, "compatible", &len);
-		if (!compatible) {
-			printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing compatible attribute\n");
-			continue;
-		}
-		strncpy(info.driver_name, compatible, sizeof(info.driver_name));
-		
-		info.addr = *addr;
-
-		i2c_register_board_info(bus_num, &info, 1);
-	}
-}
-
-static int __init fsl_i2c_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *i2c_dev;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
-	     i++) {
-		struct resource r[2];
-		struct fsl_i2c_platform_data i2c_data;
-		const unsigned char *flags = NULL;
-
-		memset(&r, 0, sizeof(r));
-		memset(&i2c_data, 0, sizeof(i2c_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-
-		of_irq_to_resource(np, 0, &r[1]);
-
-		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
-		if (IS_ERR(i2c_dev)) {
-			ret = PTR_ERR(i2c_dev);
-			goto err;
-		}
-
-		i2c_data.device_flags = 0;
-		flags = of_get_property(np, "dfsrr", NULL);
-		if (flags)
-			i2c_data.device_flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
-		flags = of_get_property(np, "fsl5200-clocking", NULL);
-		if (flags)
-			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
-
-		ret =
-		    platform_device_add_data(i2c_dev, &i2c_data,
-					     sizeof(struct
-						    fsl_i2c_platform_data));
-		if (ret)
-			goto unreg;
-
-		of_register_i2c_devices(np, i);
-	}
-
-	return 0;
-
-unreg:
-	platform_device_unregister(i2c_dev);
-err:
-	return ret;
-}
-
-arch_initcall(fsl_i2c_of_init);
-#endif
-
 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
 {
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index d8de4ac..bb6284e 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/io.h>
 #include <linux/fsl_devices.h>
@@ -25,13 +25,13 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 
-#define MPC_I2C_ADDR  0x00
+#define DRV_NAME "mpc-i2c"
+
 #define MPC_I2C_FDR 	0x04
 #define MPC_I2C_CR	0x08
 #define MPC_I2C_SR	0x0c
 #define MPC_I2C_DR	0x10
 #define MPC_I2C_DFSRR 0x14
-#define MPC_I2C_REGION 0x20
 
 #define CCR_MEN  0x80
 #define CCR_MIEN 0x40
@@ -180,7 +180,7 @@ static void mpc_i2c_stop(struct mpc_i2c *i2c)
 static int mpc_write(struct mpc_i2c *i2c, int target,
 		     const u8 * data, int length, int restart)
 {
-	int i;
+	int i, result;
 	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;
 
@@ -192,15 +192,15 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 	/* Write target byte */
 	writeb((target << 1), i2c->base + MPC_I2C_DR);
 
-	if (i2c_wait(i2c, timeout, 1) < 0)
-		return -1;
+	if ((result = i2c_wait(i2c, timeout, 1)) < 0)
+		return result;
 
 	for (i = 0; i < length; i++) {
 		/* Write data byte */
 		writeb(data[i], i2c->base + MPC_I2C_DR);
 
-		if (i2c_wait(i2c, timeout, 1) < 0)
-			return -1;
+		if ((result = i2c_wait(i2c, timeout, 1)) < 0)
+			return result;
 	}
 
 	return 0;
@@ -210,7 +210,7 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 		    u8 * data, int length, int restart)
 {
 	unsigned timeout = i2c->adap.timeout;
-	int i;
+	int i, result;
 	u32 flags = restart ? CCR_RSTA : 0;
 
 	/* Start with MEN */
@@ -221,8 +221,8 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	/* Write target address byte - this time with the read flag set */
 	writeb((target << 1) | 1, i2c->base + MPC_I2C_DR);
 
-	if (i2c_wait(i2c, timeout, 1) < 0)
-		return -1;
+	if ((result = i2c_wait(i2c, timeout, 1)) < 0)
+		return result;
 
 	if (length) {
 		if (length == 1)
@@ -234,8 +234,8 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	}
 
 	for (i = 0; i < length; i++) {
-		if (i2c_wait(i2c, timeout, 0) < 0)
-			return -1;
+		if ((result = i2c_wait(i2c, timeout, 0)) < 0)
+			return result;
 
 		/* Generate txack on next to last byte */
 		if (i == length - 2)
@@ -312,105 +312,166 @@ static struct i2c_adapter mpc_ops = {
 	.retries = 1
 };
 
-static int fsl_i2c_probe(struct platform_device *pdev)
+struct i2c_driver_device {
+	char	*of_device;
+	char	*i2c_driver;
+	char	*i2c_type;
+};
+
+static void of_register_i2c_devices(struct i2c_adapter *adap, struct device_node *adap_node)
+{
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info;
+		const u32 *addr;
+		const char *compatible;
+		int len;
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
+			printk(KERN_ERR "i2c-mpc.c: invalid entry, missing reg attribute\n");
+			continue;
+		}
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq == NO_IRQ)
+			info.irq = -1;
+
+		compatible = of_get_property(node, "compatible", &len);
+		if (!compatible) {
+			printk(KERN_ERR "i2c-mpc.c: invalid entry, missing compatible attribute\n");
+			continue;
+		}
+		strncpy(info.driver_name, compatible, sizeof(info.driver_name));
+		info.type[0] = '\0';
+
+		info.platform_data = NULL;
+		info.addr = *addr;
+		
+		if (!i2c_new_device(adap, &info)) {
+			printk(KERN_ERR "i2c-mpc.c: Failed to load driver for %s\n", info.driver_name);
+			continue;
+		}
+	}
+}
+
+static int mpc_i2c_probe(struct of_device *op, const struct of_device_id *match)
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
-	struct fsl_i2c_platform_data *pdata;
-	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
 
-	if (!(i2c = kzalloc(sizeof(*i2c), GFP_KERNEL))) {
+	if (!(i2c = kzalloc(sizeof(*i2c), GFP_KERNEL)))
 		return -ENOMEM;
-	}
 
-	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
-		result = -ENXIO;
-		goto fail_get_irq;
-	}
-	i2c->flags = pdata->device_flags;
-	init_waitqueue_head(&i2c->queue);
+	if (of_get_property(op->node, "dfsrr", NULL))
+		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
 
-	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
+	if (of_device_is_compatible(op->node, "mpc5200-i2c"))
+		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
 
+	init_waitqueue_head(&i2c->queue);
+
+	i2c->base = of_iomap(op->node, 0);
 	if (!i2c->base) {
 		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
 		result = -ENOMEM;
 		goto fail_map;
 	}
 
-	if (i2c->irq != 0)
-		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
-			printk(KERN_ERR
-			       "i2c-mpc - failed to attach interrupt\n");
-			goto fail_irq;
-		}
+	i2c->irq = irq_of_parse_and_map(op->node, 0);
+	if (i2c->irq == NO_IRQ) {
+		result = -ENXIO;
+		goto fail_irq;
+	}
+	
+	if ((result = request_irq(i2c->irq, mpc_i2c_isr,
+				  	IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
+		printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
+		goto fail_request;
+	}
 
 	mpc_i2c_setclock(i2c);
-	platform_set_drvdata(pdev, i2c);
+	
+	dev_set_drvdata(&op->dev, i2c);
 
 	i2c->adap = mpc_ops;
-	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
-	i2c->adap.dev.parent = &pdev->dev;
-	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
+	i2c->adap.dev.parent = &op->dev;
+	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
+	
+	of_register_i2c_devices(&i2c->adap, op->node);
 
 	return result;
 
-      fail_add:
-	if (i2c->irq != 0)
-		free_irq(i2c->irq, i2c);
-      fail_irq:
+fail_add:
+	free_irq(i2c->irq, i2c);
+fail_request:
+	irq_dispose_mapping(i2c->irq);
+fail_irq:
 	iounmap(i2c->base);
-      fail_map:
-      fail_get_irq:
+fail_map:
 	kfree(i2c);
 	return result;
 };
 
-static int fsl_i2c_remove(struct platform_device *pdev)
+static int mpc_i2c_remove(struct of_device *op)
 {
-	struct mpc_i2c *i2c = platform_get_drvdata(pdev);
+	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
 
 	i2c_del_adapter(&i2c->adap);
-	platform_set_drvdata(pdev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
-	if (i2c->irq != 0)
+	if (i2c->irq != NO_IRQ)
 		free_irq(i2c->irq, i2c);
-
+	
+	irq_dispose_mapping(i2c->irq);
 	iounmap(i2c->base);
 	kfree(i2c);
 	return 0;
 };
 
+static struct of_device_id mpc_i2c_of_match[] = {
+	{
+		.compatible	= "fsl-i2c",
+	},
+};
+MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
+
+
 /* Structure for a device driver */
-static struct platform_driver fsl_i2c_driver = {
-	.probe = fsl_i2c_probe,
-	.remove = fsl_i2c_remove,
-	.driver	= {
-		.owner = THIS_MODULE,
-		.name = "fsl-i2c",
+static struct of_platform_driver mpc_i2c_driver = {
+	.match_table	= mpc_i2c_of_match,
+	.probe		= mpc_i2c_probe,
+	.remove		= __devexit_p(mpc_i2c_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= DRV_NAME,
 	},
 };
 
-static int __init fsl_i2c_init(void)
+static int __init mpc_i2c_init(void)
 {
-	return platform_driver_register(&fsl_i2c_driver);
+	int rv;
+
+	rv = of_register_platform_driver(&mpc_i2c_driver);
+	if (rv) {
+		printk(KERN_ERR DRV_NAME " of_register_platform_driver failed (%i)\n", rv);
+		return rv;
+	}
+	return 0;
 }
 
-static void __exit fsl_i2c_exit(void)
+static void __exit mpc_i2c_exit(void)
 {
-	platform_driver_unregister(&fsl_i2c_driver);
+	of_unregister_platform_driver(&mpc_i2c_driver);
 }
 
-module_init(fsl_i2c_init);
-module_exit(fsl_i2c_exit);
+module_init(mpc_i2c_init);
+module_exit(mpc_i2c_exit);
 
 MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
 MODULE_DESCRIPTION
