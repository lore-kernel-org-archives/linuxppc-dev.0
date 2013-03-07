Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5F162C0357
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 03:30:23 +1100 (EST)
Received: from mail102-ch1 (localhost [127.0.0.1])	by
 mail102-ch1-R.bigfish.com (Postfix) with ESMTP id 60374800D1	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 16:30:18 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.228])	by mail102-ch1.bigfish.com (Postfix) with ESMTP id
 4A0431A0089	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 16:30:16
 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Lan Chunhe-B25806 <B25806@freescale.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
Date: Thu, 7 Mar 2013 16:30:14 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D746975@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1362643535-2377-1-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1362643535-2377-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 7, 2013, at 2:05 AM, Chunhe Lan wrote:

> This patch fixes timeout problems on t4240's sdhci controller:
>=20
> 	mmc0: Too large timeout requested for CMD25!
> 	mmc0: Too large timeout requested for CMD25!
> 	mmc0: Too large timeout requested for CMD25!
>=20
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> drivers/mmc/host/sdhci-pltfm.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltf=
m.c
> index 3145a78..9db7b12 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -94,6 +94,7 @@ void sdhci_get_of_property(struct platform_device *pdev=
)
>=20
> 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> +		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
> 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> 			host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>=20
> --=20
> 1.7.6.5
>=20


Why does this occur?  Is it a board issue?  Is it a silicon issue?  Is it d=
ue to some erratum?  Why T4 only?

- k=
