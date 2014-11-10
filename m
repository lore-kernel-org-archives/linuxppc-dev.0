Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 702481A012C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 21:53:01 +1100 (AEDT)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: "shh.xie@gmail.com" <shh.xie@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] DT: add MDIO node for FMan node
Date: Mon, 10 Nov 2014 10:19:16 +0000
Message-ID: <715df09ebc3a444bb9da853c942348c1@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415102196-9238-1-git-send-email-shh.xie@gmail.com>
In-Reply-To: <1415102196-9238-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Emilian Medve <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping.

Best Regards,=20
Shaohui Xie

> -----Original Message-----
> From: shh.xie@gmail.com [mailto:shh.xie@gmail.com]
> Sent: Tuesday, November 04, 2014 7:57 PM
> To: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; Wood
> Scott-B07421
> Cc: Medve Emilian-EMMEDVE1; Xie Shaohui-B21989
> Subject: [PATCH] DT: add MDIO node for FMan node
>=20
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>=20
> This binding is for FMan MDIO, it covers FMan v2 & FMan v3.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> based on http://patchwork.ozlabs.org/patch/390351/
> for 'next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
>=20
>  .../devicetree/bindings/powerpc/fsl/fman.txt       | 69
> ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index da8e5f2..83c2f14 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> @@ -7,6 +7,7 @@ CONTENTS
>    - FMan MURAM Node
>    - FMan dTSEC/XGEC/mEMAC Node
>    - FMan IEEE 1588 Node
> +  - FMan MDIO Node
>    - Example
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> @@ -352,6 +353,67 @@ ptp-timer@fe000 {
>  };
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
> +FMan MDIO Node
> +
> +DESCRIPTION
> +
> +The MDIO is a bus to which the PHY devices are connected.
> +
> +PROPERTIES
> +
> +- compatible
> +		Usage: required
> +		Value type: <stringlist>
> +		Definition: A standard property.
> +		Must include "fsl,fman-mdio" for 1 Gb/s MDIO from FMan v2.
> +		Must include "fsl,fman-xmdio" for 10 Gb/s MDIO from FMan v2.
> +		Must include "fsl,fman-memac-mdio" for 1/10 Gb/s MDIO from
> +		FMan v3.
> +
> +- reg
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: A standard property.
> +
> +- bus-frequency
> +		Usage: optional
> +		Value type: <u32>
> +		Definition: Default MDIO bus clock speed.
> +
> +- interrupts
> +		Usage: optional
> +		Value type: <prop-encoded-array>
> +		Definition: MDIO controller event interrupts.
> +
> +- type
> +		Usage: required for FMan v3
> +		Value type: <stringlist>
> +		Definition: A standard property.
> +		FMan v3 has internal MDIO for internal PCS(Physical Coding
> +		Sublayer) PHYs and external MDIO for external PHYs.
> +		The settings and programming routines for internal/external
> +		MDIO are different. Must include "internal" for internal MDIO,
> +		must include "external" for external MDIO.
> +
> +EXAMPLE
> +
> +Example for FMan v2:
> +
> +mdio@f1000 {
> +	compatible =3D "fsl,fman-xmdio";
> +	reg =3D <0xf1000 0x1000>;
> +};
> +
> +Example for FMan v3:
> +
> +mdio@fd000 {
> +	compatible =3D "fsl,fman-memac-mdio";
> +	reg =3D <0xfd000 0x1000>;
> +	bus-frequency =3D <2500000>;
> +	type =3D "external";
> +};
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
>  Example
>=20
>  fman@400000 {
> @@ -526,4 +588,11 @@ fman@400000 {
>  		compatible =3D "fsl,fman-ptp-timer";
>  		reg =3D <0xfe000 0x1000>;
>  	};
> +
> +	mdio@fd000 {
> +		compatible =3D "fsl,fman-memac-mdio";
> +		reg =3D <0xfd000 0x1000>;
> +		bus-frequency =3D <2500000>;
> +		type =3D "external";
> +	};
>  };
> --
> 1.8.4.1
