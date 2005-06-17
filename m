Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id B3DB667A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 17:24:32 +1000 (EST)
Date: Fri, 17 Jun 2005 00:24:30 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ed Goforth <egoforth@gmail.com>
Message-ID: <20050617002430.A7742@cox.net>
References: <75b39f0105061614333199ec37@mail.gmail.com>
	<20050616155525.A4541@cox.net>
	<75b39f010506162047236fec19@mail.gmail.com>
	<20050616214155.A7062@cox.net>
	<75b39f0105061622421d81bc92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <75b39f0105061622421d81bc92@mail.gmail.com>;
	from egoforth@gmail.com on Fri, Jun 17, 2005 at 01:42:07AM -0400
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mmap on 440gx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2005 at 01:42:07AM -0400, Ed Goforth wrote:
> On 6/17/05, Matt Porter <mporter@kernel.crashing.org> wrote:
> > On Thu, Jun 16, 2005 at 11:47:22PM -0400, Ed Goforth wrote:
> > > On 6/16/05, Matt Porter <mporter@kernel.crashing.org> wrote:
> > > > On Thu, Jun 16, 2005 at 05:33:44PM -0400, Ed Goforth wrote:
> > >
> > > Thanks for taking the time to reply.
> > >
> > > > > I've been struggling with implementing mmap on a 440gx-based custom
> > > > > board.  I have been able to use ioremap(), but we really need a mmap()
> > > > > for our software.  The kernel is 2.4.18 (TimeSys 4.0).
> > > >
> > 
> > 
> > > For what it's worth, __pa(0x5000_0000) returns 0x9000_0000.
> > 
> > Sure, you just asked it to subtract KERNELBASE from a physical address.
> > Don't use __pa() in drivers. That's expected behavior. Why are
> > you doing that?
> 
> Desperation.

Heh, I like that. :)

<snip>

> > Put some debug statements throughout fixup_bigphys_addr() to see
> > what's going on.
> 
> My include/asm/mmu.h has it defined as:
> #ifndef CONFIG_440
> #include <asm-generic/mmu.h>
> #else
> typedef unsigned long long phys_addr_t;
> #define fixup_bigphys_addr(addr, size)   (addr)
> #endif
> 
> I see that in later 2.4 kernels and in mainline 2.6 it is implemented
> as an actual working routine.  Perhaps that explains it all.  The
> ioremap() in my tree implements the fixup code inline, which would
> explain why it works, right?

It sure does.  That code is 100% wrong.  Just merge in mainline 2.4
stuff and you should be golden. 

-Matt
