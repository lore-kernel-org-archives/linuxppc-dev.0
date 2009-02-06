Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 304B0DDE26
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 01:00:52 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	galak@kernel.crashing.org, broonie@opensource.wolfsonmicro.com,
	mditto@consentry.com
Subject: [PATCH] i2c-mpc: do not allow interruptions when waiting for I2C to
	complete
Date: Fri,  6 Feb 2009 08:00:37 -0600
Message-Id: <1233928837-3401-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The i2c_wait() function is using wait_event_interruptible_timeout() to wait for
the I2C controller to signal that it has completed an I2C bus operation.  If
the process that causes the I2C operation terminated abruptly, the wait will
be interrupted, returning an error.  It is better to let the I2C operation
finished before the process exits.

It is safe to use wait_event_timeout() instead, because the timeout will allow
the process to exit if the I2C bus hangs.  It's also better to allow the
I2C operation to finish, because unacknowledged I2C operations can cause the
I2C bus to hang.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

A similar change should probably be done to i2c-cpm.c, and maybe all other
I2C drivers.  Not many use wait_event_interruptible_timeout().

 drivers/i2c/busses/i2c-mpc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index a9a45fc..c0ace48 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -70,7 +70,7 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
 		/* Read again to allow register to stabilise */
 		i2c->interrupt = readb(i2c->base + MPC_I2C_SR);
 		writeb(0, i2c->base + MPC_I2C_SR);
-		wake_up_interruptible(&i2c->queue);
+		wake_up(&i2c->queue);
 	}
 	return IRQ_HANDLED;
 }
@@ -115,13 +115,10 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 		writeb(0, i2c->base + MPC_I2C_SR);
 	} else {
 		/* Interrupt mode */
-		result = wait_event_interruptible_timeout(i2c->queue,
+		result = wait_event_timeout(i2c->queue,
 			(i2c->interrupt & CSR_MIF), timeout * HZ);
 
-		if (unlikely(result < 0)) {
-			pr_debug("I2C: wait interrupted\n");
-			writeccr(i2c, 0);
-		} else if (unlikely(!(i2c->interrupt & CSR_MIF))) {
+		if (unlikely(!(i2c->interrupt & CSR_MIF))) {
 			pr_debug("I2C: wait timeout\n");
 			writeccr(i2c, 0);
 			result = -ETIMEDOUT;
-- 
1.5.5
