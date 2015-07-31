Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 688B31A1A4C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:02:47 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC00JQHV0DU520@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:02:45 +0900 (KST)
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
Subject: [PATCH v5 12/46] usb: gadget: dummy-hcd: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:24 +0200
Message-id: <1438351258-31578-13-git-send-email-r.baldyga@samsung.com>
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

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 95 ++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 181112c..1379ad4 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -127,23 +127,87 @@ static inline struct dummy_request *usb_request_to_dummy_request
 
 static const char ep0name[] = "ep0";
 
-static const char *const ep_name[] = {
-	ep0name,				/* everyone has ep0 */
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[] = {
+#define EP_INFO(_name, _caps) \
+	{ \
+		.name = _name, \
+		.caps = _caps, \
+	}
 
+	/* everyone has ep0 */
+	EP_INFO(ep0name,
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_ALL)),
 	/* act like a pxa250: fifteen fixed function endpoints */
-	"ep1in-bulk", "ep2out-bulk", "ep3in-iso", "ep4out-iso", "ep5in-int",
-	"ep6in-bulk", "ep7out-bulk", "ep8in-iso", "ep9out-iso", "ep10in-int",
-	"ep11in-bulk", "ep12out-bulk", "ep13in-iso", "ep14out-iso",
-		"ep15in-int",
-
+	EP_INFO("ep1in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep2out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep3in-iso",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep4out-iso",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep5in-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_INT, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep6in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep7out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep8in-iso",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep9out-iso",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep10in-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_INT, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep11in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep12out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep13in-iso",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep14out-iso",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep15in-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_INT, USB_EP_CAPS_DIR_IN)),
 	/* or like sa1100: two fixed function endpoints */
-	"ep1out-bulk", "ep2in-bulk",
-
+	EP_INFO("ep1out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep2in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
 	/* and now some generic EPs so we have enough in multi config */
-	"ep3out", "ep4in", "ep5out", "ep6out", "ep7in", "ep8out", "ep9in",
-	"ep10out", "ep11out", "ep12in", "ep13out", "ep14in", "ep15out",
+	EP_INFO("ep3out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep4in",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep5out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep6out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep7in",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep8out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep9in",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep10out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep11out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep12in",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep13out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep14in",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep15out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_ALL, USB_EP_CAPS_DIR_OUT)),
+
+#undef EP_INFO
 };
-#define DUMMY_ENDPOINTS	ARRAY_SIZE(ep_name)
+
+#define DUMMY_ENDPOINTS	ARRAY_SIZE(ep_info)
 
 /*-------------------------------------------------------------------------*/
 
@@ -938,9 +1002,10 @@ static void init_dummy_udc_hw(struct dummy *dum)
 	for (i = 0; i < DUMMY_ENDPOINTS; i++) {
 		struct dummy_ep	*ep = &dum->ep[i];
 
-		if (!ep_name[i])
+		if (!ep_info[i].name)
 			break;
-		ep->ep.name = ep_name[i];
+		ep->ep.name = ep_info[i].name;
+		ep->ep.caps = ep_info[i].caps;
 		ep->ep.ops = &dummy_ep_ops;
 		list_add_tail(&ep->ep.ep_list, &dum->gadget.ep_list);
 		ep->halted = ep->wedged = ep->already_seen =
@@ -1684,7 +1749,7 @@ static void dummy_timer(unsigned long _dum_hcd)
 	}
 
 	for (i = 0; i < DUMMY_ENDPOINTS; i++) {
-		if (!ep_name[i])
+		if (!ep_info[i].name)
 			break;
 		dum->ep[i].already_seen = 0;
 	}
-- 
1.9.1
