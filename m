Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Mar 2008 11:09:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Message-ID: <20080328000917.GD16141@localhost.localdomain>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803271013.32612.laurentp@cse-semaphore.com>
	<20080327100304.GC10397@localhost.localdomain>
	<200803271531.35401.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803271531.35401.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2008 at 03:31:34PM +0100, Laurent Pinchart wrote:
> On Thursday 27 March 2008 11:03, David Gibson wrote:
> > On Thu, Mar 27, 2008 at 10:13:32AM +0100, Laurent Pinchart wrote:
> > > On Wednesday 26 March 2008 13:53, Sergei Shtylyov wrote:
> > > > Laurent Pinchart wrote:
> > [snip]
> > > >     Heh, we've gone thru "physmap" before -- it was labelled
> > > >     Linux-specific name (well, I'd agree with that).
> > > 
> > > physmap stands for physically mapped. That doesn't sound
> > > Linux-specific to me, the fact that the MTD driver has the same name
> > > is a pure coincidence.  linmap-rom and linmap-rom sound even more
> > > Linux-specific :-)
> > 
> > It may not be Linux specific per se, but it's a bad name, because the
> > fact that the device is physically direct mapped isn't a useful
> > distinguishing feature of the device.  Main memory is also direct
> > physically mapped, after all, but that's not what you want to cover
> > with this description.  In general how a device is wired is described
> > by where it sits in the tree, not by its properties.
> > 
> > It only seems like a usefully distinguishing name because it's the
> > Linux "physmap_of" driver that uses it.  So in this sense it is a
> > Linux specific name after all.  In fact, physmap_of is itself very
> > badly named - right now it only handles direct mapped mtds, but that's
> > not inherent; it could be trivially extended to also instantiate a
> > non-direct-mapped device (as long as the underlying mtd layer
> > supported it, of course).  It bears no relation at all to the
> > "physmap" driver, except historical accident.
> > 
> > > Could we agree on a name ? I'd like to submit a new patch.
> > 
> > For ROMs I think just plain "rom" should be sufficient.  For RAMs we
> > need something to indicate that it's memory but intended for secondary
> > storage, not as main memory.  Unfortunately, I'm finding myself unable
> > to think of something.
> 
> What about "storage-ram", "auxiliary-ram", "secondary-ram",
> "application-ram", "user-ram" or "ramdisk" ?

Well, I like all those better than anything previously suggested.
"storage-ram" is probably my favourite.  It still doesn't seem great,
but given I've been unable to thing of something better.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
