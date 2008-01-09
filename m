Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1570EDDF5A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 17:37:52 +1100 (EST)
Date: Wed, 9 Jan 2008 17:37:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V2] [POWERPC] Add common clock setting routine
	mpc52xx_psc_set_clkdiv()
Message-Id: <20080109173741.02a32a2a.sfr@canb.auug.org.au>
In-Reply-To: <20080109050950.14630.17832.stgit@trillian.secretlab.ca>
References: <20080109050950.14630.17832.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_17_37_41_+1100_6tUMVoH0+emEVJ=m"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Jan_2008_17_37_41_+1100_6tUMVoH0+emEVJ=m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

Just a couple of trivial things.

On Tue, 08 Jan 2008 22:09:50 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv)

> +	switch (psc_id) {
> +	  case 1: reg =3D &mpc52xx_cdm->mclken_div_psc1; mask =3D 0x20; break;
> +	  case 2: reg =3D &mpc52xx_cdm->mclken_div_psc2; mask =3D 0x40; break;
> +	  case 3: reg =3D &mpc52xx_cdm->mclken_div_psc3; mask =3D 0x80; break;
> +	  case 6: reg =3D &mpc52xx_cdm->mclken_div_psc6; mask =3D 0x10; break;
> +	  default:
> +		return -ENODEV;
> +	}

We line up case labels with the switch statement itself.

> +int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv)

> +	switch (psc_id) {
> +	  case 1: reg =3D &cdm->mclken_div_psc1; mask =3D 0x20; break;
> +	  case 2: reg =3D &cdm->mclken_div_psc2; mask =3D 0x40; break;
> +	  case 3: reg =3D &cdm->mclken_div_psc3; mask =3D 0x80; break;
> +	  case 6: reg =3D &cdm->mclken_div_psc6; mask =3D 0x10; break;
> +	  default:
> +	  	return -ENODEV;
> +	}

Here as well.

> +++ b/include/asm-powerpc/mpc52xx.h
> -extern void mpc5200_setup_xlb_arbiter(void);
> -extern void mpc52xx_declare_of_platform_devices(void);
> +extern void __init mpc5200_setup_xlb_arbiter(void);
> +extern void __init mpc52xx_declare_of_platform_devices(void);
> +extern void __init mpc52xx_map_common_devices(void);

We don't mark things __init in header files.  It is unnecessary and can
get out of sync - which causes unexpected results.

> +/* mpc52xx_pci.c */
>  #ifdef CONFIG_PCI
>  extern int __init mpc52xx_add_bridge(struct device_node *node);
>  extern void __init mpc52xx_setup_pci(void);

I see where yours above came from ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_17_37_41_+1100_6tUMVoH0+emEVJ=m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhGu5TgG2atn1QN8RAqg8AJ0V0BXjlbfzFz55uocmMrDdsUjtBACfQj3+
FSOHS0vpE2kf3rEdU2TtuiY=
=oUtK
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_17_37_41_+1100_6tUMVoH0+emEVJ=m--
