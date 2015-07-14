Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3A41A1C09
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:45:28 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRH012HD1RPXB10@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Jul 2015 18:45:25 +0900 (KST)
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
Subject: [PATCH v2 43/48] usb: gadget: udc: add usb_gadget_ep_match_desc()
 function
Date: Tue, 14 Jul 2015 11:39:31 +0200
Message-id: <1436866776-5004-44-git-send-email-r.baldyga@samsung.com>
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

Add function matching endpoint with ep descriptor. This function checks if
hardware endponit can fulfill requirements requested in descriptor. This
function can be used by UDC drivers in match_ep() callback to avoid writing
lots of repetitive code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/udc-core.c | 69 +++++++++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h        |  8 +++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index d69c355..2dff8df 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -129,6 +129,75 @@ EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
 
 /* ------------------------------------------------------------------------- */
 
+int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
+		struct usb_ep *ep, struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	u8              type;
+	u16             max;
+	int             num_req_streams = 0;
+
+	/* endpoint already claimed? */
+	if (ep->claimed)
+		return 0;
+
+	type = usb_endpoint_type(desc);
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
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		/* only support ep0 for portable CONTROL traffic */
+		return 0;
+	case USB_ENDPOINT_XFER_ISOC:
+		if (!ep->caps.type_iso)
+			return 0;
+		/* ISO:  limit 1023 bytes full speed, 1024 high/super speed */
+		if (!gadget_is_dualspeed(gadget) && max > 1023)
+			return 0;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		if (!ep->caps.type_bulk)
+			return 0;
+		if (ep_comp && gadget_is_superspeed(gadget)) {
+			/* Get the number of required streams from the
+			 * EP companion descriptor and see if the EP
+			 * matches it
+			 */
+			num_req_streams = ep_comp->bmAttributes & 0x1f;
+			if (num_req_streams > ep->max_streams)
+				return 0;
+		}
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		/* Bulk endpoints handle interrupt transfers,
+		 * except the toggle-quirky iso-synch kind
+		 */
+		if (!ep->caps.type_int && !ep->caps.type_bulk)
+			return 0;
+		/* INT:  limit 64 bytes full speed, 1024 high/super speed */
+		if (!gadget_is_dualspeed(gadget) && max > 64)
+			return 0;
+		break;
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_ep_match_desc);
+
+/* ------------------------------------------------------------------------- */
+
 static void usb_gadget_state_work(struct work_struct *work)
 {
 	struct usb_gadget *gadget = work_to_gadget(work);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 0041bb9..77e2c1e 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1079,6 +1079,14 @@ extern void usb_gadget_giveback_request(struct usb_ep *ep,
 
 /*-------------------------------------------------------------------------*/
 
+/* utility to check if endpoint caps match descriptor needs */
+
+extern int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
+		struct usb_ep *ep, struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp);
+
+/*-------------------------------------------------------------------------*/
+
 /* utility to update vbus status for udc core, it may be scheduled */
 extern void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status);
 
-- 
1.9.1
