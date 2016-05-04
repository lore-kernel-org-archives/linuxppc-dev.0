Return-Path: <yangbo.lu@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0071.outbound.protection.outlook.com [65.55.169.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r03Yy72ZrzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 13:34:30 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <netdev@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Scott Wood <oss@buserror.net>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King
 <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>, Joerg Roedel
 <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>, "Bhupesh
 Sharma" <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 "Kumar Gala" <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v9, 0/7] Fix eSDHC host version register bug
Date: Wed, 4 May 2016 11:24:27 +0800
Message-ID: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
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

This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
eSDHC controller. To get the SoC version and revision, it's needed to add the
GUTS driver to access the global utilities registers.

So, the first four patches are to add the GUTS driver.
The following patches except the updating MAINTAINERS patch are to enable
GUTS driver support to get SVR in eSDHC driver and fix host version for T4240.

Yangbo Lu (7):
  Documentation: DT: update Freescale DCFG compatible
  ARM64: dts: ls2080a: add device configuration node
  soc: fsl: add GUTS driver for QorIQ platforms
  dt: move guts devicetree doc out of powerpc directory
  powerpc/fsl: move mpc85xx.h to include/linux/fsl
  MAINTAINERS: add entry for Freescale SoC driver
  mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0

 Documentation/devicetree/bindings/arm/fsl.txt      |   6 +-
 .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
 MAINTAINERS                                        |  11 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 drivers/clk/clk-qoriq.c                            |   3 +-
 drivers/i2c/busses/i2c-mpc.c                       |   2 +-
 drivers/iommu/fsl_pamu.c                           |   3 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |  23 ++++
 drivers/net/ethernet/freescale/gianfar.c           |   2 +-
 drivers/soc/Kconfig                                |   2 +-
 drivers/soc/fsl/Kconfig                            |   8 ++
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/guts.c                             | 119 +++++++++++++++++++
 include/linux/fsl/guts.h                           | 126 +++++++++++++--------
 .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
 17 files changed, 262 insertions(+), 60 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/guts.c
 rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)

-- 
2.1.0.27.g96db324
