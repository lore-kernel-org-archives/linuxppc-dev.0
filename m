Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AA72CDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 09:34:57 +1100 (EST)
Date: Thu, 24 Jan 2008 09:34:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v6] [POWERPC] Add LED driver for Promess Motion-PRO board.
Message-Id: <20080124093452.bc555fc1.sfr@canb.auug.org.au>
In-Reply-To: <20080123121159.21197.37027.stgit@zion.izotz.org>
References: <20080123121159.21197.37027.stgit@zion.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__24_Jan_2008_09_34_52_+1100_NnpH/E.pjhimfBY."
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__24_Jan_2008_09_34_52_+1100_NnpH/E.pjhimfBY.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marian,

On Wed, 23 Jan 2008 13:12:19 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> +	label =3D of_get_property(op->node, "label", NULL);
> +	if (label =3D=3D NULL) {
> +		printk(KERN_ERR __FILE__ ": "
> +			"No label property provided for LED %s\n",
> +			op->node->full_name);
> +		err =3D -EINVAL;
> +		goto err_free;

You need an iounmap(mpled->gpt) here - or preferably jump to the one in
the error path below.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Jan_2008_09_34_52_+1100_NnpH/E.pjhimfBY.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHl8EQTgG2atn1QN8RAuufAJ0dL6JpNi0Jfim4s/hBHnakAY1UdgCfWRgW
jTSo4U0FvZyfHETMuVX6Ui4=
=3HQK
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Jan_2008_09_34_52_+1100_NnpH/E.pjhimfBY.--
