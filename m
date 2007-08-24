Return-Path: <dgibson@ozlabs.org>
Date: Sat, 25 Aug 2007 08:17:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070824221710.GA674@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
	<20070822010907.GA12472@localhost.localdomain>
	<20070822172456.GA22932@ld0162-tx32.am.freescale.net>
	<20070823020147.GB7042@localhost.localdomain>
	<46CDC86E.2070907@freescale.com>
	<20070824010122.GA7281@localhost.localdomain>
	<20070824144837.GA18753@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070824144837.GA18753@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 09:48:37AM -0500, Scott Wood wrote:
> On Fri, Aug 24, 2007 at 11:01:22AM +1000, David Gibson wrote:
> > On Thu, Aug 23, 2007 at 12:48:30PM -0500, Scott Wood wrote:
> > > It's likely to be ugly no matter what, though I'll try to come up with 
> > > something slightly nicer.  If I were doing this code from scratch, I'd 
> > > probably liven the tree first and reflatten it to pass to the kernel.
> > 
> > Eh, probably not worth bothering doing an actual implementation at
> > this stage - I'll have to redo it for libfdt anyway.
> 
> Too late, I already wrote it -- it wasn't as bad as I thought it would
> be.

Well, there you go.

> > flatdevtree uses some of the information it caches in the phandle
> > context stuff to remember who's the parent of a node.  libfdt uses raw
> > offsets into the structure, so the *only* way to implement
> > get_parent() is to rescan the dt from the beginning, keeping track of
> > parents until reaching the given node.
> 
> What is the benefit of doing it that way?

Most other operations are simpler like this - no more futzing around
converting between phandles and offsets and back again at the
beginning and end of most functions.

More importantly, it allows libfdt to be "stateless" in the sense that
you can manipulate the device tree without having to maintain any
context or state structure apart from the device tree blob itself.
That's particularly handy for doing read-only accesses really early
with a minimum of fuss.

In particular, it means libfdt does not need malloc().  That can be
rather useful for some that's supposed to be embeddable in a variety
of strange, constrained environments such as bootloaders and
firmwares.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
