Return-Path: <r.baldyga@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5B461A1D9C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 19:21:02 +1000 (AEST)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NS502NTM3AQFOA0@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Jul 2015 18:20:59 +0900 (KST)
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
Subject: [PATCH v4 30/46] usb: gadget: s3c-hsudc: add ep capabilities support
Date: Mon, 27 Jul 2015 11:16:40 +0200
Message-id: <1437988616-6962-31-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/s3c-hsudc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 85a712a..e9def42 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -1005,6 +1005,21 @@ static void s3c_hsudc_initep(struct s3c_hsudc *hsudc,
 	hsep->stopped = 0;
 	hsep->wedge = 0;
 
+	if (epnum == 0) {
+		hsep->ep.caps.type_control = true;
+		hsep->ep.caps.dir_in = true;
+		hsep->ep.caps.dir_out = true;
+	} else {
+		hsep->ep.caps.type_iso = true;
+		hsep->ep.caps.type_bulk = true;
+		hsep->ep.caps.type_int = true;
+	}
+
+	if (epnum & 1)
+		hsep->ep.caps.dir_in = true;
+	else
+		hsep->ep.caps.dir_out = true;
+
 	set_index(hsudc, epnum);
 	writel(hsep->ep.maxpacket, hsudc->regs + S3C_MPR);
 }
-- 
1.9.1
