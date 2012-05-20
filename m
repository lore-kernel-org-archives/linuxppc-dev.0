Return-Path: <chf.fritz@googlemail.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6DD6B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 09:17:34 +1000 (EST)
Received: by werh12 with SMTP id h12so2981658wer.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2012 16:17:30 -0700 (PDT)
Date: Mon, 21 May 2012 01:17:24 +0200
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Li Yang <leoli@freescale.com>, Felipe Balbi <balbi@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>
Subject: [PATCH] usb: fsl_udc: errata - postpone freeing current dTD
Message-ID: <20120520231724.GA7941@mars>
References: <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter>
 <20120514042142.GD9750@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120514042142.GD9750@kroah.com>
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-usb@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Ido Shayevitz <idos@codeaurora.org>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Daniel Mack <daniel@caiaq.de>, Christian Hemp <c.hemp@phytec.de>,
 Russell King <linux@arm.linux.org.uk>, Neil Zhang <zhangwm@marvell.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
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

mv_udc_core fixes this bug by commit daec765. There still may be unfixed
drivers.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 drivers/usb/gadget/fsl_udc_core.c |   22 ++++++++++++++++++++++
 drivers/usb/gadget/fsl_usb2_udc.h |    6 ++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 55abfb6..f9bfafd 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -65,6 +65,9 @@ static struct usb_sys_interface *usb_sys_regs;
 /* it is initialized in probe()  */
 static struct fsl_udc *udc_controller = NULL;
 
+#ifdef POSTPONE_FREE_LAST_DTD
+static struct ep_td_struct *last_free_td;
+#endif
 static const struct usb_endpoint_descriptor
 fsl_ep0_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
@@ -180,8 +183,18 @@ static void done(struct fsl_ep *ep, struct fsl_req *req, int status)
 		curr_td = next_td;
 		if (j != req->dtd_count - 1) {
 			next_td = curr_td->next_td_virt;
+#ifdef POSTPONE_FREE_LAST_DTD
+			dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
+		} else {
+			if (last_free_td != NULL)
+				dma_pool_free(udc->td_pool, last_free_td,
+						last_free_td->td_dma);
+			last_free_td = curr_td;
+		}
+#else
 		}
 		dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
+#endif
 	}
 
 	if (req->mapped) {
@@ -2579,6 +2592,10 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		goto err_unregister;
 	}
 
+#ifdef POSTPONE_FREE_LAST_DTD
+	last_free_td = NULL;
+#endif
+
 	ret = usb_add_gadget_udc(&pdev->dev, &udc_controller->gadget);
 	if (ret)
 		goto err_del_udc;
@@ -2633,6 +2650,11 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	kfree(udc_controller->status_req);
 	kfree(udc_controller->eps);
 
+#ifdef POSTPONE_FREE_LAST_DTD
+	if (last_free_td != NULL)
+		dma_pool_free(udc_controller->td_pool, last_free_td,
+				last_free_td->td_dma);
+#endif
 	dma_pool_destroy(udc_controller->td_pool);
 	free_irq(udc_controller->irq, udc_controller);
 	iounmap(dr_regs);
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index e651469..03ae07f 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -4,6 +4,12 @@
 #ifndef __FSL_USB2_UDC_H
 #define __FSL_USB2_UDC_H
 
+#if defined CONFIG_ARCH_MX51 || defined CONFIG_SOC_IMX35
+#define POSTPONE_FREE_LAST_DTD
+#else
+#undef POSTPONE_FREE_LAST_DTD
+#endif
+
 /* ### define USB registers here
  */
 #define USB_MAX_CTRL_PAYLOAD		64
-- 
1.7.2.5
