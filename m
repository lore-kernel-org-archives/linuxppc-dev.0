Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id A3232DDF10
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 17:19:59 +1000 (EST)
Date: Mon, 9 Jul 2007 09:19:55 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: khali@linux-fr.org
Subject: [PATCH] i2c-mpc: work around missing-9th-clock-pulse bug
Message-ID: <20070709071955.GD4186@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: i2c@lm-sensors.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Work around a problem reported on:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
Without this patch I2C on mpc5200 becomes unusable after a while.
Tested on mpc5200 based boards by Matthias and me.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 drivers/i2c/busses/i2c-mpc.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
+++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
@@ -74,6 +74,20 @@ static irqreturn_t mpc_i2c_isr(int irq, 
 	return IRQ_HANDLED;
 }
 
+static void mpc_i2c_fixup(struct mpc_i2c *i2c)
+{
+	writeccr(i2c, 0);
+	udelay(30);
+	writeccr(i2c, CCR_MEN);
+	udelay(30);
+	writeccr(i2c, CCR_MSTA | CCR_MTX);
+	udelay(30);
+	writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
+	udelay(30);
+	writeccr(i2c, CCR_MEN);
+	udelay(30);
+}
+
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 {
 	unsigned long orig_jiffies = jiffies;
@@ -153,6 +167,9 @@ static void mpc_i2c_start(struct mpc_i2c
 static void mpc_i2c_stop(struct mpc_i2c *i2c)
 {
 	writeccr(i2c, CCR_MEN);
+	mb();
+	writeccr(i2c, 0);
+	mb();
 }
 
 static int mpc_write(struct mpc_i2c *i2c, int target,
@@ -245,6 +262,8 @@ static int mpc_xfer(struct i2c_adapter *
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
 			pr_debug("I2C: timeout\n");
+			if (readb(i2c->base + MPC_I2C_SR) == (CSR_MCF | CSR_MBB | CSR_RXAK))
+				mpc_i2c_fixup(i2c);
 			return -EIO;
 		}
 		schedule();
