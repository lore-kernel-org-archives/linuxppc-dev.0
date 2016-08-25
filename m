Return-Path: <wsa-dev@sang-engineering.com>
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKs7H4WwmzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 03:46:51 +1000 (AEST)
From: Wolfram Sang <wsa-dev@sang-engineering.com>
To: linux-usb@vger.kernel.org
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, Li Yang <leoli@freescale.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/44] usb: gadget: udc: fsl_qe_udc: don't print on ENOMEM
Date: Thu, 25 Aug 2016 19:39:03 +0200
Message-Id: <20160825173947.26624-12-wsa-dev@sang-engineering.com>
In-Reply-To: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
References: <20160825173947.26624-1-wsa-dev@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All kmalloc-based functions print enough information on failures.

Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index cf8819a5c5b263..9d6b2c8eed4294 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -421,10 +421,8 @@ static int qe_ep_rxbd_update(struct qe_ep *ep)
 	bd = ep->rxbase;
 
 	ep->rxframe = kmalloc(sizeof(*ep->rxframe), GFP_ATOMIC);
-	if (ep->rxframe == NULL) {
-		dev_err(ep->udc->dev, "malloc rxframe failed\n");
+	if (!ep->rxframe)
 		return -ENOMEM;
-	}
 
 	qe_frame_init(ep->rxframe);
 
@@ -435,9 +433,7 @@ static int qe_ep_rxbd_update(struct qe_ep *ep)
 
 	size = (ep->ep.maxpacket + USB_CRC_SIZE + 2) * (bdring_len + 1);
 	ep->rxbuffer = kzalloc(size, GFP_ATOMIC);
-	if (ep->rxbuffer == NULL) {
-		dev_err(ep->udc->dev, "malloc rxbuffer failed,size=%d\n",
-				size);
+	if (!ep->rxbuffer) {
 		kfree(ep->rxframe);
 		return -ENOMEM;
 	}
@@ -668,10 +664,8 @@ static int qe_ep_init(struct qe_udc *udc,
 
 	if ((ep->tm == USBP_TM_CTL) || (ep->dir == USB_DIR_IN)) {
 		ep->txframe = kmalloc(sizeof(*ep->txframe), GFP_ATOMIC);
-		if (ep->txframe == NULL) {
-			dev_err(udc->dev, "malloc txframe failed\n");
+		if (!ep->txframe)
 			goto en_done2;
-		}
 		qe_frame_init(ep->txframe);
 	}
 
@@ -2347,10 +2341,8 @@ static struct qe_udc *qe_udc_config(struct platform_device *ofdev)
 	u32 offset;
 
 	udc = kzalloc(sizeof(*udc), GFP_KERNEL);
-	if (udc == NULL) {
-		dev_err(&ofdev->dev, "malloc udc failed\n");
+	if (!udc)
 		goto cleanup;
-	}
 
 	udc->dev = &ofdev->dev;
 
-- 
2.9.3
