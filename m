Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5761EDDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 22:42:59 +1100 (EST)
Date: Tue, 13 Feb 2007 14:42:45 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: hs@denx.de
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
Message-ID: <20070213144245.51de948b@localhost.localdomain>
In-Reply-To: <1171354187.5919.29.camel@Apollo>
References: <1171276422.14090.54.camel@Apollo>
	<20070212205500.1b7135fe@vitb.ru.mvista.com>
	<1171354187.5919.29.camel@Apollo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 13 Feb 2007 09:09:47 +0100
Heiko Schocher wrote:

> Hello Vitaly,
> 
> Vitaly Bordug wrote:
> > > I tried the Patch from Kalle Pokki
> > > http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/025108.html
> > > 
> > > but my SMC didnt work, without this patch, it works fine. I think
> > > that the pram_base must be set the follwing way:
> > > 
> > Thanks for the patch, but I guess it requires a bit of
> > investigation first since we cannot just drop ioremapped offset and
> > get back to raw one that has been returned by platform_get_....
> 
> Ok, "Linux" writes/reads with the ioremapped Address in the Dualported
> RAM we get with platform_get_...("pram"), thats Okay, but the CPM
> needs the "real" Dualported RAM Address from this Area at offset
> SMCx_BASE, which we get with platform_get_...("pram_base"), so it can
> find the SMC Parameter RAM, he(CPM) didnt know anything about
> ioremapped addresses.
> 
> > We require ioremap stuff for powerpc approach, and I think we'd
> > have to figure out why ioremapped address did not satisfy smc (and
> > I'll try on my 8xx).
> 
> Hmm... you mean the following?:
> 
>   r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram_base");
>   if (r) {
> +           pram_base = (u32)ioremap(r->start, r->end - r->start + 1);
>             out_be16((u16 *)pram_base, base & 0xffff);
> +           iounmap(pram_base);
>          }
> 
> But thats not, what I correct with my patch, the error was, that
> we wrote the ioremapped address pram in pram_base and not the real
> address ... and with this ioremapped address, the CPM cannot do
> anything (I think).
> 

That is what I am about - I think there is a bit of confusion around the upper. I mean, we'll have to investigate
what's happening in arch/powerpc since the SMC CPM works fine for me in aprch/powerpc with the ioremap stuff. Maybe it has to do something with io_block_map() and the ioremap - I'm not sure. Well it worths looking at it, if it will be unclear we can end up with #ifdef that areas to keep ppc/ happy at least.
