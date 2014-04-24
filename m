Return-Path: <ulf.hansson@linaro.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46E7A14008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:25:47 +1000 (EST)
Received: by mail-qa0-f51.google.com with SMTP id j7so1937348qaq.24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 01:25:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Date: Thu, 24 Apr 2014 10:25:42 +0200
Message-ID: <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>,
 linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>,
 Chris Ball <chris@printf.net>, Thierry Reding <thierry.reding@gmail.com>,
 Anton Vorontsov <anton@enomsg.org>, Michal Simek <michal.simek@xilinx.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 spear-devel@list.st.com, Rob Herring <robh+dt@kernel.org>,
 Ben Dooks <ben-linux@fluff.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Shawn Guo <shawn.guo@freescale.com>, Barry Song <baohua@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Viresh Kumar <viresh.linux@gmail.com>, Sascha Hauer <kernel@pengutronix.de>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23 April 2014 20:55, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> All,
>
> This is where I'm at with trying to clean up the SDHCI mess, and sort out
> issues I've noticed when trying to get UHS support working on CuBoxes.
> This is my full patch set, but I recommend not applying patch 37 as there
> appears to be a hardware issue preventing it working reliably.
>
> In any case, patches 0-33 inclusive are the SDHCI clean up, based against
> v3.15-rc1.  Patches 34 and 35 are Olof's Wifi support, 36 is my fix against
> those, and 38 adds the Broadcom Wifi and BT support for CuBox.
>
> The questions over how to handle these devices were never properly settled,
> so I recommend against merging patch 34 onwards.  As for the rest, I'm not
> planning on any further work, so it may be a good idea for people to
> consider testing them with a view to getting them merged.
>

I have looked though the patches up until patch 33 and this is clearly
a nice piece of clean-up /fixes work for sdhci. Besides my minor
comments per patch, I don't have any objections code-review wise to
proceed merging them.

I have also tried to applied them on Chris' mmc-next branch,
unfortunate it fails at patch 23, so it would be nice to get a
re-based patchset for the mmc-next branch.

Kind regards
Ulf Hansson

>  Documentation/devicetree/bindings/mmc/mmc.txt |  11 +
>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi        |  34 +-
>  arch/arm/boot/dts/imx6qdl-microsom.dtsi       |  98 ++++
>  drivers/mmc/core/core.c                       |  42 ++
>  drivers/mmc/core/host.c                       |  68 +++
>  drivers/mmc/core/sdio_irq.c                   |  41 +-
>  drivers/mmc/host/Kconfig                      |  63 +--
>  drivers/mmc/host/dw_mmc.c                     |   2 +
>  drivers/mmc/host/sdhci-acpi.c                 |   8 +
>  drivers/mmc/host/sdhci-bcm-kona.c             |   4 +
>  drivers/mmc/host/sdhci-bcm2835.c              |   4 +
>  drivers/mmc/host/sdhci-cns3xxx.c              |  13 +-
>  drivers/mmc/host/sdhci-dove.c                 |   4 +
>  drivers/mmc/host/sdhci-esdhc-imx.c            |  82 +--
>  drivers/mmc/host/sdhci-esdhc.h                |   4 +-
>  drivers/mmc/host/sdhci-of-arasan.c            |   4 +
>  drivers/mmc/host/sdhci-of-esdhc.c             |  70 ++-
>  drivers/mmc/host/sdhci-of-hlwd.c              |   4 +
>  drivers/mmc/host/sdhci-pci.c                  |   9 +-
>  drivers/mmc/host/sdhci-pltfm.c                |   4 +
>  drivers/mmc/host/sdhci-pxav2.c                |  14 +-
>  drivers/mmc/host/sdhci-pxav3.c                |  13 +-
>  drivers/mmc/host/sdhci-s3c.c                  |  36 +-
>  drivers/mmc/host/sdhci-sirf.c                 |   4 +
>  drivers/mmc/host/sdhci-spear.c                |   5 +-
>  drivers/mmc/host/sdhci-tegra.c                |  27 +-
>  drivers/mmc/host/sdhci.c                      | 728 +++++++++++++-------------
>  drivers/mmc/host/sdhci.h                      |  20 +-
>  include/linux/mmc/host.h                      |   8 +
>  include/linux/mmc/sdhci.h                     |  15 +-
>  30 files changed, 885 insertions(+), 554 deletions(-)
>
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
