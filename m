Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C55F1A19E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 16:35:49 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NRI01HHRNNNWQ80@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 15 Jul 2015 15:35:47 +0900 (KST)
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
Subject: [PATCH v3 21/46] usb: gadget: mv_u3d_core: add ep capabilities support
Date: Wed, 15 Jul 2015 08:32:08 +0200
Message-id: <1436941953-1327-22-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/mv_u3d_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index ea35a24..4c48969 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -1324,6 +1324,9 @@ static int mv_u3d_eps_init(struct mv_u3d *u3d)
 	ep->ep.ops = &mv_u3d_ep_ops;
 	ep->wedge = 0;
 	usb_ep_set_maxpacket_limit(&ep->ep, MV_U3D_EP0_MAX_PKT_SIZE);
+	ep->ep.caps.type_control = true;
+	ep->ep.caps.dir_in = true;
+	ep->ep.caps.dir_out = true;
 	ep->ep_num = 0;
 	ep->ep.desc = &mv_u3d_ep0_desc;
 	INIT_LIST_HEAD(&ep->queue);
@@ -1339,14 +1342,20 @@ static int mv_u3d_eps_init(struct mv_u3d *u3d)
 		if (i & 1) {
 			snprintf(name, sizeof(name), "ep%din", i >> 1);
 			ep->direction = MV_U3D_EP_DIR_IN;
+			ep->ep.caps.dir_in = true;
 		} else {
 			snprintf(name, sizeof(name), "ep%dout", i >> 1);
 			ep->direction = MV_U3D_EP_DIR_OUT;
+			ep->ep.caps.dir_out = true;
 		}
 		ep->u3d = u3d;
 		strncpy(ep->name, name, sizeof(ep->name));
 		ep->ep.name = ep->name;
 
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
+
 		ep->ep.ops = &mv_u3d_ep_ops;
 		usb_ep_set_maxpacket_limit(&ep->ep, (unsigned short) ~0);
 		ep->ep_num = i / 2;
-- 
1.9.1
