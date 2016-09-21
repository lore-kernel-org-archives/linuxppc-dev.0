Return-Path: <yangbo.lu@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0076.outbound.protection.outlook.com [104.47.36.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sf9kd5hGnzDsjY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:10:33 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>, Scott Wood
 <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <netdev@vger.kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King
 <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>, Joerg Roedel
 <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>, "Bhupesh
 Sharma" <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 "Kumar Gala" <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Minghuan Lian
 <minghuan.lian@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v12, 8/8] mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
Date: Wed, 21 Sep 2016 14:57:20 +0800
Message-ID: <1474441040-11946-9-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
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

The eSDHC of T4240-R1.0-R2.0 has incorrect vender version and spec version.
Acturally the right version numbers should be VVN=0x13 and SVN = 0x1.
This patch adds the GUTS driver support for eSDHC driver to match SoC.
And fix host version to avoid that incorrect version numbers break down
the ADMA data transfer.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Scott Wood <oss@buserror.net>
---
Changes for v2:
	- Got SVR through iomap instead of dts
Changes for v3:
	- Managed GUTS through syscon instead of iomap in eSDHC driver
Changes for v4:
	- Got SVR by GUTS driver instead of SYSCON
Changes for v5:
	- Changed to get SVR through API fsl_guts_get_svr()
	- Combined patch 4, patch 5 and patch 6 into one
Changes for v6:
	- Added 'Acked-by: Ulf Hansson'
Changes for v7:
	- None
Changes for v8:
	- Added 'Acked-by: Scott Wood'
Changes for v9:
	- None
Changes for v10:
	- None
Changes for v11:
	- Changed to use soc_device_match
Changes for v12:
	- Matched soc through .family field instead of .soc_id
---
 drivers/mmc/host/Kconfig          |  1 +
 drivers/mmc/host/sdhci-of-esdhc.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 5274f50..a1135a9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -144,6 +144,7 @@ config MMC_SDHCI_OF_ESDHC
 	depends on MMC_SDHCI_PLTFM
 	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
 	select MMC_SDHCI_IO_ACCESSORS
+	select FSL_GUTS
 	help
 	  This selects the Freescale eSDHC controller support.
 
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fb71c86..57bdb9e 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/sys_soc.h>
 #include <linux/mmc/host.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -28,6 +29,7 @@
 struct sdhci_esdhc {
 	u8 vendor_ver;
 	u8 spec_ver;
+	bool quirk_incorrect_hostver;
 };
 
 /**
@@ -73,6 +75,8 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 static u16 esdhc_readw_fixup(struct sdhci_host *host,
 				     int spec_reg, u32 value)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	u16 ret;
 	int shift = (spec_reg & 0x2) * 8;
 
@@ -80,6 +84,12 @@ static u16 esdhc_readw_fixup(struct sdhci_host *host,
 		ret = value & 0xffff;
 	else
 		ret = (value >> shift) & 0xffff;
+	/* Workaround for T4240-R1.0-R2.0 eSDHC which has incorrect
+	 * vendor version and spec version information.
+	 */
+	if ((spec_reg == SDHCI_HOST_VERSION) &&
+	    (esdhc->quirk_incorrect_hostver))
+		ret = (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | SDHCI_SPEC_200;
 	return ret;
 }
 
@@ -558,6 +568,12 @@ static const struct sdhci_pltfm_data sdhci_esdhc_le_pdata = {
 	.ops = &sdhci_esdhc_le_ops,
 };
 
+static struct soc_device_attribute soc_incorrect_hostver[] = {
+	{ .family = "QorIQ T4240", .revision = "1.0", },
+	{ .family = "QorIQ T4240", .revision = "2.0", },
+	{ },
+};
+
 static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -571,6 +587,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
 			     SDHCI_VENDOR_VER_SHIFT;
 	esdhc->spec_ver = host_ver & SDHCI_SPEC_VER_MASK;
+	if (soc_device_match(soc_incorrect_hostver))
+		esdhc->quirk_incorrect_hostver = true;
+	else
+		esdhc->quirk_incorrect_hostver = false;
 }
 
 static int sdhci_esdhc_probe(struct platform_device *pdev)
-- 
2.1.0.27.g96db324
