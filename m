Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3C4EDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 19:46:08 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6C9k15R001458
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:46:01 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6C9jxWE023313
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:46:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Thu, 12 Jul 2007 17:45:58 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3E41@zch01exm26.fsl.freescale.net>
In-Reply-To: <3325F1D3-5C03-492C-B1CE-7626DC791656@kernel.crashing.org>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3D20@zch01exm26.fsl.freescale.net>
	<3325F1D3-5C03-492C-B1CE-7626DC791656@kernel.crashing.org>
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
> >> Call it "extended-chain-mode", perhaps?
> >
> > Is it maybe too long?
>=20
> Not really no.  It's only 19 characters, and it isn't used
> all over the place, so that should be fine.

Ok,

>=20
> >>> +    - reserved : Reserve the DMA channel to device.
> >>
> >> What does this do?  Reserve it for what device, and where?
> >> The OS driver?
> >>
> >
> > Yes, it reserve for the special device, which must use the fixed
> > channel. Thus, reserve channels requested by that device.
> >
> > And in the device node of dts file, you can use such as
> > "dma-channel=3D<&dma-ch0>" to reference the below channel:
> >
> > dma-ch0: ch0@100 {
> > ...
> > }
>=20
> Right, so you don't need a "reserved" property, that information
> is in the tree already.

Ok, I'll remove "reserved" description.

>=20
> Alternatively, for ease of use, you could put a "reserved" bitmap
> in the master DMA controller node.  I wouldn't make nodes per
> channel anyway, just describe the channels using properties -- that
> takes care of the "reg" vs. "ranges" thing too, etc.

Bitmap for reserved? Not very clear. :(

Thanks!
Wei.
