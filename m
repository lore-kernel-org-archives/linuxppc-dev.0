Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51ED2679E7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 11:46:03 +1000 (EST)
Subject: [PATCH] powerpc: Fix i2c-powermac platform device usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 11:45:45 +1000
Message-Id: <1160444745.32237.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

i2c-powermac was written & merged right after Russell King's changes
adding platform_driver... which I missed. Thus it still used struct
device, causing crashes when hitting sleep/wakeup callbacks (it happened
to work by luck so far, until early/late callbacks got added). This
causes crashes on sleep/wakeup on PowerBooks with 2.6.19. The patch
fixes it by using a proper platform_driver.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/i2c/busses/i2c-powermac.c
===================================================================
--- linux-work.orig/drivers/i2c/busses/i2c-powermac.c	2006-10-06 13:48:03.000000000 +1000
+++ linux-work/drivers/i2c/busses/i2c-powermac.c	2006-10-10 11:35:46.000000000 +1000
@@ -182,9 +182,9 @@ static const struct i2c_algorithm i2c_po
 };
 
 
-static int i2c_powermac_remove(struct device *dev)
+static int i2c_powermac_remove(struct platform_device *dev)
 {
-	struct i2c_adapter	*adapter = dev_get_drvdata(dev);
+	struct i2c_adapter	*adapter = platform_get_drvdata(dev);
 	struct pmac_i2c_bus	*bus = i2c_get_adapdata(adapter);
 	int			rc;
 
@@ -195,16 +195,16 @@ static int i2c_powermac_remove(struct de
 	if (rc)
 		printk("i2c-powermac.c: Failed to remove bus %s !\n",
 		       adapter->name);
-	dev_set_drvdata(dev, NULL);
+	platform_set_drvdata(dev, NULL);
 	kfree(adapter);
 
 	return 0;
 }
 
 
-static int i2c_powermac_probe(struct device *dev)
+static int __devexit i2c_powermac_probe(struct platform_device *dev)
 {
-	struct pmac_i2c_bus *bus = dev->platform_data;
+	struct pmac_i2c_bus *bus = dev->dev.platform_data;
 	struct device_node *parent = NULL;
 	struct i2c_adapter *adapter;
 	char name[32];
@@ -246,11 +246,11 @@ static int i2c_powermac_probe(struct dev
 		printk(KERN_ERR "i2c-powermac: can't allocate inteface !\n");
 		return -ENOMEM;
 	}
-	dev_set_drvdata(dev, adapter);
+	platform_set_drvdata(dev, adapter);
 	strcpy(adapter->name, name);
 	adapter->algo = &i2c_powermac_algorithm;
 	i2c_set_adapdata(adapter, bus);
-	adapter->dev.parent = dev;
+	adapter->dev.parent = &dev->dev;
 	pmac_i2c_attach_adapter(bus, adapter);
 	rc = i2c_add_adapter(adapter);
 	if (rc) {
@@ -265,23 +265,25 @@ static int i2c_powermac_probe(struct dev
 }
 
 
-static struct device_driver i2c_powermac_driver = {
-	.name = "i2c-powermac",
-	.bus = &platform_bus_type,
+static struct platform_driver i2c_powermac_driver = {
 	.probe = i2c_powermac_probe,
-	.remove = i2c_powermac_remove,
+	.remove = __devexit_p(i2c_powermac_remove),
+	.driver = {
+		.name = "i2c-powermac",
+		.bus = &platform_bus_type,
+	},
 };
 
 static int __init i2c_powermac_init(void)
 {
-	driver_register(&i2c_powermac_driver);
+	platform_driver_register(&i2c_powermac_driver);
 	return 0;
 }
 
 
 static void __exit i2c_powermac_cleanup(void)
 {
-	driver_unregister(&i2c_powermac_driver);
+	platform_driver_unregister(&i2c_powermac_driver);
 }
 
 module_init(i2c_powermac_init);
