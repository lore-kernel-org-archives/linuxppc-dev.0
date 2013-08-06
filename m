Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E87DC2C01D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:45:09 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 05/31] [media] fsl-viu: cleanup clock API use
Date: Tue,  6 Aug 2013 22:43:45 +0200
Message-Id: <1375821851-31609-6-git-send-email-gsi@denx.de>
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
they can get enabled, adjust code paths to correctly balance get/put and
prepare/unprepare and enable/disable calls

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/media/platform/fsl-viu.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index 221ec42..fe9898c 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1485,6 +1485,7 @@ static int viu_of_probe(struct platform_device *op)
 	struct viu_reg __iomem *viu_regs;
 	struct i2c_adapter *ad;
 	int ret, viu_irq;
+	struct clk *clk;
 
 	ret = of_address_to_resource(op->dev.of_node, 0, &r);
 	if (ret) {
@@ -1577,14 +1578,18 @@ static int viu_of_probe(struct platform_device *op)
 	}
 
 	/* enable VIU clock */
-	viu_dev->clk = clk_get(&op->dev, "viu_clk");
-	if (IS_ERR(viu_dev->clk)) {
-		dev_err(&op->dev, "failed to find the clock module!\n");
-		ret = -ENODEV;
+	clk = devm_clk_get(&op->dev, "viu_clk");
+	if (IS_ERR(clk)) {
+		dev_err(&op->dev, "failed to lookup the clock!\n");
+		ret = PTR_ERR(clk);
+		goto err_clk;
+	}
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&op->dev, "failed to enable the clock!\n");
 		goto err_clk;
-	} else {
-		clk_enable(viu_dev->clk);
 	}
+	viu_dev->clk = clk;
 
 	/* reset VIU module */
 	viu_reset(viu_dev->vr);
@@ -1602,8 +1607,7 @@ static int viu_of_probe(struct platform_device *op)
 	return ret;
 
 err_irq:
-	clk_disable(viu_dev->clk);
-	clk_put(viu_dev->clk);
+	clk_disable_unprepare(viu_dev->clk);
 err_clk:
 	video_unregister_device(viu_dev->vdev);
 err_vdev:
@@ -1626,8 +1630,7 @@ static int viu_of_remove(struct platform_device *op)
 	free_irq(dev->irq, (void *)dev);
 	irq_dispose_mapping(dev->irq);
 
-	clk_disable(dev->clk);
-	clk_put(dev->clk);
+	clk_disable_unprepare(dev->clk);
 
 	video_unregister_device(dev->vdev);
 	i2c_put_adapter(client->adapter);
-- 
1.7.10.4
