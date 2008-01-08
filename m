Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id EC547DDECD
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 13:03:13 +1100 (EST)
Message-ID: <4782D9E0.4070600@pikatech.com>
Date: Mon, 07 Jan 2008 21:03:12 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
Subject: [PATCH] i2c-ibm_iic driver - new patch
References: <477EF225.4070505@pikatech.com> <200801051354.11202.arnd@arndb.de>
	<477FCE21.9080808@pikatech.com> <200801052018.22954.arnd@arndb.de>
	<20080106001238.GI4326@localhost.localdomain>
In-Reply-To: <20080106001238.GI4326@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------000509070701090304020805"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000509070701090304020805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Second attempt. I think I have covered all the comments. It now should 
work with both ppc and powerpc architectures.

You can now specify fast-mode in the .dts file.

You can now specify an index for each entry.  If you don't I try to 
chose reasonable defaults. i.e. I keep a static int that is incremented. 
If you mix index entries with non-index entries, you are on your own.

Below is the example for the taco, I have shown fast-mode set in IIC1 as 
an example:

            IIC0: i2c@ef600700 {
                device_type = "i2c";
                compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
                reg = <ef600700 14>;
                interrupt-parent = <&UIC0>;
                interrupts = <2 4>;
                index = <0>;
            };

            IIC1: i2c@ef600800 {
                device_type = "i2c";
                compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
                reg = <ef600800 14>;
                interrupt-parent = <&UIC0>;
                interrupts = <7 4>;
                index = <1>;
                fast-mode;
            };

Cheers,
   Sean


--------------000509070701090304020805
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
index 9b43ff7..0b10bb1 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -6,7 +6,10 @@
  * Copyright (c) 2003, 2004 Zultys Technologies.
  * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
  *
- * Based on original work by 
+ * Copyright (c) 2008 PIKA Technologies
+ * Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * Based on original work by
  * 	Ian DaSilva  <idasilva@mvista.com>
  *      Armin Kuster <akuster@mvista.com>
  * 	Matt Porter  <mporter@mvista.com>
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
@@ -657,6 +665,7 @@ static inline u8 iic_clckdiv(unsigned int opb)
 	return (u8)((opb + 9) / 10 - 1);
 }
 
+#ifdef CONFIG_IBM_OCP
 /*
  * Register single IIC interface
  */
@@ -831,3 +840,192 @@ static void __exit iic_exit(void)
 
 module_init(iic_init);
 module_exit(iic_exit);
+#else
+/*
+ * Register single IIC interface
+ */
+static int __devinit iic_probe(struct of_device *ofdev,
+							   const struct of_device_id *match)
+{
+	static int index = 0;
+	struct device_node *np = ofdev->node;
+	struct ibm_iic_private* dev;
+	struct i2c_adapter* adap;
+	const u32 *addrp, *freq;
+	u64 addr;
+	int ret;
+
+	if (!(dev = kzalloc(sizeof(*dev), GFP_KERNEL))) {
+		printk(KERN_CRIT "ibm-iic: failed to allocate device data\n");
+		return -ENOMEM;
+	}
+
+	/* This assumes we don't mix index and non-index entries. */
+	if((addrp = of_get_property(np, "index", NULL)))
+		dev->idx = *addrp;
+	else
+		dev->idx = index++;
+
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	if((addrp = of_get_address(np, 0, NULL, NULL)) == NULL ||
+	   (addr = of_translate_address(np, addrp)) == OF_BAD_ADDR) {
+		printk(KERN_CRIT "ibm-iic%d: Unable to get iic address\n",
+			   dev->idx);
+		ret = -EBUSY;
+		goto fail1;
+	}
+
+	if (!(dev->vaddr = ioremap(addr, sizeof(struct iic_regs)))){
+		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
+			dev->idx);
+		ret = -ENXIO;
+		goto fail1;
+	}
+
+	init_waitqueue_head(&dev->wq);
+
+	if(iic_force_poll)
+		dev->irq = NO_IRQ;
+	else if((dev->irq = irq_of_parse_and_map(np, 0)) == NO_IRQ)
+		printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
+
+	if (dev->irq != NO_IRQ) {
+		/* Disable interrupts until we finish initialization,
+		   assumes level-sensitive IRQ setup...
+		 */
+		iic_interrupt_mode(dev, 0);
+		if(request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
+			printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",
+				   dev->idx, dev->irq);
+			/* Fallback to the polling mode */
+			dev->irq = NO_IRQ;
+		}
+	}
+
+	if (dev->irq == NO_IRQ)
+		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",
+			   dev->idx);
+
+	/* Board specific settings */
+	if(iic_force_fast || of_get_property(np, "fast-mode", NULL))
+		dev->fast_mode = 1;
+	else
+		dev->fast_mode = 0;
+
+	/* clckdiv is the same for *all* IIC interfaces, but I'd rather
+	 * make a copy than introduce another global. --ebs
+	 */
+	if((freq = of_get_property(np, "clock-frequency", NULL)) == NULL &&
+	   (freq = of_get_property(np->parent, "clock-frequency", NULL)) == NULL) {
+		printk(KERN_CRIT "ibm-iic%d: Unable to get bus frequency\n", dev->idx);
+		ret = -EBUSY;
+		goto fail;
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
+	if ((ret = i2c_add_numbered_adapter(adap)) < 0) {
+		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
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
+	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_get_drvdata(&ofdev->dev);
+
+	BUG_ON(dev == NULL);
+	if (i2c_del_adapter(&dev->adap)){
+		printk(KERN_CRIT "ibm-iic%d: failed to delete i2c adapter :(\n",
+			dev->idx);
+		/* That's *very* bad, just shutdown IRQ ... */
+		if (dev->irq >= 0){
+		    iic_interrupt_mode(dev, 0);
+		    free_irq(dev->irq, dev);
+		    dev->irq = -1;
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
+static struct of_device_id ibm_iic_match[] =
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
+

--------------000509070701090304020805--
