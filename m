Return-Path: <enrico.scholz@sigma-chemnitz.de>
Received: from mail.cvg.de (mail.cvg.de [62.153.82.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.cvg.de", Issuer "SIGMA Chemnitz Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5ECB2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 03:25:09 +1000 (EST)
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] usb: gadget: fsl_udc_core: remove mapped flag
Date: Tue,  4 Sep 2012 19:24:59 +0200
Message-Id: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
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

The 'mapped' flag in 'struct fsl_req' flag is redundant with checking
for 'req.dma != DMA_ADDR_INVALID' and it was also set to a wrong value
(see 2nd hunk of patch).

Replacing it in the way described above saves 60 bytes:

  function                                     old     new   delta
  fsl_udc_irq                                 2952    2940     -12
  ep0_prime_status                             380     368     -12
  done                                         448     432     -16
  fsl_ep_queue                                 668     648     -20

and has same (or less) runtime costs like evaluating 'req->mapped'.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 drivers/usb/gadget/fsl_udc_core.c | 10 ++--------
 drivers/usb/gadget/fsl_usb2_udc.h |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 55c4a61..1282a11 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -195,14 +195,13 @@ static void done(struct fsl_ep *ep, struct fsl_req *req, int status)
 		dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
 	}
 
-	if (req->mapped) {
+	if (req->req.dma != DMA_ADDR_INVALID) {
 		dma_unmap_single(ep->udc->gadget.dev.parent,
 			req->req.dma, req->req.length,
 			ep_is_in(ep)
 				? DMA_TO_DEVICE
 				: DMA_FROM_DEVICE);
 		req->req.dma = DMA_ADDR_INVALID;
-		req->mapped = 0;
 	} else
 		dma_sync_single_for_cpu(ep->udc->gadget.dev.parent,
 			req->req.dma, req->req.length,
@@ -915,15 +914,12 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 					req->req.length, ep_is_in(ep)
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
-		req->mapped = 1;
-	} else {
+	} else
 		dma_sync_single_for_device(ep->udc->gadget.dev.parent,
 					req->req.dma, req->req.length,
 					ep_is_in(ep)
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
-		req->mapped = 0;
-	}
 
 	req->req.status = -EINPROGRESS;
 	req->req.actual = 0;
@@ -1306,7 +1302,6 @@ static int ep0_prime_status(struct fsl_udc *udc, int direction)
 	req->req.dma = dma_map_single(ep->udc->gadget.dev.parent,
 			req->req.buf, req->req.length,
 			ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-	req->mapped = 1;
 
 	if (fsl_req_to_dtd(req, GFP_ATOMIC) == 0)
 		fsl_queue_td(ep, req);
@@ -1389,7 +1384,6 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	req->req.dma = dma_map_single(ep->udc->gadget.dev.parent,
 				req->req.buf, req->req.length,
 				ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-	req->mapped = 1;
 
 	/* prime the data phase */
 	if ((fsl_req_to_dtd(req, GFP_ATOMIC) == 0))
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index fbd77ba..9aab166 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -436,7 +436,6 @@ struct fsl_req {
 	/* ep_queue() func will add
 	   a request->queue into a udc_ep->queue 'd tail */
 	struct fsl_ep *ep;
-	unsigned mapped:1;
 
 	struct ep_td_struct *head, *tail;	/* For dTD List
 						   cpu endian Virtual addr */
-- 
1.7.11.4
