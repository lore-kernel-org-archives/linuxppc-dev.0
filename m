Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E84792C01C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:36 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 20/32] usb: gadget: net2272: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:58 +0200
Message-ID: <1359042370-4358-21-git-send-email-balbi@ti.com>
In-Reply-To: <1359042370-4358-1-git-send-email-balbi@ti.com>
References: <1359042370-4358-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kgene.kim@samsung.com, eric.y.miao@gmail.com,
 kuninori.morimoto.gx@renesas.com, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, yoshihiro.shimoda.uh@renesas.com,
 nicolas.ferre@atmel.com, linux-geode@lists.infradead.org,
 haojian.zhuang@gmail.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linux-samsung-soc@vger.kernel.org, Felipe Balbi <balbi@ti.com>,
 ben-linux@fluff.org, dahlmann.thomas@arcor.de, linux@arm.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By simply setting a flag, we can drop some
boilerplate code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/net2272.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index d226058..635248f 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -2209,7 +2209,6 @@ net2272_remove(struct net2272 *dev)
 	free_irq(dev->irq, dev);
 	iounmap(dev->base_addr);
 
-	device_unregister(&dev->gadget.dev);
 	device_remove_file(dev->dev, &dev_attr_registers);
 
 	dev_info(dev->dev, "unbind\n");
@@ -2236,11 +2235,11 @@ static struct net2272 *net2272_probe_init(struct device *dev, unsigned int irq)
 	ret->gadget.max_speed = USB_SPEED_HIGH;
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&ret->gadget.dev, "gadget");
 	ret->gadget.dev.parent = dev;
 	ret->gadget.dev.dma_mask = dev->dma_mask;
 	ret->gadget.dev.release = net2272_gadget_release;
 	ret->gadget.name = driver_name;
+	ret->gadget.register_my_device = true;
 
 	return ret;
 }
@@ -2275,12 +2274,9 @@ net2272_probe_fin(struct net2272 *dev, unsigned int irqflags)
 		dma_mode_string());
 	dev_info(dev->dev, "version: %s\n", driver_vers);
 
-	ret = device_register(&dev->gadget.dev);
-	if (ret)
-		goto err_irq;
 	ret = device_create_file(dev->dev, &dev_attr_registers);
 	if (ret)
-		goto err_dev_reg;
+		goto err_irq;
 
 	ret = usb_add_gadget_udc(dev->dev, &dev->gadget);
 	if (ret)
@@ -2290,8 +2286,6 @@ net2272_probe_fin(struct net2272 *dev, unsigned int irqflags)
 
 err_add_udc:
 	device_remove_file(dev->dev, &dev_attr_registers);
- err_dev_reg:
-	device_unregister(&dev->gadget.dev);
  err_irq:
 	free_irq(dev->irq, dev);
  err:
-- 
1.8.1.rc1.5.g7e0651a
