Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id 850F8DDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 31 May 2009 20:11:43 +1000 (EST)
Date: Sun, 31 May 2009 12:11:32 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFC4733C3C.0E94C44D-ONC12575C5.00215A32-C12575C5.0023DB18@transmode.se>
	(from joakim.tjernlund@transmode.se on Fri May 29 08:31:39 2009)
Message-Id: <1243764699.3217.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-J8SjPd1wfzCg8bnI4Gi3"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-J8SjPd1wfzCg8bnI4Gi3
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jocke:

Am 29.05.09 08:31 schrieb(en) Joakim Tjernlund:
> > No (and I wasn't aware of the PPC pre-inc vs. post-inc stuff) - I =20
> just
>=20
> I think this is true for most RISC based CPU's. It is a pity as
> post ops are a lot more common. The do {} while(--chunks) is also
> better. Basically the "while(--chunks)" is free(but only if you don't =20
> use
> chunks inside the loop).

Just a side note:  I looked at the assembly output of gcc 4.3.3 coming =20
with Ubuntu Jaunty/PowerPC for

<snip case=3D"1">
   n >>=3D 2;
   do {
     *++dst =3D *++src;
   } while (--n);
<snip>

and

<snip case=3D"2">
   n >>=3D 2;
   while (n--)
     *dst++ =3D *src++;
</snip>

Using the gcc options "-O2 -mcpu=3D603e -mtune=3D603e" (same effect with =20
"-O3" instead of "-O2") the loop core is *exactly* the same in both =20
cases.

With gcc 4.2.2 (coming with ELDK 4.2) the loop core in case 2 is indeed =20
one statement longer, though...

Best, Albrecht.

--=-J8SjPd1wfzCg8bnI4Gi3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKIlfbn/9unNAn/9ERArErAJ9kdCg3OlJmF1mEJL3Q1jRD+t/YiQCglOo3
nz7W/0lslwytzhtHZNuGTvk=
=7qA3
-----END PGP SIGNATURE-----

--=-J8SjPd1wfzCg8bnI4Gi3--
