Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 951D01007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 22:37:54 +1100 (EST)
From: Li Yang <leoli@freescale.com>
To: <balbi@ti.com>, <gregkh@suse.de>
Subject: [PATCH] usb/fsl_udc: fix dequeuing a request in progress
Date: Fri, 11 Nov 2011 20:38:13 +0800
Message-ID: <1321015093-13715-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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
---
 drivers/usb/gadget/fsl_udc_core.c |   62 +++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index b2c44e1..beef9b7 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -696,12 +696,31 @@ static void fsl_free_request(struct usb_ep *_ep, struct usb_request *_req)
 		kfree(req);
 }
 
-/*-------------------------------------------------------------------------*/
+/* Actually add a dTD chain to an empty dQH and let go */
+static void fsl_prime_ep(struct fsl_ep *ep, struct ep_td_struct *td)
+{
+	struct ep_queue_head *qh = ep->qh;
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
-- 
1.5.4.3
