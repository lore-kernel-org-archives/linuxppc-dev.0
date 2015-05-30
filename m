Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0103.outbound.protection.outlook.com [65.55.169.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 775C31A0431
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 10:03:47 +1000 (AEST)
Date: Fri, 29 May 2015 19:03:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: Yangbo Lu <yangbo.lu@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>
Subject: Re: powerpc/corenet: enable eSDHC
Message-ID: <20150530000331.GA9143@home.buserror.net>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 06, 2015 at 02:29:08PM +0800, Yangbo Lu wrote:
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  arch/powerpc/configs/corenet32_smp_defconfig | 2 ++
>  arch/powerpc/configs/corenet64_smp_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
> index ca7957b..17fb2e0 100644
> --- a/arch/powerpc/configs/corenet32_smp_defconfig
> +++ b/arch/powerpc/configs/corenet32_smp_defconfig
> @@ -130,6 +130,8 @@ CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_OF_ESDHC=y
>  CONFIG_EDAC=y
>  CONFIG_EDAC_MM_EDAC=y
>  CONFIG_EDAC_MPC85XX=y
> diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
> index 04737aa..4605a55 100644
> --- a/arch/powerpc/configs/corenet64_smp_defconfig
> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> @@ -112,6 +112,8 @@ CONFIG_USB_EHCI_FSL=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_OF_ESDHC=y
>  CONFIG_EDAC=y
>  CONFIG_EDAC_MM_EDAC=y
>  CONFIG_RTC_CLASS=y

With this on t4240rdb I'm continually spammed with:
sdhci-esdhc ffe114000.sdhc: no support for card's volts
mmc0: error -22 whilst initialising SD card
sdhci-esdhc ffe114000.sdhc: no support for card's volts
mmc0: error -22 whilst initialising SD card

Releveant boot messages include:
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sdhci-esdhc ffe114000.sdhc: No vmmc regulator found
sdhci-esdhc ffe114000.sdhc: No vqmmc regulator found
mmc0: SDHCI controller on ffe114000.sdhc [ffe114000.sdhc] using ADMA
...
mmc0: error -22 whilst initialising SD card
...
sdhci-esdhc ffe114000.sdhc: no support for card's volts
mmc0: error -22 whilst initialising SD card

-Scott
