Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDDEEDDEDE
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 14:05:54 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m2635m35005242
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 20:05:48 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2635lBW025585
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 21:05:47 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] math-emu: delete PowerPC old math-emu headers
Date: Thu, 6 Mar 2008 11:05:44 +0800
Message-ID: <6EBEC19BF4A8F843BCD6B9155BBE2515E22911@zch01exm26.fsl.freescale.net>
In-Reply-To: <1204713892.21545.199.camel@pasglop>
References: <12047077481825-git-send-email-Yu.Liu@freescale.com>
	<1204713892.21545.199.camel@pasglop>
From: "Liu Yu" <Yu.Liu@freescale.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> On Wed, 2008-03-05 at 17:02 +0800, Liu Yu wrote:
> > Use common headers as a replacement.
> > The Common headers are located in "include/math-emu/", they=20
> are used=20
> > by multiple platforms such as s390, sparc, alpha.
> >=20
> > As the common headers have more developers, they are more=20
> popular and=20
> > more stable.
> >=20
> > In fact, PowerPC old math-emu headers cannot handle float point=20
> > exceptions exactly while the common headers can.
>=20
> That sounds like an excellent idea. However, were you able to=20
> run some kind of test suite to verify that the emulation=20
> works properly ?
>=20

Not yet, for I don't have the right environment. :-(

We have a patch to handle MPC85xx SPE.
The patch is not yet a part of kernel and used to adopt PowerPC math-emu
headers=20
like current math-emu for PowerPC FP does.=20

When we ran TestFloat which is a famous FP test suite to test the SPE
patch,
it reported numerous errors and most of them concerned wrong FP
exception flags.
After we change the SPE patch to the common math-emu headers, the result
of TestFloat are splendid.

So I think the same change should be done on current PowerPC FP
math-emu.
