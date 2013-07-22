Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E75282C0238
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 22:15:40 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v3 04/31] mtd: mpc5121_nfc: cleanup clock API use
Date: Mon, 22 Jul 2013 14:14:31 +0200
Message-Id: <1374495298-22019-5-git-send-email-gsi@denx.de>
In-Reply-To: <1374495298-22019-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
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

prepare before enable isn't optional, do check for and propagate clock
setup errors, adjust error code paths to correctly balance get/put and
prepare/unprepare and enable/disable, use devm_{get,put}_clk()

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/mtd/nand/mpc5121_nfc.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 3c9cdcb..9c0b8fe 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -618,8 +618,8 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 	struct mpc5121_nfc_prv *prv = chip->priv;
 
 	if (prv->clk) {
-		clk_disable(prv->clk);
-		clk_put(prv->clk);
+		clk_disable_unprepare(prv->clk);
+		devm_clk_put(dev, prv->clk);
 	}
 
 	if (prv->csreg)
@@ -629,6 +629,7 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 static int mpc5121_nfc_probe(struct platform_device *op)
 {
 	struct device_node *rootnode, *dn = op->dev.of_node;
+	struct clk *clk;
 	struct device *dev = &op->dev;
 	struct mpc5121_nfc_prv *prv;
 	struct resource res;
@@ -730,14 +731,19 @@ static int mpc5121_nfc_probe(struct platform_device *op)
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
+		devm_clk_put(dev, clk);
+		goto error;
+	}
+	prv->clk = clk;
 
 	/* Reset NAND Flash controller */
 	nfc_set(mtd, NFC_CONFIG1, NFC_RESET);
-- 
1.7.10.4
