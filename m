Return-Path: <R61911@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id B3FCB1007D2
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 16:20:12 +1000 (EST)
Received: from mail66-db3 (localhost.localdomain [127.0.0.1])	by
	mail66-db3-R.bigfish.com (Postfix) with ESMTP id 458918003C6	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 06:20:08 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.247])	by
	mail66-db3.bigfish.com (Postfix) with ESMTP id DD6F791804F	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 06:20:07 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o726K3LG026306	for <linuxppc-dev@ozlabs.org>;
	Sun, 1 Aug 2010 23:20:03 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o726VHM1026546	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 01:31:18 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits workaround
Date: Mon, 2 Aug 2010 14:19:58 +0800
Message-ID: <83024545B35D6445A690EFD603E7869A07ED05@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100730070624.GB20351@oksana.dev.rtsoft.ru>
References: <1280461977-2023-1-git-send-email-tie-fei.zang@freescale.com>
	<20100730070624.GB20351@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Anton Vorontsov" <cbouatmailru@gmail.com>
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
> From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]=20
> Sent: Friday, July 30, 2010 15:06 PM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
> akpm@linux-foundation.org
> Subject: Re: [PATCH 3/3 v2] mmc: Add ESDHC weird voltage bits=20
> workaround
>=20
> On Fri, Jul 30, 2010 at 11:52:57AM +0800, Roy Zang wrote:
> > P4080 ESDHC controller does not support 1.8V and 3.0V=20
> voltage. but the
> > host controller capabilities register wrongly set the bits.
> > This patch adds the workaround to correct the weird voltage=20
> setting bits.
> >=20
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> [...]
> > diff --git a/drivers/mmc/host/sdhci-of-core.c=20
> b/drivers/mmc/host/sdhci-of-core.c
> > index 0c30242..1f3913d 100644
> > --- a/drivers/mmc/host/sdhci-of-core.c
> > +++ b/drivers/mmc/host/sdhci-of-core.c
> > @@ -164,6 +164,10 @@ static int __devinit=20
> sdhci_of_probe(struct of_device *ofdev,
> >  	if (sdhci_of_wp_inverted(np))
> >  		host->quirks |=3D SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> > =20
> > +	if (of_device_is_compatible(np, "fsl,p4080-esdhc"))
> > +		host->quirks |=3D (SDHCI_QUIRK_QORIQ_NO_VDD_180
> > +				|SDHCI_QUIRK_QORIQ_NO_VDD_300);
> > +
>=20
> It should be two properties, something like sdhci,no-vdd-180
> and sdhci,no-vdd-300. But it might be even better: we have
> voltage-ranges for mmc-spi case, see
> Documentation/powerpc/dts-bindings/mmc-spi-slot.txt.
>=20
> If voltage-ranges specified, then we use it, not capabilities
> register.
>=20
> For p4080 it will be 'voltage-ranges =3D <3200 3400>;'. So, with
> voltage-ranges we can do fine grained VDD control without
> introducing anything new.
why not
               voltage-ranges =3D <3300 3300>;
?
Roy
