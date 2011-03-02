Return-Path: <huzaifas@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C78CEB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Mar 2011 17:23:07 +1100 (EST)
From: huzaifas@redhat.com
To: linux-usb@vger.kernel.org
Subject: [PATCH] Remove unused is_iso from fsl_udc_core.c
Date: Wed,  2 Mar 2011 11:53:00 +0530
Message-Id: <1299046980-10147-1-git-send-email-huzaifas@redhat.com>
Cc: dbrownell@users.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
	gregkh@suse.de, Huzaifa Sidhpurwala <huzaifas@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Huzaifa Sidhpurwala <huzaifas@redhat.com>

is_iso variable is not used anywhere, remove it

Signed-off-by: Huzaifa Sidhpurwala <huzaifas@redhat.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 4c55eda..912cb8e 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -766,7 +766,6 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 	struct fsl_req *req = container_of(_req, struct fsl_req, req);
 	struct fsl_udc *udc;
 	unsigned long flags;
-	int is_iso = 0;
 
 	/* catch various bogus parameters */
 	if (!_req || !req->req.complete || !req->req.buf
@@ -781,7 +780,6 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 	if (ep->desc->bmAttributes == USB_ENDPOINT_XFER_ISOC) {
 		if (req->req.length > ep->ep.maxpacket)
 			return -EMSGSIZE;
-		is_iso = 1;
 	}
 
 	udc = ep->udc;
-- 
1.7.3.4
