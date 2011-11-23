Return-Path: <r58472@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 08F661007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 22:10:45 +1100 (EST)
From: Li Yang <leoli@freescale.com>
To: <balbi@ti.com>, <gregkh@suse.de>
Subject: [PATCH v2] usb/fsl_udc: fix dequeuing a request in progress
Date: Wed, 23 Nov 2011 20:12:56 +0800
Message-ID: <1322050376-13553-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Chen <peter.chen@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original implementation of dequeuing a request in progress
is not correct.  Change to use a correct process and also clean
up the related functions a little bit.

Signed-off-by: Li Yang <leoli@freescale.com>
Cc: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/fsl_udc_core.c |   68 +++++++++++++++++-------------------
 drivers/usb/gadget/fsl_usb2_udc.h |   10 +++++
 2 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index b2c44e1..cc704dc 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -696,12 +696,31 @@ static void fsl_free_request(struct usb_ep *_ep, struct usb_request *_req)
 		kfree(req);
 }
 
-/*-------------------------------------------------------------------------*/
+/* Actually add a dTD chain to an empty dQH and let go */
+static void fsl_prime_ep(struct fsl_ep *ep, struct ep_td_struct *td)
+{
+	struct ep_queue_head *qh = get_qh_by_ep(ep);
+
+	/* Write dQH next pointer and terminate bit to 0 */
+	qh->next_dtd_ptr = cpu_to_hc32(td->td_dma
+			& EP_QUEUE_HEAD_NEXT_POINTER_MASK);
+
+	/* Clear active and halt bit */
+	qh->size_ioc_int_sts &= cpu_to_hc32(~(EP_QUEUE_HEAD_STATUS_ACTIVE
+					| EP_QUEUE_HEAD_STATUS_HALT));
+
+	/* Ensure that updates to the QH will occur before priming. */
+	wmb();
+
+	/* Prime endpoint by writing correct bit to ENDPTPRIME */
+	fsl_writel(ep_is_in(ep) ? (1 << (ep_index(ep) + 16))
+			: (1 << (ep_index(ep))), &dr_regs->endpointprime);
+}
+
+/* Add dTD chain to the dQH of an EP */
 static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 {
-	int i = ep_index(ep) * 2 + ep_is_in(ep);
 	u32 temp, bitmask, tmp_stat;
-	struct ep_queue_head *dQH = &ep->udc->ep_qh[i];
 
 	/* VDBG("QH addr Register 0x%8x", dr_regs->endpointlistaddr);
 	VDBG("ep_qh[%d] addr is 0x%8x", i, (u32)&(ep->udc->ep_qh[i])); */
@@ -719,7 +738,7 @@ static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 			cpu_to_hc32(req->head->td_dma & DTD_ADDR_MASK);
 		/* Read prime bit, if 1 goto done */
 		if (fsl_readl(&dr_regs->endpointprime) & bitmask)
-			goto out;
+			return;
 
 		do {
 			/* Set ATDTW bit in USBCMD */
@@ -736,28 +755,10 @@ static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 		fsl_writel(temp & ~USB_CMD_ATDTW, &dr_regs->usbcmd);
 
 		if (tmp_stat)
-			goto out;
+			return;
 	}
 
-	/* Write dQH next pointer and terminate bit to 0 */
-	temp = req->head->td_dma & EP_QUEUE_HEAD_NEXT_POINTER_MASK;
-	dQH->next_dtd_ptr = cpu_to_hc32(temp);
-
-	/* Clear active and halt bit */
-	temp = cpu_to_hc32(~(EP_QUEUE_HEAD_STATUS_ACTIVE
-			| EP_QUEUE_HEAD_STATUS_HALT));
-	dQH->size_ioc_int_sts &= temp;
-
-	/* Ensure that updates to the QH will occur before priming. */
-	wmb();
-
-	/* Prime endpoint by writing 1 to ENDPTPRIME */
-	temp = ep_is_in(ep)
-		? (1 << (ep_index(ep) + 16))
-		: (1 << (ep_index(ep)));
-	fsl_writel(temp, &dr_regs->endpointprime);
-out:
-	return;
+	fsl_prime_ep(ep, req->head);
 }
 
 /* Fill in the dTD structure
@@ -973,25 +974,20 @@ static int fsl_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 		/* The request isn't the last request in this ep queue */
 		if (req->queue.next != &ep->queue) {
-			struct ep_queue_head *qh;
 			struct fsl_req *next_req;
 
-			qh = ep->qh;
 			next_req = list_entry(req->queue.next, struct fsl_req,
 					queue);
 
-			/* Point the QH to the first TD of next request */
-			fsl_writel((u32) next_req->head, &qh->curr_dtd_ptr);
+			/* prime with dTD of next request */
+			fsl_prime_ep(ep, next_req->head);
 		}
-
-		/* The request hasn't been processed, patch up the TD chain */
+	/* The request hasn't been processed, patch up the TD chain */
 	} else {
 		struct fsl_req *prev_req;
 
 		prev_req = list_entry(req->queue.prev, struct fsl_req, queue);
-		fsl_writel(fsl_readl(&req->tail->next_td_ptr),
-				&prev_req->tail->next_td_ptr);
-
+		prev_req->tail->next_td_ptr = req->tail->next_td_ptr;
 	}
 
 	done(ep, req, -ECONNRESET);
@@ -1068,7 +1064,7 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
 	struct fsl_udc *udc;
 	int size = 0;
 	u32 bitmask;
-	struct ep_queue_head *d_qh;
+	struct ep_queue_head *qh;
 
 	ep = container_of(_ep, struct fsl_ep, ep);
 	if (!_ep || (!ep->desc && ep_index(ep) != 0))
@@ -1079,13 +1075,13 @@ static int fsl_ep_fifo_status(struct usb_ep *_ep)
 	if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN)
 		return -ESHUTDOWN;
 
-	d_qh = &ep->udc->ep_qh[ep_index(ep) * 2 + ep_is_in(ep)];
+	qh = get_qh_by_ep(ep);
 
 	bitmask = (ep_is_in(ep)) ? (1 << (ep_index(ep) + 16)) :
 	    (1 << (ep_index(ep)));
 
 	if (fsl_readl(&dr_regs->endptstatus) & bitmask)
-		size = (d_qh->size_ioc_int_sts & DTD_PACKET_SIZE)
+		size = (qh->size_ioc_int_sts & DTD_PACKET_SIZE)
 		    >> DTD_LENGTH_BIT_POS;
 
 	pr_debug("%s %u\n", __func__, size);
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index 1d51be8..f781f5d 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -569,6 +569,16 @@ static void dump_msg(const char *label, const u8 * buf, unsigned int length)
 					* 2 + ((windex & USB_DIR_IN) ? 1 : 0))
 #define get_pipe_by_ep(EP)	(ep_index(EP) * 2 + ep_is_in(EP))
 
+static inline struct ep_queue_head *get_qh_by_ep(struct fsl_ep *ep)
+{
+	/* we only have one ep0 structure but two queue heads */
+	if (ep_index(ep) != 0)
+		return ep->qh;
+	else
+		return &ep->udc->ep_qh[(ep->udc->ep0_dir ==
+				USB_DIR_IN) ? 1 : 0];
+}
+
 struct platform_device;
 #ifdef CONFIG_ARCH_MXC
 int fsl_udc_clk_init(struct platform_device *pdev);
-- 
1.5.4.3
