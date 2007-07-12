Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 828BADDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 19:49:04 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6C9mwFX000859
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:48:59 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6C9mv44025705
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:48:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Thu, 12 Jul 2007 17:48:56 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3E42@zch01exm26.fsl.freescale.net>
In-Reply-To: <368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>
References: <46B96294322F7D458F9648B60E15112C6F3D1E@zch01exm26.fsl.freescale.net>
	<4694F608.2090503@freescale.com>
	<368E1200-1315-4C24-9876-C92CCF65EFE3@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Wood Scott-B07421" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
> Sent: Thursday, July 12, 2007 1:54 AM
> To: Wood Scott-B07421
> Cc: Zhang Wei-r63237; linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH 1/4] Add DMA sector to=20
> Documentation/powerpc/booting-without-of.txt file.
>=20
> >>> I'd rather just treat the different DMA channels as independent =20
> >>> devices,
> >>> rather than children of a dma "bus", and change the compatible =20
> >>> name if
> >>> they're not general purpose.  There's only one register that's =20
> >>> shared
> >>> among the channels, and it's a superfluous status summary=20
> register.
> >>>
> >> Your and my ideas are both sides of a coin. :-)
> >
> > I think there's a substantive difference between them. =20
> Making each =20
> > channel an independent device makes it easier for other drivers to =20
> > use them.
>=20
> True.  If the DMA channels are independent enough, putting them
> in nodes of their own isn't too cumbersome, either.
>=20
>=20

If you want to use DMA engine driver for the reserved channel, you
should add it to dma-controller node and assign 'reserved'.
If you don't want to use DMA engine driver, just remove it from
dma-controller node and put the channel to special device node.

Thanks!
Wei.
