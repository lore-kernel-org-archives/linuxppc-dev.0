Subject: Re: [PATCH][RFC]Updated MPC I2C driver
From: Matthew McClintock <mcclintock@freescale.com>
Reply-To: mcclintock@freescale.com
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>,
	Matthew McClintock <mcclintock@motorola.com>
In-Reply-To: <1088705955.28598.168.camel@localhost>
References: <1088705955.28598.168.camel@localhost>
Content-Type: multipart/mixed; boundary="=-1erBRxaFz7bX7VtnjkFR"
Message-Id: <1088693987.7555.60.camel@matthew-laptop>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 14:59:47 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-1erBRxaFz7bX7VtnjkFR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Adrian,

	The driver works well on both an mpc8540ads and a sandpoint here.
However, I just learned yesterday that i2c 32-bit read/writes on the
85xx will not always be guaranteed to work. So there does in fact need
to be an abstraction there for 8-bit/32-bit read/writes. I wrote up a
patch that does just that and it is attached, any suggestions or
different ways to implement it I would be glad to take a go at it if
your busy. I tested the patch on our mpc8540ads and sandpoint here, and
it seems to work well. One note: the FS_I2C_32BIT needs to be set in the
flags. Let me know what you think.

Regards,
Matthew

On Thu, 2004-07-01 at 18:19, Adrian Cox wrote:
> This version should support MPC8540 as well as MPC8245 and MPC107. I
> don't have MPC85xx hardware, so I'd like feedback from people who do.
> To use it on MPC107/824x requires the OCP patch that went by on the list
> on Tuesday. The support for MPC85xx is already in the kernel.
> If nobody has any complaints I'm ready to send it to Greg K-H.
> - Adrian Cox
> Humboldt Solutions Ltd.
--
Matthew McClintock <mcclintock@freescale.com>

--=-1erBRxaFz7bX7VtnjkFR
Content-Disposition: attachment; filename=mpc-i2c-byte-word.patch
Content-Type: text/x-patch; name=mpc-i2c-byte-word.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -purN linuxppc-2.5-i2c-bak/drivers/i2c/busses/i2c-mpc.c linuxppc-2.5-i2c/drivers/i2c/busses/i2c-mpc.c
--- linuxppc-2.5-i2c-bak/drivers/i2c/busses/i2c-mpc.c	2004-07-01 14:16:22.000000000 -0500
+++ linuxppc-2.5-i2c/drivers/i2c/busses/i2c-mpc.c	2004-07-01 14:47:39.000000000 -0500
@@ -72,18 +72,40 @@ struct mpc_i2c {
 	struct i2c_adapter adap;
 };

