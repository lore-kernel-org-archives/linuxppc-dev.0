Date: Wed, 6 Mar 2002 18:37:45 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200203070237.g272bjh00185@dave.home>
To: dan@embeddededge.com
Subject: Re: mmap wrapping around to 0 revisited
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>It's not a bug that causes a system failure, just a feature that doesn't
>work correctly.  The only people I knew that were affected by this (which
>included me and why I would fix it) were the ones that had a user application
>flash programmer, and had to access the upper address space on PowerPCs.
>Since MTD is now working well, it is easier to just program/read flash with
>that "device", so I never need to do an mmap() like that anymore.
>
>The use of mmap() to physical addresses via user applications is a dangerous
>programming practice anyway.  It's a convenient hack for some quick testing,
>so if it mostly works in a controlled environment that's OK.  It's not the
>way you should be designing production systems (or the way I would do it).

I originally tried using the mtd and it worked once to program the flash
in the box. Then it wouldn't work anymore. We already had a flash utility
from another OS, so it was easy getting that to work reliably, using
mmap of /dev/mem.

XFree86 happily makes use of mmap of /dev/mem to do all its buffer
manipulation. I've seen drivers provided directly from the manufacturer
of IC's do the bulk of their coding within the user space program, and
just the interrupt handler in the kernel code. The case I'm thinking of
didn't do mmap of /dev/mem, but the kernel part did exactly what /dev/mem
does when the mmap function is called.

For testing mmap of /dev/mem has been invaluable in getting drivers going.
I can get something working in user state with little risk of crashing, then
when it is stable roll it into a kernel module.

>
>> .... Where does the fault lie? Who do I need to pass that fix on in
>> order to get it into the kernel? Who is the gatekeeper here keeping
>> the bugs in place?
>
>Relax :-).  This is supposed to be fun.  Everyone contributes, mistakes are
>made, others fix them, it's the beauty of working like this.  In the end
>we end up with something substantially better than any of could have on our
>own.  If you are trying to make a product, you need to understand the history
>of the development, take a snapshot that best meets your requirements,
>stabilize it, use it, and test it (or pay someone to do that).

It is fun, for example just the past few days I was able to write an audio
driver for our chip from the ground up. It is nice doing original coding again
for a while, rather than fixing the bugs that have already been fixed. There
is nothing fun about that, and when you finally figure out the bug after
days of concentrated effort and you find out someone says "Oh, I knew that,"
well, you kind of think something is broken in the system. And you're left with
a pretty hollow feeling when you hoped to have a good feeling about finding
a bug, and wanting to contribute your fix back to the linux community.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
