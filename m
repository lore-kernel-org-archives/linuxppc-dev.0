Return-Path: <michael@ellerman.id.au>
Subject: Re: Question about linux boot procedure (head_64.S)
From: Michael Ellerman <michael@ellerman.id.au>
To: Lee HongWoo <hongwoo7@gmail.com>
In-Reply-To: <5e2889710909010358v907022cs708dfc0dd3ed7fd0@mail.gmail.com>
References: <5e2889710909010358v907022cs708dfc0dd3ed7fd0@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Wrk4MiPuVONsXAg5tCat"
Date: Wed, 02 Sep 2009 10:47:09 +1000
Message-Id: <1251852430.5834.9.camel@concordia>
Mime-Version: 1.0
Cc: Linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Wrk4MiPuVONsXAg5tCat
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-09-01 at 19:58 +0900, Lee HongWoo wrote:
> Hi ~=20
>=20
> This is a boot flow of linux kernel under the arch/powerpc/kernel and
> I'm using pasemi cpu.=20
>=20
> __start  (in head_64.S)=20
>   ---> __start_initialization_multiplatform (in head_64.S)=20
>     ---> __boot_from_prom (in head_64.S)=20
>        ---> prom_init ( in prom_init.c)=20
>          ---> __start ???
>=20
> And I don't understand where __start is called, because I can find
> __start only in head_64.S.=20
> If it calls __start in head_64.S, it's a recursive call.=20
>=20
> Can anybody explain about this precedure ?=20

It calls __start() with different arguments. They are checked in
__start_initialization_multiplatform:

308         /*
309          * Are we booted from a PROM Of-type client-interface ?        =
    =20
310          */
311         cmpldi  cr0,r5,0
312         beq     1f
313         b       .__boot_from_prom               /* yes -> prom */


The first time through __start we are running under OF. The kernel can
detect this based on the arguments it is passed (r5 in particular).

prom_init() deals with talking to OF and flattening the OF device tree.
We then call back into __start but this time r5 is 0:

2555         __start(hdr, kbase, 0);                                       =
    =20

So the second time through we don't call into prom_init(), instead the
kernel continues using the flattened device tree.

The startup is structured this way so that the kernel can boot either
from OF (in which case we call prom_init()), or directly with a
flattened device tree.

cheers

--=-Wrk4MiPuVONsXAg5tCat
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqdwIkACgkQdSjSd0sB4dKn6ACgxhCvIljJuE2hhqq/hZR2dePZ
9kgAn3GIhF8hUV46BO9qagNXk4MKcxqe
=y4uL
-----END PGP SIGNATURE-----

--=-Wrk4MiPuVONsXAg5tCat--
