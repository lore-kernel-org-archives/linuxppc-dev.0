Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 613591A1DA8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:06:04 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC02N2EV5YTYC0@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:06:02 +0900 (KST)
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
Subject: [PATCH v5 39/46] usb: gadget: epautoconf: remove ep and desc
 configuration from ep_matches()
Date: Fri, 31 Jul 2015 16:00:51 +0200
Message-id: <1438351258-31578-40-git-send-email-r.baldyga@samsung.com>
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

As function ep_matches() is used to match endpoint with usb descriptor it's
highly unintuitive that it modifies endpoint and descriptor structures fields.
This patch moves code configuring ep and desc from ep_matches() to
usb_ep_autoconfig_ss(), so now function ep_matches() does nothing more than
its name suggests.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 66 +++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4f66e9d73..7bb28f1 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -82,13 +82,6 @@ ep_matches (
 
 	}
 
-	/*
-	 * If the protocol driver hasn't yet decided on wMaxPacketSize
-	 * and wants to know the maximum possible, provide the info.
-	 */
-	if (desc->wMaxPacketSize == 0)
-		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
-
 	/* endpoint maxpacket size is an input parameter, except for bulk
 	 * where it's an output parameter representing the full speed limit.
 	 * the usb spec fixes high speed bulk maxpacket at 512 bytes.
@@ -119,31 +112,6 @@ ep_matches (
 
 	/* MATCH!! */
 
-	/* report address */
-	desc->bEndpointAddress &= USB_DIR_IN;
-	if (isdigit (ep->name [2])) {
-		u8	num = simple_strtoul (&ep->name [2], NULL, 10);
-		desc->bEndpointAddress |= num;
-	} else if (desc->bEndpointAddress & USB_DIR_IN) {
-		if (++gadget->in_epnum > 15)
-			return 0;
-		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
-	} else {
-		if (++gadget->out_epnum > 15)
-			return 0;
-		desc->bEndpointAddress |= gadget->out_epnum;
-	}
-
-	/* report (variable) full speed bulk maxpacket */
-	if ((USB_ENDPOINT_XFER_BULK == type) && !ep_comp) {
-		int size = ep->maxpacket_limit;
-
-		/* min() doesn't work on bitfields with gcc-3.5 */
-		if (size > 64)
-			size = 64;
-		desc->wMaxPacketSize = cpu_to_le16(size);
-	}
-	ep->address = desc->bEndpointAddress;
 	return 1;
 }
 
@@ -280,6 +248,40 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	/* Fail */
 	return NULL;
 found_ep:
+
+	/*
+	 * If the protocol driver hasn't yet decided on wMaxPacketSize
+	 * and wants to know the maximum possible, provide the info.
+	 */
+	if (desc->wMaxPacketSize == 0)
+		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
+
+	/* report address */
+	desc->bEndpointAddress &= USB_DIR_IN;
+	if (isdigit(ep->name[2])) {
+		u8 num = simple_strtoul(&ep->name[2], NULL, 10);
+		desc->bEndpointAddress |= num;
+	} else if (desc->bEndpointAddress & USB_DIR_IN) {
+		if (++gadget->in_epnum > 15)
+			return 0;
+		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
+	} else {
+		if (++gadget->out_epnum > 15)
+			return 0;
+		desc->bEndpointAddress |= gadget->out_epnum;
+	}
+
+	/* report (variable) full speed bulk maxpacket */
+	if ((type == USB_ENDPOINT_XFER_BULK) && !ep_comp) {
+		int size = ep->maxpacket_limit;
+
+		/* min() doesn't work on bitfields with gcc-3.5 */
+		if (size > 64)
+			size = 64;
+		desc->wMaxPacketSize = cpu_to_le16(size);
+	}
+
+	ep->address = desc->bEndpointAddress;
 	ep->desc = NULL;
 	ep->comp_desc = NULL;
 	ep->claimed = true;
-- 
1.9.1
