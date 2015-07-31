Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02C0D1A1D1D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:02:32 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC02TNKUZL6SA0@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:02:30 +0900 (KST)
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
Subject: [PATCH v5 10/46] usb: gadget: bcm63xx_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:22 +0200
Message-id: <1438351258-31578-11-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/bcm63xx_udc.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 9db968b..8cbb003 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -44,9 +44,29 @@
 #define DRV_MODULE_NAME		"bcm63xx_udc"
 
 static const char bcm63xx_ep0name[] = "ep0";
-static const char *const bcm63xx_ep_name[] = {
-	bcm63xx_ep0name,
-	"ep1in-bulk", "ep2out-bulk", "ep3in-int", "ep4out-int",
+
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} bcm63xx_ep_info[] = {
+#define EP_INFO(_name, _caps) \
+	{ \
+		.name = _name, \
+		.caps = _caps, \
+	}
+
+	EP_INFO(bcm63xx_ep0name,
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_ALL)),
+	EP_INFO("ep1in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep2out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep3in-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_INT, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep4out-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_INT, USB_EP_CAPS_DIR_OUT)),
+
+#undef EP_INFO
 };
 
 static bool use_fullspeed;
@@ -943,7 +963,8 @@ static int bcm63xx_init_udc_hw(struct bcm63xx_udc *udc)
 	for (i = 0; i < BCM63XX_NUM_EP; i++) {
 		struct bcm63xx_ep *bep = &udc->bep[i];
 
-		bep->ep.name = bcm63xx_ep_name[i];
+		bep->ep.name = bcm63xx_ep_info[i].name;
+		bep->ep.caps = bcm63xx_ep_info[i].caps;
 		bep->ep_num = i;
 		bep->ep.ops = &bcm63xx_udc_ep_ops;
 		list_add_tail(&bep->ep.ep_list, &udc->gadget.ep_list);
-- 
1.9.1
