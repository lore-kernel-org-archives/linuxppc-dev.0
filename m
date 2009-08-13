Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9D07EB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 12:23:15 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 873A4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 12:23:15 +1000 (EST)
Subject: Re: [PATCH] Add kmemleak annotations to lmb.c
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <3437d193a392e9d365f18b3d90c52de95a590086.1249880734.git.michael@ellerman.id.au>
References: <3437d193a392e9d365f18b3d90c52de95a590086.1249880734.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-pXuUu6MGIFKYd4VtMCJv"
Date: Thu, 13 Aug 2009 12:23:13 +1000
Message-Id: <1250130193.4850.15.camel@concordia>
Mime-Version: 1.0
Cc: catalin.marinas@arm.com, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-pXuUu6MGIFKYd4VtMCJv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-08-10 at 15:05 +1000, Michael Ellerman wrote:
> We don't actually want kmemleak to track the lmb allocations, so we
> pass min_count as 0. However telling kmemleak about lmb allocations
> allows it to scan that memory for pointers to other memory that is
> tracked by kmemleak, ie. slab allocations etc.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  lib/lmb.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>=20
> diff --git a/lib/lmb.c b/lib/lmb.c
> index e4a6482..dc10bc5 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -352,8 +352,10 @@ u64 __init lmb_alloc_nid(u64 size, u64 align, int ni=
d,
>  		u64 ret =3D lmb_alloc_nid_region(&mem->region[i],
>  					       nid_range,
>  					       size, align, nid);
> -		if (ret !=3D ~(u64)0)
> +		if (ret !=3D ~(u64)0) {
> +			kmemleak_alloc(__va(ret), size, 0, 0);
>  			return ret;
> +		}
>  	}
> =20
>  	return lmb_alloc(size, align);
> @@ -412,6 +414,8 @@ u64 __init __lmb_alloc_base(u64 size, u64 align, u64 =
max_addr)
>  				/* this area isn't reserved, take it */
>  				if (lmb_add_region(&lmb.reserved, base, size) < 0)
>  					return 0;
> +
> +				kmemleak_alloc(__va(base), size, 0, 0);
>  				return base;
>  			}
>  			res_base =3D lmb.reserved.region[j].base;

This needs an include of kmemleak.h for some configs, new patch coming.

cheers

--=-pXuUu6MGIFKYd4VtMCJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqDeQ0ACgkQdSjSd0sB4dI70ACfeaf+g/Ob47EZ1Ic5STTkndNh
qWAAmwSyreyzdgxO2N4GjGn0/+BSF/kV
=cXJL
-----END PGP SIGNATURE-----

--=-pXuUu6MGIFKYd4VtMCJv--
