Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B40C4474D2
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 03:03:22 +1100 (EST)
Date: Tue, 11 Nov 2008 19:03:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 1/6] usb/fsl_qe_udc: Fix oops on QE UDC probe failure
Message-ID: <20081111160320.GA24699@oksana.dev.rtsoft.ru>
References: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081111160153.GA12783@oksana.dev.rtsoft.ru>
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

In case of probing errors the driver kfrees the udc_controller, but it
doesn't set the pointer to NULL.

When usb_gadget_register_driver is called, it checks for udc_controller
!= NULL, the check passes and the driver accesses nonexistent memory.
Fix this by setting udc_controller to NULL in case of errors.

While at it, also implement irq_of_parse_and_map()'s failure and cleanup
cases.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/gadget/fsl_qe_udc.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 94c38e4..60b9279 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2601,6 +2601,10 @@ static int __devinit qe_udc_probe(struct of_device *ofdev,
 			(unsigned long)udc_controller);
 	/* request irq and disable DR  */
 	udc_controller->usb_irq = irq_of_parse_and_map(np, 0);
+	if (!udc_controller->usb_irq) {
+		ret = -EINVAL;
+		goto err_noirq;
+	}
 
 	ret = request_irq(udc_controller->usb_irq, qe_udc_irq, 0,
 				driver_name, udc_controller);
@@ -2622,6 +2626,8 @@ static int __devinit qe_udc_probe(struct of_device *ofdev,
 err6:
 	free_irq(udc_controller->usb_irq, udc_controller);
 err5:
+	irq_dispose_mapping(udc_controller->usb_irq);
+err_noirq:
 	if (udc_controller->nullmap) {
 		dma_unmap_single(udc_controller->gadget.dev.parent,
 			udc_controller->nullp, 256,
@@ -2645,7 +2651,7 @@ err2:
 	iounmap(udc_controller->usb_regs);
 err1:
 	kfree(udc_controller);
-
+	udc_controller = NULL;
 	return ret;
 }
 
@@ -2707,6 +2713,7 @@ static int __devexit qe_udc_remove(struct of_device *ofdev)
 	kfree(ep->txframe);
 
 	free_irq(udc_controller->usb_irq, udc_controller);
+	irq_dispose_mapping(udc_controller->usb_irq);
 
 	tasklet_kill(&udc_controller->rx_tasklet);
 
-- 
1.5.6.3
