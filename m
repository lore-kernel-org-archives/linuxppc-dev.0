Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] cell: abstract spu management routines
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <455161D2.3090004@am.sony.com>
References: <455161D2.3090004@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-H35ewB5ONj5PHP1guFAF"
Date: Wed, 08 Nov 2006 16:01:14 +1100
Message-Id: <1162962074.20271.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-H35ewB5ONj5PHP1guFAF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-07 at 20:49 -0800, Geoff Levand wrote:
> This adds a platform specific spu management abstraction and the correspo=
nding
> routines to support the IBM Cell Blade.  It also removes the hypervisor o=
nly
> resources that were included in struct spu.
>=20
> Three new platform specific routines are introduced, spu_enumerate_spus()=
,
> spu_create_spu() and spu_destroy_spu().  The underlining design uses a ne=
w
> type, struct spu_management_ops, to hold function pointers that the platf=
orm
> setup code is expected to initialize to instances appropriate to that pla=
tform.
>=20
> For the IBM Cell Blade support, I put the hypervisor only resources that =
were
> in struct spu into a platform specific data structure struct platform_dat=
a.
>=20
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
> ---
..
> Index: cell--common--6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- cell--common--6.orig/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> +++ cell--common--6/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> @@ -18,120 +18,467 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
  USA
>   */
> =20
> +#undef DEBUG
> +
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/ptrace.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> =20
> -#include <asm/io.h>
>  #include <asm/spu.h>
>  #include <asm/spu_priv1.h>
> +#include <asm/firmware.h>
> +#include <asm/prom.h>
> =20
>  #include "interrupt.h"
> =20
> +struct platform_data {
> +	int nid;
> +	struct device_node *devnode;
> +	struct spu_priv1 __iomem *priv1;
> +};
> +
> +static struct platform_data *platform_data(struct spu *spu)
> +{
> +	BUG_ON(!spu->platform_data);
> +	return (struct platform_data*)spu->platform_data;
> +}

I don't see the point of this, why not just grab platform data directly?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-H35ewB5ONj5PHP1guFAF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUWSadSjSd0sB4dIRArnkAJ91fisnoZ6JBxrWh8NXJAcFnkaYEACgkriL
i4p7XR4pfMU9CU45o6EQeuE=
=1sC4
-----END PGP SIGNATURE-----

--=-H35ewB5ONj5PHP1guFAF--
