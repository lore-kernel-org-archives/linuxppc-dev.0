Message-ID: <3A63B634.44E32CF8@primenet.com>
Date: Mon, 15 Jan 2001 19:47:16 -0700
From: Bob Doyle <doyle@primenet.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GCC PPC Inline Assembly Help
References: <3A6283A7.C4327446@primenet.com> <3A629111.3F36CDE8@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Bob Doyle wrote:
> >
> > I have an embedded platform (MPC8240) that requires flash memory
> > be programmed 64-bits at a time.  I believe that a floating-point
> > store is the only way to generate this 64-bit write.  I also
> > understand that floating-point usage is prohibited in the kernel
> > because the floating-point context is not saved.
>
> Didn't you ask this not long ago?

Nope.  I'll go back through the achives more carefully though.  I'm
probably not the only one to fight this.

> Why does the flash memory need to be programmed 64-bits at a time?

The MPC8240 can only read/write 64 bits at a time when the PortX/Flash
bus is configured to be 64 bits wide.  For executing out of FLASH it's
not a problem, for reads from FLASH it's not a problem, for FLASH writes
it's an issue.  That's how it is.

> Did you actually find some devices like this?  If you have 8 8-bit,
> or 4 16-bit devices, you can program these one at a time.

No you can't!  See below.

>Oh, that's right, you didn't design the hardware correctly.........

Ouch!  I wish.  If this was my doing, I'd have fixed it by now...

The MPC8240 doesn't have 'byte-lane' signals for the FLASH and the
bottom 3 address lines don't even leave the chip in 64-bit FLASH
mode.  It's not my limitation - it's absolutely inherent in the
MPC8240 FLASH bus design.

> Why do you have to do this in the kernel?

Flash file system.

> > How close am I?
>
> Still pretty far off the mark, even if the assembler is OK.  You need
> to enable the FPU, which presents another set of problems that can
> be somewhat eliminated by disabling interrupts.

I figured that out.  I've enabled the FPU and programmed the FLASH
without saving the FP context - that all works.  I'm sure I've
trashed user-space floating-point though...  That's why I'm trying
to force the 64-bit write to use fr0, so I can save/restore it's
value.  Thus the need for inline asm in gcc.

> If you can't write less than 64-bits, how do you ensure the memory
> controller will always generate a cycle to read 64-bits?

It always does.  Even if I do a byte read, the bus cycle is always
the same - the memory controller just chucks the 7 unused bytes and
justifies the byte of interest correctly to the CPU.

> Sounds like you have designed around lots of luck.

Actually I'm using it the way that Circle-M meant it to be used.

Bob

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
