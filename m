Date: Fri, 30 Jul 1999 01:18:20 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Paul.Mackerras@cs.anu.edu.au
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Vger broken w.r.t. gdb
Message-ID: <19990730011819.A364@them.org>
References: <19990728222617.A636@them.org> <199907290400.OAA02618@tango.anu.edu.au> <19990729013842.A1209@them.org> <199907290548.PAA02760@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199907290548.PAA02760@tango.anu.edu.au>; from Paul Mackerras on Thu, Jul 29, 1999 at 03:48:59PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 29, 1999 at 03:48:59PM +1000, Paul Mackerras wrote:
> Daniel Jacobowitz <drow@false.org> wrote:
> 
> > So my question is, what is at 0x3000c1a8?  It would appear, if I am not
> > misreading binfmt_elf.c, to be the program itself in its original
> > mmap'd location.  I'm not at all confident of that conclusion, though.
> 
> Cat /proc/<pid>/maps while you have the ls process stopped at an
> appropriate point.
> 
> > So regs->msr is actually from SRR1 of the running program?  Does it
> > generally get stuffed back into the MSR when that task is running?
> 
> Yep, but the high bits get ignored.

Now I'm really confused.

>From my readings it appears that we should only reach this point if a
trap instruction was encountered.  But from what I can see no trap
instruction exists at that address.  At
<http://www.them.org/~drow/check-core> is a core dump I obtained while
my system was in this confusing state; check-test in the same directory
is the program responsible.  The instruction appears to be in
_dl_debug_state from what I can tell, but no trap instruction was
present there.

Perhaps something having to do with instruction caching by the
processor?  This is a completely wild guess, but if a trap instruction
was encountered, and then gdb cleared it, and the instruction cache was
not flushed...

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
