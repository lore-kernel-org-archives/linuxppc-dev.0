Return-Path: <hofrat@osadl.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421KG75KmszF375
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 20:57:51 +1000 (AEST)
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Li Yang <leoyang.li@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] usb: gadget: fsl_udc_core: check allocation return value
 and cleanup on failure
Date: Thu, 30 Aug 2018 12:16:58 +0200
Message-Id: <1535624219-17854-1-git-send-email-hofrat@osadl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The allocation with fsl_alloc_request() and kmalloc() were unchecked
fixed this up with a NULL check and appropriate cleanup.

Additionally udc->ep_qh_size was reset to 0 on failure of allocation.
Similar udc->phy_mode is initially 0 (as udc_controller was
allocated with kzalloc in fsl_udc_probe()) so reset it to 0 as well
so that this function is side-effect free on failure. Not clear if
this is necessary or sensible as fsl_udc_release() probably can not
be called if fsl_udc_probe() failed - but it should not hurt.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: b504882da5 ("USB: add Freescale high-speed USB SOC device controller driver")
---

Problem located with experimental coccinelle script

Patch was compile tested with: imx_v6_v7_defconfig (implies USB_FSL_USB2=y)
(with a large number of sparse warnings not related to the proposed change
 and one smatch warning)

Patch is against 4.19-rc1 (localversion-next is next-20180830)

 drivers/usb/gadget/udc/fsl_udc_core.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index be59309..e637afb 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2247,8 +2247,10 @@ static int struct_udc_setup(struct fsl_udc *udc,
 	udc->phy_mode = pdata->phy_mode;
 
 	udc->eps = kcalloc(udc->max_ep, sizeof(struct fsl_ep), GFP_KERNEL);
-	if (!udc->eps)
-		return -1;
+	if (!udc->eps) {
+		ERR("kmalloc udc endpoint status failed\n");
+		goto eps_alloc_failed;
+	}
 
 	/* initialized QHs, take care of alignment */
 	size = udc->max_ep * sizeof(struct ep_queue_head);
@@ -2262,8 +2264,7 @@ static int struct_udc_setup(struct fsl_udc *udc,
 					&udc->ep_qh_dma, GFP_KERNEL);
 	if (!udc->ep_qh) {
 		ERR("malloc QHs for udc failed\n");
-		kfree(udc->eps);
-		return -1;
+		goto ep_queue_alloc_failed;
 	}
 
 	udc->ep_qh_size = size;
@@ -2272,8 +2273,17 @@ static int struct_udc_setup(struct fsl_udc *udc,
 	/* FIXME: fsl_alloc_request() ignores ep argument */
 	udc->status_req = container_of(fsl_alloc_request(NULL, GFP_KERNEL),
 			struct fsl_req, req);
+	if (!udc->status_req) {
+		ERR("kzalloc for udc status request failed\n");
+		goto udc_status_alloc_failed;
+	}
+
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf = kmalloc(8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		ERR("kzalloc for udc request buffer failed\n");
+		goto udc_req_buf_alloc_failed;
+	}
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
 	udc->usb_state = USB_STATE_POWERED;
@@ -2281,6 +2291,18 @@ static int struct_udc_setup(struct fsl_udc *udc,
 	udc->remote_wakeup = 0;	/* default to 0 on reset */
 
 	return 0;
+
+udc_req_buf_alloc_failed:
+	kfree(udc->status_req);
+udc_status_alloc_failed:
+	kfree(udc->ep_qh);
+	udc->ep_qh_size = 0;
+ep_queue_alloc_failed:
+	kfree(udc->eps);
+eps_alloc_failed:
+	udc->phy_mode = 0;
+	return -1;
+
 }
 
 /*----------------------------------------------------------------
-- 
2.1.4
