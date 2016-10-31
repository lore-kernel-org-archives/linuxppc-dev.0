Return-Path: <felipe.balbi@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6rkq0zH4zDvQ6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 21:51:14 +1100 (AEDT)
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Linux USB <linux-usb@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Li Yang <leoli@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 44/82] usb: gadget: udc: fsl: remove unnecessary & operation
Date: Mon, 31 Oct 2016 12:48:36 +0200
Message-Id: <20161031104914.1990-45-felipe.balbi@linux.intel.com>
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

Now that usb_endpoint_maxp() only returns the lowest
11 bits from wMaxPacketSize, we can remove the &
operation from this driver.

Cc: Li Yang <leoli@freescale.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 4459644b9b55..71094e479a96 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -586,7 +586,6 @@ static int fsl_ep_enable(struct usb_ep *_ep,
 	case USB_ENDPOINT_XFER_ISOC:
 		/* Calculate transactions needed for high bandwidth iso */
 		mult = usb_endpoint_maxp_mult(desc);
-		max = max & 0x7ff;	/* bit 0~10 */
 		/* 3 transactions at most */
 		if (mult > 3)
 			goto en_done;
-- 
2.10.1
