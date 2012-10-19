Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC8BC2C03C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:25:44 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so111780bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:25:44 -0700 (PDT)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 7/7] usb: gadget: fsl_udc: purge global pointer dr_regs
Date: Fri, 19 Oct 2012 12:24:45 +0200
Message-Id: <1350642285-8145-7-git-send-email-chf.fritz@googlemail.com>
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

Move global driver pointer dr_regs to private struct fsl_udc.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |  252 +++++++++++++++++++------------------
 drivers/usb/gadget/fsl_usb2_udc.h |    1 +
 2 files changed, 130 insertions(+), 123 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 35ebcd4..f9c4eb9 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -41,8 +41,6 @@
 static const char driver_name[] = DRIVER_NAME;
 static const char driver_desc[] = DRIVER_DESC;
 
-static struct usb_dr_device *dr_regs;
-
 static const struct usb_endpoint_descriptor
 fsl_ep0_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
@@ -161,7 +159,7 @@ static int dr_controller_setup(struct fsl_udc *udc)
 #define FSL_UDC_RESET_TIMEOUT 1000
 
 	/* Config PHY interface */
-	portctrl = readl(&dr_regs->portsc1);
+	portctrl = readl(&udc->dr_regs->portsc1);
 	portctrl &= ~(PORTSCX_PHY_TYPE_SEL | PORTSCX_PORT_WIDTH);
 	switch (udc->phy_mode) {
 	case FSL_USB2_PHY_ULPI:
@@ -199,20 +197,20 @@ static int dr_controller_setup(struct fsl_udc *udc)
 	default:
 		return -EINVAL;
 	}
-	writel(portctrl, &dr_regs->portsc1);
+	writel(portctrl, &udc->dr_regs->portsc1);
 
 	/* Stop and reset the usb controller */
-	tmp = readl(&dr_regs->usbcmd);
+	tmp = readl(&udc->dr_regs->usbcmd);
 	tmp &= ~USB_CMD_RUN_STOP;
-	writel(tmp, &dr_regs->usbcmd);
+	writel(tmp, &udc->dr_regs->usbcmd);
 
-	tmp = readl(&dr_regs->usbcmd);
+	tmp = readl(&udc->dr_regs->usbcmd);
 	tmp |= USB_CMD_CTRL_RESET;
-	writel(tmp, &dr_regs->usbcmd);
+	writel(tmp, &udc->dr_regs->usbcmd);
 
 	/* Wait for reset to complete */
 	timeout = jiffies + FSL_UDC_RESET_TIMEOUT;
-	while (readl(&dr_regs->usbcmd) & USB_CMD_CTRL_RESET) {
+	while (readl(&udc->dr_regs->usbcmd) & USB_CMD_CTRL_RESET) {
 		if (time_after(jiffies, timeout)) {
 			ERR("udc reset timeout!\n");
 			return -ETIMEDOUT;
@@ -221,33 +219,33 @@ static int dr_controller_setup(struct fsl_udc *udc)
 	}
 
 	/* Set the controller as device mode */
-	tmp = readl(&dr_regs->usbmode);
+	tmp = readl(&udc->dr_regs->usbmode);
 	tmp &= ~USB_MODE_CTRL_MODE_MASK;	/* clear mode bits */
 	tmp |= USB_MODE_CTRL_MODE_DEVICE;
 	/* Disable Setup Lockout */
 	tmp |= USB_MODE_SETUP_LOCK_OFF;
 	if (udc->pdata->es)
 		tmp |= USB_MODE_ES;
-	writel(tmp, &dr_regs->usbmode);
+	writel(tmp, &udc->dr_regs->usbmode);
 
 	/* Clear the setup status */
-	writel(0, &dr_regs->usbsts);
+	writel(0, &udc->dr_regs->usbsts);
 
 	tmp = udc->ep_qh_dma;
 	tmp &= USB_EP_LIST_ADDRESS_MASK;
-	writel(tmp, &dr_regs->endpointlistaddr);
+	writel(tmp, &udc->dr_regs->endpointlistaddr);
 
 	VDBG("vir[qh_base] is %p phy[qh_base] is 0x%8x reg is 0x%8x",
 		udc->ep_qh, (int)tmp,
-		readl(&dr_regs->endpointlistaddr));
+		readl(&udc->dr_regs->endpointlistaddr));
 
-	max_no_of_ep = (0x0000001F & readl(&dr_regs->dccparams));
+	max_no_of_ep = (0x0000001F & readl(&udc->dr_regs->dccparams));
 	for (ep_num = 1; ep_num < max_no_of_ep; ep_num++) {
-		tmp = readl(&dr_regs->endptctrl[ep_num]);
+		tmp = readl(&udc->dr_regs->endptctrl[ep_num]);
 		tmp &= ~(EPCTRL_TX_TYPE | EPCTRL_RX_TYPE);
 		tmp |= (EPCTRL_EP_TYPE_BULK << EPCTRL_TX_EP_TYPE_SHIFT)
 		| (EPCTRL_EP_TYPE_BULK << EPCTRL_RX_EP_TYPE_SHIFT);
-		writel(tmp, &dr_regs->endptctrl[ep_num]);
+		writel(tmp, &udc->dr_regs->endptctrl[ep_num]);
 	}
 	/* Config control enable i/o output, cpu endian register */
 #ifndef CONFIG_ARCH_MXC
@@ -284,20 +282,20 @@ static void dr_controller_run(struct fsl_udc *udc)
 		| USB_INTR_PTC_DETECT_EN | USB_INTR_RESET_EN
 		| USB_INTR_DEVICE_SUSPEND | USB_INTR_SYS_ERR_EN;
 
-	writel(temp, &dr_regs->usbintr);
+	writel(temp, &udc->dr_regs->usbintr);
 
 	/* Clear stopped bit */
 	udc->stopped = 0;
 
 	/* Set the controller as device mode */
-	temp = readl(&dr_regs->usbmode);
+	temp = readl(&udc->dr_regs->usbmode);
 	temp |= USB_MODE_CTRL_MODE_DEVICE;
-	writel(temp, &dr_regs->usbmode);
+	writel(temp, &udc->dr_regs->usbmode);
 
 	/* Set controller to Run */
-	temp = readl(&dr_regs->usbcmd);
+	temp = readl(&udc->dr_regs->usbcmd);
 	temp |= USB_CMD_RUN_STOP;
-	writel(temp, &dr_regs->usbcmd);
+	writel(temp, &udc->dr_regs->usbcmd);
 }
 
 static void dr_controller_stop(struct fsl_udc *udc)
