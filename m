Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE7421A1A4C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:38:39 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI0047ZNSD7L80@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:38:37 +0900 (KST)
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
Subject: [PATCH v3 45/46] usb: gadget: goku_udc: add goku_match_ep() function
Date: Wed, 15 Jul 2015 08:32:32 +0200
Message-id: <1436941953-1327-46-git-send-email-r.baldyga@samsung.com>
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
