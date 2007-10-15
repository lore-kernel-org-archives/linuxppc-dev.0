Return-Path: <SRS0=UFNa=PJ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id AC1B8DDF2C
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 23:35:46 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: i2c@lm-sensors.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
Date: Mon, 15 Oct 2007 15:29:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710151529.11485.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks existing ibm-iic driver to support of_platform_device
and enables it to talk to device tree directly. The "old" OCP interface
for arch/ppc is still supported via #ifdef's and shall be removed when
arch/ppc is gone in a few months.

This is done to enable I2C support for the PPC4xx platforms now
being moved from arch/ppc (ocp) to arch/powerpc (of).

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/i2c/busses/Kconfig       |    2 +-
 drivers/i2c/busses/i2c-ibm_iic.c |  209 +++++++++++++++++++++++++++++++++++++-
 drivers/i2c/busses/i2c-ibm_iic.h |    2 +
 3 files changed, 211 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index de95c75..a47b5e6 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -241,7 +241,7 @@ config I2C_PIIX4
 
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
-	depends on IBM_OCP
+	depends on 4xx
 	help
 	  Say Y here if you want to use IIC peripheral found on 
 	  embedded IBM PPC 4xx based systems. 
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 956b947..78c6bf4 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -39,8 +39,13 @@
 #include <asm/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-id.h>
+
+#ifdef CONFIG_PPC_MERGE
+#include <linux/of_platform.h>
+#else
 #include <asm/ocp.h>
 #include <asm/ibm4xx.h>
+#endif
 
 #include "i2c-ibm_iic.h"
 
@@ -57,6 +62,10 @@ static int iic_force_fast;
 module_param(iic_force_fast, bool, 0);
 MODULE_PARM_DESC(iic_fast_poll, "Force fast mode (400 kHz)");
 
+#ifdef CONFIG_PPC_MERGE
+static int device_idx = -1;
+#endif
+
 #define DBG_LEVEL 0
 
 #ifdef DBG
@@ -660,8 +669,205 @@ static inline u8 iic_clckdiv(unsigned int opb)
 /*
  * Register single IIC interface
  */