@@ -311,14 +309,14 @@ static void dr_controller_stop(struct fsl_udc *udc)
 	 * ehci driver
 	 */
 	if (udc->gadget.is_otg) {
-		if (!(readl(&dr_regs->otgsc) & OTGSC_STS_USB_ID)) {
+		if (!(readl(&udc->dr_regs->otgsc) & OTGSC_STS_USB_ID)) {
 			pr_debug("udc: Leaving early\n");
 			return;
 		}
 	}
 
 	/* disable all INTR */
-	writel(0, &dr_regs->usbintr);
+	writel(0, &udc->dr_regs->usbintr);
 
 	/* Set stopped bit for isr */
 	udc->stopped = 1;
@@ -327,17 +325,17 @@ static void dr_controller_stop(struct fsl_udc *udc)
 /*	udc->usb_sys_regs->control = 0; */
 
 	/* set controller to Stop */
-	tmp = readl(&dr_regs->usbcmd);
+	tmp = readl(&udc->dr_regs->usbcmd);
 	tmp &= ~USB_CMD_RUN_STOP;
-	writel(tmp, &dr_regs->usbcmd);
+	writel(tmp, &udc->dr_regs->usbcmd);
 }
 
-static void dr_ep_setup(unsigned char ep_num, unsigned char dir,
-			unsigned char ep_type)
+static void dr_ep_setup(struct fsl_udc *udc, unsigned char ep_num,
+		unsigned char dir, unsigned char ep_type)
 {
 	unsigned int tmp_epctrl = 0;
 
-	tmp_epctrl = readl(&dr_regs->endptctrl[ep_num]);
+	tmp_epctrl = readl(&udc->dr_regs->endptctrl[ep_num]);
 	if (dir) {
 		if (ep_num)
 			tmp_epctrl |= EPCTRL_TX_DATA_TOGGLE_RST;
@@ -354,15 +352,15 @@ static void dr_ep_setup(unsigned char ep_num, unsigned char dir,
 				<< EPCTRL_RX_EP_TYPE_SHIFT);
 	}
 
-	writel(tmp_epctrl, &dr_regs->endptctrl[ep_num]);
+	writel(tmp_epctrl, &udc->dr_regs->endptctrl[ep_num]);
 }
 
-static void
-dr_ep_change_stall(unsigned char ep_num, unsigned char dir, int value)
+static void dr_ep_change_stall(struct fsl_udc *udc, unsigned char ep_num,
+		unsigned char dir, int value)
 {
 	u32 tmp_epctrl = 0;
 
-	tmp_epctrl = readl(&dr_regs->endptctrl[ep_num]);
+	tmp_epctrl = readl(&udc->dr_regs->endptctrl[ep_num]);
 
 	if (value) {
 		/* set the stall bit */
@@ -380,16 +378,17 @@ dr_ep_change_stall(unsigned char ep_num, unsigned char dir, int value)
 			tmp_epctrl |= EPCTRL_RX_DATA_TOGGLE_RST;
 		}
 	}
-	writel(tmp_epctrl, &dr_regs->endptctrl[ep_num]);
+	writel(tmp_epctrl, &udc->dr_regs->endptctrl[ep_num]);
 }
 
 /* Get stall status of a specific ep
    Return: 0: not stalled; 1:stalled */
