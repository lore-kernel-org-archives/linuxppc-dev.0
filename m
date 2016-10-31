Return-Path: <felipe.balbi@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6rjm6ggYzDvK3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 21:50:20 +1100 (AEDT)
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Linux USB <linux-usb@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Li Yang <leoli@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/82] usb: gadget: udc: fsl: make use of new
 usb_endpoint_maxp_mult()
Date: Mon, 31 Oct 2016 12:48:12 +0200
Message-Id: <20161031104914.1990-21-felipe.balbi@linux.intel.com>
In-Reply-To: <20161031104914.1990-1-felipe.balbi@linux.intel.com>
References: <20161031104914.1990-1-felipe.balbi@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have introduced a helper to calculate multiplier
value from wMaxPacketSize. Start using it.

Cc: Li Yang <leoli@freescale.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index aab5221d6c2e..4459644b9b55 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -585,7 +585,7 @@ static int fsl_ep_enable(struct usb_ep *_ep,
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		/* Calculate transactions needed for high bandwidth iso */
-		mult = (unsigned char)(1 + ((max >> 11) & 0x03));
+		mult = usb_endpoint_maxp_mult(desc);
 		max = max & 0x7ff;	/* bit 0~10 */
 		/* 3 transactions at most */
 		if (mult > 3)
-- 
2.10.1
