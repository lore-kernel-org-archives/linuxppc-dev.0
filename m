Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 0119967A7A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 23:27:43 +1100 (EST)
Date: Mon, 7 Mar 2005 05:27:32 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jakob Viketoft <jakob.viketoft@bitsim.se>
Message-ID: <20050307052732.A26339@cox.net>
References: <4226F904.5010104@bitsim.se> <1109875809.25252.24.camel@mud>
	<422C27FE.6000709@bitsim.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <422C27FE.6000709@bitsim.se>;
	from jakob.viketoft@bitsim.se on Mon, Mar 07, 2005 at 11:07:58AM
	+0100
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Adding machine types to the kernel tree...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2005 at 11:07:58AM +0100, Jakob Viketoft wrote:
> Thanks for the comments!
> 
> Andrew May wrote:
> > I think a huge first step would be to banish xparameters.h from all the
> > kernel code.
> > Our HW guys just seem to do the strangest things without checking.
> > So I have 2 spins of a board with 2 Virtex-II pro's each.
> > The 2 spins have a small refrence clock change and the 2 CPU's have
> > different IRQ mappings.
> 
> I understand that there is numerous resentment against having this file 
> in the kernel and I've been thinking of a solution without it. One such 
> path would be serving the kernel with a OCP list of the devices used, 
> but I'm unsure about the current status of OCP. Is this The Right Way to 
> do it, or are OCP likely to be abandoned further along the 2.6 road?
> 
> Matt (Porter), I've seen that you've "ported" this to the 2.6 kernel, 
> what do you say?

Don't tie anything permanently to OCP. :) Eventually, 4xx will convert
to platform devices like other similar SoC type subarches in ppc32 have
already done.  The only reason it hasn't been done yet is that there
are some other higher priority things on my plate at the moment.

That said, anything you do with OCP additions maps right into
platform_data in the platform device world.

However, it seems you are talking about passing information to
the kernel from some bootrom or full featured firmware. That is
a separate issue from how information is passed from the arch-code
into drivers (this is what OCP and platform devices accomplish).
For now, you could define a birec type for xparameters and
standardize around passing the info in that.  In the future,
birecs should be replaced by the "flattened OF device tree" method
that has been discussed here a bit (I know Jon Masters is lurking
around here, maybe with some code).

> > There is no way I wanted to build 4 kernels to handle these.
> > I don't have the code with me, but the basic thing I did was fixup
> > the compiled in arrays like rs_table in the board_io_mapping.
> > 
> > So the quick way to start tracking things down may be to just
> > replace all the constants in xparmaters.h with function calls
> > that got the info from the boot loader if possible.
> > You will get plenty of compile errors for the arrays, but then
> > just this type of code needs to be fixed up to setup the arrary
> > at run time rather than just get the pointer to it at run time.
> 
> The question is, do you want to have a bootloader (as U-boot) on a small 
> embedded system? In the FPGA case, you might need something that puts 
> the bitstream in the right place, but I'm not quite sure it would 
> constitute a bootloader. Maybe just having a static OCP list at a 
> certain location in flash and let the little bitstream prog send the 
> pointer to it as a kernel parameter at startup?

Even the smallest bootloader rom could put the xparameters.h info in
a location and point to it using the standard birec method when
transferring control to the kernel. 

I belive this would give Andrew the kind of flexibility he would like.
We've even talked about moving (in many cases at least) the SoC device
descriptions for other PPC SoCs out of the kernel so they are passed in
via birecs or the future flattened OF device tree.

-Matt
