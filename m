Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7A12B2C0370
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:52:14 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 08/17] spi: mpc512x: adjust to OF based clock lookup
Date: Sat, 30 Nov 2013 23:51:28 +0100
Message-Id: <1385851897-23475-9-git-send-email-gsi@denx.de>
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Mark Brown <broonie@kernel.org>, Detlev Zundel <dzu@denx.de>,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the PSC index,
remove the "psc%d_mclk" template and unconditionally use 'mclk'

acquire and release the 'ipg' clock item for register access as well

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/spi/spi-mpc512x-psc.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 9602bbd8d7ea..de66c676c248 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -40,6 +40,7 @@ struct mpc512x_psc_spi {
 	unsigned int irq;
 	u8 bits_per_word;
 	struct clk *clk_mclk;
+	struct clk *clk_ipg;
 	u32 mclk_rate;
 
 	struct completion txisrdone;
@@ -475,8 +476,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	struct spi_master *master;
 	int ret;
 	void *tempp;
-	int psc_num;
-	char clk_name[16];
 	struct clk *clk;
 
 	master = spi_alloc_master(dev, sizeof *mps);
@@ -520,9 +519,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		goto free_master;
 	init_completion(&mps->txisrdone);
 
-	psc_num = master->bus_num;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
-	clk = devm_clk_get(dev, clk_name);
+	clk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		goto free_irq;
@@ -533,17 +530,29 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->clk_mclk = clk;
 	mps->mclk_rate = clk_get_rate(clk);
 
+	clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto free_mclk_clock;
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto free_mclk_clock;
+	mps->clk_ipg = clk;
+
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
-		goto free_clock;
+		goto free_ipg_clock;
 
 	ret = devm_spi_register_master(dev, master);
 	if (ret < 0)
-		goto free_clock;
+		goto free_ipg_clock;
 
 	return ret;
 
-free_clock:
+free_ipg_clock:
+	clk_disable_unprepare(mps->clk_ipg);
+free_mclk_clock:
 	clk_disable_unprepare(mps->clk_mclk);
 free_irq:
 	free_irq(mps->irq, mps);
@@ -561,6 +570,7 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
 
 	clk_disable_unprepare(mps->clk_mclk);
+	clk_disable_unprepare(mps->clk_ipg);
 	free_irq(mps->irq, mps);
 	if (mps->psc)
 		iounmap(mps->psc);
-- 
1.7.10.4