-static int dr_ep_get_stall(unsigned char ep_num, unsigned char dir)
+static int dr_ep_get_stall(struct fsl_udc *udc, unsigned char ep_num,
+		unsigned char dir)
 {
 	u32 epctrl;
 
-	epctrl = readl(&dr_regs->endptctrl[ep_num]);
+	epctrl = readl(&udc->dr_regs->endptctrl[ep_num]);
 	if (dir)
 		return (epctrl & EPCTRL_TX_EP_STALL) ? 1 : 0;
 	else
@@ -449,8 +448,8 @@ static void ep0_setup(struct fsl_udc *udc)
 			USB_MAX_CTRL_PAYLOAD, 0, 0);
 	struct_ep_qh_setup(udc, 0, USB_SEND, USB_ENDPOINT_XFER_CONTROL,
 			USB_MAX_CTRL_PAYLOAD, 0, 0);
-	dr_ep_setup(0, USB_RECV, USB_ENDPOINT_XFER_CONTROL);
-	dr_ep_setup(0, USB_SEND, USB_ENDPOINT_XFER_CONTROL);
+	dr_ep_setup(udc, 0, USB_RECV, USB_ENDPOINT_XFER_CONTROL);
+	dr_ep_setup(udc, 0, USB_SEND, USB_ENDPOINT_XFER_CONTROL);
 
 	return;
 
@@ -534,7 +533,7 @@ static int fsl_ep_enable(struct usb_ep *_ep,
 			max, zlt, mult);
 
 	/* Init endpoint ctrl register */
