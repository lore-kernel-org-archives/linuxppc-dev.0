Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 775AB2C0193
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:25:29 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so111780bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:25:28 -0700 (PDT)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/7] usb: gadget: fsl_udc: convert to new ulc style
Date: Fri, 19 Oct 2012 12:24:41 +0200
Message-Id: <1350642285-8145-3-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <daniel@caiaq.de>,
 Christian Hemp <c.hemp@phytec.de>, linuxppc-dev@lists.ozlabs.org,
 Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert to new UDC style registration and remove
global 'udc_controller' pointer.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |  289 +++++++++++++++++--------------------
 1 files changed, 131 insertions(+), 158 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 0a0d6a6..d113f39 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -63,9 +63,6 @@ static struct usb_dr_device *dr_regs;
 
 static struct usb_sys_interface *usb_sys_regs;
 
-/* it is initialized in probe()  */
-static struct fsl_udc *udc_controller = NULL;
-
 static const struct usb_endpoint_descriptor
 fsl_ep0_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
@@ -783,12 +780,14 @@ static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 }
 
 /* Fill in the dTD structure
+ * @udc: driver private data
  * @req: request that the transfer belongs to
  * @length: return actually data length of the dTD
  * @dma: return dma address of the dTD
  * @is_last: return flag if it is the last dTD of the request
  * return: pointer to the built dTD */
