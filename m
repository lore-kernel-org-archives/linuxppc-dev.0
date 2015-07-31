Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 663E31A1D81
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:04:22 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC02TQ5V386SA0@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:04:20 +0900 (KST)
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
Subject: [PATCH v5 25/46] usb: gadget: omap_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:37 +0200
Message-id: <1438351258-31578-26-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/omap_udc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index e2fcdb8..9b7d394 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2579,6 +2579,28 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	ep->double_buf = dbuf;
 	ep->udc = udc;
 
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		ep->ep.caps.type_control = true;
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		ep->ep.caps.type_iso = true;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		ep->ep.caps.type_bulk = true;
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		ep->ep.caps.type_int = true;
+		break;
+	};
+
+	if (addr & USB_DIR_IN)
+		ep->ep.caps.dir_in = true;
+	else
+		ep->ep.caps.dir_out = true;
+
 	ep->ep.name = ep->name;
 	ep->ep.ops = &omap_ep_ops;
 	ep->maxpacket = maxp;
-- 
1.9.1
