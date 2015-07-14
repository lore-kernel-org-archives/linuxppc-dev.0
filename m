Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EEB01A1A2C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 19:43:01 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRH012F11NNC910@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Jul 2015 18:42:59 +0900 (KST)
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
Subject: [PATCH v2 24/48] usb: gadget: net2280: add ep capabilities support
Date: Tue, 14 Jul 2015 11:39:12 +0200
Message-id: <1436866776-5004-25-git-send-email-r.baldyga@samsung.com>
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

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/net2280.c | 50 ++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 2bee912..0295cf7 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -74,19 +74,41 @@ static const char driver_desc[] = DRIVER_DESC;
 
 static const u32 ep_bit[9] = { 0, 17, 2, 19, 4, 1, 18, 3, 20 };
 static const char ep0name[] = "ep0";
-static const char *const ep_name[] = {
-	ep0name,
-	"ep-a", "ep-b", "ep-c", "ep-d",
-	"ep-e", "ep-f", "ep-g", "ep-h",
-};
 
-/* Endpoint names for usb3380 advance mode */
-static const char *const ep_name_adv[] = {
-	ep0name,
-	"ep1in", "ep2out", "ep3in", "ep4out",
-	"ep1out", "ep2in", "ep3out", "ep4in",
+#define EP_INFO(_name, _type, _dir) \
+	{ \
+		.name = _name, \
+		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
+				USB_EP_CAPS_DIR_ ## _dir), \
+	}
+
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info_dft[] = { /* Default endpoint configuration */
+	EP_INFO(ep0name, CONTROL, ALL),
+	EP_INFO("ep-a",		ALL,	ALL),
+	EP_INFO("ep-b",		ALL,	ALL),
+	EP_INFO("ep-c",		ALL,	ALL),
+	EP_INFO("ep-d",		ALL,	ALL),
+	EP_INFO("ep-e",		ALL,	ALL),
+	EP_INFO("ep-f",		ALL,	ALL),
+	EP_INFO("ep-g",		ALL,	ALL),
+	EP_INFO("ep-h",		ALL,	ALL),
+}, ep_info_adv[] = { /* Endpoints for usb3380 advance mode */
+	EP_INFO(ep0name, CONTROL, ALL),
+	EP_INFO("ep1in",	ALL,	IN),
+	EP_INFO("ep2out",	ALL,	OUT),
+	EP_INFO("ep3in",	ALL,	IN),
+	EP_INFO("ep4out",	ALL,	OUT),
+	EP_INFO("ep1out",	ALL,	OUT),
+	EP_INFO("ep2in",	ALL,	IN),
+	EP_INFO("ep3out",	ALL,	OUT),
+	EP_INFO("ep4in",	ALL,	IN),
 };
 
+#undef EP_INFO
+
 /* mode 0 == ep-{a,b,c,d} 1K fifo each
  * mode 1 == ep-{a,b} 2K fifo each, ep-{c,d} unavailable
  * mode 2 == ep-a 2K fifo, ep-{b,c} 1K each, ep-d unavailable
@@ -2055,7 +2077,8 @@ static void usb_reinit_228x(struct net2280 *dev)
 	for (tmp = 0; tmp < 7; tmp++) {
 		struct net2280_ep	*ep = &dev->ep[tmp];
 
-		ep->ep.name = ep_name[tmp];
+		ep->ep.name = ep_info_dft[tmp].name;
+		ep->ep.caps = ep_info_dft[tmp].caps;
 		ep->dev = dev;
 		ep->num = tmp;
 
@@ -2095,7 +2118,10 @@ static void usb_reinit_338x(struct net2280 *dev)
 	for (i = 0; i < dev->n_ep; i++) {
 		struct net2280_ep *ep = &dev->ep[i];
 
-		ep->ep.name = dev->enhanced_mode ? ep_name_adv[i] : ep_name[i];
+		ep->ep.name = dev->enhanced_mode ? ep_info_adv[i].name :
+						   ep_info_dft[i].name;
+		ep->ep.caps = dev->enhanced_mode ? ep_info_adv[i].caps :
+						   ep_info_dft[i].caps;
 		ep->dev = dev;
 		ep->num = i;
 
-- 
1.9.1
