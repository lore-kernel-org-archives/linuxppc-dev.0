Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CA70EDDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 08:45:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx EDK BSP generation of device trees for microblaze and
	PowerPC
Date: Mon, 26 Nov 2007 13:44:02 -0800
In-Reply-To: <fa686aa40711251447t57f96dd4iba51d68e1c9a9c5c@mail.gmail.com>
References: <20071120194411.E183B100060@mail17-sin.bigfish.com>
	<20071125062456.ABA4AA4804E@mail64-cpk.bigfish.com>
	<fa686aa40711251447t57f96dd4iba51d68e1c9a9c5c@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Segher Boessenkool" <segher@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>, "Jon Loeliger" <jdl@jdl.com>
Message-Id: <20071126214459.627E7AB004D@mail132-cpk.bigfish.com>
Cc: microblaze-uclinux@itee.uq.edu.au, Michal Simek <simekm2@fel.cvut.cz>,
	git <git@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
I've pushed the current state up to
git://git.xilinx.com/gen-mhs-devtree.git for your perusing.  Comments
below.

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Sunday, November 25, 2007 2:47 PM
> To: Stephen Neuendorffer; Segher Boessenkool; David Gibson;=20
> Jon Loeliger
> Cc: microblaze-uclinux@itee.uq.edu.au;=20
> linuxppc-dev@ozlabs.org; Michal Simek; git
> Subject: Re: Xilinx EDK BSP generation of device trees for=20
> microblaze and PowerPC
>=20
> On 11/24/07, Stephen Neuendorffer=20
> <stephen.neuendorffer@xilinx.com> wrote:
> >
>=20
> Thanks for all this work; comments below.
>=20
> >
> > Here's what I've gotten so far:
> >
> >                  Hard_Ethernet_MAC: xps-ll-temac@81c00000 {
> >                          #address-cells =3D <1>;
> >                          #size-cells =3D <1>;
> >                          network@81c00000 {
> >                                  compatible =3D=20
> "xlnx,xps-ll-temac-1.00.a",
> > "xlnx,xps-ll-temac";
>=20
> Drop "xlnx,xps-ll-temac"; it's 100% made up.  This should be simply:
>       compatible =3D "xlnx,xps-ll-temac-1.00.a" for version 1.00.a and
>       compatible =3D
> "xlnx,xps-ll-temac-<version>","xlnx,xps-ll-temac-1.00.a" for a future
> version if it maintains register level compatibility.
>=20
> "xlnx,xps-ll-temac" is far to ambiguous.

What if it was: compatible =3D "xlnx,xps-ll-temac-1.00.a",
"xlnx,xps-ll-temac-1"?

Basically, I don't want to be responsible for declaring what versions of
IP are backward compatible with ll-temac-1.00.a, and I think it's bad
software design to put that list into the dts generator anyway.  In
theory, at least, all ip with the same major version should be
compatible.

> >                                  interrupt-parent =3D <&xps_intc_0>;
> >                                  interrupts =3D < 3 0 >;
> >                                  llink-connected =3D <&PIM3>;
>=20
> What's this property for?

So that the ll_temac knows whether to use dma or fifo code and where the
dma or fifo control/interrupts are.

>=20
> >                                  reg =3D < 81c00000 40 >;
>=20
> If these registers are addressable, then the parent needs a=20
> 'ranges' property.

I thought ranges weren't necessary in a 1:1 mapping?

> >                                  xlnx,bus2core-clk-ratio =3D <1>;
> >                                  xlnx,phy-type =3D <1>;
> >                                  xlnx,phyaddr =3D <1>;
> >                                  xlnx,rxcsum =3D <0>;
> >                                  xlnx,rxfifo =3D <1000>;
> >                                  xlnx,temac-type =3D <0>;
> >                                  xlnx,txcsum =3D <0>;
> >                                  xlnx,txfifo =3D <1000>;
>=20
> Would be nice to have a 'phy-handle' property as that is what is being
> used on other platforms; but that's not something that EDK knows
> about.  It would be nice to have a way to tell EDK what PHY device is
> on the board so it could generate the appropriate mdio and phy nodes.

Yeah, this is going to be a big issue, I think...
