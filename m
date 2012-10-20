Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8DF442C0092
 for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2012 17:54:51 +1100 (EST)
Date: Sat, 20 Oct 2012 08:54:42 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc: 52xx: nop out unsupported critical IRQs
Message-ID: <20121020065442.GA4208@pengutronix.de>
References: <1349902593-16431-1-git-send-email-w.sang@pengutronix.de>
 <1349947155-11540-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1349947155-11540-1-git-send-email-w.sang@pengutronix.de>
Cc: John Bonesio <bones@secretlab.ca>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2012 at 11:19:15AM +0200, Wolfram Sang wrote:
> Currently, when booting MPC52xx based platforms, we get:
>=20
>         mpc52xx_irqhost_map: invalid irq: virq=3D16, l1=3D0, l2=3D3
>         irq: irq-16=3D=3D>hwirq-0x3 mapping failed: -22
>         [WARNing skipped]
>=20
> The warning is wrong since the mapping itself is valid. However, there is=
 no
> support for that type of IRQ currently. Print a proper warning and bind t=
he irq
> to a no_irq chip.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: John Bonesio <bones@secretlab.ca>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Ping. I'd really like to get rid of the WARNing for all MPC52xx boards.
It looks pretty scary to people who don't know the issues behind it.

> ---
>=20
> Change since V1: drop the default state since all possibilities for l1 ar=
e now
> 		 covered in the switch-statement.
>=20
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_pic.c
> index 8520b58..b89ef65 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> @@ -372,10 +372,11 @@ static int mpc52xx_irqhost_map(struct irq_domain *h=
, unsigned int virq,
>  	case MPC52xx_IRQ_L1_MAIN: irqchip =3D &mpc52xx_main_irqchip; break;
>  	case MPC52xx_IRQ_L1_PERP: irqchip =3D &mpc52xx_periph_irqchip; break;
>  	case MPC52xx_IRQ_L1_SDMA: irqchip =3D &mpc52xx_sdma_irqchip; break;
> -	default:
> -		pr_err("%s: invalid irq: virq=3D%i, l1=3D%i, l2=3D%i\n",
> -		       __func__, virq, l1irq, l2irq);
> -		return -EINVAL;
> +	case MPC52xx_IRQ_L1_CRIT:
> +		pr_warn("%s: Critical IRQ #%d is unsupported! Nopping it.\n",
> +			__func__, l2irq);
> +		irq_set_chip(virq, &no_irq_chip);
> +		return 0;
>  	}
> =20
>  	irq_set_chip_and_handler(virq, irqchip, handle_level_irq);
> --=20
> 1.7.10.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCCSrIACgkQD27XaX1/VRsmEwCfRhMHwx3FPgzXRcMHMV8lYj3J
Ko4An0sobDNF50WdsEo7kISRmqxBLKD7
=uBhd
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
