Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12D2F1A1D9A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:22:47 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS5010W43DW1610@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:22:46 +0900 (KST)
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
Subject: [PATCH v4 44/46] usb: gadget: net2280: add net2280_match_ep() function
Date: Mon, 27 Jul 2015 11:16:54 +0200
Message-id: <1437988616-6962-45-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/epautoconf.c  | 23 +----------------------
 drivers/usb/gadget/udc/net2280.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index cc0b084..d41fd82 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -86,28 +86,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	/* First, apply chip-specific "best usage" knowledge.
 	 * This might make a good usb_gadget_ops hook ...
 	 */
-	if (gadget_is_net2280(gadget)) {
-		char name[8];
-
-		if (type == USB_ENDPOINT_XFER_INT) {
-			/* ep-e, ep-f are PIO with only 64 byte fifos */
-			ep = gadget_find_ep_by_name(gadget, "ep-e");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-			ep = gadget_find_ep_by_name(gadget, "ep-f");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-		}
-
-		/* USB3380: use same address for usb and hardware endpoints */
-		snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
-				usb_endpoint_dir_in(desc) ? "in" : "out");
-		ep = gadget_find_ep_by_name(gadget, name);
-		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
-	} else if (gadget_is_goku (gadget)) {
+	if (gadget_is_goku (gadget)) {
 		if (USB_ENDPOINT_XFER_INT == type) {
 			/* single buffering is enough */
 			ep = gadget_find_ep_by_name(gadget, "ep3-bulk");
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 0295cf7..41e6568 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -1533,6 +1533,36 @@ static int net2280_pullup(struct usb_gadget *_gadget, int is_on)
 	return 0;
 }
 
+static struct usb_ep *net2280_match_ep(struct usb_gadget *_gadget,
+		struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	char name[8];
+	struct usb_ep *ep;
+	u8 type;
+
+	type = usb_endpoint_type(desc);
+
+	if (type == USB_ENDPOINT_XFER_INT) {
+		/* ep-e, ep-f are PIO with only 64 byte fifos */
+		ep = gadget_find_ep_by_name(_gadget, "ep-e");
+		if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+			return ep;
+		ep = gadget_find_ep_by_name(_gadget, "ep-f");
+		if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+			return ep;
+	}
+
+	/* USB3380: use same address for usb and hardware endpoints */
+	snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
+			usb_endpoint_dir_in(desc) ? "in" : "out");
+	ep = gadget_find_ep_by_name(_gadget, name);
+	if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+		return ep;
+
+	return NULL;
+}
+
 static int net2280_start(struct usb_gadget *_gadget,
 		struct usb_gadget_driver *driver);
 static int net2280_stop(struct usb_gadget *_gadget);
@@ -1544,6 +1574,7 @@ static const struct usb_gadget_ops net2280_ops = {
 	.pullup		= net2280_pullup,
 	.udc_start	= net2280_start,
 	.udc_stop	= net2280_stop,
+	.match_ep	= net2280_match_ep,
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.9.1
