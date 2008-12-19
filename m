Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 73D4EDDF55
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 02:33:16 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: grant.likely@secretlab.ca
Subject: [PATCH V2] mpc52xx/serial: fix error paths in probe function
Date: Fri, 19 Dec 2008 16:32:03 +0100
Message-Id: <1229700723-12675-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1227800036-30109-1-git-send-email-w.sang@pengutronix.de>
References: <1227800036-30109-1-git-send-email-w.sang@pengutronix.de>
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

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Tested with 2.6.28-rc9 on a phyCORE-MPC5200B-IO.

Changes since V1:

after following a discussion on LKML, it seems better to:

- use -EINVAL again instead of -ENODEV
- use dev_dbg instead of dev_err

 drivers/serial/mpc52xx_uart.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 28c00c3..172f61f 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1109,22 +1109,29 @@ mpc52xx_uart_of_probe(struct of_device *op, const struct of_device_id *match)
 		return ret;
 
 	port->mapbase = res.start;
+	if (!port->mapbase) {
+		dev_dbg(&op->dev, "Could not allocate resources for PSC\n");
+		return -EINVAL;
+	}
+
 	port->irq = irq_of_parse_and_map(op->node, 0);
+	if (port->irq == NO_IRQ) {
+		dev_dbg(&op->dev, "Could not get irq\n");
+		return -EINVAL;
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
+		return ret;
+	}
 
-	return ret;
+	dev_set_drvdata(&op->dev, (void *)port);
+	return 0;
 }
 
 static int
-- 
1.5.6.5
