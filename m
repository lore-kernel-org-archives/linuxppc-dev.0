Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id D0B44B7CBD
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 05:59:18 +1100 (EST)
Date: Wed, 17 Feb 2010 19:59:14 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: Linux PPC Development <linuxppc-dev@ozlabs.org>, Devicetree Discussions
	<devicetree-discuss@lists.ozlabs.org>, Grant Likely
	<grant.likely@secretlab.ca>, "Ben Dooks (embedded platforms)"
	<ben-linux@fluff.org>
Message-Id: <1266433154.2322.0@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch improves the recovery of the MPC's I2C bus from errors like bus
hangs resulting in timeouts:
1. make the bus timeout configurable, as it depends on the bus clock and
    the attached slave chip(s); default is still 1 second;
2. detect any of the cases indicated by the CF, BB and RXAK MSR flags if a
    timeout occurs, and add a missing (required) MAL reset;
3. use a more reliable method to fixup the bus if a hang has been detected.
    The sequence is sent 9 times which seems to be necessary if a slave
    "misses" more than one clock cycle.  For 400 kHz bus speed, the fixup i=
s
    also ~70us (81us vs. 150us) faster.

Tested on a custom Lite5200b derived board, with a Dallas RTC, AD sensors
and NXP IO expander chips attached to the i2c.

Changes vs. v1:
- use improved bus fixup sequence for all chips (not only the 5200)
- calculate real clock from defaults if no clock is given in the device tre=
e
- better description (I hope) of the changes.

I didn't split the changes in this file into three parts as recommended by
Grant, as they actually belong together (i.e. they address one single
problem, just in three places of one single source file).

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

---

Note about the reset sequence: I verified the waveforms for 18.4kHz, 85.9kH=
z
and 375kHz (drop me a note if you want to see scope screen shots).  Not
verified on other mpc chips yet.
@Ira: thanks in advance for giving it a try on your box!


--- linux-2.6.32-orig/drivers/i2c/busses/i2c-mpc.c	2009-12-03 04:51:21.0000=
00000 +0100
+++ linux-2.6.32/drivers/i2c/busses/i2c-mpc.c	2010-02-17 16:23:11.000000000=
 +0100
@@ -59,6 +59,7 @@ struct mpc_i2c {
  	wait_queue_head_t queue;
  	struct i2c_adapter adap;
  	int irq;
+	u32 real_clk;
  };

  struct mpc_i2c_divider {
@@ -93,20 +94,23 @@ static irqreturn_t mpc_i2c_isr(int irq,
  /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
   * the bus, because it wants to send ACK.
   * Following sequence of enabling/disabling and sending start/stop genera=
tes
- * the pulse, so it's all OK.
+ * the 9 pulses, so it's all OK.
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
+	int k;
+	u32 delay_val =3D 1000000 / i2c->real_clk + 1;
+
+	if (delay_val < 2)
+		delay_val =3D 2;
+
+	for (k =3D 9; k; k--) {
+		writeccr(i2c, 0);
+		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
+		udelay(delay_val);
+		writeccr(i2c, CCR_MEN);
+		udelay(delay_val << 1);
+	}
  }

  static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
@@ -186,15 +190,19 @@ static const struct mpc_i2c_divider mpc_
  	{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
  };

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

-	if (!clock)
+	if (!clock) {
+		/* see below - default fdr =3D 0x3f -> div =3D 2048 */
+		*real_clk =3D mpc5xxx_get_bus_frequency(node) / 2048;
  		return -EINVAL;
+	}

  	/* Determine divider value */
  	divider =3D mpc5xxx_get_bus_frequency(node) / clock;
@@ -212,7 +220,8 @@ int mpc_i2c_get_fdr_52xx(struct device_n
  			break;
  	}

-	return div ? (int)div->fdr : -EINVAL;
+	*real_clk =3D mpc5xxx_get_bus_frequency(node) / div->divider;
+	return (int)div->fdr;
  }

  static void mpc_i2c_setclock_52xx(struct device_node *node,
@@ -221,13 +230,14 @@ static void mpc_i2c_setclock_52xx(struct
  {
  	int ret, fdr;

-	ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler);
+	ret =3D mpc_i2c_get_fdr_52xx(node, clock, prescaler, &i2c->real_clk);
  	fdr =3D (ret >=3D 0) ? ret : 0x3f; /* backward compatibility */

  	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);

  	if (ret >=3D 0)
-		dev_info(i2c->dev, "clock %d Hz (fdr=3D%d)\n", clock, fdr);
+		dev_info(i2c->dev, "clock %u Hz (fdr=3D%d)\n", i2c->real_clk,
+			 fdr);
  }
  #else /* !CONFIG_PPC_MPC52xx */
  static void mpc_i2c_setclock_52xx(struct device_node *node,
@@ -287,14 +297,18 @@ u32 mpc_i2c_get_sec_cfg_8xxx(void)
  	return val;
  }

-int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32 prescale=
r)
+int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock, u32 prescale=
r,
+			 u32 *real_clk)
  {
  	const struct mpc_i2c_divider *div =3D NULL;
  	u32 divider;
  	int i;

-	if (!clock)
+	if (!clock) {
+		/* see below - default fdr =3D 0x1031 -> div =3D 16 * 3072 */
+		*real_clk =3D fsl_get_sys_freq() / prescaler / (16 * 3072);
  		return -EINVAL;
+	}

  	/* Determine proper divider value */
  	if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
@@ -317,6 +331,7 @@ int mpc_i2c_get_fdr_8xxx(struct device_n
  			break;
  	}

+	*real_clk =3D fsl_get_sys_freq() / prescaler / div->divider;
  	return div ? (int)div->fdr : -EINVAL;
  }

@@ -326,7 +341,7 @@ static void mpc_i2c_setclock_8xxx(struct
  {
  	int ret, fdr;

-	ret =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
+	ret =3D mpc_i2c_get_fdr_8xxx(node, clock, prescaler, &i2c->real_clk);
  	fdr =3D (ret >=3D 0) ? ret : 0x1031; /* backward compatibility */

  	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
@@ -334,7 +349,7 @@ static void mpc_i2c_setclock_8xxx(struct

  	if (ret >=3D 0)
  		dev_info(i2c->dev, "clock %d Hz (dfsrr=3D%d fdr=3D%d)\n",
-			 clock, fdr >> 8, fdr & 0xff);
+			 i2c->real_clk, fdr >> 8, fdr & 0xff);
  }

  #else /* !CONFIG_FSL_SOC */
@@ -446,10 +461,14 @@ static int mpc_xfer(struct i2c_adapter *
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
@@ -540,6 +559,14 @@ static int __devinit fsl_i2c_probe(struc
  		}
  	}

+	prop =3D of_get_property(op->node, "fsl,timeout", &plen);
+	if (prop && plen =3D=3D sizeof(u32)) {
+		mpc_ops.timeout =3D *prop * HZ / 1000000;
+		if (mpc_ops.timeout < 5)
+			mpc_ops.timeout =3D 5;
+	}
+	dev_info(i2c->dev, "timeout %u us\n", mpc_ops.timeout * 1000000 / HZ);
+
  	dev_set_drvdata(&op->dev, i2c);

  	i2c->adap =3D mpc_ops;
