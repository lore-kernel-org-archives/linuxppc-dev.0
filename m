Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3A713DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 10:36:54 +1100 (EST)
Date: Tue, 12 Feb 2008 10:36:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 1/2] powerpc: publish 85xx soc dts entries as of_device
Message-Id: <20080212103649.40e00af8.sfr@canb.auug.org.au>
In-Reply-To: <20080211203243.GA5331@blade.az.mvista.com>
References: <20080211203243.GA5331@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Feb_2008_10_36_49_+1100_fQ/l.8RYY0ZyGIEv"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Feb_2008_10_36_49_+1100_fQ/l.8RYY0ZyGIEv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Mon, 11 Feb 2008 13:32:43 -0700 Dave Jiang <djiang@mvista.com> wrote:
>
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -26,6 +26,8 @@
>  #include <asm/mpic.h>
>  #include <mm/mmu_decl.h>
>  #include <asm/udbg.h>
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>

Like Jon said ...

> +static struct of_device_id mpc85xx_ids[] =3D {

make this __initdata

> +static int __init mpc85xx_publish_devices(void)
> +{
> +	if (!machine_is(mpc85xx_ads))
> +		return 0;

You don't need this if you make the change below.

> +	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(mpc85xx_publish_devices);

machine_devce_initcall(mpc85xx_ads, mpc85xx_publish_devices);

> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c

> +static struct of_device_id mpc85xx_ids[] =3D {

__initdata

> +static int __init mpc85xx_publish_devices(void)
> +{
> +	if (!machine_is(mpc85xx_cds))
> +		return 0;
> +
> +	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(mpc85xx_publish_devices);

Same as above.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Feb_2008_10_36_49_+1100_fQ/l.8RYY0ZyGIEv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsNwWTgG2atn1QN8RAtLYAJ4tjFrrzFZGhTJn4f3whqhn6xXT+wCfcNPI
LsEor/h/gBy3VvgRuwB+EI0=
=5VqT
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Feb_2008_10_36_49_+1100_fQ/l.8RYY0ZyGIEv--
