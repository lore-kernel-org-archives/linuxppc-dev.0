Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5A6C7474DA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:03:38 +1100 (EST)
Date: Tue, 11 Nov 2008 19:03:27 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 2/6] usb/fsl_qe_udc: Fix recursive locking bug in
	ch9getstatus()
Message-ID: <20081111160327.GB24699@oksana.dev.rtsoft.ru>
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The call chain is this:

qe_udc_irq() <- grabs the udc->lock spinlock
rx_irq()
qe_ep0_rx()
ep0_setup_handle()
setup_received_handle()
ch9getstatus()
qe_ep_queue() <- tries to grab the udc->lock again

It seems unsafe to temporarily drop the lock in the ch9getstatus(),
so to fix that bug the __qe_ep_queue() function implemented and used
by the ch9getstatus().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/gadget/fsl_qe_udc.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 60b9279..abcb35d 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -1681,14 +1681,13 @@ static void qe_free_request(struct usb_ep *_ep, struct usb_request *_req)
 		kfree(req);
 }
 
-/* queues (submits) an I/O request to an endpoint */
-static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
-				gfp_t gfp_flags)
+static int __qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+			 gfp_t gfp_flags, spinlock_t *lock)
 {
 	struct qe_ep *ep = container_of(_ep, struct qe_ep, ep);
 	struct qe_req *req = container_of(_req, struct qe_req, req);
 	struct qe_udc *udc;
-	unsigned long flags;
+	unsigned long flags = 0; /* shut up gcc */
 	int reval;
 
 	udc = ep->udc;
@@ -1732,7 +1731,8 @@ static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	list_add_tail(&req->queue, &ep->queue);
 	dev_vdbg(udc->dev, "gadget have request in %s! %d\n",
 			ep->name, req->req.length);
-	spin_lock_irqsave(&udc->lock, flags);
+	if (lock)
+		spin_lock_irqsave(lock, flags);
 	/* push the request to device */
 	if (ep_is_in(ep))
 		reval = ep_req_send(ep, req);
@@ -1748,11 +1748,21 @@ static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	if (ep->dir == USB_DIR_OUT)
 		reval = ep_req_receive(ep, req);
 
-	spin_unlock_irqrestore(&udc->lock, flags);
+	if (lock)
+		spin_unlock_irqrestore(lock, flags);
 
 	return 0;
 }
 
+/* queues (submits) an I/O request to an endpoint */
+static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+		       gfp_t gfp_flags)
+{
+	struct qe_ep *ep = container_of(_ep, struct qe_ep, ep);
+
+	return __qe_ep_queue(_ep, _req, gfp_flags, &ep->udc->lock);
+}
+
 /* dequeues (cancels, unlinks) an I/O request from an endpoint */
 static int qe_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
@@ -2008,7 +2018,7 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	udc->ep0_dir = USB_DIR_IN;
 
 	/* data phase */
-	status = qe_ep_queue(&ep->ep, &req->req, GFP_ATOMIC);
+	status = __qe_ep_queue(&ep->ep, &req->req, GFP_ATOMIC, NULL);
 
 	if (status == 0)
 		return;
-- 
1.5.6.3
