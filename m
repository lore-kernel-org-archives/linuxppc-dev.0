Return-Path: <wg@grandegger.com>
Message-ID: <49DDC718.8000706@grandegger.com>
Date: Thu, 09 Apr 2009 11:59:52 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
References: <20090407082052.477328750@denx.de>	<53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>	<F4E3E1FF-C544-460A-AC27-DB9501C13ED3@kernel.crashing.org>	<49DC515F.3040100@grandegger.com>	<E9E24C93-F147-49F0-9FBE-FCE4883D11BF@kernel.crashing.org>
	<49DD0144.7050902@grandegger.com>
In-Reply-To: <49DD0144.7050902@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Kumar Gala wrote:
>> On Apr 8, 2009, at 2:25 AM, Wolfgang Grandegger wrote:
>>
>>>> So I'm a bit concerned with the output we now get:
>>>>
>>>> mpc-i2c fffe03000.i2c: clock 0 Hz (dfsrr=16 fdr=49)
>>>>
>>>> why 0? is that right?
>>> This is the backward compatibility mode using hard-coded FDR values. The
>>> output is missleading, I agree.
>>>
>>> Wolfgang.
>> Can the output be fixed.  0 Hz seemed bad to me.
> 
> Of course. No info message will be printed for the legacy case
> like it was with the old driver version. I just realized a bug in the
> MPC52xx part. Will send patches tomorrow, after some more thorough testing.

The patch below fixes both issues. Ben, could you please apply it. Sorry for
the inconvenience caused.

Thanks,

Wolfgang.



[PATCH] i2c: i2c-mpc: bug fix for MPC52xx clock setting and printout

The clock setting did not work for the MPC52xx due to a stupid bug.
Furthermore, the dev info output "clock=0" for old device trees was
misleading. This patch fixes both issues.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/i2c/busses/i2c-mpc.c |   34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c	2009-04-08 21:51:31.771719368 +0200
+++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c	2009-04-09 11:18:45.812969033 +0200
@@ -164,7 +164,7 @@
 	return 0;
 }
 
-#ifdef CONFIG_PPC_52xx
+#ifdef CONFIG_PPC_MPC52xx
 static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
 	{20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
 	{28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
@@ -188,7 +188,7 @@
 
 int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescaler)
 {
-	const struct mpc52xx_i2c_divider *div = NULL;
+	const struct mpc_i2c_divider *div = NULL;
 	unsigned int pvr = mfspr(SPRN_PVR);
 	u32 divider;
 	int i;
@@ -203,7 +203,7 @@
 	 * We want to choose an FDR/DFSR that generates an I2C bus speed that
 	 * is equal to or lower than the requested speed.
 	 */
-	for (i = 0; i < ARRAY_SIZE(mpc52xx_i2c_dividers); i++) {
+	for (i = 0; i < ARRAY_SIZE(mpc_i2c_dividers_52xx); i++) {
 		div = &mpc_i2c_dividers_52xx[i];
 		/* Old MPC5200 rev A CPUs do not support the high bits */
 		if (div->fdr & 0xc0 && pvr == 0x80822011)
@@ -219,20 +219,23 @@
 				  struct mpc_i2c *i2c,
 				  u32 clock, u32 prescaler)
 {
-	int fdr = mpc52xx_i2c_get_fdr(node, clock, prescaler);
+	int ret, fdr;
+
+	ret = mpc_i2c_get_fdr_52xx(node, clock, prescaler);
+	fdr = (ret >= 0) ? ret : 0x3f; /* backward compatibility */
 
-	if (fdr < 0)
-		fdr = 0x3f; /* backward compatibility */
 	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
-	dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
+
+	if (ret >= 0)
+		dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
 }
-#else /* !CONFIG_PPC_52xx */
+#else /* !CONFIG_PPC_MPC52xx */
 static void mpc_i2c_setclock_52xx(struct device_node *node,
 				  struct mpc_i2c *i2c,
 				  u32 clock, u32 prescaler)
 {
 }
-#endif /* CONFIG_PPC_52xx*/
+#endif /* CONFIG_PPC_MPC52xx*/
 
 #ifdef CONFIG_FSL_SOC
 static const struct mpc_i2c_divider mpc_i2c_dividers_8xxx[] = {
@@ -321,14 +324,17 @@
 				  struct mpc_i2c *i2c,
 				  u32 clock, u32 prescaler)
 {
-	int fdr = mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
+	int ret, fdr;
+
+	ret = mpc_i2c_get_fdr_8xxx(node, clock, prescaler);
+	fdr = (ret >= 0) ? ret : 0x1031; /* backward compatibility */
 
-	if (fdr < 0)
-		fdr = 0x1031; /* backward compatibility */
 	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
 	writeb((fdr >> 8) & 0xff, i2c->base + MPC_I2C_DFSRR);
-	dev_info(i2c->dev, "clock %d Hz (dfsrr=%d fdr=%d)\n",
-		 clock, fdr >> 8, fdr & 0xff);
+
+	if (ret >= 0)
+		dev_info(i2c->dev, "clock %d Hz (dfsrr=%d fdr=%d)\n",
+			 clock, fdr >> 8, fdr & 0xff);
 }
 
 #else /* !CONFIG_FSL_SOC */
