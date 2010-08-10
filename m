Return-Path: <R61911@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id 00059B70F8
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 20:07:30 +1000 (EST)
Received: from mail142-va3 (localhost.localdomain [127.0.0.1])	by
	mail142-va3-R.bigfish.com (Postfix) with ESMTP id C2A7AF7018F	for
	<linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 10:07:27 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.253])	by
	mail142-va3.bigfish.com (Postfix) with ESMTP id 87C3F1C5804D	for
	<linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 10:07:27 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7AA7PML010001	for <linuxppc-dev@ozlabs.org>;
	Tue, 10 Aug 2010 03:07:25 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7AA7UJC025048	for <linuxppc-dev@ozlabs.org>;
	Tue, 10 Aug 2010 05:07:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Tue, 10 Aug 2010 18:07:20 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A0562B0@zch01exm23.fsl.freescale.net>
In-Reply-To: <AANLkTikUypKobPAHsE+tz-Py-XvvJhbcj7Syj3rX_ej0@mail.gmail.com>
From: Zang Roy-R61911 <r61911@freescale.com>
To: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
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

=20

> -----Original Message-----
> From: Micha=B3 Miros=B3aw [mailto:mirqus@gmail.com]=20
> Sent: Tuesday, August 10, 2010 2:25 AM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
> akpm@linux-foundation.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for=20
> eSDHC driver
>=20
> 2010/8/3 Roy Zang <tie-fei.zang@freescale.com>:
> [...]
> > @@ -240,6 +240,8 @@ struct sdhci_host {
> > =A0#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<25)
> > =A0/* Controller cannot support End Attribute in NOP ADMA=20
> descriptor */
> > =A0#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1<<26)
> > +/* Controller uses Auto CMD12 command to stop the transfer */
> > +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 =A0 =A0 =A0 =A0 =A0 =A0 =
(1<<27)
> >
> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =
=A0 =A0 =A0 =A0 =A0/* Device IRQ */
> > =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0 =
=A0 /* Mapped address */
>=20
> Just a cosmetic hint: I suggest SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12
> or something for the quirk name, because ACMD12 part might be confused
> with MMC/SD App CMD 12 (CMD55+CMD12 combo) if/whenever that gets used.
Thanks for the suggestion.
There are several ACMD12 needed to be updated.
Send a new patch to update it.
Roy
