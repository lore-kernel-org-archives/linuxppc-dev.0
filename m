Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F445B6EFE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 16:43:19 +1100 (EST)
Received: from mail14-am1 (localhost.localdomain [127.0.0.1])	by
	mail14-am1-R.bigfish.com (Postfix) with ESMTP id 431971030439	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 05:28:09 +0000 (UTC)
Received: from am1ehsmhs008.bigfish.com (unknown [10.3.201.244])	by
	mail14-am1.bigfish.com (Postfix) with ESMTP id DAB981858050	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 05:28:08 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o975RuSk003402	for <linuxppc-dev@ozlabs.org>;
	Wed, 6 Oct 2010 22:28:06 -0700 (MST)
Subject: Re: [PATCH 1/2] powerpc/85xx: add ngPIXIS FPGA device tree node to
	the P1022DS board
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284057597-17126-1-git-send-email-timur@freescale.com>
Date: Thu, 7 Oct 2010 00:27:54 -0500
Message-ID: <6D1D0935-4E91-4E2F-87E9-95F7F5B16377@freescale.com>
References: <1284057597-17126-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 9, 2010, at 1:39 PM, Timur Tabi wrote:

> The device tree for Freescale's P1022DS reference board is missing the =
node
> for the ngPIXIS FPGA.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |    9 +++++++++
> 1 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p1022ds.dts =
b/arch/powerpc/boot/dts/p1022ds.dts
> index 8bcb10b..e61b42d 100644
> --- a/arch/powerpc/boot/dts/p1022ds.dts
> +++ b/arch/powerpc/boot/dts/p1022ds.dts
> @@ -148,6 +148,15 @@
> 				label =3D "reserved-nand";
> 			};
> 		};
> +
> +		board-control@3,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;

these aren't need if we don't have a child node.

> +			compatible =3D "fsl,fpga-pixis";

lets make this "fsl,p1022ds-pixis"

> +			reg =3D <3 0 0x30>;
> +			interrupt-parent =3D <&mpic>;
> +			interrupts =3D <8 8>;

what do we think about adding a comment about what this interrupt is for

> +		};
> 	};
>=20
> 	soc@fffe00000 {
> --=20
> 1.7.2.2
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