-	dr_ep_setup((unsigned char) ep_index(ep),
+	dr_ep_setup(udc, (unsigned char) ep_index(ep),
 			(unsigned char) ((desc->bEndpointAddress & USB_DIR_IN)
 					? USB_SEND : USB_RECV),
 			(unsigned char) (desc->bmAttributes
@@ -571,7 +570,7 @@ static int fsl_ep_disable(struct usb_ep *_ep)
 
 	/* disable ep on controller */
 	ep_num = ep_index(ep);
-	epctrl = readl(&dr_regs->endptctrl[ep_num]);
+	epctrl = readl(&udc->dr_regs->endptctrl[ep_num]);
 	if (ep_is_in(ep)) {
 		epctrl &= ~(EPCTRL_TX_ENABLE | EPCTRL_TX_TYPE);
 		epctrl |= EPCTRL_EP_TYPE_BULK << EPCTRL_TX_EP_TYPE_SHIFT;
@@ -579,7 +578,7 @@ static int fsl_ep_disable(struct usb_ep *_ep)
 		epctrl &= ~(EPCTRL_RX_ENABLE | EPCTRL_TX_TYPE);
 		epctrl |= EPCTRL_EP_TYPE_BULK << EPCTRL_RX_EP_TYPE_SHIFT;
 	}
-	writel(epctrl, &dr_regs->endptctrl[ep_num]);
+	writel(epctrl, &udc->dr_regs->endptctrl[ep_num]);
 
 	udc = (struct fsl_udc *)ep->udc;
 	spin_lock_irqsave(&udc->lock, flags);
@@ -629,6 +628,7 @@ static void fsl_free_request(struct usb_ep *_ep, struct usb_request *_req)
 static void fsl_prime_ep(struct fsl_ep *ep, struct ep_td_struct *td)
 {
 	struct ep_queue_head *qh = get_qh_by_ep(ep);
+	struct fsl_udc *udc = ep->udc;
 
 	/* Write dQH next pointer and terminate bit to 0 */
 	qh->next_dtd_ptr = cpu_to_le32(td->td_dma
@@ -643,13 +643,14 @@ static void fsl_prime_ep(struct fsl_ep *ep, struct ep_td_struct *td)
 
 	/* Prime endpoint by writing correct bit to ENDPTPRIME */
 	writel(ep_is_in(ep) ? (1 << (ep_index(ep) + 16))
-			: (1 << (ep_index(ep))), &dr_regs->endpointprime);
+			: (1 << (ep_index(ep))), &udc->dr_regs->endpointprime);
 }
 
 /* Add dTD chain to the dQH of an EP */
 static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 {
 	u32 temp, bitmask, tmp_stat;
+	struct fsl_udc *udc = ep->udc;
 
 	/* VDBG("QH addr Register 0x%8x", dr_regs->endpointlistaddr);
 	VDBG("ep_qh[%d] addr is 0x%8x", i, (u32)&(ep->udc->ep_qh[i])); */
@@ -668,22 +669,22 @@ static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 		/* Ensure dTD's next dtd pointer to be updated */
 		wmb();
 		/* Read prime bit, if 1 goto done */
-		if (readl(&dr_regs->endpointprime) & bitmask)
+		if (readl(&udc->dr_regs->endpointprime) & bitmask)
 			return;
 
 		do {
 			/* Set ATDTW bit in USBCMD */
-			temp = readl(&dr_regs->usbcmd);
-			writel(temp | USB_CMD_ATDTW, &dr_regs->usbcmd);
+			temp = readl(&udc->dr_regs->usbcmd);
+			writel(temp | USB_CMD_ATDTW, &udc->dr_regs->usbcmd);
 
 			/* Read correct status bit */
-			tmp_stat = readl(&dr_regs->endptstatus) & bitmask;
+			tmp_stat = readl(&udc->dr_regs->endptstatus) & bitmask;
 
-		} while (!(readl(&dr_regs->usbcmd) & USB_CMD_ATDTW));
+		} while (!(readl(&udc->dr_regs->usbcmd) & USB_CMD_ATDTW));
 
 		/* Write ATDTW bit to 0 */
-		temp = readl(&dr_regs->usbcmd);
-		writel(temp & ~USB_CMD_ATDTW, &dr_regs->usbcmd);
+		temp = readl(&udc->dr_regs->usbcmd);
+		writel(temp & ~USB_CMD_ATDTW, &udc->dr_regs->usbcmd);
 
 		if (tmp_stat)
 			return;
@@ -866,6 +867,7 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct fsl_ep *ep = container_of(_ep, struct fsl_ep, ep);
 	struct fsl_req *req;
+	struct fsl_udc *udc = ep->udc;
 	unsigned long flags;
 	int ep_num, stopped, ret = 0;
 	u32 epctrl;
@@ -873,18 +875,18 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	if (!_ep || !_req)
 		return -EINVAL;
 
-	spin_lock_irqsave(&ep->udc->lock, flags);
+	spin_lock_irqsave(&udc->lock, flags);
 	stopped = ep->stopped;
 
 	/* Stop the ep before we deal with the queue */
 	ep->stopped = 1;
 	ep_num = ep_index(ep);
-	epctrl = readl(&dr_regs->endptctrl[ep_num]);
+	epctrl = readl(&udc->dr_regs->endptctrl[ep_num]);
 	if (ep_is_in(ep))
 		epctrl &= ~EPCTRL_TX_ENABLE;
 	else
 		epctrl &= ~EPCTRL_RX_ENABLE;
-	writel(epctrl, &dr_regs->endptctrl[ep_num]);
+	writel(epctrl, &udc->dr_regs->endptctrl[ep_num]);
 
 	/* make sure it's actually queued on this endpoint */
 	list_for_each_entry(req, &ep->queue, queue) {
@@ -922,12 +924,12 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	done(ep, req, -ECONNRESET);
 
 	/* Enable EP */
-out:	epctrl = readl(&dr_regs->endptctrl[ep_num]);
+out:	epctrl = readl(&udc->dr_regs->endptctrl[ep_num]);
 	if (ep_is_in(ep))
 		epctrl |= EPCTRL_TX_ENABLE;
 	else
 		epctrl |= EPCTRL_RX_ENABLE;
-	writel(epctrl, &dr_regs->endptctrl[ep_num]);
+	writel(epctrl, &udc->dr_regs->endptctrl[ep_num]);
 	ep->stopped = stopped;
 
 	spin_unlock_irqrestore(&ep->udc->lock, flags);
@@ -973,7 +975,7 @@ static int fsl_ep_set_halt(struct usb_ep *_ep, int value)
 	ep_dir = ep_is_in(ep) ? USB_SEND : USB_RECV;
 	ep_num = (unsigned char)(ep_index(ep));
 	spin_lock_irqsave(&ep->udc->lock, flags);
-	dr_ep_change_stall(ep_num, ep_dir, value);
+	dr_ep_change_stall(udc, ep_num, ep_dir, value);
 	spin_unlock_irqrestore(&ep->udc->lock, flags);
 
 	if (ep_index(ep) == 0) {
@@ -1009,7 +1011,7 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
 	bitmask = (ep_is_in(ep)) ? (1 << (ep_index(ep) + 16)) :
 	    (1 << (ep_index(ep)));
 
-	if (readl(&dr_regs->endptstatus) & bitmask)
+	if (readl(&udc->dr_regs->endptstatus) & bitmask)
 		size = (qh->size_ioc_int_sts & DTD_PACKET_SIZE)
 		    >> DTD_LENGTH_BIT_POS;
 
@@ -1019,6 +1021,7 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
 
 static void fsl_ep_fifo_flush(struct usb_ep *_ep)
 {
+	struct fsl_udc *udc;
 	struct fsl_ep *ep;
 	int ep_num, ep_dir;
 	u32 bits;
@@ -1031,6 +1034,7 @@ static void fsl_ep_fifo_flush(struct usb_ep *_ep)
 		ep = container_of(_ep, struct fsl_ep, ep);
 		if (!ep->ep.desc)
 			return;
+		udc = ep->udc;
 	}
 	ep_num = ep_index(ep);
 	ep_dir = ep_is_in(ep) ? USB_SEND : USB_RECV;
@@ -1044,10 +1048,10 @@ static void fsl_ep_fifo_flush(struct usb_ep *_ep)
 
 	timeout = jiffies + FSL_UDC_FLUSH_TIMEOUT;
 	do {
-		writel(bits, &dr_regs->endptflush);
+		writel(bits, &udc->dr_regs->endptflush);
 
 		/* Wait until flush complete */
-		while (readl(&dr_regs->endptflush)) {
+		while (readl(&udc->dr_regs->endptflush)) {
 			if (time_after(jiffies, timeout)) {
 				ERR("ep flush timeout\n");
 				return;
@@ -1055,7 +1059,7 @@ static void fsl_ep_fifo_flush(struct usb_ep *_ep)
 			cpu_relax();
 		}
 		/* See if we need to flush again */
-	} while (readl(&dr_regs->endptstatus) & bits);
+	} while (readl(&udc->dr_regs->endptstatus) & bits);
 }
 
 static struct usb_ep_ops fsl_ep_ops = {
@@ -1082,7 +1086,8 @@ static struct usb_ep_ops fsl_ep_ops = {
  *----------------------------------------------------------------------*/
 static int fsl_get_frame(struct usb_gadget *gadget)
 {
-	return (int)(readl(&dr_regs->frindex) & USB_FRINDEX_MASKS);
+	struct fsl_udc *udc = container_of(gadget, struct fsl_udc, gadget);
+	return (int)(readl(&udc->dr_regs->frindex) & USB_FRINDEX_MASKS);
 }
 
 /*-----------------------------------------------------------------------
@@ -1097,13 +1102,13 @@ static int fsl_wakeup(struct usb_gadget *gadget)
 	if (!udc->remote_wakeup)
 		return -ENOTSUPP;
 
-	portsc = readl(&dr_regs->portsc1);
+	portsc = readl(&udc->dr_regs->portsc1);
 	/* not suspended? */
 	if (!(portsc & PORTSCX_PORT_SUSPEND))
 		return 0;
 	/* trigger force resume */
 	portsc |= PORTSCX_PORT_FORCE_RESUME;
-	writel(portsc, &dr_regs->portsc1);
+	writel(portsc, &udc->dr_regs->portsc1);
 	return 0;
 }
 
@@ -1124,11 +1129,11 @@ static int fsl_vbus_session(struct usb_gadget *gadget, int is_active)
 	VDBG("VBUS %s", is_active ? "on" : "off");
 	udc->vbus_active = (is_active != 0);
 	if (can_pullup(udc))
-		writel((readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
-				&dr_regs->usbcmd);
+		writel((readl(&udc->dr_regs->usbcmd) | USB_CMD_RUN_STOP),
+				&udc->dr_regs->usbcmd);
 	else
-		writel((readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
-				&dr_regs->usbcmd);
+		writel((readl(&udc->dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
+				&udc->dr_regs->usbcmd);
 	spin_unlock_irqrestore(&udc->lock, flags);
 	return 0;
 }
@@ -1162,11 +1167,11 @@ static int fsl_pullup(struct usb_gadget *gadget, int is_on)
 	spin_lock_irqsave(&udc->lock, flags);
 	udc->softconnect = (is_on != 0);
 	if (can_pullup(udc))
-		writel((readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
-				&dr_regs->usbcmd);
+		writel((readl(&udc->dr_regs->usbcmd) | USB_CMD_RUN_STOP),
+				&udc->dr_regs->usbcmd);
 	else
-		writel((readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
-				&dr_regs->usbcmd);
+		writel((readl(&udc->dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
+				&udc->dr_regs->usbcmd);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	return 0;
@@ -1195,9 +1200,9 @@ static void ep0stall(struct fsl_udc *udc)
 	u32 tmp;
 
 	/* must set tx and rx to stall at the same time */
-	tmp = readl(&dr_regs->endptctrl[0]);
+	tmp = readl(&udc->dr_regs->endptctrl[0]);
 	tmp |= EPCTRL_TX_EP_STALL | EPCTRL_RX_EP_STALL;
-	writel(tmp, &dr_regs->endptctrl[0]);
+	writel(tmp, &udc->dr_regs->endptctrl[0]);
 	udc->ep0_state = WAIT_FOR_SETUP;
 	udc->ep0_dir = 0;
 }
@@ -1290,8 +1295,8 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 		/* stall if endpoint doesn't exist */
 		if (!target_ep->ep.desc)
 			goto stall;
-		tmp = dr_ep_get_stall(ep_index(target_ep), ep_is_in(target_ep))
-				<< USB_ENDPOINT_HALT;
+		tmp = dr_ep_get_stall(udc, ep_index(target_ep),
+				ep_is_in(target_ep)) << USB_ENDPOINT_HALT;
 	}
 
 	udc->ep0_dir = USB_DIR_IN;
@@ -1407,8 +1412,8 @@ static void setup_received_irq(struct fsl_udc *udc,
 			u32 tmp;
 
 			mdelay(10);
-			tmp = readl(&dr_regs->portsc1) | (ptc << 16);
-			writel(tmp, &dr_regs->portsc1);
+			tmp = readl(&udc->dr_regs->portsc1) | (ptc << 16);
+			writel(tmp, &udc->dr_regs->portsc1);
 			printk(KERN_INFO "udc: switch to test mode %d.\n", ptc);
 		}
 
@@ -1460,7 +1465,7 @@ static void ep0_req_complete(struct fsl_udc *udc, struct fsl_ep *ep0,
 		/* Set the new address */
 		u32 new_address = (u32) udc->device_address;
 		writel(new_address << USB_DEVICE_ADDRESS_BIT_POS,
-				&dr_regs->deviceaddr);
+				&udc->dr_regs->deviceaddr);
 	}
 
 	done(ep0, req, 0);
@@ -1498,14 +1503,14 @@ static void tripwire_handler(struct fsl_udc *udc, u8 ep_num, u8 *buffer_ptr)
 	qh = &udc->ep_qh[ep_num * 2 + EP_DIR_OUT];
 
 	/* Clear bit in ENDPTSETUPSTAT */
-	temp = readl(&dr_regs->endptsetupstat);
-	writel(temp | (1 << ep_num), &dr_regs->endptsetupstat);
+	temp = readl(&udc->dr_regs->endptsetupstat);
+	writel(temp | (1 << ep_num), &udc->dr_regs->endptsetupstat);
 
 	/* while a hazard exists when setup package arrives */
 	do {
 		/* Set Setup Tripwire */
-		temp = readl(&dr_regs->usbcmd);
-		writel(temp | USB_CMD_SUTW, &dr_regs->usbcmd);
+		temp = readl(&udc->dr_regs->usbcmd);
+		writel(temp | USB_CMD_SUTW, &udc->dr_regs->usbcmd);
 
 		/* Copy the setup packet to local buffer */
 		if (pdata->le_setup_buf) {
@@ -1518,11 +1523,11 @@ static void tripwire_handler(struct fsl_udc *udc, u8 ep_num, u8 *buffer_ptr)
 		} else {
 			memcpy(buffer_ptr, (u8 *) qh->setup_buffer, 8);
 		}
-	} while (!(readl(&dr_regs->usbcmd) & USB_CMD_SUTW));
+	} while (!(readl(&udc->dr_regs->usbcmd) & USB_CMD_SUTW));
 
 	/* Clear Setup Tripwire */
-	temp = readl(&dr_regs->usbcmd);
-	writel(temp & ~USB_CMD_SUTW, &dr_regs->usbcmd);
+	temp = readl(&udc->dr_regs->usbcmd);
+	writel(temp & ~USB_CMD_SUTW, &udc->dr_regs->usbcmd);
 }
 
 /* process-ep_req(): free the completed Tds for this req */
@@ -1609,8 +1614,8 @@ static void dtd_complete_irq(struct fsl_udc *udc)
 	struct fsl_req *curr_req, *temp_req;
 
 	/* Clear the bits in the register */
-	bit_pos = readl(&dr_regs->endptcomplete);
-	writel(bit_pos, &dr_regs->endptcomplete);
+	bit_pos = readl(&udc->dr_regs->endptcomplete);
+	writel(bit_pos, &udc->dr_regs->endptcomplete);
 
 	if (!bit_pos)
 		return;
@@ -1674,10 +1679,10 @@ static void port_change_irq(struct fsl_udc *udc)
 		udc->bus_reset = 0;
 
 	/* Bus resetting is finished */
-	if (!(readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET))
+	if (!(readl(&udc->dr_regs->portsc1) & PORTSCX_PORT_RESET))
 		/* Get the speed */
 		udc->gadget.speed =
-			portscx_device_speed(readl(&dr_regs->portsc1));
+			portscx_device_speed(readl(&udc->dr_regs->portsc1));
 
 	/* Update USB state */
 	if (!udc->resume_state)
@@ -1728,8 +1733,8 @@ static void reset_irq(struct fsl_udc *udc)
 	unsigned long timeout;
 
 	/* Clear the device address */
-	temp = readl(&dr_regs->deviceaddr);
-	writel(temp & ~USB_DEVICE_ADDRESS_MASK, &dr_regs->deviceaddr);
+	temp = readl(&udc->dr_regs->deviceaddr);
+	writel(temp & ~USB_DEVICE_ADDRESS_MASK, &udc->dr_regs->deviceaddr);
 
 	udc->device_address = 0;
 
@@ -1743,15 +1748,15 @@ static void reset_irq(struct fsl_udc *udc)
 	udc->gadget.a_alt_hnp_support = 0;
 
 	/* Clear all the setup token semaphores */
-	temp = readl(&dr_regs->endptsetupstat);
-	writel(temp, &dr_regs->endptsetupstat);
+	temp = readl(&udc->dr_regs->endptsetupstat);
+	writel(temp, &udc->dr_regs->endptsetupstat);
 
 	/* Clear all the endpoint complete status bits */
-	temp = readl(&dr_regs->endptcomplete);
-	writel(temp, &dr_regs->endptcomplete);
+	temp = readl(&udc->dr_regs->endptcomplete);
+	writel(temp, &udc->dr_regs->endptcomplete);
 
 	timeout = jiffies + 100;
-	while (readl(&dr_regs->endpointprime)) {
+	while (readl(&udc->dr_regs->endpointprime)) {
 		/* Wait until all endptprime bits cleared */
 		if (time_after(jiffies, timeout)) {
 			ERR("Timeout for reset\n");
@@ -1761,9 +1766,9 @@ static void reset_irq(struct fsl_udc *udc)
 	}
 
 	/* Write 1s to the flush register */
-	writel(0xffffffff, &dr_regs->endptflush);
+	writel(0xffffffff, &udc->dr_regs->endptflush);
 
-	if (readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET) {
+	if (readl(&udc->dr_regs->portsc1) & PORTSCX_PORT_RESET) {
 		VDBG("Bus reset");
 		/* Bus is reseting */
 		udc->bus_reset = 1;
@@ -1802,22 +1807,23 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
 	if (udc->stopped)
 		return IRQ_NONE;
 	spin_lock_irqsave(&udc->lock, flags);
-	irq_src = readl(&dr_regs->usbsts) & readl(&dr_regs->usbintr);
+	irq_src = readl(&udc->dr_regs->usbsts) & readl(&udc->dr_regs->usbintr);
 	/* Clear notification bits */
-	writel(irq_src, &dr_regs->usbsts);
+	writel(irq_src, &udc->dr_regs->usbsts);
 
 	/* VDBG("irq_src [0x%8x]", irq_src); */
 
 	/* Need to resume? */
 	if (udc->usb_state == USB_STATE_SUSPENDED)
-		if ((readl(&dr_regs->portsc1) & PORTSCX_PORT_SUSPEND) == 0)
+		if ((readl(&udc->dr_regs->portsc1) & PORTSCX_PORT_SUSPEND) == 0)
 			bus_resume(udc);
 
 	/* USB Interrupt */
 	if (irq_src & USB_STS_INT) {
 		VDBG("Packet int");
 		/* Setup package, we only support ep0 as control ep */
-		if (readl(&dr_regs->endptsetupstat) & EP_SETUP_STATUS_EP0) {
+		if (readl(&udc->dr_regs->endptsetupstat) &
+				EP_SETUP_STATUS_EP0) {
 			tripwire_handler(udc, 0,
 					(u8 *) (&udc->local_setup_buff));
 			setup_received_irq(udc, &udc->local_setup_buff);
@@ -1825,7 +1831,7 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
 		}
 
 		/* completion of dtd */
-		if (readl(&dr_regs->endptcomplete)) {
+		if (readl(&udc->dr_regs->endptcomplete)) {
 			dtd_complete_irq(udc);
 			status = IRQ_HANDLED;
 		}
@@ -1987,7 +1993,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	next += t;
 
 	/* ------ DR Registers ----- */
-	tmp_reg = readl(&dr_regs->usbcmd);
+	tmp_reg = readl(&udc->dr_regs->usbcmd);
 	t = scnprintf(next, size,
 			"USBCMD reg:\n"
 			"SetupTW: %d\n"
@@ -1997,7 +2003,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->usbsts);
+	tmp_reg = readl(&udc->dr_regs->usbsts);
 	t = scnprintf(next, size,
 			"USB Status Reg:\n"
 			"Dr Suspend: %d Reset Received: %d System Error: %s "
@@ -2009,7 +2015,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->usbintr);
+	tmp_reg = readl(&udc->dr_regs->usbintr);
 	t = scnprintf(next, size,
 			"USB Intrrupt Enable Reg:\n"
 			"Sleep Enable: %d SOF Received Enable: %d "
@@ -2027,21 +2033,21 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->frindex);
+	tmp_reg = readl(&udc->dr_regs->frindex);
 	t = scnprintf(next, size,
 			"USB Frame Index Reg: Frame Number is 0x%x\n\n",
 			(tmp_reg & USB_FRINDEX_MASKS));
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->deviceaddr);
+	tmp_reg = readl(&udc->dr_regs->deviceaddr);
 	t = scnprintf(next, size,
 			"USB Device Address Reg: Device Addr is 0x%x\n\n",
 			(tmp_reg & USB_DEVICE_ADDRESS_MASK));
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->endpointlistaddr);
+	tmp_reg = readl(&udc->dr_regs->endpointlistaddr);
 	t = scnprintf(next, size,
 			"USB Endpoint List Address Reg: "
 			"Device Addr is 0x%x\n\n",
@@ -2049,7 +2055,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->portsc1);
+	tmp_reg = readl(&udc->dr_regs->portsc1);
 	t = scnprintf(next, size,
 		"USB Port Status&Control Reg:\n"
 		"Port Transceiver Type : %s Port Speed: %s\n"
@@ -2088,7 +2094,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->usbmode);
+	tmp_reg = readl(&udc->dr_regs->usbmode);
 	t = scnprintf(next, size,
 			"USB Mode Reg: Controller Mode is: %s\n\n", ( {
 				char *s;
@@ -2107,7 +2113,7 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	size -= t;
 	next += t;
 
-	tmp_reg = readl(&dr_regs->endptsetupstat);
+	tmp_reg = readl(&udc->dr_regs->endptsetupstat);
 	t = scnprintf(next, size,
 			"Endpoint Setup Status Reg: SETUP on ep 0x%x\n\n",
 			(tmp_reg & EP_SETUP_STATUS_MASK));
@@ -2115,13 +2121,13 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	next += t;
 
 	for (i = 0; i < udc->max_ep / 2; i++) {
-		tmp_reg = readl(&dr_regs->endptctrl[i]);
+		tmp_reg = readl(&udc->dr_regs->endptctrl[i]);
 		t = scnprintf(next, size, "EP Ctrl Reg [0x%x]: = [0x%x]\n",
 				i, tmp_reg);
 		size -= t;
 		next += t;
 	}
-	tmp_reg = readl(&dr_regs->endpointprime);
+	tmp_reg = readl(&udc->dr_regs->endpointprime);
 	t = scnprintf(next, size, "EP Prime Reg = [0x%x]\n\n", tmp_reg);
 	size -= t;
 	next += t;
@@ -2368,13 +2374,13 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		}
 	}
 
-	dr_regs = ioremap(res->start, resource_size(res));
-	if (!dr_regs) {
+	udc->dr_regs = ioremap(res->start, resource_size(res));
+	if (!udc->dr_regs) {
 		ret = -ENOMEM;
 		goto err_release_mem_region;
 	}
 
-	pdata->regs = (void *)dr_regs;
+	pdata->regs = (void *)udc->dr_regs;
 
 	/*
 	 * do platform specific init: check the clock, grab/config pins, etc.
@@ -2386,7 +2392,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 
 #ifndef CONFIG_ARCH_MXC
 	if (pdata->have_sysif_regs)
-		udc->usb_sys_regs = (void *)dr_regs + USB_DR_SYS_OFFSET;
+		udc->usb_sys_regs = (void *)udc->dr_regs + USB_DR_SYS_OFFSET;
 #endif
 
 	/* Initialize USB clocks */
@@ -2395,7 +2401,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		goto err_iounmap_noclk;
 
 	/* Read Device Controller Capability Parameters register */
-	dccparams = readl(&dr_regs->dccparams);
+	dccparams = readl(&udc->dr_regs->dccparams);
 	if (!(dccparams & DCCPARAMS_DC)) {
 		ERR("This SOC doesn't support device role\n");
 		ret = -ENODEV;
@@ -2505,7 +2511,7 @@ err_iounmap:
 		pdata->exit(pdev);
 	fsl_udc_clk_release();
 err_iounmap_noclk:
-	iounmap(dr_regs);
+	iounmap(udc->dr_regs);
 err_release_mem_region:
 	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
 		release_mem_region(res->start, resource_size(res));
@@ -2543,7 +2549,7 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 
 	dma_pool_destroy(udc->td_pool);
 	free_irq(udc->irq, udc);
-	iounmap(dr_regs);
+	iounmap(udc->dr_regs);
 	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
 		release_mem_region(res->start, resource_size(res));
 
@@ -2595,7 +2601,7 @@ static int fsl_udc_otg_suspend(struct device *dev, pm_message_t state)
 	struct fsl_udc *udc = container_of(dev, struct fsl_udc, gadget.dev);
 	u32 mode, usbcmd;
 
-	mode = readl(&dr_regs->usbmode) & USB_MODE_CTRL_MODE_MASK;
+	mode = readl(&udc->dr_regs->usbmode) & USB_MODE_CTRL_MODE_MASK;
 
 	pr_debug("%s(): mode 0x%x stopped %d\n", __func__, mode, udc->stopped);
 
@@ -2616,8 +2622,8 @@ static int fsl_udc_otg_suspend(struct device *dev, pm_message_t state)
 	}
 
 	/* stop the controller */
-	usbcmd = readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP;
-	writel(usbcmd, &dr_regs->usbcmd);
+	usbcmd = readl(&udc->dr_regs->usbcmd) & ~USB_CMD_RUN_STOP;
+	writel(usbcmd, &udc->dr_regs->usbcmd);
 
 	udc->stopped = 1;
 
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index 0d888f4..3b2a5ff 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -499,6 +499,7 @@ struct fsl_udc {
 
 	struct ep_td_struct *last_free_td;
 	struct usb_sys_interface *usb_sys_regs;
+	struct usb_dr_device *dr_regs;
 
 	u32 max_pipes;          /* Device max pipes */
 	u32 bus_reset;		/* Device is bus resetting */
-- 
1.7.2.5
