Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E5122C01B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:31 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 21/32] usb: gadget: net2280: let udc-core manage
 gadget->dev
Date: Thu, 24 Jan 2013 17:45:59 +0200
Message-ID: <1359042370-4358-22-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/net2280.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index 708c0b5..630f715 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -2667,7 +2667,6 @@ static void net2280_remove (struct pci_dev *pdev)
 				pci_resource_len (pdev, 0));
 	if (dev->enabled)
 		pci_disable_device (pdev);
-	device_unregister (&dev->gadget.dev);
 	device_remove_file (&pdev->dev, &dev_attr_registers);
 	pci_set_drvdata (pdev, NULL);
 
@@ -2699,11 +2698,11 @@ static int net2280_probe (struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->gadget.max_speed = USB_SPEED_HIGH;
 
 	/* the "gadget" abstracts/virtualizes the controller */
-	dev_set_name(&dev->gadget.dev, "gadget");
 	dev->gadget.dev.parent = &pdev->dev;
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = driver_name;
+	dev->gadget.register_my_device = true;
 
 	/* now all the pci goodies ... */
 	if (pci_enable_device (pdev) < 0) {
@@ -2811,8 +2810,6 @@ static int net2280_probe (struct pci_dev *pdev, const struct pci_device_id *id)
 			use_dma
 				? (use_dma_chaining ? "chaining" : "enabled")
 				: "disabled");
-	retval = device_register (&dev->gadget.dev);
-	if (retval) goto done;
 	retval = device_create_file (&pdev->dev, &dev_attr_registers);
 	if (retval) goto done;
 
-- 
1.8.1.rc1.5.g7e0651a
