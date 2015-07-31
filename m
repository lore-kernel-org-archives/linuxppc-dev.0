Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 517C71A1DB6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:04:44 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC030U0V3UBW60@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:04:42 +0900 (KST)
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
Subject: [PATCH v5 28/46] usb: gadget: pxa27x_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:40 +0200
Message-id: <1438351258-31578-29-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/pxa27x_udc.h | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.h b/drivers/usb/gadget/udc/pxa27x_udc.h
index 11e1423..cea2cb7 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.h
+++ b/drivers/usb/gadget/udc/pxa27x_udc.h
@@ -234,25 +234,35 @@
 /*
  * Endpoint definition helpers
  */
-#define USB_EP_DEF(addr, bname, dir, type, maxpkt) \
-{ .usb_ep = { .name = bname, .ops = &pxa_ep_ops, .maxpacket = maxpkt, }, \
+#define USB_EP_DEF(addr, bname, dir, type, maxpkt, ctype, cdir) \
+{ .usb_ep = {	.name = bname, .ops = &pxa_ep_ops, .maxpacket = maxpkt, \
+		.caps = USB_EP_CAPS(ctype, cdir), }, \
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
+	USB_EP_DEF(addr, bname, dir, BULK, BULK_FIFO_SIZE, \
+		USB_EP_CAPS_TYPE_BULK, cdir)
+#define USB_EP_ISO(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, ISOC, ISO_FIFO_SIZE, \
+		USB_EP_CAPS_TYPE_ISO, cdir)
+#define USB_EP_INT(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, INT, INT_FIFO_SIZE, \
+		USB_EP_CAPS_TYPE_INT, cdir)
+#define USB_EP_IN_BULK(n)	USB_EP_BULK(n, "ep" #n "in-bulk", 1, \
+					USB_EP_CAPS_DIR_IN)
+#define USB_EP_OUT_BULK(n)	USB_EP_BULK(n, "ep" #n "out-bulk", 0, \
+					USB_EP_CAPS_DIR_OUT)
+#define USB_EP_IN_ISO(n)	USB_EP_ISO(n,  "ep" #n "in-iso", 1, \
+					USB_EP_CAPS_DIR_IN)
+#define USB_EP_OUT_ISO(n)	USB_EP_ISO(n,  "ep" #n "out-iso", 0, \
+					USB_EP_CAPS_DIR_OUT)
+#define USB_EP_IN_INT(n)	USB_EP_INT(n,  "ep" #n "in-int", 1, \
+					USB_EP_CAPS_DIR_IN)
+#define USB_EP_CTRL	USB_EP_DEF(0,  "ep0", 0, CONTROL, EP0_FIFO_SIZE, \
+				USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_ALL)
 
 #define PXA_EP_DEF(_idx, _addr, dir, _type, maxpkt, _config, iface, altset) \
 { \
-- 
1.9.1
