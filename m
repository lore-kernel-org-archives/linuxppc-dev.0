From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15174.24815.352088.954640@cargo.ozlabs.ibm.com>
Date: Sat, 7 Jul 2001 11:07:59 +1000 (EST)
To: Gary Byers <gb@gse.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: giving up the FPU, MSR[FE0], MSR[FE1], and the FPSCR
In-Reply-To: <Pine.GSO.4.21.0106260032030.15923-100000@gse.com>
References: <Pine.GSO.4.21.0106260032030.15923-100000@gse.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gary Byers writes:

> Sometime in the last year or two (sorry not to be more precise; I
> wasn't paying attention) the linuxppc kernel seems to have started
> doing lazy FPU switching.  If I read the code (in

No, that code is older than that, I think it dates from 96 or 97. :)

> ../arch/ppc/kernel/head.S) and judge its effects correctly, code in
> load_up_fpu() unconditionally sets the FE0 and FE1 bits in the MSR.  I
> wonder if this change (setting the bits) was intentional: there's
> still some code in ./signal.c and ./ptrace.c that tries to allow
> signal handlers/ptrace to change those bits, though I don't know if
> that's ever worked.

I believe that does work and that glibc uses it.  Not that that is the
ideal way to handle it...  Albert Cahalan's suggestion of setting
FE0/FE1 based on the disposition of the SIGFPE signal is a good one.

I'm not totally sure yet what to do when SIGFPE is blocked though - I
guess if we get a floating-point exception and SIGFPE is blocked we
should clear FE0/FE1 and continue.  Maybe we should clear the
exception enable bits in the FPSCR too, although I would rather not.
I don't like the idea of the kernel frobbing the FPSCR when the
process is not expecting it, but on the other hand you may get
surprising results if you do a floating-point operation that causes an
exception, and the exception enable bit in the FPSCR is set, but
FE0/FE1 are zero.  (Section 3.3.6 of the Programming Environments
Manual describes this.)  But then I guess if you are doing
floating-point stuff with SIGFPE blocked you presumably know what you
are doing... :)

> It seems that when a user-level SIGFPE handler begins execution, its
> own FPSCR[FEX] (and other exception-related bits in the FPSCR) are set
> and the FPU (MSR[FP, FE0, FE1]) is disabled.  (I'd be more confident

Interesting... I guess you are right but I haven't found the code that
does that yet. 8-)

> It seems like any attempt to use the FPU inside the SIGFPE handler
> cause the kernel to turn it back on (setting MSR[FP, FE0, and FE1]);
> with FPSCR[FEX] set, this seems to raise SIGFPE again; attempts to
> clear FPSCR[FEX] from user code involve ... well, they involve using
> the FPU again.

OK.  The question I have here is whether the signal handler should
have its own FPSCR value.  I notice that the signal delivery code in
the kernel saves the floating-point registers (fr0 - fr31) on the
stack, and restores them in sys_sigreturn, but doesn't do anything
with FPSCR.  Arguably it should save and restore FPSCR and initialize
the FPSCR to 0 for the signal handler.  That would mean a change to
the signal stack layout though, and it would mean that if the signal
handler wanted to change the FPSCR used by the program (e.g. to clear
the exception status bits) it would need to find and change the value
on the stack rather than changing the FPSCR directly.

> While I was puzzling over that (stepping through a SIGFPE handler in
> gdb), I noticed something disturbing: some newly created processes
> (grep and more and other random programs) started dying with unhandled
> "Floating point exception" messages.  I'm at a loss to explain this,
> but I saw it happen often enough to be convinced that I'm not imagining
> the behavior.  I do wonder whether "lazily" enabling the FPU (and
> enabling FPU exceptions) when FPSCR[FEX] may be set is really a good

In fact the MSR[FP] bit has no effect on whether the cpu will take a
floating-point exception (the 0x700 program exception, not the FP
unavailable exception, I mean).  It's fairly clear now that
setting/clearing FE0 and FE1 at the same time as FP is not the right
thing to do.

> I guess that I'm reporting a bug (or a few bugs) here; I certainly
> understand the motivation behind doing lazy FPU switching, but question
> whether it's done with adequate care when FP exceptions are enabled.

Certainly the current behaviour is suboptimal; we can fix it but first
we need to discuss what the Right Way (tm) to do things would be.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
