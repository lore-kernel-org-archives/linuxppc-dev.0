Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7089FDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 06:56:51 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 3B4A01C15408
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 20:58:49 +0100 (CET)
Received: from lancy.denx.de (p4FE64C03.dip.t-dialin.net [79.230.76.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 508059015D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 20:56:49 +0100 (CET)
Message-ID: <49C151FF.1080604@grandegger.com>
Date: Wed, 18 Mar 2009 20:56:47 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [RFC] powerpc: i2c-mpc: make I2C bus speed configurable
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The I2C driver for the MPC still uses a fixed clock divider hard-coded
into the driver. This issue has already been discussed twice:

 http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21933.html
 http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg26923.html

Let's code speak ;-). The attached RFC patch used the following approach:

- the SOC property "i2c-clock-frequency" defines the frequency of the
  I2C source clock, which could be filled in by U-Boot. This avoids all
  the fiddling with getting the proper source clock frequency for the
  processor or board. I will provide a patch for U-Boot if this proposal
  gets accepted.

- the I2C node uses the property "clock-frequency" to define the desired
  I2C bus frequency. If 0, the FDR/DFSRR register already set by the
  bootloader will not be touched.

- I use Timur's divider table approach from U-Boot as it's more
  efficient than an appropriate algorithm (less code).

- If none of the above new properties are defined, the old hard-coded
  FDR/DFSRR register settings are used for backward compatibility.

I have tested the speed settings basically on an MPC8544 and MPC5200
board. The 8xxx table may need some tweaking/conversion for the 82xx.

What do you think? I'm still not happy that the tables and lookup
function are common code. But for the 82xx/85xx/86xx it's not obvious
to me where to put it.

Note: I'm aware that this patch is not yet perfect, e.g. the documentation
of the new bindings are missing and debug messages need to be removed.

Wolfgang.

---
 drivers/i2c/busses/i2c-mpc.c |  140 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 128 insertions(+), 12 deletions(-)

Index: linux-2.6.29-rc7/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6.29-rc7.orig/drivers/i2c/busses/i2c-mpc.c
+++ linux-2.6.29-rc7/drivers/i2c/busses/i2c-mpc.c
@@ -58,6 +58,11 @@ struct mpc_i2c {
 	u32 flags;
 };
 
+struct mpc_i2c_div {
+	u16 divider;
+	u16 fdr;	/* including dfsrr */
+};
+
 static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
 {
 	writeb(x, i2c->base + MPC_I2C_CR);
@@ -153,16 +158,107 @@ static int i2c_wait(struct mpc_i2c *i2c,
 	return 0;
 }
 
-static void mpc_i2c_setclock(struct mpc_i2c *i2c)
+static const struct mpc_i2c_div mpc_i2c_8xxx_divs[] = {
+	{160, 0x0120}, {192, 0x0121}, {224, 0x0122}, {256, 0x0123},
+	{288, 0x0100}, {320, 0x0101}, {352, 0x0601}, {384, 0x0102},
+	{416, 0x0602}, {448, 0x0126}, {480, 0x0103}, {512, 0x0127},
+	{544, 0x0b03}, {576, 0x0104}, {608, 0x1603}, {640, 0x0105},
+	{672, 0x2003}, {704, 0x0b05}, {736, 0x2b03}, {768, 0x0106},
+	{800, 0x3603}, {832, 0x0b06}, {896, 0x012a}, {960, 0x0107},
+	{1024, 0x012b}, {1088, 0x1607}, {1152, 0x0108}, {1216, 0x2b07},
+	{1280, 0x0109}, {1408, 0x1609}, {1536, 0x010a}, {1664, 0x160a},
+	{1792, 0x012e}, {1920, 0x010b}, {2048, 0x012f}, {2176, 0x2b0b},
+	{2304, 0x010c}, {2560, 0x010d}, {2816, 0x2b0d}, {3072, 0x010e},
+	{3328, 0x2b0e}, {3584, 0x0132}, {3840, 0x010f}, {4096, 0x0133},
+	{4608, 0x0110}, {5120, 0x0111}, {6144, 0x0112}, {7168, 0x0136},
+	{7680, 0x0113}, {8192, 0x0137}, {9216, 0x0114}, {10240, 0x0115},
+	{12288, 0x0116}, {14336, 0x013a}, {15360, 0x0117}, {16384, 0x013b},
+	{18432, 0x0118}, {20480, 0x0119}, {24576, 0x011a}, {28672, 0x013e},
+	{30720, 0x011b}, {32768, 0x013f}, {36864, 0x011c}, {40960, 0x011d},
+	{49152, 0x011e}, {61440, 0x011f}
+};
+
+/*
+ * Works for both, MPC5200 rev A and rev B processors. The rev B
+ * processors have 2 more bits, which are not used in the table below.
+ */
+static const struct mpc_i2c_div mpc_i2c_52xx_divs[] = {
+	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
+	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
+	{36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
+	{56, 0x29}, {64, 0x2a}, {68, 0x07}, {72, 0x2b},
+	{80, 0x2c}, {88, 0x09}, {96, 0x2d}, {104, 0x0a},
+	{112, 0x2e}, {128, 0x2f}, {144, 0x0c}, {160, 0x30},
+	{192, 0x31}, {224, 0x32}, {240, 0x0f}, {256, 0x33},
+	{288, 0x10}, {320, 0x34}, {384, 0x35}, {448, 0x36},
+	{480, 0x13}, {512, 0x37}, {576, 0x14}, {640, 0x38},
+	{768, 0x39}, {896, 0x3a}, {960, 0x17}, {1024, 0x3b},
+	{1152, 0x18}, {1280, 0x3c}, {1536, 0x3d}, {1792, 0x3e},
+	{1920, 0x1b}, {2048, 0x3f}, {2304, 0x1c}, {2560, 0x1d},
+	{3072, 0x1e}, {3840, 0x1f}
+};
+
+static u16 mpc_i2c_get_fdr(const struct mpc_i2c_div *divs, int count,
+			   u32 divider)
 {
-	/* Set clock and filters */
-	if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
-		writeb(0x31, i2c->base + MPC_I2C_FDR);
-		writeb(0x10, i2c->base + MPC_I2C_DFSRR);
-	} else if (i2c->flags & FSL_I2C_DEV_CLOCK_5200)
-		writeb(0x3f, i2c->base + MPC_I2C_FDR);
-	else
-		writel(0x1031, i2c->base + MPC_I2C_FDR);
+	const struct mpc_i2c_div *div = NULL;
+	int i;
+
+	/*
+	 * We want to choose an FDR/DFSR that generates an I2C bus speed that
+	 * is equal to or lower than the requested speed.
+	 */
+	for (i = 0; i < count; i++) {
+		div = &divs[i];
+		if (div->divider >= divider)
+			break;
+	}
+
+	return div ? div->fdr : 0;
+}
+
+static void mpc_i2c_setclock(struct mpc_i2c *i2c, u32 src_clock, u32 clock)
+{
+	u32 divider;
+	u16 fdr;
+
+	if (src_clock && !clock)
+		return; /* clock already configured by bootloader */
+
+	divider = (src_clock && clock) ? src_clock / clock : 0;
+
+	if (i2c->flags & FSL_I2C_DEV_CLOCK_5200) {
+		printk("I2C: old fdr=%d\n", readb(i2c->base + MPC_I2C_FDR));
+		if (divider)
+			fdr = mpc_i2c_get_fdr(mpc_i2c_52xx_divs,
+					      ARRAY_SIZE(mpc_i2c_52xx_divs),
+					      divider);
+		else
+			fdr = 0x3f; /* backward compatibility */
+		writeb(fdr, i2c->base + MPC_I2C_FDR);
+		printk("I2C: clock %d Hz (fdr=%d)\n", clock, fdr);
+	} else {
+		if (divider)
+			fdr = mpc_i2c_get_fdr(mpc_i2c_8xxx_divs,
+					      ARRAY_SIZE(mpc_i2c_8xxx_divs),
+					      divider);
+		else
+			fdr = 0x1031; /* backward compatibility */
+		if (i2c->flags & FSL_I2C_DEV_SEPARATE_DFSRR) {
+			printk("I2C: old dfsrr=%d fdr=%d\n",
+			       readb(i2c->base + MPC_I2C_DFSRR),
+			       readb(i2c->base + MPC_I2C_FDR));
+			writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
+			writeb(fdr >> 8, i2c->base + MPC_I2C_DFSRR);
+			printk("I2C: clock %d Hz (dfsrr=%d fdr=%d)\n",
+			       clock, fdr >> 8, fdr & 0xff);
+		} else {
+			printk("I2C: old fdr=%d\n",
+			       readl(i2c->base + MPC_I2C_FDR));
+			writel(fdr, i2c->base + MPC_I2C_FDR);
+			printk("I2C: clock %d Hz (fdr=%d)\n", clock, fdr);
+		}
+	}
 }
 
 static void mpc_i2c_start(struct mpc_i2c *i2c)
@@ -316,13 +412,33 @@ static struct i2c_adapter mpc_ops = {
 
 static int __devinit fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
 {
-	int result = 0;
+	struct device_node *parent;
 	struct mpc_i2c *i2c;
+	const u32 *prop;
+	u32 src_clock, clock;
+	int result = 0;
+	int plen;
+
+	parent = of_get_parent(op->node);
+	if (!parent)
+		return -ENODEV;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
+	prop = of_get_property(parent, "i2c-clock-frequency", &plen);
+	if (prop && plen == sizeof(u32))
+		src_clock = *prop;
+	else
+		src_clock = 0;
+
+	prop = of_get_property(op->node, "clock-frequency", &plen);
+	if (prop && plen == sizeof(u32))
+		clock = *prop;
+	else
+		clock = 0;
+
 	if (of_get_property(op->node, "dfsrr", NULL))
 		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
 
@@ -348,8 +464,8 @@ static int __devinit fsl_i2c_probe(struc
 			goto fail_request;
 		}
 	}
-	
-	mpc_i2c_setclock(i2c);
+
+	mpc_i2c_setclock(i2c, src_clock, clock);
 
 	dev_set_drvdata(&op->dev, i2c);
 
