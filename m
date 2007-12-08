Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CE100DDE2C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 12:01:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx EDK BSP generation of device trees for microblaze and
	PowerPC
Date: Fri, 7 Dec 2007 16:58:13 -0800
In-Reply-To: <fa686aa40712021847k21a9a360u9fc2b887c9db49c7@mail.gmail.com>
References: <20071120194411.E183B100060@mail17-sin.bigfish.com>
	<20071125062456.ABA4AA4804E@mail64-cpk.bigfish.com>
	<fa686aa40711251447t57f96dd4iba51d68e1c9a9c5c@mail.gmail.com>
	<20071126214459.627E7AB004D@mail132-cpk.bigfish.com>
	<fa686aa40712021847k21a9a360u9fc2b887c9db49c7@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071208005649.5EEAB30804C@mail3-sin.bigfish.com>
Cc: microblaze-uclinux@itee.uq.edu.au, git <git@xilinx.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> > > -----Original Message-----
> > > From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On
> > > Behalf Of Grant Likely
> > > Sent: Sunday, November 25, 2007 2:47 PM
> > > To: Stephen Neuendorffer; Segher Boessenkool; David Gibson;
> > > Jon Loeliger
> > > Cc: microblaze-uclinux@itee.uq.edu.au;
> > > linuxppc-dev@ozlabs.org; Michal Simek; git
> > > Subject: Re: Xilinx EDK BSP generation of device trees for
> > > microblaze and PowerPC
> > >
> > > On 11/24/07, Stephen Neuendorffer
> > > <stephen.neuendorffer@xilinx.com> wrote:
> > > >
> > >
> > > Thanks for all this work; comments below.
> > >
> > > >
> > > > Here's what I've gotten so far:
> > > >
> > > >                  Hard_Ethernet_MAC: xps-ll-temac@81c00000 {
> > > >                          #address-cells =3D <1>;
> > > >                          #size-cells =3D <1>;
> > > >                          network@81c00000 {
> > > >                                  compatible =3D
> > > "xlnx,xps-ll-temac-1.00.a",
> > > > "xlnx,xps-ll-temac";
> > >
> > > Drop "xlnx,xps-ll-temac"; it's 100% made up.  This should=20
> be simply:
> > >       compatible =3D "xlnx,xps-ll-temac-1.00.a" for version=20
> 1.00.a and
> > >       compatible =3D
> > > "xlnx,xps-ll-temac-<version>","xlnx,xps-ll-temac-1.00.a"=20
> for a future
> > > version if it maintains register level compatibility.
> > >
> > > "xlnx,xps-ll-temac" is far to ambiguous.
> >
> > What if it was: compatible =3D "xlnx,xps-ll-temac-1.00.a",
> > "xlnx,xps-ll-temac-1"?
>=20
> Here's what I've learned: There is no such thing as a perfect device
> tree.  Either hardware bugs will be discovered at a later date which
> make compatible inaccurate, or a better understanding of the device
> will come along which will change the understood best practices for
> describing the device.
>=20
> My opinion is the best strategy against claiming something that's not
> true, or won't be true in the fucture, is to strive for uniqueness and
> describe only what you are certain of.  Be conservative instead of
> liberal in the compatible case; ie. it's easier to teach the driver
> about other versions it can bind against than it is to teach it about
> exceptions to certain versions of the hardware (when binding).
>=20
> In this particular case the problem still stands that the VHDL
> engineer may make a non backward compatible change in version
> xlnx,xps-ll-temac-1.00.c or -1.03.c.  You just don't know until it
> happens.  Stick with what is known and don't try to extrapolate to a
> 'generic' version when there is no guarantee that it will remain
> generic.
>=20
> When sticking with real version numbers, it is quite safe to claim
> compatibility with an older version number because you've probably
> tested it; something which isn't so safe when you attempt to make up
> generic versions.

I think you've convinced me... :)  I think the only reason to ever put
more than one thing in the compatible list, is if you want to declare
that you are compatible with an established, standard driver and you
don't have control over the driver.  ns16550 is a great example of this,
where it is so ubiquitous that the driver is likely to be much more
stable over time than any particular hardware.

I did some quick scripting around in various versions of EDK.  For the
record, Xilinx shipped about 369 distinct versions of processor IP with
the EDK, since EDK 6.3:
    369     /home/stephenn/iplist_combined

And there's obviously alot of overlap between the different versions:
    202     EDK 6.3
    227     EDK 7.1
    268     EDK 8.2
    297     EDK 9.2

But the total number of drivers is much smaller:
     87      EDK 6.3
     91      EDK 7.1
     86      EDK 8.2
    112      EDK 9.2

And it appears that there are a relatively small number of changes which
the drivers claim are not forwards compatible (not to say that there
aren't other incompatibilities, but this is the compatibility that we
can infer based on what the drivers claim).

opb_ethernet_v1_01_a -> opb_ethernet_v1_02_a -> opb_ethernet_v1_04_[a-z]
opb_ethernetlite_v1_00_a -> opb_ethernetlite_v1_01_a
opb_pci_v1_00_c -> opb_pci_v1_01_a
plb_temac_v2_00_a -> plb_temac_v3_00_a
opb_deltasigma_dac_v1_00_a -> opb_deltasigma_dac_v1_01_a
opb_deltasigma_adc_v1_01_a -> opb_deltasigma_dac_v1_01_a
opb_hwicap_v1_00_b -> opb_hwicap_v1_10_a

In any event, my plan is to put only the exact version name in the
device tree and list all the compatible versions in the driver match.

Steve
