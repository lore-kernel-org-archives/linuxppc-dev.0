Return-Path: <michael@ellerman.id.au>
Subject: Re: LMB regression...
From: Michael Ellerman <michael@ellerman.id.au>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080423.232419.193712136.davem@davemloft.net>
References: <20080423.232419.193712136.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-H0HU0D/UVcp2i6cGTbUH"
Date: Thu, 24 Apr 2008 16:35:33 +1000
Message-Id: <1209018933.22532.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-H0HU0D/UVcp2i6cGTbUH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-04-23 at 23:24 -0700, David Miller wrote:
> Paul, I finally got around to testing your changeset on sparc64, it
> breaks things:
>=20
> commit d9024df02ffe74d723d97d552f86de3b34beb8cc
> Author: Paul Mackerras <paulus@samba.org>
> Date:   Sat Apr 12 15:20:59 2008 +1000
>=20
>     [LMB] Restructure allocation loops to avoid unsigned underflow
>  ...   =20
>=20
> Specifically, you removed the aligning of the size argument given to
> lmb_add_region() in the lmb allocators, and that is critical when
> allocating many small chunks, we run out of LMB slots otherwise
> and allocations start failing.
>=20
> I added the alignment there as a bug fix earlier:
>=20
> commit eea89e13a9c61d3928223d2f9bf2295e22e0efb6
> Author: David S. Miller <davem@davemloft.net>
> Date:   Wed Feb 13 16:57:09 2008 -0800
>=20
>     [LMB]: Fix bug in __lmb_alloc_base().
>    =20
>     We need to check lmb_add_region() for errors, it can run out
>     of regions etc.
>    =20
>     Also, the size needs to be padded to the given alignment
>     or else the lmb.reserved regions don't get expanded and
>     instead we get tons of holes and eventually run out of
>     regions prematurely.
>    =20
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> Please be more careful in the future :-(
>=20
> I find it quite ironic that you spent so much time and effort fixing
> an absolutely totally theoretical bug that nobody was triggering, and
> in the process reintroduced a real one that triggers immediately on
> real systems, and that had even been explicitly fixed previously.

Sounds like we need a test suite :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-H0HU0D/UVcp2i6cGTbUH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIECo1dSjSd0sB4dIRAr4DAKClS3pi7RW15+8XOEAyA/wncN6H7ACfZ2L7
NF7guM3FFMRD4DNScLgU1WU=
=WQGh
-----END PGP SIGNATURE-----

--=-H0HU0D/UVcp2i6cGTbUH--
