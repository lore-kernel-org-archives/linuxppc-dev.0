Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 8D234DDF12
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 12:55:58 +1100 (EST)
Message-ID: <49124EAD.8090508@consentry.com>
Date: Wed, 05 Nov 2008 17:55:57 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org, jochen@scram.de
Subject: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and filter.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the ability to enable the digital filter in the device
tree (with the "clock-filter" boolean property) and automates the
predivider selection according to the clock-frequency and clock-filter
properties.  This allows use of a wider range of I2C bus frequencies.

Signed-off-by:  Mike Ditto <mditto@consentry.com>
---
This patch is against 2.6.27.

To use the full range of I2C clock frequencies supported by the
Freescale CPM I2C controller, it is necessary to choose an appropriate
predivider value.  The choice is affected by whether the SCL signal
digital filter is enabled.

The existing code computes the final divider (i2brg) but always uses
a predivider of 32.  This can set illegal values in i2brg - for example
on a machine with 25 MHz BRG_CLK, when selecting I2C clock-frequency
97656 Hz, the code was loading i2brg with the value 1, which does not
work (the CPM requires a minimum value of 3 when the digital filter is
not enabled).  Additionally, the calculation did not work when the
filter is enabled (and the driver did not provide a way to enable it).

Index: linux/drivers/i2c/busses/i2c-cpm.c
===================================================================
diff -u -p -r1.1.1.1 i2c-cpm.c
--- linux/drivers/i2c/busses/i2c-cpm.c	11 Oct 2008 02:53:07 -0000	1.1.1.1
+++ linux/drivers/i2c/busses/i2c-cpm.c	6 Nov 2008 01:45:15 -0000
@@ -87,6 +87,11 @@ struct i2c_ram {
 #define I2CER_TXB	0x02
 #define I2CER_RXB	0x01
 #define I2MOD_EN	0x01
+#define I2MOD_PDIV_32	0x00	/* BRGCLK/32 */
+#define I2MOD_PDIV_16	0x02	/* BRGCLK/16 */
+#define I2MOD_PDIV_8	0x04	/* BRGCLK/8 */
+#define I2MOD_PDIV_4	0x06	/* BRGCLK/4 */
+#define I2MOD_FLT	0x08

 /* I2C Registers */
 struct i2c_reg {
@@ -111,7 +116,6 @@ struct cpm_i2c {
 	int version; /* CPM1=1, CPM2=2 */
 	int irq;
 	int cp_command;
-	int freq;
 	struct i2c_reg __iomem *i2c_reg;
 	struct i2c_ram __iomem *i2c_ram;
 	u16 i2c_addr;
@@ -365,6 +369,7 @@ static int cpm_i2c_xfer(struct i2c_adapt
 		pmsg = &msgs[tptr];
 		if (pmsg->flags & I2C_M_RD)
 			ret = wait_event_interruptible_timeout(cpm->i2c_wait,
+				(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_NAK) ||
 				!(in_be16(&rbdf[rptr].cbd_sc) & BD_SC_EMPTY),
 				1 * HZ);
 		else
@@ -434,7 +439,8 @@ static int __devinit cpm_i2c_setup(struc
 	void __iomem *i2c_base;
 	cbd_t __iomem *tbdf;
 	cbd_t __iomem *rbdf;
-	unsigned char brg;
+	uint freq, maxfreq, prediv;
+	unsigned char mod, brg;

 	dev_dbg(&cpm->ofdev->dev, "cpm_i2c_setup()\n");

@@ -508,9 +514,15 @@ static int __devinit cpm_i2c_setup(struc

 	data = of_get_property(ofdev->node, "clock-frequency", &len);
 	if (data && len == 4)
-		cpm->freq = *data;
+		freq = *data;
 	else
-		cpm->freq = 60000; /* use 60kHz i2c clock by default */
+		freq = 60000;	/* use 60kHz I2C clock by default */
+
+	data = of_get_property(ofdev->node, "clock-filter", &len);
+	if (data && len == 0)
+		mod = I2MOD_FLT;
+	else
+		mod = 0;

 	/*
 	 * Allocate space for CPM_MAXBD transmit and receive buffer
@@ -552,8 +564,8 @@ static int __devinit cpm_i2c_setup(struc

 	cpm_reset_i2c_params(cpm);

-	dev_dbg(&cpm->ofdev->dev, "i2c_ram 0x%p, i2c_addr 0x%04x, freq %d\n",
-		cpm->i2c_ram, cpm->i2c_addr, cpm->freq);
+	dev_dbg(&cpm->ofdev->dev, "i2c_ram 0x%p, i2c_addr 0x%04x, freq %u\n",
+		cpm->i2c_ram, cpm->i2c_addr, freq);
 	dev_dbg(&cpm->ofdev->dev, "tbase 0x%04x, rbase 0x%04x\n",
 		(u8 __iomem *)cpm->tbase - DPRAM_BASE,
 		(u8 __iomem *)cpm->rbase - DPRAM_BASE);
@@ -566,14 +578,48 @@ static int __devinit cpm_i2c_setup(struc
 	out_8(&cpm->i2c_reg->i2add, 0x7f << 1);

 	/*
-	 * PDIV is set to 00 in i2mod, so brgclk/32 is used as input to the
-	 * i2c baud rate generator. This is divided by 2 x (DIV + 3) to get
-	 * the actual i2c bus frequency.
+	 * Compute the clock predivider and final divider to generate something
+	 * close to the desired I2C clock frequency.  Use the largest predivider
+	 * possible.  i2brg must be >= 6 when using I2MOD_FLT, otherwise >= 3.
+	 * So compute the highest frequency that will work with I2MOD_PDIV_32;
+	 * if that isn't high enough, see if we can use I2MOD_PDIV_16, etc.
+	 * Then choose a final divider that will generate at least the desired
+	 * clock frequency.  Note the "at least" -- this rounds upward, not
+	 * toward the nearest available frequency.
+	 *
+	 * I2C frequency for a given predivider and i2brg value is:
+	 *   i2cfreq = brgfreq / prediv / 2 / (i2brg + 3 + 2 * flt)
+	 * i2brg value for a given predivider and I2C frequency is:
+	 *   i2brg = (brgfreq / prediv / 2 / i2cfreq) - 3 - 2 * flt
+	 * Minimum allowed i2brg is (3 + 3 * flt).
+	 * Maximum freq possible for a given predivider is:
+	 *   maxfreq = brgfreq / prediv / 2 / (3 + 3 + 5 * flt)
 	 */
-	brg = get_brgfreq() / (32 * 2 * cpm->freq) - 3;
-	out_8(&cpm->i2c_reg->i2brg, brg);
+	maxfreq = get_brgfreq() / 64 / ((mod & I2MOD_FLT) ? 11 : 6);
+	if (freq <= maxfreq) {		/* Works with predivider 32? */
+		mod |= I2MOD_PDIV_32;
+		prediv = 32;
+	} else if (freq <= maxfreq*2) {	/* How about 16? */
+		mod |= I2MOD_PDIV_16;
+		prediv = 16;
+	} else if (freq <= maxfreq*4) {	/* How about 8? */
+		mod |= I2MOD_PDIV_8;
+		prediv = 8;
+	} else {			/* 4 is last resort. */
+		if (freq > maxfreq*8)
+			/* Impossibly high clock-frequency requested. */
+			freq = maxfreq*8;
+		mod |= I2MOD_PDIV_4;
+		prediv = 4;
+	}
+	brg = get_brgfreq() / prediv / 2 / freq - ((mod & I2MOD_FLT) ? 5 : 3);
+
+	freq = get_brgfreq() / prediv / 2 / (brg + ((mod & I2MOD_FLT) ? 5 : 3));
+	dev_dbg(&cpm->ofdev->dev, "i2mod 0x%02x, i2brg %u, actual freq %u\n",
+		mod, brg, freq);

-	out_8(&cpm->i2c_reg->i2mod, 0x00);
+	out_8(&cpm->i2c_reg->i2brg, brg);
+	out_8(&cpm->i2c_reg->i2mod, mod);
 	out_8(&cpm->i2c_reg->i2com, I2COM_MASTER);	/* Master mode */

 	/* Disable interrupts. */
Index: linux/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt
===================================================================
diff -u -p -r1.1.1.1 i2c.txt
--- linux/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt	11 Oct 2008 02:49:31 -0000	1.1.1.1
+++ linux/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt	6 Nov 2008 01:29:58 -0000
@@ -10,8 +10,13 @@ Properties:
 - #address-cells : Should be one. The cell is the i2c device address with
   the r/w bit set to zero.
 - #size-cells : Should be zero.
-- clock-frequency : Can be used to set the i2c clock frequency. If
-  unspecified, a default frequency of 60kHz is being used.
+- clock-frequency : Can be used to set the desired i2c clock frequency (in Hz).
+  If unspecified, a default of 60 kHz is used.  The actual frequency may be
+  somewhat higher than this value, depending on how the BRG_CLK and dividers
+  work out.
+- clock-filter : boolean; if defined, indicates that the hardware has
+  electrical or usage characteristics that can result in noise on the SCL
+  signal.  The driver will enable the SCL digital filter.
 The following two properties are deprecated. They are only used by legacy
 i2c drivers to find the bus to probe:
 - linux,i2c-index : Can be used to hard code an i2c bus number. By default,
