Date: Sun, 19 Mar 2000 03:46:24 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb: please test!
Message-ID: <20000319034624.A8893@drow.res.cmu.edu>
References: <20000318143259.A11235@drow.res.cmu.edu> <200003190830.JAA00344@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003190830.JAA00344@piglet.grunz.lu>; from mlan@cpu.lu on Sun, Mar 19, 2000 at 09:30:55AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 19, 2000 at 09:30:55AM +0100, Michel Lanners wrote:
> Hi Dan,
>
> On  18 Mar, this message from Daniel Jacobowitz echoed through cyberspace:
> > Well, first of all, there are two different 'current' controlfb's.  One
> > of them is in the PPC 2.2 tree and the other in the 2.3 tree (both
> > bitkeeper), I believe.  Did you try both of those?  I'm pretty sure I
> > fixed this quite thoroughly in one or the other.
>
> 2.2 works well for me, but doesn't seem to work for Andrew Fyfe,
> according to the comments in 2.3. 2.2 detects my 4M, 2.3 doesn't.
>
> > Actually, on closer look, I thought that the 2.3 code was correct.
> > Could you compare to Andrew's observations in the comment above the
> > code?  Is he wrong?  I certainly can't see how his comment would be
> > unless there is a memory scheme he was not detecting, and I do not
> > think there is.
>
> At least his code and comments are not _entirely_ correct for my
> machine. Here's what I've found so far:
>
> - control manages mem in chunks of 2M (a pair of DIMMs), within a
> region of 8M in size.
> - 2M in bank 1, and 4M, are accessed at offset 0x0.
> - 2M in bank 2 are accessed at offset 6M.
> - the 2.3 code doesn't detect the mem at 2M in my case. It seems
> writing to 0x0 garbles the memory contents at 2M: write to
> 2M, write to 0x0-garbling 2M, detect 0x0, detect 2M-garbled, so nothing
> detected.

Aha!  This signifies a much bigger problem.  If the write to 0M garbles
the read from 2M, than the two are actually the same memory location!
It's my understanding that if only 2M is present it can be accessed at
0M and 2M (and possibly other offsets).  Does that seem to be wrong for
you?  Perhaps it can only be accessed when in a mode that requires it?

> I'll speed up then ;-)
>
> The next step is to compile a better detection check, that can detect
> mirrored memory regions, so that I can find out what's wrong between
> 0x0 and 2M..... It's actually very strange, as my 4M do work when
> accessed in one block starting at 0x0... so 2M would have to be
> different from 0x0 ???

Try running the check after switching to a vmode which requires more
than 2M, please.

> By the way, somewhere I have an alternate OF driver for control, that
> IIRC came out of darwin, and it ver accesses VRAM only at 0x0 or 6M....
> Unfortunately, it's too big to fit into nvramrc ;-))

Hmmm.......

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
