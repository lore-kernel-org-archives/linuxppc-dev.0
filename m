Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 7634867A76
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 07:41:20 +1100 (EST)
Date: Thu, 27 Jan 2005 13:41:17 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050127134117.D4266@cox.net>
References: <c3d0340b0501271005409166e6@mail.gmail.com>
	<20050127111615.A4266@cox.net>
	<c3d0340b050127121826b92395@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b050127121826b92395@mail.gmail.com>;
	from shawnxjin@gmail.com on Thu, Jan 27, 2005 at 12:18:45PM -0800
Cc: linuxppc <linuxppc-dev@ozlabs.org>
Subject: Re: Relocating interrupt vectors in ppc440?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 27, 2005 at 12:18:45PM -0800, Shawn Jin wrote:
> First thank you for your valuable response.
> 
> > > Assumed that the interrupt vectors locate at the low address space
> > > physically and given that there is 2GB SDRAM shared by two ppc440
> > > cores, can one of linux kernels run at the top of 1GB space? This
> > > means the interrupt vectors for this copy need to move to upper 1GB.
> > > Each core runs a copy of linux kernel independently.
> > 
> > Yes, you'd have to do something like the APUS code does by settings
> > PPC_MEMSTART appropriately for the second processor. Also, of course
> 
> I guess the value set to PPC_MEMSTART should be the offset to the
> physical starting address of 2GB SDRAM not the absolute physical
> address, right?

It would be 0x00000000 for the first processor and 0x40000000 for the
second processor. Note that head_44x.S is a major place where a lot
of "system memory is at zero" assumptions take place that need to
be addressed for the second processor.
 
> > limiting the memory on the first processor to 1GB. There's probably
> 
> Limiting the memory on the first processor to 1GB can be done by
> setting the mem size to 1GB in boot arguments (mem=1024MB)?

Correct, but for a SoC port where this is a static configuration, you
can simply make your "find_end_of_memory()" routine return 1GB.

> > One idea is that if you really don't have to do it, then don't. :)
> 
> The SoC is designed in this way that two cores share the DDR but it's
> not SMP. Two kernels have to run independently. Relocating interrupt
> vectors to upper 1GB memory means that another copy of kernel can run
> at upper memory, right. So I'm afraid I have to do that. :(

That's a shame. This sounds identical to a 440-based standard product
that IBM had planned (and cancelled) when they still owned the 4xx
standard product line.
 
-Matt
