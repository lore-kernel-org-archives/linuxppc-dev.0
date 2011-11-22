Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 54D78B6F86
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 12:15:34 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <leoli@freescale.com>, <balbi@ti.com>
Subject: [PATCH] USB: fsl_udc_core: Use (&) instead of (==) to compare ISO XFER
Date: Tue, 22 Nov 2011 09:15:21 +0800
Message-ID: <1321924521-3218-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some ISO gadgets, like audio, has SYNC attribute as well as
USB_ENDPOINT_XFER_ISOC for their bmAttributes at ISO endpoint
descriptor. So, it needs to use & instead of == to judge if
it is ISO XFER.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index d786ba3..bf40de3 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -877,7 +877,7 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 		VDBG("%s, bad ep", __func__);
 		return -EINVAL;
 	}
-	if (ep->desc->bmAttributes == USB_ENDPOINT_XFER_ISOC) {
+	if (ep->desc->bmAttributes & USB_ENDPOINT_XFER_ISOC) {
 		if (req->req.length > ep->ep.maxpacket)
 			return -EMSGSIZE;
 	}
@@ -1032,7 +1032,7 @@ static int fsl_ep_set_halt(struct usb_ep *_ep, int value)
 		goto out;
 	}
 
-	if (ep->desc->bmAttributes == USB_ENDPOINT_XFER_ISOC) {
+	if (ep->desc->bmAttributes & USB_ENDPOINT_XFER_ISOC) {
 		status = -EOPNOTSUPP;
 		goto out;
 	}
-- 
1.6.3.3
