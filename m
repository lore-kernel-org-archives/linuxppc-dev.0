Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 582F0DE0B2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:31:11 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9C3V9u2004733
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:31:09 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9C3YidH210658
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:34:44 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9C3UrqB005995
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:30:54 +1000
Date: Fri, 12 Oct 2007 13:14:49 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
Message-ID: <20071012031449.GE21056@localhost.localdomain>
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
	<1192048682.5534.92.camel@localhost.localdomain>
	<20071011013817.GB14873@localhost.localdomain>
	<fa686aa40710101925x6b005aa7paaeb072ba492c81f@mail.gmail.com>
	<20071011040622.GE14873@localhost.localdomain>
	<fa686aa40710102118p3e62d06eqff8db252772eb58c@mail.gmail.com>
	<20071011042441.GG14873@localhost.localdomain>
	<fa686aa40710102158r5d488d3kae3d02177625da1e@mail.gmail.com>
	<20071011050850.GI14873@localhost.localdomain>
	<fa686aa40710102227j474a4025p6f3aa7118adf03db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710102227j474a4025p6f3aa7118adf03db@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2007 at 11:27:14PM -0600, Grant Likely wrote:
> On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> > > My main concern is that I don't like the implicit numbering that
> > > occurs simply based on the order of devices in the device tree.  If
> > > the probe algorithm ever changes to parse in reverse order or
> > > something reorders the tree, then the device numbers also change.  :-(
> >
> > Way of the future, apparently, everything's supposed to use udev to
> > give things logical names.  No, I'm not thrilled at the prospect
> > either.
> 
> ...
> 
> So in the OF aliases approach, would udev need to read the aliases
> node when assigning names to devices?

Well... maybe.  Exactly how to sensibly propogate the information up
to userspace depends on the type of device and other factors.  In most
cases I'd expect some kind of kernel intermediary between the device
tree and udev, but there might be instances where it would make sense
for udev to directly access /proc/device-tree/aliases via a helper
program.

In any case, if the kernel does provide some sort of name/number for
the device, you can use the aliases for that.

> > > I'd rather be explicit.  In fact I've already been bitten by this
> > > where the mpc5200 has 6 PSC, each of which can be configured as a
> > > serial port.  However, I've got access to 3 different boards; each of
> > > which has the logical port numbers 100% unrelated to the 'cell'
> > > number.
> >
> > In any case, this can't really belong in a *device* binding.  Because
> > the numbering has to cross devices of the same basic type, but
> > different implementations.  Where "basic type" is based on how device
> > names are allocated, and is thus inherently Linux specific.
> 
> Okay, that makes sense.
> 
> > > > Segher's suggestion of using OF-style aliases for this is a fairly
> > > > good one, actually.  I just need to get to implementing it...
> > >
> > > /me needs to look up what that look like and how I would use it.  My
> > > knowledge of OF is sadly lacking.
> >
> > Short version by example:
> > / {
> >         /* ... */
> >         aliases {
> >                 hd = "/pci@f0000000/sata@f4000000/....";
> >                 enet0 = "/soc/ethernet@c000";
> >                 enet1 = "/soc/ethernet@d000";
> >                 enet2 = "/pci@f0000000/isa/ethernet@i480"
> >                 ttya = "/soc/serial@e000";
> >                 ttyb = "/pci/isa/serail@3f8";
> >         }
> > }
> 
> Ah, my plan worked...  I got you to teach me about OF aliases and I
> have to do any work myself.  :-)

Well, be careful, and take that example with a grain of salt.  I made
it up on the spot without checking a lot, so although it gives you the
general idea, I probably haven't followed conventions for the names of
the aliases and so forth.

> Hmm, yes that would provide the information nicely.  As long as the
> data is in the tree, I'm pretty happy.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
