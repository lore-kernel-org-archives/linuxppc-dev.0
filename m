Date: Thu, 3 Oct 2002 08:14:39 -0700
From: Matt Porter <porter@cox.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: very minor 405GP and 405GPr PCI difference
Message-ID: <20021003081439.C4643@home.com>
References: <20021002014219.GF1848@zax> <NCBBIINEHIPFGJPLBEIFEEMFDMAA.acurtis@onz.com> <20021002053422.GL1848@zax> <20021002100312.A2240@home.com> <20021003011044.GB1102@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021003011044.GB1102@zax>; from david@gibson.dropbear.id.au on Thu, Oct 03, 2002 at 11:10:44AM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 03, 2002 at 11:10:44AM +1000, David Gibson wrote:
>
> On Wed, Oct 02, 2002 at 10:03:12AM -0700, Matt Porter wrote:
> > That's exactly the problem.  If your world is filled with the
> > standard IBM reference platforms then a simple single host PCI
> > bridge in "CHRP-style" mapping probably seems reasonable.
> >
> > In reality, it's necessary to design PCI host bridge library
> > code such that it can be called in a board-specific way to allow
> > for window mappings in "wacky" systems with 2 or more PCI connected
> > processors.  This is very common.
>
> Ok, I can see why you'd want a different PCI mapping for that.
>
> For boards like this, would it be sufficient for the generic code to
> set up PMM0 and PTM1 with the standard mapping, then let the board
> code use the remaining PMMs and PTMs for additional mappings?

In my book, that removes flexibility which is something I'm a
big believer in when it comes to embedded stuffs.  I'd prefer
to have something like:

	ibm_pci_init(<default_or_custom_map_flag>, <window_struct_ptr>)

If you want the default CHRP map you call like this:

	ibm_pci_init(IBM_PCI_DEFAULT_MAP, NULL);

If you want a custom map you fill out a window reg struct and do:

	ibm_pci_init(IBM_PCI_CUSTOM_MAP, &my_win_struct);

The implementation of the init function can be as simple as
just taking the values of the custom win struct and programming
verbatim into the PMMs and PTMs, or eventually one can get
fancy and provide a little more abstraction where one could
pass window start/end values and the code would do some range
checking a la pplus_common.c.

Since there's such an incredible amount of cleanup work to do
for 4xx, I think a bare bones back end implementation is more
than sufficient.  I should provide an example of this for
the 440gp/gx pcix logic, but having 440 stable seemed a bit
more important first. :)

> > This is where the current flow of having a common thread of excecution
> > falls apart (ppc4xx_setup).  40x really should be following the model
> > of the embedded 7xx/74xx system where each <board>.c would call to a
> > PCI library with some parameters to set up a desired set of window
> > mappings.  It's possible to have a default common case to set up
> > a CHRP-like mapping.
>
> I agree absolutely.  The current flow of control of the board stuff is
> a ghastly horrible mess.

Aha!  Good.

> > We've had some threads in the past about the limitations of using
> > this "common flow" design in 4xx.  I believe there was some agreement
> > that it is a limiting way to do things.  I do recall that Dan said
> > it was only this way because he copied the 826x flow and it probably
> > didn't make sense anymore for 4xx.  If there's no serious objections
> > I'm suggesting that this is where we go in the 2.5 4xx reorg.
>
> Quite.  In fact I recall suggesting a re-org along these lines some
> time ago, but then I got busy and didn't have time to actually send
> patches.  I seem to recall there was some resistance to such a re-org
> at the time.

Hrm, I will have to reread some of threads I saved.  I only recalled
some agreement from Dan that it probably didn't make sense any longer
and a tangential issue regarding the desire to build a single image
with multiple 4xx targets.  Something that I, incidentally, believe
is a waste of time since kernels can be built so quickly.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
