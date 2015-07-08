Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5B4E1A18B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:20:18 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR6034NW1P2EQD0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:10:14 +0900 (KST)
From: Robert Baldyga <r.baldyga@samsung.com>
To: gregkh@linuxfoundation.org
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, balbi@ti.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com,
 Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 04/37] staging: emxx_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:08:48 +0200
Message-id: <1436353761-7107-5-git-send-email-r.baldyga@samsung.com>
In-reply-to: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert endpoint configuration to new capabilities model.

Fixed typo in "epc-nulk" to "epc-bulk".

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 60 ++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3b7aa36..0d64bee 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -3153,36 +3153,33 @@ static const struct usb_gadget_ops nbu2ss_gadget_ops = {
 	.ioctl			= nbu2ss_gad_ioctl,
 };
 
-static const char g_ep0_name[] = "ep0";
-static const char g_ep1_name[] = "ep1-bulk";
-static const char g_ep2_name[] = "ep2-bulk";
-static const char g_ep3_name[] = "ep3in-int";
-static const char g_ep4_name[] = "ep4-iso";
-static const char g_ep5_name[] = "ep5-iso";
-static const char g_ep6_name[] = "ep6-bulk";
-static const char g_ep7_name[] = "ep7-bulk";
-static const char g_ep8_name[] = "ep8in-int";
-static const char g_ep9_name[] = "ep9-iso";
-static const char g_epa_name[] = "epa-iso";
-static const char g_epb_name[] = "epb-bulk";
-static const char g_epc_name[] = "epc-nulk";
-static const char g_epd_name[] = "epdin-int";
-
-static const char *gp_ep_name[NUM_ENDPOINTS] = {
-	g_ep0_name,
-	g_ep1_name,
-	g_ep2_name,
-	g_ep3_name,
-	g_ep4_name,
-	g_ep5_name,
-	g_ep6_name,
-	g_ep7_name,
-	g_ep8_name,
-	g_ep9_name,
-	g_epa_name,
-	g_epb_name,
-	g_epc_name,
-	g_epd_name,
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[NUM_ENDPOINTS] = {
+#define EP_INFO(_name, _type, _dir) \
+	{ \
+		.name = _name, \
+		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
+				USB_EP_CAPS_DIR_ ## _dir), \
+	}
+
+	EP_INFO("ep0",		CONTROL, ALL),
+	EP_INFO("ep1-bulk",	BULK,	ALL),
+	EP_INFO("ep2-bulk",	BULK,	ALL),
+	EP_INFO("ep3in-int",	INT,	IN),
+	EP_INFO("ep4-iso",	INT,	ALL),
+	EP_INFO("ep5-iso",	ISO,	ALL),
+	EP_INFO("ep6-bulk",	ISO,	ALL),
+	EP_INFO("ep7-bulk",	BULK,	ALL),
+	EP_INFO("ep8in-int",	INT,	IN),
+	EP_INFO("ep9-iso",	ISO,	ALL),
+	EP_INFO("epa-iso",	ISO,	ALL),
+	EP_INFO("epb-bulk",	BULK,	ALL),
+	EP_INFO("epc-bulk",	BULK,	ALL),
+	EP_INFO("epdin-int",	INT,	IN),
+
+#undef EP_INFO
 };
 
 /*-------------------------------------------------------------------------*/
@@ -3200,7 +3197,8 @@ static void __init nbu2ss_drv_ep_init(struct nbu2ss_udc *udc)
 		ep->desc = NULL;
 
 		ep->ep.driver_data = NULL;
-		ep->ep.name = gp_ep_name[i];
+		ep->ep.name = ep_info[i].name;
+		ep->ep.caps = ep_info[i].caps;
 		ep->ep.ops = &nbu2ss_ep_ops;
 
 		usb_ep_set_maxpacket_limit(&ep->ep,
-- 
1.9.1
