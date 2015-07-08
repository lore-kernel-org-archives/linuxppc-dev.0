Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24AB71A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:15:16 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR600X9V1WWGPE0@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:14:56 +0900 (KST)
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
Subject: [PATCH 31/37] usb: gadget: s3c2410_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:15 +0200
Message-id: <1436353761-7107-32-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/s3c2410_udc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index 5d9aa81..eb3571e 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1691,6 +1691,8 @@ static struct s3c2410_udc memory = {
 			.name		= ep0name,
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP0_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 	},
@@ -1702,6 +1704,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep1-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1714,6 +1718,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep2-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1726,6 +1732,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep3-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1738,6 +1746,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep4-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
-- 
1.9.1
