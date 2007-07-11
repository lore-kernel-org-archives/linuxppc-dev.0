Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 2EEA7DDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 19:44:30 +1000 (EST)
Date: Wed, 11 Jul 2007 11:34:47 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] mpc52xx_psc_spi: use clk.h subsystem
Message-ID: <20070711093447.GH4375@moe.telargo.com>
References: <20070711093113.GE4375@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070711093113.GE4375@moe.telargo.com>
Cc: David Brownell <david-b@pacbell.net>, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use clocks subsystem in spi driver.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 drivers/spi/mpc52xx_psc_spi.c |   64 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 7 deletions(-)

Index: work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
===================================================================
--- work-powerpc.git.orig/drivers/spi/mpc52xx_psc_spi.c
+++ work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
@@ -18,6 +18,7 @@
 
 #if defined(CONFIG_PPC_MERGE)
 #include <asm/of_platform.h>
+#include <linux/clk.h>
 #else
 #include <linux/platform_device.h>
 #endif
@@ -53,6 +54,8 @@ struct mpc52xx_psc_spi {
 	spinlock_t lock;
 
 	struct completion done;
+
+	struct clk *clk;
 };
 
 /* controller state */
@@ -85,6 +88,13 @@ static void mpc52xx_psc_spi_activate_cs(
 	u32 sicr;
 	u16 ccr;
 
+#ifdef CONFIG_PPC_MERGE
+	u8 bitclkdiv = 2;	/* minimum bitclkdiv */
+	int speed = cs->speed_hz ? cs->speed_hz : 1000000;
+	int mclk;
+	int system;
+#endif
+
 	sicr = in_be32(&psc->sicr);
 
 	/* Set clock phase and polarity */
@@ -106,13 +116,39 @@ static void mpc52xx_psc_spi_activate_cs(
 	/* Set clock frequency and bits per word
 	 * Because psc->ccr is defined as 16bit register instead of 32bit
 	 * just set the lower byte of BitClkDiv
+	 * Because BitClkDiv is 8-bit on mpc5200. Lets stay compatible.
 	 */
 	ccr = in_be16(&psc->ccr);
 	ccr &= 0xFF00;
+
+#ifdef CONFIG_PPC_MERGE
+	/*
+	 * pscclk = mclk/(bitclkdiv+1))		bitclkdiv is 8-bit, >= 2
+	 * mclk = fsys/(mclkdiv+1)		mclkdiv is 9-bit, >= 1
+	 * as mclkdiv has higher precision, we want is as big as possible
+	 * => we get < 0.002*clock error
+	 */
+
+	system = clk_get_rate(clk_get_parent(mps->clk));
+	mclk = speed * (bitclkdiv+1);
+	if (system/mclk > 512) { /* bigger than mclkdiv */
+		bitclkdiv = (system/512) / speed;
+		mclk = speed * (bitclkdiv+1);
+	}
+
+	if (clk_set_rate(mps->clk, mclk))
+		dev_err(&spi->dev, "couldn't set psc_mclk's rate\n");
+
+	dev_info(&spi->dev, "clock: wanted: %i, got: %li\n", speed,
+			clk_round_rate(mps->clk, mclk) / (bitclkdiv+1));
+
+	ccr |= bitclkdiv;
+#else
 	if (cs->speed_hz)
 		ccr |= (MCLK / cs->speed_hz - 1) & 0xFF;
 	else /* by default SPI Clk 1MHz */
 		ccr |= (MCLK / 1000000 - 1) & 0xFF;
+#endif
 	out_be16(&psc->ccr, ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
@@ -321,20 +357,17 @@ static void mpc52xx_psc_spi_cleanup(stru
 
 static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 {
+	struct mpc52xx_psc __iomem *psc = mps->psc;
+	int ret = 0;
+
+#if !defined(CONFIG_PPC_MERGE)
 	struct mpc52xx_cdm __iomem *cdm;
 	struct mpc52xx_gpio __iomem *gpio;
-	struct mpc52xx_psc __iomem *psc = mps->psc;
 	u32 ul;
 	u32 mclken_div;
-	int ret = 0;
 
-#if defined(CONFIG_PPC_MERGE)
-	cdm = mpc52xx_find_and_map("mpc5200-cdm");
-	gpio = mpc52xx_find_and_map("mpc5200-gpio");
-#else
 	cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
 	gpio = ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
-#endif
 	if (!cdm || !gpio) {
 		printk(KERN_ERR "Error mapping CDM/GPIO\n");
 		ret = -EFAULT;
@@ -390,6 +423,7 @@ static int mpc52xx_psc_spi_port_config(i
 		ret = -EINVAL;
 		goto unmap_regs;
 	}
+#endif
 
 	/* Reset the PSC into a known state */
 	out_8(&psc->command, MPC52xx_PSC_RST_RX);
@@ -413,11 +447,13 @@ static int mpc52xx_psc_spi_port_config(i
 
 	mps->bits_per_word = 8;
 
+#if !defined(CONFIG_PPC_MERGE)
 unmap_regs:
 	if (cdm)
 		iounmap(cdm);
 	if (gpio)
 		iounmap(gpio);
+#endif
 
 	return ret;
 }
@@ -502,11 +538,22 @@ static int __init mpc52xx_psc_spi_do_pro
 
 	ret = spi_register_master(master);
 	if (ret < 0)
+		goto destr_wq;
+
+#ifdef CONFIG_PPC_MERGE
+	mps->clk = clk_get(dev, "psc_mclk");
+	if (IS_ERR(mps->clk)) {
+		dev_err(dev, "couldn't get psc_mclk clock\n");
+		ret = -ENOENT;
 		goto unreg_master;
+	}
+#endif
 
 	return ret;
 
 unreg_master:
+	spi_unregister_master(master);
+destr_wq:
 	destroy_workqueue(mps->workqueue);
 free_irq:
 	free_irq(mps->irq, mps);
@@ -523,6 +570,9 @@ static int __exit mpc52xx_psc_spi_do_rem
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
 
+#ifdef CONFIG_PPC_MERGE
+	clk_put(mps->clk);
+#endif
 	flush_workqueue(mps->workqueue);
 	destroy_workqueue(mps->workqueue);
 	spi_unregister_master(master);
