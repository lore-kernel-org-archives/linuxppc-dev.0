Return-Path: <yangbo.lu@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0042.outbound.protection.outlook.com [104.47.32.42])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT0RB6JZdzDrqH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 18:40:22 +1000 (AEST)
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
 <leoyang.li@nxp.com>, <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v11, 0/8] Fix eSDHC host version register bug
Date: Tue, 6 Sep 2016 16:28:15 +0800
Message-ID: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
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
eSDHC controller. To match the SoC version and revision, 10 previous version
patchsets had tried many methods but all of them were rejected by reviewers.
Such as
	- dts compatible method
	- syscon method
	- ifdef PPC method
	- GUTS driver getting SVR method
Anrd suggested a soc_device_match method in v10, and this is the only available
method left now. This v11 patchset introduces the soc_device_match interface in
soc driver.

The first six patches are to add the GUTS driver. This is used to register a
soc device which contain soc version and revision information.
The following two patches introduce the soc_device_match method in soc driver
and apply it on esdhc driver to fix this bug.

Yangbo Lu (8):
  dt: bindings: update Freescale DCFG compatible
  ARM64: dts: ls2080a: add device configuration node
  dt: bindings: move guts devicetree doc out of powerpc directory
  powerpc/fsl: move mpc85xx.h to include/linux/fsl
  soc: fsl: add GUTS driver for QorIQ platforms
  MAINTAINERS: add entry for Freescale SoC drivers
  base: soc: introduce soc_device_match() interface
  mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0

 Documentation/devicetree/bindings/arm/fsl.txt      |   6 +-
 .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
 MAINTAINERS                                        |  11 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   2 +-
 drivers/base/Kconfig                               |   1 +
 drivers/base/soc.c                                 |  61 +++
 drivers/clk/clk-qoriq.c                            |   3 +-
 drivers/i2c/busses/i2c-mpc.c                       |   2 +-
 drivers/iommu/fsl_pamu.c                           |   3 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |  20 +
 drivers/net/ethernet/freescale/gianfar.c           |   2 +-
 drivers/soc/Kconfig                                |   2 +-
 drivers/soc/fsl/Kconfig                            |  20 +
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/guts.c                             | 483 +++++++++++++++++++++
 include/linux/fsl/guts.h                           | 127 ++++--
 .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
 include/linux/sys_soc.h                            |   3 +
 21 files changed, 702 insertions(+), 61 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/guts.c
 rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)

-- 
2.1.0.27.g96db324
