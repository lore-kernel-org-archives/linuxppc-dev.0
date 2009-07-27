Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 004C4B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 18:45:51 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3257DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 18:45:50 +1000 (EST)
Subject: Re: "test" branch update
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1248668057.5706.2.camel@pasglop>
References: <1248668057.5706.2.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-q4XGK9PCucdvaFATg29h"
Date: Mon, 27 Jul 2009 18:45:50 +1000
Message-Id: <1248684350.4691.19.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-q4XGK9PCucdvaFATg29h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-07-27 at 14:14 +1000, Benjamin Herrenschmidt wrote:
> Hi !
>=20
> I've started collecting things for my -next branch. For now I put
> everything in -test, I'll move it over to -next in the upcoming couple
> of days if there's no major issue found.

I'm seeing this on Power 6 (Didgo3), haven't had a chance to look any
closer, 100% reproducible, using SLUB.

HugeTLB registered 16 MB page size, pre-allocated 0 pages
HugeTLB registered 16 GB page size, pre-allocated 0 pages
HugeTLB registered 64 KB page size, pre-allocated 0 pages
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc00000000003ea98
cpu 0x0: Vector: 300 (Data Access) at [c0000000fe6e3840]
    pc: c00000000003ea98: .strcmp+0x10/0x24
    lr: c0000000001c8e60: .sysfs_find_dirent+0x3c/0x78
    sp: c0000000fe6e3ac0
   msr: 8000000000009032
   dar: 0
 dsisr: 40000000
  current =3D 0xc0000000fe6d8000
  paca    =3D 0xc000000000ab3200
    pid   =3D 1, comm =3D swapper
enter ? for help
[link register   ] c0000000001c8e60 .sysfs_find_dirent+0x3c/0x78
[c0000000fe6e3ac0] c0000000001c939c .sysfs_addrm_start+0x70/0xec
(unreliable)
[c0000000fe6e3b50] c0000000001c6f50 .sysfs_hash_and_remove+0x58/0xb0
[c0000000fe6e3c10] c0000000001ca8a4 .sysfs_remove_link+0x4c/0x6c
[c0000000fe6e3cb0] c00000000014612c .sysfs_slab_alias+0x64/0x154
[c0000000fe6e3d60] c00000000090e22c .slab_sysfs_init+0xd4/0x130
[c0000000fe6e3e00] c000000000009848 .do_one_initcall+0x90/0x1b8
[c0000000fe6e3ef0] c0000000008ef4c0 .kernel_init+0x1f8/0x278
[c0000000fe6e3f90] c00000000002f570 .kernel_thread+0x54/0x70
0:mon> r
R00 =3D c0000000001c6f50   R16 =3D 0000000000000000
R01 =3D c0000000fe6e3ac0   R17 =3D 0000000004d2dbb8
R02 =3D c000000000a72248   R18 =3D c00000000092da50
R03 =3D 0000000000000073   R19 =3D 0000000000000000
R04 =3D ffffffffffffffff   R20 =3D 0000000002f1fed0
R05 =3D c0000000feb70460   R21 =3D 0000000004d2da78
R06 =3D c0000000fec19640   R22 =3D 0000000004400000
R07 =3D 0000000000000001   R23 =3D c00000000092da48
R08 =3D ffffffffffffffff   R24 =3D c00000000092da58
R09 =3D c000000000bd6080   R25 =3D 00000000010ad378
R10 =3D 0000000000000816   R26 =3D c000000000aa7ac0
R11 =3D 0000000000000012   R27 =3D 0000000000000000
R12 =3D 0000000024000084   R28 =3D 0000000000000000
R13 =3D c000000000ab3200   R29 =3D c0000000fec19690
R14 =3D 0000000000000000   R30 =3D c0000000009ddd98
R15 =3D 0000000000000000   R31 =3D c0000000fe6e3ac0
pc  =3D c00000000003ea98 .strcmp+0x10/0x24
lr  =3D c0000000001c8e60 .sysfs_find_dirent+0x3c/0x78
msr =3D 8000000000009032   cr  =3D 24000048
ctr =3D 0000000000000000   xer =3D 000000002000000b   trap =3D  300
dar =3D 0000000000000000   dsisr =3D 40000000
0:mon>


--=-q4XGK9PCucdvaFATg29h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkptaT0ACgkQdSjSd0sB4dL0ZwCfWMBgaA0Ah5NLlpxsaaxZM2fA
ZBEAoJfcBATjdsdTFNAXhIMqt+mVQGFF
=IWuB
-----END PGP SIGNATURE-----

--=-q4XGK9PCucdvaFATg29h--
