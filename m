Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F3BC1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Jan 2010 00:30:47 +1100 (EST)
Date: Sat, 2 Jan 2010 14:30:41 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next 1/3] can: mscan: fix improper return if dlc <
	8 in start_xmit function
Message-ID: <20100102133041.GB2239@pengutronix.de>
References: <1262420274-16586-1-git-send-email-wg@grandegger.com>
	<1262420274-16586-2-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
In-Reply-To: <1262420274-16586-2-git-send-email-wg@grandegger.com>
Cc: Socketcan-core@lists.berlios.de, Netdev@vger.kernel.org,
	Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 02, 2010 at 09:17:52AM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> The start_xmit function of the MSCAN Driver did return improperly if
> the CAN dlc check failed (skb not freed and invalid return code). This
> patch adds a proper check of the frame lenght and data size and returns
> now correctly. Furthermore, a typo has been fixed.

A few little things, but in general:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> ---
>  drivers/net/can/mscan/mscan.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
> index 07346f8..abdf5e8 100644
> --- a/drivers/net/can/mscan/mscan.c
> +++ b/drivers/net/can/mscan/mscan.c
> @@ -4,7 +4,7 @@
>   * Copyright (C) 2005-2006 Andrey Volkov <avolkov@varma-el.com>,
>   *                         Varma Electronics Oy
>   * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> - * Copytight (C) 2008-2009 Pengutronix <kernel@pengutronix.de>
> + * Copyright (C) 2008-2009 Pengutronix <kernel@pengutronix.de>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the version 2 of the GNU General Public License
> @@ -177,8 +177,13 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  	int i, rtr, buf_id;
>  	u32 can_id;
> =20
> -	if (frame->can_dlc > 8)
> -		return -EINVAL;
> +	if (skb->len !=3D sizeof(*frame) || frame->can_dlc > 8) {
> +		dev_err(dev->dev.parent,
> +			"Dropping non-conform paket: len %d, can_dlc %d\n",

s/paket/packet/

> +			skb->len, frame->can_dlc);

Also, shouldn't it rather be %u (sk_buff->len is unsigned int)?

> +		kfree_skb(skb);
> +		return  NETDEV_TX_OK;
> +	}
> =20
>  	out_8(&regs->cantier, 0);
> =20
> --=20
> 1.6.2.5
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks/SoEACgkQD27XaX1/VRuqGQCfXdEyfjWqoZ4ExhYww8Dxwzc+
49gAoLv2E1JQUyY2eT0H4iASBQ7c6Azy
=9cTy
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
