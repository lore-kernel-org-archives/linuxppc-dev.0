Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1A301A1E28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:23:03 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS5027EV3ECNSE0@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:23:00 +0900 (KST)
From: Robert Baldyga <r.baldyga@samsung.com>
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, Peter.Chen@freescale.com,
 johnyoun@synopsys.com, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com,
 cernekee@gmail.com, leoli@freescale.com, daniel@zonque.org,
 haojian.zhuang@gmail.com, robert.jarzmik@free.fr, michal.simek@xilinx.com,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com,
 m.szyprowski@samsung.com, stern@rowland.harvard.edu, petr.cvek@tul.cz,
 Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v4 46/46] usb: musb: gadget: add musb_match_ep() function
Date: Mon, 27 Jul 2015 11:16:56 +0200
Message-id: <1437988616-6962-47-git-send-email-r.baldyga@samsung.com>
In-reply-to: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
process. Function does the same that was done by chip-specific code inside
of epautoconf. Now this code can be removed from there to separate generic code
from platform specific logic.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 23 -----------------------
 drivers/usb/musb/musb_gadget.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index da45371..254ece7 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -83,29 +83,6 @@ struct usb_ep *usb_ep_autoconfig_ss(
 			goto found_ep;
 	}
 
-	/* First, apply chip-specific "best usage" knowledge.
-	 * This might make a good usb_gadget_ops hook ...
-	 */
-#ifdef CONFIG_BLACKFIN
-	if (gadget_is_musbhdrc(gadget)) {
-		if ((USB_ENDPOINT_XFER_BULK == type) ||
-		    (USB_ENDPOINT_XFER_ISOC == type)) {
-			if (USB_DIR_IN & desc->bEndpointAddress)
-				ep = gadget_find_ep_by_name(gadget, "ep5in");
-			else
-				ep = gadget_find_ep_by_name(gadget, "ep6out");
-		} else if (USB_ENDPOINT_XFER_INT == type) {
-			if (USB_DIR_IN & desc->bEndpointAddress)
-				ep = gadget_find_ep_by_name(gadget, "ep1in");
-			else
-				ep = gadget_find_ep_by_name(gadget, "ep2out");
-		} else
-			ep = NULL;
-		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
-	}
-#endif
-
 	/* Second, look at endpoints until an unclaimed one looks usable */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
 		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 043248a..3a64cf2 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1684,6 +1684,39 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
+#ifdef CONFIG_BLACKFIN
+static struct usb_ep *musb_match_ep(struct usb_gadget *g,
+		struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	struct usb_ep *ep = NULL;
+	u8 type = usb_endpoint_type(desc);
+
+	switch(type) {
+	case USB_ENDPOINT_XFER_ISOC:
+	case USB_ENDPOINT_XFER_BULK:
+		if (usb_endpoint_dir_in(desc))
+			ep = gadget_find_ep_by_name(g, "ep5in");
+		else
+			ep = gadget_find_ep_by_name(g, "ep6out");
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		if (usb_endpoint_dir_in(desc))
+			ep = gadget_find_ep_by_name(g, "ep1in");
+		else
+			ep = gadget_find_ep_by_name(g, "ep2out");
+	default:
+	}
+
+	if (ep && usb_gadget_ep_match_desc(g, ep, desc, ep_comp))
+		return ep;
+
+	return NULL;
+}
+#else
+#define musb_match_ep NULL
+#endif
+
 static int musb_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
 static int musb_gadget_stop(struct usb_gadget *g);
@@ -1697,6 +1730,7 @@ static const struct usb_gadget_ops musb_gadget_operations = {
 	.pullup			= musb_gadget_pullup,
 	.udc_start		= musb_gadget_start,
 	.udc_stop		= musb_gadget_stop,
+	.match_ep		= musb_match_ep,
 };
 
 /* ----------------------------------------------------------------------- */
-- 
1.9.1
