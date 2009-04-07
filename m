Return-Path: <wg@denx.de>
Message-Id: <20090407082231.335327816@denx.de>
Date: Tue, 07 Apr 2009 10:20:54 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v3 2/5] i2c: i2c-mpc: use dev based printout function
References: <20090407082052.477328750@denx.de>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch used the dev_dbg, dev_err, etc. functions for debug
and error output instead of printk and pr_debug.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/i2c/busses/i2c-mpc.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c	2009-04-07 10:09:13.271719088 +0200
+++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c	2009-04-07 10:09:14.012720756 +0200
@@ -50,6 +50,7 @@
 #define CSR_RXAK 0x01
 
 struct mpc_i2c {
+	struct device *dev;
 	void __iomem *base;
 	u32 interrupt;
 	wait_queue_head_t queue;
@@ -104,7 +105,7 @@
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
-				pr_debug("I2C: timeout\n");
+				dev_dbg(i2c->dev, "timeout\n");
 				writeccr(i2c, 0);
 				result = -EIO;
 				break;
@@ -118,7 +119,7 @@
 			(i2c->interrupt & CSR_MIF), timeout);
 
 		if (unlikely(!(i2c->interrupt & CSR_MIF))) {
-			pr_debug("I2C: wait timeout\n");
+			dev_dbg(i2c->dev, "wait timeout\n");
 			writeccr(i2c, 0);
 			result = -ETIMEDOUT;
 		}
@@ -131,17 +132,17 @@
 		return result;
 
 	if (!(x & CSR_MCF)) {
-		pr_debug("I2C: unfinished\n");
+		dev_dbg(i2c->dev, "unfinished\n");
 		return -EIO;
 	}
 
 	if (x & CSR_MAL) {
-		pr_debug("I2C: MAL\n");
+		dev_dbg(i2c->dev, "MAL\n");
 		return -EIO;
 	}
 
 	if (writing && (x & CSR_RXAK)) {
-		pr_debug("I2C: No RXAK\n");
+		dev_dbg(i2c->dev, "No RXAK\n");
 		/* generate stop */
 		writeccr(i2c, CCR_MEN);
 		return -EIO;
@@ -263,12 +264,12 @@
 	/* Allow bus up to 1s to become not busy */
 	while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
 		if (signal_pending(current)) {
-			pr_debug("I2C: Interrupted\n");
+			dev_dbg(i2c->dev, "Interrupted\n");
 			writeccr(i2c, 0);
 			return -EINTR;
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
-			pr_debug("I2C: timeout\n");
+			dev_dbg(i2c->dev, "timeout\n");
 			if (readb(i2c->base + MPC_I2C_SR) ==
 			    (CSR_MCF | CSR_MBB | CSR_RXAK))
 				mpc_i2c_fixup(i2c);
@@ -279,9 +280,10 @@
 
 	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
-		pr_debug("Doing %s %d bytes to 0x%02x - %d of %d messages\n",
-			 pmsg->flags & I2C_M_RD ? "read" : "write",
-			 pmsg->len, pmsg->addr, i + 1, num);
+		dev_dbg(i2c->dev,
+			"Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+			pmsg->flags & I2C_M_RD ? "read" : "write",
+			pmsg->len, pmsg->addr, i + 1, num);
 		if (pmsg->flags & I2C_M_RD)
 			ret =
 			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
@@ -320,6 +322,8 @@
 	if (!i2c)
 		return -ENOMEM;
 
+	i2c->dev = &op->dev; /* for debug and error output */
+
 	if (of_get_property(op->node, "dfsrr", NULL))
 		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
 
@@ -331,7 +335,7 @@
 
 	i2c->base = of_iomap(op->node, 0);
 	if (!i2c->base) {
-		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
+		dev_err(i2c->dev, "failed to map controller\n");
 		result = -ENOMEM;
 		goto fail_map;
 	}
@@ -341,8 +345,7 @@
 		result = request_irq(i2c->irq, mpc_i2c_isr,
 				     IRQF_SHARED, "i2c-mpc", i2c);
 		if (result < 0) {
-			printk(KERN_ERR
-			       "i2c-mpc - failed to attach interrupt\n");
+			dev_err(i2c->dev, "failed to attach interrupt\n");
 			goto fail_request;
 		}
 	}
@@ -357,7 +360,7 @@
 
 	result = i2c_add_adapter(&i2c->adap);
 	if (result < 0) {
-		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
+		dev_err(i2c->dev, "failed to add adapter\n");
 		goto fail_add;
 	}
 	of_register_i2c_devices(&i2c->adap, op->node);
