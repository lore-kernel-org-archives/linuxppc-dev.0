Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 648F2DDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 13:57:43 +1100 (EST)
Message-ID: <477EF225.4070505@pikatech.com>
Date: Fri, 04 Jan 2008 21:57:41 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] i2c-ibm_iic driver
Content-Type: multipart/mixed; boundary="------------070901080405080100050801"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070901080405080100050801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I converted the i2c-ibm_iic driver from an ocp driver to an of_platform 
driver. Since this driver is in the kernel.org kernel, should I rename 
it and keep the old one around? I notice this was done with the emac 
network driver.

This driver is required for the taco platform.

Cheers,
    Sean


--------------070901080405080100050801
Content-Type: text/plain;
 name="i2c-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-patch"

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index c466c6c..e9e1493 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -241,7 +241,6 @@ config I2C_PIIX4
 
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
-	depends on IBM_OCP
 	help
 	  Say Y here if you want to use IIC peripheral found on 
 	  embedded IBM PPC 4xx based systems. 
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 9b43ff7..838006f 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -3,6 +3,10 @@
  *
  * Support for the IIC peripheral on IBM PPC 4xx
  *
+ * Copyright (c) 2008 PIKA Technologies
+ * Sean MacLennan <smaclennan@pikatech.com>
+ *  Converted to an of_platform_driver.
+ *
  * Copyright (c) 2003, 2004 Zultys Technologies.
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
@@ -39,12 +43,11 @@
 #include <asm/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-id.h>
-#include <asm/ocp.h>
-#include <asm/ibm4xx.h>
+#include <linux/of_platform.h>
 
 #include "i2c-ibm_iic.h"
 
-#define DRIVER_VERSION "2.1"
+#define DRIVER_VERSION "2.2"
 
 MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
 MODULE_LICENSE("GPL");
@@ -660,50 +663,58 @@ static inline u8 iic_clckdiv(unsigned int opb)
 /*
  * Register single IIC interface
  */
