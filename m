Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7995FDDE2A
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 13:41:35 +1000 (EST)
Date: Wed, 6 Aug 2008 13:41:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH add immr alias 1/4] powerpc: Teach get_immrbase to use
	immr alias if it exists.
Message-Id: <20080806134130.3ac17fbb.sfr@canb.auug.org.au>
In-Reply-To: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Aug_2008_13_41_30_+1000_O+wBrUuhOlUyIGEc"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Aug_2008_13_41_30_+1000_O+wBrUuhOlUyIGEc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

[From further in the discussion, this may no longer be relevant ...]

On Tue,  5 Aug 2008 14:13:37 -0600 John Rigby <jrigby@freescale.com> wrote:
>
> -	soc =3D of_find_node_by_type(NULL, "soc");
> +	/*
> +	 * First look for an immr alias
> +	 */
> +	np =3D of_find_node_by_name(NULL, "/aliases");
> +	if (np) {
> +		path =3D of_get_property(np, "immr", NULL);
> +		if (path)
> +			soc =3D of_find_node_by_name(NULL, path);

		of_node_put(np);

> +	}
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Aug_2008_13_41_30_+1000_O+wBrUuhOlUyIGEc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZHWoACgkQjjKRsyhoI8xpjACgnpzLs1ATlDtnpBOOIwiYyPt6
LPoAnRzOWjldJ7nFVaBTWw0LKyak2mol
=sL6n
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Aug_2008_13_41_30_+1000_O+wBrUuhOlUyIGEc--
