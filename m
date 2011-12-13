Return-Path: <r66093@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 62A341007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 19:00:29 +1100 (EST)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] mmc: sdhci-pltfm: Added sdhci-adjust-timeout quirk
Date: Tue, 13 Dec 2011 08:00:19 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11644C44@039-SN1MPN1-006.039d.mgd.msft.net>
References: <y> <1323075320-9138-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1323075320-9138-1-git-send-email-X.Xie@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Xie Xiaobo-R63061 <r63061@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xiaobo, I have one other similar patch, but the property is 'sdhci,adjust-t=
imeout'.
Maybe I can repost it with add your signed-off-by?

> -----Original Message-----
> From: linuxppc-dev-bounces+r66093=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+r66093=3Dfreescale.com@lists.ozlabs.org] On
> Behalf Of Xie Xiaobo
> Sent: Monday, December 05, 2011 4:55 PM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: avorontsov@ru.mvista.com; linux-mmc@vger.kernel.org; Xie Xiaobo-
> R63061
> Subject: [PATCH] mmc: sdhci-pltfm: Added sdhci-adjust-timeout quirk
>=20
> Some controller provides an incorrect timeout value for transfers,
> So it need the quirk to adjust timeout value to 0xE.
> E.g. eSDHC of MPC8536, P1010, and P2020.
>=20
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> pltfm.c
> index a9e12ea..b5d6b3f 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -2,7 +2,7 @@
>   * sdhci-pltfm.c Support for SDHCI platform devices
>   * Copyright (c) 2009 Intel Corporation
>   *
> - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + * Copyright (c) 2007, 2011 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
>   *
>   * Authors: Xiaobo Xie <X.Xie@freescale.com>
> @@ -68,6 +68,9 @@ void sdhci_get_of_property(struct platform_device *pdev=
)
>  		if (of_get_property(np, "sdhci,1-bit-only", NULL))
>  			host->quirks |=3D SDHCI_QUIRK_FORCE_1_BIT_DATA;
>=20
> +		if (of_get_property(np, "sdhci,sdhci-adjust-timeout", NULL))
> +			host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +
>  		if (sdhci_of_wp_inverted(np))
>  			host->quirks |=3D SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>=20
> --
> 1.6.4
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
