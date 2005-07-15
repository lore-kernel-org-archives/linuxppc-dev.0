Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Jul 2005 17:19:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050715071924.GA16797@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
	<20050712040623.GG3945@localhost.localdomain>
	<1121371427.24467.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121371427.24467.34.camel@cashmere.sps.mot.com>
Cc: linuxppc64-dev@ozlabs.org,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 14, 2005 at 03:03:47PM -0500, Jon Loeliger wrote:
> On Mon, 2005-07-11 at 23:06, David Gibson wrote:
> > On Mon, Jul 11, 2005 at 04:22:30PM -0500, Jon Loeliger wrote:
> > > On Sun, 2005-07-10 at 23:55, David Gibson wrote:
> > > > On Fri, Jul 08, 2005 at 04:44:58PM -0500, Jon Loeliger wrote:
> > [snip]
> > > > Biggest thing is that rather than passing the tree itself and the
> > > > memreserve info about as two parameters all over the place, I'd rather
> > > > create a new structure which has both (and later can have anything
> > > > else that might be needed).
> > > 
> > > If you'd like, I'll do this work.
> > 
> > That would be helpful.  You'll need to rediff, though, I merged a
> > couple of bugfixes from your patch that weren't directly related to
> > the memreserve stuff.
> 
> David,
> 
> Here is an updated version of the patch that obsoletes
> the previous one I submitted.  I have incorporated all
> of your syntactic suggestions except not using the
> split-64 values (ie, this still uses 'struct data').
> It primarily merges in the changes that you adopted
> from earlier and implements a new structure at the
> base of the parse tree to hold both the device tree
> and the header information.  I called that new stucuture
> 'struct header_tree'.  Feel free to dream up something
> better. :-)

Ok, I've merged this, although I've tweaked things substantially in
the process.  I did rename "header_tree" to "boot_info", moved some
things around, and changed the syntax.  Reserve ranges can now be
specified either as an address and length:

	/memreserve/	10000000 00002000;

or as an (inclusive) address range:

	/memreserve/	10000000-10001fff;

I am a bit worried that those two forms may be hard to distinguish at
a glance.  Any sugggestions for changes to the syntax soon please, I'd
really like to keep the source syntax as stable as possible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