-static struct ep_td_struct *fsl_build_dtd(struct fsl_req *req, unsigned *length,
+static struct ep_td_struct *fsl_build_dtd(struct fsl_udc *udc,
+		struct fsl_req *req, unsigned *length,
 		dma_addr_t *dma, int *is_last, gfp_t gfp_flags)
 {
 	u32 swap_temp;
@@ -798,7 +797,7 @@ static struct ep_td_struct *fsl_build_dtd(struct fsl_req *req, unsigned *length,
 	*length = min(req->req.length - req->req.actual,
 			(unsigned)EP_MAX_LENGTH_TRANSFER);
 
-	dtd = dma_pool_alloc(udc_controller->td_pool, gfp_flags, dma);
+	dtd = dma_pool_alloc(udc->td_pool, gfp_flags, dma);
 	if (dtd == NULL)
 		return dtd;
 
@@ -848,7 +847,8 @@ static struct ep_td_struct *fsl_build_dtd(struct fsl_req *req, unsigned *length,
 }
 
 /* Generate dtd chain for a request */
-static int fsl_req_to_dtd(struct fsl_req *req, gfp_t gfp_flags)
+static int fsl_req_to_dtd(struct fsl_udc *udc, struct fsl_req *req,
+		gfp_t gfp_flags)
 {
 	unsigned	count;
 	int		is_last;
@@ -857,7 +857,8 @@ static int fsl_req_to_dtd(struct fsl_req *req, gfp_t gfp_flags)
 	dma_addr_t dma;
 
 	do {
-		dtd = fsl_build_dtd(req, &count, &dma, &is_last, gfp_flags);
+		dtd = fsl_build_dtd(udc, req, &count, &dma, &is_last,
+				gfp_flags);
 		if (dtd == NULL)
 			return -ENOMEM;
 
@@ -932,7 +933,7 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 	req->dtd_count = 0;
 
 	/* build dtds and push them to device queue */
-	if (!fsl_req_to_dtd(req, gfp_flags)) {
+	if (!fsl_req_to_dtd(udc, req, gfp_flags)) {
 		spin_lock_irqsave(&udc->lock, flags);
 		fsl_queue_td(ep, req);
 	} else {
@@ -1258,9 +1259,10 @@ static int fsl_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
-static int fsl_start(struct usb_gadget_driver *driver,
-		int (*bind)(struct usb_gadget *, struct usb_gadget_driver *));
-static int fsl_stop(struct usb_gadget_driver *driver);
+static int fsl_udc_start(struct usb_gadget *gadget,
+		struct usb_gadget_driver *driver);
+static int fsl_udc_stop(struct usb_gadget *gadget,
+		struct usb_gadget_driver *driver);
 /* defined in gadget.h */
 static struct usb_gadget_ops fsl_gadget_ops = {
 	.get_frame = fsl_get_frame,
@@ -1269,8 +1271,8 @@ static struct usb_gadget_ops fsl_gadget_ops = {
 	.vbus_session = fsl_vbus_session,
 	.vbus_draw = fsl_vbus_draw,
 	.pullup = fsl_pullup,
-	.start = fsl_start,
-	.stop = fsl_stop,
+	.udc_start = fsl_udc_start,
+	.udc_stop = fsl_udc_stop,
 };
 
 /* Set protocol stall on ep0, protocol stall will automatically be cleared
@@ -1314,7 +1316,7 @@ static int ep0_prime_status(struct fsl_udc *udc, int direction)
 			ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	req->mapped = 1;
 
-	if (fsl_req_to_dtd(req, GFP_ATOMIC) == 0)
+	if (fsl_req_to_dtd(udc, req, GFP_ATOMIC) == 0)
 		fsl_queue_td(ep, req);
 	else
 		return -ENOMEM;
@@ -1398,7 +1400,7 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	req->mapped = 1;
 
 	/* prime the data phase */
-	if ((fsl_req_to_dtd(req, GFP_ATOMIC) == 0))
+	if ((fsl_req_to_dtd(udc, req, GFP_ATOMIC) == 0))
 		fsl_queue_td(ep, req);
 	else			/* no mem */
 		goto stall;
@@ -1422,7 +1424,7 @@ static void setup_received_irq(struct fsl_udc *udc,
 
 	udc_reset_ep_queue(udc, 0);
 
-	/* We process some stardard setup requests here */
+	/* We process some standard setup requests here */
 	switch (setup->bRequest) {
 	case USB_REQ_GET_STATUS:
 		/* Data+Status phase from udc */
@@ -1954,114 +1956,82 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
  * Hook to gadget drivers
  * Called by initialization code of gadget drivers
 *----------------------------------------------------------------*/
-static int fsl_start(struct usb_gadget_driver *driver,
-		int (*bind)(struct usb_gadget *, struct usb_gadget_driver *))
+static int fsl_udc_start(struct usb_gadget *gadget,
+	struct usb_gadget_driver *driver)
 {
+	struct fsl_udc *udc;
 	int retval = -ENODEV;
-	unsigned long flags = 0;
+	unsigned long flags;
 
-	if (!udc_controller)
+	udc = container_of(gadget, struct fsl_udc, gadget);
+	if (!udc)
 		return -ENODEV;
 
 	if (!driver || driver->max_speed < USB_SPEED_FULL
-			|| !bind || !driver->disconnect || !driver->setup)
+			|| !driver->disconnect || !driver->setup)
 		return -EINVAL;
 
-	if (udc_controller->driver)
-		return -EBUSY;
-
 	/* lock is needed but whether should use this lock or another */
-	spin_lock_irqsave(&udc_controller->lock, flags);
+	spin_lock_irqsave(&udc->lock, flags);
 
 	driver->driver.bus = NULL;
-	/* hook up the driver */
-	udc_controller->driver = driver;
-	udc_controller->gadget.dev.driver = &driver->driver;
-	spin_unlock_irqrestore(&udc_controller->lock, flags);
-
-	/* bind udc driver to gadget driver */
-	retval = bind(&udc_controller->gadget, driver);
-	if (retval) {
-		VDBG("bind to %s --> %d", driver->driver.name, retval);
-		udc_controller->gadget.dev.driver = NULL;
-		udc_controller->driver = NULL;
-		goto out;
-	}
 
-	if (!IS_ERR_OR_NULL(udc_controller->transceiver)) {
+	if (!IS_ERR_OR_NULL(udc->transceiver)) {
 		/* Suspend the controller until OTG enable it */
-		udc_controller->stopped = 1;
+		udc->stopped = 1;
 		printk(KERN_INFO "Suspend udc for OTG auto detect\n");
 
 		/* connect to bus through transceiver */
-		if (!IS_ERR_OR_NULL(udc_controller->transceiver)) {
-			retval = otg_set_peripheral(
-					udc_controller->transceiver->otg,
-						    &udc_controller->gadget);
+		if (!IS_ERR_OR_NULL(udc->transceiver)) {
+			retval = otg_set_peripheral(udc->transceiver->otg,
+					&udc->gadget);
 			if (retval < 0) {
 				ERR("can't bind to transceiver\n");
-				driver->unbind(&udc_controller->gadget);
-				udc_controller->gadget.dev.driver = 0;
-				udc_controller->driver = 0;
 				return retval;
 			}
 		}
 	} else {
-		/* Enable DR IRQ reg and set USBCMD reg Run bit */
-		dr_controller_run(udc_controller);
-		udc_controller->usb_state = USB_STATE_ATTACHED;
-		udc_controller->ep0_state = WAIT_FOR_SETUP;
-		udc_controller->ep0_dir = 0;
+		/* hook up the driver */
+		udc->driver = driver;
+		udc->gadget.dev.driver = &driver->driver;
+		dr_controller_run(udc);
+		udc->usb_state = USB_STATE_ATTACHED;
+		udc->ep0_state = WAIT_FOR_SETUP;
+		udc->ep0_dir = USB_DIR_OUT;
 	}
-	printk(KERN_INFO "%s: bind to driver %s\n",
-			udc_controller->gadget.name, driver->driver.name);
+	spin_unlock_irqrestore(&udc->lock, flags);
 
-out:
-	if (retval)
-		printk(KERN_WARNING "gadget driver register failed %d\n",
-		       retval);
-	return retval;
+	return 0;
 }
 
 /* Disconnect from gadget driver */
-static int fsl_stop(struct usb_gadget_driver *driver)
+static int fsl_udc_stop(struct usb_gadget *gadget,
+	struct usb_gadget_driver *driver)
 {
+	struct fsl_udc *udc;
 	struct fsl_ep *loop_ep;
 	unsigned long flags;
 
-	if (!udc_controller)
-		return -ENODEV;
-
-	if (!driver || driver != udc_controller->driver || !driver->unbind)
-		return -EINVAL;
-
-	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
-		otg_set_peripheral(udc_controller->transceiver->otg, NULL);
+	udc = container_of(gadget, struct fsl_udc, gadget);
 
 	/* stop DR, disable intr */
-	dr_controller_stop(udc_controller);
+	dr_controller_stop(udc);
 
 	/* in fact, no needed */
-	udc_controller->usb_state = USB_STATE_ATTACHED;
-	udc_controller->ep0_state = WAIT_FOR_SETUP;
-	udc_controller->ep0_dir = 0;
+	udc->usb_state = USB_STATE_ATTACHED;
+	udc->ep0_state = WAIT_FOR_SETUP;
+	udc->ep0_dir = USB_DIR_OUT;
 
 	/* stand operation */
-	spin_lock_irqsave(&udc_controller->lock, flags);
-	udc_controller->gadget.speed = USB_SPEED_UNKNOWN;
-	nuke(&udc_controller->eps[0], -ESHUTDOWN);
-	list_for_each_entry(loop_ep, &udc_controller->gadget.ep_list,
-			ep.ep_list)
+	spin_lock_irqsave(&udc->lock, flags);
+	udc->gadget.speed = USB_SPEED_UNKNOWN;
+	nuke(&udc->eps[0], -ESHUTDOWN);
+	list_for_each_entry(loop_ep, &udc->gadget.ep_list, ep.ep_list)
 		nuke(loop_ep, -ESHUTDOWN);
-	spin_unlock_irqrestore(&udc_controller->lock, flags);
-
-	/* report disconnect; the controller is already quiesced */
-	driver->disconnect(&udc_controller->gadget);
+	spin_unlock_irqrestore(&udc->lock, flags);
 
-	/* unbind gadget and unhook driver. */
-	driver->unbind(&udc_controller->gadget);
-	udc_controller->gadget.dev.driver = NULL;
-	udc_controller->driver = NULL;
+	udc->gadget.dev.driver = NULL;
+	udc->driver = NULL;
 
 	printk(KERN_WARNING "unregistered gadget driver '%s'\n",
 	       driver->driver.name);
@@ -2088,8 +2058,8 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	u32 tmp_reg;
 	struct fsl_ep *ep = NULL;
 	struct fsl_req *req;
+	struct fsl_udc *udc = _dev;
 
-	struct fsl_udc *udc = udc_controller;
 	if (off != 0)
 		return 0;
 
@@ -2318,7 +2288,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 }
 
 #define create_proc_file()	create_proc_read_entry(proc_filename, \
-				0, NULL, fsl_proc_read, NULL)
+				0, NULL, fsl_proc_read, udc)
 
 #define remove_proc_file()	remove_proc_entry(proc_filename, NULL)
 
@@ -2334,10 +2304,12 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 /* Release udc structures */
 static void fsl_udc_release(struct device *dev)
 {
-	complete(udc_controller->done);
-	dma_free_coherent(dev->parent, udc_controller->ep_qh_size,
-			udc_controller->ep_qh, udc_controller->ep_qh_dma);
-	kfree(udc_controller);
+	struct fsl_udc *udc = container_of(dev, struct fsl_udc, gadget.dev);
+
+	complete(udc->done);
+	dma_free_coherent(dev->parent, udc->ep_qh_size,
+			udc->ep_qh, udc->ep_qh_dma);
+	kfree(udc);
 }
 
 /******************************************************************
@@ -2436,6 +2408,7 @@ static int __init struct_ep_setup(struct fsl_udc *udc, unsigned char index,
  */
 static int __init fsl_udc_probe(struct platform_device *pdev)
 {
+	struct fsl_udc *udc;
 	struct fsl_usb2_platform_data *pdata;
 	struct resource *res;
 	int ret = -ENODEV;
@@ -2447,21 +2420,21 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	udc_controller = kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);
-	if (udc_controller == NULL) {
+	udc = kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);
+	if (udc == NULL) {
 		ERR("malloc udc failed\n");
 		return -ENOMEM;
 	}
 
 	pdata = pdev->dev.platform_data;
-	udc_controller->pdata = pdata;
-	spin_lock_init(&udc_controller->lock);
-	udc_controller->stopped = 1;
+	udc->pdata = pdata;
+	spin_lock_init(&udc->lock);
+	udc->stopped = 1;
 
 #ifdef CONFIG_USB_OTG
 	if (pdata->operating_mode == FSL_USB2_DR_OTG) {
-		udc_controller->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
-		if (IS_ERR_OR_NULL(udc_controller->transceiver)) {
+		udc->transceiver = usb_get_phy(USB_PHY_TYPE_USB2);
+		if (IS_ERR_OR_NULL(udc->transceiver)) {
 			ERR("Can't find OTG driver!\n");
 			ret = -ENODEV;
 			goto err_kfree;
@@ -2522,90 +2495,90 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	}
 	/* Get max device endpoints */
 	/* DEN is bidirectional ep number, max_ep doubles the number */
-	udc_controller->max_ep = (dccparams & DCCPARAMS_DEN_MASK) * 2;
+	udc->max_ep = (dccparams & DCCPARAMS_DEN_MASK) * 2;
 
-	udc_controller->irq = platform_get_irq(pdev, 0);
-	if (!udc_controller->irq) {
+	udc->irq = platform_get_irq(pdev, 0);
+	if (!udc->irq) {
 		ret = -ENODEV;
 		goto err_iounmap;
 	}
 
-	ret = request_irq(udc_controller->irq, fsl_udc_irq, IRQF_SHARED,
-			driver_name, udc_controller);
+	ret = request_irq(udc->irq, fsl_udc_irq, IRQF_SHARED,
+			driver_name, udc);
 	if (ret != 0) {
 		ERR("cannot request irq %d err %d\n",
-				udc_controller->irq, ret);
+				udc->irq, ret);
 		goto err_iounmap;
 	}
 
 	/* Initialize the udc structure including QH member and other member */
-	if (struct_udc_setup(udc_controller, pdev)) {
+	if (struct_udc_setup(udc, pdev)) {
 		ERR("Can't initialize udc data structure\n");
 		ret = -ENOMEM;
 		goto err_free_irq;
 	}
 
-	if (IS_ERR_OR_NULL(udc_controller->transceiver)) {
+	if (IS_ERR_OR_NULL(udc->transceiver)) {
 		/* initialize usb hw reg except for regs for EP,
 		 * leave usbintr reg untouched */
-		dr_controller_setup(udc_controller);
+		dr_controller_setup(udc);
 	}
 
 	fsl_udc_clk_finalize(pdev);
 
 	/* Setup gadget structure */
-	udc_controller->gadget.ops = &fsl_gadget_ops;
-	udc_controller->gadget.max_speed = USB_SPEED_HIGH;
-	udc_controller->gadget.ep0 = &udc_controller->eps[0].ep;
-	INIT_LIST_HEAD(&udc_controller->gadget.ep_list);
-	udc_controller->gadget.speed = USB_SPEED_UNKNOWN;
-	udc_controller->gadget.name = driver_name;
+	udc->gadget.ops = &fsl_gadget_ops;
+	udc->gadget.max_speed = USB_SPEED_HIGH;
+	udc->gadget.ep0 = &udc->eps[0].ep;
+	INIT_LIST_HEAD(&udc->gadget.ep_list);
+	udc->gadget.speed = USB_SPEED_UNKNOWN;
+	udc->gadget.name = driver_name;
 	udc->vbus_active = true;
 
 	/* Setup gadget.dev and register with kernel */
-	dev_set_name(&udc_controller->gadget.dev, "gadget");
-	udc_controller->gadget.dev.release = fsl_udc_release;
-	udc_controller->gadget.dev.parent = &pdev->dev;
-	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
-	ret = device_register(&udc_controller->gadget.dev);
+	dev_set_name(&udc->gadget.dev, "gadget");
+	udc->gadget.dev.release = fsl_udc_release;
+	udc->gadget.dev.parent = &pdev->dev;
+	udc->gadget.dev.of_node = pdev->dev.of_node;
+	ret = device_register(&udc->gadget.dev);
 	if (ret < 0)
 		goto err_free_irq;
 
-	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
-		udc_controller->gadget.is_otg = 1;
+	if (!IS_ERR_OR_NULL(udc->transceiver))
+		udc->gadget.is_otg = 1;
 
 	/* setup QH and epctrl for ep0 */
-	ep0_setup(udc_controller);
+	ep0_setup(udc);
 
 	/* setup udc->eps[] for ep0 */
-	struct_ep_setup(udc_controller, 0, "ep0", 0);
+	struct_ep_setup(udc, 0, "ep0", 0);
 	/* for ep0: the desc defined here;
 	 * for other eps, gadget layer called ep_enable with defined desc
 	 */
-	udc_controller->eps[0].ep.desc = &fsl_ep0_desc;
-	udc_controller->eps[0].ep.maxpacket = USB_MAX_CTRL_PAYLOAD;
+	udc->eps[0].ep.desc = &fsl_ep0_desc;
+	udc->eps[0].ep.maxpacket = USB_MAX_CTRL_PAYLOAD;
 
 	/* setup the udc->eps[] for non-control endpoints and link
 	 * to gadget.ep_list */
-	for (i = 1; i < (int)(udc_controller->max_ep / 2); i++) {
+	for (i = 1; i < (int)(udc->max_ep / 2); i++) {
 		char name[14];
 
 		sprintf(name, "ep%dout", i);
-		struct_ep_setup(udc_controller, i * 2, name, 1);
+		struct_ep_setup(udc, i * 2, name, 1);
 		sprintf(name, "ep%din", i);
-		struct_ep_setup(udc_controller, i * 2 + 1, name, 1);
+		struct_ep_setup(udc, i * 2 + 1, name, 1);
 	}
 
 	/* use dma_pool for TD management */
-	udc_controller->td_pool = dma_pool_create("udc_td", &pdev->dev,
+	udc->td_pool = dma_pool_create("udc_td", &pdev->dev,
 			sizeof(struct ep_td_struct),
 			DTD_ALIGNMENT, UDC_DMA_BOUNDARY);
-	if (udc_controller->td_pool == NULL) {
+	if (udc->td_pool == NULL) {
 		ret = -ENOMEM;
 		goto err_unregister;
 	}
 
-	ret = usb_add_gadget_udc(&pdev->dev, &udc_controller->gadget);
+	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
 	if (ret)
 		goto err_del_udc;
 
@@ -2613,11 +2586,11 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_udc:
-	dma_pool_destroy(udc_controller->td_pool);
+	dma_pool_destroy(udc->td_pool);
 err_unregister:
-	device_unregister(&udc_controller->gadget.dev);
+	device_unregister(&udc->gadget.dev);
 err_free_irq:
-	free_irq(udc_controller->irq, udc_controller);
+	free_irq(udc->irq, udc);
 err_iounmap:
 	if (pdata->exit)
 		pdata->exit(pdev);
@@ -2628,8 +2601,7 @@ err_release_mem_region:
 	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
 		release_mem_region(res->start, resource_size(res));
 err_kfree:
-	kfree(udc_controller);
-	udc_controller = NULL;
+	kfree(udc);
 	return ret;
 }
 
@@ -2638,16 +2610,13 @@ err_kfree:
  */
 static int __exit fsl_udc_remove(struct platform_device *pdev)
 {
+	struct fsl_udc *udc = dev_get_drvdata(&pdev->dev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-
 	DECLARE_COMPLETION(done);
 
-	if (!udc_controller)
-		return -ENODEV;
-
-	usb_del_gadget_udc(&udc_controller->gadget);
-	udc_controller->done = &done;
+	usb_del_gadget_udc(&udc->gadget);
+	udc->done = &done;
 
 	fsl_udc_clk_release();
 
@@ -2655,17 +2624,17 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	remove_proc_file();
 
 	/* Free allocated memory */
-	kfree(udc_controller->status_req->req.buf);
-	kfree(udc_controller->status_req);
-	kfree(udc_controller->eps);
+	kfree(udc->status_req->req.buf);
+	kfree(udc->status_req);
+	kfree(udc->eps);
 
-	dma_pool_destroy(udc_controller->td_pool);
-	free_irq(udc_controller->irq, udc_controller);
+	dma_pool_destroy(udc->td_pool);
+	free_irq(udc->irq, udc);
 	iounmap(dr_regs);
 	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
 		release_mem_region(res->start, resource_size(res));
 
-	device_unregister(&udc_controller->gadget.dev);
+	device_unregister(&udc->gadget.dev);
 	/* free udc --wait for the release() finished */
 	wait_for_completion(&done);
 
@@ -2685,7 +2654,8 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
  -----------------------------------------------------------------*/
 static int fsl_udc_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	dr_controller_stop(udc_controller);
+	struct fsl_udc *udc = dev_get_drvdata(&pdev->dev);
+	dr_controller_stop(udc);
 	return 0;
 }
 
@@ -2695,20 +2665,21 @@ static int fsl_udc_suspend(struct platform_device *pdev, pm_message_t state)
  *-----------------------------------------------------------------*/
 static int fsl_udc_resume(struct platform_device *pdev)
 {
+	struct fsl_udc *udc = dev_get_drvdata(&pdev->dev);
 	/* Enable DR irq reg and set controller Run */
-	if (udc_controller->stopped) {
-		dr_controller_setup(udc_controller);
-		dr_controller_run(udc_controller);
+	if (udc->stopped) {
+		dr_controller_setup(udc);
+		dr_controller_run(udc);
 	}
-	udc_controller->usb_state = USB_STATE_ATTACHED;
-	udc_controller->ep0_state = WAIT_FOR_SETUP;
-	udc_controller->ep0_dir = 0;
+	udc->usb_state = USB_STATE_ATTACHED;
+	udc->ep0_state = WAIT_FOR_SETUP;
+	udc->ep0_dir = USB_DIR_OUT;
 	return 0;
 }
 
 static int fsl_udc_otg_suspend(struct device *dev, pm_message_t state)
 {
-	struct fsl_udc *udc = udc_controller;
+	struct fsl_udc *udc = container_of(dev, struct fsl_udc, gadget.dev);
 	u32 mode, usbcmd;
 
 	mode = fsl_readl(&dr_regs->usbmode) & USB_MODE_CTRL_MODE_MASK;
@@ -2744,15 +2715,17 @@ static int fsl_udc_otg_suspend(struct device *dev, pm_message_t state)
 
 static int fsl_udc_otg_resume(struct device *dev)
 {
+	struct fsl_udc *udc = container_of(dev, struct fsl_udc, gadget.dev);
+
 	pr_debug("%s(): stopped %d  already_stopped %d\n", __func__,
-		 udc_controller->stopped, udc_controller->already_stopped);
+		 udc->stopped, udc->already_stopped);
 
 	/*
 	 * If the controller was stopped at suspend time, then
 	 * don't resume it now.
 	 */
-	if (udc_controller->already_stopped) {
-		udc_controller->already_stopped = 0;
+	if (udc->already_stopped) {
+		udc->already_stopped = 0;
 		pr_debug("gadget was already stopped, leaving early\n");
 		return 0;
 	}
-- 
1.7.2.5
