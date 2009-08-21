Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 74460B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 02:43:56 +1000 (EST)
Subject: [PATCH V2] Use clock freqency from the device tree to calculate
	correct MPC5200 PSC clock.
To: grant.likely@secretlab.ca, Linuxppc-dev@ozlabs.org
From: Jon Smirl <jonsmirl@gmail.com>
Date: Fri, 21 Aug 2009 12:36:40 -0400
Message-ID: <20090821163640.7391.12133.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use clock freqency from the device tree to calculate correct MPC5200 PSC clock.
Previous code had errors or used a constant. This versions computes
the right clock based on the xtal and register settings.

Adjusted from previous version to rebase onto current Linus tree.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 arch/powerpc/include/asm/mpc52xx.h           |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   26 ++++++++++++++++++++++++--
 drivers/spi/mpc52xx_psc_spi.c                |    8 +-------
 sound/soc/fsl/mpc5200_psc_i2s.c              |   12 +++++++++---
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/mpc52xx.h
index cadd398..1ca8a0e 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -285,7 +285,7 @@ struct mpc52xx_rtc {
 extern void mpc5200_setup_xlb_arbiter(void);
 extern void mpc52xx_declare_of_platform_devices(void);
 extern void mpc52xx_map_common_devices(void);
-extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
+extern int mpc52xx_set_psc_clkdiv(int psc_id, int freq);
 extern unsigned int mpc52xx_get_xtal_freq(struct device_node *node);
 extern void mpc52xx_restart(char *cmd);
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index a46bad0..8a19156 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -110,6 +110,8 @@ static struct of_device_id mpc52xx_cdm_ids[] __initdata = {
 	{}
 };
 
+static u32 mpc52xx_fsystem; /* fsystem clock on mpc5200 */
+
 /**
  * mpc52xx_map_common_devices: iomap devices required by common code
  */
@@ -117,6 +119,7 @@ void __init
 mpc52xx_map_common_devices(void)
 {
 	struct device_node *np;
+	u32 val;
 
 	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
 	 * possibly from a interrupt context. wdt is only implement
@@ -133,8 +136,16 @@ mpc52xx_map_common_devices(void)
 
 	/* Clock Distribution Module, used by PSC clock setting function */
 	np = of_find_matching_node(NULL, mpc52xx_cdm_ids);
+	mpc52xx_fsystem = mpc5xxx_get_bus_frequency(np);
 	mpc52xx_cdm = of_iomap(np, 0);
 	of_node_put(np);
+
+	/* compute fsystem, it is either 4 or 8 times the bus freq */
+	val = in_be32(&mpc52xx_cdm->rstcfg);
+	if (val & (1 << 5))
+		mpc52xx_fsystem *= 8;
+	else
+		mpc52xx_fsystem *= 4;
 }
 
 /**
@@ -143,17 +154,28 @@ mpc52xx_map_common_devices(void)
  * @psc_id: id of psc port; must be 1,2,3 or 6
  * @clkdiv: clock divider value to put into CDM PSC register.
  */
-int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv)
+int mpc52xx_set_psc_clkdiv(int psc_id, int freq)
 {
 	unsigned long flags;
 	u16 __iomem *reg;
 	u32 val;
-	u32 mask;
+	u32 mask, clkdiv, err;
 	u32 mclken_div;
 
 	if (!mpc52xx_cdm)
 		return -ENODEV;
 
+	/* figure out the closest frequency the hardware can make */
+	clkdiv = mpc52xx_fsystem / freq;
+	err = mpc52xx_fsystem % freq;
+	if (err > freq / 2)
+		clkdiv++;
+	/* hardware is not very flexible, there will be significant error */
+	/* frequency error = fsystem / clkdiv - freq; */
+
+	/* hardware adds one to the divisor */
+	clkdiv -= 1;
+
 	mclken_div = 0x8000 | (clkdiv & 0x1FF);
 	switch (psc_id) {
 	case 1: reg = &mpc52xx_cdm->mclken_div_psc1; mask = 0x20; break;
diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 1b74d5c..d000edc 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -32,7 +32,6 @@
 struct mpc52xx_psc_spi {
 	/* fsl_spi_platform data */
 	void (*cs_control)(struct spi_device *spi, bool on);
-	u32 sysclk;
 
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
@@ -312,12 +311,9 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 {
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc52xx_psc_fifo __iomem *fifo = mps->fifo;
-	u32 mclken_div;
 	int ret = 0;
 
-	/* default sysclk is 512MHz */
-	mclken_div = (mps->sysclk ? mps->sysclk : 512000000) / MCLK;
-	mpc52xx_set_psc_clkdiv(psc_id, mclken_div);
+	mpc52xx_set_psc_clkdiv(psc_id, MCLK);
 
 	/* Reset the PSC into a known state */
 	out_8(&psc->command, MPC52xx_PSC_RST_RX);
@@ -382,12 +378,10 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		dev_warn(dev, "probe called without platform data, no "
 				"cs_control function will be called\n");
 		mps->cs_control = NULL;
-		mps->sysclk = 0;
 		master->bus_num = bus_num;
 		master->num_chipselect = 255;
 	} else {
 		mps->cs_control = pdata->cs_control;
-		mps->sysclk = pdata->sysclk;
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->max_chipselect;
 	}
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index ce8de90..2e347dd 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -14,6 +14,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+#include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 
 #include "mpc5200_psc_i2s.h"
@@ -90,9 +91,14 @@ static int psc_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 			      int clk_id, unsigned int freq, int dir)
 {
 	struct psc_dma *psc_dma = cpu_dai->private_data;
-	dev_dbg(psc_dma->dev, "psc_i2s_set_sysclk(cpu_dai=%p, dir=%i)\n",
-				cpu_dai, dir);
-	return (dir == SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
+
+	dev_dbg(psc_dma->dev, "psc_i2s_set_sysclk(cpu_dai=%p, freq=%u, dir=%i)\n",
+				cpu_dai, freq, dir);
+
+	if (dir == SND_SOC_CLOCK_OUT)
+		return mpc52xx_set_psc_clkdiv(psc_dma->id + 1, freq);
+
+	return -EINVAL;
 }
 
 /**
