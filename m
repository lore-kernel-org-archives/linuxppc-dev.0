Date: Tue, 10 Aug 1999 11:00:29 +1000
Message-Id: <199908100100.LAA28784@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
In-reply-to: 
	<Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Mon, 9 Aug 1999 10:17:17 +0200
	(CEST))
Subject: Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

> Jes Sørensen pointed out to me that readl() and friends should not use eieio on
> PPC. On other architectures (e.g. AXP) this isn't done neither.

Readl/writel etc. are intended for "memory" space, but this could be
either memory-mapped device registers or plain ordinary memory.  The
intel folks don't make the distinction because ia32 doesn't allow
reordering of memory accesses AFAIK.

> Hence both inl() and readl() protect against reordering. This is not necessary
> for readl(). Drivers that need to protect against reordering should use
> wmb()/rmb()/mb() theirselves.

Linus made the point in a recent post to linux-kernel that people
shouldn't necessarily expect inb/outb/readb/writeb etc. to be usable
on every kind of bus - it's quite reasonable to define other access
methods on other cpus or buses.

> If readl() and friends don't do eieio, the fbcon-* routines won't be slowed
> down by using readl() and friends (but we're still having the byte swapping
> then).

Do you have any numbers to show how much the eieios slow you down?

If you take out the eieios, you will break other drivers, starting
with the OHCI USB host driver.  Can we think of another way around the
problem?  You could use le32_to_cpup for loading from the frame
buffer, but there isn't currently an equivalent for stores,
unfortunately (one could be invented, though).

> And atyfb should use readl()/writel() instead of aty_{ld,st}_le32(), so we can
> get rid of the inline assembler. Note that this will probably break on Atari,

I thought the point of the aty_ld/st* routines was to avoid one add
instruction each time by using the PPC indexed addressing mode.
Anyway, IMO the aty_ld/st* routines *should* include the eieio.  That
would mean you wouldn't need the explicit eieio() calls scattered
through the rest of the driver.  I guess it's just luck that it works
where you do a sequence of aty_st_le32's to set up some drawing
command and then call wait_for_fifo (or wait_for_idle) which does an
aty_ld_le32.  Or doesn't it matter if the load gets done before all of
the stores have completed?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
