Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9AE3DDDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 22:30:58 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAKBUoLS018129
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 04:30:51 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAKBUnk4021421
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 05:30:50 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: mpc832x mds: Fix board PHY reset code
Date: Tue, 20 Nov 2007 19:30:46 +0800
Message-ID: <989B956029373F45A0B8AF029708189001A1C75E@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071119190443.7c04ae6b.kim.phillips@freescale.com>
References: <20071119190443.7c04ae6b.kim.phillips@freescale.com>
From: "Li Yang" <LeoLi@freescale.com>
To: "Phillips Kim" <Kim.Phillips@freescale.com>,
	"Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Cc: Van Ackeren Peter <Peter.VanAckeren@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Phillips Kim=20
> Sent: Tuesday, November 20, 2007 9:05 AM
> To: Kumar Gala; linuxppc-dev@ozlabs.org
> Cc: Van Ackeren Peter; Li Yang
> Subject: [PATCH] powerpc: mpc832x mds: Fix board PHY reset code
>=20
> currently the board-level PHY reset code for the mpc832x MDS=20
> messes with reset configuration words source settings which=20
> is plain wrong (it looks like this board code was=20
> cut-n-pasted from the mpc8360 mds code, which has the PHY=20
> reset bits in a different BCSR); this patch points the PHY=20
> reset code to the proper mpc832x mds PHY reset bits in the BCSR.
>=20
> Signed-off-by: Peter Van Ackeren <peter.vanackeren@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Acked-by: Li Yang <leoli@freescale.com>

> ---
>  arch/powerpc/platforms/83xx/mpc832x_mds.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c=20
> b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> index 972fa85..9e3bfcc 100644
> --- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
> +++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
> @@ -90,10 +90,11 @@ static void __init mpc832x_sys_setup_arch(void)
> =20
>  	if ((np =3D of_find_compatible_node(NULL, "network", "ucc_geth"))
>  			!=3D NULL){
> -		/* Reset the Ethernet PHY */
> -		bcsr_regs[9] &=3D ~0x20;
> +		/* Reset the Ethernet PHYs */
> +#define BCSR8_FETH_RST 0x50
> +		bcsr_regs[8] &=3D ~BCSR8_FETH_RST;
>  		udelay(1000);
> -		bcsr_regs[9] |=3D 0x20;
> +		bcsr_regs[8] |=3D BCSR8_FETH_RST;
>  		iounmap(bcsr_regs);
>  		of_node_put(np);
>  	}
> --
> 1.5.2.2
>=20
>=20
