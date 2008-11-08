Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 86121DDE06
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 04:51:49 +1100 (EST)
Date: Sat, 8 Nov 2008 20:51:48 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 2/2] usb/fsl_qe_udc: Check for muram allocation errors
Message-ID: <20081108175148.GB6010@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Greg Kroah-Hartman <greg@kroah.com>, Li Yang <leoli@freescale.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The QE UDC doesn't check for cpm_muram_alloc() return values, this
might cause all sorts of misbehaviour when cpm_muram_alloc() failed
to allocate the muram memory.

While at at, change few dev_dbg() calls to dev_err(), so that the
driver would not die silently.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/gadget/fsl_qe_udc.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 1fe8b44..94c38e4 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -26,6 +26,7 @@
 #include <linux/ioport.h>
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
@@ -370,6 +371,9 @@ static int qe_ep_bd_init(struct qe_udc *udc, unsigned char pipe_num)
 	/* alloc multi-ram for BD rings and set the ep parameters */
 	tmp_addr = cpm_muram_alloc(sizeof(struct qe_bd) * (bdring_len +
 				USB_BDRING_LEN_TX), QE_ALIGNMENT_OF_BD);
+	if (IS_ERR_VALUE(tmp_addr))
+		return -ENOMEM;
+
 	out_be16(&epparam->rbase, (u16)tmp_addr);
 	out_be16(&epparam->tbase, (u16)(tmp_addr +
 				(sizeof(struct qe_bd) * bdring_len)));
@@ -689,7 +693,7 @@ en_done2:
 en_done1:
 	spin_unlock_irqrestore(&udc->lock, flags);
 en_done:
-	dev_dbg(udc->dev, "failed to initialize %s\n", ep->ep.name);
+	dev_err(udc->dev, "failed to initialize %s\n", ep->ep.name);
 	return -ENODEV;
 }
 
@@ -2405,6 +2409,8 @@ static struct qe_udc __devinit *qe_udc_config(struct of_device *ofdev)
 	tmp_addr = cpm_muram_alloc((USB_MAX_ENDPOINTS *
 					sizeof(struct usb_ep_para)),
 					   USB_EP_PARA_ALIGNMENT);
+	if (IS_ERR_VALUE(tmp_addr))
+		goto cleanup;
 
 	for (i = 0; i < USB_MAX_ENDPOINTS; i++) {
 		out_be16(&usbpram->epptr[i], (u16)tmp_addr);
@@ -2510,7 +2516,7 @@ static int __devinit qe_udc_probe(struct of_device *ofdev,
 	/* Initialize the udc structure including QH member and other member */
 	udc_controller = qe_udc_config(ofdev);
 	if (!udc_controller) {
-		dev_dbg(&ofdev->dev, "udc_controll is NULL\n");
+		dev_err(&ofdev->dev, "failed to initialize\n");
 		return -ENOMEM;
 	}
 
@@ -2565,7 +2571,7 @@ static int __devinit qe_udc_probe(struct of_device *ofdev,
 	/* create a buf for ZLP send, need to remain zeroed */
 	udc_controller->nullbuf = kzalloc(256, GFP_KERNEL);
 	if (udc_controller->nullbuf == NULL) {
-		dev_dbg(udc_controller->dev, "cannot alloc nullbuf\n");
+		dev_err(udc_controller->dev, "cannot alloc nullbuf\n");
 		ret = -ENOMEM;
 		goto err3;
 	}
-- 
1.5.6.3
