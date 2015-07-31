Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C52081A1E01
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:05:27 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC00JU4V50U520@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:05:25 +0900 (KST)
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
Subject: [PATCH v5 34/46] usb: musb: gadget: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:46 +0200
Message-id: <1438351258-31578-35-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/musb/musb_gadget.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 9e18178..4150baf 100644
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
