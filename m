Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id D60FFDDE43
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 13:47:08 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so634510anc
	for <linuxppc-dev@ozlabs.org>; Sun, 02 Dec 2007 18:47:07 -0800 (PST)
Message-ID: <fa686aa40712021847k21a9a360u9fc2b887c9db49c7@mail.gmail.com>
Date: Sun, 2 Dec 2007 19:47:07 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Xilinx EDK BSP generation of device trees for microblaze and
	PowerPC
In-Reply-To: <20071126214459.627E7AB004D@mail132-cpk.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071120194411.E183B100060@mail17-sin.bigfish.com>
	<20071125062456.ABA4AA4804E@mail64-cpk.bigfish.com>
	<fa686aa40711251447t57f96dd4iba51d68e1c9a9c5c@mail.gmail.com>
	<20071126214459.627E7AB004D@mail132-cpk.bigfish.com>
Cc: Jon Loeliger <jdl@jdl.com>, microblaze-uclinux@itee.uq.edu.au,
	Michal Simek <simekm2@fel.cvut.cz>, linuxppc-dev@ozlabs.org,
	git <git@xilinx.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bah; I wrote this email about a week ago, but never sent it.  Sorry.

g.

On 11/26/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> I've pushed the current state up to
> git://git.xilinx.com/gen-mhs-devtree.git for your perusing.  Comments
> below.
>
> > -----Original Message-----
> > From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On
> > Behalf Of Grant Likely
> > Sent: Sunday, November 25, 2007 2:47 PM
> > To: Stephen Neuendorffer; Segher Boessenkool; David Gibson;
> > Jon Loeliger
> > Cc: microblaze-uclinux@itee.uq.edu.au;
> > linuxppc-dev@ozlabs.org; Michal Simek; git
> > Subject: Re: Xilinx EDK BSP generation of device trees for
> > microblaze and PowerPC
> >
> > On 11/24/07, Stephen Neuendorffer
> > <stephen.neuendorffer@xilinx.com> wrote:
> > >
> >
> > Thanks for all this work; comments below.
> >
> > >
> > > Here's what I've gotten so far:
> > >
> > >                  Hard_Ethernet_MAC: xps-ll-temac@81c00000 {
> > >                          #address-cells = <1>;
> > >                          #size-cells = <1>;
> > >                          network@81c00000 {
> > >                                  compatible =
> > "xlnx,xps-ll-temac-1.00.a",
> > > "xlnx,xps-ll-temac";
> >
> > Drop "xlnx,xps-ll-temac"; it's 100% made up.  This should be simply:
> >       compatible = "xlnx,xps-ll-temac-1.00.a" for version 1.00.a and
> >       compatible =
> > "xlnx,xps-ll-temac-<version>","xlnx,xps-ll-temac-1.00.a" for a future
> > version if it maintains register level compatibility.
> >
> > "xlnx,xps-ll-temac" is far to ambiguous.
>
> What if it was: compatible = "xlnx,xps-ll-temac-1.00.a",
> "xlnx,xps-ll-temac-1"?

Here's what I've learned: There is no such thing as a perfect device
tree.  Either hardware bugs will be discovered at a later date which
make compatible inaccurate, or a better understanding of the device
will come along which will change the understood best practices for
describing the device.

My opinion is the best strategy against claiming something that's not
true, or won't be true in the fucture, is to strive for uniqueness and
describe only what you are certain of.  Be conservative instead of
liberal in the compatible case; ie. it's easier to teach the driver
about other versions it can bind against than it is to teach it about
exceptions to certain versions of the hardware (when binding).

In this particular case the problem still stands that the VHDL
engineer may make a non backward compatible change in version
xlnx,xps-ll-temac-1.00.c or -1.03.c.  You just don't know until it
happens.  Stick with what is known and don't try to extrapolate to a
'generic' version when there is no guarantee that it will remain
generic.

When sticking with real version numbers, it is quite safe to claim
compatibility with an older version number because you've probably
tested it; something which isn't so safe when you attempt to make up
generic versions.

>
> Basically, I don't want to be responsible for declaring what versions of
> IP are backward compatible with ll-temac-1.00.a, and I think it's bad
> software design to put that list into the dts generator anyway.  In
> theory, at least, all ip with the same major version should be
> compatible.

Yes, but at the point of releasing, you've probably tested it so the
risk is very low.

>
> > >                                  interrupt-parent = <&xps_intc_0>;
> > >                                  interrupts = < 3 0 >;
> > >                                  llink-connected = <&PIM3>;
> >
> > What's this property for?
>
> So that the ll_temac knows whether to use dma or fifo code and where the
> dma or fifo control/interrupts are.
>
> >
> > >                                  reg = < 81c00000 40 >;
> >
> > If these registers are addressable, then the parent needs a
> > 'ranges' property.
>
> I thought ranges weren't necessary in a 1:1 mapping?

At the very least there needs to be an empty 'ranges' property in
order for it to work

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
