Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 4E1B2DDECE
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 06:24:53 +1000 (EST)
Message-ID: <466323EF.5040807@ru.mvista.com>
Date: Mon, 04 Jun 2007 00:26:23 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
	<548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
In-Reply-To: <548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>>>>> You obviously completely misunderstand the semantics
>>>>> of the "compatible" property.

>>>>    Oh well, on the chip level, your "compatible" prop would be correct.

>>> This has nothing to do with a "chip level", it is plain and
>>> simply the most basic device tree stuff.

>>    If it was as "plain and simple" as you say, there would be nothing 
>> to argue about.

> There isn't as far as I am concerned; the purpose and
> meaning of the "compatible" property, as well as of any
> other standard OF properties, is clear.

    Erm, concerning matching those with drivers it wasn't as clear that those 
props aren't the same as driver names b/c of the follwing passage in Generic 
Names:

"It is possible that the operating system will find a driver matching the 
generic name, and that said driver will not be the correct one. However, this 
is not a new problem, because generic names have already been used in the past 
for built-in devices. Consequently, an operating system that does not already 
have a mechanism for resolving or avoiding such false matches is likely to 
have problems eventually, with or without the proliferation of generic names.

The following suggests some possible techniques for dealing with such false 
generic matches.

a) In collections of OS drivers, avoid the use of generic names for the 
drivers themselves. For example, it is generally unwise to name a driver 
ethernet, since there are many different ethernet adapters with different 
programming models. Using the generic name ethernet to identify only one such 
driver is presumptuous.

b) Separate the OS's name spaces for drivers for real hardware devices and 
pseudodrivers (collections of support routines that are used by real drivers). 
Some operating systems load such pseudo-drivers using a mechanism similar to 
the mechanism used for real drivers. Pseudo drivers often perform generic 
functions that apply equally well to, for example, all ethernet adapters, 
independent of their low-level programming models. Consequently, it is 
reasonable to use generic names (e.g. ethernet) for such pseudodrivers. 
Separating the name spaces of real drivers and pseudo-drivers avoids false 
matches from generic device names to generic psuedo-driver names.

c) Make the OS's driver search mechanism depend upon the device's parent. In 
other words, separate the OS's driver name spaces so that drivers for devices 
that attach to, for example, PCI bus can be distinguished from those that 
attach to, for example, ISA bus. This reduces the range over which false 
matches can occur.

d) For cases where false matches are unavoidable (for example, if there is an 
existing driver with a generic name that must be retained for backwards 
compatibility) allow the drivers that can be incorrectly matched the 
possibility of rejecting the match. One technique for doing so is to for the 
driver to inspect the compatible property to ensure that it is appropriate. 
Another common technique is to have the generic driver probe the hardware to 
see if it behaves as expected (although this technique can cause problems)."

    Well, I've already pointed that out in the past...

>> What we ended up with is 2 or 3 level hierarchy of nodes which doesn't 
>> at all seem to be such simple (considering the fact that what's 
>> covered by a the simple "bank-width" property could be represented by 
>> several combinations of interleaved flash chips).

> Yes, the more complex (and sometimes insane) ways that
> flash chips are connected to systems can be really hard
> to describe properly.  Which is why I don't even want
> to make a "binding" for it (yet).  It seems easy enough

    Neither do we. :-)

> to do this for single flash chips (possibly direct-mapped)
> though.

    Erm, FSL boards seem to generally have dual 16-bit NOR flash chips 
interleaved -- and that's seems quite a common case, not only in PPC world.
    Perhaps... those interleaved chips could really be merged (abstracted) 
into a single one, with the bus width being a sum of two?

>>  (either that or over-engineer the physmap_of driver to gather that 
>> kind of information from the multiple "chip" subnodes).

> I would say it is overengineered already.  It shouldn't
> try to be a general solution for all possible cases since
> it has no hope of achieving that.

    It's not trying to be such a general solution, it's just trying to handle 
all the cases of simply-mapped NOR flashes, just like its non-OF counterpart does.

>  Get the simple cases
> (that actually are used in real life) right, first.

    We pursued this task exactly. Get it working, quick. :-)

> Segher

WBR, Sergei
