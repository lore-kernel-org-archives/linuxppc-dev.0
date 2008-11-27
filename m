Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 4A46DDDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 02:34:02 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: grant.likely@secretlab.ca
Subject: [PATCH] mpc52xx/serial: fix error paths in probe function
Date: Thu, 27 Nov 2008 16:33:56 +0100
Message-Id: <1227800036-30109-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- error cases for mapbase and irq were unbundled
- mapped irq now gets disposed on error
- errors return ENODEV instead of EINVAL as they are not dependant on
  arguments

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/serial/mpc52xx_uart.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 3234100..93e8893 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1113,14 +1113,14 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 		if (mpc52xx_uart_nodes[idx] == op->node)
 			break;
 	if (idx >= MPC52xx_PSC_MAXNUM)
-		return -EINVAL;
+		return -ENODEV;
 	pr_debug("Found %s assigned to ttyPSC%x\n",
 		 mpc52xx_uart_nodes[idx]->full_name, idx);
 
 	uartclk = psc_ops->getuartclk(op->node);
 	if (uartclk == 0) {
 		dev_dbg(&op->dev, "Could not find uart clock frequency!\n");
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	/* Init the port structure */
@@ -1142,22 +1142,29 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 		return ret;
 
 	port->mapbase = res.start;
+	if (!port->mapbase) {
+		dev_err(&op->dev, "Could not allocate resources for PSC\n");
+		return -ENODEV;
+	}
+
 	port->irq = irq_of_parse_and_map(op->node, 0);
+	if (port->irq == NO_IRQ) {
+		dev_err(&op->dev, "Could not get irq\n");
+		return -ENODEV;
+	}
 
 	dev_dbg(&op->dev, "mpc52xx-psc uart at %p, irq=%x, freq=%i\n",
 		(void *)port->mapbase, port->irq, port->uartclk);
 
-	if ((port->irq == NO_IRQ) || !port->mapbase) {
-		printk(KERN_ERR "Could not allocate resources for PSC\n");
-		return -EINVAL;
-	}
-
 	/* Add the port to the uart sub-system */
 	ret = uart_add_one_port(&mpc52xx_uart_driver, port);
-	if (!ret)
-		dev_set_drvdata(&op->dev, (void *)port);
+	if (ret) {
+		irq_dispose_mapping(port->irq);
+		return -ENODEV;
+	}
 
-	return ret;
+	dev_set_drvdata(&op->dev, (void *)port);
+	return 0;
 }
 
 static int
-- 
1.5.6.5
