Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B429E1A1944
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:34:38 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI01E0XNLHFO90@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:34:29 +0900 (KST)
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
Subject: [PATCH v3 10/46] usb: gadget: bcm63xx_udc: add ep capabilities support
Date: Wed, 15 Jul 2015 08:31:57 +0200
Message-id: <1436941953-1327-11-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/bcm63xx_udc.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 9db968b..c5e0894 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -44,9 +44,25 @@
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
+#define EP_INFO(_name, _type, _dir) \
+	{ \
+		.name = _name, \
+		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
+				USB_EP_CAPS_DIR_ ## _dir), \
+	}
+
+	EP_INFO(bcm63xx_ep0name, CONTROL, ALL),
+	EP_INFO("ep1in-bulk",	BULK,	IN),
+	EP_INFO("ep2out-bulk",	BULK,	OUT),
+	EP_INFO("ep3in-int",	INT,	IN),
+	EP_INFO("ep4out-int",	INT,	OUT),
+
+#undef EP_INFO
 };
 
 static bool use_fullspeed;
@@ -943,7 +959,8 @@ static int bcm63xx_init_udc_hw(struct bcm63xx_udc *udc)
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
