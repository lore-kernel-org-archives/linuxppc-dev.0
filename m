Message-Id: <200003190830.JAA00344@piglet.grunz.lu>
Date: Sun, 19 Mar 2000 09:30:55 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb: please test!
To: drow@false.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000318143259.A11235@drow.res.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan,

On  18 Mar, this message from Daniel Jacobowitz echoed through cyberspace:
> Well, first of all, there are two different 'current' controlfb's.  One
> of them is in the PPC 2.2 tree and the other in the 2.3 tree (both
> bitkeeper), I believe.  Did you try both of those?  I'm pretty sure I
> fixed this quite thoroughly in one or the other.

2.2 works well for me, but doesn't seem to work for Andrew Fyfe,
according to the comments in 2.3. 2.2 detects my 4M, 2.3 doesn't.

> Actually, on closer look, I thought that the 2.3 code was correct.
> Could you compare to Andrew's observations in the comment above the
> code?  Is he wrong?  I certainly can't see how his comment would be
> unless there is a memory scheme he was not detecting, and I do not
> think there is.

At least his code and comments are not _entirely_ correct for my
machine. Here's what I've found so far:

- control manages mem in chunks of 2M (a pair of DIMMs), within a
region of 8M in size.
- 2M in bank 1, and 4M, are accessed at offset 0x0.
- 2M in bank 2 are accessed at offset 6M.
- the 2.3 code doesn't detect the mem at 2M in my case. It seems
writing to 0x0 garbles the memory contents at 2M: write to
2M, write to 0x0-garbling 2M, detect 0x0, detect 2M-garbled, so nothing
detected.

> I have a bunch of other patches to merge for controlfb anyway, so now
> is a good time to straighten this out... with luck and speed we can get
> a fix into 2.3.99preX.

I'll speed up then ;-)

The next step is to compile a better detection check, that can detect
mirrored memory regions, so that I can find out what's wrong between
0x0 and 2M..... It's actually very strange, as my 4M do work when
accessed in one block starting at 0x0... so 2M would have to be
different from 0x0 ???

By the way, somewhere I have an alternate OF driver for control, that
IIRC came out of darwin, and it ver accesses VRAM only at 0x0 or 6M....
Unfortunately, it's too big to fit into nvramrc ;-))

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
