Date: Tue, 24 Aug 2004 11:14:35 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: "Peter 'p2' De Schrijver" <p2@mind.be>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
References: <20040824085118.GO2698@mind.be>
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
Message-ID: <27642.1093338875@www70.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> A lot of the 405 specific kernel code relies on the
> fact that main memory is mapped at address 0. It would require quite
> some work to make it work on other addresses too.

You mean that RAM has to start at *physical* address zero? Well, then
perhaps I can convince the hardware guy to change the memory layout. It's a
softcore SDRAM controller, after all ;))

> > Where does my board specific fixup stuff go
> > (for
> > example, memory and IRQ declarations and such).
>
> Most of the board specific fixup stuff resides in
> platforms/boardname.[ch]. Look at arch/ppc/platforms/insightv2pro.[ch]
> for an example how we did this for the insight V2Pro board.

Thanks for the suggestions. I'll be looking into that, once I've handled the
low-level stuff.

> > 2) What requirements and responsibilities are imposed on the bootloader?
>
> The bootloader should load the kernel at address 0 and initialize the
> registers as follows (...)
> (See also arch/ppc/kernel/head_4xx.S). The board info structure is
> defined in asm-ppc/ppcboot.h (struct bd_info).

Thanks, I've already seen that one. Are there any other requirements (cache
flushing, cache turned on/off, interrupts disabled, etc.)?

> > 3) Is there a way to get a self-decompressing kernel image?
>
> Yes. look at arc/ppc/boot/simple for some targets which have a
> self-decompressing kernel. (Amongst which is our port to the Insight
> V2PRO board).

Hmm. The denx tutorial states that the bootloader *must* decompress the
kernel. If that's not true (anymore), then I might not have to use u-boot as
second stage bootloader.

Thanks,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
