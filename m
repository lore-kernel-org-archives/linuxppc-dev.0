Message-ID: <3A629111.3F36CDE8@mvista.com>
Date: Mon, 15 Jan 2001 00:56:33 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Bob Doyle <doyle@primenet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: GCC PPC Inline Assembly Help
References: <3A6283A7.C4327446@primenet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob Doyle wrote:
>
> I have an embedded platform (MPC8240) that requires flash memory
> be programmed 64-bits at a time.  I believe that a floating-point
> store is the only way to generate this 64-bit write.  I also
> understand that floating-point usage is prohibited in the kernel
> because the floating-point context is not saved.

Didn't you ask this not long ago?
Why does the flash memory need to be programmed 64-bits at a time?
Did you actually find some devices like this?  If you have 8 8-bit,
or 4 16-bit devices, you can program these one at a time. Oh, that's
right, you didn't design the hardware correctly.........

Why do you have to do this in the kernel?


> How close am I?

Still pretty far off the mark, even if the assembler is OK.  You need
to enable the FPU, which presents another set of problems that can
be somewhat eliminated by disabling interrupts.


If you can't write less than 64-bits, how do you ensure the memory
controller will always generate a cycle to read 64-bits?  Sounds like
you have designed around lots of luck.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
