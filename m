Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AB991A0F93
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:34:45 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI01E21NLVFO90@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:34:43 +0900 (KST)
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
Subject: [PATCH v3 12/46] usb: gadget: dummy-hcd: add ep capabilities support
Date: Wed, 15 Jul 2015 08:31:59 +0200
Message-id: <1436941953-1327-13-git-send-email-r.baldyga@samsung.com>
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

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 65 +++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 181112c..69fd29a 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -127,23 +127,57 @@ static inline struct dummy_request *usb_request_to_dummy_request
 
 static const char ep0name[] = "ep0";
 
-static const char *const ep_name[] = {
-	ep0name,				/* everyone has ep0 */
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[] = {
+#define EP_INFO(_name, _type, _dir) \
+	{ \
+		.name = _name, \
+		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
+				USB_EP_CAPS_DIR_ ## _dir), \
+	}
 
+	/* everyone has ep0 */
+	EP_INFO(ep0name,	CONTROL, ALL),
 	/* act like a pxa250: fifteen fixed function endpoints */
-	"ep1in-bulk", "ep2out-bulk", "ep3in-iso", "ep4out-iso", "ep5in-int",
-	"ep6in-bulk", "ep7out-bulk", "ep8in-iso", "ep9out-iso", "ep10in-int",
-	"ep11in-bulk", "ep12out-bulk", "ep13in-iso", "ep14out-iso",
-		"ep15in-int",
-
+	EP_INFO("ep1in-bulk",	BULK,	IN),
+	EP_INFO("ep2out-bulk",	BULK,	OUT),
+	EP_INFO("ep3in-iso",	ISO,	IN),
+	EP_INFO("ep4out-iso",	ISO,	OUT),
+	EP_INFO("ep5in-int",	INT,	IN),
+	EP_INFO("ep6in-bulk",	BULK,	IN),
+	EP_INFO("ep7out-bulk",	BULK,	OUT),
+	EP_INFO("ep8in-iso",	ISO,	IN),
+	EP_INFO("ep9out-iso",	ISO,	OUT),
+	EP_INFO("ep10in-int",	INT,	IN),
+	EP_INFO("ep11in-bulk",	BULK,	IN),
+	EP_INFO("ep12out-bulk",	BULK,	OUT),
+	EP_INFO("ep13in-iso",	ISO,	IN),
+	EP_INFO("ep14out-iso",	ISO,	OUT),
+	EP_INFO("ep15in-int",	INT,	IN),
 	/* or like sa1100: two fixed function endpoints */
-	"ep1out-bulk", "ep2in-bulk",
-
+	EP_INFO("ep1out-bulk",	BULK,	OUT),
+	EP_INFO("ep2in-bulk",	BULK,	IN),
 	/* and now some generic EPs so we have enough in multi config */
-	"ep3out", "ep4in", "ep5out", "ep6out", "ep7in", "ep8out", "ep9in",
-	"ep10out", "ep11out", "ep12in", "ep13out", "ep14in", "ep15out",
+	EP_INFO("ep3out",	ALL,	OUT),
+	EP_INFO("ep4in",	ALL,	IN),
+	EP_INFO("ep5out",	ALL,	OUT),
+	EP_INFO("ep6out",	ALL,	OUT),
+	EP_INFO("ep7in",	ALL,	IN),
+	EP_INFO("ep8out",	ALL,	OUT),
+	EP_INFO("ep9in",	ALL,	IN),
+	EP_INFO("ep10out",	ALL,	OUT),
+	EP_INFO("ep11out",	ALL,	OUT),
+	EP_INFO("ep12in",	ALL,	IN),
+	EP_INFO("ep13out",	ALL,	OUT),
+	EP_INFO("ep14in",	ALL,	IN),
+	EP_INFO("ep15out",	ALL,	OUT),
+
+#undef EP_INFO
 };
-#define DUMMY_ENDPOINTS	ARRAY_SIZE(ep_name)
+
+#define DUMMY_ENDPOINTS	ARRAY_SIZE(ep_info)
 
 /*-------------------------------------------------------------------------*/
 
@@ -938,9 +972,10 @@ static void init_dummy_udc_hw(struct dummy *dum)
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
@@ -1684,7 +1719,7 @@ static void dummy_timer(unsigned long _dum_hcd)
 	}
 
 	for (i = 0; i < DUMMY_ENDPOINTS; i++) {
-		if (!ep_name[i])
+		if (!ep_info[i].name)
 			break;
 		dum->ep[i].already_seen = 0;
 	}
-- 
1.9.1
