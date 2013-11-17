Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 769282C05E2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 10:08:32 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v5 11/17] USB: fsl-mph-dr-of: adjust for OF based clock lookup
Date: Mon, 18 Nov 2013 00:06:11 +0100
Message-Id: <1384729577-7336-12-git-send-email-gsi@denx.de>
In-Reply-To: <1384729577-7336-1-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 linux-usb@vger.kernel.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

after device tree based clock lookup became available, the peripheral
driver need no longer construct clock names which include the component
index -- remove the "usb%d_clk" template, always use "ipg" instead

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/usb/host/fsl-mph-dr-of.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index abd5050a4899..9162d1b6c0a3 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -261,19 +261,8 @@ int fsl_usb2_mpc5121_init(struct platform_device *pdev)
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct clk *clk;
 	int err;
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
 
-	snprintf(clk_name, sizeof(clk_name), "usb%d_clk", clk_num);
-	clk = devm_clk_get(pdev->dev.parent, clk_name);
+	clk = devm_clk_get(pdev->dev.parent, "ipg");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clk\n");
 		return PTR_ERR(clk);
-- 
1.7.10.4
