Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1039B1A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:15:43 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR602PBA1Y5QR40@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:15:41 +0900 (KST)
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
Subject: [PATCH 37/37] usb: gadget: epautoconf: add endpoint capabilities flags
 verification
Date: Wed, 08 Jul 2015 13:09:21 +0200
Message-id: <1436353761-7107-38-git-send-email-r.baldyga@samsung.com>
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

Introduce endpoint matching mechanism basing on endpoint capabilities
flags. We check if endpoint supports transfer type and direction requested
in ep descriptor. Since we have this new endpoint matching mechanism
there is no need to have old code guessing endpoint capabilities basing
on its name, so we are getting rid of it.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 72 +++++++++++++----------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 8e00ca7..38df22a 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -47,7 +47,6 @@ ep_matches (
 )
 {
 	u8		type;
-	const char	*tmp;
 	u16		max;
 
 	int		num_req_streams = 0;
@@ -56,58 +55,31 @@ ep_matches (
 	if (ep->claimed)
 		return 0;
 
-	/* only support ep0 for portable CONTROL traffic */
 	type = usb_endpoint_type(desc);
-	if (USB_ENDPOINT_XFER_CONTROL == type)
-		return 0;
-
-	/* some other naming convention */
-	if ('e' != ep->name[0])
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		/* only support ep0 for portable CONTROL traffic */
 		return 0;
+	case USB_ENDPOINT_XFER_ISOC:
+		if (!ep->caps.type_iso)
+			return 0;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		if (!ep->caps.type_bulk)
+			return 0;
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		if (!ep->caps.type_int)
+			return 0;
+		break;
+	}
 
-	/* type-restriction:  "-iso", "-bulk", or "-int".
-	 * direction-restriction:  "in", "out".
-	 */
-	if ('-' != ep->name[2]) {
-		tmp = strrchr (ep->name, '-');
-		if (tmp) {
-			switch (type) {
-			case USB_ENDPOINT_XFER_INT:
-				/* bulk endpoints handle interrupt transfers,
-				 * except the toggle-quirky iso-synch kind
-				 */
-				if ('s' == tmp[2])	// == "-iso"
-					return 0;
-				/* for now, avoid PXA "interrupt-in";
-				 * it's documented as never using DATA1.
-				 */
-				if (gadget_is_pxa (gadget)
-						&& 'i' == tmp [1])
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_BULK:
-				if ('b' != tmp[1])	// != "-bulk"
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_ISOC:
-				if ('s' != tmp[2])	// != "-iso"
-					return 0;
-			}
-		} else {
-			tmp = ep->name + strlen (ep->name);
-		}
-
-		/* direction-restriction:  "..in-..", "out-.." */
-		tmp--;
-		if (!isdigit (*tmp)) {
-			if (desc->bEndpointAddress & USB_DIR_IN) {
-				if ('n' != *tmp)
-					return 0;
-			} else {
-				if ('t' != *tmp)
-					return 0;
-			}
-		}
+	if (usb_endpoint_dir_in(desc)) {
+		if (!ep->caps.dir_in)
+			return 0;
+	} else {
+		if (!ep->caps.dir_out)
+			return 0;
 	}
 
 	/*
-- 
1.9.1
