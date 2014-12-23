Return-Path: <der.herr@hofr.at>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2CB61A0C64
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Dec 2014 05:58:17 +1100 (AEDT)
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] gadget: cleanup on stack DECLARE_COMPLETIONs
Date: Tue, 23 Dec 2014 19:50:14 +0100
Message-Id: <1419360614-23898-1-git-send-email-der.herr@hofr.at>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Nicholas Mc Guire <der.herr@hofr.at>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fixups for incorrect use of DECLARE_COMPLETION. see also commit
6e9a4738 ("completions: lockdep annotate on stack completions")

patch is against 3.18.0 linux-next

This was only code reviewed and compile tested

Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c   |    2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 795c99c..e0822f1 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -2630,7 +2630,7 @@ static int qe_udc_remove(struct platform_device *ofdev)
 	struct qe_udc *udc = platform_get_drvdata(ofdev);
 	struct qe_ep *ep;
 	unsigned int size;
-	DECLARE_COMPLETION(done);
+	DECLARE_COMPLETION_ONSTACK(done);

 	usb_del_gadget_udc(&udc->gadget);

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 2df8074..c3830ad 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2529,7 +2529,7 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);

-	DECLARE_COMPLETION(done);
+	DECLARE_COMPLETION_ONSTACK(done);

 	if (!udc_controller)
 		return -ENODEV;
--
1.7.10.4