+static u32 mpc_i2c_read(struct mpc_i2c *i2c, char *addr)
+{
+	struct ocp_fs_i2c_data *i2c_data = i2c->ocpdef->additions;
+
+	if (i2c_data && (i2c_data->flags & FS_I2C_32BIT)) {
+		return readl(addr);
+	} else {
+		return readb(addr);
+	}
+}
+
+static void mpc_i2c_write(struct mpc_i2c *i2c, u32 val, char *addr)
+{
+	struct ocp_fs_i2c_data *i2c_data = i2c->ocpdef->additions;
+
+	if (i2c_data && (i2c_data->flags & FS_I2C_32BIT)) {
+		writel(val, addr);
+	} else {
+		writeb(val & 0xff, addr);
+	}
+}
+
 static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
 {
-	writel(x, i2c->base + MPC_I2C_CR);
+	mpc_i2c_write(i2c, x, i2c->base + MPC_I2C_CR);
 }

 static irqreturn_t mpc_i2c_isr(int irq, void *dev_id, struct pt_regs * regs)
 {
 	struct mpc_i2c *i2c = dev_id;
-	if (readl(i2c->base + MPC_I2C_SR) & CSR_MIF) {
+	if (mpc_i2c_read(i2c, i2c->base + MPC_I2C_SR) & CSR_MIF) {
 		/* Read again to allow register to stabilise */
-		i2c->interrupt = readl(i2c->base + MPC_I2C_SR);
-		writel(0, i2c->base + MPC_I2C_SR);
+		i2c->interrupt = mpc_i2c_read(i2c, i2c->base + MPC_I2C_SR);
+		mpc_i2c_write(i2c, 0, i2c->base + MPC_I2C_SR);
 		wake_up_interruptible(&i2c->queue);
 	}
 	return IRQ_HANDLED;
@@ -97,7 +119,7 @@ static int i2c_wait(struct mpc_i2c *i2c,
 	int result = 0;

 	if (i2c->ocpdef->irq == OCP_IRQ_NA) {
-		while(! (readl(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
+		while(! (mpc_i2c_read(i2c, i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (orig_jiffies + timeout < jiffies) {
 				DPRINTK("I2C: timeout\n");
@@ -105,8 +127,8 @@ static int i2c_wait(struct mpc_i2c *i2c,
 				break;
 			}
 		}
-		x = readl(i2c->base + MPC_I2C_SR);
-		writel(0, i2c->base + MPC_I2C_SR);
+		x = mpc_i2c_read(i2c, i2c->base + MPC_I2C_SR);
+		mpc_i2c_write(i2c, 0, i2c->base + MPC_I2C_SR);
 	} else {
 		add_wait_queue(&i2c->queue, &wait);
 		while ( ! (i2c->interrupt & CSR_MIF)) {
@@ -158,12 +180,12 @@ static void mpc_i2c_start(struct mpc_i2c
 	struct ocp_fs_i2c_data *i2c_data = i2c->ocpdef->additions;
         /* Set clock and filters */
 	if (i2c_data && (i2c_data->flags & FS_I2C_SEPARATE_DFSRR)) {
-		writel(0x31, i2c->base + MPC_I2C_FDR);
-		writel(0x10, i2c->base + MPC_I2C_DFSRR);
+		mpc_i2c_write(i2c, 0x31, i2c->base + MPC_I2C_FDR);
+		mpc_i2c_write(i2c, 0x10, i2c->base + MPC_I2C_DFSRR);
 	} else
-		writel(0x1031, i2c->base + MPC_I2C_FDR);
+		mpc_i2c_write(i2c, 0x1031, i2c->base + MPC_I2C_FDR);
         /* Clear arbitration */
-        writel(0, i2c->base + MPC_I2C_SR);
+        mpc_i2c_write(i2c, 0, i2c->base + MPC_I2C_SR);
        	/* Start with MEN */
 	writeccr(i2c, CCR_MEN);
 }
@@ -187,14 +209,14 @@ static int mpc_write(struct mpc_i2c *i2c
 	writeccr(i2c, CCR_MIEN | CCR_MEN |
 		      CCR_MSTA | CCR_MTX | flags);
 	/* Write target byte */
-	writel((target << 1), i2c->base + MPC_I2C_DR);
+	mpc_i2c_write(i2c, (target << 1), i2c->base + MPC_I2C_DR);

 	if (i2c_wait(i2c, timeout, 1) < 0)
 	    return -1;

         for(i = 0; i < length; i++) {
 	        /* Write data byte */
-	        writel(data[i], i2c->base + MPC_I2C_DR);
+	        mpc_i2c_write(i2c, data[i], i2c->base + MPC_I2C_DR);

 	        if (i2c_wait(i2c, timeout, 1) < 0)
 	            return -1;
@@ -217,7 +239,7 @@ static int mpc_read(struct mpc_i2c *i2c,
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA |
 		      CCR_MTX | flags);
 	/* Write target address byte - this time with the read flag set */
-	writel((target << 1) | 1, i2c->base + MPC_I2C_DR);
+	mpc_i2c_write(i2c, (target << 1) | 1, i2c->base + MPC_I2C_DR);

 	if (i2c_wait(i2c, timeout, 0) < 0)
 	    return -1;
@@ -228,7 +250,7 @@ static int mpc_read(struct mpc_i2c *i2c,
 	else
 	    writeccr(i2c, CCR_MIEN| CCR_MEN | CCR_MSTA);
     	/* Dummy read */
-	readl(i2c->base + MPC_I2C_DR);
+	mpc_i2c_read(i2c, i2c->base + MPC_I2C_DR);

 	for(i = 0; i < length; i++) {
 		if (i2c_wait(i2c, timeout, 0) < 0)
@@ -242,7 +264,7 @@ static int mpc_read(struct mpc_i2c *i2c,
 		if (i == length - 1)
 			writeccr(i2c, CCR_MIEN | CCR_MEN |
 				      CCR_TXAK);
-		data[i] = readl(i2c->base + MPC_I2C_DR);
+		data[i] = mpc_i2c_read(i2c, i2c->base + MPC_I2C_DR);
 	}

 	return length;
@@ -260,7 +282,7 @@ static int mpc_xfer(struct i2c_adapter *
         mpc_i2c_start(i2c);

 	/* Allow bus up to 1s to become not busy */
-	while(readl(i2c->base + MPC_I2C_SR) & CSR_MBB) {
+	while(mpc_i2c_read(i2c, i2c->base + MPC_I2C_SR) & CSR_MBB) {
                 if (signal_pending(current))
 		{
 			DPRINTK("I2C: Interrupted\n");

--=-1erBRxaFz7bX7VtnjkFR--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
