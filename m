Return-Path: <vitb@kernel.crashing.org>
Date: Fri, 14 Sep 2007 12:21:14 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/9] 8xx: Infrastructure code cleanup.
Message-ID: <20070914122114.30327773@localhost.localdomain>
In-Reply-To: <20070914040934.GK481@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201718.GB24260@ld0162-tx32.am.freescale.net>
	<20070913071125.GC24281@localhost.localdomain>
	<20070913121640.5764f656@localhost.localdomain>
	<20070914040934.GK481@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello David,

On Fri, 14 Sep 2007 14:09:34 +1000
David Gibson wrote:

> On Thu, Sep 13, 2007 at 12:16:40PM +0400, Vitaly Bordug wrote:
> [snip]
> > > This looks bogus.  You're replacing the old crap immr_map() functions,
> > > which ioremap()ed the registers every time, with a much simpler
> > > version which uses an established-once mapping of the register
> > > region.  AFAICT, anywah.
> > > 
> > > So far, so good - but your immr_unmap() still does an iounmap() which
> > > is surely wrong - it should now be a no-op, leaving the mpc8xx_immr
> > > mapping intact.  You probably get away with it by accident, because I
> > > imagine attempting to unmap an unaligned chunk of the region will just
> > > fail.
> > >
> > 
> > yes, it should do nop instead of iounmap. 
> > > In fact, with this patch in place, I'd like to see another patch which
> > > removes all calls to immr_map() and immr_unmap(), simply accessing the
> > > common mapping directly.
> > > 
> > Sorry, but originally, that stuff was created to get rid of BSP
> > ifdefs in drivers. For PQ family, it is a common practice to have
> > single driver handling all 3 CPU families, which use the same logic,
> > but immr structure differs a little bit.
> > 
> > At this point it's clear case-by-case ioremapping does not have firm
> > benefit, but getting back to the way it was is useless either.  In
> > ideal world, we'd have all those stuff put into dts and have
> > specific drivers be a shim layer between core hw and IO drivers.
> 
> Err.. I don't understand what you're getting at.  As the code stands
> after Scott's cleanup, the map() and unmap() calls can certainly be
> trivially removed, regardless of the history for them.
> 
I don't argue if they can be removed, but if we aught to do that. Direct immr 
dereference adds plenty of mess into driver code. I would like to keep the
situation when immr accesses factored out as a starting point, rather then turn them back to
&immap-> or cpm2_immr-> refs.
> And, yes, the drivers should certainly uses addresses from the device
> tree, rather than that revolting structure covering all the inbuilt
> device retgisters.
hehe, then you prolly know, that this structure does not fin well into device/driver model, either platform_ or
of_device. And I am going to sort it out at some point...


-- 
Sincerely, Vitaly