-static int __devinit iic_probe(struct ocp_device *ocp){
 
+#ifdef CONFIG_PPC_MERGE
+/*
+ * device-tree (of) when used from arch/powerpc
+ */
+static int __devinit iic_probe(struct of_device *ofdev,
+			       const struct of_device_id *match)
+{
+	struct ibm_iic_private* dev;
+	struct i2c_adapter* adap;
+	struct device_node *np;
+	int ret = -ENODEV;
+	int  irq, len;
+	const u32 *prop;
+	struct resource res;
+
+	np = ofdev->node;
+	if (!(dev = kzalloc(sizeof(*dev), GFP_KERNEL))) {
+		printk(KERN_CRIT "ibm-iic(%s): failed to allocate device data\n",
+		       np->full_name);
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	dev->np = np;
+	irq = irq_of_parse_and_map(np, 0);
+
+	if (of_address_to_resource(np, 0, &res)) {
+		printk(KERN_ERR "ibd-iic(%s): Can't get registers address\n",
+		       np->full_name);
+		goto fail1;
+	}
+	dev->paddr = res.start;
+
+	if (!request_mem_region(dev->paddr, sizeof(struct iic_regs), "ibm_iic")) {
+		ret = -EBUSY;
+		goto fail1;
+	}
+	dev->vaddr = ioremap(dev->paddr, sizeof(struct iic_regs));
+
+	if (dev->vaddr == NULL) {
+		printk(KERN_CRIT "ibm-iic(%s): failed to ioremap device regs\n",
+		       dev->np->full_name);
+		ret = -ENXIO;
+		goto fail2;
+	}
+
+	init_waitqueue_head(&dev->wq);
+
+	dev->irq = iic_force_poll ? -1 : (irq == NO_IRQ) ? -1 : irq;
+	if (dev->irq >= 0){
+		/* Disable interrupts until we finish initialization,
+		 * assumes level-sensitive IRQ setup...
+		 */
+		iic_interrupt_mode(dev, 0);
+		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)) {
+			printk(KERN_ERR "ibm-iic(%s): request_irq %d failed\n",
+			       dev->np->full_name, dev->irq);
+			/* Fallback to the polling mode */
+			dev->irq = -1;
+		}
+	}
+
+	if (dev->irq < 0)
+		printk(KERN_WARNING "ibm-iic(%s): using polling mode\n",
+		       dev->np->full_name);
+
+	/* Board specific settings */
+	prop = of_get_property(np, "iic-mode", &len);
+	/* use 400kHz only if stated in dts, 100kHz otherwise */
+	dev->fast_mode = (prop && (*prop == 400));
+	/* clckdiv is the same for *all* IIC interfaces,
+	 * but I'd rather make a copy than introduce another global. --ebs
+	 */
+	/* Parent bus should have frequency filled */
+	prop = of_get_property(of_get_parent(np), "clock-frequency", &len);
+	if (prop == NULL) {
+		printk(KERN_ERR
+		       "ibm-iic(%s):no clock-frequency prop on parent bus!\n",
+		       dev->np->full_name);
+		goto fail;
+	}
+
+	dev->clckdiv = iic_clckdiv(*prop);
+	DBG("%s: clckdiv = %d\n", dev->np->full_name, dev->clckdiv);
+
+	/* Initialize IIC interface */
+	iic_dev_init(dev);
+
+	/* Register it with i2c layer */
+	adap = &dev->adap;
+	adap->dev.parent = &ofdev->dev;
+	strcpy(adap->name, "IBM IIC");
+	i2c_set_adapdata(adap, dev);
+	adap->id = I2C_HW_OCP;
+	adap->class = I2C_CLASS_HWMON;
+	adap->algo = &iic_algo;
+	adap->client_register = NULL;
+	adap->client_unregister = NULL;
+	adap->timeout = 1;
+	adap->retries = 1;
+
+	dev->idx = ++device_idx;
+	adap->nr = dev->idx;
+	if ((ret = i2c_add_numbered_adapter(adap)) < 0) {
+		printk(KERN_CRIT"ibm-iic(%s): failed to register i2c adapter\n",
+		       dev->np->full_name);
+		goto fail;
+	}
+
+	printk(KERN_INFO "ibm-iic(%s): using %s mode\n", dev->np->full_name,
+	       dev->fast_mode ?
+	       "fast (400 kHz)" : "standard (100 kHz)");
+
+	return 0;
+
+fail:
+	if (dev->irq >= 0){
+		iic_interrupt_mode(dev, 0);
+		free_irq(dev->irq, dev);
+	}
+
+	iounmap(dev->vaddr);
+fail2:
+	release_mem_region(dev->paddr, sizeof(struct iic_regs));
+fail1:
+	dev_set_drvdata(&ofdev->dev, NULL);
+	kfree(dev);
+
+	return ret;
+}
+
+/*
+ * Cleanup initialized IIC interface
+ */
+static int __devexit iic_remove(struct of_device *ofdev)
+{
+	struct ibm_iic_private *dev =
+		(struct ibm_iic_private *)dev_get_drvdata(&ofdev->dev);
+	BUG_ON(dev == NULL);
+	if (i2c_del_adapter(&dev->adap)){
+		printk(KERN_CRIT "ibm-iic(%s): failed to delete i2c adapter\n",
+		       dev->np->full_name);
+		/* That's *very* bad, just shutdown IRQ ... */
+		if (dev->irq >= 0){
+			iic_interrupt_mode(dev, 0);
+			free_irq(dev->irq, dev);
+			dev->irq = -1;
+		}
+	} else {
+		if (dev->irq >= 0){
+			iic_interrupt_mode(dev, 0);
+			free_irq(dev->irq, dev);
+		}
+		iounmap(dev->vaddr);
+		release_mem_region(dev->paddr, sizeof(struct iic_regs));
+		kfree(dev);
+	}
+	return 0;
+}
+
+static struct of_device_id ibm_iic_match[] = {
+	{
+		.type = "i2c",
+		.compatible = "ibm,iic",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ibm_iic_match);
+
+static struct of_platform_driver ibm_iic_driver = {
+	.name = "ibm-iic",
+	.match_table = ibm_iic_match,
+	.probe = iic_probe,
+	.remove = iic_remove,
+#if defined(CONFIG_PM)
+	.suspend = NULL,
+	.resume = NULL,
+#endif
+};
+
+static int __init iic_init(void)
+{
+	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
+	return of_register_platform_driver(&ibm_iic_driver);
+}
+
+static void __exit iic_exit(void)
+{
+	of_unregister_platform_driver(&ibm_iic_driver);
+}
+#else
+/*
+ * OCP when used from arch/ppc
+ */
+static int __devinit iic_probe(struct ocp_device *ocp)
+{
 	struct ibm_iic_private* dev;
 	struct i2c_adapter* adap;
 	struct ocp_func_iic_data* iic_data = ocp->def->additions;
@@ -828,6 +1034,7 @@ static void __exit iic_exit(void)
 {
 	ocp_unregister_driver(&ibm_iic_driver);
 }
+#endif /* CONFIG_PPC_MERGE */
 
 module_init(iic_init);
 module_exit(iic_exit);
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
index fdaa482..c15b091 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -50,6 +50,8 @@ struct ibm_iic_private {
 	int irq;
 	int fast_mode;
 	u8  clckdiv;
+	struct device_node *np;
+	phys_addr_t paddr;
 };
 
 /* IICx_CNTL register */
-- 
1.5.3.4
