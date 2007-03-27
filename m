Return-Path: <michael@ellerman.id.au>
Subject: RE: [PATCH 4/4] Add irq debugfs and virq_mapping for getting
	thevirq to irq host's hwirq mapping list.
From: Michael Ellerman <michael@ellerman.id.au>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C132437@zch01exm26.fsl.freescale.net>
References: <11740199151814-git-send-email-wei.zhang@freescale.com>
	<11740199152595-git-send-email-wei.zhang@freescale.com>
	<11740199154116-git-send-email-wei.zhang@freescale.com>
	<11740199152381-git-send-email-wei.zhang@freescale.com>
	<1174359820.10827.8.camel@concordia.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C132437@zch01exm26.fsl.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZT9Yrih4tfBl37D/41GT"
Date: Tue, 27 Mar 2007 13:21:05 +1000
Message-Id: <1174965665.5348.17.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Wang Haiying-r54964 <Haiying.Wang@freescale.com>, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ZT9Yrih4tfBl37D/41GT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-20 at 17:51 +0800, Zhang Wei-r63237 wrote:
> >=20
> > Minor nit. Should we be creating a 'powerpc' directory first, and
> > putting the 'irq' file under that? Otherwise we risk clashing=20
> > with some
> > generic code that creates a file called 'irq' in debugfs.
> >=20
> > cheers
> >=20
> Hi, Michael,
>=20
> I've seen some codes in arch/powerpc/kernel/prom.c to create debugfs
> dir "powerpc". But those codes were enabled by a local macro 'DEBUG'.
> There is a little problem. Maybe I should change '#ifdef DEBUG' to
> '#ifdef CONFIG_DEBUG_FS' before the export_flat_device_tree() function
> in arch/powerpc/kernel/prom.c. How about it?

No, we don't want to always export the flat device tree.

Instead I think you should add a function in
arch/powerpc/kernel/setup-common.c which creates the powerpc directory
if CONFIG_DEBUG_FS is enabled, make it an arch_initcall. Then the flat
device tree code can use that directory, and so can your irq stuff.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ZT9Yrih4tfBl37D/41GT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGCI2hdSjSd0sB4dIRAmjmAJ9vPOfQo0cv5X7URl2VgzDJJrEeugCgw3WD
AWFBMJz65h19U+JCEfYVQao=
=T5cn
-----END PGP SIGNATURE-----

--=-ZT9Yrih4tfBl37D/41GT--
