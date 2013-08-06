Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 263DB2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:44:46 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 01/31] spi: mpc512x: cleanup clock API use
Date: Tue,  6 Aug 2013 22:43:41 +0200
Message-Id: <1375821851-31609-2-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cleanup the MPC512x SoC's SPI master's use of the clock API
- get, prepare, and enable the MCLK during probe; disable, unprepare and
  put the MCLK upon remove; hold a reference to the clock over the
  period of use
- fetch MCLK rate (reference) once during probe and slightly reword BCLK
  (bitrate) determination to reduce redundancy as well as to not exceed
  the maximum text line length
- stick with the PPC_CLOCK 'psc%d_mclk' name for clock lookup, only
  switch to a fixed string later after device tree based clock lookup
  will have become available

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/spi/spi-mpc512x-psc.c |   48 +++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 29fce6a..85581f3 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -38,7 +38,8 @@ struct mpc512x_psc_spi {
 	struct mpc512x_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
-	u32 mclk;
+	struct clk *clk_mclk;
+	u32 mclk_rate;
 
 	struct completion txisrdone;
 };
@@ -72,6 +73,7 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	u32 sicr;
 	u32 ccr;
+	int speed;
 	u16 bclkdiv;
 
 	sicr = in_be32(&psc->sicr);
@@ -95,10 +97,10 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 
 	ccr = in_be32(&psc->ccr);
 	ccr &= 0xFF000000;
-	if (cs->speed_hz)
-		bclkdiv = (mps->mclk / cs->speed_hz) - 1;
-	else
-		bclkdiv = (mps->mclk / 1000000) - 1;	/* default 1MHz */
+	speed = cs->speed_hz;
+	if (!speed)
+		speed = 1000000;	/* default 1MHz */
+	bclkdiv = (mps->mclk_rate / speed) - 1;
 
 	ccr |= (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
 	out_be32(&psc->ccr, ccr);
@@ -386,19 +388,11 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 {
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
-	struct clk *spiclk;
-	int ret = 0;
-	char name[32];
 	u32 sicr;
 	u32 ccr;
+	int speed;
 	u16 bclkdiv;
 
-	sprintf(name, "psc%d_mclk", master->bus_num);
-	spiclk = clk_get(&master->dev, name);
-	clk_enable(spiclk);
-	mps->mclk = clk_get_rate(spiclk);
-	clk_put(spiclk);
-
 	/* Reset the PSC into a known state */
 	out_8(&psc->command, MPC52xx_PSC_RST_RX);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
@@ -425,7 +419,8 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 
 	ccr = in_be32(&psc->ccr);
 	ccr &= 0xFF000000;
-	bclkdiv = (mps->mclk / 1000000) - 1;	/* default 1MHz */
+	speed = 1000000;	/* default 1MHz */
+	bclkdiv = (mps->mclk_rate / speed) - 1;
 	ccr |= (((bclkdiv & 0xff) << 16) | (((bclkdiv >> 8) & 0xff) << 8));
 	out_be32(&psc->ccr, ccr);
 
@@ -445,7 +440,7 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 
 	mps->bits_per_word = 8;
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
@@ -479,6 +474,9 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	struct spi_master *master;
 	int ret;
 	void *tempp;
+	int psc_num;
+	char clk_name[16];
+	struct clk *clk;
 
 	master = spi_alloc_master(dev, sizeof *mps);
 	if (master == NULL)
@@ -521,16 +519,29 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		goto free_master;
 	init_completion(&mps->txisrdone);
 
+	psc_num = master->bus_num;
+	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
+	clk = devm_clk_get(dev, clk_name);
+	if (IS_ERR(clk))
+		goto free_irq;
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto free_irq;
+	mps->clk_mclk = clk;
+	mps->mclk_rate = clk_get_rate(clk);
+
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
-		goto free_irq;
+		goto free_clock;
 
 	ret = spi_register_master(master);
 	if (ret < 0)
-		goto free_irq;
+		goto free_clock;
 
 	return ret;
 
+free_clock:
+	clk_disable_unprepare(mps->clk_mclk);
 free_irq:
 	free_irq(mps->irq, mps);
 free_master:
@@ -547,6 +558,7 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
 
 	spi_unregister_master(master);
+	clk_disable_unprepare(mps->clk_mclk);
 	free_irq(mps->irq, mps);
 	if (mps->psc)
 		iounmap(mps->psc);
-- 
1.7.10.4
