Date: Tue, 6 Jun 2000 16:11:03 -0400
Message-Id: <200006062011.QAA31478@rome.wavemark.com>
From: Kent Borg <kentborg@wavemark.com>
To: dan@netx4.com
CC: tmontgom@miranda.com, linuxppc-embedded@lists.linuxppc.org
In-reply-to: <393D3D63.E3504DE9@embeddededge.com> (message from Dan Malek on
	Tue, 06 Jun 2000 14:05:23 -0400)
Subject: Re: Running from ROM
References: <200006052137.RAA29282@rome.wavemark.com> <393C23CC.3289DD1F@mvista.com> <00060516034300.24189@minotaur.mvista.com> <200006061339.JAA30741@rome.wavemark.com> <393D06BD.ADEDF247@miranda.com> <393D3D63.E3504DE9@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> responded to a post by Tom Montgomery
<tmontgom@miranda.com> with various reasons for why one should not try
to make Linux look like a primative RTOS, ending with:
>I like learning new things.....explain why running from Flash is
>better for your system.

Well, I am not Tom and I don't know much about his system, but I did
open this up by asking the question, so let me give this a shot.

As a preface, let me say that I don't know that it *is* better for us
to run from ROM, only that I suspect it *might* be.  See if the
following makes any sense.

I think the reasons start out at about two.

First is the particulars of how big ROM requirements are vs. RAM.
Flash and RAM come in specific sizes, they are not available one byte
at a time.  If a system has, say, 8 MB of each, and if much of the ROM
is not very compressable data, compressing the ROM contents maybe
doesn't save any parts, yet it might cost in marginal RAM usage,
possibly requiring 16 MB of RAM instead of 8 MB.

The particulars here will change as sizes change and where they fall
on available parts' boundaries change, but it can matter.  In our case
we might have single digit megabytes of code, single digit megabytes
of data, and a need for mallocable data space that starts in high
single digit megabytes and stretches to triple digits (depending upon
how much work the user throws at it).  I am not talking about merely
running the kernel out of ROM (though that seems the easy part), I am
talking about accessing megabytes of code and data without wanting to
spend the time or space necessary in decompresion and copying to RAM.
In some configurations our products might be populated with lots of
RAM, allowing nastier data to be thrown at them before they fail, but
the low-end still needs to function with little RAM, so
architecturally the design needs to carefully conserve RAM.

Decompressing and copying into RAM will not eliminate the need for
flash, merely reduce the need.  The cost savings in flash parts only
happens if you can drop at least one whole part or move to
significantly lessor parts, yet the "cost" in RAM kicks in as that RAM
can no longer be used for other things, and in our case where every
marginal byte of RAM is potentially useful, the costs are immediate.
Unless a significant substitution in parts happens, the fractional
cost advantage of RAM is never realized.

One way to sooner realize the price advantage of RAM would be to only
page needed code into RAM.  But our RAM needs get nastier as lots of
data gets thrown at us, plus, exactly how a user exercises our
features can be unpredictable.  This frightens me as I fear the use of
an unfortuitous combination of features unpredictably pushing us into
thrashing bits through the decompression and copying routines.

Which slides me into my second reason, which is less precise, but
possibly more interesting.

In realtime systems it is the programmers who are expected to
carefully manage time, and to do so they need simple deterministic
control over time.  In our case, we are trying to squeeze a lot out of
a little RAM, you might say we are doing "realspace" programming as
well as "realtime" programming, and to do that we need clear
deterministic control over much of our memory use.  Not relying on a
paging system to make room in which to run our executable code seems
to me part of carefully managing space.  In fact, we go to significant
effort to predict whether, for a given input, we will meet time
deadlines.  Part of that calculation is assuming we can trade time and
space.  The idea of having an unpredictable amount of space available
makes that calculation really scary if not simply impossible.

A couple other notes.

>Flash ROM is typically slower access than DRAM

Not always, a recent project on which I worked had faster access to
flash than it did to RAM.

>Execution from Flash ROM is harder to debug and configure, increasing
>development time.

Who says that development has to happen in flash ROM?  Certainly the
mechanism for executing directly out of ROM needs to be debugged, and
certainly final code needs to be extensively tested in ROM, but why
not do developmentment executing directly from RAM?  In our current
non-Linux environment we we do both RAM and ROM builds, depending upon
what we are doing.  And, yes, I have spent a lot of time learning
exactly what our gdb set up will and will not let me do with a flash
build.

>Why not utilize those [workstation] features when it is beneficial?

Indeed, why not?  I look forward to dropping in extra RAM, mounting a
network disk, possibly dropping in a local disk, and having rather
nice facilities available when developing--but not in the shipping
product.  That means the extra RAM is gone (or available for the user
to use), the disk is gone (or available for the user to use), and my
other Linux box isn't being mounted.

Some products ship in volumes where a few dollars difference in parts
makes a big difference, and even a few cents is noticed.  We are in
that world.  I would very much like to have workstation while
developing, but we can't afford to ship lots of parts dedicated to
being a workstation.

>I can compress the kernel and file system into a single 8-bit device,
>saving substantial board space.

But how much application code can you fit in that 8-bit device?  I am
looking at running megabytes of applications and megabytes data
directly from ROM.

Did I miss anything?


Finally, I repeat that I am not sure it makes sense try to run code
and data directly from ROM, but neither is it obviously a mistake to
want to.  I am trying to understand all of this.

So I am still wondering how we might do this as I worry about possibly
having to muck in the deep innards of MMU manipulating code.


-kb, the Kent who reminds those who think direct code and data access
in Linux is an obvious oxymoron that the term "embedded Unix" would
rather recently have been considered completely laughable.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
