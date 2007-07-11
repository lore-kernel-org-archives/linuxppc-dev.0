Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2569DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:00:16 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6BA0Av3014194
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 03:00:10 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6BA08Bt000817
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 05:00:09 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 11 Jul 2007 18:00:07 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070710161121.GA14556@ld0162-tx32.am.freescale.net>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<20070710161121.GA14556@ld0162-tx32.am.freescale.net>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,=20

> -----Original Message-----
> From: Wood Scott-B07421=20
>=20
> On Tue, Jul 10, 2007 at 04:01:19PM +0200, Segher Boessenkool wrote:
> > > +    - compatible : Should be "fsl,mpc8xxx-dma"
> >=20
> > Should _include_, not should _be_.  And none of this xxx
> > business, of course.
>=20
> Especially since the 85xx/86xx version is not 100% compatible with the
> 83xx version.  How about fsl,mpc8349-dma and fsl,mpc8548-dma=20
> for the two
> variants?

I want to use this one driver to fit for mpc8349 and mpc8548. But it
seems some register difference between them.
Ok, using "fsl,mpc8548-dma".

>=20
> > > +    - extended : Set the DMA channel to work at extended=20
> chain mode.
> > > +                 If not set, the DMA channel will work at basic
> > > +                 chain mode.
> >=20
> > Call it "extended-chain-mode", perhaps?
>=20
It's clear, but maybe too long?

> Or don't call it anything.  The ability to do extended chain mode is
> implicit in being compatible with fsl,mpc8548-dma.

The basic mode could be used for mpc83xx silicons.

>=20
> > > +    - reserved : Reserve the DMA channel to device.
> >=20
> > What does this do?  Reserve it for what device, and where?
> > The OS driver?
>=20
> Some hardware has DMA channels hardwired to certain=20
> peripherals, such as
> an audio codec.  This keeps them from being used as general=20
> purpose DMA
> channels.

DMA channels could be used as ethernet phy. You can point to DMA
channel's 'phandle' in the device node for reserve use.

>=20
> I'd rather just treat the different DMA channels as=20
> independent devices,
> rather than children of a dma "bus", and change the compatible name if
> they're not general purpose.  There's only one register that's shared
> among the channels, and it's a superfluous status summary register.
>=20

Your and my ideas are both sides of a coin. :-)

Thanks!
Wei.
