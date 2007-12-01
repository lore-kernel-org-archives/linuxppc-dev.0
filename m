Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 17F9DDDDFF
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 10:27:51 +1100 (EST)
Date: Sun, 2 Dec 2007 10:27:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: cbou@mail.ru
Subject: Re: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate PHY
	layer functionality
Message-Id: <20071202102739.490ae468.sfr@canb.auug.org.au>
In-Reply-To: <20071201213403.GA2350@zarina>
References: <20071126142906.19642.45540.stgit@localhost.localdomain>
	<47516646.9000803@scram.de> <20071201213403.GA2350@zarina>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__2_Dec_2007_10_27_39_+1100_P8UzWhXZL=bMA0n_"
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__2_Dec_2007_10_27_39_+1100_P8UzWhXZL=bMA0n_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just a little reminder ...

On Sun, 2 Dec 2007 00:34:03 +0300 Anton Vorontsov <cbou@mail.ru> wrote:
>
> static int __init of_add_fixed_phys(void)
> {
> 	struct device_node *np;
> 	const u32 *prop;
> 	struct fixed_phy_status status =3D {};
>=20
> 	while ((np =3D of_find_node_by_name(NULL, "ethernet"))) {

	for_each_node_by_name(np, "ethernet") {
(this probably does what you want instead of finding just the first
ethernet over and over again. :-))

> 		data  =3D of_get_property(np, "fixed-link", NULL);
> 		if (!data)
> 			continue;
>=20
> 		status.link =3D 1;
> 		status.duplex =3D data[1];
> 		status.speed  =3D data[2];
>=20
> 		ret =3D fixed_phy_add(PHY_POLL, data[0], &status);
> 		if (ret)
> 			return ret;
		if (ret) {
			of_put_node(np);
			retun ret;
		}
> 	}

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__2_Dec_2007_10_27_39_+1100_P8UzWhXZL=bMA0n_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHUe3yTgG2atn1QN8RAnKXAJ0atAh7fRzQ8PgPUE1+yoK4aNVJQgCfY29E
kx+R21nK1BHD63ePkedAKeE=
=D5Cu
-----END PGP SIGNATURE-----

--Signature=_Sun__2_Dec_2007_10_27_39_+1100_P8UzWhXZL=bMA0n_--
