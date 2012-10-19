Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB8DE2C036F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:25:25 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so111780bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:25:25 -0700 (PDT)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/7] usb: gadget: fsl_udc: protect fsl_pullup() with spin_lock
Date: Fri, 19 Oct 2012 12:24:40 +0200
Message-Id: <1350642285-8145-2-git-send-email-chf.fritz@googlemail.com>
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

This patch reworks fsl_pullup() against the background of switching over
to udc_start()/udc_stop() style:

Protect function fsl_pullup() with a spin_lock. Also set vbus_active as
default to true. This prevents disabling USB controller if there is no
driver support for an external transceiver (or GPIO) that detects a VBUS
power session starting.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 340451d..0a0d6a6 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -1242,8 +1242,10 @@ static int fsl_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 static int fsl_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct fsl_udc *udc;
+	unsigned long flags;
 
 	udc = container_of(gadget, struct fsl_udc, gadget);
+	spin_lock_irqsave(&udc->lock, flags);
 	udc->softconnect = (is_on != 0);
 	if (can_pullup(udc))
 		fsl_writel((fsl_readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
@@ -1251,6 +1253,7 @@ static int fsl_pullup(struct usb_gadget *gadget, int is_on)
 	else
 		fsl_writel((fsl_readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP),
 				&dr_regs->usbcmd);
+	spin_unlock_irqrestore(&udc->lock, flags);
 
 	return 0;
 }
@@ -2557,6 +2560,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&udc_controller->gadget.ep_list);
 	udc_controller->gadget.speed = USB_SPEED_UNKNOWN;
 	udc_controller->gadget.name = driver_name;
+	udc->vbus_active = true;
 
 	/* Setup gadget.dev and register with kernel */
 	dev_set_name(&udc_controller->gadget.dev, "gadget");
-- 
1.7.2.5
