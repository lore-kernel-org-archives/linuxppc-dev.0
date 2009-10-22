Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 60D97B7BCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 08:11:56 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 1/3] i2c/mpc: drop NO_IRQ
Date: Thu, 22 Oct 2009 23:11:26 +0200
Message-Id: <1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org, Ben Dooks <ben-linux@fluff.org>
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
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-mpc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index d325e86..7e58443 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -115,7 +115,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	u32 x;
 	int result = 0;
 
-	if (i2c->irq == NO_IRQ) {
+	if (!i2c->irq) {
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
@@ -520,7 +520,7 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 	}
 
 	i2c->irq = irq_of_parse_and_map(op->node, 0);
-	if (i2c->irq != NO_IRQ) { /* i2c->irq = NO_IRQ implies polling */
+	if (i2c->irq) { /* no i2c->irq implies polling */
 		result = request_irq(i2c->irq, mpc_i2c_isr,
 				     IRQF_SHARED, "i2c-mpc", i2c);
 		if (result < 0) {
@@ -579,7 +579,7 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
 	i2c_del_adapter(&i2c->adap);
 	dev_set_drvdata(&op->dev, NULL);
 
-	if (i2c->irq != NO_IRQ)
+	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
 
 	irq_dispose_mapping(i2c->irq);
-- 
1.6.5
