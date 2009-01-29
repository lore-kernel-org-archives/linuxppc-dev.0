Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A3E2F474C1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:29:34 +1100 (EST)
Date: Thu, 29 Jan 2009 22:29:30 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/8] powerpc/5200: Remove pr_debug() from hot paths in
	irq driver
Message-ID: <20090129212930.GE1406@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205534.31232.68165.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
In-Reply-To: <20090121205534.31232.68165.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2009 at 01:55:35PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> pr_debug() calls in the 'hot' *_mask(), *_unmask(), *_ack() and
> get_irq() makes adding #define DEBUG pretty much useless.  Remove
> these calls because they completely swamp the output.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Yup!

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

> ---
>=20
>  arch/powerpc/platforms/52xx/mpc52xx_pic.c |   23 -----------------------
>  1 files changed, 0 insertions(+), 23 deletions(-)
>=20
>=20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_pic.c
> index 0a093f0..c0a9559 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
> @@ -163,8 +163,6 @@ static void mpc52xx_extirq_mask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_clrbit(&intr->ctrl, 11 - l2irq);
>  }
> =20
> @@ -176,8 +174,6 @@ static void mpc52xx_extirq_unmask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_setbit(&intr->ctrl, 11 - l2irq);
>  }
> =20
> @@ -189,8 +185,6 @@ static void mpc52xx_extirq_ack(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_setbit(&intr->ctrl, 27-l2irq);
>  }
> =20
> @@ -255,8 +249,6 @@ static void mpc52xx_main_mask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_setbit(&intr->main_mask, 16 - l2irq);
>  }
> =20
> @@ -268,8 +260,6 @@ static void mpc52xx_main_unmask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_clrbit(&intr->main_mask, 16 - l2irq);
>  }
> =20
> @@ -291,8 +281,6 @@ static void mpc52xx_periph_mask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_setbit(&intr->per_mask, 31 - l2irq);
>  }
> =20
> @@ -304,8 +292,6 @@ static void mpc52xx_periph_unmask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_clrbit(&intr->per_mask, 31 - l2irq);
>  }
> =20
> @@ -327,8 +313,6 @@ static void mpc52xx_sdma_mask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_setbit(&sdma->IntMask, l2irq);
>  }
> =20
> @@ -340,8 +324,6 @@ static void mpc52xx_sdma_unmask(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	io_be_clrbit(&sdma->IntMask, l2irq);
>  }
> =20
> @@ -353,8 +335,6 @@ static void mpc52xx_sdma_ack(unsigned int virq)
>  	irq =3D irq_map[virq].hwirq;
>  	l2irq =3D irq & MPC52xx_IRQ_L2_MASK;
> =20
> -	pr_debug("%s: irq=3D%x. l2=3D%d\n", __func__, irq, l2irq);
> -
>  	out_be32(&sdma->IntPend, 1 << l2irq);
>  }
> =20
> @@ -613,8 +593,5 @@ unsigned int mpc52xx_get_irq(void)
>  		}
>  	}
> =20
> -	pr_debug("%s: irq=3D%x. virq=3D%d\n", __func__, irq,
> -		 irq_linear_revmap(mpc52xx_irqhost, irq));
> -
>  	return irq_linear_revmap(mpc52xx_irqhost, irq);
>  }
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmCH7oACgkQD27XaX1/VRsADACeP6yw+65GUsvb5w2iITqiUpwC
jsAAn2QTlb8Rt6Im6+4vRB67AtRPp3Fs
=Jk4g
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
