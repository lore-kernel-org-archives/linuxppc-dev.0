From: "Chris Hallinan" <clh@net1plus.com>
To: "Rudolf Ladyzhenskii" <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem setting breakpoints with BDI2000
Date: Mon, 20 May 2002 23:25:35 -0400
Message-ID: <NEBBKJPFOLJNBMFNKBIIAEPNCNAA.clh@net1plus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <B164B53F5BD6D511888D009027732E1A4D11CC@ntserver.act.domain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Rudolf Ladyzhenskii wrote
> Hi, all
>
> I have BDI2000 with software version v1.11
> I have problems setting a breakpoint. I am trying to set
> a breakpoint in the
> start_kernel() function to debug misbehaving kernel.
> So, at command line I type:
> bi 0xXXXXXXXX, where 0xXXXXXXXX is address of
> start_kernel out of map file.
> BDI does not stop there, it passes this breakpoint. IO
> tried it with HARD
> and SOFT breakpoints.

It's hard to answer your questions without knowing your target
processor type, and it would be useful to know the kernel version
and boot loader you are using.

If I am not mistaken, addresses entered using the BDI-2000 telnet
interface are physical addresses for certain target processors.  You
are entering virtual addresses from the system.map file.

> I know that my kernel gets into infinite loop in timer
> interrupt. So I put a
> breakpoint there -- same! Nothing happens.

This is a common problem.  I'm guessing your decrementer is set
wrong, causing the interrupt to happen many times faster than it is
supposed to.  That is, as soon as you exit from the decrementer
exception, you are immediately entering it again, making it _look_
like an infinite loop :)

> I tried to connect to BDI with DDD. I can successfully
> load the kernel and
> start the kernel. When it freezes, I can halt BDI2000 and
> single step the
> kernel. I can now use breakpoints freely -- all works.

Is this through telnet or gdb??  This is the way it's supposed to
work :)

> Basically, if I start kernel, BDI does not react to any
> of the breakpoints.
> It starts to react on them once it was stopped at least once.

Make sure the MMU setting in your .cfg file is set properly.

-Chris Hallinan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
