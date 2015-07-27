Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85FBB1A1BDF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:18:24 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS500HJG36CLVB0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:18:15 +0900 (KST)
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
Subject: [PATCH v4 08/46] usb: gadget: amd5536udc: add ep capabilities support
Date: Mon, 27 Jul 2015 11:16:18 +0200
Message-id: <1437988616-6962-9-git-send-email-r.baldyga@samsung.com>
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

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/amd5536udc.c | 57 ++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc.c b/drivers/usb/gadget/udc/amd5536udc.c
index de7e5e2..1a1d91c 100644
--- a/drivers/usb/gadget/udc/amd5536udc.c
+++ b/drivers/usb/gadget/udc/amd5536udc.c
@@ -138,15 +138,51 @@ static DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect,
 
 /* endpoint names used for print */
 static const char ep0_string[] = "ep0in";
-static const char *const ep_string[] = {
-	ep0_string,
-	"ep1in-int", "ep2in-bulk", "ep3in-bulk", "ep4in-bulk", "ep5in-bulk",
-	"ep6in-bulk", "ep7in-bulk", "ep8in-bulk", "ep9in-bulk", "ep10in-bulk",
-	"ep11in-bulk", "ep12in-bulk", "ep13in-bulk", "ep14in-bulk",
-	"ep15in-bulk", "ep0out", "ep1out-bulk", "ep2out-bulk", "ep3out-bulk",
-	"ep4out-bulk", "ep5out-bulk", "ep6out-bulk", "ep7out-bulk",
-	"ep8out-bulk", "ep9out-bulk", "ep10out-bulk", "ep11out-bulk",
-	"ep12out-bulk", "ep13out-bulk", "ep14out-bulk", "ep15out-bulk"
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
+
+	EP_INFO(ep0_string,	CONTROL, IN),
+	EP_INFO("ep1in-int",	BULK,	IN),
+	EP_INFO("ep2in-bulk",	BULK,	IN),
+	EP_INFO("ep3in-bulk",	BULK,	IN),
+	EP_INFO("ep4in-bulk",	BULK,	IN),
+	EP_INFO("ep5in-bulk",	BULK,	IN),
+	EP_INFO("ep6in-bulk",	BULK,	IN),
+	EP_INFO("ep7in-bulk",	BULK,	IN),
+	EP_INFO("ep8in-bulk",	BULK,	IN),
+	EP_INFO("ep9in-bulk",	BULK,	IN),
+	EP_INFO("ep10in-bulk",	BULK,	IN),
+	EP_INFO("ep11in-bulk",	BULK,	IN),
+	EP_INFO("ep12in-bulk",	BULK,	IN),
+	EP_INFO("ep13in-bulk",	BULK,	IN),
+	EP_INFO("ep14in-bulk",	BULK,	IN),
+	EP_INFO("ep15in-bulk",	BULK,	IN),
+	EP_INFO("ep0out",	CONTROL, OUT),
+	EP_INFO("ep1out-bulk",	BULK,	OUT),
+	EP_INFO("ep2out-bulk",	BULK,	OUT),
+	EP_INFO("ep3out-bulk",	BULK,	OUT),
+	EP_INFO("ep4out-bulk",	BULK,	OUT),
+	EP_INFO("ep5out-bulk",	BULK,	OUT),
+	EP_INFO("ep6out-bulk",	BULK,	OUT),
+	EP_INFO("ep7out-bulk",	BULK,	OUT),
+	EP_INFO("ep8out-bulk",	BULK,	OUT),
+	EP_INFO("ep9out-bulk",	BULK,	OUT),
+	EP_INFO("ep10out-bulk",	BULK,	OUT),
+	EP_INFO("ep11out-bulk",	BULK,	OUT),
+	EP_INFO("ep12out-bulk",	BULK,	OUT),
+	EP_INFO("ep13out-bulk",	BULK,	OUT),
+	EP_INFO("ep14out-bulk",	BULK,	OUT),
+	EP_INFO("ep15out-bulk",	BULK,	OUT),
+
+#undef EP_INFO
 };
 
 /* DMA usage flag */
@@ -1517,7 +1553,8 @@ static void udc_setup_endpoints(struct udc *dev)
 	for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
 		ep = &dev->ep[tmp];
 		ep->dev = dev;
-		ep->ep.name = ep_string[tmp];
+		ep->ep.name = ep_info[tmp].name;
+		ep->ep.caps = ep_info[tmp].caps;
 		ep->num = tmp;
 		/* txfifo size is calculated at enable time */
 		ep->txfifo = dev->txfifo;
-- 
1.9.1
