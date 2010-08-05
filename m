Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 57AAC1007D1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 11:03:17 +1000 (EST)
Received: by gxk25 with SMTP id 25so3834617gxk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Aug 2010 18:03:16 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 4 Aug 2010 19:02:56 -0600
Message-ID: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
To: Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 2, 2010 at 9:11 PM, Roy Zang <tie-fei.zang@freescale.com> wrote=
:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> Add auto CMD12 command support for eSDHC driver.
> This is needed by P4080 and P1022 for block read/write.
> Manual asynchronous CMD12 abort operation causes protocol violations on
> these silicons.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A04 ++++
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 14 ++++++++++++--
> =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 | =A0 =A02 ++
> =A03 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..a92566e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -817,8 +817,12 @@ static void sdhci_set_transfer_mode(struct sdhci_hos=
t *host,
> =A0 =A0 =A0 =A0WARN_ON(!host->data);
>
> =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
> - =A0 =A0 =A0 if (data->blocks > 1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
> + =A0 =A0 =A0 if (data->blocks > 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_R=
EAD_ACMD12)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI =
| SDHCI_TRNS_ACMD12;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;

nit:
+               mode |=3D SDHCI_TRNS_MULTI;
+               if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+                       mode |=3D SDHCI_TRNS_ACMD12;

Clearer, no?

> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (data->flags & MMC_DATA_READ)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode |=3D SDHCI_TRNS_READ;
> =A0 =A0 =A0 =A0if (host->flags & SDHCI_REQ_USE_DMA)
