Date: Tue, 30 Oct 2001 02:42:52 -0800 (PST)
From: Gary Byers <gb@gse.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: floating-point under ppc/linux
In-Reply-To: <15326.8355.242681.874353@cargo.ozlabs.ibm.com>
Message-ID: <Pine.GSO.4.21.0110291939370.13591-100000@gse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Oct 2001, Paul Mackerras wrote:

>
> Is there anyone on this list who does, or wants to do, serious
> floating point computations on PPC?  I know that our FP exception
> handling is a bit, um, deficient and I would like to fix it, but I
> would like some advice about what would be the most useful way to have
> it work.
>

OpenMCL (http://openmcl.clozure.com) is a Common Lisp development
environment; CL programs (and CL programmers) expect a fairly high
degree of control over exceptional situations (including FP exceptions.)

> I am thinking that the FE0 and FE1 bits in the MSR will be set
> according to the disposition of the SIGFPE signal: SIG_IGN => 00
> (disabled), SIG_DFL => 01 (imprecise nonrecoverable mode), user
> handler => 10 (imprecise recoverable mode).
>

Note that some PPC implementations (e.g., the 750) consider any
combination of the FE0/FE1 bits other than 00 to imply precise mode;
it seems like "precise" and "disabled" are the only modes that can be
portably supported.  I don't what considerations led the 750's
designers to make this change and don't know whether it's a trend or
an isolated case.

Current SIGFPE handlers may assume (as OpenMCL's does) that FP
exceptions are reported precisely. OpenMCL's handler tries to report
the offending operation and its operands to higher-level code; if the
exception's reported "imprecisely", this would likely require some
changes to the handler.  I don't know if it would always be possible
to reliably identify the operation if the exception's reported in
an imprecise mode.

If the handler had to deal with different behavior on different
CPU/Linux kernel combinations, ... well, I'd like there to be some way
to know what FPU exception mode is actually in effect.

I'm kind of neutral on whether establishing a SIGFPE handler should
affect the FE0/FE1 bits; since there are performance/revoverability
tradeoffs, it's not clear that there's an appropriate, one-size-fits-all
default.  It seems best to me to let the application evaluate those
tradeoffs (by providing an independent means to get/set those bits.)

Current kernels seem to try to support changes to these bits that
are made by signal handlers; since current kernels set those bits
to 11 whenever reawakening the FPU, those changes are short-lived.
The MSR[FP,FE0,FE1] bits all seem to be clear in the regs->msr
field that's passed to a signal handler; I can understand why this
would be true much of the time, but find it a little puzzling that
it seems to be true every time I've looked.

> What I am not sure about is whether we should change FE0/FE1 when
> SIGFPE is blocked.
[...]
> In other words, if a program blocks SIGFPE, does something that
> generates a floating-point exception, then clears the exception status
> in FPSCR, then unblocks SIGFPE, should it get a SIGFPE signal
> delivered to it at that point?

I have to admit that I find the concept of blocking synchronous,
hardware-generated signals (SIGFPE, SIGILL, SIGTRAP, SIGSEGV, ...)
pretty hard to understand.  I think that it's correct to think of
SIGFPE as being more like SIGILL than like SIGINT.

If a program that generally wants FP exceptions to be signalled wants
to prevent a particular sequence of FP operations from generating a
SIGFPE, it seems like there are already mechanisms (manipulation of
the FPSCR 'enable' bits) that allow it to do so inexpensively.

> Finally, is it reasonable to say that it is the responsibility of the
> signal handler to clear FEX, by clearing either the status or enable
> bit for the exception that occurred?
>

I found that it was non-trivial for a signal handler to do any FP
operation (including those operations that'd be required to load
new values into the FPSCR) without triggering another FP exception.

This seemed to be happening because the FPU was disabled (MSR[FP] == 0)
when the handler was called and was reenabled when the handler tried
to use the FPU.  Reenabling the FPU when the FPSCR[FEX] bit and MSR[FE0/FE1]
bits are set seemed to cause the exception to be raised again.

I'd see this behavior on LFD instructions in the handler (and, as we
all know, "FP loads and stores can't cause FP exceptions.")  I assume
that the FPU is a little groggy after waking up from its nap, and
understandably is a little confused about whether or not an exception
has already been generated.

That sort of implies that

 a) if a SIGFPE handler wants to use the FPU, it has to get a benign
    value (one with the FEX bit clear) into the FPSCR before doing so.
    (See (b), below.)
 b) the most obvious ways of getting a benign value into the FPSCR
    involve use of the FPU.  (See (a), above.)

It's amazing how quickly a modern processor can overflow its stack.

I found a rather convoluted way around this, but while I was debugging
the problem I found that other Unix processes running on the same
machine would sometimes die with spurious SIGFPE exceptions; I believe
that I've seen some similar behavior reported by other members of this
list (though I'm not sure that I understand what causes this.)

Both of these considerations lead me to conclude that the kernel
should make the FPSCR have benign contents as soon as possible after
an FP exception.

ELF_NFPREG is 33; it -looks- to me like kernel functions like
setup_frame() (in linux/arch/ppc/kernel/signal.c) have enough information
to ensure that the signal handler is called with a benign value in
its own FPSCR (and the offending FPSCR value in the handler's sigcontext.).

	regs->gpr[1] = newsp;
	regs->gpr[4] = (unsigned long) sc;
	/* Please forgive the following; other alternatives seem at
	   least as ugly.  Of course PT_FPSCR isn't addressing a gpr ...
	*/
	regs->gpr[PT_FPSCR] &= ~FPU_RESERVED; /* a benign value */
	...

Unfortunately, I haven't been able to reproduce the problem whereby
random processes start getting spurious SIGFPEs as soon as some process
gets a "real" one; I assume that this has something to do with the
way in which FPU registers (including the FPSCR) are lazily saved and
restored.  I don't know whether or not it might be necessary to clear
the FEX bit a little sooner to fix this problem.

It's extremely desirable that the copy of the FPSCR that's provided to
the handler in its context->regs argument is valid; if a handler wants
to somehow fix things and resume, it seems reasonable to me to expect
it to clear the FPSCR[FEX] bit - and whatever other bits are causing
it to be set - in the context->regs structure before returning.

> Opinions?

Lots of 'em; hope they make sense.

>
> Paul.
>

Gary Byers
gb@gse.com
gb@clozure.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
