Date: Wed, 28 Jul 1999 22:26:17 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Vger broken w.r.t. gdb
Message-ID: <19990728222617.A636@them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After compiling the current vger 2.3.10 (gcc 2.95
-fno-strict-aliasing), I discovered an odd problem.  Strace works just
fine, but gdb doesn't.  Simply 'gdb ls', run it, quit.  No processes
will die but every new process will recieve a SIGTRAP immediately (not
quite sure if it's before or after the exec() yet).  Ignoring SIGTRAP
seems to make no difference.  We're reaching the function
ProgramCheckException in arch/ppc/kernel/traps.c:

Jul 28 21:07:32 drow kernel: Program check exception at PC: 3000c1a8, SR: 2d032, vector=700

This function includes the code:

        if (regs->msr & 0x100000) {
                /* IEEE FP exception */
                _exception(SIGFPE, regs);
        } else if (regs->msr & 0x20000) {
                /* trap exception */
#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
                if (debugger_bpt(regs))
                        return;
#endif
printk("Program check exception at PC: %lx, SR: %lx, vector=%lx\n",
  regs->nip, regs->msr, regs->trap);
                _exception(SIGTRAP, regs);
        } else {
                _exception(SIGILL, regs);
        }

I don't understand what this is supposed to do.  When are program check
exceptions generated?  And most of all, what are those MSR bits?  The
first one is (1 << 20), or bit 11; this is labeled as Reserved in my
reference.  The second is (1 << 17), or bit 14; this is marked
Implementation Dependent, and a note adds it is unused on the 601.

I would guess that the first one is supposed to check bit 20, or
(1 << 11); that's FE0 and controls recoverable and precise floating
point interrupts, so that would make more sense.  And my hunch is that
the second should be checking MSR_SE (1 << 10, bit 21).

Of course, since this file hasn't changed in an age, that leaves me
completely baffled as to why this was never a problem before.


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
