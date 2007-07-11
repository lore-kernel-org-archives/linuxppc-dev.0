Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33653DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:06:51 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6BA6jEL014009
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 03:06:46 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6BA6iQp022204
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 05:06:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 11 Jul 2007 18:06:43 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3D20@zch01exm26.fsl.freescale.net>
In-Reply-To: <14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
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
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
>=20
> > +   k) DMA
> > +
> > +   This sector define DMA for dma-engine driver of Freescale
>=20
> It's called a "device node" or "node", not a "sector".

Ok, "node".

>=20
> > +    - compatible : Should be "fsl,mpc8xxx-dma"
>=20
> Should _include_, not should _be_.  And none of this xxx
> business, of course.
>=20

All right.

> > +    - extended : Set the DMA channel to work at extended=20
> chain mode.
> > +                 If not set, the DMA channel will work at basic
> > +                 chain mode.
>=20
> Call it "extended-chain-mode", perhaps?
>=20

Is it maybe too long?

> > +    - reserved : Reserve the DMA channel to device.
>=20
> What does this do?  Reserve it for what device, and where?
> The OS driver?
>=20

Yes, it reserve for the special device, which must use the fixed
channel. Thus, reserve channels requested by that device.

And in the device node of dts file, you can use such as
"dma-channel=3D<&dma-ch0>" to reference the below channel:

dma-ch0: ch0@100 {
...
}

Thanks!
Wei.
