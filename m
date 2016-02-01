Return-Path: <raghav@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C90E1A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 22:19:50 +1100 (AEDT)
From: Raghav Dogra <raghav@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <oss@buserror.net>, <prabhakar.kushwaha@nxp.com>, Raghav Dogra
 <raghav@freescale.com>
Subject: [PATCH 2/3] driver/memory: Update dependency of IFC for Layerscape
Date: Mon, 1 Feb 2016 16:16:37 +0530
Message-ID: <1454323598-5149-2-git-send-email-raghav@freescale.com>
In-Reply-To: <1454323598-5149-1-git-send-email-raghav@freescale.com>
References: <1454323598-5149-1-git-send-email-raghav@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IFC NAND is not working on ARM layescape platform due to
undefined macro FSL_SOC.
This patch fixes the dependency to enable NAND.

Signed-off-by: Raghav Dogra <raghav@freescale.com>
---
 drivers/memory/Kconfig   | 2 +-
 drivers/memory/fsl_ifc.c | 4 +++-
 drivers/mtd/nand/Kconfig | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 6f31546..7365ecf 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -103,7 +103,7 @@ config FSL_CORENET_CF
 
 config FSL_IFC
 	bool
-	depends on FSL_SOC
+	depends on FSL_SOC || ARCH_LAYERSCAPE
 
 config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 054809e..f82a245 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -31,7 +31,9 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/fsl_ifc.h>
-#include <asm/prom.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 struct fsl_ifc_ctrl *fsl_ifc_ctrl_dev;
 EXPORT_SYMBOL(fsl_ifc_ctrl_dev);
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 2896640..0c460e4 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -436,7 +436,7 @@ config MTD_NAND_FSL_ELBC
 
 config MTD_NAND_FSL_IFC
 	tristate "NAND support for Freescale IFC controller"
-	depends on MTD_NAND && FSL_SOC
+	depends on MTD_NAND && (FSL_SOC || ARCH_LAYERSCAPE)
 	select FSL_IFC
 	select MEMORY
 	help
-- 
1.9.1
