Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48A3B1A0414
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jun 2015 20:13:00 +1000 (AEST)
From: Lu Y.B. <yangbo.lu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: powerpc/corenet: enable eSDHC
Date: Mon, 8 Jun 2015 10:12:52 +0000
Message-ID: <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
 <20150530000331.GA9143@home.buserror.net>
In-Reply-To: <20150530000331.GA9143@home.buserror.net>
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

Thanks a lot, Scott.
And now a patch was merged on git://git.linaro.org/people/ulf.hansson/mmc.g=
it next branch to fix this issue.
It should be no problem.


>From 5fd26c7ecb32082745b0bd33c8e35badd1cb5a91 Mon Sep 17 00:00:00 2001
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 5 Jun 2015 11:40:08 +0200
Subject: [PATCH] mmc: sdhci: Restore behavior while creating OCR mask

Commit 3a48edc4bd68 ("mmc: sdhci: Use mmc core regulator infrastucture")
changed the behavior for how to assign the ocr_avail mask for the mmc
host. More precisely it started to mask the bits instead of assigning
them.

Restore the behavior, but also make it clear that an OCR mask created
from an external regulator overrides the other ones. The OCR mask is
determined by one of the following with this priority:

1. Supported ranges of external regulator if one supplies VDD
2. Host OCR mask if set by the driver (based on DT properties)
3. The capabilities reported by the controller itself

Fixes: 3a48edc4bd68 ("mmc: sdhci: Use mmc core regulator infrastucture")
Cc: Tim Kryger <tim.kryger@gmail.com>
Reported-by: Yangbo Lu <yangbo.lu@freescale.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@gmail.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b4861d..706bb60 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3256,13 +3256,14 @@ int sdhci_add_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
=20
-	/* If OCR set by external regulators, use it instead */
+	/* If OCR set by host, use it instead. */
+	if (host->ocr_mask)
+		ocr_avail =3D host->ocr_mask;
+
+	/* If OCR set by external regulators, give it highest prio. */
 	if (mmc->ocr_avail)
 		ocr_avail =3D mmc->ocr_avail;
=20
-	if (host->ocr_mask)
-		ocr_avail &=3D host->ocr_mask;
-
 	mmc->ocr_avail =3D ocr_avail;
 	mmc->ocr_avail_sdio =3D ocr_avail;
 	if (host->ocr_avail_sdio)
--=20
2.1.0.27.g96db324



Best regards,
Yangbo Lu


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, May 30, 2015 8:04 AM
> To: Lu Yangbo-B47093
> Cc: linuxppc-dev@lists.ozlabs.org; linux-mmc@vger.kernel.org
> Subject: Re: powerpc/corenet: enable eSDHC
>=20
> On Wed, May 06, 2015 at 02:29:08PM +0800, Yangbo Lu wrote:
> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > ---
> >  arch/powerpc/configs/corenet32_smp_defconfig | 2 ++
> > arch/powerpc/configs/corenet64_smp_defconfig | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/arch/powerpc/configs/corenet32_smp_defconfig
> > b/arch/powerpc/configs/corenet32_smp_defconfig
> > index ca7957b..17fb2e0 100644
> > --- a/arch/powerpc/configs/corenet32_smp_defconfig
> > +++ b/arch/powerpc/configs/corenet32_smp_defconfig
> > @@ -130,6 +130,8 @@ CONFIG_USB_OHCI_HCD_PPC_OF_LE=3Dy
> > CONFIG_USB_STORAGE=3Dy  CONFIG_MMC=3Dy  CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_PLTFM=3Dy
> > +CONFIG_MMC_SDHCI_OF_ESDHC=3Dy
> >  CONFIG_EDAC=3Dy
> >  CONFIG_EDAC_MM_EDAC=3Dy
> >  CONFIG_EDAC_MPC85XX=3Dy
> > diff --git a/arch/powerpc/configs/corenet64_smp_defconfig
> > b/arch/powerpc/configs/corenet64_smp_defconfig
> > index 04737aa..4605a55 100644
> > --- a/arch/powerpc/configs/corenet64_smp_defconfig
> > +++ b/arch/powerpc/configs/corenet64_smp_defconfig
> > @@ -112,6 +112,8 @@ CONFIG_USB_EHCI_FSL=3Dy  CONFIG_USB_STORAGE=3Dy
> > CONFIG_MMC=3Dy  CONFIG_MMC_SDHCI=3Dy
> > +CONFIG_MMC_SDHCI_PLTFM=3Dy
> > +CONFIG_MMC_SDHCI_OF_ESDHC=3Dy
> >  CONFIG_EDAC=3Dy
> >  CONFIG_EDAC_MM_EDAC=3Dy
> >  CONFIG_RTC_CLASS=3Dy
>=20
> With this on t4240rdb I'm continually spammed with:
> sdhci-esdhc ffe114000.sdhc: no support for card's volts
> mmc0: error -22 whilst initialising SD card sdhci-esdhc ffe114000.sdhc:
> no support for card's volts
> mmc0: error -22 whilst initialising SD card
>=20
> Releveant boot messages include:
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper sdhci-esdhc
> ffe114000.sdhc: No vmmc regulator found sdhci-esdhc ffe114000.sdhc: No
> vqmmc regulator found
> mmc0: SDHCI controller on ffe114000.sdhc [ffe114000.sdhc] using ADMA ...
> mmc0: error -22 whilst initialising SD card ...
> sdhci-esdhc ffe114000.sdhc: no support for card's volts
> mmc0: error -22 whilst initialising SD card
>=20
> -Scott
