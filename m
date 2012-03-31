Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA4B0B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 20:26:47 +1100 (EST)
To: linuxppc-dev@lists.ozlabs.org
Subject: teach i2c-mpc to selectively ignore !RXAK errors
From: Anthony Foiani <tkil@scrye.com>
Date: Sat, 31 Mar 2012 03:19:20 -0600
Message-ID: <gbondxh47.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On the project I'm working on, the hardware engineers put an I2C
device behind a unidirectional level translator.  When I tried to
write to it, I was getting EIO due to the lack of receiver ack.

This is my hack to support this situation, based off 3.0.6 with a few
minor additions (none of which impact the I2C bits, SFAICT).

There are really two distinct changes here:

1. Change mpc_read and mpc_write to take a generic "flags" argument,
   instead of just passing the message index; and

2. In the very specific case of performing a write when the user has
   specified I2C_M_NO_RD_ACK on a message, do not error out on !RXAK
   condition.

My apologies for not breaking it down, but I don't have the bandwidth
to respin and track this change.  I'm mostly posting it so that other
people can find it if they run into the same issue.

The use of I2C_M_NO_RD_ACK is a bit obscure, but it's barely used in
the kernel, and it makes a certain amount of sense in this context.

Thanks to everyone that's contributed to the PPC Linux stack; it's
made this project (and my current livelihood!) possible.

Best Regards,
Anthony Foiani

-----------------------------------------------------------------------
>From a529752a703bcbb4a751e2e8fef721a65c702c6f Mon Sep 17 00:00:00 2001
From: Anthony Foiani <anthony.foiani@gmail.com>
Date: Wed, 28 Mar 2012 20:51:53 -0600
Subject: [PATCH] Selectively ignore missing RXAK.

Overload the I2C_M_NO_RD_ACK flag to continue with writes even when
the receiver has not acknowledged.  This was useful when talking to a
part that was electrically isolated such that it could not drive the
bus lines back to the CPU.

Signed-Off-By: Anthony Foiani <anthony.foiani@gmail.com>
---
 drivers/i2c/busses/i2c-mpc.c |   46 ++++++++++++++++++++++++-----------------
 1 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 107397a..961a0e1 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -48,6 +48,8 @@
 #define CCR_TXAK 0x08
 #define CCR_RSTA 0x04
 
+#define CCR_MASK 0xff
+
 #define CSR_MCF  0x80
 #define CSR_MAAS 0x40
 #define CSR_MBB  0x20
@@ -116,7 +118,7 @@ static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 	}
 }
 
-static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
+static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing, u32 flags)
 {
 	unsigned long orig_jiffies = jiffies;
 	u32 x;
@@ -163,10 +165,13 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	}
 
 	if (writing && (x & CSR_RXAK)) {
-		dev_dbg(i2c->dev, "No RXAK\n");
-		/* generate stop */
-		writeccr(i2c, CCR_MEN);
-		return -EIO;
+		if (!(flags & I2C_M_NO_RD_ACK)) {
+			dev_dbg(i2c->dev, "No RXAK\n");
+			/* generate stop */
+			writeccr(i2c, CCR_MEN);
+			return -EIO;
+		}
+		dev_dbg(i2c->dev, "suppressed !RXAK\n");
 	}
 	return 0;
 }
@@ -426,18 +431,18 @@ static void mpc_i2c_stop(struct mpc_i2c *i2c)
 }
 
 static int mpc_write(struct mpc_i2c *i2c, int target,
-		     const u8 *data, int length, int restart)
+		     const u8 *data, int length, u32 flags)
 {
 	int i, result;
 	unsigned timeout = i2c->adap.timeout;
-	u32 flags = restart ? CCR_RSTA : 0;
 
 	/* Start as master */
-	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
+	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA |
+		      CCR_MTX | (flags & CCR_MASK));
 	/* Write target byte */
 	writeb((target << 1), i2c->base + MPC_I2C_DR);
 
-	result = i2c_wait(i2c, timeout, 1);
+	result = i2c_wait(i2c, timeout, 1, flags);
 	if (result < 0)
 		return result;
 
@@ -445,7 +450,7 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 		/* Write data byte */
 		writeb(data[i], i2c->base + MPC_I2C_DR);
 
-		result = i2c_wait(i2c, timeout, 1);
+		result = i2c_wait(i2c, timeout, 1, flags);
 		if (result < 0)
 			return result;
 	}
@@ -454,18 +459,18 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 }
 
 static int mpc_read(struct mpc_i2c *i2c, int target,
-		    u8 *data, int length, int restart)
+		    u8 *data, int length, u32 flags)
 {
 	unsigned timeout = i2c->adap.timeout;
 	int i, result;
-	u32 flags = restart ? CCR_RSTA : 0;
 
 	/* Switch to read - restart */
-	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
+	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA |
+		      CCR_MTX | (flags & CCR_MASK));
 	/* Write target address byte - this time with the read flag set */
 	writeb((target << 1) | 1, i2c->base + MPC_I2C_DR);
 
-	result = i2c_wait(i2c, timeout, 1);
+	result = i2c_wait(i2c, timeout, 1, flags);
 	if (result < 0)
 		return result;
 
@@ -479,7 +484,7 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	}
 
 	for (i = 0; i < length; i++) {
-		result = i2c_wait(i2c, timeout, 0);
+		result = i2c_wait(i2c, timeout, 0, flags);
 		if (result < 0)
 			return result;
 
@@ -502,6 +507,7 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	int ret = 0;
 	unsigned long orig_jiffies = jiffies;
 	struct mpc_i2c *i2c = i2c_get_adapdata(adap);
+	u32 restart;
 
 	mpc_i2c_start(i2c);
 
@@ -526,6 +532,7 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		schedule();
 	}
 
+	restart = 0;
 	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 		dev_dbg(i2c->dev,
@@ -533,11 +540,12 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			pmsg->flags & I2C_M_RD ? "read" : "write",
 			pmsg->len, pmsg->addr, i + 1, num);
 		if (pmsg->flags & I2C_M_RD)
-			ret =
-			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+			ret = mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len,
+				       restart | (pmsg->flags & ~CCR_MASK));
 		else
-			ret =
-			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+			ret = mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len,
+				       restart | (pmsg->flags & ~CCR_MASK));
+		restart = CCR_RSTA;
 	}
 	mpc_i2c_stop(i2c);
 	return (ret < 0) ? ret : num;
-- 
1.7.7.6
