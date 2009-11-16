Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A71A3B7093
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 09:59:44 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:50 +0100
Message-Id: <1258412274-14686-8-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 07/11] net/can/mpc52xx_can: refactor clock-get routine
Cc: socketcan-core@lists.berlios.de, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge two functions into one. The result is smaller as they can now share some
variables.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/can/mscan/mpc52xx_can.c |   45 ++++++++++++----------------------
 1 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/mscan/mpc52xx_can.c b/drivers/net/can/mscan/mpc52xx_can.c
index 34ae2ba..a915959 100644
--- a/drivers/net/can/mscan/mpc52xx_can.c
+++ b/drivers/net/can/mscan/mpc52xx_can.c
@@ -38,28 +38,37 @@
 
 static struct of_device_id mpc52xx_cdm_ids[] __devinitdata = {
 	{ .compatible = "fsl,mpc5200-cdm", },
-	{ .compatible = "fsl,mpc5200b-cdm", },
 	{}
 };
 
 /*
- * Get the frequency of the external oscillator clock connected
- * to the SYS_XTAL_IN pin, or return 0 if it cannot be determined.
+ * Get frequency of the MSCAN clock source
+ *
+ * Either the oscillator clock (SYS_XTAL_IN) or the IP bus clock (IP_CLK)
+ * can be selected. According to the MPC5200 user's manual, the oscillator
+ * clock is the better choice as it has less jitter but due to a hardware
+ * bug, it can not be selected for the old MPC5200 Rev. A chips.
  */
-static unsigned int  __devinit mpc52xx_can_xtal_freq(struct of_device *of)
+
+static unsigned int  __devinit mpc52xx_can_clock_freq(struct of_device *of,
+						      int clock_src)
 {
+	unsigned int pvr;
 	struct mpc52xx_cdm  __iomem *cdm;
 	struct device_node *np_cdm;
 	unsigned int freq;
 	u32 val;
 
+	pvr = mfspr(SPRN_PVR);
+
 	freq = mpc5xxx_get_bus_frequency(of->node);
 	if (!freq)
 		return 0;
 
-	/*
-	 * Determine SYS_XTAL_IN frequency from the clock domain settings
-	 */
+	if (clock_src == MSCAN_CLKSRC_BUS || pvr == 0x80822011)
+		return freq;
+
+	/* Determine SYS_XTAL_IN frequency from the clock domain settings */
 	np_cdm = of_find_matching_node(NULL, mpc52xx_cdm_ids);
 	if (!np_cdm) {
 		dev_err(&of->dev, "can't get clock node!\n");
@@ -80,28 +89,6 @@ static unsigned int  __devinit mpc52xx_can_xtal_freq(struct of_device *of)
 	return freq;
 }
 
-/*
- * Get frequency of the MSCAN clock source
- *
- * Either the oscillator clock (SYS_XTAL_IN) or the IP bus clock (IP_CLK)
- * can be selected. According to the MPC5200 user's manual, the oscillator
- * clock is the better choice as it has less jitter but due to a hardware
- * bug, it can not be selected for the old MPC5200 Rev. A chips.
- */
-
-static unsigned int  __devinit mpc52xx_can_clock_freq(struct of_device *of,
-						      int clock_src)
-{
-	unsigned int pvr;
-
-	pvr = mfspr(SPRN_PVR);
-
-	if (clock_src == MSCAN_CLKSRC_BUS || pvr == 0x80822011)
-		return mpc5xxx_get_bus_frequency(of->node);
-
-	return mpc52xx_can_xtal_freq(of);
-}
-
 static int __devinit mpc5xxx_can_probe(struct of_device *ofdev,
 				       const struct of_device_id *id)
 {
-- 
1.6.3.3
