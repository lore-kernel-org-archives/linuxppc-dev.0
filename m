Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA6721A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:36:33 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI0167WNOTPVE0@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:36:29 +0900 (KST)
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
Subject: [PATCH v3 27/46] usb: gadget: pxa25x_udc: add ep capabilities support
Date: Wed, 15 Jul 2015 08:32:14 +0200
Message-id: <1436941953-1327-28-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/pxa25x_udc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index f6cbe66..1301e29 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1821,6 +1821,8 @@ static struct pxa25x_udc memory = {
 			.name		= ep0name,
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= EP0_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.reg_udccs	= &UDCCS0,
@@ -1833,6 +1835,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep1in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1846,6 +1850,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep2out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1861,6 +1867,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep3in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1874,6 +1882,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep4out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1888,6 +1898,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep5in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1903,6 +1915,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep6in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1916,6 +1930,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep7out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1930,6 +1946,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep8in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1943,6 +1961,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep9out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1957,6 +1977,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep10in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1972,6 +1994,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep11in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1985,6 +2009,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep12out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1999,6 +2025,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep13in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2012,6 +2040,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep14out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2026,6 +2056,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep15in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
-- 
1.9.1
