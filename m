Date: Fri, 24 Aug 2001 17:44:53 -0500 (CDT)
Message-Id: <200108242244.f7OMirY15080@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
In-reply-to: <15236.22289.93463.203180@cargo.ozlabs.ibm.com> (message from
	Paul Mackerras on Thu, 23 Aug 2001 11:06:25 +1000 (EST))
Subject: Re: assorted kernel patches - IABR/DABR & MSR[RI]
References: <200108222112.f7MLCTt439203@saturn.cs.uml.edu> <15236.22289.93463.203180@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras replied:

> > 1. Support for hardware breakpoints for process threads.
>
> A good idea in general although I will be interested to see
> how this interacts with xmon's and kgdb's use of iabr/dabr.

My goal was to support IABR/DABR for user application debug under gdb.

The sole instruction-breakpoint may be of limited use.  But it may be
possible to use it for the silent breakpoint gdb sets in _dl_debug_state
in the dynamic loader.  This may eliminate the need for a r/w copy of
the shared library. The data breakpoint should prove useful as a watchpoint.

One option is to have the iabr/dabr in xmon override the user.

I took Albert's challenge and looked at the x86 port.  For reference:

do_debug in i386/kernel/traps.c is the hardware trap interrupt
handler.  It essentially calls force_sig_info(SIGTRAP), disables the
breakpoint, and returns.  It has one trick, for traps in the kernel
si_addr is set to the address of the user instruction which called the kernel.

The other references to the breakpoint register (debugreg) are:
- __switch_to,  if thread->debugreg[7] is non-zero, enable breakpoints by loading debugregs
- do_signal,    re-enable breakpoints by loading debugreg[7] before calling handle_signal.
- flush_thread, clear current->thread.debugreg[]
- ptrace,       peek and poke debugreg, restricting breakpoints below TASK_SIZE

I must be missing something, though.  I don't see where the unconditional disable
is done when switching out a process which uses breakpoints to one which doesn't.

> >    - Add iabr and dabr to the end of the pt_regs structure.
>
> Why save them there rather than in the thread_struct?

I was going to move them to the thread struct to match x86, but I
just noticed that 4xx now uses two of the four empty pt_reg slots for DBCR0
and DBCR1 (This is space before PT_FPR0).  I guess it should match 4xx so
how about putting DABR in DBCR0 and IABR in DBCR1.

> Do you change them on every kernel entry from userspace?

I would follow the x86 example and only load on switch.  This allows
watching any kernel access to userspace.  The ptrace interface
provides the security.

> >    - add IABR and DABR register numbers for ptrace
>
> Is this so that gdb can change them?

Yes.

> In any case this is all vapor since Ed Swarthout has not posted his
> patches for us to look at, nor has he sent them to me.

I'm sync'ing up to linuxppc_2_4_devel and should be able to provide
patches for discussion shortly.

> > > > 2. Allow superviser (MSR[PR]=0) user threads.
> > > >    Currently MSR[PR] has a second purpose which indicates
> > > >    the thread was in kernel mode on exception.
> > >
> > > Hmmm, you'll need to explain exactly why this is a good idea
> > > and why it won't break anything. Without a good strong argument
> > > I would be inclined to reject this. I don't see what you can do
> > > with a "user" thread running in supervisor mode that you can't
> > > do with a kernel module.
> >
> > It is good for experimenting with processor features.
> >
> > On an embedded system, it is often nice to turn off interrupts
> > to do a bit of super-hard real-time from userspace. The user code
> > may well be incompatible with the kernel. (non-GPL C++ or FORTRAN)
>
> OK, I can buy that argument.  The way that Ed described that he
> implemented this sounded to me like it maybe wasn't the best way to do
> it but without seeing any actual code we can't usefully discuss it any
> further.

I want to allow special applications to be able to do any instruction
and I want to keep the standard ptrace/signal process model for them.

> > > > A different bit needs to indicate this.  A good alternative is MSR[RI].
> > > >
> > > >    - change user_mode() to reference MSR_RI instead of MSR_PR
> > > >    - change copy_thread to use the user_mode macro instead of MSR_PR

> Huh?  Why is RI good?

It is not used for anything today and hardware maintains its value.
I'm open to any other method.

-Ed

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
