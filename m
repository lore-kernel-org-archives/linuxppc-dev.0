Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 8AE5567A04
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Jun 2005 07:14:32 +1000 (EST)
Date: Tue, 7 Jun 2005 14:14:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Message-ID: <20050607141428.A26258@cox.net>
References: <11180976151713@foobar.com>
	<Pine.LNX.4.61.0506062302440.10441@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0506062302440.10441@montezuma.fsmlabs.com>;
	from zwane@arm.linux.org.uk on Mon, Jun 06, 2005 at 11:19:50PM
	-0600
Cc: linux-kernel@vger.kernel.org, gregkh@kroah.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][3/5] RapidIO support: core enum
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jun 06, 2005 at 11:19:50PM -0600, Zwane Mwaikambo wrote:
> On Mon, 6 Jun 2005, Matt Porter wrote:
> 
> > +spinlock_t rio_global_list_lock = SPIN_LOCK_UNLOCKED;
> 
> spin_lock_init?

How about DEFINE_SPINLOCK() as they do the same thing (except the 
difference in amount of babble)? This is what PCI is doing, for
example. I use the same init method in the static locks found
in rio-access.c, FWIW.

> > +extern struct rio_route_ops __start_rio_route_ops[];
> > +extern struct rio_route_ops __end_rio_route_ops[];
> 
> rio.h?

Yep, will move.

> > +static void
> > +rio_set_device_id(struct rio_mport *port, u16 destid, u8 hopcount, u16 did)
> 
> Shouldn't those be on the same line?

Yes, will fix.
 
> > +static int rio_device_has_destid(struct rio_mport *port, int src_ops,
> > +				 int dst_ops)
> > +{
> > +	if (((src_ops & RIO_SRC_OPS_READ) ||
> > +	     (src_ops & RIO_SRC_OPS_WRITE) ||
> > +	     (src_ops & RIO_SRC_OPS_ATOMIC_TST_SWP) ||
> > +	     (src_ops & RIO_SRC_OPS_ATOMIC_INC) ||
> > +	     (src_ops & RIO_SRC_OPS_ATOMIC_DEC) ||
> > +	     (src_ops & RIO_SRC_OPS_ATOMIC_SET) ||
> > +	     (src_ops & RIO_SRC_OPS_ATOMIC_CLR)) &&
> > +	    ((dst_ops & RIO_DST_OPS_READ) ||
> > +	     (dst_ops & RIO_DST_OPS_WRITE) ||
> > +	     (dst_ops & RIO_DST_OPS_ATOMIC_TST_SWP) ||
> > +	     (dst_ops & RIO_DST_OPS_ATOMIC_INC) ||
> > +	     (dst_ops & RIO_DST_OPS_ATOMIC_DEC) ||
> > +	     (dst_ops & RIO_DST_OPS_ATOMIC_SET) ||
> > +	     (dst_ops & RIO_DST_OPS_ATOMIC_CLR))) {
> > +		return 1;
> 
> Why not just;
> 
> mask = (RIO_DST_OPS_READ | RIO_DST_OPS_WRITE....)
> return !!((dst_ops & mask) && (src_ops & mask))

Yes, that's good. I already had that comment from an IRC discussion
and neglected to address it in the last updates. Will do.

> > +	rdev->dev.dma_mask = (u64 *) 0xffffffff;
> > +	rdev->dev.coherent_dma_mask = 0xffffffffULL;
> 
> Shouldn't that be dma_set_mask?

There is a problem there, yes, but it shouldn't use dma_set_mask().
dma_set_mask() needs [struct device]->dma_mask to be non-zero
(initialized to something) to do anything in all the copied
implementations I've seen.  I need to do something like the
following to initialize the struct device dma_mask properly:

	rdev->dma_mask = 0xffffffffULL;
	rdev->dev.dma_mask = &rdev->dma_mask;

-Matt
