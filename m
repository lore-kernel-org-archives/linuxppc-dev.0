Message-ID: <3A63D066.F050245C@mvista.com>
Date: Mon, 15 Jan 2001 23:39:02 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Bob Doyle <doyle@primenet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GCC PPC Inline Assembly Help
References: <3A6283A7.C4327446@primenet.com> <3A629111.3F36CDE8@mvista.com> <3A63B634.44E32CF8@primenet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob Doyle wrote:

> Nope.

Sorry.  I've seen a couple of questions about this lately.

> The MPC8240 can only read/write 64 bits at a time when the PortX/Flash
> bus is configured to be 64 bits wide.

Oh, you tried to find a use for PortX beyond just simple stuff :-).
I thought is was on the 60x bus.

> The MPC8240 doesn't have 'byte-lane' signals for the FLASH

Yes, yes....

> Flash file system.

I was afraid that was the answer :-).


> .....That's why I'm trying
> to force the 64-bit write to use fr0, so I can save/restore it's
> value.  Thus the need for inline asm in gcc.

Or, just write a simple assembler function and stick it in misc.S
or something.  In a past message I responded with the necessary
steps.....disable all exception, enable FPU, save data register,
do your memory operation, restore the data register, disable FPU,
enable exceptions.

The other thing that would work is to copy-back cache the space
and use cache operations to clear and push the cache line.

> Actually I'm using it the way that Circle-M meant it to be used.

Well.....If you notice in any of their documentation, they only
show ROM interfaces in 64-bit mode.  Their Flash examples are either
8- or 32-bit with external logic to decode chip enables.....

Have Fun :-)!


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
