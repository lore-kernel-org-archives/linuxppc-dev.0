Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5CB867BD7
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 09:33:31 +1100 (EST)
In-Reply-To: <1162677911.28571.55.camel@localhost.localdomain>
References: <1162588367.10630.100.camel@localhost.localdomain>
	<CE55E1AD-1553-442C-98FC-D348BC73E7A4@kernel.crashing.org>
	<1162677911.28571.55.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <78783FCE-8B34-40B8-9746-1593B5150411@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Hookable IO operations
Date: Sat, 4 Nov 2006 23:33:18 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> + * for the out_* accessors has the arguments in opposite order
>>> from the usual
>>> + * linux PCI accessors. Unlike those, they take the address first
>>> and the value
>>> + * next.
>>
>> Isn't that more confusing than useful?
>
> That's how they have been singe day 1. I'm not about to change that  
> and
> go fix every bit of ppc code that uses them. At least not with this
> patch.

Sure.  By just reading the patch I couldn't tell whether this was
new (or a new comment) or not, without cross-referencing stuff :-)

>> Drop the "inline" and you don't need any macro games anymore, and  
>> code
>> size drops, and it shouldn't be slower -- the I/O operation itself
>> dominates runtime (but testing is needed, of course).
>
> No, the low level accessors are staying inline and I don't see how  
> that
> would prevent macro games... Anyway that doesn't matter much at this
> point.

It would be nice if someone could measure the difference between
inlined and non-inlined though, both in code size and actual
performance.

> Note that I've posted a second version of the patch with simpler
> macros.

Your mails show up in my mailbox really late, I'll look at the
new version.

>> You can also drop the "volatile" -- it has no effect.
>
> Well, it's possible, but I've never quite understood when and when  
> not C
> compilers need/want volatile or not in the case of IO accessors :-)

"volatile" on a pointer only has effect at the point where that
pointer is dereferenced (at the C level, asm doesn't count).
"volatile" in a function prototype is meaningless; in a function
definition, it only does something _within_ that function, and
then only where the pointer is dereferenced.  It's preferable
for clarity to cast the pointer to the volatile version of its
type _right at the dereference itself_.

> It
> seems to be the rule accross linux that those functions take  
> volatile so
> I will continue following it.

... but then there's that, heh.  I don't feel up to a bad-use-of-
volatile-crusade right now, so I won't ask you to either :-)

>> "r"(addr) should probably be "b" (and you might want to lose the  
>> "m" --
>> it certainly won't have any bad effects if you decide to get rid  
>> of the
>> inline).
>
> In which case should "r" be "b" ? Those macros are directly equivalent
> to the previous code that was there and it didn't use "b". If you look
> closely, depending on the type of operations(lbz,lhz,lwz etc.. vs.
> lhbrz, lwbrx etc...), we use %1 or %2 for the address. In the former
> case, we get more efficient code by letting gcc generate the right  
> type
> of instruction (update form, indexed form, ... using %U and %X) by  
> using
> and "m" input. For the later, we use "r" and we use it for rB which  
> can
> safely be r0 afaik so we don't need "b".
>
>>> +#define DEF_MMIO_IN_BE(pfx, size, insn) \
>>> +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)"%U2%X2 %0,%2")
>>> +#define DEF_MMIO_IN_LE(pfx, size, insn) \
>>> +	DEF_MMIO_IN(pfx##size, u##size, __stringify(insn)" %0,0,%1")
>>
>> ... "r" is okay actually, no "b" needed (would be needed if addr  
>> was the
>> first arg -- which is very much preferred on most CPUs for  
>> performance
>> reasons).
>
> Ah ? But how so ? I mean, there has to be a rB, there is no form of
> these instructions (the LE ones) with only one argument.

In load/store insns of the form

	op rD,rA,rB

the rA needs to be "b" (i.e., GPR0 is disallowed) and rB can be "r".

Some CPUs want rA to be a "real" address itself, probably because of
how they do the storage address translation.  I don't have details,
but see http://gcc.gnu.org/PR28690 .  I can speculate but let's do
that in private, not on this mailing list :-)

> Thus there is
> always a register specified as the second part of the address. So if I
> was using "b" with rA, I would have to spill another register for  
> rB and
> put 0 in it.

Quite true; just keep it as-is until you get complaints :-)

>>> +/* Enforce in-order execution of data I/O.
>>> + * No distinction between read/write on PPC; use eieio for all  
>>> three.
>>> + */
>>
>> It also prevents write gathering; if not, the _w version wouldn't
>> need eieio.
>
> That was there already, I haven't touched that comment. Maybe I
> should...

Yes exactly.

>>> +config PPC_INDIRECT_IO
>>
>> I find this name a little confusing, it sounds too much like the
>> "PCI indirect I/O".
>
> Any better idea ?

Not sure really...  PPC_HOOKED_IO?

>> Get rid of the caps in IoAddress too?
>
> As I said to Arnd, I will do that in a separate patch as I sanitize a
> bit the content of those functions.

Yeah I didn't see that reply yet.  Great to hear you'll do this
cleanup, thanks!

And now to review #2, or did you send #3 already :-)


Segher
