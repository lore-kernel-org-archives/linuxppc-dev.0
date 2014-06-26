Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AF3E1A0006
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 13:30:09 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <broonie@kernel.org>,
 <linux-spi@vger.kernel.org>, <B07421@freescale.com>
Subject: [PATCH v2] spi: deal with a compile warning
Date: Thu, 26 Jun 2014 11:26:43 +0800
Message-ID: <1403753203-13473-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ret is unused when CONFIG_FSL_SOC defined,
so return ret instead of -ENOMEM when the
kzalloc fails to avoid it.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
Changes for v2:
	-return ret instead of -ENOMEM when the kzalloc fails 

 drivers/spi/spi-fsl-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index e5d45fc..d40378f 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -202,7 +202,7 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 
 	pinfo = devm_kzalloc(&ofdev->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
-		return -ENOMEM;
+		return ret;
 
 	pdata = &pinfo->pdata;
 	dev->platform_data = pdata;
-- 
1.8.5
