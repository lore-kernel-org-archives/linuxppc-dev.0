Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7430ADDFD0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:35:49 +1100 (EST)
Message-ID: <4783C284.1070400@pikatech.com>
Date: Tue, 08 Jan 2008 13:35:48 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] i2c-ibm_iic driver - new patch
References: <477EF225.4070505@pikatech.com><200801051354.11202.arnd@arndb.de><477FCE21.9080808@pikatech.com><200801052018.22954.arnd@arndb.de><20080106001238.GI4326@localhost.localdomain><4782D9E0.4070600@pikatech.com><20080108155240.503ca3ab.sfr@canb.auug.org.au><4783108B.6070308@pikatech.com>
	<20080108173636.73db1623.sfr@canb.auug.org.au>
In-Reply-To: <20080108173636.73db1623.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Let's try again.

Cheers,
    Sean

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
index 9b43ff7..98476fc 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -6,6 +6,9 @@
  * Copyright (c) 2003, 2004 Zultys Technologies.
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
+ * Copyright (c) 2008 PIKA Technologies
+ * Sean MacLennan <smaclennan@pikatech.com>
+ *
  * Based on original work by 
  * 	Ian DaSilva  <idasilva@mvista.com>
  *      Armin Kuster <akuster@mvista.com>
@@ -39,12 +42,17 @@
 #include <asm/io.h>
 #include <linux/i2c.h>
 #include <linux/i2c-id.h>
+
+#ifdef CONFIG_IBM_OCP
 #include <asm/ocp.h>
 #include <asm/ibm4xx.h>
+#else
+#include <linux/of_platform.h>
+#endif
 
 #include "i2c-ibm_iic.h"
 
-#define DRIVER_VERSION "2.1"
+#define DRIVER_VERSION "2.2"
 
 MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
 MODULE_LICENSE("GPL");
@@ -650,13 +658,14 @@ static inline u8 iic_clckdiv(unsigned int opb)
 	opb /= 1000000;
 	
 	if (opb < 20 || opb > 150){
-		printk(KERN_CRIT "ibm-iic: invalid OPB clock frequency %u MHz\n",
+		printk(KERN_WARNING "ibm-iic: invalid OPB clock frequency %u MHz\n",
 			opb);
 		opb = opb < 20 ? 20 : 150;
 	}
 	return (u8)((opb + 9) / 10 - 1);
 }
 
+#ifdef CONFIG_IBM_OCP
 /*
  * Register single IIC interface
  */
