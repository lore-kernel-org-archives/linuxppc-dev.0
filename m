Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77234DE43C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 23:20:42 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m2LCKbFq014619 for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 05:20:37 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2LCKYvl016386
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 07:20:35 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ucc_geth: Add 8 bytes to max TX frame for VLANs
Date: Fri, 21 Mar 2008 20:20:34 +0800
Message-ID: <989B956029373F45A0B8AF029708189001D19565@zch01exm26.fsl.freescale.net>
In-Reply-To: <1205853088-30171-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <>
	<1205853088-30171-1-git-send-email-Joakim.Tjernlund@transmode.se>
From: "Li Yang" <LeoLi@freescale.com>
To: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>,
	"Netdev" <netdev@vger.kernel.org>,
	"Linuxppc-Embedded@Ozlabs.Org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: netdev-owner@vger.kernel.org=20
> [mailto:netdev-owner@vger.kernel.org] On Behalf Of Joakim Tjernlund
> Sent: Tuesday, March 18, 2008 11:11 PM
> To: Netdev; Li Yang
> Cc: Joakim Tjernlund
> Subject: [PATCH] ucc_geth: Add 8 bytes to max TX frame for VLANs
>=20
> Creating a VLAN interface on top of ucc_geth adds 4 bytes to=20
> the frame and the HW controller is not prepared to TX a frame=20
> bigger than 1518 bytes which is 4 bytes too small for a full=20
> VLAN frame. Also add 4 extra bytes for future expansion.

IMO, VLAN and Jumbo packet support is not general case of Ethernet.
Could you make this change optional?  Thanks.

- Leo

>=20
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
>  drivers/net/ucc_geth.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c=20
> index 348892b..038ec75 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -114,10 +114,10 @@ static struct ucc_geth_info=20
> ugeth_primary_info =3D {
>  	.maxGroupAddrInHash =3D 4,
>  	.maxIndAddrInHash =3D 4,
>  	.prel =3D 7,
> -	.maxFrameLength =3D 1518,
> +	.maxFrameLength =3D 1518+8, /* Add 4 bytes for VLAN tags=20
> and 4 extra=20
> +bytes */
>  	.minFrameLength =3D 64,
> -	.maxD1Length =3D 1520,
> -	.maxD2Length =3D 1520,
> +	.maxD1Length =3D 1520+8,
> +	.maxD2Length =3D 1520+8,
>  	.vlantype =3D 0x8100,
>  	.ecamptr =3D ((uint32_t) NULL),
>  	.eventRegMask =3D UCCE_OTHER,
> --
> 1.5.4.3
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> netdev" in the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
