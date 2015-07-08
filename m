Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 284DF1A18B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:23:53 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR601D8U1V024C0@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:13:48 +0900 (KST)
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
Subject: [PATCH 28/37] usb: gadget: pxa27x_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:12 +0200
Message-id: <1436353761-7107-29-git-send-email-r.baldyga@samsung.com>
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

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.h | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.h b/drivers/usb/gadget/udc/pxa27x_udc.h
index 11e1423..ded058c 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.h
+++ b/drivers/usb/gadget/udc/pxa27x_udc.h
@@ -234,25 +234,28 @@
 /*
  * Endpoint definition helpers
  */
-#define USB_EP_DEF(addr, bname, dir, type, maxpkt) \
-{ .usb_ep = { .name = bname, .ops = &pxa_ep_ops, .maxpacket = maxpkt, }, \
+#define USB_EP_DEF(addr, bname, dir, type, maxpkt, ctype, cdir) \
+{ .usb_ep = {	.name = bname, .ops = &pxa_ep_ops, .maxpacket = maxpkt, \
+		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## ctype, \
+				    USB_EP_CAPS_DIR_ ## cdir), }, \
   .desc = {	.bEndpointAddress = addr | (dir ? USB_DIR_IN : 0), \
-		.bmAttributes = type, \
+		.bmAttributes = USB_ENDPOINT_XFER_ ## type, \
 		.wMaxPacketSize = maxpkt, }, \
   .dev = &memory \
 }
-#define USB_EP_BULK(addr, bname, dir) \
-  USB_EP_DEF(addr, bname, dir, USB_ENDPOINT_XFER_BULK, BULK_FIFO_SIZE)
-#define USB_EP_ISO(addr, bname, dir) \
-  USB_EP_DEF(addr, bname, dir, USB_ENDPOINT_XFER_ISOC, ISO_FIFO_SIZE)
-#define USB_EP_INT(addr, bname, dir) \
-  USB_EP_DEF(addr, bname, dir, USB_ENDPOINT_XFER_INT, INT_FIFO_SIZE)
-#define USB_EP_IN_BULK(n)	USB_EP_BULK(n, "ep" #n "in-bulk", 1)
-#define USB_EP_OUT_BULK(n)	USB_EP_BULK(n, "ep" #n "out-bulk", 0)
-#define USB_EP_IN_ISO(n)	USB_EP_ISO(n,  "ep" #n "in-iso", 1)
-#define USB_EP_OUT_ISO(n)	USB_EP_ISO(n,  "ep" #n "out-iso", 0)
-#define USB_EP_IN_INT(n)	USB_EP_INT(n,  "ep" #n "in-int", 1)
-#define USB_EP_CTRL		USB_EP_DEF(0,  "ep0", 0, 0, EP0_FIFO_SIZE)
+#define USB_EP_BULK(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, BULK, BULK_FIFO_SIZE, BULK, cdir)
+#define USB_EP_ISO(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, ISOC, ISO_FIFO_SIZE, ISO, cdir)
+#define USB_EP_INT(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, INT, INT_FIFO_SIZE, INT, cdir)
+#define USB_EP_IN_BULK(n)	USB_EP_BULK(n, "ep" #n "in-bulk", 1, IN)
+#define USB_EP_OUT_BULK(n)	USB_EP_BULK(n, "ep" #n "out-bulk", 0, OUT)
+#define USB_EP_IN_ISO(n)	USB_EP_ISO(n,  "ep" #n "in-iso", 1, IN)
+#define USB_EP_OUT_ISO(n)	USB_EP_ISO(n,  "ep" #n "out-iso", 0, OUT)
+#define USB_EP_IN_INT(n)	USB_EP_INT(n,  "ep" #n "in-int", 1, IN)
+#define USB_EP_CTRL		USB_EP_DEF(0,  "ep0", 0, CONTROL, \
+					   EP0_FIFO_SIZE, CONTROL, ALL)
 
 #define PXA_EP_DEF(_idx, _addr, dir, _type, maxpkt, _config, iface, altset) \
 { \
-- 
1.9.1
