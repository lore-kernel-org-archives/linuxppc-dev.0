Date: Thu, 29 Jul 1999 01:38:42 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Paul.Mackerras@cs.anu.edu.au
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Vger broken w.r.t. gdb
Message-ID: <19990729013842.A1209@them.org>
References: <19990728222617.A636@them.org> <199907290400.OAA02618@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199907290400.OAA02618@tango.anu.edu.au>; from Paul Mackerras on Thu, Jul 29, 1999 at 02:00:39PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 29, 1999 at 02:00:39PM +1000, Paul Mackerras wrote:
> 
> Daniel Jacobowitz <drow@false.org> wrote:
> 
> > After compiling the current vger 2.3.10 (gcc 2.95
> > -fno-strict-aliasing), I discovered an odd problem.  Strace works just
> > fine, but gdb doesn't.  Simply 'gdb ls', run it, quit.  No processes
> > will die but every new process will recieve a SIGTRAP immediately (not
> > quite sure if it's before or after the exec() yet).  Ignoring SIGTRAP
> > seems to make no difference.  We're reaching the function
> > ProgramCheckException in arch/ppc/kernel/traps.c:
> > 
> > Jul 28 21:07:32 drow kernel: Program check exception at PC: 3000c1a8, SR: 2d032, vector=700
> 
> That address looks to be in some shared library.  I haven't been using
> 2.3.x lately (it dies somewhere near `starting crond' on my SMP
> powermac), but I would suspect that the ppc ptrace code needs some
> work.  It looks like gdb is inserting a trap instruction in a shared
> library which is going into the in-memory copy of the page rather than
> into a copy of the page.

Well, that came from running /bin/ls:
drow:/usr/src/kernel/linux/arch/ppc/kernel$ ldd /bin/ls
        libc.so.6 => /lib/libc.so.6 (0x016ba000)
        /lib/ld.so.1 => /lib/ld.so.1 (0x08000000)

And ls itself loads at 0x01800000 from what I can tell/remember.

0x30000000 seems to be where things are being mmap()'d.  Well, more or
less.  Relevant snippets:

execve("/bin/ls", ["ls"], [/* 21 vars */]) = 0
brk(0)                                  = 0x184d7cc
open("/etc/ld.so.cache", O_RDONLY)      = 3
mmap(0, 30308, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30014000
close(3)                                = 0

Ahah, the first mmap was above the address we died at.

open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=0200000, st_size=933225093, ...}) = 0
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\2 \30"..., 4096) = 4096
mmap(0x16ba000, 1268792, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x16ba000
mprotect(0x1799000, 355384, PROT_NONE)  = 0
close(3)                                = 0
munmap(0x30014000, 30308)               = 0

libc itself gets mapped in lower.

So my question is, what is at 0x3000c1a8?  It would appear, if I am not
misreading binfmt_elf.c, to be the program itself in its original
mmap'd location.  I'm not at all confident of that conclusion, though.

> 
> > I don't understand what this is supposed to do.  When are program check
> > exceptions generated?  And most of all, what are those MSR bits?  The
> 
> The program check exception is generated for various conditions such
> as floating-point exceptions, illegal instructions, privileged
> instructions in user mode, or trap instructions.  On a program check
> exception, the CPU copies the MSR into the SRR1 register and then sets
> one or more of the high bits of SRR1 to indicate the cause of the
> exception.  The regs->msr value actually comes from the SRR1 register.

So regs->msr is actually from SRR1 of the running program?  Does it
generally get stuffed back into the MSR when that task is running?

> > first one is (1 << 20), or bit 11; this is labeled as Reserved in my
> > reference.  The second is (1 << 17), or bit 14; this is marked
> > Implementation Dependent, and a note adds it is unused on the 601.
> 
> You need to look at the SRR1 bit settings for the program check
> exception.

... which I don't have a reference to at the moment.  Is this sort of
thing in the Motorola documentation for the processor?  I would hope
so.  I'll look through that tomorrow.


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
