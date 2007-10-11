Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5DCBDDDFD7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:09:45 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9B59Npi020793
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:09:23 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9B59Our4477016
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:09:24 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9B598A2012599
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:09:08 +1000
Date: Thu, 11 Oct 2007 15:08:50 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
Message-ID: <20071011050850.GI14873@localhost.localdomain>
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
	<1192048682.5534.92.camel@localhost.localdomain>
	<20071011013817.GB14873@localhost.localdomain>
	<fa686aa40710101925x6b005aa7paaeb072ba492c81f@mail.gmail.com>
	<20071011040622.GE14873@localhost.localdomain>
	<fa686aa40710102118p3e62d06eqff8db252772eb58c@mail.gmail.com>
	<20071011042441.GG14873@localhost.localdomain>
	<fa686aa40710102158r5d488d3kae3d02177625da1e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710102158r5d488d3kae3d02177625da1e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2007 at 10:58:25PM -0600, Grant Likely wrote:
> On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> > On Wed, Oct 10, 2007 at 10:18:50PM -0600, Grant Likely wrote:
> > > On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> > > > On Wed, Oct 10, 2007 at 08:25:36PM -0600, Grant Likely wrote:
> > > > > On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> > > > > > We've used 'cell-index' for similar purposes on other 4xx.
> > > > >
> > > > > Unfortunately, 'cell' has been used in the sense of a logic cell in an
> > > > > SoC.  In the case of the SystemACE, it is an external chip.
> > > > >
> > > > > What about "device-number"?
> > > >
> > > > Ok, I misunderstood.  If it's not on chip, what significance does this
> > > > serial number have?  Where would a driver need it?
> > >
> > > If there were 2 systemace devices on board; one attached to a CF slot
> > > labeled "1" and the other to one labeled "2".  :-)  Same problem as
> > > lining up serial device files to physical port numbers.
> > >
> > > The driver doesn't technically need it, but the information does need
> > > to flow through to the creation of logically numbered device files.
> >
> > Ah.  Then, I'm afraid it doesn't belong in the core binding.
> >
> > Preferably, you should just figure out something without help of this
> > property - plenty of other things have to figure out device names
> > without assistance like this.
> 
> I'm not too stuck on the method used, but I do think it is appropriate
> to encode this kind of data in the device tree in some form...
> However, for this particular device I'm probably just borrowing
> trouble.  I'll drop the property.
> 
> My main concern is that I don't like the implicit numbering that
> occurs simply based on the order of devices in the device tree.  If
> the probe algorithm ever changes to parse in reverse order or
> something reorders the tree, then the device numbers also change.  :-(

Way of the future, apparently, everything's supposed to use udev to
give things logical names.  No, I'm not thrilled at the prospect
either.

> I'd rather be explicit.  In fact I've already been bitten by this
> where the mpc5200 has 6 PSC, each of which can be configured as a
> serial port.  However, I've got access to 3 different boards; each of
> which has the logical port numbers 100% unrelated to the 'cell'
> number.

In any case, this can't really belong in a *device* binding.  Because
the numbering has to cross devices of the same basic type, but
different implementations.  Where "basic type" is based on how device
names are allocated, and is thus inherently Linux specific.

> > If you really must you could do this in analogy with the
> > "linux,network-index" property - but this would be, as that is, an
> > ugly hack, and should be recognized as such
> >
> > Segher's suggestion of using OF-style aliases for this is a fairly
> > good one, actually.  I just need to get to implementing it...
> 
> /me needs to look up what that look like and how I would use it.  My
> knowledge of OF is sadly lacking.

Short version by example:
/ {
	/* ... */
	aliases {
		hd = "/pci@f0000000/sata@f4000000/....";
		enet0 = "/soc/ethernet@c000";
		enet1 = "/soc/ethernet@d000";
		enet2 = "/pci@f0000000/isa/ethernet@i480"
		ttya = "/soc/serial@e000";
		ttyb = "/pci/isa/serail@3f8";
	}
}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
