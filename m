Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 521E5DDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 04:51:30 +1100 (EST)
Date: Tue, 18 Nov 2008 20:51:27 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: dbrownell@users.sourceforge.net
Subject: [PATCH 2/6 v2] usb/fsl_qe_udc: Fix recursive locking bug in
	ch9getstatus()
Message-ID: <20081118175127.GA29920@oksana.dev.rtsoft.ru>
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
	<20081111160327.GB24699@oksana.dev.rtsoft.ru>
	<200811171759.42674.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200811171759.42674.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
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
so to fix that bug the lock-less __qe_ep_queue() function
implemented and used by the ch9getstatus().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Mon, Nov 17, 2008 at 05:59:42PM -0800, David Brownell wrote:
> On Tuesday 11 November 2008, Anton Vorontsov wrote:
> > -       spin_lock_irqsave(&udc->lock, flags);
> > +       if (lock)
> > +               spin_lock_irqsave(lock, flags);
> 
> Ugly ugly ugly.  Conditional locking is error prone ... don't.
> 
> Couldn't you just have the usb_ep_queue() method wrap lock calls
> around a common routine called by that and the status reporting code?

Yeah, that's much better approach.

> Or just have the status reporting code stuff the two bytes directly
> into the FIFO?  (Which is what a lot of other drivers do.)

Well, I think that using common code path for data transmission is
better, and simpler.

Thanks for the review.

 drivers/usb/gadget/fsl_qe_udc.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 60b9279..165ff76 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -1681,14 +1681,12 @@ static void qe_free_request(struct usb_ep *_ep, struct usb_request *_req)
 		kfree(req);
 }
 
-/* queues (submits) an I/O request to an endpoint */
-static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
-				gfp_t gfp_flags)
+static int __qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+			 gfp_t gfp_flags)
 {
 	struct qe_ep *ep = container_of(_ep, struct qe_ep, ep);
 	struct qe_req *req = container_of(_req, struct qe_req, req);
 	struct qe_udc *udc;
-	unsigned long flags;
 	int reval;
 
 	udc = ep->udc;
@@ -1732,7 +1730,7 @@ static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	list_add_tail(&req->queue, &ep->queue);
 	dev_vdbg(udc->dev, "gadget have request in %s! %d\n",
 			ep->name, req->req.length);
-	spin_lock_irqsave(&udc->lock, flags);
+
 	/* push the request to device */
 	if (ep_is_in(ep))
 		reval = ep_req_send(ep, req);
@@ -1748,11 +1746,24 @@ static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	if (ep->dir == USB_DIR_OUT)
 		reval = ep_req_receive(ep, req);
 
-	spin_unlock_irqrestore(&udc->lock, flags);
-
 	return 0;
 }
 
+/* queues (submits) an I/O request to an endpoint */
+static int qe_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+		       gfp_t gfp_flags)
+{
+	struct qe_ep *ep = container_of(_ep, struct qe_ep, ep);
+	struct qe_udc *udc = ep->udc;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&udc->lock, flags);
+	ret = __qe_ep_queue(_ep, _req, gfp_flags);
+	spin_unlock_irqrestore(&udc->lock, flags);
+	return ret;
+}
+
 /* dequeues (cancels, unlinks) an I/O request from an endpoint */
 static int qe_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
@@ -2008,7 +2019,7 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	udc->ep0_dir = USB_DIR_IN;
 
 	/* data phase */
-	status = qe_ep_queue(&ep->ep, &req->req, GFP_ATOMIC);
+	status = __qe_ep_queue(&ep->ep, &req->req, GFP_ATOMIC);
 
 	if (status == 0)
 		return;
-- 
1.5.6.3
