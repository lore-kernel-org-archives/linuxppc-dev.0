Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id A4EE7B7CCD
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jan 2010 07:25:14 +1100 (EST)
Date: Fri, 22 Jan 2010 21:17:55 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH/RFC 1/2] 5200: improve i2c bus error recovery
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Devicetree Discussions
	<devicetree-discuss@lists.ozlabs.org>, "Ben Dooks (embedded platforms)"
	<ben-linux@fluff.org>
Message-Id: <1264191475.2224.1@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Improve the recovery of the MPC5200B's I2C bus from errors like bus
hangs.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

---

This patch introduces several improvements to the MPC5200B's I2C driver
as to improve the recovery from error conditions I encountered when
testing a custom board with several I2C devices attached (eeprom, io
expander, rtc, sensors).  The error conditions included cases where the
bus if logic of one slave apparently went south, blocking the bus
completely.

My fixes include:
1. make the bus timeout configurable in fsl_i2c_probe(); the default of
   one second is *way* too long for my use case;
2. if a timeout condition occurs in mpc_xfer(), mpc_i2c_fixup() the bus
   if *any* of the CF, BB and RXAK flags in the MSR is 1.  I actually
   saw different combinations with hangs, not only all three set;
3. improve the fixup procedure by calculating the timing needed from the
   real (configured) bus clock, calculated in mpc_i2c_setclock_52xx().
   Furthermore, I issue 9 instead of one cycle, as I experienced cases
   where the single one is not enough (found this tip in a forum).  As a
   side effect, the new scheme needs only 81us @375kHz bus clock instead
   of 150us.  I recorded waveforms for 18.4kHz, 85.9kHz and 375kHz, all
   looking fine, which I can provide if anyone is interested.

Open questions:
- is the approach correct at all, in particular the interpretation of
  the flags (#2)?
- could this code also be used on non-5200 processors?

--- linux-2.6.32-orig/drivers/i2c/busses/i2c-mpc.c	2009-12-03 04:51:21.0000=
00000 +0100
+++ linux-2.6.32/drivers/i2c/busses/i2c-mpc.c	2010-01-22 16:05:13.000000000=
 +0100
@@ -59,6 +59,7 @@ struct mpc_i2c {
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
 	int irq;
+	u32 real_clk;
 };
=20
 struct mpc_i2c_divider {
@@ -97,16 +98,32 @@ static irqreturn_t mpc_i2c_isr(int irq,=20
  */
 static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 {
-	writeccr(i2c, 0);
-	udelay(30);
-	writeccr(i2c, CCR_MEN);
-	udelay(30);
-	writeccr(i2c, CCR_MSTA | CCR_MTX);
-	udelay(30);
-	writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
-	udelay(30);
-	writeccr(i2c, CCR_MEN);
-	udelay(30);
+	if (i2c->real_clk =3D=3D 0) {
+		writeccr(i2c, 0);
+		udelay(30);
+		writeccr(i2c, CCR_MEN);
+		udelay(30);
+		writeccr(i2c, CCR_MSTA | CCR_MTX);
+		udelay(30);
+		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
+		udelay(30);
+		writeccr(i2c, CCR_MEN);
+		udelay(30);
+	} else {
+		int k;
+		u32 delay_val =3D 1000000 / i2c->real_clk + 1;
+
+		if (delay_val < 2)
+			delay_val =3D 2;
+
+		for (k =3D 9; k; k--) {
+			writeccr(i2c, 0);
+			writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
+			udelay(delay_val);
+			writeccr(i2c, CCR_MEN);
+			udelay(delay_val << 1);
+		}
+	}
 }
=20
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
@@ -186,15 +203,18 @@ static const struct mpc_i2c_divider mpc_
 	{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
 };
=20
-int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescale=
r)
+int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescale=
r,
+			 u32 *real_clk)
 {
 	const struct mpc_i2c_divider *div =3D NULL;
 	unsigned int pvr =3D mfspr(SPRN_PVR);
 	u32 divider;
 	int i;
=20
-	if (!clock)
+	if (!clock) {
+		*real_clk =3D 0;
 		return -EINVAL;
+	}
=20
 	/* Determine divider value */
 	divider =3D mpc5xxx_get_bus_frequency(node) / clock;
@@ -212,7 +232,8 @@ int mpc_i2c_get_fdr_52xx(struct device_n
 			break;
 	}
=20
-	return div ? (int)div->fdr : -EINVAL;
+	*real_clk =3D mpc5xxx_get_bus_frequency(node) / div->divider;
+	return (int)div->fdr;
 }
=20
 static void mpc_i2c_setclock_52xx(struct device_node *node,
@@ -221,13 +242,14 @@ static void mpc_i2c_setclock_52xx(struct
 {
 	int ret, fdr;
=20
-	ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler);
+	ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler, &i2c->real_clk);
 	fdr =3D (ret >=3D 0) ? ret : 0x3f; /* backward compatibility */
=20
 	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
=20
 	if (ret >=3D 0)
-		dev_info(i2c->dev, "clock %d Hz (fdr=3D%d)\n", clock, fdr);
+		dev_info(i2c->dev, "clock %u Hz (fdr=3D%d)\n", i2c->real_clk,
+			 fdr);
 }
 #else /* !CONFIG_PPC_MPC52xx */
 static void mpc_i2c_setclock_52xx(struct device_node *node,
@@ -446,10 +468,14 @@ static int mpc_xfer(struct i2c_adapter *
 			return -EINTR;
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
+			u8 status =3D readb(i2c->base + MPC_I2C_SR);
+
 			dev_dbg(i2c->dev, "timeout\n");
-			if (readb(i2c->base + MPC_I2C_SR) =3D=3D
-			    (CSR_MCF | CSR_MBB | CSR_RXAK))
+			if ((status & (CSR_MCF | CSR_MBB | CSR_RXAK)) !=3D 0) {
+				writeb(status & ~CSR_MAL,
+				       i2c->base + MPC_I2C_SR);
 				mpc_i2c_fixup(i2c);
+			}
 			return -EIO;
 		}
 		schedule();
@@ -540,6 +566,14 @@ static int __devinit fsl_i2c_probe(struc
 		}
 	}
=20
+	prop =3D of_get_property(op->node, "timeout", &plen);
+	if (prop && plen =3D=3D sizeof(u32)) {
+		mpc_ops.timeout =3D *prop * HZ / 1000000;
+		if (mpc_ops.timeout < 5)
+			mpc_ops.timeout =3D 5;
+	}
+	dev_info(i2c->dev, "timeout %u us\n", mpc_ops.timeout * 1000000 / HZ);
+
 	dev_set_drvdata(&op->dev, i2c);
=20
 	i2c->adap =3D mpc_ops;
