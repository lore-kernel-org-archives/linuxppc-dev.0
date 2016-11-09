Return-Path: <ulf.hansson@linaro.org>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com
 [IPv6:2a00:1450:400c:c09::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDZRY4nLzzDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 05:27:53 +1100 (AEDT)
Received: by mail-wm0-x235.google.com with SMTP id f82so259356506wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 10:27:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1478661252-42439-1-git-send-email-yangbo.lu@nxp.com>
References: <1478661252-42439-1-git-send-email-yangbo.lu@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Nov 2016 19:27:47 +0100
Message-ID: <CAPDyKFrcAN_pqgtGaUanfB2zh97zGcL23m5VDtJ3g==NJeRrfA@mail.gmail.com>
Subject: Re: [v16, 0/7] Fix eSDHC host version register bug
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Scott Wood <oss@buserror.net>,
 Arnd Bergmann <arnd@arndb.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Kumar Gala <galak@codeaurora.org>, Leo Li <leoyang.li@nxp.com>,
 Xiaobo Xie <xiaobo.xie@nxp.com>, Minghuan Lian <minghuan.lian@nxp.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- i2c-list

On 9 November 2016 at 04:14, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
> eSDHC controller. To match the SoC version and revision, 15 previous version
> patchsets had tried many methods but all of them were rejected by reviewers.
> Such as
>         - dts compatible method
>         - syscon method
>         - ifdef PPC method
>         - GUTS driver getting SVR method
> Anrd suggested a soc_device_match method in v10, and this is the only available
> method left now. This v11 patchset introduces the soc_device_match interface in
> soc driver.
>
> The first four patches of Yangbo are to add the GUTS driver. This is used to
> register a soc device which contain soc version and revision information.
> The other three patches introduce the soc_device_match method in soc driver
> and apply it on esdhc driver to fix this bug.
>
> ---
> Changes for v15:
>         - Dropped patch 'dt: bindings: update Freescale DCFG compatible'
>           since the work had been done by below patch on ShawnGuo's linux tree.
>           'dt-bindings: fsl: add LS1043A/LS1046A/LS2080A compatible for SCFG
>            and DCFG'
>         - Fixed error code issue in guts driver
> Changes for v16:
>         - Dropped patch 'powerpc/fsl: move mpc85xx.h to include/linux/fsl'
>         - Added a bug-fix patch from Geert
> ---
>
> Arnd Bergmann (1):
>   base: soc: introduce soc_device_match() interface
>
> Geert Uytterhoeven (1):
>   base: soc: Check for NULL SoC device attributes
>
> Yangbo Lu (5):
>   ARM64: dts: ls2080a: add device configuration node
>   dt: bindings: move guts devicetree doc out of powerpc directory
>   soc: fsl: add GUTS driver for QorIQ platforms
>   MAINTAINERS: add entry for Freescale SoC drivers
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
>
>  .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
>  MAINTAINERS                                        |  11 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 +
>  drivers/base/Kconfig                               |   1 +
>  drivers/base/soc.c                                 |  70 ++++++
>  drivers/mmc/host/Kconfig                           |   1 +
>  drivers/mmc/host/sdhci-of-esdhc.c                  |  20 ++
>  drivers/soc/Kconfig                                |   3 +-
>  drivers/soc/fsl/Kconfig                            |  18 ++
>  drivers/soc/fsl/Makefile                           |   1 +
>  drivers/soc/fsl/guts.c                             | 236 +++++++++++++++++++++
>  include/linux/fsl/guts.h                           | 125 ++++++-----
>  include/linux/sys_soc.h                            |   3 +
>  13 files changed, 447 insertions(+), 51 deletions(-)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/guts.c
>
> --
> 2.1.0.27.g96db324
>

Thanks, applied on my mmc tree for next!

I noticed that some DT compatibles weren't documented, according to
checkpatch. Please fix that asap!

Kind regards
Ulf Hansson
