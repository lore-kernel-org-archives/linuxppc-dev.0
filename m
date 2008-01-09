Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D472DDDF97
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:38:38 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m09FcMIu018291
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 08:38:23 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m09FcLs3009176
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 09:38:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Fix remainder calculating bug in single floating
	pointdivision
Date: Wed, 9 Jan 2008 23:38:19 +0800
Message-ID: <6EBEC19BF4A8F843BCD6B9155BBE2515D1B70D@zch01exm26.fsl.freescale.net>
In-Reply-To: <C387A6C8-3FC9-4DD9-A79D-3ADAB1F5A73F@kernel.crashing.org>
References: <11996296134110-git-send-email-Yu.Liu@freescale.com><1199650065.7291.81.camel@pasglop><66F0B96A-5B53-48D3-BB90-07841F3EA1EE@embeddedalley.com>
	<C387A6C8-3FC9-4DD9-A79D-3ADAB1F5A73F@kernel.crashing.org>
From: "Liu Yu" <Yu.Liu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Dan Malek" <dan@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: linuxppc-dev-bounces+b13201=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b13201=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Kumar Gala
> Sent: Tuesday, January 08, 2008 2:20 PM
> To: Dan Malek
> Cc: Liu Yu; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Fix remainder calculating bug in single=20
> floating pointdivision
>=20
>=20
> On Jan 6, 2008, at 2:44 PM, Dan Malek wrote:
>=20
> >
> > On Jan 6, 2008, at 12:07 PM, Benjamin Herrenschmidt wrote:
> >
> >> It's nice to see somebody digging in that scary math emu stuff. If=20
> >> you could also get rid of the warnings, it would be perfect :-)
> >
> > Yes, it is :-)  I didn't think it would have a life beyond MPC8xx.
> >
> >> .... that this code was lifted from
> >> somewhere else (glibc ? gcc soft-float ?),
> >
> > It seems like a lifetime ago....  I copied the framework=20
> from Sparc,=20
> > and the internals from gcc soft-float.  I didn't change any of the=20
> > internal emulation functions (hence, some of the warnings),=20
> just the=20
> > calling interface.
> >
> > While it's convenient, I still don't think kernel float emulation=20
> > should be a solution.  The tools should generate soft-float for the=20
> > applications and libraries.
>=20
> If we think this is really true, we could move to using include/math-
> emu/* instead of the files in powerpc/math-emu.

Why it's better to move to using include/math-emu.
I found they have similar framework, is powerpc/math-emu evolved from
include/math-emu?

>=20
> The problem I had was when I tried to recreate the history of=20
> the code in powerpc/math-emu and how it doesn't really match=20
> the glibc code base.  There are some differences and I wasn't=20
> sure if they were do to trying to match PPC HW at a bit level or not.
>=20
> I was hoping that the work Liu Yu would get as a bit of a=20
> testsuite to see if there was any harm in moving over to=20
> include/math-emu.
>=20
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
