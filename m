Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D18F52C0215
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:45:05 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 03/31] USB: fsl-mph-dr-of: cleanup clock API use
Date: Tue,  6 Aug 2013 22:43:43 +0200
Message-Id: <1375821851-31609-4-git-send-email-gsi@denx.de>
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

use devm_get_clk() for automatic put upon device close, check for and
propagate errors when enabling clocks, must prepare clocks before they
can get enabled, unprepare after disable

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/usb/host/fsl-mph-dr-of.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 11e0b79..b8a1866 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -260,6 +260,7 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
 	struct clk *clk;
+	int err;
 	char clk_name[10];
 	int base, clk_num;
 
@@ -272,13 +273,16 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 		return -ENODEV;
 
 	snprintf(clk_name, sizeof(clk_name), "usb%d_clk", clk_num);
-	clk = clk_get(&pdev->dev, clk_name);
+	clk = devm_clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clk\n");
 		return PTR_ERR(clk);
 	}
-
-	clk_enable(clk);
+	err = clk_prepare_enable(clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable clk\n");
+		return err;
+	}
 	pdata->clk = clk;
 
 	if (pdata->phy_mode == FSL_USB2_PHY_UTMI_WIDE) {
@@ -302,10 +306,8 @@ static void fsl_usb2_mpc5121_exit(struct platform_device *pdev)
 
 	pdata->regs = NULL;
 
-	if (pdata->clk) {
-		clk_disable(pdata->clk);
-		clk_put(pdata->clk);
-	}
+	if (pdata->clk)
+		clk_disable_unprepare(pdata->clk);
 }
 
 static struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd = {
-- 
1.7.10.4
