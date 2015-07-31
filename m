Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 942A31A1BDA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:02:40 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC00JQHV0DU520@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:02:37 +0900 (KST)
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
Subject: [PATCH v5 11/46] usb: gadget: bdc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:23 +0200
Message-id: <1438351258-31578-12-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/bdc/bdc_ep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index b04980c..f9a8f57 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -1952,12 +1952,18 @@ static int init_ep(struct bdc *bdc, u32 epnum, u32 dir)
 	ep->bdc = bdc;
 	ep->dir = dir;
 
+	if (dir)
+		ep->usb_ep.caps.dir_in = true;
+	else
+		ep->usb_ep.caps.dir_out = true;
+
 	/* ep->ep_num is the index inside bdc_ep */
 	if (epnum == 1) {
 		ep->ep_num = 1;
 		bdc->bdc_ep_array[ep->ep_num] = ep;
 		snprintf(ep->name, sizeof(ep->name), "ep%d", epnum - 1);
 		usb_ep_set_maxpacket_limit(&ep->usb_ep, EP0_MAX_PKT_SIZE);
+		ep->usb_ep.caps.type_control = true;
 		ep->comp_desc = NULL;
 		bdc->gadget.ep0 = &ep->usb_ep;
 	} else {
@@ -1971,6 +1977,9 @@ static int init_ep(struct bdc *bdc, u32 epnum, u32 dir)
 			 dir & 1 ? "in" : "out");
 
 		usb_ep_set_maxpacket_limit(&ep->usb_ep, 1024);
+		ep->usb_ep.caps.type_iso = true;
+		ep->usb_ep.caps.type_bulk = true;
+		ep->usb_ep.caps.type_int = true;
 		ep->usb_ep.max_streams = 0;
 		list_add_tail(&ep->usb_ep.ep_list, &bdc->gadget.ep_list);
 	}
-- 
1.9.1
