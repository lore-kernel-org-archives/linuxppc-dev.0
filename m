From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Gabriel Paubert <paubert@iram.es>,
        Kevin Hendricks <khendricks@ivey.uwo.ca>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Date: Thu, 20 Jan 2000 23:34:23 +0100
Content-Type: text/plain
Cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
References: <Pine.HPX.4.10.10001202043560.18916-100000@gra-ux1.iram.es>
In-Reply-To: <Pine.HPX.4.10.10001202043560.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Message-Id: <00012023473100.01038@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Don, 20 Jan 2000 schrieb Gabriel Paubert:
>Hi,
>
>> In this particular case, the base address can change (but very very rarely
>> such as writing to one Aperature or Another on the Rage 128 card) and all of
>> the writes are made to either the card memory mapped io or the frame buffer
>> itself.
>
>Then the memory clobber would force the compiler to reload base_addr
>between 2 writes to the frame buffer.
>
>> Should I not include the : "memory" clobber in this case?  Will it hurt
>> performance much?
>
>I think that it is not necessary: the best thing with a compiler which
>performs alias analysis might be to tell the truth
>
>asm ("stwbrx %1,%2,%3"
>     : "=m" (*(volatile unsigned *)(base_addr+regindex))
>     : "r" (regdata), "b" (base_addr), "r" (regindex));
>
>Note we don't use %0, and it won't produce any aditional code. You may
>want to check what the compiler would have generated as addressing mode
>by appending " # %0" at the end of the code string.

It depends a little bit on the usage of the asm's if the memory (either
global or local) clobber is needed or not. If you use them for read/writes to HW
registers needing ordering (which is very likely here since we talk about
graphics HW), the compiler can only decide on the memory usage defined by the
clobbers/memory inputs on how to order the inlines (volatile has no effect on
this).

Actually the load instructions need a memory input too:

asm volatile ("lwbrx %0,%1,%2" : "=r"(val) : "b"(regindex), "r"(base_addr),
"m" (*(volatile unsigned *)(base_addr+regindex)));

And to insure ordering on processor level you still need the eieio (with a
memory clobber) as usual.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
