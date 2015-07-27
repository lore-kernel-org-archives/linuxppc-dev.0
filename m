Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 275061A0EA0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:17:45 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS500BZI35EHPC0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:17:38 +0900 (KST)
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
Subject: [PATCH v4 03/46] usb: gadget: add endpoint capabilities helper macros
Date: Mon, 27 Jul 2015 11:16:13 +0200
Message-id: <1437988616-6962-4-git-send-email-r.baldyga@samsung.com>
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

Add macros useful while initializing array of endpoint capabilities
structures. These macros makes structure initialization more compact
to decrease number of code lines and increase readability of code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 include/linux/usb/gadget.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 2e85b86..c71b1de 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -158,6 +158,26 @@ struct usb_ep_caps {
 	unsigned dir_out:1;
 };
 
+#define USB_EP_CAPS_TYPE_CONTROL     0x01
+#define USB_EP_CAPS_TYPE_ISO         0x02
+#define USB_EP_CAPS_TYPE_BULK        0x04
+#define USB_EP_CAPS_TYPE_INT         0x08
+#define USB_EP_CAPS_TYPE_ALL \
+	(USB_EP_CAPS_TYPE_ISO | USB_EP_CAPS_TYPE_BULK | USB_EP_CAPS_TYPE_INT)
+#define USB_EP_CAPS_DIR_IN           0x01
+#define USB_EP_CAPS_DIR_OUT          0x02
+#define USB_EP_CAPS_DIR_ALL  (USB_EP_CAPS_DIR_IN | USB_EP_CAPS_DIR_OUT)
+
+#define USB_EP_CAPS(_type, _dir) \
+	{ \
+		.type_control = !!(_type & USB_EP_CAPS_TYPE_CONTROL), \
+		.type_iso = !!(_type & USB_EP_CAPS_TYPE_ISO), \
+		.type_bulk = !!(_type & USB_EP_CAPS_TYPE_BULK), \
+		.type_int = !!(_type & USB_EP_CAPS_TYPE_INT), \
+		.dir_in = !!(_dir & USB_EP_CAPS_DIR_IN), \
+		.dir_out = !!(_dir & USB_EP_CAPS_DIR_OUT), \
+	}
+
 /**
  * struct usb_ep - device side representation of USB endpoint
  * @name:identifier for the endpoint, such as "ep-a" or "ep9in-bulk"
-- 
1.9.1
