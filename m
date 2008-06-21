Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D31D5DDEDD
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 14:39:22 +1000 (EST)
Date: Sat, 21 Jun 2008 14:39:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 2/6] MPC5121 clock driver
Message-Id: <20080621143913.a6008120.sfr@canb.auug.org.au>
In-Reply-To: <1213981119-1979-3-git-send-email-jrigby@freescale.com>
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__21_Jun_2008_14_39_13_+1000_22_yGsZ3Tnx4.e_l"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__21_Jun_2008_14_39_13_+1000_22_yGsZ3Tnx4.e_l
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Fri, 20 Jun 2008 10:58:35 -0600 John Rigby <jrigby@freescale.com> wrote:
>
> +struct module;

Since you include linux/module.h, you don't need this.

> +static unsigned long devtree_getfreq(char *nodetype, char *clockname)
> +{
> +	struct device_node *node;
> +	const unsigned int *fp;
> +	unsigned int val =3D 0;
> +
> +	node =3D of_find_node_by_type(NULL, "soc");
> +	if (node) {
> +		fp =3D of_get_property(node, clockname, NULL);
> +		if (fp)
> +			val =3D of_read_ulong(fp, 1);
> +	}
> +	return val;

You leak a reference to the node here. Also every call has nodetype set to
"soc" and you don't use nodetype anyway.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__21_Jun_2008_14_39_13_+1000_22_yGsZ3Tnx4.e_l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhchfEACgkQTgG2atn1QN9y8gCfcMi9TvPpUp2HrDrOaJR2XkaA
I+oAnRgvEFx5qRgnIarMVFpDelP0uwmk
=+KOI
-----END PGP SIGNATURE-----

--Signature=_Sat__21_Jun_2008_14_39_13_+1000_22_yGsZ3Tnx4.e_l--
