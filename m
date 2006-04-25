Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC 1/2] powerpc: add all the iSeries virtual devices to the
	device tree
From: Michael Ellerman <michael@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060425215405.648a16e7.sfr@canb.auug.org.au>
References: <20060425215405.648a16e7.sfr@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nj/mV32hqNmJ6Mj3rWHj"
Date: Tue, 25 Apr 2006 23:17:38 +1000
Message-Id: <1145971058.11392.4.camel@localhost.localdomain>
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


--=-nj/mV32hqNmJ6Mj3rWHj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-25 at 21:54 +1000, Stephen Rothwell wrote:
> We do this by putting them in the flattened device tree at setup time.
> This required the flattened device tree blob to be made bigger.

Fully sick! As the kids say .. I hear.

We should probably think about allocating the blob at run time, just by
sticking it at klimit. I think I decided that was a good idea, I just
never got around to coding it up.

> 676ab187518bfb5e48aa4c3cc418456e67a2ed70
> diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platfo=
rms/iseries/setup.c
> index 3c51448..9ce2afc 100644
> --- a/arch/powerpc/platforms/iseries/setup.c
> +++ b/arch/powerpc/platforms/iseries/setup.c
> @@ -45,6 +45,7 @@ #include <asm/paca.h>
>  #include <asm/cache.h>
>  #include <asm/sections.h>
>  #include <asm/abs_addr.h>
> +#include <asm/iseries/hv_types.h>
>  #include <asm/iseries/hv_lp_config.h>
>  #include <asm/iseries/hv_call_event.h>
>  #include <asm/iseries/hv_call_xm.h>
> @@ -710,7 +711,7 @@ define_machine(iseries) {
>  };
> =20
>  struct blob {
> -	unsigned char data[PAGE_SIZE];
> +	unsigned char data[PAGE_SIZE * 2];
>  	unsigned long next;
>  };
> =20
> @@ -911,6 +912,88 @@ void dt_model(struct iseries_flat_dt *dt
>  	dt_prop_str(dt, "compatible", "IBM,iSeries");
>  }
> =20
> +void dt_vdevices(struct iseries_flat_dt *dt)
> +{
> +	u32 reg =3D 0;
> +	HvLpIndexMap vlan_map;
> +	int i;
> +	char buf[32];
> +
> +	dt_start_node(dt, "vdevice");
> +	dt_prop_u32(dt, "#address-cells", 1);
> +	dt_prop_u32(dt, "#size-cells", 0);
> +
> +	snprintf(buf, sizeof(buf), "viocons@%08x", reg);
> +	dt_start_node(dt, buf);
> +	dt_prop_str(dt, "device_type", "serial");
> +	dt_prop_empty(dt, "compatible");
> +	dt_prop_u32(dt, "reg", reg);
> +	dt_end_node(dt);
> +	reg++;
> +
> +	snprintf(buf, sizeof(buf), "v-scsi@%08x", reg);
> +	dt_start_node(dt, buf);
> +	dt_prop_str(dt, "device_type", "vscsi");
> +	dt_prop_str(dt, "compatible", "IBM,v-scsi");
> +	dt_prop_u32(dt, "reg", reg);
> +	dt_end_node(dt);
> +	reg++;
> +
> +	vlan_map =3D HvLpConfig_getVirtualLanIndexMap();
> +	for (i =3D 0; i < HVMAXARCHITECTEDVIRTUALLANS; i++) {
> +		unsigned char mac_addr[6];

ETH_ALEN instead of 6 ?

> +
> +		if ((vlan_map & (0x8000 >> i)) =3D=3D 0)
> +			continue;
> +		snprintf(buf, 32, "vlan@%08x", reg + i);
> +		dt_start_node(dt, buf);
> +		dt_prop_str(dt, "device_type", "vlan");
> +		dt_prop_empty(dt, "compatible");
> +		dt_prop_u32(dt, "reg", reg + i);
> +
> +		mac_addr[0] =3D 0x02;
> +		mac_addr[1] =3D 0x01;
> +		mac_addr[2] =3D 0xff;
> +		mac_addr[3] =3D i;
> +		mac_addr[4] =3D 0xff;
> +		mac_addr[5] =3D HvLpConfig_getLpIndex_outline();
> +		dt_prop(dt, "local-mac-address", (char *)mac_addr, 6);
> +		dt_prop(dt, "mac-address", (char *)mac_addr, 6);

Ditto, ditto.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-nj/mV32hqNmJ6Mj3rWHj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBETiFydSjSd0sB4dIRAjXsAJ9FHZqdHGGSDwzYXxRy+O5yRqEq+QCeIHtr
L+CihW8QvglNYcqpqvr0AEo=
=c4WE
-----END PGP SIGNATURE-----

--=-nj/mV32hqNmJ6Mj3rWHj--
