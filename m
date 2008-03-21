Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 02ECCDDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:14:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx
	uart16550.
Date: Fri, 21 Mar 2008 09:14:57 -0700
In-Reply-To: <fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com><20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, "John Linn" <linnj@xilinx.com>
Message-Id: <20080321161421.AAFD2518061@mail63-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of =
Grant
Likely
> Sent: Thursday, March 20, 2008 5:19 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for
Xilinx uart16550.
>=20
> On Thu, Mar 20, 2008 at 8:43 AM, John Linn <john.linn@xilinx.com>
wrote:
> > The Xilinx 16550 uart core is not a standard 16550, because it uses
> >  word-based addressing rather than byte-based addressing.  As a
result,
> >  it is not compatible with the open firmware 'ns16550' compatible
> >  binding.  This code introduces new bindings, which pass the correct
> >  register base and regshift properties to the uart driver to enable
> >  this core to be used.  Doing this cleanly required some refactoring
of
> >  the existing code.
>=20
> Personally, I'm not fond of this approach.  There is already some
> traction to using the reg-shift property to specify spacing, and I
> think it would be appropriate to also define a reg-offset property to
> handle the +3 offset and then let the xilinx 16550 nodes use those.

Since the ePAPR ns16550 defines reg-shift, I don't think it makes sense
to have a separate binding for sparse16550, or for the xilinx16550
types.  Personally, I like having reg-offset better than
adding three to the reg space, but I leave that up to someone who is
much more involved in ePAPR.

> >  +static struct of_serial_info __devinitdata ns8250_info =3D { .type =
=3D
PORT_8250 };
> >  +static struct of_serial_info __devinitdata ns16450_info =3D { =
.type
=3D PORT_16450 };
> >  +static struct of_serial_info __devinitdata ns16550_info =3D { =
.type
=3D PORT_16550 };
> >  +static struct of_serial_info __devinitdata ns16750_info =3D { =
.type
=3D PORT_16750 };
> >  +static struct of_serial_info __devinitdata xilinx_16550_info =3D {
> >  +       .type =3D PORT_16550,
> >  +       .regshift =3D 2,
> >  +       .regoffset =3D 3,
> >  +};
> >  +static struct of_serial_info __devinitdata unknown_info =3D { =
.type
=3D PORT_UNKNOWN };
>=20
> In support of my argument; the fact that you need a table of data says
> to me that this data should really be encoded in the device tree.  :-)

The table of data was always there to bind the UART types, I just added
some more info to it.

Steve
