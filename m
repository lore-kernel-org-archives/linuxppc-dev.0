Date: Tue, 24 Aug 2004 11:42:11 +0200
To: Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
Message-ID: <20040824094211.GP2698@mind.be>
References: <20040824085118.GO2698@mind.be> <27642.1093338875@www70.gmx.net>
Mime-Version: 1.0
In-Reply-To: <27642.1093338875@www70.gmx.net>
From: "Peter 'p2' De Schrijver" <p2@mind.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 24, 2004 at 11:14:35AM +0200, Patrick Huesmann wrote:
>
> > A lot of the 405 specific kernel code relies on the fact that main
> > memory is mapped at address 0. It would require quite some work to
> > make it work on other addresses too.
>
> You mean that RAM has to start at *physical* address zero? Well, then
> perhaps I can convince the hardware guy to change the memory layout.
> It's a softcore SDRAM controller, after all ;))

Yes. That's what I mean. Changing the hardware is probably easier in
this case then adapting the kernel yes :)

> Thanks, I've already seen that one. Are there any other requirements
> (cache flushing, cache turned on/off, interrupts disabled, etc.)?

Interrupts should be disabled. There is no real cache disable on the
405. You can only mark pages (or 128MB regions when running in
untranslated mode), cacheable or uncacheable. Caches are normally
flushed by the linux startup code, but it doesn't hurt to flush them in
the bootloader.

> > > 3) Is there a way to get a self-decompressing kernel image?
> >
> > Yes. look at arc/ppc/boot/simple for some targets which have a
> > self-decompressing kernel. (Amongst which is our port to the Insight
> > V2PRO board).
>
> Hmm. The denx tutorial states that the bootloader *must* decompress
> the kernel. If that's not true (anymore), then I might not have to use
> u-boot as second stage bootloader.

Cheers,

Peter (p2).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