@@ -672,7 +681,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 			ocp->def->index);
 
 	if (!(dev = kzalloc(sizeof(*dev), GFP_KERNEL))) {
-		printk(KERN_CRIT "ibm-iic%d: failed to allocate device data\n",
+		printk(KERN_ERR "ibm-iic%d: failed to allocate device data\n",
 			ocp->def->index);
 		return -ENOMEM;
 	}
@@ -687,7 +696,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	}
 
 	if (!(dev->vaddr = ioremap(ocp->def->paddr, sizeof(struct iic_regs)))){
-		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
+		printk(KERN_ERR "ibm-iic%d: failed to ioremap device registers\n",
 			dev->idx);
 		ret = -ENXIO;
 		goto fail2;
@@ -746,7 +755,7 @@ static int __devinit iic_probe(struct ocp_device *ocp){
 	adap->nr = dev->idx >= 0 ? dev->idx : 0;
 
 	if ((ret = i2c_add_numbered_adapter(adap)) < 0) {
-		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
+		printk(KERN_ERR "ibm-iic%d: failed to register i2c adapter\n",
 			dev->idx);
 		goto fail;
 	}
@@ -779,7 +788,7 @@ static void __devexit iic_remove(struct ocp_device *ocp)
 	struct ibm_iic_private* dev = (struct ibm_iic_private*)ocp_get_drvdata(ocp);
 	BUG_ON(dev == NULL);
 	if (i2c_del_adapter(&dev->adap)){
-		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
+		printk(KERN_ERR "ibm-iic%d: failed to delete i2c adapter :(\n",
 			dev->idx);
 		/* That's *very* bad, just shutdown IRQ ... */
 		if (dev->irq >= 0){
@@ -831,3 +840,189 @@ static void __exit iic_exit(void)
 
 module_init(iic_init);
 module_exit(iic_exit);
+#else
+/*
+ * Register single IIC interface
+ */
+static int __devinit iic_probe(struct of_device *ofdev,
+			       const struct of_device_id *match)
+{
+	static int index = 0;
+	struct device_node *np = ofdev->node;
+	struct ibm_iic_private* dev;
+	struct i2c_adapter* adap;
+	const u32 *indexp, *freq;
+	int ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR "ibm-iic: failed to allocate device data\n");
+		return -ENOMEM;
+	}
+
+	/* This assumes we don't mix index and non-index entries. */
+	indexp = of_get_property(np, "index", NULL);
+	dev->idx = indexp ? *indexp : index++;
+
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	dev->vaddr = of_iomap(np, 0);
+	if (dev->vaddr == NULL) {
+		printk(KERN_ERR "ibm-iic%d: failed to ioremap device registers\n",
+			dev->idx);
+		ret = -ENXIO;
+		goto fail1;
+	}
+
+	init_waitqueue_head(&dev->wq);
+
+	if (iic_force_poll)
+		dev->irq = NO_IRQ;
+	else {
+		dev->irq = irq_of_parse_and_map(np, 0);
+		if (dev->irq == NO_IRQ)
+			printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+		else {
+			/* Disable interrupts until we finish initialization,
+			   assumes level-sensitive IRQ setup...
+			*/
+			iic_interrupt_mode(dev, 0);
+			if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
+				printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",
+				       dev->idx, dev->irq);
+				/* Fallback to the polling mode */
+				dev->irq = NO_IRQ;
+			}
+		}
+	}
+
+	if (dev->irq == NO_IRQ)
+		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",
+			   dev->idx);
+
+	/* Board specific settings */
+	if (iic_force_fast || of_get_property(np, "fast-mode", NULL))
+		dev->fast_mode = 1;
+	else
+		dev->fast_mode = 0;
+
+	/* clckdiv is the same for *all* IIC interfaces, but I'd rather
+	 * make a copy than introduce another global. --ebs
+	 */
+	freq = of_get_property(np, "clock-frequency", NULL);
+	if (freq == NULL) {
+		freq = of_get_property(np->parent, "clock-frequency", NULL);
+		if (freq == NULL) {
+			printk(KERN_ERR "ibm-iic%d: Unable to get bus frequency\n",
+			       dev->idx);
+			ret = -EBUSY;
+			goto fail;
+		}
+	}
+
+	dev->clckdiv = iic_clckdiv(*freq);
+	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
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
+	adap->nr = dev->idx;
+
+	ret = i2c_add_numbered_adapter(adap);
+	if (ret  < 0) {
+		printk(KERN_ERR "ibm-iic%d: failed to register i2c adapter\n",
+			dev->idx);
+		goto fail;
+	}
+
+	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
+		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
+
+	return 0;
+
+fail:
+	if (dev->irq != NO_IRQ){
+		iic_interrupt_mode(dev, 0);
+		free_irq(dev->irq, dev);
+	}
+
+	iounmap(dev->vaddr);
+fail1:
+	dev_set_drvdata(&ofdev->dev, NULL);
+	kfree(dev);
+	return ret;
+}
+
+/*
+ * Cleanup initialized IIC interface
+ */
+static int __devexit iic_remove(struct of_device *ofdev)
+{
+	struct ibm_iic_private* dev = dev_get_drvdata(&ofdev->dev);
+
+	BUG_ON(dev == NULL);
+	if (i2c_del_adapter(&dev->adap)){
+		printk(KERN_ERR "ibm-iic%d: failed to delete i2c adapter :(\n",
+			dev->idx);
+		/* That's *very* bad, just shutdown IRQ ... */
+		if (dev->irq != NO_IRQ){
+		    iic_interrupt_mode(dev, 0);
+		    free_irq(dev->irq, dev);
+		    dev->irq = NO_IRQ;
+		}
+	} else {
+		if (dev->irq != NO_IRQ){
+		    iic_interrupt_mode(dev, 0);
+		    free_irq(dev->irq, dev);
+		}
+		iounmap(dev->vaddr);
+		kfree(dev);
+	}
+
+	return 0;
+}
+
+
+static const struct of_device_id ibm_iic_match[] =
+{
+	{ .type = "i2c", .compatible = "ibm,iic-405ex", },
+	{ .type = "i2c", .compatible = "ibm,iic-405gp", },
+	{ .type = "i2c", .compatible = "ibm,iic-440gp", },
+	{ .type = "i2c", .compatible = "ibm,iic-440gpx", },
+	{ .type = "i2c", .compatible = "ibm,iic-440grx", },
+	{}
+};
+
+static struct of_platform_driver ibm_iic_driver =
+{
+	.name   = "ibm-iic",
+	.match_table = ibm_iic_match,
+	.probe  = iic_probe,
+	.remove = iic_remove,
+};
+
+static int __init ibm_iic_init(void)
+{
+	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
+	return of_register_platform_driver(&ibm_iic_driver);
+}
+module_init(ibm_iic_init);
+
+static void __exit ibm_iic_exit(void)
+{
+	of_unregister_platform_driver(&ibm_iic_driver);
+}
+module_exit(ibm_iic_exit);
+#endif
