Message-Id: <200003152038.VAA00473@piglet.grunz.lu>
Date: Wed, 15 Mar 2000 21:38:39 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
To: bh40@calva.net
cc: paubert@iram.es, linux-fbdev@vuser.vu.union.edu,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000315123150.025617@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:

>>> #define _IO_BASE       0
>>>
>>> breaks CHRP and PReP boxes that use plain ISA drivers (inb() and friends).
>>
>>Indeed, but that's unavoidable. Except that the breakage has to wait for
>>2.5 to be acceptable. Given the choice I prefer to break this and properly
>>use resources even for drivers which believe that they have to use fixed
>>addresses assigned by God, or rather the devil given the mess that the PC
>>`architecture' is.
>
> Well, we need a fix _now_ (that I will backport to 2.2.x as soon as
> possible too), at least for PowerMacs.

Hmmm, I do vote for a solution like mine _right now_ for PMac, given
that PRep and CHRP do use real ISA. That means the above #define can't
be used, but we need to get back to a working ppc_md.something aproach.

This leaves time to implement a unified solution for 2.5, but that
solution needs to be coordinated with other platforms.

> The problem of ISA drivers with
> legacy hard-coded addresses is indeed a real one, but it can be
> temporarily worked around by having the kernel maintaing a separate
> mapping of the "old" IO base to the legacy ISA bus if one exist.

That would be difficult to implement... as all inb() and friends
include the _IO_BASE offset. Either you remove that, and you need to
map the ISA bus at kernel address 0x0, or you leave it in, but then
inb() are unusable from drivers using 'corrected' IO ports.

> We have, I think, no legacy code using /proc/bus/pci, do we ? If I'm
> right, then we can change it to return physical addresses without
> breaking anyone so at least we have a temporary fix for XFree. We must
> get the kernel<->userland interface right asap so that we don't need to
> change XFree again and again.

Agreed. But, now that I think about it: what address space should the
'translated' port be in? Processor physical or kernel virtual? They are
the same for the addresses I've come across on my PMac, but they need
not be... PMac bridge init code ioremap()'s the IO region; is that the
same on other platforms/architectures?

> I'll play a bit with Michel patches next week-end. Unfortunately, I can't
> test much on 2.3.x until the OHCI driver is fixed.

Good luck!

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
