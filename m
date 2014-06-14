Return-Path: <himangi774@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C79E81A04D0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Jun 2014 01:18:37 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id y10so1562070pdj.22
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 08:18:35 -0700 (PDT)
Date: Sat, 14 Jun 2014 20:48:27 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Li Yang <leoli@freescale.com>, Felipe Balbi <balbi@ti.com>,
 GregKroah-Hartman@himangi-Dell, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: fsl_qe_udc: Introduce use of managed version of
 kzalloc
Message-ID: <20140614151827.GA2910@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julia.lawall@lip6.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves data allocated using kzalloc to managed data allocated
using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
functions. Also, the unnecesary labels are removed and some labels are
renamed to preserve ordering.

The following Coccinelle semantic patch was used for making the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression e;
@@
removefn(...) {
  <...
- kfree(e);
  ...>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
Not compile tested due to incompatible architecture.

 drivers/usb/gadget/fsl_qe_udc.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index ad54833..7324308 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2539,7 +2539,7 @@ static int qe_udc_probe(struct platform_device *ofdev)
 		goto err2;
 
 	/* create a buf for ZLP send, need to remain zeroed */
-	udc->nullbuf = kzalloc(256, GFP_KERNEL);
+	udc->nullbuf = devm_kzalloc(&ofdev->dev, 256, GFP_KERNEL);
 	if (udc->nullbuf == NULL) {
 		dev_err(udc->dev, "cannot alloc nullbuf\n");
 		ret = -ENOMEM;
@@ -2547,10 +2547,10 @@ static int qe_udc_probe(struct platform_device *ofdev)
 	}
 
 	/* buffer for data of get_status request */
-	udc->statusbuf = kzalloc(2, GFP_KERNEL);
+	udc->statusbuf = devm_kzalloc(&ofdev->dev, 2, GFP_KERNEL);
 	if (udc->statusbuf == NULL) {
 		ret = -ENOMEM;
-		goto err4;
+		goto err3;
 	}
 
 	udc->nullp = virt_to_phys((void *)udc->nullbuf);
@@ -2581,13 +2581,13 @@ static int qe_udc_probe(struct platform_device *ofdev)
 	if (ret) {
 		dev_err(udc->dev, "cannot request irq %d err %d\n",
 				udc->usb_irq, ret);
-		goto err5;
+		goto err4;
 	}
 
 	ret = usb_add_gadget_udc_release(&ofdev->dev, &udc->gadget,
 			qe_udc_release);
 	if (ret)
-		goto err6;
+		goto err5;
 
 	platform_set_drvdata(ofdev, udc);
 	dev_info(udc->dev,
@@ -2595,9 +2595,9 @@ static int qe_udc_probe(struct platform_device *ofdev)
 			(udc->soc_type == PORT_QE) ? "QE" : "CPM");
 	return 0;
 
-err6:
-	free_irq(udc->usb_irq, udc);
 err5:
+	free_irq(udc->usb_irq, udc);
+err4:
 	irq_dispose_mapping(udc->usb_irq);
 err_noirq:
 	if (udc->nullmap) {
@@ -2610,9 +2610,6 @@ err_noirq:
 			udc->nullp, 256,
 				DMA_TO_DEVICE);
 	}
-	kfree(udc->statusbuf);
-err4:
-	kfree(udc->nullbuf);
 err3:
 	ep = &udc->eps[0];
 	cpm_muram_free(cpm_muram_offset(ep->rxbase));
@@ -2660,8 +2657,6 @@ static int qe_udc_remove(struct platform_device *ofdev)
 			udc->nullp, 256,
 				DMA_TO_DEVICE);
 	}
-	kfree(udc->statusbuf);
-	kfree(udc->nullbuf);
 
 	ep = &udc->eps[0];
 	cpm_muram_free(cpm_muram_offset(ep->rxbase));
-- 
1.9.1
