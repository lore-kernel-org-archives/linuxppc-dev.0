Return-Path: <mort@bork.org>
Received: from galileo.bork.org (galileo.bork.org [134.117.69.57])
	by ozlabs.org (Postfix) with ESMTP id 98227679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 11:51:19 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by galileo.bork.org (Postfix) with ESMTP id CDE8C412D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 19:51:19 -0500 (EST)
Received: from galileo.bork.org ([127.0.0.1])
	by localhost (galileo.bork.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32181-02 for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 19:51:19 -0500 (EST)
Date: Thu, 30 Mar 2006 19:51:19 -0500
From: Martin Hicks <mort@bork.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: U-boot CPU post failure on 405gp
Message-ID: <20060331005119.GM27792@bork.org>
References: <20060330211143.GK27792@bork.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="skzcsJvRJWOW8YcK"
In-Reply-To: <20060330211143.GK27792@bork.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--skzcsJvRJWOW8YcK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Thu, Mar 30, 2006 at 04:11:43PM -0500, Martin Hicks wrote:
>=20
> POST cpu link =3D 0
> ret =3D -1, link =3D 0, code =3D 03fa5ab8, lr =3D 0
>=20
> It looks clear to me that link =3D=3D 0, so the test worked fine.
>=20
> However, if I take away the "static" from the cpu_post_test_bc()
> declaration then everything works fine.
>=20
> I've posted "objdump -dS" output for post/cpu/b.o with and without
> cpu_post_test_bc() declared as static at:

It looks like the problem is the automatic inlining of the static
function.  If I declare cpu_post_test_bc as:

__attribute__((noinline))
static int cpu_post_test_bc (ulong cmd, ulong bo, ulong bi,
    int pjump, int dec, int link, ulong pctr, ulong cr)


Then the test completes.
mh

--=20
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

--skzcsJvRJWOW8YcK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFELH0H0ZUZrUx/K+4RAkl0AJ9/HrESFghvH0HLAWfW8JRBVxEh8ACfRiMz
Olwg1kpWeZ4O4jJy/PQJlYg=
=Frs6
-----END PGP SIGNATURE-----

--skzcsJvRJWOW8YcK--
