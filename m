Return-Path: <michael@ellerman.id.au>
Subject: Re: Fix interrupt clearing in kdump shutdown sequence
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20060912121821.GB20606@in.ibm.com>
References: <20060912121821.GB20606@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Yy7pvyMxzapUZmPV+m+z"
Date: Thu, 14 Sep 2006 13:07:29 +1000
Message-Id: <1158203250.7305.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, paulus@samba.org, torvalds@osdl.org,
	fastboot@osdl.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Yy7pvyMxzapUZmPV+m+z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-12 at 17:48 +0530, Mohan Kumar M wrote:
> Hi,
>=20
> Some times HVC console on a PPC machine may have pending interrupts and
> in this case kdump shutdown sequence created problem by calling
> chip->end. This should be chip->eoi(). The attached patch fixes this
> issue. Tested on POWER5 box.

Nice catch.

Looks like chip->end() used to =3D=3D xics_end_irq(), but that vanished and
became xics_eio_(direct|lpar) and got hooked up to chip->eoi(). We
should check there are no other callers of chip->end() which really want
chip->eoi().

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Yy7pvyMxzapUZmPV+m+z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFCMdxdSjSd0sB4dIRAjnBAKCLWISCfR7vSw7Uwr94/6wv2RDfqwCdGg/e
EMHHhHe/K1jU1kh3EkXvvTY=
=tP8c
-----END PGP SIGNATURE-----

--=-Yy7pvyMxzapUZmPV+m+z--
