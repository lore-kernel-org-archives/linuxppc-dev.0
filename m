Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id E1867DDF52
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 00:41:48 +1000 (EST)
Message-Id: <20080610142947.974805307@arndb.de>
References: <20080610142702.354823071@arndb.de>
Date: Tue, 10 Jun 2008 16:27:05 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 3/5] powerpc/ibm_iic: remove support for OCP
Cc: linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

OCP is dead, so all code referring to it can go away as well.

Cc: i2c@lm-sensors.org
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-ibm_iic.c |  181 --------------------------------------
 1 files changed, 0 insertions(+), 181 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 85dbf34..3a364a7 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -42,13 +42,7 @@
 #include <asm/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-id.h>
-
-#ifdef CONFIG_IBM_OCP
-#include <asm/ocp.h>
-#include <asm/ibm4xx.h>
-#else
 #include <linux/of_platform.h>
-#endif
 
 #include "i2c-ibm_iic.h"
 
@@ -665,180 +659,6 @@ static inline u8 iic_clckdiv(unsigned int opb)
 	return (u8)((opb + 9) / 10 - 1);
 }
 
-#ifdef CONFIG_IBM_OCP
-/*
- * Register single IIC interface
- */
-static int __devinit iic_probe(struct ocp_device *ocp){
-
-	struct ibm_iic_private* dev;
-	struct i2c_adapter* adap;
-	struct ocp_func_iic_data* iic_data = ocp->def->additions;
-	int ret;
-
-	if (!iic_data)
-		printk(KERN_WARNING"ibm-iic%d: missing additional data!\n",
-			ocp->def->index);
-
-	if (!(dev = kzalloc(sizeof(*dev), GFP_KERNEL))) {
-		printk(KERN_ERR "ibm-iic%d: failed to allocate device data\n",
-			ocp->def->index);
-		return -ENOMEM;
-	}
-
-	dev->idx = ocp->def->index;
-	ocp_set_drvdata(ocp, dev);
-
-	if (!request_mem_region(ocp->def->paddr, sizeof(struct iic_regs),
-				"ibm_iic")) {
-		ret = -EBUSY;
-		goto fail1;
-	}
-
-	if (!(dev->vaddr = ioremap(ocp->def->paddr, sizeof(struct iic_regs)))){
-		printk(KERN_ERR "ibm-iic%d: failed to ioremap device registers\n",
-			dev->idx);
-		ret = -ENXIO;
-		goto fail2;
-	}
-
-	init_waitqueue_head(&dev->wq);
-
-	dev->irq = iic_force_poll ? -1 : ocp->def->irq;
-	if (dev->irq >= 0){
-		/* Disable interrupts until we finish initialization,
-		   assumes level-sensitive IRQ setup...
-		 */
-		iic_interrupt_mode(dev, 0);
-		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
-			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",
-				dev->idx, dev->irq);
-			/* Fallback to the polling mode */
-			dev->irq = -1;
-		}
-	}
-
-	if (dev->irq < 0)
-		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",
-			dev->idx);
-
-	/* Board specific settings */
-	dev->fast_mode = iic_force_fast ? 1 : (iic_data ? iic_data->fast_mode : 0);
-
-	/* clckdiv is the same for *all* IIC interfaces,
-	 * but I'd rather make a copy than introduce another global. --ebs
-	 */
-	dev->clckdiv = iic_clckdiv(ocp_sys_info.opb_bus_freq);
-	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
-
-	/* Initialize IIC interface */
-	iic_dev_init(dev);
-
-	/* Register it with i2c layer */
-	adap = &dev->adap;
-	adap->dev.parent = &ocp->dev;
-	strcpy(adap->name, "IBM IIC");
-	i2c_set_adapdata(adap, dev);
-	adap->id = I2C_HW_OCP;
-	adap->class = I2C_CLASS_HWMON;
-	adap->algo = &iic_algo;
-	adap->client_register = NULL;
-	adap->client_unregister = NULL;
-	adap->timeout = 1;
-
-	/*
-	 * If "dev->idx" is negative we consider it as zero.
-	 * The reason to do so is to avoid sysfs names that only make
-	 * sense when there are multiple adapters.
-	 */
-	adap->nr = dev->idx >= 0 ? dev->idx : 0;
-
-	if ((ret = i2c_add_numbered_adapter(adap)) < 0) {
-		printk(KERN_ERR "ibm-iic%d: failed to register i2c adapter\n",
-			dev->idx);
-		goto fail;
-	}
-
-	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
-		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
-
-	return 0;
-
-fail:
-	if (dev->irq >= 0){
-		iic_interrupt_mode(dev, 0);
-		free_irq(dev->irq, dev);
-	}
-
-	iounmap(dev->vaddr);
-fail2:
-	release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
-fail1:
-	ocp_set_drvdata(ocp, NULL);
-	kfree(dev);
-	return ret;
-}
-
-/*
- * Cleanup initialized IIC interface
- */
-static void __devexit iic_remove(struct ocp_device *ocp)
-{
-	struct ibm_iic_private* dev = (struct ibm_iic_private*)ocp_get_drvdata(ocp);
-	BUG_ON(dev == NULL);
-	if (i2c_del_adapter(&dev->adap)){
-		printk(KERN_ERR "ibm-iic%d: failed to delete i2c adapter :(\n",
-			dev->idx);
-		/* That's *very* bad, just shutdown IRQ ... */
-		if (dev->irq >= 0){
-		    iic_interrupt_mode(dev, 0);
-		    free_irq(dev->irq, dev);
-		    dev->irq = -1;
-		}
-	} else {
-		if (dev->irq >= 0){
-		    iic_interrupt_mode(dev, 0);
-		    free_irq(dev->irq, dev);
-		}
-		iounmap(dev->vaddr);
-		release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
-		kfree(dev);
-	}
-}
-
-static struct ocp_device_id ibm_iic_ids[] __devinitdata =
-{
-	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_IIC },
-	{ .vendor = OCP_VENDOR_INVALID }
-};
-
-MODULE_DEVICE_TABLE(ocp, ibm_iic_ids);
-
-static struct ocp_driver ibm_iic_driver =
-{
-	.name 		= "iic",
-	.id_table	= ibm_iic_ids,
-	.probe		= iic_probe,
-	.remove		= __devexit_p(iic_remove),
-#if defined(CONFIG_PM)
-	.suspend	= NULL,
-	.resume		= NULL,
-#endif
-};
-
-static int __init iic_init(void)
-{
-	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
-	return ocp_register_driver(&ibm_iic_driver);
-}
-
-static void __exit iic_exit(void)
-{
-	ocp_unregister_driver(&ibm_iic_driver);
-}
-
-#else  /* !CONFIG_IBM_OCP */
-
 static int __devinit iic_request_irq(struct of_device *ofdev,
 				     struct ibm_iic_private *dev)
 {
@@ -1011,7 +831,6 @@ static void __exit iic_exit(void)
 {
 	of_unregister_platform_driver(&ibm_iic_driver);
 }
-#endif /* CONFIG_IBM_OCP */
 
 module_init(iic_init);
 module_exit(iic_exit);
-- 
1.5.4.3

-- 
