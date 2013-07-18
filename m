Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v2 03/24] mtd: mpc5121_nfc: prepare clocks before enabling them
Date: Thu, 18 Jul 2013 19:00:34 +0200
Message-Id: <1374166855-7280-4-git-send-email-gsi@denx.de>
In-Reply-To: <1374166855-7280-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1374166855-7280-1-git-send-email-gsi@denx.de>
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

must prepare clocks before enabling them, unprepare after disable

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/mtd/nand/mpc5121_nfc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 3c9cdcb..eb7771d 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -618,7 +618,7 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 	struct mpc5121_nfc_prv *prv = chip->priv;
 
 	if (prv->clk) {
-		clk_disable(prv->clk);
+		clk_disable_unprepare(prv->clk);
 		clk_put(prv->clk);
 	}
 
@@ -737,7 +737,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 		goto error;
 	}
 
-	clk_enable(prv->clk);
+	clk_prepare_enable(prv->clk);
 
 	/* Reset NAND Flash controller */
 	nfc_set(mtd, NFC_CONFIG1, NFC_RESET);
-- 
1.7.10.4
