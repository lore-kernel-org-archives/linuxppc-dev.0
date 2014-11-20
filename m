Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0138.outbound.protection.outlook.com [157.56.110.138])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FEC61A0A0B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 00:15:26 +1100 (AEDT)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
Date: Thu, 20 Nov 2014 13:00:44 +0000
Message-ID: <20b19f779c5e45d7ac40964f21866ca3@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
In-Reply-To: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>,
 Emilian Medve <Emilian.Medve@freescale.com>
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
> Sent: Friday, November 14, 2014 5:53 PM
> To: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; Wood
> Scott-B07421
> Cc: Medve Emilian-EMMEDVE1; Liberman Igal-B31950; Xie Shaohui-B21989
> Subject: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
>=20
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>=20
> This binding is for FMan MDIO, it covers FMan v2 & FMan v3.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> changes in V2:
> addressed comments from Scott in V1.
>=20
>  .../devicetree/bindings/powerpc/fsl/fman.txt       | 69
> ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index edeea16..1523a87 100644
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
> @@ -357,6 +358,68 @@ ptp-timer@fe000 {
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
> +		Definition: Specifies external MDIO bus clock speed which is
> +		different from MDIO standard 2.5MHz. Should be defined for
> SoCs
> +		on which the standard one cannot work.
> +
> +- interrupts
> +		Usage: optional
> +		Value type: <prop-encoded-array>
> +		Definition: Event interrupt of external MDIO controller.
> +		1 Gb/s MDIO and 10 Gb/s MDIO has one interrupt respectively.
> +
> +- fsl,fman-internal-mdio
> +		Usage: required for internal MDIO
> +		Value type: boolean
> +		Definition: Fman has internal MDIO for internal PCS(Physical
> +		Coding Sublayer) PHYs and external MDIO for external PHYs.
> +		The settings and programming routines for internal/external
> +		MDIO are different. Must be included for internal MDIO.
> +
> +EXAMPLE
> +
> +Example for FMan v2 external MDIO:
> +
> +mdio@f1000 {
> +	compatible =3D "fsl,fman-xmdio";
> +	reg =3D <0xf1000 0x1000>;
> +	bus-frequency =3D <20000>;
> +};
> +
> +Example for FMan v3 internal MDIO:
> +
> +mdio@f1000 {
> +	compatible =3D "fsl,fman-memac-mdio";
> +	reg =3D <0xf1000 0x1000>;
> +	fsl,fman-internal-mdio;
> +};
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
>  Example
>=20
>  fman@400000 {
> @@ -531,4 +594,10 @@ fman@400000 {
>  		compatible =3D "fsl,fman-ptp-timer";
>  		reg =3D <0xfe000 0x1000>;
>  	};
> +
> +	mdio@f1000 {
> +		compatible =3D "fsl,fman-xmdio";
> +		reg =3D <0xf1000 0x1000>;
> +		bus-frequency =3D <20000>;
> +	};
>  };
> --
> 1.8.4.1
