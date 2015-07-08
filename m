Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458011A1992
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:15:44 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR6002UM1XJW2C0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:15:19 +0900 (KST)
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
Subject: [PATCH 34/37] usb: musb: gadget: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:18 +0200
Message-id: <1436353761-7107-35-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/musb/musb_gadget.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 625d482f..043248a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1729,6 +1729,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 	INIT_LIST_HEAD(&ep->end_point.ep_list);
 	if (!epnum) {
 		usb_ep_set_maxpacket_limit(&ep->end_point, 64);
+		ep->end_point.caps.type_control = true;
 		ep->end_point.ops = &musb_g_ep0_ops;
 		musb->g.ep0 = &ep->end_point;
 	} else {
@@ -1736,9 +1737,20 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 			usb_ep_set_maxpacket_limit(&ep->end_point, hw_ep->max_packet_sz_tx);
 		else
 			usb_ep_set_maxpacket_limit(&ep->end_point, hw_ep->max_packet_sz_rx);
+		ep->end_point.caps.type_iso = true;
+		ep->end_point.caps.type_bulk = true;
+		ep->end_point.caps.type_int = true;
 		ep->end_point.ops = &musb_ep_ops;
 		list_add_tail(&ep->end_point.ep_list, &musb->g.ep_list);
 	}
+
+	if (!epnum || hw_ep->is_shared_fifo) {
+		ep->end_point.caps.dir_in = true;
+		ep->end_point.caps.dir_out = true;
+	} else if (is_in)
+		ep->end_point.caps.dir_in = true;
+	else
+		ep->end_point.caps.dir_out = true;
 }
 
 /*
-- 
1.9.1
