Return-Path: <jonsmirl@gmail.com>
Received: from vms173001pub.verizon.net (vms173001pub.verizon.net
	[206.46.173.1]) by ozlabs.org (Postfix) with ESMTP id 00340DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 08:09:08 +1100 (EST)
Received: from terra.home ([96.233.72.204]) by vms173001.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0JV000D5OFCYIWW0@vms173001.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 21 Jan 2008 13:55:46 -0600 (CST)
Date: Mon, 21 Jan 2008 15:07:40 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20080121200740.13800.20524.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alter the mpc i2c driver to use the NO_IRQ symbol instead of the constant zero when checking for valid interrupts. NO_IRQ=-1 on ppc and NO_IRQ=0 on powerpc so the checks against zero are not correct.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 drivers/i2c/busses/i2c-mpc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index bbe787b..d20959d 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -99,7 +99,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	u32 x;
 	int result = 0;
 
-	if (i2c->irq == 0)
+	if (i2c->irq == NO_IRQ)
 	{
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
@@ -329,7 +329,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
+	if (i2c->irq < NO_IRQ) {
 		result = -ENXIO;
 		goto fail_get_irq;
 	}
@@ -344,7 +344,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 		goto fail_map;
 	}
 
-	if (i2c->irq != 0)
+	if (i2c->irq != NO_IRQ)
 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
 					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
@@ -367,7 +367,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 	return result;
 
       fail_add:
-	if (i2c->irq != 0)
+	if (i2c->irq != NO_IRQ)
 		free_irq(i2c->irq, i2c);
       fail_irq:
 	iounmap(i2c->base);
@@ -384,7 +384,7 @@ static int fsl_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&i2c->adap);
 	platform_set_drvdata(pdev, NULL);
 
-	if (i2c->irq != 0)
+	if (i2c->irq != NO_IRQ)
 		free_irq(i2c->irq, i2c);
 
 	iounmap(i2c->base);
