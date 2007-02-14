Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id BE92FDDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 03:14:25 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1EGEHF5029902
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 09:14:18 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1EGEHUI004591
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 10:14:17 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 09:14:15 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
In-Reply-To: <20070213061026.5837FDDDE9@ozlabs.org>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I realize the dts is preliminary, but saw some stuff and=20
thought I would comment.

> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of David Gibson

[snip]

> +	UIC0: interrupt-controller { /* UIC0 */
> +		device_type =3D "interrupt-controller";
> +		compatible =3D "ibm,uic440gp", "ibm,uic";
> +		interrupt-controller;
> +		cell-index =3D <0>;
> +		dcr-reg =3D <0c0 009>;
> +		#address-cells =3D <0>;
> +		#size-cells =3D <0>;
> +		#interrupt-cells =3D <2>;
> +
> +		UIC1: interrupt-controller@1 { /* UIC1 */
> +			device_type =3D "interrupt-controller";
> +			compatible =3D "ibm,uic440gp", "ibm,uic";
> +			interrupt-controller;
> +			cell-index =3D <1>;
> +			dcr-reg =3D <0d0 009>;
> +			#address-cells =3D <0>;
> +			#size-cells =3D <0>;
> +			#interrupt-cells =3D <2>;
> +			interrupts =3D <1e 4 1f 4>; /* cascade */
> +		};
> +	};

Did you mean to have UIC1 nested under UIC0 or should
they be at the same level?

> +	plb {
> +		device_type =3D "soc";
> +		compatible =3D "ibm,plb-440gp", "ibm,plb4";
> +		ranges;
> +
> +		POB0: opb@0 {
> +			device_type =3D "soc";
> +			compatible =3D "ibm,opb-440gp", "ibm,opb";
> +			ranges;
> +			dcr-reg =3D <090 00b>;
> +			interrupt-parent =3D <&UIC1>;
> +			interrupts =3D <7 4>;
> +			clock-frequency =3D <3ef1480>; // FIXME: 66MHz

Hmm.  There are two "soc" devices here, one nested under the
first??

I'm assuming these are two levels of busses the opb bus is attached
to the plb bus.  Is the "soc" device_type the right way to=20
do this?

Stuart
