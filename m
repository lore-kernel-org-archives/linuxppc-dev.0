Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 54BB1DDE20
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 17:14:03 +1100 (EST)
Date: Mon, 14 Jan 2008 17:13:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] Freescale enhanced Local Bus Controller FCM NAND
	support.
Message-Id: <20080114171358.644b4e2a.sfr@canb.auug.org.au>
In-Reply-To: <20080111204320.GC11215@loki.buserror.net>
References: <20080111204320.GC11215@loki.buserror.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_Jan_2008_17_13_58_+1100_psAKYMDgA.mygV/F"
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_Jan_2008_17_13_58_+1100_psAKYMDgA.mygV/F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Fri, 11 Jan 2008 14:43:20 -0600 Scott Wood <scottwood@freescale.com> wro=
te:
>
> +static int __devinit fsl_elbc_ctrl_probe(struct of_device *ofdev,
> +                                         const struct of_device_id *matc=
h)
> +{

> +	child =3D NULL;
> +	while ((child =3D of_get_next_child(ofdev->node, child)))

	for_each_child_of_node(of_dev->node, child)

> +		if (of_device_is_compatible(child, "fsl,elbc-fcm-nand"))
> +			fsl_elbc_chip_probe(ctrl, child);

> +static struct of_device_id fsl_elbc_match[] =3D {

const, please.

> +static struct of_platform_driver fsl_elbc_ctrl_driver =3D {

	.driver =3D {

> +	.name	=3D "fsl-elbc",

	},

> +	.match_table =3D fsl_elbc_match,
> +	.probe =3D fsl_elbc_ctrl_probe,
> +	.remove =3D __devexit_p(fsl_elbc_ctrl_remove),
> +};

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_Jan_2008_17_13_58_+1100_psAKYMDgA.mygV/F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHiv2qTgG2atn1QN8RAlyVAJ9g6mIEjDgp/dQg+qwYlBHT/1OPsgCfR5HT
T9TY9n73o/obnGKg51LpDnk=
=pzaQ
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Jan_2008_17_13_58_+1100_psAKYMDgA.mygV/F--
