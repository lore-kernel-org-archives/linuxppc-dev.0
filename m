Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 72182B7BFB
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 16:33:07 +1100 (EST)
Date: Sat, 31 Oct 2009 16:32:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mpc52xx-psc-spi: refactor probe and remove to make use
	of of_register_spi_devices()
Message-Id: <20091031163259.5c651773.sfr@canb.auug.org.au>
In-Reply-To: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
References: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__31_Oct_2009_16_32_59_+1100_a+306G2MiZby2M/3"
Cc: =?UTF-8?B?S8OhcmkgRGF2w60=?= =?UTF-8?B?w7Bzc29u?=
	<kari.davidsson@marel.com>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__31_Oct_2009_16_32_59_+1100_a+306G2MiZby2M/3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Fri, 30 Oct 2009 20:44:12 +0100 Wolfram Sang <w.sang@pengutronix.de> wro=
te:
>
>  static struct of_platform_driver mpc52xx_psc_spi_of_driver =3D {
>  	.owner =3D THIS_MODULE,
> -	.name =3D "mpc52xx-psc-spi",
> +	.name =3D DRIVER_NAME,

You no longer need to set either owner or name in the of_platform driver,
just in the included struct driver (as is done below), so you could just
remove the above two lines.

>  	.match_table =3D mpc52xx_psc_spi_of_match,
>  	.probe =3D mpc52xx_psc_spi_of_probe,
>  	.remove =3D __exit_p(mpc52xx_psc_spi_of_remove),
>  	.driver =3D {
> -		.name =3D "mpc52xx-psc-spi",
> +		.name =3D DRIVER_NAME,
>  		.owner =3D THIS_MODULE,
>  	},
>  };

I am hoping that we can remove the owner and name fields from struct
of_platform_driver sometime.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__31_Oct_2009_16_32_59_+1100_a+306G2MiZby2M/3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrrzAsACgkQjjKRsyhoI8zkPACfWvLFMPT+IGon6R7fVZu+hSuJ
A/EAn0RBqP/UnD2smgqx/yaLGVWm85Fd
=mTv6
-----END PGP SIGNATURE-----

--Signature=_Sat__31_Oct_2009_16_32_59_+1100_a+306G2MiZby2M/3--
