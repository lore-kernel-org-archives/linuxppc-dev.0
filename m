Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 61C29DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 11:23:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
Date: Mon, 17 Dec 2007 16:22:56 -0800
In-Reply-To: <fa686aa40712170719o29da3caew43d65225feea9ba@mail.gmail.com>
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
	<fa686aa40712170719o29da3caew43d65225feea9ba@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071218002143.6C141190077@mail8-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I've updated the generator based on the below feedback.  I'll also send
around the updated patch for this section briefly.  Comments below.

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
> Grant Likely
> Sent: Monday, December 17, 2007 7:20 AM
> To: Stephen Neuendorffer
> Cc: simekm2@fel.cvut.cz; jwilliams@itee.uq.edu.au; linuxppc-
> dev@ozlabs.org; David Gibson
> Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
>=20
> > -       (name)@(base-address) {
> > +       (name): (ip-core-name)@(base-address) {
>=20
> (name): (generic-name)@(base-address) {

In most cases it now does this.  In the default case for ip which is not
recognized, it falls back to the ip-core-name.

> > -       opb_ps2_dual_ref_0@a9000000 {
> > +       opb_ps2_dual_ref_0: opb-ps2-dual-ref@a9000000 {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               compatible =3D "xlnx,compound";
> >                 ranges =3D <0 a9000000 2000>;
> >                 // If this device had extra parameters, then they
would
> >                 // go here.
> > -               ps2@0 {
> > +               opb-ps2-dual-ref@0 {
>=20
> According to the generic names recommendation, this should be either
> "keyboard@0" or "mouse@0", but of course the two interfaces are
> identical and EDK doesn't have any information about how they are
> used.  Perhaps the node name should be: "ps2@0".  David, thoughts?

I don't think keyboard or mouse really makes sense here.  Went with ps2.

> > -       plb-v34-0 {
> > +       plb_v34 {
>=20
> Steve, when I wrote this I was lazy and I didn't add the bus address.
> However, if we don't have the base address I think we'll end up with
> name collisions (especially in the MPMC case).  So, based on generic
> names convention, this should probably simply be "plb@<baseaddr>".

I wondered at one point if this would be a problem... in any event, you
now get the baseaddress.

> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <1>;
> > +               compatible =3D "xlnx,plb-v34-1.02.a";
> >                 device_type =3D "ibm,plb";
> >                 ranges; // 1:1 translation
> >
> > -               plb-bram-if-cntrl-0@ffff0000 {
> > +               plb_bram_if_cntrl_0: plb-bram-if-cntrl@ffff0000 {
>=20
> Node name should probably just be "bram@ffff0000" here.

What actually gets generated is a memory node at the toplevel, which is
currently suppressed, since it appears that having disjoint memory
locations doesn't work.  If you have more than one 'real' memory
controller, such as an plb_emc connected to flash, then you currently
get the warning:

"Warning!: More than one memory found.  Note that most platforms don't
support non-contiguous memory maps!"

So, there is some divergence here, but I'm not too concerned about it
since the way that such memory might get used is still up for
discussion.

Also note that memory nodes which are not at the toplevel don't appear
to be detected.  Is this by intention or omission?

Obviously there is room for improvement here.  Having a some way to
leverage brams, in particular the dummy bram that you have to have at
high memory in order to get the ppc to boot would be nice!

Steve
