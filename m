Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E157EDF029
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 05:44:17 +1000 (EST)
Date: Tue, 3 Jun 2008 12:43:21 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <200806031416.18195.nickpiggin@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0806031154050.3242@t2.domain.actdsltmp>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<20080602072403.GA20222@flint.arm.linux.org.uk>
	<200806031416.18195.nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Jun 2008, Nick Piggin wrote:
> On Monday 02 June 2008 17:24, Russell King wrote:
>> So, can the semantics of what's expected from these IO accessor
>> functions be documented somewhere.  Please?  Before this thread gets
>> lost in the depths of time?
>
> This whole thread also ties in with my posts about mmiowb (which IMO
> should go away).
>
> readl/writel:  strongly ordered wrt one another and other stores
>               to cacheable RAM, byteswapping
> __readl/__writel:  not ordered (needs mb/rmb/wmb to order with
>                   other readl/writel and cacheable operations, or
>                   io_*mb to order with one another)
> raw_readl/raw_writel:  strongly ordered, no byteswapping
> __raw_readl/__raw_writel:  not ordered, no byteswapping

Byte-swapping vs not byte-swapping is not usually what the programmer wants. 
Usually your device's registers are defined as being big-endian or
little-endian and you want whatever is needed to give you that.

I believe that on some archs that can be either byte order, some built-in
devices will change their registers to match, and so you want "native endian"
or no swapping for these.  Though that's definitely in the minority.

An accessors that always byte-swaps regardless of the endianness of the host
is never something I've seen a driver want.

IOW, there are four ways one can defined endianness/swapping:
1) Little-endian
2) Big-endian
3) Native-endian aka non-byte-swapping
4) Foreign-endian aka byte-swapping

1 and 2 are by far the most used.  Some code wants 3.  No one wants 4.  Yet
our API is providing 3 & 4, the two which are the least useful.

Is it enough to provide only "all or none" for ordering strictness?  For
instance on powerpc, one can get a speedup by dropping strict ordering for IO
vs cacheable memory, but still keeping ordering for IO vs IO and IO vs locks. 
This is much easier to program for than no ordering at all.  In fact, if one
doesn't use coherent DMA, it's basically the same as fully strict ordering.
