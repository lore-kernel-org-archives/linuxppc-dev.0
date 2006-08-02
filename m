Return-Path: <mgreer@mvista.com>
Date: Wed, 2 Aug 2006 10:54:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 4/6] bootwrapper: Add non-OF serial console support
Message-ID: <20060802175431.GF17652@mag.az.mvista.com>
References: <20060719231244.GE3887@mag.az.mvista.com>
	<20060802161712.GH3075@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060802161712.GH3075@smtp.west.cox.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 09:17:12AM -0700, Tom Rini wrote:
> On Wed, Jul 19, 2006 at 04:12:44PM -0700, Mark A. Greer wrote:
> 
> > This patch adds support for serial I/O to the bootwrapper.
> > 
> > It is broken into 2 layers.  The first layer is generic serial
> > operations that calls uart-specific routines to do the actual I/O.
> > The second layer contains support for a 16550 compatible uart.
> > 
> > The division allows support for other serial devices to be easily
> > added in the future (e.g., the Marvell MPSC and the Freescale CPM).
> 
> Why do we do this with indirection rather than weak defaults and then
> real implementations?

Remember, devtrees can be added years after the zImage built.
So what if you had a board with 4 serial ports, 2 MPSC, 2 16550/8250
and the /chosen/linux,stdout-path could choose any of the four?

The current code doesn't handle that now either :) but it easily
could (and I should make it handle that).  The reason for the
indirections and not weak routines is to allow maximum flexibility.

Once things become more concrete, we can look at what can be replaced
by weak routines.  Now isn't the time, IMHO.

> The only places I see that are data are:
> 
> > +	ns16550_scd.base = NULL;
> > +	ns16550_scd.reg_shift = 0;
> 
> And I imagine that on platforms where these are real, we dig them out of
> the tree and set them, in your scheme, so it'd just be an empty (return
> 0/NULL) weak function, or the dig in the tree function.  Heck, it could
> just always be a 'dig in the tree' function.

I'm sorry, but I can't parse this paragraph.

What I probably should do, is rework serial_open() to query the dt
to get the stdout-path, match it up to one of the low-level serial
drivers that's been linked into the zImage, hook it up, and can call
its open routine.  Its open routine can then look for the properies
it needs in the devtree.  Something like that.

Again, when things have settled down, we can convert indirects to weak
routines where it makes sense.  But also remember, that the zImage
doesn't necessarily know a priori what's going to be in its devtree
(unless what's been compiled & linked into the zImage is so minimal
that it allows it no options--maybe that ends up always being the case,
I don't know).

Mark
