Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5C011A1BF1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:21:38 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS502QX23BRYR90@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:21:36 +0900 (KST)
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
Subject: [PATCH v4 35/46] usb: renesas: gadget: add ep capabilities support
Date: Mon, 27 Jul 2015 11:16:45 +0200
Message-id: <1437988616-6962-36-git-send-email-r.baldyga@samsung.com>
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

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 494dfe0..de4f97d 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1103,12 +1103,18 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		if (usbhsg_is_dcp(uep)) {
 			gpriv->gadget.ep0 = &uep->ep;
 			usb_ep_set_maxpacket_limit(&uep->ep, 64);
+			uep->ep.caps.type_control = true;
 		}
 		/* init normal pipe */
 		else {
 			usb_ep_set_maxpacket_limit(&uep->ep, 512);
+			uep->ep.caps.type_iso = true;
+			uep->ep.caps.type_bulk = true;
+			uep->ep.caps.type_int = true;
 			list_add_tail(&uep->ep.ep_list, &gpriv->gadget.ep_list);
 		}
+		uep->ep.caps.dir_in = true;
+		uep->ep.caps.dir_out = true;
 	}
 
 	ret = usb_add_gadget_udc(dev, &gpriv->gadget);
-- 
1.9.1
