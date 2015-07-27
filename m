Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EDCF1A1A29
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:22:03 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS502C7S3CPXSD0@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:22:01 +0900 (KST)
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
Subject: [PATCH v4 38/46] usb: gadget: epautoconf: remove pxa quirk from
 ep_matches()
Date: Mon, 27 Jul 2015 11:16:48 +0200
Message-id: <1437988616-6962-39-git-send-email-r.baldyga@samsung.com>
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

The same effect can be achieved by using capabilities flags, so now we can
get rid of handling of hardware specific limitations in generic code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c     | 5 -----
 drivers/usb/gadget/udc/pxa25x_udc.c | 9 +++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index af4b10a..4f66e9d73 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -58,11 +58,6 @@ ep_matches (
 		 */
 		if (!ep->caps.type_int && !ep->caps.type_bulk)
 			return 0;
-		/* for now, avoid PXA "interrupt-in";
-		 * it's documented as never using DATA1.
-		 */
-		if (gadget_is_pxa(gadget) && ep->caps.type_int)
-			return 0;
 		break;
 	}
 
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 1301e29..f53e526 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1898,8 +1898,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep5in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1977,8 +1976,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep10in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -2056,8 +2054,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep15in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
-- 
1.9.1
