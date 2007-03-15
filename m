Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id BB171DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 20:58:06 +1100 (EST)
Date: Thu, 15 Mar 2007 10:57:58 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto read I2C on MPC5200 Lite
Message-ID: <20070315095758.GE14658@moe.telargo.com>
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
	<20070309113506.GB6726@server.idefix.lan>
	<4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
	<20070309234251.GA68997@server.idefix.lan>
	<20070311005535.GA39488@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070311005535.GA39488@server.idefix.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/03/07 01:55 +0100, Matthias Fechner wrote:
> Hi,
> 
> * Matthias Fechner <idefix@fechner.net> [10-03-07 00:42]:
> > It seems now that everything works fine. I will check it for the next
> > days. And will give some feedback.
> 
> ok, I checked now the driver some time at it failed. So it seems that
> that the patch had not solved the problem.
> 
> I have attached the programm to check it.

But not for built-in eeprom :-P
Anyway, I managed to reproduce some problems, and hopefully "fix" them.
One problem seems to be fixed by disabling i2c on stop,
another looks like it's:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html

Can you please try following patch.


	Domen


diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index ee65aa1..522f485 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -75,6 +75,20 @@ static irqreturn_t mpc_i2c_isr(int irq, 
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
@@ -154,6 +168,9 @@ static void mpc_i2c_start(struct mpc_i2c
 static void mpc_i2c_stop(struct mpc_i2c *i2c)
 {
 	writeccr(i2c, CCR_MEN);
+	mb();
+	writeccr(i2c, 0);
+	mb();
 }
 
 static int mpc_write(struct mpc_i2c *i2c, int target,
@@ -246,6 +263,8 @@ static int mpc_xfer(struct i2c_adapter *
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
 			pr_debug("I2C: timeout\n");
+			if (readb(i2c->base + MPC_I2C_SR) == (CSR_MCF | CSR_MBB | CSR_RXAK))
+				mpc_i2c_fixup(i2c);
 			return -EIO;
 		}
 		schedule();
