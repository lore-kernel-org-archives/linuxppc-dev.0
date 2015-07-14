Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AF3E1A1975
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:46:01 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRH02CVO1RY0A20@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Jul 2015 18:45:34 +0900 (KST)
From: Robert Baldyga <r.baldyga@samsung.com>
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de,
 nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com,
 Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 44/48] usb: gadget: epautoconf: remove ep_matches() function
Date: Tue, 14 Jul 2015 11:39:32 +0200
Message-id: <1436866776-5004-45-git-send-email-r.baldyga@samsung.com>
In-reply-to: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As now we have usb_gadget_ep_match_desc() function which does exactly the same
thing as ep_matches(), we can remove the second one and replace all of its calls
with usb_gadget_ep_match_desc() calls.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 95 +++++------------------------------------
 1 file changed, 11 insertions(+), 84 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 92a1a4c..7c43b7c 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -22,82 +22,6 @@
 
 #include "gadget_chips.h"
 
-static int
-ep_matches (
-	struct usb_gadget		*gadget,
-	struct usb_ep			*ep,
-	struct usb_endpoint_descriptor	*desc,
-	struct usb_ss_ep_comp_descriptor *ep_comp
-)
-{
-	u8              type;
-	u16             max;
-	int             num_req_streams = 0;
-
-	/* endpoint already claimed? */
-	if (ep->claimed)
-		return 0;
-
-	type = usb_endpoint_type(desc);
-	max = 0x7ff & usb_endpoint_maxp(desc);
-
-	if (usb_endpoint_dir_in(desc) && !ep->caps.dir_in)
-		return 0;
-	else if (!ep->caps.dir_out)
-		return 0;
-
-	if (max > ep->maxpacket_limit)
-		return 0;
-
-	/* "high bandwidth" works only at high speed */
-	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp(desc) & (3<<11))
-		return 0;
-
-	switch (type) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		/* only support ep0 for portable CONTROL traffic */
-		return 0;
-	case USB_ENDPOINT_XFER_ISOC:
-		if (!ep->caps.type_iso)
-			return 0;
-		/* ISO:  limit 1023 bytes full speed,
-		 * 1024 high/super speed
-		 */
-		if (!gadget_is_dualspeed(gadget) && max > 1023)
-			return 0;
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		if (!ep->caps.type_bulk)
-			return 0;
-		if (ep_comp && gadget_is_superspeed(gadget)) {
-			/* Get the number of required streams from the
-			 * EP companion descriptor and see if the EP
-			 * matches it
-			 */
-			num_req_streams = ep_comp->bmAttributes & 0x1f;
-			if (num_req_streams > ep->max_streams)
-				return 0;
-		}
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		/* Bulk endpoints handle interrupt transfers,
-		 * except the toggle-quirky iso-synch kind
-		 */
-		if (!ep->caps.type_int && !ep->caps.type_bulk)
-			return 0;
-		/* INT:  limit 64 bytes full speed,
-		 * 1024 high/super speed
-		 */
-		if (!gadget_is_dualspeed(gadget) && max > 64)
-			return 0;
-		break;
-	}
-
-	/* MATCH!! */
-
-	return 1;
-}
-
 static struct usb_ep *
 find_ep (struct usb_gadget *gadget, const char *name)
 {
@@ -180,10 +104,12 @@ struct usb_ep *usb_ep_autoconfig_ss(
 		if (type == USB_ENDPOINT_XFER_INT) {
 			/* ep-e, ep-f are PIO with only 64 byte fifos */
 			ep = find_ep(gadget, "ep-e");
-			if (ep && ep_matches(gadget, ep, desc, ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 			ep = find_ep(gadget, "ep-f");
-			if (ep && ep_matches(gadget, ep, desc, ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 		}
 
@@ -191,20 +117,21 @@ struct usb_ep *usb_ep_autoconfig_ss(
 		snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
 				usb_endpoint_dir_in(desc) ? "in" : "out");
 		ep = find_ep(gadget, name);
-		if (ep && ep_matches(gadget, ep, desc, ep_comp))
+		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
 	} else if (gadget_is_goku (gadget)) {
 		if (USB_ENDPOINT_XFER_INT == type) {
 			/* single buffering is enough */
 			ep = find_ep(gadget, "ep3-bulk");
-			if (ep && ep_matches(gadget, ep, desc, ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 		} else if (USB_ENDPOINT_XFER_BULK == type
 				&& (USB_DIR_IN & desc->bEndpointAddress)) {
 			/* DMA may be available */
 			ep = find_ep(gadget, "ep2-bulk");
-			if (ep && ep_matches(gadget, ep, desc,
-					      ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 		}
 
@@ -223,14 +150,14 @@ struct usb_ep *usb_ep_autoconfig_ss(
 				ep = find_ep(gadget, "ep2out");
 		} else
 			ep = NULL;
-		if (ep && ep_matches(gadget, ep, desc, ep_comp))
+		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
 #endif
 	}
 
 	/* Second, look at endpoints until an unclaimed one looks usable */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		if (ep_matches(gadget, ep, desc, ep_comp))
+		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
 	}
 
-- 
1.9.1
