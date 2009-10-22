Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 423E3B80E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 08:12:01 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 3/3] i2c/ibm-iic: drop NO_IRQ
Date: Thu, 22 Oct 2009 23:11:28 +0200
Message-Id: <1256245888-25210-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-3-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org, Ben Dooks <ben-linux@fluff.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
(http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driver is
only used on powerpc, where NO_IRQ is 0 anyhow.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index b1bc6e2..2bef534 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -668,12 +668,12 @@ static int __devinit iic_request_irq(struct of_device *ofdev,
 	int irq;
 
 	if (iic_force_poll)
-		return NO_IRQ;
+		return 0;
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_err(&ofdev->dev, "irq_of_parse_and_map failed\n");
-		return NO_IRQ;
+		return 0;
 	}
 
 	/* Disable interrupts until we finish initialization, assumes
@@ -683,7 +683,7 @@ static int __devinit iic_request_irq(struct of_device *ofdev,
 	if (request_irq(irq, iic_handler, 0, "IBM IIC", dev)) {
 		dev_err(&ofdev->dev, "request_irq %d failed\n", irq);
 		/* Fallback to the polling mode */
-		return NO_IRQ;
+		return 0;
 	}
 
 	return irq;
@@ -719,7 +719,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
 	init_waitqueue_head(&dev->wq);
 
 	dev->irq = iic_request_irq(ofdev, dev);
-	if (dev->irq == NO_IRQ)
+	if (!dev->irq)
 		dev_warn(&ofdev->dev, "using polling mode\n");
 
 	/* Board specific settings */
@@ -766,7 +766,7 @@ static int __devinit iic_probe(struct of_device *ofdev,
 	return 0;
 
 error_cleanup:
-	if (dev->irq != NO_IRQ) {
+	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
 	}
@@ -790,7 +790,7 @@ static int __devexit iic_remove(struct of_device *ofdev)
 
 	i2c_del_adapter(&dev->adap);
 
-	if (dev->irq != NO_IRQ) {
+	if (dev->irq) {
 		iic_interrupt_mode(dev, 0);
 		free_irq(dev->irq, dev);
 	}
-- 
1.6.5
