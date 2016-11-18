Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tL1nz4bTtzDvnG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 02:17:43 +1100 (AEDT)
Subject: patch "usb: gadget: udc: fsl: remove unnecessary & operation" added
 to usb-next
To: felipe.balbi@linux.intel.com, leoli@freescale.com,
 linuxppc-dev@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Nov 2016 16:10:06 +0100
Message-ID: <14794818069374@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    usb: gadget: udc: fsl: remove unnecessary & operation

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 0eb862e9c4f7a6a3abee25bc561ffdbe3d57a9d1 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@linux.intel.com>
Date: Wed, 28 Sep 2016 14:17:38 +0300
Subject: usb: gadget: udc: fsl: remove unnecessary & operation

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
2.10.2
