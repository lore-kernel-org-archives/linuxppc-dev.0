Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 65DD4DE008
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 02:32:38 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2MFWXxk016151
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:32:34 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2MFWXqB016494
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 10:32:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
Date: Thu, 22 Mar 2007 08:32:33 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302B97F7C@az33exm25.fsl.freescale.net>
In-Reply-To: <1174573524.6595.509.camel@ld0161-tx32>
References: <1174573524.6595.509.camel@ld0161-tx32>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +		mpic: pic@40000 {
> +			clock-frequency =3D <0>;
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <2>;
> +			reg =3D <40000 40000>;
> +			built-in;
> +			compatible =3D "chrp,open-pic";
> +			device_type =3D "open-pic";
> +			big-endian;
> +			interrupts =3D <
> +			18 2 49 2 19 2
> +			2a 2 2b 2 4a 1
> +			1d 2 1e 2 22 2
> +			23 2 24 2 28 2
> +			>;
> +		};
> +	};
> +};

I think using the 'interrupts' property in this way is bad.  It's=20
being used to tell the pic which interrupts belong to it.=20

The problem is that the interrupts property is being overloaded
and used for a completely different purpose than that which
it was originally intended and documented.  Interrupt controllers
should not have an interrupts property.

The only reason I can see to do this is as a convenience to avoid
walking the device tree.   The pic code should walk the device tree
to determine the irq numbers the running core.

Stuart
