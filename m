Return-Path: <yangbo.lu@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0070.outbound.protection.outlook.com [104.47.2.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sj8G94V89zDrLK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 13:14:41 +1000 (AEST)
From: "Y.B. Lu" <yangbo.lu@nxp.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Scott Wood
 <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring
 <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jochen Friedrich
 <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>, Kumar Gala
 <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Leo Li
 <leoyang.li@nxp.com>, "X.B. Xie" <xiaobo.xie@nxp.com>, "M.H. Lian"
 <minghuan.lian@nxp.com>
Subject: RE: [v12, 0/8] Fix eSDHC host version register bug
Date: Mon, 26 Sep 2016 03:14:32 +0000
Message-ID: <HE1PR04MB08893C8EE38DB311648C1109F8CD0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any comments about this version patchset ?

:)


> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Wednesday, September 21, 2016 2:57 PM
> To: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Scott Wood; Arnd
> Bergmann
> Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> clk@vger.kernel.org; linux-i2c@vger.kernel.org; iommu@lists.linux-
> foundation.org; netdev@vger.kernel.org; Mark Rutland; Rob Herring;
> Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B. Xie; M.H.
> Lian; Y.B. Lu
> Subject: [v12, 0/8] Fix eSDHC host version register bug
>=20
> This patchset is used to fix a host version register bug in the T4240-
> R1.0-R2.0 eSDHC controller. To match the SoC version and revision, 10
> previous version patchsets had tried many methods but all of them were
> rejected by reviewers.
> Such as
> 	- dts compatible method
> 	- syscon method
> 	- ifdef PPC method
> 	- GUTS driver getting SVR method
> Anrd suggested a soc_device_match method in v10, and this is the only
> available method left now. This v11 patchset introduces the
> soc_device_match interface in soc driver.
>=20
> The first six patches of Yangbo are to add the GUTS driver. This is used
> to register a soc device which contain soc version and revision
> information.
> The other two patches introduce the soc_device_match method in soc driver
> and apply it on esdhc driver to fix this bug.
>=20
> Arnd Bergmann (1):
>   base: soc: introduce soc_device_match() interface
>=20
> Yangbo Lu (7):
>   dt: bindings: update Freescale DCFG compatible
>   ARM64: dts: ls2080a: add device configuration node
>   dt: bindings: move guts devicetree doc out of powerpc directory
>   powerpc/fsl: move mpc85xx.h to include/linux/fsl
>   soc: fsl: add GUTS driver for QorIQ platforms
>   MAINTAINERS: add entry for Freescale SoC drivers
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
>=20
>  Documentation/devicetree/bindings/arm/fsl.txt      |   6 +-
>  .../bindings/{powerpc =3D> soc}/fsl/guts.txt         |   3 +
>  MAINTAINERS                                        |  11 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 +
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
>  arch/powerpc/sysdev/fsl_pci.c                      |   2 +-
>  drivers/base/Kconfig                               |   1 +
>  drivers/base/soc.c                                 |  66 ++++++
>  drivers/clk/clk-qoriq.c                            |   3 +-
>  drivers/i2c/busses/i2c-mpc.c                       |   2 +-
>  drivers/iommu/fsl_pamu.c                           |   3 +-
>  drivers/mmc/host/Kconfig                           |   1 +
>  drivers/mmc/host/sdhci-of-esdhc.c                  |  20 ++
>  drivers/net/ethernet/freescale/gianfar.c           |   2 +-
>  drivers/soc/Kconfig                                |   2 +-
>  drivers/soc/fsl/Kconfig                            |  19 ++
>  drivers/soc/fsl/Makefile                           |   1 +
>  drivers/soc/fsl/guts.c                             | 257
> +++++++++++++++++++++
>  include/linux/fsl/guts.h                           | 125 ++++++----
>  .../asm/mpc85xx.h =3D> include/linux/fsl/svr.h       |   4 +-
>  include/linux/sys_soc.h                            |   3 +
>  21 files changed, 478 insertions(+), 61 deletions(-)  rename
> Documentation/devicetree/bindings/{powerpc =3D> soc}/fsl/guts.txt (91%)
> create mode 100644 drivers/soc/fsl/Kconfig  create mode 100644
> drivers/soc/fsl/guts.c  rename arch/powerpc/include/asm/mpc85xx.h =3D>
> include/linux/fsl/svr.h (97%)
>=20
> --
> 2.1.0.27.g96db324
