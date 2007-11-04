Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out0.tiscali.nl (smtp-out0.tiscali.nl [195.241.79.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55EC8DDEE6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 04:44:23 +1100 (EST)
Message-ID: <472E04EF.9000005@tiscali.nl>
Date: Sun, 04 Nov 2007 18:44:15 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Balance alloc/free and ioremap/iounmap in gpio_mdio_probe
	(powerpc/platforms/pasemi/gpio_mdio.c)
References: <472DF914.7020601@tiscali.nl> <20071104171814.GI9695@localdomain>
In-Reply-To: <20071104171814.GI9695@localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Hi,

I moved res to the wrong function, that's fixed as well as the unlikely's and
the extra new lines.

Thanks for your quick response. Here is an updated version:
--
Upon errors gpio_regs was not iounmapped, and later priv nor new_bus->irq was
freed. Testing succes of the allocation of new_bus->irq was missing as well.

This patch creates a new function __gpio_mdio_register_bus to allow the 
iounmapping after an ioremap.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---

diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index dae9f65..af5b241 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -208,68 +208,50 @@ static int gpio_mdio_write(struct mii_bus *bus, int phy_id, int location, u16 va
 }
 
 static int gpio_mdio_reset(struct mii_bus *bus)
 {
 	/*nothing here - dunno how to reset it*/
 	return 0;
 }
 
-
-static int __devinit gpio_mdio_probe(struct of_device *ofdev,
-				     const struct of_device_id *match)
+static int __devinit __gpio_mdio_register_bus(struct of_device *ofdev,
+					const struct of_device_id *match)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->node;
-	struct device_node *gpio_np;
 	struct mii_bus *new_bus;
-	struct resource res;
 	struct gpio_priv *priv;
 	const unsigned int *prop;
-	int err = 0;
 	int i;
 
-	gpio_np = of_find_compatible_node(NULL, "gpio", "1682m-gpio");
-
-	if (!gpio_np)
-		return -ENODEV;
-
-	err = of_address_to_resource(gpio_np, 0, &res);
-	of_node_put(gpio_np);
-
-	if (err)
-		return -EINVAL;
-
-	if (!gpio_regs)
-		gpio_regs = ioremap(res.start, 0x100);
-
-	if (!gpio_regs)
-		return -EPERM;
-
 	priv = kzalloc(sizeof(struct gpio_priv), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
 	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
 
 	if (new_bus == NULL)
-		return -ENOMEM;
+		goto free_priv;
 
 	new_bus->name = "pasemi gpio mdio bus",
 	new_bus->read = &gpio_mdio_read,
 	new_bus->write = &gpio_mdio_write,
 	new_bus->reset = &gpio_mdio_reset,
 
 	prop = of_get_property(np, "reg", NULL);
 	new_bus->id = *prop;
 	new_bus->priv = priv;
 
 	new_bus->phy_mask = 0;
 
 	new_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
+	if (new_bus->irq == NULL)
+		goto free_new_bus;
+
 	for(i = 0; i < PHY_MAX_ADDR; ++i)
 		new_bus->irq[i] = irq_create_mapping(NULL, 10);
 
 
 	prop = of_get_property(np, "mdc-pin", NULL);
 	priv->mdc_pin = *prop;
 
 	prop = of_get_property(np, "mdio-pin", NULL);
@@ -284,17 +266,54 @@ static int __devinit gpio_mdio_probe(struct of_device *ofdev,
 		printk(KERN_ERR "%s: Cannot register as MDIO bus, err %d\n",
 				new_bus->name, err);
 		goto bus_register_fail;
 	}
 
 	return 0;
 
 bus_register_fail:
+	kfree(new_bus->irq);
+free_new_bus:
 	kfree(new_bus);
+free_priv:
+	kfree(priv);
+
+	return -ENOMEM;
+}
+
+
+static int __devinit gpio_mdio_probe(struct of_device *ofdev,
+				     const struct of_device_id *match)
+{
+	struct device_node *gpio_np;
+	struct resource res;
+	int err;
+
+	gpio_np = of_find_compatible_node(NULL, "gpio", "1682m-gpio");
+
+	if (!gpio_np)
+		return -ENODEV;
+
+	err = of_address_to_resource(gpio_np, 0, &res);
+	of_node_put(gpio_np);
+
+	if (err)
+		return -EINVAL;
+
+	if (!gpio_regs) {
+		gpio_regs = ioremap(res.start, 0x100);
+		if (unlikely(!gpio_regs))
+			return -EPERM;
+
+		err = __gpio_mdio_register_bus(ofdev, match);
+		if (err < 0)
+			iounmap(gpio_regs);
+	} else
+		err = __gpio_mdio_register_bus(ofdev, match);
 
 	return err;
 }
 
 
 static int gpio_mdio_remove(struct of_device *dev)
 {
 	struct mii_bus *bus = dev_get_drvdata(&dev->dev);
