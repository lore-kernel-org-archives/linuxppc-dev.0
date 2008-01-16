Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 83DFCDDE3D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 10:02:58 +1100 (EST)
Date: Thu, 17 Jan 2008 10:02:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [Add mpc5121 support PATCH v2 3/8] Basic Freescale MPC512x support
Message-Id: <20080117100254.b43225c8.sfr@canb.auug.org.au>
In-Reply-To: <1200519447-25555-3-git-send-email-jrigby@freescale.com>
References: <1200519447-25555-1-git-send-email-jrigby@freescale.com>
	<1200519447-25555-2-git-send-email-jrigby@freescale.com>
	<1200519447-25555-3-git-send-email-jrigby@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__17_Jan_2008_10_02_54_+1100_kyqtP_XVr0t/xDyN"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__17_Jan_2008_10_02_54_+1100_kyqtP_XVr0t/xDyN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Wed, 16 Jan 2008 14:37:22 -0700 John Rigby <jrigby@freescale.com> wrote:
>
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c

> +static void __init mpc5121_ads_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);

You need an op_node_put(np) here.  ipic_init will do another of_node_get()
if it keeps a reference to np.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__17_Jan_2008_10_02_54_+1100_kyqtP_XVr0t/xDyN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjo0iTgG2atn1QN8RAnPRAJ9FqsKf5wT/lWshqIti90CEbzObEQCeOa2I
JgNLv3qj2vHlb2mkW4mPg0g=
=UMsg
-----END PGP SIGNATURE-----

--Signature=_Thu__17_Jan_2008_10_02_54_+1100_kyqtP_XVr0t/xDyN--
