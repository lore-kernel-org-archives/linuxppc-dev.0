Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFAFC1A1955
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:46:01 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRH02GT01S6YY10@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Jul 2015 18:45:42 +0900 (KST)
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
Subject: [PATCH v2 45/48] usb: gadget: net2280: add net2280_match_ep() function
Date: Tue, 14 Jul 2015 11:39:33 +0200
Message-id: <1436866776-5004-46-git-send-email-r.baldyga@samsung.com>
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

Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
process. Functions does the same that was done by chip-specific code inside
of epautoconf. Now this code can be removed from there to separate generic code
from platform specific logic.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c  | 23 +--------------------
 drivers/usb/gadget/udc/net2280.c | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 7c43b7c..3ac92b4 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -98,28 +98,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	/* First, apply chip-specific "best usage" knowledge.
 	 * This might make a good usb_gadget_ops hook ...
 	 */
-	if (gadget_is_net2280(gadget)) {
-		char name[8];
-
-		if (type == USB_ENDPOINT_XFER_INT) {
-			/* ep-e, ep-f are PIO with only 64 byte fifos */
-			ep = find_ep(gadget, "ep-e");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-			ep = find_ep(gadget, "ep-f");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-		}
-
-		/* USB3380: use same address for usb and hardware endpoints */
-		snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
-				usb_endpoint_dir_in(desc) ? "in" : "out");
-		ep = find_ep(gadget, name);
-		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
-	} else if (gadget_is_goku (gadget)) {
+	if (gadget_is_goku (gadget)) {
 		if (USB_ENDPOINT_XFER_INT == type) {
 			/* single buffering is enough */
 			ep = find_ep(gadget, "ep3-bulk");
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 0295cf7..4933321 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -1533,6 +1533,49 @@ static int net2280_pullup(struct usb_gadget *_gadget, int is_on)
 	return 0;
 }
 
+static struct usb_ep *net2280_find_ep(struct usb_gadget *_gadget,
+		const char *name)
+{
+	struct usb_ep *ep;
+
+	list_for_each_entry(ep, &_gadget->ep_list, ep_list) {
+		if (0 == strcmp(ep->name, name))
+			return ep;
+	}
+
+	return NULL;
+}
+
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
+		ep = net2280_find_ep(_gadget, "ep-e");
+		if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+			return ep;
+		ep = net2280_find_ep(_gadget, "ep-f");
+		if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+			return ep;
+	}
+
+	/* USB3380: use same address for usb and hardware endpoints */
+	snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
+			usb_endpoint_dir_in(desc) ? "in" : "out");
+	ep = net2280_find_ep(_gadget, name);
+	if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+		return ep;
+
+	return NULL;
+}
+
 static int net2280_start(struct usb_gadget *_gadget,
 		struct usb_gadget_driver *driver);
 static int net2280_stop(struct usb_gadget *_gadget);
@@ -1544,6 +1587,7 @@ static const struct usb_gadget_ops net2280_ops = {
 	.pullup		= net2280_pullup,
 	.udc_start	= net2280_start,
 	.udc_stop	= net2280_stop,
+	.match_ep	= net2280_match_ep,
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.9.1
