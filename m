Return-Path: <vitb@kernel.crashing.org>
Date: Thu, 13 Sep 2007 12:16:40 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/9] 8xx: Infrastructure code cleanup.
Message-ID: <20070913121640.5764f656@localhost.localdomain>
In-Reply-To: <20070913071125.GC24281@localhost.localdomain>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201718.GB24260@ld0162-tx32.am.freescale.net>
	<20070913071125.GC24281@localhost.localdomain>
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

On Thu, 13 Sep 2007 17:11:25 +1000
David Gibson wrote:

> Didn't notice this before - only when some yak shaving led me into
> looking at the horrors of the 8xx imm mapping code...
> 
> But..
> [snip]
> > diff --git a/include/asm-powerpc/fs_pd.h
> > b/include/asm-powerpc/fs_pd.h index c624915..733e8cb 100644
> > --- a/include/asm-powerpc/fs_pd.h
> > +++ b/include/asm-powerpc/fs_pd.h
> > @@ -45,22 +45,11 @@
> >  #include <asm/8xx_immap.h>
> >  #include <asm/mpc8xx.h>
> >  
> > -#define
> > immr_map(member)						\
> > -({
> > \
> > -	u32 offset = offsetof(immap_t,
> > member);				\
> > -	void *addr = ioremap (IMAP_ADDR +
> > offset,			\
> > -
> > sizeof( ((immap_t*)0)->member));		\
> > -
> > addr;
> > \ -}) -
> > -#define immr_map_size(member,
> > size)					\
> > -({
> > \
> > -	u32 offset = offsetof(immap_t,
> > member);				\
> > -	void *addr = ioremap (IMAP_ADDR + offset,
> > size);		\
> > -
> > addr;
> > \ -}) +extern immap_t __iomem *mpc8xx_immr;
> >  
> > -#define immr_unmap(addr)		iounmap(addr)
> > +#define immr_map(member) (&mpc8xx_immr->member)
> > +#define immr_map_size(member, size) (&mpc8xx_immr->member)
> > +#define immr_unmap(addr) iounmap(addr)
> 
> This looks bogus.  You're replacing the old crap immr_map() functions,
> which ioremap()ed the registers every time, with a much simpler
> version which uses an established-once mapping of the register
> region.  AFAICT, anywah.
> 
> So far, so good - but your immr_unmap() still does an iounmap() which
> is surely wrong - it should now be a no-op, leaving the mpc8xx_immr
> mapping intact.  You probably get away with it by accident, because I
> imagine attempting to unmap an unaligned chunk of the region will just
> fail.
>

yes, it should do nop instead of iounmap. 
> In fact, with this patch in place, I'd like to see another patch which
> removes all calls to immr_map() and immr_unmap(), simply accessing the
> common mapping directly.
> 
Sorry, but originally, that stuff was created to get rid of BSP ifdefs in drivers. For PQ family, it is a common practice
to have single driver handling all 3 CPU families, which use the same logic, but immr structure differs a little bit.

At this point it's clear case-by-case ioremapping does not have firm benefit, but getting back to the way it was is useless either.
In ideal world, we'd have all those stuff put into dts and have specific drivers be a shim layer between core hw and IO drivers.


-- 
Sincerely, Vitaly
