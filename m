Date: Fri, 30 Jul 1999 15:24:26 +1000
Message-Id: <199907300524.PAA03967@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: drow@false.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990730011819.A364@them.org> (message from Daniel Jacobowitz on
	Fri, 30 Jul 1999 01:18:20 -0400)
Subject: Re: Vger broken w.r.t. gdb
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990728222617.A636@them.org> <199907290400.OAA02618@tango.anu.edu.au> <19990729013842.A1209@them.org> <199907290548.PAA02760@tango.anu.edu.au> <19990730011819.A364@them.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz <drow@false.org> wrote:

> Now I'm really confused.
> 
> >From my readings it appears that we should only reach this point if a
> trap instruction was encountered.  But from what I can see no trap
> instruction exists at that address.  At

A common thing that gdb does is to put trap instructions into the
memory image of a process being debugged.  It sounds to me as though,
with all the page cache and memory management changes that have gone
on in 2.3, we now have the undesirable situation that a trap
instruction put in by gdb hasn't stayed confined to the process being
debugged but has leaked into the copy of the page that is being used
by other processes.

> Perhaps something having to do with instruction caching by the
> processor?  This is a completely wild guess, but if a trap instruction
> was encountered, and then gdb cleared it, and the instruction cache was
> not flushed...

Well, whatever the problem is, it's something new in 2.3, it's not a
long-standing omission of some cache flushing stuff.  It's far more
likely to be something in the ptrace syscall code which hasn't been
correctly updated to cope with the recent page cache and VM changes.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
