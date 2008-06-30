Return-Path: <jonsmirl@gmail.com>
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 1/2] Convert i2c-mpc from a platform driver into a of_platform
	driver, V3
To: i2c@lm-sensors.org, Linuxppc-dev@ozlabs.org
Date: Mon, 30 Jun 2008 14:34:13 -0400
Message-ID: <20080630183413.4614.8840.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert i2c-mpc to an of_platform driver. Utilize the code in drivers/of-i2c.c to make i2c modules dynamically loadable by the device tree.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 arch/powerpc/sysdev/fsl_soc.c |  122 -----------------------------------------
 drivers/i2c/busses/i2c-mpc.c  |  104 ++++++++++++++++++++---------------
 2 files changed, 60 insertions(+), 166 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3a7054e..ebcec73 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -414,128 +414,6 @@ err:
 
 arch_initcall(gfar_of_init);
 
-#ifdef CONFIG_I2C_BOARDINFO
-#include <linux/i2c.h>
-struct i2c_driver_device {
-	char	*of_device;
-	char	*i2c_type;
-};
-
-static struct i2c_driver_device i2c_devices[] __initdata = {
-	{"ricoh,rs5c372a", "rs5c372a"},
-	{"ricoh,rs5c372b", "rs5c372b"},
-	{"ricoh,rv5c386",  "rv5c386"},
-	{"ricoh,rv5c387a", "rv5c387a"},
-	{"dallas,ds1307",  "ds1307"},
-	{"dallas,ds1337",  "ds1337"},
-	{"dallas,ds1338",  "ds1338"},
-	{"dallas,ds1339",  "ds1339"},
-	{"dallas,ds1340",  "ds1340"},
-	{"stm,m41t00",     "m41t00"},
-	{"dallas,ds1374",  "rtc-ds1374"},
-};
-
-static int __init of_find_i2c_driver(struct device_node *node,
-				     struct i2c_board_info *info)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
-		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
-			continue;
-		if (strlcpy(info->type, i2c_devices[i].i2c_type,
-			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
-			return -ENOMEM;
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static void __init of_register_i2c_devices(struct device_node *adap_node,
-					   int bus_num)
-{
-	struct device_node *node = NULL;
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
-		if (of_find_i2c_driver(node, &info) < 0)
-			continue;
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
-	unsigned int i = 0;
-	struct platform_device *i2c_dev;
-	int ret;
-
-	for_each_compatible_node(np, NULL, "fsl-i2c") {
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
-		of_register_i2c_devices(np, i++);
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
 
 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index a076129..36bea49 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -17,7 +17,8 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_i2c.h>
 
 #include <asm/io.h>
 #include <linux/fsl_devices.h>
@@ -25,13 +26,13 @@
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
@@ -315,102 +316,117 @@ static struct i2c_adapter mpc_ops = {
 	.timeout = 1,
 };
 
-static int fsl_i2c_probe(struct platform_device *pdev)
+static int __devinit fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
-	struct fsl_i2c_platform_data *pdata;
-	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0)
-		i2c->irq = NO_IRQ; /* Use polling */
+	if (of_get_property(op->node, "dfsrr", NULL))
+		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
 
-	i2c->flags = pdata->device_flags;
-	init_waitqueue_head(&i2c->queue);
+	if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
+			of_device_is_compatible(op->node, "mpc5200-i2c"))
+		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
 
-	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
+	init_waitqueue_head(&i2c->queue);
 
+	i2c->base = of_iomap(op->node, 0);
 	if (!i2c->base) {
 		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
 		result = -ENOMEM;
 		goto fail_map;
 	}
 
-	if (i2c->irq != NO_IRQ)
-		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
-			printk(KERN_ERR
-			       "i2c-mpc - failed to attach interrupt\n");
-			goto fail_irq;
+	i2c->irq = irq_of_parse_and_map(op->node, 0);
+	if (i2c->irq != NO_IRQ) { /* i2c->irq = NO_IRQ implies polling */
+		result = request_irq(i2c->irq, mpc_i2c_isr,
+							IRQF_SHARED, "i2c-mpc", i2c);
+		if (result < 0) {
+			printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
+			goto fail_request;
 		}
-
+	}
+	
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
+
+	result = i2c_add_adapter(&i2c->adap);
+	if (result < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
+	of_register_i2c_devices(&i2c->adap, op->node);
 
 	return result;
 
-      fail_add:
-	if (i2c->irq != NO_IRQ)
-		free_irq(i2c->irq, i2c);
-      fail_irq:
-	iounmap(i2c->base);
-      fail_map:
+ fail_add:
+	dev_set_drvdata(&op->dev, NULL);
+	free_irq(i2c->irq, i2c);
+ fail_request:
+	irq_dispose_mapping(i2c->irq);
+ 	iounmap(i2c->base);
+ fail_map:
 	kfree(i2c);
 	return result;
 };
 
-static int fsl_i2c_remove(struct platform_device *pdev)
+static int __devexit fsl_i2c_remove(struct of_device *op)
 {
-	struct mpc_i2c *i2c = platform_get_drvdata(pdev);
+	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
 
 	i2c_del_adapter(&i2c->adap);
-	platform_set_drvdata(pdev, NULL);
+	dev_set_drvdata(&op->dev, NULL);
 
 	if (i2c->irq != NO_IRQ)
 		free_irq(i2c->irq, i2c);
 
+	irq_dispose_mapping(i2c->irq);
 	iounmap(i2c->base);
 	kfree(i2c);
 	return 0;
 };
 
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:fsl-i2c");
+static const struct of_device_id mpc_i2c_of_match[] = {
+	{.compatible = "fsl-i2c",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpc_i2c_of_match);
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
+	.probe		= fsl_i2c_probe,
+	.remove		= __devexit_p(fsl_i2c_remove),
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= DRV_NAME,
 	},
 };
 
 static int __init fsl_i2c_init(void)
 {
-	return platform_driver_register(&fsl_i2c_driver);
+	int rv;
+
+	rv = of_register_platform_driver(&mpc_i2c_driver);
+	if (rv)
+		printk(KERN_ERR DRV_NAME 
+		" of_register_platform_driver failed (%i)\n", rv);
+	return rv;
 }
 
 static void __exit fsl_i2c_exit(void)
 {
-	platform_driver_unregister(&fsl_i2c_driver);
+	of_unregister_platform_driver(&mpc_i2c_driver);
 }
 
 module_init(fsl_i2c_init);
