Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1170C2C015C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:45:02 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 04/31] mtd: mpc5121_nfc: cleanup clock API use
Date: Tue,  6 Aug 2013 22:43:44 +0200
Message-Id: <1375821851-31609-5-git-send-email-gsi@denx.de>
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

use devm_clk_get() for automatic put after device close, check for and
propagate errors when enabling clocks, need to prepare clocks before
they can get enabled, adjust error code paths to correctly balance
get/put and prepare/unprepare and enable/disable calls

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/mtd/nand/mpc5121_nfc.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 3c9cdcb..3c60a00 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -617,10 +617,8 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 	struct nand_chip *chip = mtd->priv;
 	struct mpc5121_nfc_prv *prv = chip->priv;
 
-	if (prv->clk) {
-		clk_disable(prv->clk);
-		clk_put(prv->clk);
-	}
+	if (prv->clk)
+		clk_disable_unprepare(prv->clk);
 
 	if (prv->csreg)
 		iounmap(prv->csreg);
@@ -629,6 +627,7 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 static int mpc5121_nfc_probe(struct platform_device *op)
 {
 	struct device_node *rootnode, *dn = op->dev.of_node;
+	struct clk *clk;
 	struct device *dev = &op->dev;
 	struct mpc5121_nfc_prv *prv;
 	struct resource res;
@@ -730,14 +729,18 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	of_node_put(rootnode);
 
 	/* Enable NFC clock */
-	prv->clk = clk_get(dev, "nfc_clk");
-	if (IS_ERR(prv->clk)) {
+	clk = devm_clk_get(dev, "nfc_clk");
+	if (IS_ERR(clk)) {
 		dev_err(dev, "Unable to acquire NFC clock!\n");
-		retval = PTR_ERR(prv->clk);
+		retval = PTR_ERR(clk);
 		goto error;
 	}
-
-	clk_enable(prv->clk);
+	retval = clk_prepare_enable(clk);
+	if (retval) {
+		dev_err(dev, "Unable to enable NFC clock!\n");
+		goto error;
+	}
+	prv->clk = clk;
 
 	/* Reset NAND Flash controller */
 	nfc_set(mtd, NFC_CONFIG1, NFC_RESET);
-- 
1.7.10.4
