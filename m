Return-Path: <R61911@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48AA4B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 19:09:05 +1100 (EST)
Received: from mail195-va3 (localhost.localdomain [127.0.0.1])	by
	mail195-va3-R.bigfish.com (Postfix) with ESMTP id D38F2F50182	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 19 Oct 2010 08:08:58 +0000 (UTC)
Received: from VA3EHSMHS029.bigfish.com (unknown [10.7.14.242])	by
	mail195-va3.bigfish.com (Postfix) with ESMTP id 5861C5E804C	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 19 Oct 2010 08:08:58 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9J89PXb025188	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 19 Oct 2010 01:09:25 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o9J8PLfI018712	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 03:25:22 -0500 (CDT)
Subject: RE: eSDHC controller driver on MPC8308rdb
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 19 Oct 2010 16:09:04 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A2B07E4@zch01exm23.fsl.freescale.net>
In-Reply-To: <4CBD4EFB.6070603@windriver.com>
References: <DF61B4AD1C20A54EADF5C05E1F1110DE08D449@Exchange.parkairsystems.net><4CBC04E8.5030706@windriver.com><DF61B4AD1C20A54EADF5C05E1F1110DE08D44C@Exchange.parkairsystems.net>
	<4CBD4EFB.6070603@windriver.com>
From: Zang Roy-R61911 <r61911@freescale.com>
To: <Bo.Liu@windriver.com>, Maria Johansen <m.johansen@no.parkairsystems.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: =
linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.org
>
[mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.or=
g
] On
> Behalf Of Tonyliu
> Sent: Tuesday, October 19, 2010 15:56 PM
> To: Maria Johansen
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: eSDHC controller driver on MPC8308rdb
>=20
> Maria Johansen wrote:
> >
> >> -----Original Message-----
> >> From: Tonyliu [mailto:Bo.Liu@windriver.com]
> >> <snip>
> >>
> >>> Could this be a problem related the eSDHC controller (or the
driver),
> >>> or is it the memory card? (a 4GB SanDisk Extreme SDHC card, which
> unfortunately is the only card I have available at the moment.) I will
keep
> digging into drivers/mmc/host/sdhci.c in search of a solution, and any
tips to
> how I should proceed would be greatly appreciated!
> >>>
> >>>
> >> Hi,
> >> Try the patch in attatchment. By default, on some e300 platforms
such as
> mpc8308_rdb, the entry "clock-frequency" of section sdchi in DTB is
not fixed
> by u-boot, so has to >caculate the input clock for sdhci controller
explicitly
> in driver.
> >>
> >> Tony
> >>
> >
> > Thanks, the missing clock-frequency was part of my problem. The rest
was
> solved by adding some more quirks to the esdhc-driver
> (SDHCI_QUIRK_FORCE_1_BIT_DATA and SDHCI_QUIRK_RESET_AFTER_REQUEST).
Why it is
> necessary to force 1-bit data transfers I am a bit unsure about, since
the
> mpc8308 reference manual clearly states that 4-bit transfers are
supported.
> >
> Actually, I did use 4-bit mode. You can try another 2 quicks:
>=20
> +   if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> +       host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> +
> +   if (of_get_property(np, "sdhci,broken-timeout", NULL))
> +       host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +
>=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9d4fdfa..b7a1ce4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -807,8 +807,12 @@ static void sdhci_set_transfer_mode(struct
> sdhci_host *host,
>     WARN_ON(!host->data);
>=20
>     mode =3D SDHCI_TRNS_BLK_CNT_EN;
> -   if (data->blocks > 1)
> +   if (data->blocks > 1) {
> +       if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> +           mode |=3D SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
> +       else
>         mode |=3D SDHCI_TRNS_MULTI;
> +   }
>     if (data->flags & MMC_DATA_READ)
>         mode |=3D SDHCI_TRNS_READ;
>     if (host->flags & SDHCI_REQ_USE_DMA)
> @@ -1099,6 +1103,13 @@ static void sdhci_request(struct mmc_host *mmc,
> struct mmc_request *mrq)
>     sdhci_activate_led(host);
>  #endif
>=20
> +   if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12) {
> +       if (mrq->stop) {
> +           mrq->data->stop =3D NULL;
> +           mrq->stop =3D NULL;
> +       }
> +   }
> +
>     host->mrq =3D mrq;
>=20
>=20
> I don't have patch for upstream, you can add them manually.


https://patchwork.kernel.org/patch/176752/


Roy
