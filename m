Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA931B7E51
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Apr 2010 11:17:20 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-i2c@vger.kernel.org
Date: Fri,  2 Apr 2010 02:16:59 +0200
Message-Id: <1270167421-5205-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
References: <1270167421-5205-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH RESEND 1/3] i2c/mpc: drop NO_IRQ
Cc: linuxppc-dev@ozlabs.org, Ben Dooks <ben-linux@fluff.org>
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
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-mpc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 78a15af..72a26a2 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -117,7 +117,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	u32 x;
 	int result = 0;
 
-	if (i2c->irq == NO_IRQ) {
+	if (!i2c->irq) {
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
@@ -567,7 +567,7 @@ static int __devinit fsl_i2c_probe(struct of_device *op,
 	}
 
 	i2c->irq = irq_of_parse_and_map(op->node, 0);
-	if (i2c->irq != NO_IRQ) { /* i2c->irq = NO_IRQ implies polling */
+	if (i2c->irq) { /* no i2c->irq implies polling */
 		result = request_irq(i2c->irq, mpc_i2c_isr,
 				     IRQF_SHARED, "i2c-mpc", i2c);
 		if (result < 0) {
@@ -626,7 +626,7 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
 	i2c_del_adapter(&i2c->adap);
 	dev_set_drvdata(&op->dev, NULL);
 
-	if (i2c->irq != NO_IRQ)
+	if (i2c->irq)
 		free_irq(i2c->irq, i2c);
 
 	irq_dispose_mapping(i2c->irq);
-- 
1.7.0
