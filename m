Return-Path: <dgibson@ozlabs.org>
Date: Fri, 1 Aug 2008 13:30:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Board level compatibility matching
Message-ID: <20080801033009.GG5008@yookeroo.seuss>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<9e4733910807311349l5770a17ib2ab2535bcd2868a@mail.gmail.com>
	<20080731205251.GB29834@secretlab.ca>
	<9e4733910807311358k54b5c088l1023d354fd0ad28e@mail.gmail.com>
	<20080801024729.GA5008@yookeroo.seuss>
	<9e4733910807312006l8e83d27qe1b5ca5f50b89e39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807312006l8e83d27qe1b5ca5f50b89e39@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 11:06:20PM -0400, Jon Smirl wrote:
> On 7/31/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Thu, Jul 31, 2008 at 04:58:34PM -0400, Jon Smirl wrote:
> >  > On 7/31/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  > > On Thu, Jul 31, 2008 at 04:49:49PM -0400, Jon Smirl wrote:
> >  > >  > On 7/31/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  > >  > > This topic keeps coming up, so it is probably time to address it once
> >  > >  > >  and for all.
> >  > >  > >
> >  > >  > >  When it comes to machine level support in arch/powerpc, there seems to
> >  > >  > >  me that there are two levels or machine support.
> >  > >  > >
> >  > >  > ......
> >  > >  > >
> >  > >  > >  Thoughts?
> >  > >  > >  g.
> >  > >  >
> >  > >  >
> >  > >  > As part of this, how can we going to solve the problem with triggering
> >  > >  > the load of a board specific machine/fabric driver in a generic way?
> >  > >
> >  > >
> >  > > That really is a separate problem.  We *could* do this with a board
> >  > >  specific powerpc machine driver, but I don't think it is the best
> >  > >  solution.
> >  > >
> >  > >  I'm still thinking that the drivers module_init() function could check
> >  > >  the top level board model property and decide whether or not to load
> >  > >  based on that.
> >  >
> >  > You're assuming the driver is compiled in.
> >  >
> >  > If the drivers are on initrd selection has to happen via the normal
> >  > device/driver matching process. Search for a device in the alias table
> >  > of the drive file.
> >
> >
> > This can still be done via the board platform code.  The platform code
> >  creates a platform device which the driver can later bind to.
> 
> That is what I'm doing now. But it requires every board to add a file
> to arch/powerpc/platforms.  Can we have some common code to make the
> fabric device? Can it be an OF device instead of a platform one? An OF
> device could be compatible with boardname-fabric, generic-fabric. That
> allows a stub fabric driver to always bind.

There are several ways to do this, and which is the most sensible
depends on the specific design, and whether / how many boards the
design is shared amongst.

In some cases it's suitable to have a "fake" device node for the sound
wiring, to which a fabric driver can bind.  I think I've argued
against this approach in the past, but I've since been convinced that
it is a reasonable approach for some situations.  There's precedent,
too, a number of Apple device trees do this.

In other cases it may be possible to deduce the correct fabric driver
from the interconnections of individual sound components.

In yet others, we need board-specific platform code to instantiate the
fabric driver.  In some cases that's simply the most straightforward
way to do things.  In others it's not ideal, but we can use it as a
fallback technique because deployed device trees simply don't have
sufficient information in other places to use another approach.

There doesn't have to be One True Method for doing this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
