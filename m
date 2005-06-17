Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id D6D5F679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 14:41:57 +1000 (EST)
Date: Thu, 16 Jun 2005 21:41:55 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ed Goforth <egoforth@gmail.com>
Message-ID: <20050616214155.A7062@cox.net>
References: <75b39f0105061614333199ec37@mail.gmail.com>
	<20050616155525.A4541@cox.net>
	<75b39f010506162047236fec19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <75b39f010506162047236fec19@mail.gmail.com>;
	from egoforth@gmail.com on Thu, Jun 16, 2005 at 11:47:22PM -0400
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

On Thu, Jun 16, 2005 at 11:47:22PM -0400, Ed Goforth wrote:
> On 6/16/05, Matt Porter <mporter@kernel.crashing.org> wrote:
> > On Thu, Jun 16, 2005 at 05:33:44PM -0400, Ed Goforth wrote:
> 
> Thanks for taking the time to reply.
> 
> > > I've been struggling with implementing mmap on a 440gx-based custom
> > > board.  I have been able to use ioremap(), but we really need a mmap()
> > > for our software.  The kernel is 2.4.18 (TimeSys 4.0).
> > 
> > There are some special things done for handling [io]_remap_page/pfn_range
> > on other vendor kernels and the current mainline kernel.  I'm not sure
> > if your vendor kernel addressed them since it would be a vendor-specific
> > patch in that timeframe.  The special things are due to 36-bit
> > addressing.
> > 
> > > I'm trying to access one of our FPGA's located at 0x50000000.  Offsets
> > 
> > Let's start at the beginning.  How do you have FPGA's at 0x50000000?
> > that address falls with the fix DDR SDRAM area on the 440GX memory
> > map. All peripheral and EBC space is mapped by 4GB. You lost me
> > right here. Oh wait, are you referring to the least significant 32-bits
> > of the physical mapping. It's not really at 0x50000000.
> 
> Of course, you're correct.  The 36-bit base address is 0x1_0000_0000. 
> It is mapped to the 32-bit address 0x5000_0000.

That's an interesting way to look at it but there isn't really a
"mapping".  You have configured a EBC chip selects to decode at
1_5000_0000.

> Should I pass the 36-bit address to remap_page_range()?

No, it takes a 32-bit physical address and "fixes it up" using
the fixup_bigphys_addr() method.  Double check that the trap ranges
are correct for you board port.  They need to be modified to add
the appropriate MS 4-bit.  Since ioremap() also uses
fixup_bigphys_addr() to "fixup" 32-bit addresses to 36-bit,
it should just work. 

> For what it's worth, __pa(0x5000_0000) returns 0x9000_0000.

Sure, you just asked it to subtract KERNELBASE from a physical address.
Don't use __pa() in drivers. That's expected behavior. Why are
you doing that?
 
> > You need something like the bigphys_remap patch for 2.4 that can be
> > found at ftp://source.mvista.com/pub/linuxppc/
> 
> I just checked the source, and that patch has indeed been applied.

Ok, assuming it's all correct then I don't know why it does work
for you in your vendor tree. Have you asked Timesys for help?

Put some debug statements throughout fixup_bigphys_addr() to see
what's going on.

-Matt
