Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D73B42C016B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:52:19 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v6 12/17] mtd: mpc5121_nfc: adjust for OF based clock lookup
Date: Sat, 30 Nov 2013 23:51:32 +0100
Message-Id: <1385851897-23475-13-git-send-email-gsi@denx.de>
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Gerhard Sittig <gsi@denx.de>, linux-mtd@lists.infradead.org,
 Scott Wood <scottwood@freescale.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

after device tree based clock lookup became available, the NAND
flash driver need no longer use the previous global "nfc_clk" name,
but should use the "ipg" clock name specific to the OF node

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/mtd/nand/mpc5121_nfc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 439bc3896418..779e60d12f89 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -731,7 +731,7 @@ static int mpc5121_nfc_probe(struct platform_device *op)
 	of_node_put(rootnode);
 
 	/* Enable NFC clock */
-	clk = devm_clk_get(dev, "nfc_clk");
+	clk = devm_clk_get(dev, "ipg");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "Unable to acquire NFC clock!\n");
 		retval = PTR_ERR(clk);
-- 
1.7.10.4
