Date: Thu, 29 Jul 1999 14:00:39 +1000
Message-Id: <199907290400.OAA02618@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: drow@false.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990728222617.A636@them.org> (message from Daniel Jacobowitz on
	Wed, 28 Jul 1999 22:26:17 -0400)
Subject: Re: Vger broken w.r.t. gdb
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <19990728222617.A636@them.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz <drow@false.org> wrote:

> After compiling the current vger 2.3.10 (gcc 2.95
> -fno-strict-aliasing), I discovered an odd problem.  Strace works just
> fine, but gdb doesn't.  Simply 'gdb ls', run it, quit.  No processes
> will die but every new process will recieve a SIGTRAP immediately (not
> quite sure if it's before or after the exec() yet).  Ignoring SIGTRAP
> seems to make no difference.  We're reaching the function
> ProgramCheckException in arch/ppc/kernel/traps.c:
> 
> Jul 28 21:07:32 drow kernel: Program check exception at PC: 3000c1a8, SR: 2d032, vector=700

That address looks to be in some shared library.  I haven't been using
2.3.x lately (it dies somewhere near `starting crond' on my SMP
powermac), but I would suspect that the ppc ptrace code needs some
work.  It looks like gdb is inserting a trap instruction in a shared
library which is going into the in-memory copy of the page rather than
into a copy of the page.

> I don't understand what this is supposed to do.  When are program check
> exceptions generated?  And most of all, what are those MSR bits?  The

The program check exception is generated for various conditions such
as floating-point exceptions, illegal instructions, privileged
instructions in user mode, or trap instructions.  On a program check
exception, the CPU copies the MSR into the SRR1 register and then sets
one or more of the high bits of SRR1 to indicate the cause of the
exception.  The regs->msr value actually comes from the SRR1 register.

> first one is (1 << 20), or bit 11; this is labeled as Reserved in my
> reference.  The second is (1 << 17), or bit 14; this is marked
> Implementation Dependent, and a note adds it is unused on the 601.

You need to look at the SRR1 bit settings for the program check
exception.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
