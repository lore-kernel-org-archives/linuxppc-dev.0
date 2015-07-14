Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 893EF1A19C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:45:22 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRH013EA1R2BQ10@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Jul 2015 18:45:02 +0900 (KST)
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
Subject: [PATCH v2 40/48] usb: gadget: epautoconf: rework ep_matches() function
Date: Tue, 14 Jul 2015 11:39:28 +0200
Message-id: <1436866776-5004-41-git-send-email-r.baldyga@samsung.com>
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

Rework ep_matches() function to make it shorter and better readable.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 87 +++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index d00b443..ee0d4e6 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -30,16 +30,29 @@ ep_matches (
 	struct usb_ss_ep_comp_descriptor *ep_comp
 )
 {
-	u8		type;
-	u16		max;
-
-	int		num_req_streams = 0;
+	u8              type;
+	u16             max;
+	int             num_req_streams = 0;
 
 	/* endpoint already claimed? */
 	if (ep->claimed)
 		return 0;
 
 	type = usb_endpoint_type(desc);
+	max = 0x7ff & usb_endpoint_maxp(desc);
+
+	if (usb_endpoint_dir_in(desc) && !ep->caps.dir_in)
+		return 0;
+	else if (!ep->caps.dir_out)
+		return 0;
+
+	if (max > ep->maxpacket_limit)
+		return 0;
+
+	/* "high bandwidth" works only at high speed */
+	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp(desc) & (3<<11))
+		return 0;
+
 	switch (type) {
 	case USB_ENDPOINT_XFER_CONTROL:
 		/* only support ep0 for portable CONTROL traffic */
@@ -47,66 +60,36 @@ ep_matches (
 	case USB_ENDPOINT_XFER_ISOC:
 		if (!ep->caps.type_iso)
 			return 0;
+		/* ISO:  limit 1023 bytes full speed,
+		 * 1024 high/super speed
+		 */
+		if (!gadget_is_dualspeed(gadget) && max > 1023)
+			return 0;
 		break;
 	case USB_ENDPOINT_XFER_BULK:
 		if (!ep->caps.type_bulk)
 			return 0;
+		if (ep_comp && gadget_is_superspeed(gadget)) {
+			/* Get the number of required streams from the
+			 * EP companion descriptor and see if the EP
+			 * matches it
+			 */
+			num_req_streams = ep_comp->bmAttributes & 0x1f;
+			if (num_req_streams > ep->max_streams)
+				return 0;
+		}
 		break;
 	case USB_ENDPOINT_XFER_INT:
-		/* bulk endpoints handle interrupt transfers,
+		/* Bulk endpoints handle interrupt transfers,
 		 * except the toggle-quirky iso-synch kind
 		 */
 		if (!ep->caps.type_int && !ep->caps.type_bulk)
 			return 0;
-		break;
-	}
-
-	if (usb_endpoint_dir_in(desc)) {
-		if (!ep->caps.dir_in)
-			return 0;
-	} else {
-		if (!ep->caps.dir_out)
-			return 0;
-	}
-
-	/*
-	 * Get the number of required streams from the EP companion
-	 * descriptor and see if the EP matches it
-	 */
-	if (usb_endpoint_xfer_bulk(desc)) {
-		if (ep_comp && gadget->max_speed >= USB_SPEED_SUPER) {
-			num_req_streams = ep_comp->bmAttributes & 0x1f;
-			if (num_req_streams > ep->max_streams)
-				return 0;
-		}
-
-	}
-
-	/* endpoint maxpacket size is an input parameter, except for bulk
-	 * where it's an output parameter representing the full speed limit.
-	 * the usb spec fixes high speed bulk maxpacket at 512 bytes.
-	 */
-	max = 0x7ff & usb_endpoint_maxp(desc);
-	switch (type) {
-	case USB_ENDPOINT_XFER_INT:
-		/* INT:  limit 64 bytes full speed, 1024 high/super speed */
+		/* INT:  limit 64 bytes full speed,
+		 * 1024 high/super speed
+		 */
 		if (!gadget_is_dualspeed(gadget) && max > 64)
 			return 0;
-		/* FALLTHROUGH */
-
-	case USB_ENDPOINT_XFER_ISOC:
-		/* ISO:  limit 1023 bytes full speed, 1024 high/super speed */
-		if (ep->maxpacket_limit < max)
-			return 0;
-		if (!gadget_is_dualspeed(gadget) && max > 1023)
-			return 0;
-
-		/* BOTH:  "high bandwidth" works only at high speed */
-		if ((desc->wMaxPacketSize & cpu_to_le16(3<<11))) {
-			if (!gadget_is_dualspeed(gadget))
-				return 0;
-			/* configure your hardware with enough buffering!! */
-		}
 		break;
 	}
 
-- 
1.9.1
