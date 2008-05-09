Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C15C1DDE0C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 20:19:03 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m49AIutr008936
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 03:18:57 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m49AItWP007252
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 05:18:56 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/4 V2] booting-without-of for Freescale MSI
Date: Fri, 9 May 2008 18:18:52 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C16F0@zch01exm27.fsl.freescale.net>
In-Reply-To: <a7387ce0860d7d5bcd990f1364310221@kernel.crashing.org>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<c6e4b0f3534e38db766d76fd6450f163@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A8C16ED@zch01exm27.fsl.freescale.net>
	<a7387ce0860d7d5bcd990f1364310221@kernel.crashing.org>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
> Sent: Friday, May 09, 2008 6:14 PM
> To: Jin Zhengxiong
> Cc: michael@ellerman.id.au; linuxppc-dev@ozlabs.org;=20
> galak@kernel.crashing.org
> Subject: Re: [PATCH 1/4 V2] booting-without-of for Freescale MSI
>=20
> >> If these MSI devices work really identical for 83xx, 85xx, 86xx,=20
> >> there is no need to distinguish between them for probing either --=20
> >> you want to use the same driver for all, anyway
> > .
> > The driver can work for 83xx, 85xx and 86xx,  but the msiir=20
> offset is=20
> > different for 83xx and 85xx/86xx cpu. I need this to get different=20
> > msiir offset in the driver.
>=20
> It's a different offset _within_ the region specified in "reg"?
> Yeah, using different "compatible" is cleanest then, no doubt.
>=20
Yes, It's different offset _within_ the "reg" region.

> >>> +    - msi-available-ranges: use <start count> style
> >> section to define
> >>> which
> >>> +      msi interrupt can be used in the 256 msi interrupts.
> >>
> >> Please make this property optional, default to "all available".
> >>
> > The value setting for this property is "all available", and this=20
> > ranges maybe useful for some other MSI controller.
>=20
> Sure, I didn't say to drop the property, just make it=20
> optional, since most trees will want the same value anyway.

So, The code should change to work with this change, If there's the=20
property, use it. If no, make it all available, Am I right?

Jason
