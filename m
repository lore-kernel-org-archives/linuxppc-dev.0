Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v1 19/24] USB: fsl-mph-dr-of: OF clock lookup,
 prepare and enable
Date: Tue, 16 Jul 2013 08:05:07 +0200
Message-Id: <1373954707-23909-4-git-send-email-gsi@denx.de>
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

device tree based clock lookup in the MPC512x initialization (lookup
'per' for register access), add error check in the clock setup, must
prepare clocks before they can get enabled, unprepare after disable

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/usb/host/fsl-mph-dr-of.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 11e0b79..eb564f3 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -260,25 +260,19 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
 	struct clk *clk;
-	char clk_name[10];
-	int base, clk_num;
-
-	base = pdev->resource->start & 0xf000;
-	if (base == 0x3000)
-		clk_num = 1;
-	else if (base == 0x4000)
-		clk_num = 2;
-	else
-		return -ENODEV;
+	int err;
 
-	snprintf(clk_name, sizeof(clk_name), "usb%d_clk", clk_num);
-	clk = clk_get(&pdev->dev, clk_name);
+	clk = clk_get(&pdev->dev, "per");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clk\n");
 		return PTR_ERR(clk);
 	}
-
-	clk_enable(clk);
+	err = clk_prepare_enable(clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable clk\n");
+		clk_put(clk);
+		return err;
+	}
 	pdata->clk = clk;
 
 	if (pdata->phy_mode == FSL_USB2_PHY_UTMI_WIDE) {
@@ -303,7 +297,7 @@ static void fsl_usb2_mpc5121_exit(struct platform_device *pdev)
 	pdata->regs = NULL;
 
 	if (pdata->clk) {
-		clk_disable(pdata->clk);
+		clk_disable_unprepare(pdata->clk);
 		clk_put(pdata->clk);
 	}
 }
-- 
1.7.10.4
