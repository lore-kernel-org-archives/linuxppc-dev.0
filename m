Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F9011A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 11:58:27 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <broonie@kernel.org>,
 <linux-spi@vger.kernel.org>, <B07421@freescale.com>
Subject: [PATCH] spi: include "int ret" with macro
Date: Wed, 25 Jun 2014 09:54:36 +0800
Message-ID: <1403661276-16598-1-git-send-email-B45475@freescale.com>
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
so include it with "#ifndef CONFIG_FSL_SOC".

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 drivers/spi/spi-fsl-lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index e5d45fc..44aace1 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -198,8 +198,9 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofdev)
 	struct mpc8xxx_spi_probe_info *pinfo;
 	struct fsl_spi_platform_data *pdata;
 	const void *prop;
+#ifndef CONFIG_FSL_SOC
 	int ret = -ENOMEM;
-
+#endif
 	pinfo = devm_kzalloc(&ofdev->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
-- 
1.8.5
