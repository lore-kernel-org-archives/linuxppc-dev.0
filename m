Return-Path: <galak@somerset.sps.mot.com>
Received: from motgate5.mot.com (motgate5.mot.com [144.189.100.105])
	by ozlabs.org (Postfix) with ESMTP id DE8C62BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 11:22:04 +1100 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate5.mot.com (8.12.11/Motgate5) with ESMTP id j0E0OalA011705
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 17:24:37 -0700 (MST)
Received: from postal.somerset.sps.mot.com (postal.somerset.sps.mot.com
	[163.12.132.5])
	by az33exr03.mot.com (Motorola/az33exr03) with ESMTP id j0E0LbNu017548
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Jan 2005 18:21:38 -0600
Date: Thu, 13 Jan 2005 18:21:54 -0600 (CST)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: greg@kroah.com
Message-ID: <Pine.LNX.4.61.0501131816260.27470@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] I2C-MPC: use wait_event_interruptible_timeout between
 transactions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Use wait_event_interruptible_timeout so we dont waste time waiting between 
transactions like we use to.  Also, we use the adapters timeout so the 
ioctl cmd I2C_TIMEOUT will now work.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/13 18:09:31-06:00 galak@cde-tx32-ldt330.sps.mot.com 
#   use wait_even_interruptible_timeout instead of msleep_interruptible
# 
# drivers/i2c/busses/i2c-mpc.c
#   2005/01/13 18:08:40-06:00 galak@cde-tx32-ldt330.sps.mot.com +15 -21
#   use wait_even_interruptible_timeout instead of msleep_interruptible
# 
diff -Nru a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c	2005-01-13 18:15:58 -06:00
+++ b/drivers/i2c/busses/i2c-mpc.c	2005-01-13 18:15:58 -06:00
@@ -6,7 +6,7 @@
  * MPC107/Tsi107 PowerPC northbridge and processors that include
  * the same I2C unit (8240, 8245, 85xx). 
  *
- * Release 0.6
+ * Release 0.7
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -75,7 +75,6 @@
 
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	unsigned long orig_jiffies = jiffies;
 	u32 x;
 	int result = 0;
@@ -92,28 +91,22 @@
 		x = readb(i2c->base + MPC_I2C_SR);
 		writeb(0, i2c->base + MPC_I2C_SR);
 	} else {
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&i2c->queue, &wait);
-		while (!(i2c->interrupt & CSR_MIF)) {
-			if (signal_pending(current)) {
-				pr_debug("I2C: Interrupted\n");
-				result = -EINTR;
-				break;
-			}
-			if (time_after(jiffies, orig_jiffies + timeout)) {
-				pr_debug("I2C: timeout\n");
-				result = -EIO;
-				break;
-			}
-			msleep_interruptible(jiffies_to_msecs(timeout));
+		/* Interrupt mode */
+		result = wait_event_interruptible_timeout(i2c->queue, 
+			(i2c->interrupt & CSR_MIF), timeout * HZ);
+
+		if (unlikely(result < 0))
+			pr_debug("I2C: wait interrupted\n");
+		else if (unlikely(!(i2c->interrupt & CSR_MIF))) {
+			pr_debug("I2C: wait timeout\n");
+			result = -ETIMEDOUT;
 		}
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&i2c->queue, &wait);
+
 		x = i2c->interrupt;
 		i2c->interrupt = 0;
 	}
 
-	if (result < -0)
+	if (result < 0)
 		return result;
 
 	if (!(x & CSR_MCF)) {
@@ -165,7 +158,7 @@
 		     const u8 * data, int length, int restart)
 {
 	int i;
-	unsigned timeout = HZ;
+	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;
 
 	/* Start with MEN */
@@ -193,7 +186,7 @@
 static int mpc_read(struct mpc_i2c *i2c, int target,
 		    u8 * data, int length, int restart)
 {
-	unsigned timeout = HZ;
+	unsigned timeout = i2c->adap.timeout;
 	int i;
 	u32 flags = restart ? CCR_RSTA : 0;
 
@@ -302,6 +295,7 @@
 	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
+	memset(i2c, 0, sizeof(*i2c));
 	i2c->ocpdef = ocp->def;
 	init_waitqueue_head(&i2c->queue);
 
