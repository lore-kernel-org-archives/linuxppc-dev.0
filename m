Message-ID: <3C0BAFF8.5060309@embeddededge.com>
Date: Mon, 03 Dec 2001 12:01:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Shie Erlich <shie_e@elbit.co.il>
Cc: "Linuxppc-Embedded mailing list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 64 bit memory access - again ...
References: <937610FE9B70D511B3E700508B8B65770E53CA@MAIL1>
Content-Type: text/plain; charset=windows-1255; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shie Erlich wrote:


> i also know that floating point in the kernel is a big NO, but if no other
> choice is found, i'll have to do it. my questions are:

If possible, I would mmap() the device from user space and perform
the access there.

> a) what is the recommended way of doing a 64bit access in the linux kernel ?

I would first try to do it with a cache line burst access.  Put it in
copyback mode, zero the line, write the line, flush the line, invalidate
the line.

> b) if the fpu is the way to go, what do i need to do so that the kernel does
> not
>     trap my floating point access ?

You can't trap and emulate, that defeats the purpose.  The biggest challenge
when using floating point in the kernel is context switching the FPU.
I would probably force the kernel to always context switch the FPU (as
it does on SMP) so you would always have a clean context to use in
the kernel.  I would then disable interrupts (to avoid other FPU context
problems), enable the FPU, perform the access, ensure the context is
reloaded for the switched-in thread, disable the FPU, enable interrupts.

Any system performance gains you thought you may have by using 64-bit
I/O are likely to be significantly reduced by the amount of software
overhead needed to manage this.

Depending upon what you are using for a bridge/memory controller you
may have a DMA controller that could perform this access as well.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
