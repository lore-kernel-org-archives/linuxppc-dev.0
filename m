Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 8D175DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 16:33:40 +1000 (EST)
Date: Wed, 11 Jul 2007 08:33:35 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] i2c-mpc: work around missing-9th-clock-pulse bug
Message-ID: <20070711063335.GB4375@moe.telargo.com>
References: <20070709071955.GD4186@moe.telargo.com>
	<fa686aa40707090853j6079b0c7rbcff7c449baa15e0@mail.gmail.com>
	<20070710061736.GG4186@moe.telargo.com>
	<fa686aa40707092322v58bbdad0veb0ee2ec00f125b0@mail.gmail.com>
	<20070710144030.3786cbf3@hyperion.delvare>
	<20070711054923.GA4375@moe.telargo.com>
	<fa686aa40707102303k58bae578u7358b932c4721ec0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40707102303k58bae578u7358b932c4721ec0@mail.gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/07/07 00:03 -0600, Grant Likely wrote:
> On 7/10/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> >On 10/07/07 14:40 +0200, Jean Delvare wrote:
...
> >+/* Sometimes 9th clock pulse isn't generated, so slave doesn't release
> >+ * the bus.  Documented and suggested workaround on
> >+ * http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> >+ */
> 
> I don't think it's a great idea to use a link;  You should copy the
> important parts into the .c file.  Archives may not be forever, and
> links cannot be read when offline.  If the text is too long for the
> middle of the C file; then put the documentation at the top right
> after the header block.

And v4:
<----------- cut ------------->

Work around a problem reported on:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
Without this patch I2C on mpc5200 becomes unusable after a while.
Tested on mpc5200 boards by Matthias Fechner and me.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 drivers/i2c/busses/i2c-mpc.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
+++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
@@ -74,6 +74,25 @@ static irqreturn_t mpc_i2c_isr(int irq, 
 	return IRQ_HANDLED;
 }
 
+/* Sometimes 9th clock pulse isn't generated, and slave doesn't release
+ * the bus, because it wants to send ACK.
+ * Following sequence of enabling/disabling and sending start/stop generates
+ * the pulse, so it's all OK.
+ */
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
@@ -153,6 +172,7 @@ static void mpc_i2c_start(struct mpc_i2c
 static void mpc_i2c_stop(struct mpc_i2c *i2c)
 {
 	writeccr(i2c, CCR_MEN);
+	writeccr(i2c, 0);
 }
 
 static int mpc_write(struct mpc_i2c *i2c, int target,
@@ -245,6 +265,8 @@ static int mpc_xfer(struct i2c_adapter *
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
 			pr_debug("I2C: timeout\n");
+			if (readb(i2c->base + MPC_I2C_SR) == (CSR_MCF | CSR_MBB | CSR_RXAK))
+				mpc_i2c_fixup(i2c);
 			return -EIO;
 		}
 		schedule();
