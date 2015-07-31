Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65D1C1A1D60
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:06:48 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC032KXV6OHC60@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:06:46 +0900 (KST)
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
Subject: [PATCH v5 45/46] usb: gadget: goku_udc: add goku_match_ep() function
Date: Fri, 31 Jul 2015 16:00:57 +0200
Message-id: <1438351258-31578-46-git-send-email-r.baldyga@samsung.com>
In-reply-to: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/epautoconf.c   | 20 ++------------------
 drivers/usb/gadget/udc/goku_udc.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index d41fd82..da45371 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -86,24 +86,8 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	/* First, apply chip-specific "best usage" knowledge.
 	 * This might make a good usb_gadget_ops hook ...
 	 */
-	if (gadget_is_goku (gadget)) {
-		if (USB_ENDPOINT_XFER_INT == type) {
-			/* single buffering is enough */
-			ep = gadget_find_ep_by_name(gadget, "ep3-bulk");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-		} else if (USB_ENDPOINT_XFER_BULK == type
-				&& (USB_DIR_IN & desc->bEndpointAddress)) {
-			/* DMA may be available */
-			ep = gadget_find_ep_by_name(gadget, "ep2-bulk");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-		}
-
 #ifdef CONFIG_BLACKFIN
-	} else if (gadget_is_musbhdrc(gadget)) {
+	if (gadget_is_musbhdrc(gadget)) {
 		if ((USB_ENDPOINT_XFER_BULK == type) ||
 		    (USB_ENDPOINT_XFER_ISOC == type)) {
 			if (USB_DIR_IN & desc->bEndpointAddress)
@@ -119,8 +103,8 @@ struct usb_ep *usb_ep_autoconfig_ss(
 			ep = NULL;
 		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
-#endif
 	}
+#endif
 
 	/* Second, look at endpoints until an unclaimed one looks usable */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 46b8d14..d5a93ea 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -990,6 +990,30 @@ static int goku_get_frame(struct usb_gadget *_gadget)
 	return -EOPNOTSUPP;
 }
 
+static struct usb_ep *goku_match_ep(struct usb_gadget *g,
+		struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	struct goku_udc	*dev = to_goku_udc(g);
+	struct usb_ep *ep;
+	u8 type = usb_endpoint_type(desc);
+
+	if (type == USB_ENDPOINT_XFER_INT) {
+		/* single buffering is enough */
+		ep = &dev->ep[3].ep;
+		if (ep && usb_gadget_ep_match_desc(g, ep, desc, ep_comp))
+			return ep;
+	} else if (type == USB_ENDPOINT_XFER_BULK
+			&& usb_endpoint_dir_in(desc)) {
+		/* DMA may be available */
+		ep = &dev->ep[2].ep;
+		if (ep && usb_gadget_ep_match_desc(g, ep, desc, ep_comp))
+			return ep;
+	}
+
+	return NULL;
+}
+
 static int goku_udc_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
 static int goku_udc_stop(struct usb_gadget *g);
@@ -998,6 +1022,7 @@ static const struct usb_gadget_ops goku_ops = {
 	.get_frame	= goku_get_frame,
 	.udc_start	= goku_udc_start,
 	.udc_stop	= goku_udc_stop,
+	.match_ep	= goku_match_ep,
 	// no remote wakeup
 	// not selfpowered
 };
-- 
1.9.1
