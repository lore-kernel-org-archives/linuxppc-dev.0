Return-Path: <xtfeng@gmail.com>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F03B82C0106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 19:05:38 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id t11so489042daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 01:05:36 -0700 (PDT)
From: Xiaotian Feng <xtfeng@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: gadget: fsl_qe_udc: do not use tasklet_disable
 before tasklet_kill
Date: Wed, 31 Oct 2012 16:06:00 +0800
Message-Id: <1351670761-26749-2-git-send-email-xtfeng@gmail.com>
In-Reply-To: <1351670761-26749-1-git-send-email-xtfeng@gmail.com>
References: <1351670761-26749-1-git-send-email-xtfeng@gmail.com>
Cc: Xiaotian Feng <dannyfeng@tencent.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, Xiaotian Feng <xtfeng@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If tasklet_disable() is called before related tasklet handled,
tasklet_kill will never be finished. tasklet_kill is enough.

Signed-off-by: Xiaotian Feng <dannyfeng@tencent.com>
Cc: Li Yang <leoli@freescale.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/usb/gadget/fsl_qe_udc.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index b09452d..4ad3b82 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2661,7 +2661,7 @@ static int __devexit qe_udc_remove(struct platform_device *ofdev)
 	usb_del_gadget_udc(&udc->gadget);
 
 	udc->done = &done;
-	tasklet_disable(&udc->rx_tasklet);
+	tasklet_kill(&udc->rx_tasklet);
 
 	if (udc->nullmap) {
 		dma_unmap_single(udc->gadget.dev.parent,
@@ -2698,8 +2698,6 @@ static int __devexit qe_udc_remove(struct platform_device *ofdev)
 	free_irq(udc->usb_irq, udc);
 	irq_dispose_mapping(udc->usb_irq);
 
-	tasklet_kill(&udc->rx_tasklet);
-
 	iounmap(udc->usb_regs);
 
 	device_unregister(&udc->gadget.dev);
-- 
1.7.9.5
