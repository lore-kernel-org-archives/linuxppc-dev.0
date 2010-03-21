Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4561CB7CF6
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 06:25:39 +1100 (EST)
From: Ben Hutchings <ben@decadent.org.uk>
To: Andi Kleen <andi@firstfloor.org>
In-Reply-To: <87y6hlebik.fsf@basil.nowhere.org>
References: <1269126097.18314.111.camel@localhost>
	<1269126340.18314.115.camel@localhost>
	<87y6hlebik.fsf@basil.nowhere.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-aTG0+FBLZ4wAKesqS+5r"
Date: Sun, 21 Mar 2010 19:25:21 +0000
Message-ID: <1269199521.18314.220.camel@localhost>
Mime-Version: 1.0
Subject: Re: [PATCH 2/4] panic: Allow taint flag for warnings to be changed
	from TAINT_WARN
Cc: linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linuxppc-dev@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-aTG0+FBLZ4wAKesqS+5r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-03-21 at 20:10 +0100, Andi Kleen wrote:
> Ben Hutchings <ben@decadent.org.uk> writes:
>=20
> > WARN() is used in some places to report firmware or hardware bugs that
> > are then worked-around.  These bugs do not affect the stability of the
> > kernel and should not set the usual TAINT_WARN flag.  To allow for
> > this, add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint
> > flag as argument.
> >
> > Architectures that implement warnings using trap instructions instead
> > of calls to warn_slowpath_*() must now implement __WARN_TAINT(taint)
> > instead of __WARN().
>=20
> I guess this should enforce that at least some taint flag is set?
> (e.g. with a BUILD_BUG_ON)

I'm being a bit sloppy with the wording here.  The TAINT_* macros are
actually bit numbers, not flags.  I could define a TAINT_MAX and add:

	BUILD_BUG_ON(taint < 0 || taint > TAINT_MAX);

Not sure that that's really worth doing though.

Ben.

--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.

--=-aTG0+FBLZ4wAKesqS+5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUAS6Zym+e/yOyVhhEJAQIoiA/+PtVtlFPVa6k50dvxo4ESDxteBVZfWXQZ
eu2QKBNWV9+YyonKYEkmD+HykXOT9+c8P5KthlGXPKiwTAbR1BE8tkaKOvI6WGUo
kK00Ie8kyIel99IKPaOsxSHQmda6pybUv+shIlx5zd1Ep9b9kDNflILNVLB8Xb/G
py0gRfbX1Oru49CAk5vHnCV3PpnmhdG9U94Y+agCdqXRlFGUHcRDeCkbHXxvmdBJ
eSTXqrD9YXwuJCk/vuJc+Zz1oxaKGu5RCK3ztRBD2afF41NB1KOy+zCv/hTEPHLl
OoKeV9vQG8wVtFGe5nDXTy2tGnZZI9O3W/jssnfzcyDf/DPX164fiQwMHSDfP0lB
Vzqtl/9/xOi8jZ7pDLz/4QtZfMr8/25cmWzuzazuqQTHKa5Gvl1On0LEA9e7uXqN
5u9VVK0sYNS2+zyM+JveFarY7+PMpeOZL1xeudD/fBDau9tUHkRywwlFt3HzVKDn
wwIuNWASR2taYgEGUT0ULyaM6judARKvHpwg8ger3WFc1l1r3jb6CgGoyqxWuOCA
OA7x9706CSvkFZ8ZKufUDqbORXtQWaGltGcGEvhOW6VygnW5oSivaYQ5OFAVPZOg
eVqjJMaR7lwW8geSX8fA2ht/h+u6SbtQmyOPsTdGXQmwXZhsiD5zhNDSVYusWNFw
WTzNxKHMvxU=
=2sqx
-----END PGP SIGNATURE-----

--=-aTG0+FBLZ4wAKesqS+5r--
