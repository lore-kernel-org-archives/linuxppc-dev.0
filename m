Message-Id: <200006212008.WAA24859@denx.local.net>
To: Lucinda Schafer <lucsch@adaptivemicro.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation Kernel Panic--specific information 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Jun 2000 12:26:58 CDT."
             <A109131318C4D1119AC20060088DECE330F493@amwmail.adaptivemicro.com>
Date: Wed, 21 Jun 2000 22:08:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A109131318C4D1119AC20060088DECE330F493@amwmail.adaptivemicro.com>
Lucinda Schafer wrote:
>
> The NIP, LR, and TRAP always seem to be set to the same values (others
> vary). I assume those values are physical addresses.

No. All these are virtual addresses.

> If so, from System.map, the NIP seems to be between c0001f00 t Trap_1f and
> c0002000 T transfer_to_handler.

It should be obvious that 0xCxxxxxxx is a virtual address.

> I can't make sense of this, since I don't fully understand what the
> relationship of NIP and LR are.  Does the LR address refer to the return
> address after the exception? Does this mean the exception happened in the
> Decrementer timer interrupt? Why is the NIP set to a value between Trap_1f
> and transfer_to_handler?

NIP means "Next Instruction Pointer" and contains the address of  the
statement following the one that caused the exception; LR is the link
register and contains the return address = the address where executun
continues when you return from the current function.

So in simple words: NIP-4 gives the IP (Intruction  Pointer)  aka  PC
(Program  Counter), and LR-4 is the place where your current function
was called.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To get something done, a committee should consist  of  no  more  than
three men, two of them absent.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
