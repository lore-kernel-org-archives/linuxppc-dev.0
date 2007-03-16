Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 11:09:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070316000939.GC6784@localhost.localdomain>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<20070314063546.GH25514@localhost.localdomain>
	<20070314165921.GC10075@ld0162-tx32.am.freescale.net>
	<20070314235625.GC12573@localhost.localdomain>
	<20070315164037.GA21194@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315164037.GA21194@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 11:40:37AM -0500, Scott Wood wrote:
> On Thu, Mar 15, 2007 at 10:56:25AM +1100, David Gibson wrote:
> > On Wed, Mar 14, 2007 at 11:59:21AM -0500, Scott Wood wrote:
> > > Sure...  This is solely a compatibility hack to keep the kernel from
> > > regressing with respect to which firmware it boots on when moving from
> > > arch/ppc to arch/powerpc.  It's not intended to be a model for how things
> > > should be done when one has control over the firmware.
> > 
> > Yeah, but there's a lot of arch/ppc boards which can boot from old
> > u-boots to be ported over eventually.
> 
> Hence why I didn't want to have to have per-board glue. :-)

> I could live with per SOC family though, as the number of those is
> manageable.

Again, when I say "per board" it should read "per group of
sufficiently similar boards".  For the boards you're handling, that
corresponds to per SOC family, though it doesn't always.
"sufficiently similar" is determined by the zImage's needs, of course,
so includes firmware interface details, and any specific hardware
tweaks that are necessary (which doesn't appear to be any for the
boards you're considering).

> >  I just see this as the nucleus of exactly the same sort of tangled
> > mess we have in arch/ppc.  Even if it only covers the old boards in
> > arch/ppc not newer ones, it's still bad enough.
> 
> It's not even "old boards"; it's "old boards with old firmware".

But any old board can have old firmware, more-or-less by definition.

> > People copy bad examples, even when they're not intended as good
> > examples.
> 
> How about a big warning on top of cuboot.c and ppcboot.h, saying that
> it's a compatibility hack only, and nobody should imitate it unless they
> absolutely have to (i.e. they're also dealing with compatibility issues)?

Well, yes, but I think we can do it right at little extra effort, and
it will make life easier for extending your support to other old
boards.  I've got a patch in the works, which rearranges your code in
the way I think is more sensible.  Since I have no boards to test, it
almost certainly won't actually work but should demonstrate what I'm
talking about.  Soon, I hope, I got a bit sidetracked fixing some
other things in the zImage while I was at it.

> > > If you want to get the MAC address, you'll still need the ifdef mess (or
> > > a per-target offset list, which strikes me as being more error-prone). 
> > 
> > Why so?  If the board .c defines the board's specific bd_t..
> 
> OK, or a manual board-specific extraction of the bd_t from the
> ifdef-tangle that is the authoritative source.  Either way, it seems to
> me that the most robust means of getting exactly the same struct as
> u-boot uses is to use the same struct, and define the same defines.

Actually, I'm not sure that's necesssarily so, odd though it may seem.
We're considering only old, fixed, versions of u-boot here, not trying
to track u-boot changes.  Which means once we have the bd_t right for
a board, it's *right* and is actually more robust against someone
adding more #ifdefs to the structure for a new board and accidentally
screwing things up for an existing board.

> > Ew.  As I say below, a per-board (or per-soc) table can give you this
> > information.  Or, we could define a "linux,network-index" property to
> > give the right ordering.
> 
> I like the linux,network-index method.  The less shared information to
> maintain, the better.

Ok, let's do that then.  It certainly has the advantage of leveraging
the existing device tree data structure, rather than creating a new
one.

> > Sorry, when I've said "per-board" you can substitute "per-soc" when
> > there are no relevant devices outside the soc.
> 
> OK.
> 
> > And the fact is you *do* have per-board glue; that's what it means to
> > have #ifdefs all over the place.
> 
> I meant actual boards, not the broad chip families that are currently
> ifdeffed.
> 
> > > > Does the path of the "soc" node actually vary?
> > > 
> > > Yes, unfortunately -- the chip model number is in the node name (rather
> > > than in compatible or model or someplace sensible like that).
> > 
> > Eck.  Again per-soc tables can address this without the need to define
> > the new finddevice_rel() interface hook.
> 
> That'd force there to be separate tables for every specific model, rather
> than 83xx, 85xx, etc.  Plus, it seems like a generally useful thing to
> have, and as long as it isn't used from non-platform code, it doesn't
> need to be implemented by platforms that don't use it.

Hrm.  I dislike the idea of having hook methods that are only
implemented on some platforms (although I guess, realistically, we're
only ever going to have 2 sets of device tree methods; OF and flat
tree).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
