Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8E10FB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 16:01:38 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77BDFDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 16:01:38 +1000 (EST)
Subject: Re: [PATCH] Add kmemleak annotations to lmb.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <1250287071.5085.2.camel@pc1117.cambridge.arm.com>
References: <e846103b117cc36798b1f352ed526d600fd88e16.1250132460.git.michael@ellerman.id.au>
	<1250178041.14019.34.camel@pc1117.cambridge.arm.com>
	<1250236600.24143.34.camel@pasglop>
	<20090814.124933.146642945.davem@davemloft.net>
	<1250287071.5085.2.camel@pc1117.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-KExQ9XAFS/3qPOvi0hNj"
Date: Thu, 20 Aug 2009 16:01:34 +1000
Message-Id: <1250748094.7670.4.camel@concordia>
Mime-Version: 1.0
Cc: David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-KExQ9XAFS/3qPOvi0hNj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-08-14 at 22:57 +0100, Catalin Marinas wrote:
> On Fri, 2009-08-14 at 12:49 -0700, David Miller wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date: Fri, 14 Aug 2009 17:56:40 +1000
> >=20
> > > On Thu, 2009-08-13 at 16:40 +0100, Catalin Marinas wrote:
> > >> On Thu, 2009-08-13 at 13:01 +1000, Michael Ellerman wrote:
> > >> > We don't actually want kmemleak to track the lmb allocations, so w=
e
> > >> > pass min_count as 0. However telling kmemleak about lmb allocation=
s
> > >> > allows it to scan that memory for pointers to other memory that is
> > >> > tracked by kmemleak, ie. slab allocations etc.
> > >>=20
> > >> Looks alright to me (though I haven't tested it). You can add a
> > >> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > >=20
> > > Actually, Milton pointed to me that we may not want to allow all
> > > LMB chunks to be scanned by kmemleaks, things like the DART hole
> > > that's taken out of the linear mapping for example may need to
> > > be avoided, though I'm not sure what would be the right way to
> > > do it.
> >=20
> > I think that annotating LMB for kmemleak may be more problems
> > that it's worth.
>=20
> BTW, are there many LMB allocations used for storing pointers to other
> objects? If not, it may be worth just annotating those with
> kmemleak_alloc() if you get false positives.

Yeah I think that's probably the safer approach. As Dave says even if
there's nothing obvious, lmb is used for very early allocs which are
more likely to be "special" and cause problems - and only when someone
boots with kmemleak enabled. So we're better to explicitly mark things
we want scanned.

cheers

--=-KExQ9XAFS/3qPOvi0hNj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqM5r4ACgkQdSjSd0sB4dIT9ACfVBYCBtpXoJxhnmbgbKhaOlXf
NX0AnRuR7ZOqyOKGeOVUziT9Ky90vI5w
=Vg2V
-----END PGP SIGNATURE-----

--=-KExQ9XAFS/3qPOvi0hNj--
