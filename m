Date: Thu, 13 Jul 2000 07:12:16 -0700
From: Matt Porter <mmporter@home.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Adrian Cox <apc@agelectronics.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Message-ID: <20000713071216.C264@cx258813-a.chnd1.az.home.com>
References: <20000712071604.C28921@cx258813-a.chnd1.az.home.com> <Pine.HPX.4.10.10007131339330.9548-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10007131339330.9548-100000@gra-ux1.iram.es>; from paubert@iram.es on Thu, Jul 13, 2000 at 01:43:49PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 13, 2000 at 01:43:49PM +0200, Gabriel Paubert wrote:
>
>
> On Wed, 12 Jul 2000, Matt Porter wrote:
>
> > > Residual data is useful for things like finding the memory size, and for
> > > chips designed inside Apple. For almost everything else Linux already
> > > contains a device tree, built by PCI probing when the kernel boots^*. I
> > > don't see much need for a parallel, architecture specific, device tree.
> >
> > Whoa...you mentioned the key phrase here...it's really only useful or
> > required for chips design inside Apple where you can't get documentation.
> > "Residual data" and defined in the PReP spec is only found on PReP systems
> > where all the hardware is fully documented so it's easy to size the
> > memory by other means.  It's not that hard to read board registers or
> > the memory controller setup.
>
> Indeed, but there is one thing which is very hard to guess: interrupt
> routing (due to the utterly stupid original Intel/IBM design which was
> obsolete already before Neanderthal).

Not just hard to guess...impossible.  That's one piece of board specific
information that you must provide somewhere.  The PReP port provides it
in a table as you know...all firmware has tables for each board's local
bus that is supported.  Although many of those tables are incorrect,
the information is public and it can be fixed (I just found some errors
in the Utah map since I have one of those at home).

> Actually very similar boards may have quite different interrupt routing
> and break an unsuspecting kernel. I also hate all these tables with magic
> values in the kernel (beside the fact that they don't work with
> multifunction boards).
>
> > I can see why the Mac folks have to deal with the broken OF device tree.
> >
> > A architecture specific (PPC) device tree (or residual data, if you will)
> > would be part of a "standard" OpenSource firmware project.  It's only
> > use would be to provide information for board bringup, etc.  It has it's
> > advantages and disadvantages...
>
> For ISA devices and interrupt routing, I consider it a big plus... For PCI
> devices just ignore it if present.

If only we could kill off ISA...I about passed out when I got a newly
designed PPC750 CPCI board with an Acer Labs PCI-ISA bridge. :-/

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
