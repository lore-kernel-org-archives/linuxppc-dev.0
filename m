Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 101872C028F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 02:47:56 +1100 (EST)
From: Felipe Balbi <balbi@ti.com>
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: [RFC/PATCH 32/32] usb: gadget: drop now unnecessary flag
Date: Thu, 24 Jan 2013 17:46:10 +0200
Message-ID: <1359042370-4358-33-git-send-email-balbi@ti.com>
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

We don't need the ->register_my_device flag
anymore because all UDC drivers have been
properly converted.

Let's remove every history of it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/chipidea/udc.c             | 1 -
 drivers/usb/dwc3/gadget.c              | 1 -
 drivers/usb/gadget/amd5536udc.c        | 1 -
 drivers/usb/gadget/at91_udc.c          | 1 -
 drivers/usb/gadget/atmel_usba_udc.c    | 1 -
 drivers/usb/gadget/bcm63xx_udc.c       | 1 -
 drivers/usb/gadget/dummy_hcd.c         | 1 -
 drivers/usb/gadget/fsl_qe_udc.c        | 1 -
 drivers/usb/gadget/fsl_udc_core.c      | 1 -
 drivers/usb/gadget/fusb300_udc.c       | 1 -
 drivers/usb/gadget/goku_udc.c          | 1 -
 drivers/usb/gadget/imx_udc.c           | 1 -
 drivers/usb/gadget/lpc32xx_udc.c       | 1 -
 drivers/usb/gadget/m66592-udc.c        | 1 -
 drivers/usb/gadget/mv_u3d_core.c       | 1 -
 drivers/usb/gadget/mv_udc_core.c       | 1 -
 drivers/usb/gadget/net2272.c           | 1 -
 drivers/usb/gadget/net2280.c           | 1 -
 drivers/usb/gadget/omap_udc.c          | 1 -
 drivers/usb/gadget/pch_udc.c           | 1 -
 drivers/usb/gadget/pxa25x_udc.c        | 1 -
 drivers/usb/gadget/pxa27x_udc.c        | 1 -
 drivers/usb/gadget/r8a66597-udc.c      | 1 -
 drivers/usb/gadget/s3c-hsotg.c         | 1 -
 drivers/usb/gadget/s3c-hsudc.c         | 1 -
 drivers/usb/gadget/s3c2410_udc.c       | 1 -
 drivers/usb/gadget/udc-core.c          | 3 ---
 drivers/usb/musb/musb_gadget.c         | 1 -
 drivers/usb/renesas_usbhs/mod_gadget.c | 1 -
 include/linux/usb/gadget.h             | 4 ----
 30 files changed, 35 deletions(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index e95e8bb..1b65ac8 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1721,7 +1721,6 @@ static int udc_start(struct ci13xxx *ci)
 	ci->gadget.dev.coherent_dma_mask = dev->coherent_dma_mask;
 	ci->gadget.dev.parent   = dev;
 	ci->gadget.dev.release  = udc_release;
-	ci->gadget.register_my_device = true;
 
 	/* alloc resources */
 	ci->qh_pool = dma_pool_create("ci13xxx_qh", dev,
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7002cf6..067ba6ad 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2423,7 +2423,6 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.dev.dma_parms	= dwc->dev->dma_parms;
 	dwc->gadget.dev.dma_mask	= dwc->dev->dma_mask;
 	dwc->gadget.dev.release		= dwc3_gadget_release;
-	dwc->gadget.register_my_device	= true;
 	dwc->gadget.name		= "dwc3-gadget";
 
 	/*
diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
index 1827d4c..35ab5d3 100644
--- a/drivers/usb/gadget/amd5536udc.c
+++ b/drivers/usb/gadget/amd5536udc.c
@@ -3275,7 +3275,6 @@ static int udc_probe(struct udc *dev)
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = name;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
-	dev->gadget.register_my_device = true;
 
 	/* init registers, interrupts, ... */
 	startup_registers(dev);
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 177b56d..dc3682c 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1726,7 +1726,6 @@ static int at91udc_probe(struct platform_device *pdev)
 
 	/* init software state */
 	udc = &controller;
-	udc->gadget.register_my_device = true;
 	udc->gadget.dev.parent = dev;
 	if (pdev->dev.of_node)
 		at91udc_of_init(udc, pdev->dev.of_node);
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f0f9423..b197b75 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1902,7 +1902,6 @@ static int __init usba_udc_probe(struct platform_device *pdev)
 
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
-	udc->gadget.register_my_device = true;
 
 	platform_set_drvdata(pdev, udc);
 
diff --git a/drivers/usb/gadget/bcm63xx_udc.c b/drivers/usb/gadget/bcm63xx_udc.c
index 10b0475..96a585ee 100644
--- a/drivers/usb/gadget/bcm63xx_udc.c
+++ b/drivers/usb/gadget/bcm63xx_udc.c
@@ -2373,7 +2373,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 	udc->gadget.dev.parent = dev;
 	udc->gadget.dev.release = bcm63xx_udc_gadget_release;
 	udc->gadget.dev.dma_mask = dev->dma_mask;
-	udc->gadget.register_my_device = true;
 
 	if (!pd->use_fullspeed && !use_fullspeed)
 		udc->gadget.max_speed = USB_SPEED_HIGH;
diff --git a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
index 8155d4a..7fe600f 100644
--- a/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -982,7 +982,6 @@ static int dummy_udc_probe(struct platform_device *pdev)
 	dum->gadget.name = gadget_name;
 	dum->gadget.ops = &dummy_ops;
 	dum->gadget.max_speed = USB_SPEED_SUPER;
-	dum->gadget.register_my_device = true;
 
 	dum->gadget.dev.parent = &pdev->dev;
 	dum->gadget.dev.release = dummy_gadget_release;
diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 08c8432..010e216 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2525,7 +2525,6 @@ static int qe_udc_probe(struct platform_device *ofdev)
 	udc->gadget.name = driver_name;
 	udc->gadget.dev.release = qe_udc_release;
 	udc->gadget.dev.parent = &ofdev->dev;
-	udc->gadget.register_my_device = true;
 
 	/* initialize qe_ep struct */
 	for (i = 0; i < USB_MAX_ENDPOINTS ; i++) {
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index b78b734..449bf13 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2526,7 +2526,6 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.dev.release = fsl_udc_release;
 	udc_controller->gadget.dev.parent = &pdev->dev;
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
-	udc_controller->gadget.register_my_device = true;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
 		udc_controller->gadget.is_otg = 1;
diff --git a/drivers/usb/gadget/fusb300_udc.c b/drivers/usb/gadget/fusb300_udc.c
index 798a25b..093e6c6 100644
--- a/drivers/usb/gadget/fusb300_udc.c
+++ b/drivers/usb/gadget/fusb300_udc.c
@@ -1427,7 +1427,6 @@ static int __init fusb300_probe(struct platform_device *pdev)
 	fusb300->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	fusb300->gadget.dev.release = pdev->dev.release;
 	fusb300->gadget.name = udc_name;
-	fusb300->gadget.register_my_device = true;
 	fusb300->reg = reg;
 
 	ret = request_irq(ires->start, fusb300_irq, IRQF_SHARED,
diff --git a/drivers/usb/gadget/goku_udc.c b/drivers/usb/gadget/goku_udc.c
index b4ea2cf..8a6c666 100644
--- a/drivers/usb/gadget/goku_udc.c
+++ b/drivers/usb/gadget/goku_udc.c
@@ -1758,7 +1758,6 @@ static int goku_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = driver_name;
-	dev->gadget.register_my_device = true;
 
 	/* now all the pci goodies ... */
 	retval = pci_enable_device(pdev);
diff --git a/drivers/usb/gadget/imx_udc.c b/drivers/usb/gadget/imx_udc.c
index c8b5da3..4cc8a92 100644
--- a/drivers/usb/gadget/imx_udc.c
+++ b/drivers/usb/gadget/imx_udc.c
@@ -1462,7 +1462,6 @@ static int __init imx_udc_probe(struct platform_device *pdev)
 	imx_usb->clk = clk;
 	imx_usb->dev = &pdev->dev;
 
-	imx_usb->gadget.register_my_device = true;
 	imx_usb->gadget.dev.parent = &pdev->dev;
 	imx_usb->gadget.dev.dma_mask = pdev->dev.dma_mask;
 
diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
index 077e021..0ad78cd 100644
--- a/drivers/usb/gadget/lpc32xx_udc.c
+++ b/drivers/usb/gadget/lpc32xx_udc.c
@@ -3090,7 +3090,6 @@ static int __init lpc32xx_udc_probe(struct platform_device *pdev)
 
 	/* init software state */
 	udc->gadget.dev.parent = dev;
-	udc->gadget.register_my_device = true;
 	udc->pdev = pdev;
 	udc->dev = &pdev->dev;
 	udc->enabled = 0;
diff --git a/drivers/usb/gadget/m66592-udc.c b/drivers/usb/gadget/m66592-udc.c
index c5d1b39..5ba712f 100644
--- a/drivers/usb/gadget/m66592-udc.c
+++ b/drivers/usb/gadget/m66592-udc.c
@@ -1612,7 +1612,6 @@ static int __init m66592_probe(struct platform_device *pdev)
 	m66592->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	m66592->gadget.dev.release = pdev->dev.release;
 	m66592->gadget.name = udc_name;
-	m66592->gadget.register_my_device = true;
 
 	init_timer(&m66592->timer);
 	m66592->timer.function = m66592_timer;
diff --git a/drivers/usb/gadget/mv_u3d_core.c b/drivers/usb/gadget/mv_u3d_core.c
index 734ade1..e5735fc 100644
--- a/drivers/usb/gadget/mv_u3d_core.c
+++ b/drivers/usb/gadget/mv_u3d_core.c
@@ -1959,7 +1959,6 @@ static int mv_u3d_probe(struct platform_device *dev)
 	u3d->gadget.dev.dma_mask = dev->dev.dma_mask;
 	u3d->gadget.dev.release = mv_u3d_gadget_release;
 	u3d->gadget.name = driver_name;		/* gadget name */
-	u3d->gadget.register_my_device = true;
 
 	mv_u3d_eps_init(u3d);
 
diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
index 60741af..73b90f9 100644
--- a/drivers/usb/gadget/mv_udc_core.c
+++ b/drivers/usb/gadget/mv_udc_core.c
@@ -2313,7 +2313,6 @@ static int mv_udc_probe(struct platform_device *pdev)
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	udc->gadget.dev.release = gadget_release;
 	udc->gadget.name = driver_name;		/* gadget name */
-	udc->gadget.register_my_device = true;
 
 	eps_init(udc);
 
diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index 635248f..78c8bb5 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -2239,7 +2239,6 @@ static struct net2272 *net2272_probe_init(struct device *dev, unsigned int irq)
 	ret->gadget.dev.dma_mask = dev->dma_mask;
 	ret->gadget.dev.release = net2272_gadget_release;
 	ret->gadget.name = driver_name;
-	ret->gadget.register_my_device = true;
 
 	return ret;
 }
diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index 630f715..5da1ffc 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -2702,7 +2702,6 @@ static int net2280_probe (struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = driver_name;
-	dev->gadget.register_my_device = true;
 
 	/* now all the pci goodies ... */
 	if (pci_enable_device (pdev) < 0) {
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 234e82b..3faa50e 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2633,7 +2633,6 @@ omap_udc_setup(struct platform_device *odev, struct usb_phy *xceiv)
 
 	udc->gadget.dev.release = omap_udc_release;
 	udc->gadget.dev.parent = &odev->dev;
-	udc->gadget.register_my_device = true;
 	if (use_dma)
 		udc->gadget.dev.dma_mask = odev->dev.dma_mask;
 
diff --git a/drivers/usb/gadget/pch_udc.c b/drivers/usb/gadget/pch_udc.c
index 7032145..e8c9afd 100644
--- a/drivers/usb/gadget/pch_udc.c
+++ b/drivers/usb/gadget/pch_udc.c
@@ -3198,7 +3198,6 @@ static int pch_udc_probe(struct pci_dev *pdev,
 	dev->gadget.dev.release = gadget_release;
 	dev->gadget.name = KBUILD_MODNAME;
 	dev->gadget.max_speed = USB_SPEED_HIGH;
-	dev->gadget.register_my_device = true;
 
 	/* Put the device in disconnected state till a driver is bound */
 	pch_udc_set_disconnect(dev);
diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 9deffd3..b19e2bb 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -2134,7 +2134,6 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 
 	dev->gadget.dev.parent = &pdev->dev;
 	dev->gadget.dev.dma_mask = pdev->dev.dma_mask;
-	dev->gadget.register_my_device = true;
 
 	the_controller = dev;
 	platform_set_drvdata(pdev, dev);
diff --git a/drivers/usb/gadget/pxa27x_udc.c b/drivers/usb/gadget/pxa27x_udc.c
index 23a3eed..bc67ba7 100644
--- a/drivers/usb/gadget/pxa27x_udc.c
+++ b/drivers/usb/gadget/pxa27x_udc.c
@@ -2457,7 +2457,6 @@ static int __init pxa_udc_probe(struct platform_device *pdev)
 
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = NULL;
-	udc->gadget.register_my_device = true;
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 40ef4bd..bdadbbe 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1919,7 +1919,6 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	r8a66597->gadget.dev.dma_mask = pdev->dev.dma_mask;
 	r8a66597->gadget.dev.release = pdev->dev.release;
 	r8a66597->gadget.name = udc_name;
-	r8a66597->gadget.register_my_device = true;
 
 	init_timer(&r8a66597->timer);
 	r8a66597->timer.function = r8a66597_timer;
diff --git a/drivers/usb/gadget/s3c-hsotg.c b/drivers/usb/gadget/s3c-hsotg.c
index bd8292d..3adc5bf 100644
--- a/drivers/usb/gadget/s3c-hsotg.c
+++ b/drivers/usb/gadget/s3c-hsotg.c
@@ -3558,7 +3558,6 @@ static int s3c_hsotg_probe(struct platform_device *pdev)
 	hsotg->gadget.dev.parent = dev;
 	hsotg->gadget.dev.dma_mask = dev->dma_mask;
 	hsotg->gadget.dev.release = s3c_hsotg_release;
-	hsotg->gadget.register_my_device = true;
 
 	/* reset the system */
 
diff --git a/drivers/usb/gadget/s3c-hsudc.c b/drivers/usb/gadget/s3c-hsudc.c
index dee6810..d1c3b1b 100644
--- a/drivers/usb/gadget/s3c-hsudc.c
+++ b/drivers/usb/gadget/s3c-hsudc.c
@@ -1313,7 +1313,6 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 	hsudc->gadget.is_otg = 0;
 	hsudc->gadget.is_a_peripheral = 0;
 	hsudc->gadget.speed = USB_SPEED_UNKNOWN;
-	hsudc->gadget.register_my_device = true;
 
 	s3c_hsudc_setup_ep(hsudc);
 
diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index 302e137..dbe6125 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1832,7 +1832,6 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 
 	udc->gadget.dev.parent = &pdev->dev;
 	udc->gadget.dev.dma_mask = pdev->dev.dma_mask;
-	udc->gadget.register_my_device = true;
 
 	the_controller = udc;
 	platform_set_drvdata(pdev, udc);
diff --git a/drivers/usb/gadget/udc-core.c b/drivers/usb/gadget/udc-core.c
index 9195054..4ee0efc 100644
--- a/drivers/usb/gadget/udc-core.c
+++ b/drivers/usb/gadget/udc-core.c
@@ -173,7 +173,6 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 	if (!udc)
 		goto err1;
 
-	if (gadget->register_my_device) {
 		dev_set_name(&gadget->dev, "gadget");
 
 		ret = device_register(&gadget->dev);
@@ -211,7 +210,6 @@ err3:
 	put_device(&udc->dev);
 
 err2:
-	if (gadget->register_my_device)
 		put_device(&gadget->dev);
 err1:
 	return ret;
@@ -267,7 +265,6 @@ found:
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	device_unregister(&udc->dev);
 
-	if (gadget->register_my_device)
 		device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 1c4a8e8..af88e27 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1875,7 +1875,6 @@ int musb_gadget_setup(struct musb *musb)
 	musb->g.dev.dma_mask = musb->controller->dma_mask;
 	musb->g.dev.release = musb_gadget_release;
 	musb->g.name = musb_driver_name;
-	musb->g.register_my_device = true;
 	musb->g.is_otg = 1;
 
 	musb_g_init_endpoints(musb);
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index b42d81d..853271e 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -986,7 +986,6 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	gpriv->gadget.name		= "renesas_usbhs_udc";
 	gpriv->gadget.ops		= &usbhsg_gadget_ops;
 	gpriv->gadget.max_speed		= USB_SPEED_HIGH;
-	gpriv->gadget.register_my_device = true;
 
 	INIT_LIST_HEAD(&gpriv->gadget.ep_list);
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index fcd9ef8..2e297e8 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -494,9 +494,6 @@ struct usb_gadget_ops {
  *	only supports HNP on a different root port.
  * @b_hnp_enable: OTG device feature flag, indicating that the A-Host
  *	enabled HNP support.
- * @register_my_device: Flag telling udc-core that UDC driver didn't
- *	register the gadget device to the driver model. Temporary until
- *	all UDC drivers are fixed up properly.
  * @name: Identifies the controller hardware type.  Used in diagnostics
  *	and sometimes configuration.
  * @dev: Driver model state for this abstract device.
@@ -534,7 +531,6 @@ struct usb_gadget {
 	unsigned			b_hnp_enable:1;
 	unsigned			a_hnp_support:1;
 	unsigned			a_alt_hnp_support:1;
-	unsigned			register_my_device:1;
 	const char			*name;
 	struct device			dev;
 	unsigned			out_epnum;
-- 
1.8.1.rc1.5.g7e0651a
