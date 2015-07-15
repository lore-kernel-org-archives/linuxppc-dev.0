Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4B6D1A1A3B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:38:25 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI01F9DNRXAZ90@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:38:23 +0900 (KST)
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
Subject: [PATCH v3 43/46] usb: gadget: move find_ep() from epautoconf to
 gadget.h
Date: Wed, 15 Jul 2015 08:32:30 +0200
Message-id: <1436941953-1327-44-git-send-email-r.baldyga@samsung.com>
In-reply-to: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move find_ep() function to gadget.h, rename it to gadget_find_ep_by_name()
and make it static inline. It can be used in UDC drivers, especially in
'match_ep' callback after moving chip-specific endpoint matching logic from
epautoconf to UDC drivers.

Replace all calls of find_ep() function with gadget_find_ep_by_name().

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 30 +++++++++---------------------
 include/linux/usb/gadget.h      | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 3f0a380..cc0b084 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -22,18 +22,6 @@
 
 #include "gadget_chips.h"
 
-static struct usb_ep *
-find_ep (struct usb_gadget *gadget, const char *name)
-{
-	struct usb_ep	*ep;
-
-	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		if (0 == strcmp (ep->name, name))
-			return ep;
-	}
-	return NULL;
-}
-
 /**
  * usb_ep_autoconfig_ss() - choose an endpoint matching the ep
  * descriptor and ep companion descriptor
@@ -103,11 +91,11 @@ struct usb_ep *usb_ep_autoconfig_ss(
 
 		if (type == USB_ENDPOINT_XFER_INT) {
 			/* ep-e, ep-f are PIO with only 64 byte fifos */
-			ep = find_ep(gadget, "ep-e");
+			ep = gadget_find_ep_by_name(gadget, "ep-e");
 			if (ep && usb_gadget_ep_match_desc(gadget,
 					ep, desc, ep_comp))
 				goto found_ep;
-			ep = find_ep(gadget, "ep-f");
+			ep = gadget_find_ep_by_name(gadget, "ep-f");
 			if (ep && usb_gadget_ep_match_desc(gadget,
 					ep, desc, ep_comp))
 				goto found_ep;
@@ -116,20 +104,20 @@ struct usb_ep *usb_ep_autoconfig_ss(
 		/* USB3380: use same address for usb and hardware endpoints */
 		snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
 				usb_endpoint_dir_in(desc) ? "in" : "out");
-		ep = find_ep(gadget, name);
+		ep = gadget_find_ep_by_name(gadget, name);
 		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
 	} else if (gadget_is_goku (gadget)) {
 		if (USB_ENDPOINT_XFER_INT == type) {
 			/* single buffering is enough */
-			ep = find_ep(gadget, "ep3-bulk");
+			ep = gadget_find_ep_by_name(gadget, "ep3-bulk");
 			if (ep && usb_gadget_ep_match_desc(gadget,
 					ep, desc, ep_comp))
 				goto found_ep;
 		} else if (USB_ENDPOINT_XFER_BULK == type
 				&& (USB_DIR_IN & desc->bEndpointAddress)) {
 			/* DMA may be available */
-			ep = find_ep(gadget, "ep2-bulk");
+			ep = gadget_find_ep_by_name(gadget, "ep2-bulk");
 			if (ep && usb_gadget_ep_match_desc(gadget,
 					ep, desc, ep_comp))
 				goto found_ep;
@@ -140,14 +128,14 @@ struct usb_ep *usb_ep_autoconfig_ss(
 		if ((USB_ENDPOINT_XFER_BULK == type) ||
 		    (USB_ENDPOINT_XFER_ISOC == type)) {
 			if (USB_DIR_IN & desc->bEndpointAddress)
-				ep = find_ep (gadget, "ep5in");
+				ep = gadget_find_ep_by_name(gadget, "ep5in");
 			else
-				ep = find_ep (gadget, "ep6out");
+				ep = gadget_find_ep_by_name(gadget, "ep6out");
 		} else if (USB_ENDPOINT_XFER_INT == type) {
 			if (USB_DIR_IN & desc->bEndpointAddress)
-				ep = find_ep(gadget, "ep1in");
+				ep = gadget_find_ep_by_name(gadget, "ep1in");
 			else
-				ep = find_ep(gadget, "ep2out");
+				ep = gadget_find_ep_by_name(gadget, "ep2out");
 		} else
 			ep = NULL;
 		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 77e2c1e..42e951b 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -629,6 +629,24 @@ static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
 #define gadget_for_each_ep(tmp, gadget) \
 	list_for_each_entry(tmp, &(gadget)->ep_list, ep_list)
 
+/**
+ * gadget_find_ep_by_name - returns ep whose name is the same as sting passed
+ *	in second parameter or NULL if searched endpoint not found
+ * @g: controller to check for quirk
+ * @name: name of searched endpoint
+ */
+static inline struct usb_ep *
+gadget_find_ep_by_name(struct usb_gadget *g, const char *name)
+{
+	struct usb_ep *ep;
+
+	gadget_for_each_ep(ep, g) {
+		if (!strcmp(ep->name, name))
+			return ep;
+	}
+
+	return NULL;
+}
 
 /**
  * usb_ep_align_maybe - returns @len aligned to ep's maxpacketsize if gadget
-- 
1.9.1
