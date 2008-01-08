Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 88F0EDDE9E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 13:38:00 +1100 (EST)
Date: Tue, 8 Jan 2008 13:37:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v6] qe: add ability to upload QE firmware
Message-Id: <20080108133747.f717e4b4.sfr@canb.auug.org.au>
In-Reply-To: <11997441442105-git-send-email-timur@freescale.com>
References: <11997441442105-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_13_37_47_+1100_rgkivUvGZPAGadv3"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_13_37_47_+1100_rgkivUvGZPAGadv3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Jan 2008 16:15:44 -0600 Timur Tabi <timur@freescale.com> wrote:
>
> +struct qe_firmware_info *qe_get_firmware_info(void)
> +{

> +	/* Find the 'firmware' child node */
> +	while ((fw =3D of_get_next_child(qe, fw)))

If you use:
	for_each_child_of_node(qe, fw)
You don't need to initialise 'fw' in its declararion.

> +	/* Did we find the 'firmware' node? */
> +	if (!fw) {
> +		of_node_put(fw);

This of_node_put is not necessary (as fw is NULL);

> +	prop =3D of_find_property(fw, "extended-modes", NULL);
> +	if (prop && (prop->length =3D=3D sizeof(u64))) {
> +		const u64 *iprop =3D prop->value;
> +
> +		qe_firmware_info.extended_modes =3D *iprop;
> +	}

Why not:
	const u64 *iprop;
	int len;

	iprop =3D of_get_property(fs, "extended-modes", &len);
	if (iprop && (len =3D=3D sizeof(u64))
		qe_firmware_info.extended_modes =3D *iprop;

> +	prop =3D of_find_property(fw, "virtual-traps", NULL);
> +	if (prop && (prop->length =3D=3D 32)) {
> +		const u32 *iprop =3D prop->value;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(qe_firmware_info.vtraps); i++)
> +			qe_firmware_info.vtraps[i] =3D iprop[i];
> +	}

And similarly?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_13_37_47_+1100_rgkivUvGZPAGadv3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHguIATgG2atn1QN8RAg8cAJwJ0p7z40QbyQEOs37WsuRkrAo1HgCdFAYU
FMoy7NGtYI5pLJ9X4a4JK3A=
=If4M
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_13_37_47_+1100_rgkivUvGZPAGadv3--
