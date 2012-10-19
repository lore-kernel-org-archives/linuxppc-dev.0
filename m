Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F09CD2C033D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:25:36 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so111780bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:25:36 -0700 (PDT)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/7] usb: gadget: fsl_udc: postpone freeing current dTD
Date: Fri, 19 Oct 2012 12:24:43 +0200
Message-Id: <1350642285-8145-5-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <daniel@caiaq.de>,
 Christian Hemp <c.hemp@phytec.de>, linuxppc-dev@lists.ozlabs.org,
 Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

USB controller may access a wrong address for the dTD (endpoint transfer
descriptor) and then hang. This happens a lot when doing tests with
g_ether module and iperf, a tool for measuring maximum TCP and UDP
bandwidth.

This hardware bug is explained in detail by errata number 2858 for i.MX23:
http://cache.freescale.com/files/dsp/doc/errata/IMX23CE.pdf

All (?) SOCs with an IP from chipidea suffer from this problem.
mv_udc_core fixes this bug by commit daec765.  There still may be
unfixed drivers.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Christian Hemp <c.hemp@phytec.de>
Reviewed-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/fsl_udc_core.c |   12 +++++++++++-
 drivers/usb/gadget/fsl_usb2_udc.h |    2 ++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 53df9c0..deaab62 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -88,8 +88,13 @@ static void done(struct fsl_ep *ep, struct fsl_req *req, int status)
 		curr_td = next_td;
 		if (j != req->dtd_count - 1) {
 			next_td = curr_td->next_td_virt;
+			dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
+		} else {
+			if (udc->last_free_td != NULL)
+				dma_pool_free(udc->td_pool, udc->last_free_td,
+						udc->last_free_td->td_dma);
+			udc->last_free_td = curr_td;
 		}
-		dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
 	}
 
 	if (req->mapped) {
@@ -2439,6 +2444,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.name = driver_name;
 	udc->vbus_active = true;
+	udc->last_free_td = NULL;
 
 	/* Setup gadget.dev and register with kernel */
 	dev_set_name(&udc->gadget.dev, "gadget");
@@ -2533,6 +2539,10 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	kfree(udc->status_req);
 	kfree(udc->eps);
 
+	if (udc->last_free_td != NULL)
+		dma_pool_free(udc->td_pool, udc->last_free_td,
+			udc->last_free_td->td_dma);
+
 	dma_pool_destroy(udc->td_pool);
 	free_irq(udc->irq, udc);
 	iounmap(dr_regs);
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index f61a967..a0123ae 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -497,6 +497,8 @@ struct fsl_udc {
 	size_t ep_qh_size;		/* size after alignment adjustment*/
 	dma_addr_t ep_qh_dma;		/* dma address of QH */
 
+	struct ep_td_struct *last_free_td;
+
 	u32 max_pipes;          /* Device max pipes */
 	u32 bus_reset;		/* Device is bus resetting */
 	u32 resume_state;	/* USB state to resume */
-- 
1.7.2.5
