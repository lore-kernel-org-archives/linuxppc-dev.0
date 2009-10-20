Return-Path: <michael@ellerman.id.au>
Subject: Re: Device Tree Corrupted after unflatten_device_tree()
From: Michael Ellerman <michael@ellerman.id.au>
To: Lixin Yao <Lixin.Yao@HSTX.com>
In-Reply-To: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB88@exchtxus2.HSTX.global.vpn>
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB88@exchtxus2.HSTX.global.vpn>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-dumKdEEY44XJWTXSlJyE"
Date: Wed, 21 Oct 2009 10:01:31 +1100
Message-Id: <1256079691.8902.3.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-dumKdEEY44XJWTXSlJyE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-10-20 at 09:10 -0700, Lixin Yao wrote:
> I use a board with MPC866T and 2.6.28 Linux Kernel.  Occasionally, the
> unflattened device is corrupted after =E2=80=9Cunflatten_device_tree()=E2=
=80=9D which
> causes crash of kernel when device tree is traversed later on.
>=20
> I looked at the fixes in lib/lmb.c, arch/powerpc/mm,
> arch/powerpc/kernel etc since 2.6.28 to 2.6.32-r4 (the most recent
> version) and could not fix my problem.
>=20
> I have had a hard time trying to determine the cause.=20
>=20
> arch/powerpc/kernel/setup_32.c
>=20
> void __init setup_arch(char **cmdline_p)
>=20
> {
>=20
>         *cmdline_p =3D cmd_line;
>=20
>         /* so udelay does something sensible, assume <=3D 1000 bogomips
> */
>=20
>         loops_per_jiffy =3D 500000000 / HZ;
>=20
>         unflatten_device_tree();
>=20
>         /* UNFLATTENED DEVICE TREE IS CORRUPTED SOMETIMES HERE */

_In what way_ is it corrupted? Bad tree structure? Bogus node/property
values, names etc.

cheers

--=-dumKdEEY44XJWTXSlJyE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkreQUcACgkQdSjSd0sB4dJH+QCgnzxcjWcflwb9+S5mOTzZTNGj
rpoAn3tjc2dQpt1yVUycbkhe6gSJKgzM
=pfuk
-----END PGP SIGNATURE-----

--=-dumKdEEY44XJWTXSlJyE--
