Return-Path: <ulf.hansson@linaro.org>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfRRn5KrnzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 21:28:04 +1000 (AEST)
Received: by mail-wm0-x22f.google.com with SMTP id 191so21112845wmq.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Apr 2016 04:28:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
References: <1459480051-3701-1-git-send-email-yangbo.lu@nxp.com>
Date: Tue, 5 Apr 2016 13:27:58 +0200
Message-ID: <CAPDyKFqgMCvbqMYZ-uM-rTnVvfJkCYbhv2kucCRyNyc9FWoR=Q@mail.gmail.com>
Subject: Re: [v7, 0/5] Fix eSDHC host version register bug
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-clk@vger.kernel.org,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, scott.wood@nxp.com,
 Russell King <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>,
 Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>,
 Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 leoyang.li@nxp.com, xiaobo.xie@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1 April 2016 at 05:07, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
> eSDHC controller. To get the SoC version and revision, it's needed to add the
> GUTS driver to access the global utilities registers.
>
> So, the first three patches are to add the GUTS driver.
> The following two patches are to enable GUTS driver support to get SVR in eSDHC
> driver and fix host version for T4240.
>
> Yangbo Lu (5):
>   ARM64: dts: ls2080a: add device configuration node
>   soc: fsl: add GUTS driver for QorIQ platforms
>   dt: move guts devicetree doc out of powerpc directory
>   powerpc/fsl: move mpc85xx.h to include/linux/fsl
>   mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0
>
>  .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 ++
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
>  drivers/clk/clk-qoriq.c                            |   3 +-
>  drivers/i2c/busses/i2c-mpc.c                       |   2 +-
>  drivers/iommu/fsl_pamu.c                           |   3 +-
>  drivers/mmc/host/Kconfig                           |   1 +
>  drivers/mmc/host/sdhci-of-esdhc.c                  |  23 ++++
>  drivers/net/ethernet/freescale/gianfar.c           |   2 +-
>  drivers/soc/Kconfig                                |   2 +-
>  drivers/soc/fsl/Kconfig                            |   8 ++
>  drivers/soc/fsl/Makefile                           |   1 +
>  drivers/soc/fsl/guts.c                             | 119 +++++++++++++++++++++
>  include/linux/fsl/guts.h                           |  98 ++++++++---------
>  .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
>  15 files changed, 219 insertions(+), 58 deletions(-)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/guts.c
>  rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)
>
> --
> 2.1.0.27.g96db324
>

I was about to queue this for next, when I noticed that checkpatch is
complaining/warning lots about these patches. Can you please a round
of checkpatch and fix what makes sense.

Kind regards
Uffe
