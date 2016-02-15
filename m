Return-Path: <a.hajda@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 948871A034B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 01:46:51 +1100 (AEDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O2L00BCUF982A40@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 15 Feb 2016 14:36:44 +0000 (GMT)
From: Andrzej Hajda <a.hajda@samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Li Yang <leoli@freescale.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/7] usb: gadget: fsl_qe_udc: fix IS_ERR_VALUE usage
Date: Mon, 15 Feb 2016 15:35:25 +0100
Message-id: <1455546925-22119-8-git-send-email-a.hajda@samsung.com>
In-reply-to: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IS_ERR_VALUE macro should be used only with unsigned long type.
Otherwise it can work incorrectly.

The patch follows conclusion from discussion on LKML [1][2].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2120927
[2]: http://permalink.gmane.org/gmane.linux.kernel/2150581

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 53c0692..93d28cb 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -2340,7 +2340,7 @@ static struct qe_udc *qe_udc_config(struct platform_device *ofdev)
 {
 	struct qe_udc *udc;
 	struct device_node *np = ofdev->dev.of_node;
-	unsigned int tmp_addr = 0;
+	unsigned long tmp_addr = 0;
 	struct usb_device_para __iomem *usbpram;
 	unsigned int i;
 	u64 size;
-- 
1.9.1
