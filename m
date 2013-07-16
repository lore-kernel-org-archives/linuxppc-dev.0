Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v1 21/24] [media] fsl-viu: OF clock lookup,
 prepare before enable
Date: Tue, 16 Jul 2013 10:45:37 +0200
Message-Id: <1373964341-25228-1-git-send-email-gsi@denx.de>
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
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

device tree based clock lookup, must prepare clocks before enabling
them, unprepare after disable, error check in the clock setup

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/media/platform/fsl-viu.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
index 221ec42..b95aa43 100644
--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1582,8 +1582,11 @@ static int viu_of_probe(struct platform_device *op)
 		dev_err(&op->dev, "failed to find the clock module!\n");
 		ret = -ENODEV;
 		goto err_clk;
-	} else {
-		clk_enable(viu_dev->clk);
+	}
+	ret = clk_prepare_enable(viu_dev->clk);
+	if (ret) {
+		dev_err(&op->dev, "failed to enable the clock!\n");
+		goto err_clk_put;
 	}
 
 	/* reset VIU module */
@@ -1602,7 +1605,8 @@ static int viu_of_probe(struct platform_device *op)
 	return ret;
 
 err_irq:
-	clk_disable(viu_dev->clk);
+	clk_disable_unprepare(viu_dev->clk);
+err_clk_put:
 	clk_put(viu_dev->clk);
 err_clk:
 	video_unregister_device(viu_dev->vdev);
@@ -1626,7 +1630,7 @@ static int viu_of_remove(struct platform_device *op)
 	free_irq(dev->irq, (void *)dev);
 	irq_dispose_mapping(dev->irq);
 
-	clk_disable(dev->clk);
+	clk_disable_unprepare(dev->clk);
 	clk_put(dev->clk);
 
 	video_unregister_device(dev->vdev);
-- 
1.7.10.4
