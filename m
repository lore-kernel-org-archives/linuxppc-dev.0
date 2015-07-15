Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 567991A08B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:33:35 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI01EV9NJCFO80@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:33:12 +0900 (KST)
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
Subject: [PATCH v3 02/46] usb: gadget: add endpoint capabilities flags
Date: Wed, 15 Jul 2015 08:31:49 +0200
Message-id: <1436941953-1327-3-git-send-email-r.baldyga@samsung.com>
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

Introduce struct usb_ep_caps which contains information about capabilities
of usb endpoints - supported transfer types and directions. This structure
should be filled by UDC driver for each of its endpoints, and will be
used in epautoconf in new ep matching mechanism which will replace ugly
guessing of endpoint capabilities basing on its name.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 include/linux/usb/gadget.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index fcb0a4e..6f3e0fb 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -141,10 +141,29 @@ struct usb_ep_ops {
 };
 
 /**
+ * struct usb_ep_caps - endpoint capabilities description
+ * @type_control:Endpoint supports control type (reserved for ep0).
+ * @type_iso:Endpoint supports isochronous transfers.
+ * @type_bulk:Endpoint supports bulk transfers.
+ * @type_int:Endpoint supports interrupt transfers.
+ * @dir_in:Endpoint supports IN direction.
+ * @dir_out:Endpoint supports OUT direction.
+ */
+struct usb_ep_caps {
+	unsigned type_control:1;
+	unsigned type_iso:1;
+	unsigned type_bulk:1;
+	unsigned type_int:1;
+	unsigned dir_in:1;
+	unsigned dir_out:1;
+};
+
+/**
  * struct usb_ep - device side representation of USB endpoint
  * @name:identifier for the endpoint, such as "ep-a" or "ep9in-bulk"
  * @ops: Function pointers used to access hardware-specific operations.
  * @ep_list:the gadget's ep_list holds all of its endpoints
+ * @caps:The structure describing types and directions supported by endoint.
  * @maxpacket:The maximum packet size used on this endpoint.  The initial
  *	value can sometimes be reduced (hardware allowing), according to
  *      the endpoint descriptor used to configure the endpoint.
@@ -167,12 +186,14 @@ struct usb_ep_ops {
  * gadget->ep_list.  the control endpoint (gadget->ep0) is not in that list,
  * and is accessed only in response to a driver setup() callback.
  */
+
 struct usb_ep {
 	void			*driver_data;
 
 	const char		*name;
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
+	struct usb_ep_caps	caps;
 	bool			claimed;
 	unsigned		maxpacket:16;
 	unsigned		maxpacket_limit:16;
-- 
1.9.1
