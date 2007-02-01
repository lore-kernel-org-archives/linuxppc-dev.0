Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7161BDDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 02:08:35 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l11F8XGX020776
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 08:08:33 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l11F8WtC010361
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 09:08:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: I don't understand #size-cells = <0>
Date: Thu, 1 Feb 2007 08:08:31 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA30262A1AA@az33exm25.fsl.freescale.net>
In-Reply-To: <20070201002534.GD29213@localhost.localdomain>
References: <200702010022.l110MCan009105@pogo.cesa.opbu.xerox.com>
	<20070201002534.GD29213@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Andrew Klossner" <andrew@cesa.opbu.xerox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


A specific example of #size-cells =3D <0> would be for=20
the cpus node:

    cpus {
       #address-cells =3D <1>;
       #size-cells =3D <0>;

       PowerPC,7447A@0 {
          device_type =3D "cpu";
          reg =3D <0>;
       }
=20
       PowerPC,7447A@1 {
          device_type =3D "cpu";
          reg =3D <1>;
       }
    }

The "reg" field for a cpu node does not have a size
field.

Stuart

> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of David Gibson
> Sent: Wednesday, January 31, 2007 6:26 PM
> To: Andrew Klossner
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: I don't understand #size-cells =3D <0>
>=20
> On Wed, Jan 31, 2007 at 04:22:12PM -0800, Andrew Klossner wrote:
> > I'm porting the kernel to an 8548-based board whose boot loader does
> > not provide a device tree, so I'm rolling my own.
> >=20
> > Rev 0.5 of booting-without-of.txt says:
> >=20
> > 	"reg" properties are always a tuple of the type "address size"
> > 	where the number of cells of address and size is specified by
> > 	the bus #address-cells and #size-cells.
> >=20
> > but in the examples, we see
> >=20
> > 		reg =3D <22000 1000>;
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <0>;
> >=20
> > The number of cells of address is 1.  The number of cells=20
> of size is 0.
> > 1+0=3D1, so how can the reg property have a tuple of size 2?
>=20
> The #address-cells and #size-cells properties apply to children of the
> node they appear in, but not in the node itself.  So the "reg" here
> uses the #address-cells and #size-cells values from its parent.
>=20
> This is so that a bridge to a different bus (say, PCI<->USB) can have
> a reg property in the format of its parent bus for the control
> registers, but define a new address format for things on the
> subordinate bus.
>=20
> --=20
> David Gibson			| I'll have my music baroque,=20
> and my code
> david AT gibson.dropbear.id.au	| minimalist, thank=20
> you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
