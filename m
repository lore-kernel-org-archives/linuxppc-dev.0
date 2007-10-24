Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6F23BDDF13
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 17:16:31 +1000 (EST)
Date: Wed, 24 Oct 2007 17:16:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 03/11] [POWERPC] Add common mpc52xx_setup_pci() routine
Message-Id: <20071024171619.465d501f.sfr@canb.auug.org.au>
In-Reply-To: <20071023231321.29359.96506.stgit@hekate.izotz.org>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231321.29359.96506.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__24_Oct_2007_17_16_19_+1000_TI/rnlrb0L6GL/5b"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__24_Oct_2007_17_16_19_+1000_TI/rnlrb0L6GL/5b
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Oct 2007 01:13:21 +0200 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +++ b/arch/powerpc/platforms/52xx/lite5200.c
> @@ -155,11 +155,7 @@ static void __init lite5200_setup_arch(void)
>  #endif
> =20
>  #ifdef CONFIG_PCI
> -	np =3D of_find_node_by_type(NULL, "pci");
> -	if (np) {
> -		mpc52xx_add_bridge(np);
> -		of_node_put(np);
> -	}
> +	mpc52xx_setup_pci();
>  #endif

Normally we would have no "#ifdef CONFIG_PCI" here but instead define a

static inline void mpc52xx_setup_pci(void) { }

in the header file for the non PCI case.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__24_Oct_2007_17_16_19_+1000_TI/rnlrb0L6GL/5b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHvFNTgG2atn1QN8RAltcAJsF3bGxJYfp00AenhVMRJgRk5g3BgCbB1sx
VO2SWsLtc6+E/Hs53PXrTXA=
=RBzq
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Oct_2007_17_16_19_+1000_TI/rnlrb0L6GL/5b--
