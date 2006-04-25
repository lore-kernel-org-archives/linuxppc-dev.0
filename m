Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC 2/2] powerpc: use the device tree for the iSeries vio bus
	probe
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060425215950.36c01f2b.sfr@canb.auug.org.au>
References: <20060425215405.648a16e7.sfr@canb.auug.org.au>
	<20060425215950.36c01f2b.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wm3ymuzX4WgULdtbeIqO"
Date: Tue, 25 Apr 2006 23:22:46 +1000
Message-Id: <1145971366.11392.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-wm3ymuzX4WgULdtbeIqO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-25 at 21:59 +1000, Stephen Rothwell wrote:
> As an added bonus, since every vio_dev now has a device_node
> associated with it, hotplug now works.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

> diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platfo=
rms/iseries/setup.c
> index 9ce2afc..af5609a 100644
> --- a/arch/powerpc/platforms/iseries/setup.c
> +++ b/arch/powerpc/platforms/iseries/setup.c
> @@ -54,6 +54,7 @@ #include <asm/iseries/mf.h>
>  #include <asm/iseries/it_exp_vpd_panel.h>
>  #include <asm/iseries/hv_lp_event.h>
>  #include <asm/iseries/lpar_map.h>
> +#include <asm/iseries/vio.h>
>  #include <asm/udbg.h>
>  #include <asm/irq.h>
> =20
> @@ -939,6 +940,7 @@ void dt_vdevices(struct iseries_flat_dt=20
>  	dt_end_node(dt);
>  	reg++;
> =20
> +	vio_first_vlan_unit =3D reg;
>  	vlan_map =3D HvLpConfig_getVirtualLanIndexMap();
>  	for (i =3D 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
>  		unsigned char mac_addr[6];
> @@ -964,6 +966,7 @@ void dt_vdevices(struct iseries_flat_dt=20
>  	}
>  	reg +=3D HVMAXARCHITECTEDVIRTUALLANS;
> =20
> +	vio_first_viodasd_unit =3D reg;
>  	for (i =3D 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++) {
>  		snprintf(buf, 32, "viodasd@%08x", reg + i);
>  		dt_start_node(dt, buf);
> @@ -973,6 +976,7 @@ void dt_vdevices(struct iseries_flat_dt=20
>  		dt_end_node(dt);
>  	}
>  	reg +=3D HVMAXARCHITECTEDVIRTUALDISKS;
> +	vio_first_viocd_unit =3D reg;
>  	for (i =3D 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++) {
>  		snprintf(buf, 32, "viocd@%08x", reg + i);
>  		dt_start_node(dt, buf);
> @@ -982,6 +986,7 @@ void dt_vdevices(struct iseries_flat_dt=20
>  		dt_end_node(dt);
>  	}
>  	reg +=3D HVMAXARCHITECTEDVIRTUALCDROMS;
> +	vio_first_viotape_unit =3D reg;
>  	for (i =3D 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++) {
>  		snprintf(buf, 32, "viotape@%08x", reg + i);
>  		dt_start_node(dt, buf);
> diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platform=
s/iseries/vio.c
> index 22045a2..5cd197b 100644
> --- a/arch/powerpc/platforms/iseries/vio.c
> +++ b/arch/powerpc/platforms/iseries/vio.c
> @@ -24,6 +24,15 @@ #include <asm/iseries/hv_call_xm.h>
> =20
>  #include "iommu.h"
> =20
> +int vio_first_vlan_unit;
> +EXPORT_SYMBOL(vio_first_vlan_unit);
> +int vio_first_viodasd_unit;
> +EXPORT_SYMBOL(vio_first_viodasd_unit);
> +int vio_first_viocd_unit;
> +EXPORT_SYMBOL(vio_first_viocd_unit);
> +int vio_first_viotape_unit;
> +EXPORT_SYMBOL(vio_first_viotape_unit);

Why do we need these guys? If we have to have them then I'd rather they
were in the device tree, rather than have the "bootloader" passing info
to the kernel via globals.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-wm3ymuzX4WgULdtbeIqO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBETiKmdSjSd0sB4dIRAt8LAJ9XxOF9Ch3NlvixzRDlgtxWE/XUCwCfQNYG
acfTp0gfcVdSjayLMv6/lRg=
=qUq1
-----END PGP SIGNATURE-----

--=-wm3ymuzX4WgULdtbeIqO--
