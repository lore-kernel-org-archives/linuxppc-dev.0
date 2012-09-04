Return-Path: <enrico.scholz@sigma-chemnitz.de>
Received: from mail.cvg.de (mail.cvg.de [62.153.82.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.cvg.de", Issuer "SIGMA Chemnitz Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9290F2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 03:31:01 +1000 (EST)
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime STATUS for
 IN xfer
Date: Tue,  4 Sep 2012 18:58:52 +0200
Message-Id: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: gregkh@linuxfoundation.org, balbi@ti.com,
 Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because the fsl_udc_core driver shares one 'status_req' object for the
complete ep0 control transfer, it is not possible to prime the final
STATUS phase immediately after the IN transaction.  E.g. ch9getstatus()
executed:

| req = udc->status_req;
| ...
| list_add_tail(&req->queue, &ep->queue);
| if (ep0_prime_status(udc, EP_DIR_OUT))
|       ....
|       struct fsl_req *req = udc->status_req;
|       list_add_tail(&req->queue, &ep->queue);

which corrupts the ep->queue list by inserting 'status_req' twice.  This
causes a kernel oops e.g. when 'lsusb -v' is executed on the host.

Patch delays the final 'ep0_prime_status(udc, EP_DIR_OUT))' by moving it
into the ep0 completion handler.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 drivers/usb/gadget/fsl_udc_core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index d7138cc..55c4a61 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -1294,8 +1294,7 @@ static int ep0_prime_status(struct fsl_udc *udc, int direction)
 		udc->ep0_dir = USB_DIR_OUT;
 
 	ep = &udc->eps[0];
-	if (udc->ep0_state != DATA_STATE_XMIT)
-		udc->ep0_state = WAIT_FOR_OUT_STATUS;
+	udc->ep0_state = WAIT_FOR_OUT_STATUS;
 
 	req->ep = ep;
 	req->req.length = 0;
@@ -1400,8 +1399,6 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 
 	list_add_tail(&req->queue, &ep->queue);
 	udc->ep0_state = DATA_STATE_XMIT;
-	if (ep0_prime_status(udc, EP_DIR_OUT))
-		ep0stall(udc);
 
 	return;
 stall:
@@ -1511,14 +1508,6 @@ static void setup_received_irq(struct fsl_udc *udc,
 		spin_lock(&udc->lock);
 		udc->ep0_state = (setup->bRequestType & USB_DIR_IN)
 				?  DATA_STATE_XMIT : DATA_STATE_RECV;
-		/*
-		 * If the data stage is IN, send status prime immediately.
-		 * See 2.0 Spec chapter 8.5.3.3 for detail.
-		 */
-		if (udc->ep0_state == DATA_STATE_XMIT)
-			if (ep0_prime_status(udc, EP_DIR_OUT))
-				ep0stall(udc);
-
 	} else {
 		/* No data phase, IN status from gadget */
 		udc->ep0_dir = USB_DIR_IN;
@@ -1548,7 +1537,8 @@ static void ep0_req_complete(struct fsl_udc *udc, struct fsl_ep *ep0,
 	switch (udc->ep0_state) {
 	case DATA_STATE_XMIT:
 		/* already primed at setup_received_irq */
-		udc->ep0_state = WAIT_FOR_OUT_STATUS;
+		if (ep0_prime_status(udc, EP_DIR_OUT))
+			ep0stall(udc);
 		break;
 	case DATA_STATE_RECV:
 		/* send status phase */
-- 
1.7.11.4
