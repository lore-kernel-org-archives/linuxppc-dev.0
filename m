Return-Path: <r.baldyga@samsung.com>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4CFB1A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:14:51 +1000 (AEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR60018A1WPMXD0@mailout4.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 08 Jul 2015 20:14:49 +0900 (KST)
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
Subject: [PATCH 30/37] usb: gadget: s3c-hsudc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:14 +0200
Message-id: <1436353761-7107-31-git-send-email-r.baldyga@samsung.com>
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
