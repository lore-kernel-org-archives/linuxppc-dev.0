Return-Path: <florian@openwrt.org>
From: Florian Fainelli <florian@openwrt.org>
To: davem@davemloft.net
Subject: [PATCH 4/5] net: mvmdio: allow Device Tree and platform device to
 coexist
Date: Tue, 29 Jan 2013 16:24:07 +0100
Message-Id: <1359473048-26551-5-git-send-email-florian@openwrt.org>
In-Reply-To: <1359473048-26551-1-git-send-email-florian@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Rob Landley <rob@landley.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the Marvell MDIO driver to be registered by using
both Device Tree and platform device methods. The driver voluntarily
does not use devm_ioremap() to share the same error path for Device Tree
and non-Device Tree cases.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/net/ethernet/marvell/mvmdio.c |   46 +++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index cada794..10c593c 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -190,6 +190,7 @@ static irqreturn_t orion_mdio_err_irq(int irq, void *dev_id)
 static int orion_mdio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct resource *r = NULL;
 	struct mii_bus *bus;
 	struct orion_mdio_dev *dev;
 	int i, ret;
@@ -219,18 +220,31 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		bus->irq[i] = PHY_POLL;
 
 	dev = bus->priv;
-	dev->regs = of_iomap(pdev->dev.of_node, 0);
-	if (!dev->regs) {
-		dev_err(&pdev->dev, "No SMI register address given in DT\n");
-		kfree(bus->irq);
-		mdiobus_free(bus);
-		return -ENODEV;
-	}
-
 	dev->err_interrupt = NO_IRQ;
 	init_waitqueue_head(&dev->smi_busy_wait);
 
-	dev->err_interrupt = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (pdev->dev.of_node) {
+		dev->regs = of_iomap(pdev->dev.of_node, 0);
+		if (!dev->regs) {
+			dev_err(&pdev->dev, "No SMI register address given in DT\n");
+			ret = -ENODEV;
+			goto out_free;
+		}
+
+		dev->err_interrupt = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	} else {
+		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+		dev->regs = ioremap(r->start, resource_size(r));
+		if (!dev->regs) {
+			dev_err(&pdev->dev, "No SMI register address given\n");
+			ret = -ENODEV;
+			goto out_free;
+		}
+
+		dev->err_interrupt = platform_get_irq(pdev, 0);
+	}
+
 	if (dev->err_interrupt != NO_IRQ) {
 		ret = devm_request_irq(&pdev->dev, dev->err_interrupt,
 					orion_mdio_err_irq,
@@ -242,18 +256,24 @@ static int orion_mdio_probe(struct platform_device *pdev)
 
 	mutex_init(&dev->lock);
 
-	ret = of_mdiobus_register(bus, np);
+	if (np)
+		ret = of_mdiobus_register(bus, np);
+	else
+		ret = mdiobus_register(bus);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
 		iounmap(dev->regs);
-		kfree(bus->irq);
-		mdiobus_free(bus);
-		return ret;
+		goto out_free;
 	}
 
 	platform_set_drvdata(pdev, bus);
 
 	return 0;
+
+out_free:
+	kfree(bus->irq);
+	mdiobus_free(bus);
+	return ret;
 }
 
 static int orion_mdio_remove(struct platform_device *pdev)
-- 
1.7.10.4
