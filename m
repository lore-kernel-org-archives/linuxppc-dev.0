Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E768B1A1D8A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:05:49 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC00YA6V5GL850@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:05:47 +0900 (KST)
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
Subject: [PATCH v5 37/46] usb: gadget: epautoconf: add endpoint capabilities
 flags verification
Date: Fri, 31 Jul 2015 16:00:49 +0200
Message-id: <1438351258-31578-38-git-send-email-r.baldyga@samsung.com>
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

Introduce endpoint matching mechanism basing on endpoint capabilities
flags. We check if endpoint supports transfer type and direction requested
in ep descriptor. Since we have this new endpoint matching mechanism
there is no need to have old code guessing endpoint capabilities basing
on its name, so we are getting rid of it. Remove also the obsolete comment.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 96 +++++++++++++----------------------------
 1 file changed, 30 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 8e00ca7..af4b10a 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -22,22 +22,6 @@
 
 #include "gadget_chips.h"
 
-/*
- * This should work with endpoints from controller drivers sharing the
- * same endpoint naming convention.  By example:
- *
- *	- ep1, ep2, ... address is fixed, not direction or type
- *	- ep1in, ep2out, ... address and direction are fixed, not type
- *	- ep1-bulk, ep2-bulk, ... address and type are fixed, not direction
- *	- ep1in-bulk, ep2out-iso, ... all three are fixed
- *	- ep-* ... no functionality restrictions
- *
- * Type suffixes are "-bulk", "-iso", or "-int".  Numbers are decimal.
- * Less common restrictions are implied by gadget_is_*().
- *
- * NOTE:  each endpoint is unidirectional, as specified by its USB
- * descriptor; and isn't specific to a configuration or altsetting.
- */
 static int
 ep_matches (
 	struct usb_gadget		*gadget,
@@ -47,7 +31,6 @@ ep_matches (
 )
 {
 	u8		type;
-	const char	*tmp;
 	u16		max;
 
 	int		num_req_streams = 0;
@@ -56,58 +39,39 @@ ep_matches (
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
+		/* bulk endpoints handle interrupt transfers,
+		 * except the toggle-quirky iso-synch kind
+		 */
+		if (!ep->caps.type_int && !ep->caps.type_bulk)
+			return 0;
+		/* for now, avoid PXA "interrupt-in";
+		 * it's documented as never using DATA1.
+		 */
+		if (gadget_is_pxa(gadget) && ep->caps.type_int)
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
