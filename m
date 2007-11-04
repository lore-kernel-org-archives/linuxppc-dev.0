Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 396B3DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 08:28:12 +1100 (EST)
Date: Sun, 4 Nov 2007 15:37:09 -0600
From: Olof Johansson <olof@lixom.net>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] pasemi: clean up gpio_mdio init
Message-ID: <20071104213709.GA13266@lixom.net>
References: <472DF914.7020601@tiscali.nl> <20071104174701.GB10191@lixom.net>
	<472E0569.7070601@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <472E0569.7070601@tiscali.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pasemi: clean up mdio_gpio driver init

Misc cleanups of mdio_gpio:
* Better error handling/unrolling in case of init/alloc failures
* Go through child nodes and get their interrupts instead of using
  hardcoded values
* Remap the GPIO registers at module load/driver init instead of during probe
* Coding style and other misc cleanups

Signed-off-by: Olof Johansson <olof@lixom.net>

---

On Sun, Nov 04, 2007 at 06:46:17PM +0100, Roel Kluin wrote:
> Olof Johansson wrote:
> > On Sun, Nov 04, 2007 at 05:53:40PM +0100, Roel Kluin wrote:
> >> I think this is how it should be done, but
> >> please review: it was not tested.
> > 
> > Hi,
> > 
> > Thanks for the bug report. The mdio driver needs a set of other cleanups
> > as well. I have a more comprehensive patch that I'll post tomorrow after
> > I have a chance to test them.
> 
> Ok, that's fine with me,

This is what I'll queue up for 2.6.25.


-Olof

diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index dae9f65..2254091 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -218,45 +218,27 @@ static int __devinit gpio_mdio_probe(struct of_device *ofdev,
 				     const struct of_device_id *match)
 {
 	struct device *dev = &ofdev->dev;
-	struct device_node *np = ofdev->node;
-	struct device_node *gpio_np;
+	struct device_node *phy_dn, *np = ofdev->node;
 	struct mii_bus *new_bus;
-	struct resource res;
 	struct gpio_priv *priv;
 	const unsigned int *prop;
-	int err = 0;
+	int err;
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
+	err = -ENOMEM;
 	priv = kzalloc(sizeof(struct gpio_priv), GFP_KERNEL);
-	if (priv == NULL)
-		return -ENOMEM;
+	if (!priv)
+		goto out;
 
 	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
 
-	if (new_bus == NULL)
-		return -ENOMEM;
+	if (!new_bus)
+		goto out_free_priv;
 
-	new_bus->name = "pasemi gpio mdio bus",
-	new_bus->read = &gpio_mdio_read,
-	new_bus->write = &gpio_mdio_write,
-	new_bus->reset = &gpio_mdio_reset,
+	new_bus->name = "pasemi gpio mdio bus";
+	new_bus->read = &gpio_mdio_read;
+	new_bus->write = &gpio_mdio_write;
+	new_bus->reset = &gpio_mdio_reset;
 
 	prop = of_get_property(np, "reg", NULL);
 	new_bus->id = *prop;
@@ -265,9 +247,24 @@ static int __devinit gpio_mdio_probe(struct of_device *ofdev,
 	new_bus->phy_mask = 0;
 
 	new_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
-	for(i = 0; i < PHY_MAX_ADDR; ++i)
-		new_bus->irq[i] = irq_create_mapping(NULL, 10);
 
+	if (!new_bus->irq)
+		goto out_free_bus;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++)
+		new_bus->irq[i] = NO_IRQ;
+
+	for (phy_dn = of_get_next_child(np, NULL);
+	     phy_dn != NULL;
+	     phy_dn = of_get_next_child(np, phy_dn)) {
+		const int *ip, *regp;
+
+		ip = of_get_property(phy_dn, "interrupts", NULL);
+		regp = of_get_property(phy_dn, "reg", NULL);
+		if (!ip || !regp)
+			continue;
+		new_bus->irq[*regp] = irq_create_mapping(NULL, *ip);
+	}
 
 	prop = of_get_property(np, "mdc-pin", NULL);
 	priv->mdc_pin = *prop;
@@ -280,17 +277,21 @@ static int __devinit gpio_mdio_probe(struct of_device *ofdev,
 
 	err = mdiobus_register(new_bus);
 
-	if (0 != err) {
+	if (err != 0) {
 		printk(KERN_ERR "%s: Cannot register as MDIO bus, err %d\n",
 				new_bus->name, err);
-		goto bus_register_fail;
+		goto out_free_irq;
 	}
 
 	return 0;
 
-bus_register_fail:
+out_free_irq:
+	kfree(new_bus->irq);
+out_free_bus:
 	kfree(new_bus);
-
+out_free_priv:
+	kfree(priv);
+out:
 	return err;
 }
 
@@ -330,12 +331,23 @@ static struct of_platform_driver gpio_mdio_driver =
 
 int gpio_mdio_init(void)
 {
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, "gpio", "1682m-gpio");
+	if (!np)
+		return -ENODEV;
+	gpio_regs = of_iomap(np, 0);
+	if (!gpio_regs)
+		return -ENODEV;
+
 	return of_register_platform_driver(&gpio_mdio_driver);
 }
+module_init(gpio_mdio_init);
 
 void gpio_mdio_exit(void)
 {
 	of_unregister_platform_driver(&gpio_mdio_driver);
+	if (gpio_regs)
+		iounmap(gpio_regs);
 }
-device_initcall(gpio_mdio_init);
-
+module_exit(gpio_mdio_exit);
