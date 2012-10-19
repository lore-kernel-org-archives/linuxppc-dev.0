Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9805A2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:25:17 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so111780bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:25:14 -0700 (PDT)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/7] usb: gadget: fsl_udc: simplify driver init
Date: Fri, 19 Oct 2012 12:24:39 +0200
Message-Id: <1350642285-8145-1-git-send-email-chf.fritz@googlemail.com>
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

To initialize this driver use 'module_platform_driver' instead
of '__init' and '__exit'.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/usb/gadget/fsl_udc_core.c |   37 +++++++++++--------------------------
 1 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 6ae70cb..340451d 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -49,13 +49,14 @@
 
 #include "fsl_usb2_udc.h"
 
+#define	DRIVER_NAME	"fsl-usb2-udc"
 #define	DRIVER_DESC	"Freescale High-Speed USB SOC Device Controller driver"
 #define	DRIVER_AUTHOR	"Li Yang/Jiang Bo"
 #define	DRIVER_VERSION	"Apr 20, 2007"
 
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
-static const char driver_name[] = "fsl-usb2-udc";
+static const char driver_name[] = DRIVER_NAME;
 static const char driver_desc[] = DRIVER_DESC;
 
 static struct usb_dr_device *dr_regs;
@@ -2761,35 +2762,19 @@ static int fsl_udc_otg_resume(struct device *dev)
 	Register entry point for the peripheral controller driver
 --------------------------------------------------------------------------*/
 
-static struct platform_driver udc_driver = {
-	.remove  = __exit_p(fsl_udc_remove),
-	/* these suspend and resume are not usb suspend and resume */
-	.suspend = fsl_udc_suspend,
-	.resume  = fsl_udc_resume,
-	.driver  = {
-		.name = (char *)driver_name,
-		.owner = THIS_MODULE,
-		/* udc suspend/resume called from OTG driver */
+static struct platform_driver fsl_udc_driver = {
+	.probe		= fsl_udc_probe,
+	.remove		= __devexit_p(fsl_udc_remove),
+	.suspend	= fsl_udc_suspend,
+	.resume		= fsl_udc_resume,
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
 		.suspend = fsl_udc_otg_suspend,
 		.resume  = fsl_udc_otg_resume,
 	},
 };
-
-static int __init udc_init(void)
-{
-	printk(KERN_INFO "%s (%s)\n", driver_desc, DRIVER_VERSION);
-	return platform_driver_probe(&udc_driver, fsl_udc_probe);
-}
-
-module_init(udc_init);
-
-static void __exit udc_exit(void)
-{
-	platform_driver_unregister(&udc_driver);
-	printk(KERN_WARNING "%s unregistered\n", driver_desc);
-}
-
-module_exit(udc_exit);
+module_platform_driver(fsl_udc_driver);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
1.7.2.5
