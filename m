Return-Path: <r.baldyga@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 976811A1DB4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:21:38 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS500P2G3BAGB40@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:21:21 +0900 (KST)
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
Subject: [PATCH v4 33/46] usb: isp1760: udc: add ep capabilities support
Date: Mon, 27 Jul 2015 11:16:43 +0200
Message-id: <1437988616-6962-34-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/isp1760/isp1760-udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/isp1760/isp1760-udc.c b/drivers/usb/isp1760/isp1760-udc.c
index 3699962..1c3d0fd 100644
--- a/drivers/usb/isp1760/isp1760-udc.c
+++ b/drivers/usb/isp1760/isp1760-udc.c
@@ -1383,13 +1383,24 @@ static void isp1760_udc_init_eps(struct isp1760_udc *udc)
 		 */
 		if (ep_num == 0) {
 			usb_ep_set_maxpacket_limit(&ep->ep, 64);
+			ep->ep.caps.type_control = true;
+			ep->ep.caps.dir_in = true;
+			ep->ep.caps.dir_out = true;
 			ep->maxpacket = 64;
 			udc->gadget.ep0 = &ep->ep;
 		} else {
 			usb_ep_set_maxpacket_limit(&ep->ep, 512);
+			ep->ep.caps.type_iso = true;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
 			ep->maxpacket = 0;
 			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
 		}
+
+		if (is_in)
+			ep->ep.caps.dir_in = true;
+		else
+			ep->ep.caps.dir_out = true;
 	}
 }
 
-- 
1.9.1
