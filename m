Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27DDD1A0FB8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:21:15 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS500P2G3BAGB40@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:21:14 +0900 (KST)
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
Subject: [PATCH v4 32/46] usb: gadget: udc-xilinx: add ep capabilities support
Date: Mon, 27 Jul 2015 11:16:42 +0200
Message-id: <1437988616-6962-33-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/udc-xilinx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 1f24274..1cbb0ac 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1317,12 +1317,21 @@ static void xudc_eps_init(struct xusb_udc *udc)
 			snprintf(ep->name, EPNAME_SIZE, "ep%d", ep_number);
 			ep->ep_usb.name = ep->name;
 			ep->ep_usb.ops = &xusb_ep_ops;
+
+			ep->ep_usb.caps.type_iso = true;
+			ep->ep_usb.caps.type_bulk = true;
+			ep->ep_usb.caps.type_int = true;
 		} else {
 			ep->ep_usb.name = ep0name;
 			usb_ep_set_maxpacket_limit(&ep->ep_usb, EP0_MAX_PACKET);
 			ep->ep_usb.ops = &xusb_ep0_ops;
+
+			ep->ep_usb.caps.type_control = true;
 		}
 
+		ep->ep_usb.caps.dir_in = true;
+		ep->ep_usb.caps.dir_out = true;
+
 		ep->udc = udc;
 		ep->epnumber = ep_number;
 		ep->desc = NULL;
-- 
1.9.1