-static int __devinit iic_probe(struct ocp_device *ocp){
-
+static int __devinit iic_probe(struct of_device *ofdev,
+							   const struct of_device_id *match)
+{
+	static int index = 0;
+	struct device_node *np = ofdev->node;
 	struct ibm_iic_private* dev;
 	struct i2c_adapter* adap;
-	struct ocp_func_iic_data* iic_data = ocp->def->additions;
+	const u32 *addrp, *freq;
+	u64 addr;
 	int ret;
-	
-	if (!iic_data)
-		printk(KERN_WARNING"ibm-iic%d: missing additional data!\n",
-			ocp->def->index);
 
 	if (!(dev = kzalloc(sizeof(*dev), GFP_KERNEL))) {
-		printk(KERN_CRIT "ibm-iic%d: failed to allocate device data\n",
-			ocp->def->index);
+		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
 		return -ENOMEM;
 	}
 
-	dev->idx = ocp->def->index;
-	ocp_set_drvdata(ocp, dev);
-	
-	if (!request_mem_region(ocp->def->paddr, sizeof(struct iic_regs),
-				"ibm_iic")) {
+	dev->idx = index++;
+
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	if((addrp = of_get_address(np, 0, NULL, NULL)) == NULL ||
+	   (addr = of_translate_address(np, addrp)) == OF_BAD_ADDR) {
+		printk(KERN_CRIT "ibm-iic%d: Unable to get iic address\n",
+			   dev->idx);
 		ret = -EBUSY;
 		goto fail1;
 	}
 
-	if (!(dev->vaddr = ioremap(ocp->def->paddr, sizeof(struct iic_regs)))){
+	if (!(dev->vaddr = ioremap(addr, sizeof(struct iic_regs)))){
 		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
 			dev->idx);
 		ret = -ENXIO;
-		goto fail2;
+		goto fail1;
 	}
 	
 	init_waitqueue_head(&dev->wq);
 
-	dev->irq = iic_force_poll ? -1 : ocp->def->irq;
-	if (dev->irq >= 0){
+	if(iic_force_poll)
+		dev->irq = -1;
+	else if((dev->irq = irq_of_parse_and_map(np, 0)) == NO_IRQ) {
+		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+		dev->irq = -1;
+	}
+
+	if (dev->irq >= 0) {
 		/* Disable interrupts until we finish initialization,
 		   assumes level-sensitive IRQ setup...
 		 */
 		iic_interrupt_mode(dev, 0);
-		if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
+		if(request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
 			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n", 
-				dev->idx, dev->irq);
+				   dev->idx, dev->irq);
 			/* Fallback to the polling mode */	
 			dev->irq = -1;
 		}
@@ -711,23 +722,30 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	
 	if (dev->irq < 0)
 		printk(KERN_WARNING "ibm-iic%d: using polling mode\n", 
-			dev->idx);
+			   dev->idx);
 		
 	/* Board specific settings */
-	dev->fast_mode = iic_force_fast ? 1 : (iic_data ? iic_data->fast_mode : 0);
+	dev->fast_mode = iic_force_fast ? 1 : 0;
 	
-	/* clckdiv is the same for *all* IIC interfaces, 
-	 * but I'd rather make a copy than introduce another global. --ebs
+	/* clckdiv is the same for *all* IIC interfaces, but I'd rather
+	 * make a copy than introduce another global. --ebs
 	 */
-	dev->clckdiv = iic_clckdiv(ocp_sys_info.opb_bus_freq);
+	if((freq = of_get_property(np, "clock-frequency", NULL)) == NULL &&
+	   (freq = of_get_property(np->parent, "clock-frequency", NULL)) == NULL) {
+		printk(KERN_CRIT "ibm-iic%d: Unable to get bus frequency\n", dev->idx);
+		ret = -EBUSY;
+		goto fail;
+	}
+
+	dev->clckdiv = iic_clckdiv(*freq);
 	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
-	
+
 	/* Initialize IIC interface */
 	iic_dev_init(dev);
 	
 	/* Register it with i2c layer */
 	adap = &dev->adap;
-	adap->dev.parent = &ocp->dev;
+	adap->dev.parent = &ofdev->dev;
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP;
@@ -737,13 +755,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	adap->client_unregister = NULL;
 	adap->timeout = 1;
 	adap->retries = 1;
-
-	/*
-	 * If "dev->idx" is negative we consider it as zero.
-	 * The reason to do so is to avoid sysfs names that only make
-	 * sense when there are multiple adapters.
-	 */
-	adap->nr = dev->idx >= 0 ? dev->idx : 0;
+	adap->nr = dev->idx;
 
 	if ((ret = i2c_add_numbered_adapter(adap)) < 0) {
 		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
@@ -763,20 +775,19 @@ fail:
 	}	
 
 	iounmap(dev->vaddr);
-fail2:	
-	release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
 fail1:
-	ocp_set_drvdata(ocp, NULL);
-	kfree(dev);	
+	dev_set_drvdata(&ofdev->dev, NULL);
+	kfree(dev);
 	return ret;
 }
 
 /*
  * Cleanup initialized IIC interface
  */
-static void __devexit iic_remove(struct ocp_device *ocp)
+static int __devexit iic_remove(struct of_device *ofdev)
 {
-	struct ibm_iic_private* dev = (struct ibm_iic_private*)ocp_get_drvdata(ocp);
+	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_get_drvdata(&ofdev->dev);
+
 	BUG_ON(dev == NULL);
 	if (i2c_del_adapter(&dev->adap)){
 		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
@@ -793,41 +804,37 @@ static void __devexit iic_remove(struct ocp_device *ocp)
 		    free_irq(dev->irq, dev);
 		}
 		iounmap(dev->vaddr);
-		release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
 		kfree(dev);
 	}
+
+	return 0;
 }
 
-static struct ocp_device_id ibm_iic_ids[] __devinitdata = 
+
+static struct of_device_id ibm_iic_match[] =
 {
-	{ .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_IIC },
-	{ .vendor = OCP_VENDOR_INVALID }
+	{ .type = "i2c", .compatible = "ibm,iic", },
+	{}
 };
 
-MODULE_DEVICE_TABLE(ocp, ibm_iic_ids);
-
-static struct ocp_driver ibm_iic_driver =
+static struct of_platform_driver ibm_iic_driver =
 {
-	.name 		= "iic",
-	.id_table	= ibm_iic_ids,
+	.name  = "ibm-iic",
+	.match_table = ibm_iic_match,
+
 	.probe		= iic_probe,
-	.remove		= __devexit_p(iic_remove),
-#if defined(CONFIG_PM)
-	.suspend	= NULL,
-	.resume		= NULL,
-#endif
+	.remove		= iic_remove,
 };
 
-static int __init iic_init(void)
+static int __init ibm_iic_init(void)
 {
 	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
-	return ocp_register_driver(&ibm_iic_driver);
+	return of_register_platform_driver(&ibm_iic_driver);
 }
+module_init(ibm_iic_init);
 
-static void __exit iic_exit(void)
+static void __exit ibm_iic_exit(void)
 {
-	ocp_unregister_driver(&ibm_iic_driver);
+	of_unregister_platform_driver(&ibm_iic_driver);
 }
-
-module_init(iic_init);
-module_exit(iic_exit);
+module_exit(ibm_iic_exit);

--------------070901080405080100050801--
