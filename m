Date: Wed, 2 Oct 2002 10:03:12 -0700
From: Matt Porter <porter@cox.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021002100312.A2240@home.com>
References: <20021002014219.GF1848@zax> <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com> <20021002053422.GL1848@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021002053422.GL1848@zax>; from david@gibson.dropbear.id.au on Wed, Oct 02, 2002 at 03:34:22PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 02, 2002 at 03:34:22PM +1000, David Gibson wrote:
>
> On Tue, Oct 01, 2002 at 09:26:18PM -0700, Allen Curtis wrote:
> >
> > > That's right.  Is there a reason for boards to have different
> > > mappings?  I can well believe that there is, but the current tree
> > > doesn't show it - all the boards (in the tree) that have PCI appear to
> > > do the same initialisation of the windows.  It doesn't seem worthwhile
> > > to create board specific PCI initialisation hooks until we have a
> > > board that needs it.
> >
> > If all boards are suppose to have the same mapping, why doesn't someone
> > document it as such? It would have saved me a lot of time. If it isn't a
> > good enough rule to be documented then make the system flexible enough to
> > take a different path if required. (proactive)
>
> Um, well... I can't immediately think of a logical place to document
> this.  It seems logical to me that the PCI setup should be handled by
> the driver for the PCI bridge - which is common between the boards.
> This could be seen as a first step of changing PCI from a special
> system handled platform wide, to making the PCI bridge just another
> gadget in the device tree.
>
> There's no particular reason the mapping has to be the same between
> boards, but I can't think of any particular reason you'd want it to be
> different (maybe I just haven't seen a wacky enough board).

That's exactly the problem.  If your world is filled with the
standard IBM reference platforms then a simple single host PCI
bridge in "CHRP-style" mapping probably seems reasonable.

In reality, it's necessary to design PCI host bridge library
code such that it can be called in a board-specific way to allow
for window mappings in "wacky" systems with 2 or more PCI connected
processors.  This is very common.

This is where the current flow of having a common thread of excecution
falls apart (ppc4xx_setup).  40x really should be following the model
of the embedded 7xx/74xx system where each <board>.c would call to a
PCI library with some parameters to set up a desired set of window
mappings.  It's possible to have a default common case to set up
a CHRP-like mapping.

We've had some threads in the past about the limitations of using
this "common flow" design in 4xx.  I believe there was some agreement
that it is a limiting way to do things.  I do recall that Dan said
it was only this way because he copied the 826x flow and it probably
didn't make sense anymore for 4xx.  If there's no serious objections
I'm suggesting that this is where we go in the 2.5 4xx reorg.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
