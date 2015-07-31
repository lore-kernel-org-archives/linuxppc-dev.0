Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD5871A1C06
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:04:38 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC0335YV3M5N60@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:04:34 +0900 (KST)
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
Subject: [PATCH v5 27/46] usb: gadget: pxa25x_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:39 +0200
Message-id: <1438351258-31578-28-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/pxa25x_udc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 27f9442..b4d25dc 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1822,6 +1822,8 @@ static struct pxa25x_udc memory = {
 			.name		= ep0name,
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= EP0_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.reg_udccs	= &UDCCS0,
@@ -1834,6 +1836,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep1in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1847,6 +1851,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep2out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1862,6 +1868,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep3in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1875,6 +1883,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep4out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1889,6 +1899,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep5in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1904,6 +1916,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep6in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1917,6 +1931,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep7out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1931,6 +1947,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep8in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1944,6 +1962,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep9out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1958,6 +1978,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep10in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1973,6 +1995,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep11in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1986,6 +2010,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep12out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -2000,6 +2026,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep13in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2013,6 +2041,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep14out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2027,6 +2057,8 @@ static struct pxa25x_udc memory = {
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
