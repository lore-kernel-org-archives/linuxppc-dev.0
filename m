Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3E231A18B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:22:00 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR601FLP1RWNUB0@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:11:56 +0900 (KST)
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
Subject: [PATCH 17/37] usb: gadget: goku_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:01 +0200
Message-id: <1436353761-7107-18-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/goku_udc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 9e8d842..46b8d14 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1257,6 +1257,14 @@ static void udc_reinit (struct goku_udc *dev)
 		INIT_LIST_HEAD (&ep->queue);
 
 		ep_reset(NULL, ep);
+
+		if (i == 0)
+			ep->ep.caps.type_control = true;
+		else
+			ep->ep.caps.type_bulk = true;
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
 	}
 
 	dev->ep[0].reg_mode = NULL;
-- 
1.9.1
