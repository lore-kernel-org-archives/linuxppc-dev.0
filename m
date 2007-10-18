Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 50398DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:06:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3] Device tree bindings for Xilinx devices
Date: Thu, 18 Oct 2007 12:04:59 -0700
In-Reply-To: <fa686aa40710181112pbe37a18xb21b7c5bcbe973b6@mail.gmail.com>
References: <20071018172259.14948.74736.stgit@trillian.cg.shawcable.net>
	<20071018174956.05D7A1AA008D@mail197-blu.bigfish.com>
	<fa686aa40710181112pbe37a18xb21b7c5bcbe973b6@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071018190555.8EE7177805F@mail76-sin.bigfish.com>
Cc: Leonid <Leonid@a-k-a.net>, Arnd Bergmann <arnd@arndb.de>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	Wolfgang Reissnegger <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Thursday, October 18, 2007 11:13 AM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org; Wolfgang Reissnegger; Leonid;=20
> microblaze-uclinux@itee.uq.edu.au; Josh Boyer; Arnd Bergmann
> Subject: Re: [PATCH v3] Device tree bindings for Xilinx devices
>=20
> On 10/18/07, Stephen Neuendorffer=20
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> > > -----Original Message-----
> > > From: Grant Likely [mailto:grant.likely@secretlab.ca]
> > > Sent: Thursday, October 18, 2007 10:23 AM
> > > To: linuxppc-dev@ozlabs.org; Stephen Neuendorffer; Wolfgang
> > > Reissnegger; Leonid; microblaze-uclinux@itee.uq.edu.au; Josh
> > > Boyer; Arnd Bergmann
> > > Subject: [PATCH v3] Device tree bindings for Xilinx devices
> > >
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >
> > Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> >
> > This is good enough for the moment, and it reflects the=20
> best we can do
> > right now...  But:
> >
> > > +     (parameter#):   C_* parameters from system.mhs.  The C_
> > > prefix is
> > > +                     dropped from the parameter name, the
> > > name is converted
> > > +                     to lowercase and all underscore '_'
> > > characters are
> > > +                     converted to dashes '-'.
> >
> > Unfortunately, xparameters don't follow this exactly,=20
> particularly for
> > the 'multiple logical devices' case...  Maybe it's worth adding
> > something like: "For simple devices, the parameter name can=20
> be formed
> > by:"
>=20
> What specific parts of this are you concerned about? Examples?

Imagine if the ps2 adapter had a parameter "FOO" for each logical
device, In the core, one would be named C_PORT_0_FOO and another
C_PORT_1_FOO.  But, of course, you would want the FOO parameters to be
unmangled in the correct way for each port (as your hierarchical example
shows, but without any parameters).  In the xparameters, this unmangling
has been done, and the xparameters would look something like
XPAR_PS2_0_FOO and XPAR_PS2_1_FOO.

In other cases, xparameters for one core might be extracted from another
core that it is connected to, and in fact might reflect how the two are
connected.  This is how some cores under development will work (in EDK
9.2).

In short, I think its better to think about this all relative to
xparameters, rather than relative to the .mhs file.  In all current
cases, this is (I think) the same, but in the (very near future) it
won't be.

> > In any event, this should essentially document what the=20
> mechanism for
> > generating the device trees actually does...  Have you updated
> > gen_mhs_devtree.py to reflect all this?
>=20
> No; I'm looking at this as a line in the sand that we can use as a
> starting point and discuss the issues.

OK...  Well, as far as I'm concerned it looks good enough that we should
try it out... :)   I'll hack up gen_mhs_devtree and see how far we get.

> > > +   Typically, the compatible list will include the exact IP
> > > core version
> > > +   followed by an older IP core version which implements the same
> > > +   interface or any other device with the same interface.
> >
> > This seems to be awkward, since it means that the tree=20
> *and* the driver
> > will likely have long lists of compatible types.  In the=20
> driver, this is
> > hard to maintain, and in the device tree we don't have an=20
> easy way of
> > knowing exactly what is compatible and what isn't anyway...=20
>  It seems
> > better to me to have the
> > compatible list include the exact type (e.g.=20
> xilinx,opb-uartlite-1.00.b)
> > and
> > a generic compatibility class (e.g. xilinx,uartlite), and for the
> > drivers
> > to essentially define the gross compatibility classes. =20
> Then the driver
> > only has an of_match with:
> >
> >  .compatible =3D "xilinx,uartlite"
>=20
> The problem with this is how do you define what "xilinx,uartlite" is?
> For example; there have been 3 major versions of the plb_temac, and
> IIRC v2 and v3 are *not* compatible.  Which one is xilinx,temac?
>=20
> However, this does not need to result in a long list.  Basically, the
> list should include the exact version of the device plus the first
> version that implemented that interface.  (hence it is "compatible"
> with the earlier version of the device).  If there are no prior
> devices implementing the same device, then the compatible list has
> exactly one instance.  This document should probably include a list of
> the well-known compatible values for each of the xilinx devices.
>=20
> I used to try and come up with generic values for compatible, but it
> just ends up causing problems in the long run.  The concept of what is
> generic changes over time, but a specific version is a known quantity.

OK... I'll buy it... :)  I missed the emphasis on the 'sparseness'...
And I agree about the versions being really canonical: we just need to
make sure that the actual versions that are critical get back in at some
point.

Steve
