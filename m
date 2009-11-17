Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 2CC3FB7BA2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 01:31:25 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH] spi/mpc52xx-spi: cleanups
Date: Tue, 17 Nov 2009 15:31:08 +0100
Message-Id: <1258468268-9911-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Luotao Fu <l.fu@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- drop own, obsolete include-file
- drop IRQF_SAMPLE_RANDOM (deprecated feature)
- drop 'if' above kfree()
- typos, braces & whitespaces

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Luotao Fu <l.fu@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---

This goes ontop of Grant's test-branch.

 drivers/spi/mpc52xx_spi.c       |   24 ++++++++++--------------
 include/linux/spi/mpc52xx_spi.h |   10 ----------
 2 files changed, 10 insertions(+), 24 deletions(-)
 delete mode 100644 include/linux/spi/mpc52xx_spi.h

diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
index 97beba2..7f4089c 100644
--- a/drivers/spi/mpc52xx_spi.c
+++ b/drivers/spi/mpc52xx_spi.c
@@ -18,7 +18,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/mpc52xx_spi.h>
 #include <linux/of_spi.h>
 #include <linux/io.h>
 #include <linux/of_gpio.h>
@@ -54,7 +53,7 @@ MODULE_LICENSE("GPL");
 /* FSM state return values */
 #define FSM_STOP	0	/* Nothing more for the state machine to */
 				/* do.  If something interesting happens */
-				/* then and IRQ will be received */
+				/* then an IRQ will be received */
 #define FSM_POLL	1	/* need to poll for completion, an IRQ is */
 				/* not expected */
 #define FSM_CONTINUE	2	/* Keep iterating the state machine */
@@ -62,13 +61,12 @@ MODULE_LICENSE("GPL");
 /* Driver internal data */
 struct mpc52xx_spi {
 	struct spi_master *master;
-	u32 sysclk;
 	void __iomem *regs;
 	int irq0;	/* MODF irq */
 	int irq1;	/* SPIF irq */
-	int ipb_freq;
+	unsigned int ipb_freq;
 
-	/* Statistics */
+	/* Statistics; not used now, but will be reintroduced for debugfs */
 	int msg_count;
 	int wcol_count;
 	int wcol_ticks;
@@ -229,7 +227,7 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, struct mpc52xx_spi *ms,
 		ms->wcol_tx_timestamp = get_tbl();
 		data = 0;
 		if (ms->tx_buf)
-			data = *(ms->tx_buf-1);
+			data = *(ms->tx_buf - 1);
 		out_8(ms->regs + SPI_DATA, data); /* try again */
 		return FSM_CONTINUE;
 	} else if (status & SPI_STATUS_MODF) {
@@ -481,8 +479,9 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 			gpio_direction_output(gpio_cs, 1);
 			ms->gpio_cs[i] = gpio_cs;
 		}
-	} else
+	} else {
 		master->num_chipselect = 1;
+	}
 
 	spin_lock_init(&ms->lock);
 	INIT_LIST_HEAD(&ms->queue);
@@ -490,9 +489,9 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 
 	/* Decide if interrupts can be used */
 	if (ms->irq0 && ms->irq1) {
-		rc = request_irq(ms->irq0, mpc52xx_spi_irq, IRQF_SAMPLE_RANDOM,
+		rc = request_irq(ms->irq0, mpc52xx_spi_irq, 0,
 				  "mpc5200-spi-modf", ms);
-		rc |= request_irq(ms->irq1, mpc52xx_spi_irq, IRQF_SAMPLE_RANDOM,
+		rc |= request_irq(ms->irq1, mpc52xx_spi_irq, 0,
 				  "mpc5200-spi-spiF", ms);
 		if (rc) {
 			free_irq(ms->irq0, ms);
@@ -524,8 +523,7 @@ static int __devinit mpc52xx_spi_probe(struct of_device *op,
 	while (i-- > 0)
 		gpio_free(ms->gpio_cs[i]);
 
-	if (ms->gpio_cs != NULL)
-		kfree(ms->gpio_cs);
+	kfree(ms->gpio_cs);
  err_alloc:
  err_init:
 	iounmap(regs);
@@ -544,9 +542,7 @@ static int __devexit mpc52xx_spi_remove(struct of_device *op)
 	for (i = 0; i < ms->gpio_cs_count; i++)
 		gpio_free(ms->gpio_cs[i]);
 
-	if (ms->gpio_cs != NULL)
-		kfree(ms->gpio_cs);
-
+	kfree(ms->gpio_cs);
 	spi_unregister_master(master);
 	spi_master_put(master);
 	iounmap(ms->regs);
diff --git a/include/linux/spi/mpc52xx_spi.h b/include/linux/spi/mpc52xx_spi.h
deleted file mode 100644
index d1004cf..0000000
--- a/include/linux/spi/mpc52xx_spi.h
+++ /dev/null
@@ -1,10 +0,0 @@
-
-#ifndef INCLUDE_MPC5200_SPI_H
-#define INCLUDE_MPC5200_SPI_H
-
-extern void mpc52xx_spi_set_premessage_hook(struct spi_master *master,
-					    void (*hook)(struct spi_message *m,
-							 void *context),
-					    void *hook_context);
-
-#endif
-- 
1.6.3.3
