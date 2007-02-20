Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 74B55DDD0E
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 06:22:13 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l1KJM9au016343
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 12:22:09 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1KJM8Z1011071
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 13:22:08 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 12/14] Add device tree for Ebony
Date: Tue, 20 Feb 2007 12:22:07 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A58C89@az33exm25.fsl.freescale.net>
In-Reply-To: <20070220021235.DC02DDDD06@ozlabs.org>
References: <20070220020837.GF17818@localhost.localdomain>
	<20070220021235.DC02DDDD06@ozlabs.org>
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


A couple of minor nits...

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

Since UIC1 is cascaded off UIC0 in the interrupt tree,
UIC1 should have an interrupt-parent pointing to UIC0
so the interrupt tree can be traversed to the root.

I know this was beaten to death last week, but I would
still argue that in the device tree UIC0 and UIC1 should
be siblings.  (In the interrupt tree the cascade relationship
is described through interrupt-parent).

> +	chosen {
> +		linux,stdout-path =3D "/plb/opb@0/serial@140000200";
> +		linux,initrd-start =3D <0>; /* FIXME */
> +		linux,initrd-end =3D <0>;
> +		interrupt-controller =3D <&UIC0>;
> +	};
> +};

I thought there was agreement (last week) that interrupt-controller
would no longer be under /chosen.  I submitted a patch to
booting-without-of.txt to make this obsolete.   The kernel
does not use the property, and we can find a different place for
it in the future if we need it.

Stuart
