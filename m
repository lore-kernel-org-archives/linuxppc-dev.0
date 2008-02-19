Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BA8A8DDE45
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 09:23:44 +1100 (EST)
Message-ID: <47BB56EF.7050708@pikatech.com>
Date: Tue, 19 Feb 2008 17:23:43 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
References: <4784FED1.2040206@pikatech.com>
	<47BA3416.5080405@pikatech.com><20080219092321.1fed233d@hyperion.delvare>
	<200802190959.41253.sr@denx.de>
In-Reply-To: <200802190959.41253.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> How about this:
>
> -	depends on IBM_OCP
> +	depends on 4xx
>   
That's what I did, great minds think alike ;) But the email does not 
seem to have come through, so I will repost the patch. If you already 
got an email with the above patch, you can ignore this one ;)

Cheers,
   Sean

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

--- for-2.6.25/drivers/i2c/busses/orig-i2c-ibm_iic.c	2008-02-18 16:36:30.000000000 -0500
+++ for-2.6.25/drivers/i2c/busses/i2c-ibm_iic.c	2008-02-19 16:46:35.000000000 -0500
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
@@ -657,6 +665,7 @@
 	return (u8)((opb + 9) / 10 - 1);
 }
 
+#ifdef CONFIG_IBM_OCP
 /*
  * Register single IIC interface
  */
@@ -828,5 +837,181 @@
 	ocp_unregister_driver(&ibm_iic_driver);
 }
 
+#else  /* !CONFIG_IBM_OCP */
+
+static int __devinit iic_request_irq(struct of_device *ofdev,
+				     struct ibm_iic_private *dev)
+{
+	struct device_node *np = ofdev->node;
+	int irq;
+
+	if (iic_force_poll)
+		return NO_IRQ;
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq == NO_IRQ) {
+		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
+		return NO_IRQ;
+	}
+
+	/* Disable interrupts until we finish initialization, assumes
+	 *  level-sensitive IRQ setup...
+	 */
+	iic_interrupt_mode(dev, 0);
+	if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
+		dev_err(&ofdev->dev, "request_irq %d failed\n", irq);
+		/* Fallback to the polling mode */
+		return NO_IRQ;
+	}
+
+	return irq;
+}
+
+/*
+ * Register single IIC interface
+ */
+static int __devinit iic_probe(struct of_device *ofdev,
+			       const struct of_device_id *match)
+{
+	struct device_node *np = ofdev->node;
+	struct ibm_iic_private *dev;
+	struct i2c_adapter *adap;
+	const u32 *indexp, *freq;
+	int ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		dev_err(&ofdev->dev, "failed to allocate device data\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	indexp = of_get_property(np, "index", NULL);
+	if (!indexp) {
+		dev_err(&ofdev->dev, "no index specified\n");
+		ret = -EINVAL;
+		goto error_cleanup;
+	}
+	dev->idx = *indexp;
+
+	dev->vaddr = of_iomap(np, 0);
+	if (dev->vaddr == NULL) {
+		dev_err(&ofdev->dev, "failed to iomap device\n");
+		ret = -ENXIO;
+		goto error_cleanup;
+	}
+
+	init_waitqueue_head(&dev->wq);
+
+	dev->irq = iic_request_irq(ofdev, dev);
+	if (dev->irq == NO_IRQ)
+		dev_warn(&ofdev->dev, "using polling mode\n");
+
+	/* Board specific settings */
+	if (iic_force_fast || of_get_property(np, "fast-mode", NULL))
+		dev->fast_mode = 1;
+
+	freq = of_get_property(np, "clock-frequency", NULL);
+	if (freq == NULL) {
+		freq = of_get_property(np->parent, "clock-frequency", NULL);
+		if (freq == NULL) {
+			dev_err(&ofdev->dev, "Unable to get bus frequency\n");
+			ret = -EINVAL;
+			goto error_cleanup;
+		}
+	}
+
+	dev->clckdiv = iic_clckdiv(*freq);
+	dev_dbg(&ofdev->dev, "clckdiv = %d\n", dev->clckdiv);
+
+	/* Initialize IIC interface */
+	iic_dev_init(dev);
+
+	/* Register it with i2c layer */
+	adap = &dev->adap;
+	adap->dev.parent = &ofdev->dev;
+	strlcpy(adap->name, "IBM IIC", sizeof(adap->name));
+	i2c_set_adapdata(adap, dev);
+	adap->id = I2C_HW_OCP;
+	adap->class = I2C_CLASS_HWMON;
+	adap->algo = &iic_algo;
+	adap->timeout = 1;
+	adap->nr = dev->idx;
+
+	ret = i2c_add_numbered_adapter(adap);
+	if (ret  < 0) {
+		dev_err(&ofdev->dev, "failed to register i2c adapter\n");
+		goto error_cleanup;
+	}
+
+	dev_info(&ofdev->dev, "using %s mode\n",
+		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
+
+	return 0;
+
+error_cleanup:
+	if (dev->irq != NO_IRQ) {
+		iic_interrupt_mode(dev, 0);
+		free_irq(dev->irq, dev);
+	}
+
+	if (dev->vaddr)
+		iounmap(dev->vaddr);
+
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
+	struct ibm_iic_private *dev = dev_get_drvdata(&ofdev->dev);
+
+	dev_set_drvdata(&ofdev->dev, NULL);
+
+	i2c_del_adapter(&dev->adap);
+
+	if (dev->irq != NO_IRQ) {
+		iic_interrupt_mode(dev, 0);
+		free_irq(dev->irq, dev);
+	}
+
+	iounmap(dev->vaddr);
+	kfree(dev);
+
+	return 0;
+}
+
+static const struct of_device_id ibm_iic_match[] = {
+	{ .compatible = "ibm,iic-405ex", },
+	{ .compatible = "ibm,iic-405gp", },
+	{ .compatible = "ibm,iic-440gp", },
+	{ .compatible = "ibm,iic-440gpx", },
+	{ .compatible = "ibm,iic-440grx", },
+	{}
+};
+
+static struct of_platform_driver ibm_iic_driver = {
+	.name	= "ibm-iic",
+	.match_table = ibm_iic_match,
+	.probe	= iic_probe,
+	.remove	= __devexit_p(iic_remove),
+};
+
+static int __init iic_init(void)
+{
+	return of_register_platform_driver(&ibm_iic_driver);
+}
+
+static void __exit iic_exit(void)
+{
+	of_unregister_platform_driver(&ibm_iic_driver);
+}
+#endif /* CONFIG_IBM_OCP */
+
 module_init(iic_init);
 module_exit(iic_exit);
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index b61f56b..bda87a0 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -244,7 +244,7 @@ config I2C_PIIX4
 
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
-	depends on IBM_OCP
+	depends on 4xx
 	help
 	  Say Y here if you want to use IIC peripheral found on 
 	  embedded IBM PPC 4xx based systems. 
