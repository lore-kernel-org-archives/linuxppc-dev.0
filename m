Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: change topology_init() to a subsys_initcall
From: Michael Ellerman <michael@ellerman.id.au>
To: Kevin Corry <kevcorry@us.ibm.com>
In-Reply-To: <200705021211.49331.kevcorry@us.ibm.com>
References: <200705021208.59068.kevcorry@us.ibm.com>
	<200705021211.49331.kevcorry@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ngDdP6kHko+NmyBGljhp"
Date: Thu, 03 May 2007 11:11:47 +1000
Message-Id: <1178154707.5338.11.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Carl Love <carll@us.ibm.com>,
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@hpl.hp.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ngDdP6kHko+NmyBGljhp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 12:11 -0500, Kevin Corry wrote:
> Change the powerpc version of topology_init() from an __initcall to
> a subsys_initcall to match all other architectures.
>=20
> Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>
>=20
> Index: linux-2.6.21/arch/powerpc/kernel/sysfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21.orig/arch/powerpc/kernel/sysfs.c
> +++ linux-2.6.21/arch/powerpc/kernel/sysfs.c
> @@ -498,4 +498,4 @@ static int __init topology_init(void)
> =20
>  	return 0;
>  }
> -__initcall(topology_init);
> +subsys_initcall(topology_init);     =20

topology_init() depends on the register_one_node() stuff being
available, which relies on register_node_type() being called AFAICT -
which is a postcore_initcall(). So that's OK.

It also creates sysfs files, which is OK because long before initcalls
run vfs_caches_init() called mnt_init() which called sysfs_init().

Just to be super safe it'd be good to diff your sysfs before and after
the change. But assuming that show's nothing this looks fine to me.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ngDdP6kHko+NmyBGljhp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOTbTdSjSd0sB4dIRAg3eAJ9SzedIToDo6fj3fE9jM0jZivdcLQCfZTNW
qeGUuy+Tn8RAGYLafOGTnvo=
=PqzK
-----END PGP SIGNATURE-----

--=-ngDdP6kHko+NmyBGljhp--
