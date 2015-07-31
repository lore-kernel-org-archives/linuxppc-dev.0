Return-Path: <r.baldyga@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEE8A1A1C11
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:02:10 +1000 (AEST)
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSC033WAUZKQD50@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 31 Jul 2015 23:02:08 +0900 (KST)
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
Subject: [PATCH v5 07/46] usb: dwc3: gadget: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:19 +0200
Message-id: <1438351258-31578-8-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/dwc3/gadget.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2feed9e..bd4c3db 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1715,6 +1715,19 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 				return ret;
 		}
 
+		if (epnum == 0 || epnum == 1) {
+			dep->endpoint.caps.type_control = true;
+		} else {
+			dep->endpoint.caps.type_iso = true;
+			dep->endpoint.caps.type_bulk = true;
+			dep->endpoint.caps.type_int = true;
+		}
+
+		if (direction)
+			dep->endpoint.caps.dir_in = true;
+		else
+			dep->endpoint.caps.dir_out = true;
+
 		INIT_LIST_HEAD(&dep->request_list);
 		INIT_LIST_HEAD(&dep->req_queued);
 	}
-- 
1.9.1
