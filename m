Date: Thu, 28 Jun 2001 18:32:10 -0400 (EDT)
Message-Id: <200106282232.f5SMWA8406538@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linuxppc-dev@lists.linuxppc.org
Cc: gb@gse.com
Subject: Re: giving up the FPU, MSR[FE0], MSR[FE1], and the FPSCR
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Sometime in the last year or two (sorry not to be more precise; I
> wasn't paying attention) the linuxppc kernel seems to have started
> doing lazy FPU switching.  If I read the code (in
> ../arch/ppc/kernel/head.S) and judge its effects correctly, code in
> load_up_fpu() unconditionally sets the FE0 and FE1 bits in the MSR.  I

If the user does not want traps, both FE0 and FE1 should be set
to 0 in addition to FPSCR being set to zero. This is supposed to
perform best.

If the user does want traps, the kernel should choose:

If a debugger is attached or a SIGFPE handler is present,
then FE0 and FE1 should both be 1. (precise mode)

Otherwise, FE0 should be 0 and FE1 should be 1. This is the
imprecise non-recoverable mode, which may be faster.

> It seems that when a user-level SIGFPE handler begins execution, its
> own FPSCR[FEX] (and other exception-related bits in the FPSCR) are set
> and the FPU (MSR[FP, FE0, FE1]) is disabled.  (I'd be more confident
> in saying that than I am if gdb 5.0 had ever heard of a register
> called the fpscr, or if its "info float" command wasn't so convinced
> that there was no FP info available ...)
>
> It seems like any attempt to use the FPU inside the SIGFPE handler
> cause the kernel to turn it back on (setting MSR[FP, FE0, and FE1]);
> with FPSCR[FEX] set, this seems to raise SIGFPE again; attempts to
> clear FPSCR[FEX] from user code involve ... well, they involve using
> the FPU again.

"the program exception occurs before the next synchronizing event
if an instruction alters those bits (thus enabling the program
exception). When this occurs, SRR0 points to the instruction that
would have executed next and not to the instruction that modified MSR"

> While I was puzzling over that (stepping through a SIGFPE handler in
> gdb), I noticed something disturbing: some newly created processes
> (grep and more and other random programs) started dying with unhandled
> "Floating point exception" messages.  I'm at a loss to explain this,
> but I saw it happen often enough to be convinced that I'm not imagining
> the behavior.  I do wonder whether "lazily" enabling the FPU (and
> enabling FPU exceptions) when FPSCR[FEX] may be set is really a good
> idea.
...
> I guess that I'm reporting a bug (or a few bugs) here; I certainly
> understand the motivation behind doing lazy FPU switching, but question
> whether it's done with adequate care when FP exceptions are enabled.

It is a bad idea, because gcc now uses FP registers to copy structs.
Every program can be an FP program now, so why add complexity and
keep taking traps?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
