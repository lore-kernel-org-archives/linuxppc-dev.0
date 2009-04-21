Return-Path: <gridish@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0437DDF07
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 21:23:05 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3LBMjq8007785
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 04:22:56 -0700 (MST)
Received: from zil05exm11.fsl.freescale.net (zil05exm11.ea.freescale.net
	[216.3.95.201])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3LBMiA9017465
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 06:22:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [net, 83xx] ucc_geth.c: Fix upsmr setting in RMII mode
Date: Tue, 21 Apr 2009 14:22:42 +0300
Message-ID: <75B28D1B75754E4BAEAF634C9498EC900376A911@zil05exm11.fsl.freescale.net>
In-Reply-To: <49ED859B.30904@denx.de>
References: <49ED859B.30904@denx.de>
From: "Gridish Shlomi-RM96313" <gridish@freescale.com>
To: <hs@denx.de>, "Li Yang-R58472" <LeoLi@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is correct.
Thanks
=20

> -----Original Message-----
> From: Heiko Schocher [mailto:hs@denx.de]=20
> Sent: Tuesday, April 21, 2009 11:37 AM
> To: Li Yang-R58472
> Cc: Gridish Shlomi-RM96313; Kumar Gala;=20
> netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> Subject: [PATCH] [net, 83xx] ucc_geth.c: Fix upsmr setting in=20
> RMII mode
>=20
> If using the UCC on a MPC8360 in RMII mode, don;t set=20
> UCC_GETH_UPSMR_RPM bit in the upsmr register.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>  drivers/net/ucc_geth.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c=20
> index d3f39e8..44f8392 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -1394,7 +1394,8 @@ static int adjust_enet_interface(struct=20
> ucc_geth_private *ugeth)
>  	    (ugeth->phy_interface =3D=3D PHY_INTERFACE_MODE_RGMII_RXID) ||
>  	    (ugeth->phy_interface =3D=3D PHY_INTERFACE_MODE_RGMII_TXID) ||
>  	    (ugeth->phy_interface =3D=3D PHY_INTERFACE_MODE_RTBI)) {
> -		upsmr |=3D UCC_GETH_UPSMR_RPM;
> +		if (ugeth->phy_interface !=3D PHY_INTERFACE_MODE_RMII)
> +			upsmr |=3D UCC_GETH_UPSMR_RPM;
>  		switch (ugeth->max_speed) {
>  		case SPEED_10:
>  			upsmr |=3D UCC_GETH_UPSMR_R10M;
> --
> 1.6.0.6
>=20
> --=20
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>=20
