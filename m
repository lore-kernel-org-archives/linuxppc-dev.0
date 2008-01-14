Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 15 Jan 2008 10:33:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 4/4] powerpc: Katana750i - Add platform support
Message-Id: <20080115103346.30cc3d54.sfr@canb.auug.org.au>
In-Reply-To: <20080114230057.GC22862@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080114230057.GC22862@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Jan_2008_10_33_46_+1100_2FDgnJABobofECPd"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Jan_2008_10_33_46_+1100_2FDgnJABobofECPd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 14 Jan 2008 16:00:57 -0700 "Mark A. Greer" <mgreer@mvista.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/embedded6xx/katana750i.c
> @@ -0,0 +1,314 @@
> +/*
> + * Board setup routines for the Emerson Katana-750i/752i
> + *
> + * Author: Mark A. Greer <mgreer@mvista.com>
> + *
> + * Based on code prpmc2800.c by Dale Farnsworth <dale@farnsworth.org>
> + * and original katana port by Tim Montgomery <timm@artesyncp.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.

A Copyright notice would be nice.

> +static void __init katana750i_setup_arch(void)
> +{
> +	struct device_node *np;
> +	phys_addr_t paddr;
> +	const unsigned int *reg;
> +
> +	/*
> +	 * ioremap mpp and gpp registers in case they are later
> +	 * needed by katana750i_reset_board().
> +	 */
> +	np =3D of_find_compatible_node(NULL, NULL, "marvell,mv64360-mpp");
> +	reg =3D of_get_property(np, "reg", NULL);

What happens if np =3D=3D NULL?

> +	paddr =3D of_translate_address(np, reg);
> +	of_node_put(np);
> +	mv64x60_mpp_reg_base =3D ioremap(paddr, reg[1]);
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "marvell,mv64360-gpp");
> +	reg =3D of_get_property(np, "reg", NULL);

Ditto.

> +	paddr =3D of_translate_address(np, reg);
> +	of_node_put(np);
> +	mv64x60_gpp_reg_base =3D ioremap(paddr, reg[1]);
> +
> +#ifdef CONFIG_PCI
> +	mv64x60_pci_init();
> +#endif

Maybe there should be a stub of mv64x60_pci_init for the non PCI case -
that would save the ifdefs in C code.

> +	np =3D of_find_compatible_node(NULL, NULL, "katana750i,cpld");
> +	reg =3D of_get_property(np, "reg", NULL);

What if np =3D=3D NULL?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Jan_2008_10_33_46_+1100_2FDgnJABobofECPd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHi/FeTgG2atn1QN8RAkUyAJ9YoLP8POoeZxWgfDFz1xYr7DccPACgmXjB
Np/5yDfwZ3bGCTMYOj8kKMs=
=xSAz
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Jan_2008_10_33_46_+1100_2FDgnJABobofECPd--
