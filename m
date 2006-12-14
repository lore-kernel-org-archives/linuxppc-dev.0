Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 12/14] Spidernet Avoid possible RX chain corruption
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061213212301.GL1915@austin.ibm.com>
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213212301.GL1915@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2Sw9NVTzfuC/sViISQcj"
Date: Thu, 14 Dec 2006 11:22:43 +1100
Message-Id: <1166055763.6838.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@gmx.de>,
	jgarzik@pobox.com, James K Lewis <jim@jklewis.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2Sw9NVTzfuC/sViISQcj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-12-13 at 15:23 -0600, Linas Vepstas wrote:
> Delete possible source of chain corruption; the hardware
> already knows the location of the tail, and writing it
> again is likely to mess it up.
>=20
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
>=20
> ----
>=20
>  drivers/net/spider_net.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> Index: linux-2.6.19-git7/drivers/net/spider_net.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-git7.orig/drivers/net/spider_net.c	2006-12-13 14:28:23.0=
00000000 -0600
> +++ linux-2.6.19-git7/drivers/net/spider_net.c	2006-12-13 14:28:25.000000=
000 -0600
> @@ -513,7 +513,6 @@ spider_net_alloc_rx_skbs(struct spider_n
>  	/* This will allocate the rest of the rx buffers;
>  	 * if not, it's business as usual later on. */
>  	spider_net_refill_rx_chain(card);
> -	spider_net_enable_rxchtails(card);
>  	spider_net_enable_rxdmac(card);
>  	return 0;

Didn't you just add that line?

=46rom "[PATCH 10/14] Spidernet RX Chain tail":

> @@ -501,17 +501,18 @@ spider_net_alloc_rx_skbs(struct spider_n
>=20
> <snip comment change>
> =20
> -       /* this will allocate the rest of the rx buffers; if not, it's
> -        * business as usual later on */
> +       /* This will allocate the rest of the rx buffers;
> +        * if not, it's business as usual later on. */
>         spider_net_refill_rx_chain(card);
> +       spider_net_enable_rxchtails(card);
>         spider_net_enable_rxdmac(card);
>         return 0;

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-2Sw9NVTzfuC/sViISQcj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFgJlSdSjSd0sB4dIRAhdSAKCT2YsyU53E9bjK/mrLEzL+INgQIgCgs7P7
JNEAY5O+rwG0foI/AiJ06kY=
=uefY
-----END PGP SIGNATURE-----

--=-2Sw9NVTzfuC/sViISQcj--
