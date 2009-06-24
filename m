Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 02BF9B70C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 10:55:34 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3CC0DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 10:55:33 +1000 (EST)
Subject: Re: [PATCH] powerpc/ps3: Use pr_devel() in ps3/mm.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4A4108A3.8060003@am.sony.com>
References: <8977d21ed6cf59b89f9a830d59968ce178420a46.1245722192.git.michael@ellerman.id.au>
	<4A4108A3.8060003@am.sony.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-1+mCou/r+kHk5712RbQa"
Date: Wed, 24 Jun 2009 10:55:32 +1000
Message-Id: <1245804932.9237.30.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-1+mCou/r+kHk5712RbQa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-06-23 at 09:53 -0700, Geoff Levand wrote:
> On 06/22/2009 06:56 PM, Michael Ellerman wrote:
> > The non-debug case in ps3/mm.c uses pr_debug(), so that the compiler
> > still does type checks etc. and doesn't complain about unused
> > variables in the non-debug case.
> >=20
> > However with DEBUG=3Dn and CONFIG_DYNAMIC_DEBUG=3Dy there's still code
> > generated for those pr_debugs().
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >  arch/powerpc/platforms/ps3/mm.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> Looks good, thanks.  I put it on the todo list to go through
> the the remaining PS3 code to check for the same.

Cool, I've been slowly going through as I have time but I'll leave ps3
to you. I see ~270 uses in 9 files.

There are places where being able to dynamically enable the debug is
useful, but there are plenty where it's not also.

cheers

--=-1+mCou/r+kHk5712RbQa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpBeYQACgkQdSjSd0sB4dLlvgCgimbHhJCOuUK2vx/duJZzke8x
z3UAoJ7q4wEytaeyXSvqQdlL+4+3u4iU
=lQUA
-----END PGP SIGNATURE-----

--=-1+mCou/r+kHk5712RbQa--
