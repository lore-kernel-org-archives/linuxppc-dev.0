Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AF1B5DDED9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 17:48:37 +1000 (EST)
Date: Wed, 6 Aug 2008 17:48:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 4/6] powerpc: add USB peripheral support to MPC8272ADS
Message-Id: <20080806174822.a23a9231.sfr@canb.auug.org.au>
In-Reply-To: <1218006285-27138-4-git-send-email-leoli@freescale.com>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Aug_2008_17_48_23_+1000_fHQWKx1j0Dp=6RUU"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Aug_2008_17_48_23_+1000_fHQWKx1j0Dp=6RUU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Li,

On Wed,  6 Aug 2008 15:04:43 +0800 Li Yang <leoli@freescale.com> wrote:
>
> @@ -150,6 +169,12 @@ static void __init mpc8272_ads_setup_arch(void)
>  	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
>  	setbits32(&bcsr[3], BCSR3_FETH2_RST);
> =20
> +	/* Enabling USB support in BCSR */
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe_udc");
> +	if (np !=3D NULL) {

		of_node_put(np);

> +		clrbits32(&bcsr[3], BCSR3_USB_EN);
> +		clrbits32(&bcsr[3], BCSR3_USB_HI_SPEED);
> +	}
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_17_48_23_+1000_fHQWKx1j0Dp=6RUU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZV0cACgkQjjKRsyhoI8zgKQCfUdpGwPX1xBGa57dh1DPEdVs7
HtEAnjZeITxmHy4H2gqhIZmjolmgNJsX
=Sp/a
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_17_48_23_+1000_fHQWKx1j0Dp=6RUU--
