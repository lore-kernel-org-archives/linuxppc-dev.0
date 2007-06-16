Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] numa: enforce iommu-off memory address limit
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <111819287886b8b45671.846930886.miltonm@bga.com>
References: <111819287886b8b45671.846930886.miltonm@bga.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-04Y9lLGu9b1c4ONiP8xJ"
Date: Sat, 16 Jun 2007 14:34:13 +1000
Message-Id: <1181968453.21287.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-04Y9lLGu9b1c4ONiP8xJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-15 at 12:33 -0500, Milton Miller wrote:
> Don't short circuit the lmb_end_of_DRAM if iommu_is_off.
>=20
> If linux,iommu-off is in /chosen (because iommu=3Doff was on the command
> line), we limit the memory when adding it to the lmbs and page tables,
> but not when numa parses the device tree for numa affinity.  When we
> free bootmem, we then try to use these pages without mapping them or
> allocating supporting data structures resulting in bad_page and/or data
> storage interrupts.
>=20
> Signed-off-by: Milton Miller <miltonm@bga.com>
> ---=20
> Paul, I think this can wait for 2.6.23 although its small enough
> if you want to send it for 2.6.22.
>=20
> Index: kernel/arch/powerpc/mm/numa.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kernel.orig/arch/powerpc/mm/numa.c	2007-06-15 01:10:19.000000000 -050=
0
> +++ kernel/arch/powerpc/mm/numa.c	2007-06-15 01:41:32.000000000 -0500
> @@ -21,6 +21,7 @@
>  #include <asm/lmb.h>
>  #include <asm/system.h>
>  #include <asm/smp.h>
> +#include <asm/iommu.h>
> =20
>  static int numa_enabled =3D 1;
> =20
> @@ -286,7 +287,7 @@ static unsigned long __init numa_enforce
>  	 * having memory holes below the limit.
>  	 */
> =20
> -	if (! memory_limit)
> +	if (!memory_limit && !iommu_is_off)
>  		return size;

I'd rather just remove the check entirely, and rename the routine -
numa_check_end_of_ram() or something.

cheers


--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-04Y9lLGu9b1c4ONiP8xJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGc2hFdSjSd0sB4dIRAkhoAKCxx5xvJX4YIGySoqy4ZFzTU/kIDgCghtZX
5BUc5lwSPr9LYDofjsLtQlE=
=vcNa
-----END PGP SIGNATURE-----

--=-04Y9lLGu9b1c4ONiP8xJ--
