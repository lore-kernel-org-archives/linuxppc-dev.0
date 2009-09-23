Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 82930B7B7F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 04:52:43 +1000 (EST)
Date: Wed, 23 Sep 2009 22:52:42 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/3] USB: ehci-fsl: Fix sparse warnings
Message-ID: <20090923185242.GB18755@oksana.dev.rtsoft.ru>
References: <20090923185158.GA29065@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090923185158.GA29065@oksana.dev.rtsoft.ru>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes following warnings:

ehci-fsl.c:43:5: warning: symbol 'usb_hcd_fsl_probe' was not declared. Should it be static?
ehci-fsl.c:150:6: warning: symbol 'usb_hcd_fsl_remove' was not declared. Should it be static?

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/host/ehci-fsl.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 9911749..593a7e7 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -40,8 +40,8 @@
  * Allocates basic resources for this USB host controller.
  *
  */
-int usb_hcd_fsl_probe(const struct hc_driver *driver,
-		      struct platform_device *pdev)
+static int usb_hcd_fsl_probe(const struct hc_driver *driver,
+			     struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata;
 	struct usb_hcd *hcd;
@@ -147,7 +147,8 @@ int usb_hcd_fsl_probe(const struct hc_driver *driver,
  * Reverses the effect of usb_hcd_fsl_probe().
  *
  */
-void usb_hcd_fsl_remove(struct usb_hcd *hcd, struct platform_device *pdev)
+static void usb_hcd_fsl_remove(struct usb_hcd *hcd,
+			       struct platform_device *pdev)
 {
 	usb_remove_hcd(hcd);
 	iounmap(hcd->regs);
-- 
1.6.3.3
