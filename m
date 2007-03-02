Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id AD16BDDF1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 21:56:53 +1100 (EST)
Date: Fri, 2 Mar 2007 11:47:18 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] i2c-mpc: add support for arch/powerpc/ tree
Message-ID: <20070302104718.GU4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add I2C support for mpc5200 powerpc tree.
Tested to work on eeprom on lite5200b.

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
I'm not sure how this relates to FSL_SOC config option and
fsl_i2c_of_init. Comments?


	Domen


 arch/powerpc/boot/dts/lite5200b.dts |    2 
 drivers/i2c/busses/i2c-mpc.c        |   80 +++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 2 deletions(-)

Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -328,6 +328,7 @@
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
@@ -337,6 +338,7 @@
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
 			interrupt-parent = <500>;
+			fsl5200-clocking;
 		};
 		sram@8000 {
 			device_type = "sram";
Index: grant.git/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- grant.git.orig/drivers/i2c/busses/i2c-mpc.c
+++ grant.git/drivers/i2c/busses/i2c-mpc.c
@@ -20,6 +20,10 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
+#ifdef CONFIG_PPC_MERGE
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#endif
 #include <asm/io.h>
 #include <linux/fsl_devices.h>
 #include <linux/i2c.h>
@@ -287,25 +291,50 @@ static struct i2c_adapter mpc_ops = {
 	.retries = 1
 };
 
+#ifdef CONFIG_PPC_MERGE
+static int fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
+#else
 static int fsl_i2c_probe(struct platform_device *pdev)
+#endif
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
 	struct fsl_i2c_platform_data *pdata;
+#ifdef CONFIG_PPC_MERGE
+	struct resource __r;
+	struct resource *r = &__r;
+
+	result = of_address_to_resource(op->node, 0, r);
+	if (result) {
+		printk(KERN_ERR "i2c-mpc - error parsing device node resource\n");
+		return result;
+	}
+
+	pdata = (struct fsl_i2c_platform_data *) op->dev.platform_data;
+#else
 	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
+#endif
 
 	if (!(i2c = kzalloc(sizeof(*i2c), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_PPC_MERGE
+	i2c->irq = irq_of_parse_and_map(op->node, 0);
+	if (get_property(op->node, "dfsrr", NULL))
+		i2c->flags = FSL_I2C_DEV_SEPARATE_DFSRR;
+	if (get_property(op->node, "fsl5200-clocking", NULL))
+		i2c->flags = FSL_I2C_DEV_CLOCK_5200;
+#else
 	i2c->irq = platform_get_irq(pdev, 0);
+	i2c->flags = pdata->device_flags;
+#endif
 	if (i2c->irq < 0) {
 		result = -ENXIO;
 		goto fail_get_irq;
 	}
-	i2c->flags = pdata->device_flags;
 	init_waitqueue_head(&i2c->queue);
 
 	i2c->base = ioremap((phys_addr_t)r->start, MPC_I2C_REGION);
@@ -325,11 +354,16 @@ static int fsl_i2c_probe(struct platform
 		}
 
 	mpc_i2c_setclock(i2c);
-	platform_set_drvdata(pdev, i2c);
 
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
+#ifdef CONFIG_PPC_MERGE
+	dev_set_drvdata(&op->dev, i2c);
+	i2c->adap.dev.parent = &op->dev;
+#else
+	platform_set_drvdata(pdev, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
+#endif
 	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
@@ -348,21 +382,54 @@ static int fsl_i2c_probe(struct platform
 	return result;
 };
 
+#ifdef CONFIG_PPC_MERGE
+static int fsl_i2c_remove(struct of_device *op)
+#else
 static int fsl_i2c_remove(struct platform_device *pdev)
+#endif
 {
+#ifdef CONFIG_PPC_MERGE
+	struct mpc_i2c *i2c = dev_get_drvdata(&op->dev);
+#else
 	struct mpc_i2c *i2c = platform_get_drvdata(pdev);
+#endif
 
 	i2c_del_adapter(&i2c->adap);
+#ifdef CONFIG_PPC_MERGE
+	dev_set_drvdata(&op->dev, NULL);
+#else
 	platform_set_drvdata(pdev, NULL);
+#endif
 
 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);
 
+#ifdef CONFIG_PPC_MERGE
+	irq_dispose_mapping(i2c->irq);
+#endif
 	iounmap(i2c->base);
 	kfree(i2c);
 	return 0;
 };
 
+#ifdef CONFIG_PPC_MERGE
+static struct of_device_id fsl_i2c_of_match[] = {
+	{ .compatible = "mpc5200-i2c", },
+	{},
+};
+
+static struct of_platform_driver fsl_i2c_driver = {
+	.name = "fsl-i2c",
+	.owner = THIS_MODULE,
+	.match_table = fsl_i2c_of_match,
+	.probe = fsl_i2c_probe,
+	.remove = fsl_i2c_remove,
+	.driver	= {
+		.name = "fsl-i2c",
+		.owner = THIS_MODULE,
+	},
+};
+#else
 /* Structure for a device driver */
 static struct platform_driver fsl_i2c_driver = {
 	.probe = fsl_i2c_probe,
@@ -372,15 +439,24 @@ static struct platform_driver fsl_i2c_dr
 		.name = "fsl-i2c",
 	},
 };
+#endif
 
 static int __init fsl_i2c_init(void)
 {
+#ifdef CONFIG_PPC_MERGE
+	return of_register_platform_driver(&fsl_i2c_driver);
+#else
 	return platform_driver_register(&fsl_i2c_driver);
+#endif
 }
 
 static void __exit fsl_i2c_exit(void)
 {
+#ifdef CONFIG_PPC_MERGE
+	of_unregister_platform_driver(&fsl_i2c_driver);
+#else
 	platform_driver_unregister(&fsl_i2c_driver);
+#endif
 }
 
 module_init(fsl_i2c_init);
