Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FE9DB6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Jan 2010 01:33:43 +1100 (EST)
Date: Wed, 6 Jan 2010 15:33:37 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH net-next v2 1/3] can: mscan: fix improper return if dlc
	< 8 in start_xmit function
Message-ID: <20100106143337.GC5299@pengutronix.de>
References: <1262719169-2350-1-git-send-email-wg@grandegger.com>
	<1262719169-2350-2-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
In-Reply-To: <1262719169-2350-2-git-send-email-wg@grandegger.com>
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


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2010 at 08:19:27PM +0100, Wolfgang Grandegger wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>=20
> The start_xmit function of the MSCAN Driver did return improperly if
> the CAN dlc check failed (skb not freed and invalid return code). This
> patch adds a proper check of the frame lenght and data size and returns
> now correctly. Furthermore, a typo has been fixed.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/net/can/mscan/mscan.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
> index bb06dfb..7df950e 100644
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
> +			"Dropping non-conform packet: len %u, can_dlc %u\n",
> +			skb->len, frame->can_dlc);
> +		kfree_skb(skb);
> +		return  NETDEV_TX_OK;

Double space.

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

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktEn0EACgkQD27XaX1/VRuh1wCcD/HMib9GgtTHAVvmJR2AnGzb
MygAn3fVzNw33dY+/R28XQSb4IxdJWya
=F9By
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
