Date: Tue, 26 Jun 2001 07:10:03 -0700 (PDT)
From: Gary Byers <gb@gse.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: giving up the FPU, MSR[FE0], MSR[FE1], and the FPSCR
Message-ID: <Pine.GSO.4.21.0106260032030.15923-100000@gse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sometime in the last year or two (sorry not to be more precise; I
wasn't paying attention) the linuxppc kernel seems to have started
doing lazy FPU switching.  If I read the code (in
../arch/ppc/kernel/head.S) and judge its effects correctly, code in
load_up_fpu() unconditionally sets the FE0 and FE1 bits in the MSR.  I
wonder if this change (setting the bits) was intentional: there's
still some code in ./signal.c and ./ptrace.c that tries to allow
signal handlers/ptrace to change those bits, though I don't know if
that's ever worked.

With MSR[FE0] and MSR[FE1] set, an enabled FPU exception (something
that causes FPSCR[FEX] to be set) causes a program exception with
SRR1[11] set, and Linux maps this to SIGFPE.

It seems that when a user-level SIGFPE handler begins execution, its
own FPSCR[FEX] (and other exception-related bits in the FPSCR) are set
and the FPU (MSR[FP, FE0, FE1]) is disabled.  (I'd be more confident
in saying that than I am if gdb 5.0 had ever heard of a register
called the fpscr, or if its "info float" command wasn't so convinced
that there was no FP info available ...)

It seems like any attempt to use the FPU inside the SIGFPE handler
cause the kernel to turn it back on (setting MSR[FP, FE0, and FE1]);
with FPSCR[FEX] set, this seems to raise SIGFPE again; attempts to
clear FPSCR[FEX] from user code involve ... well, they involve using
the FPU again.

While I was puzzling over that (stepping through a SIGFPE handler in
gdb), I noticed something disturbing: some newly created processes
(grep and more and other random programs) started dying with unhandled
"Floating point exception" messages.  I'm at a loss to explain this,
but I saw it happen often enough to be convinced that I'm not imagining
the behavior.  I do wonder whether "lazily" enabling the FPU (and
enabling FPU exceptions) when FPSCR[FEX] may be set is really a good
idea.

I didn't see any significant differences in later versions of
'head.S', but for the record  all of this happens in a pretty
vanilla 2.2.17 kernel.

I guess that I'm reporting a bug (or a few bugs) here; I certainly
understand the motivation behind doing lazy FPU switching, but question
whether it's done with adequate care when FP exceptions are enabled.

Gary Byers
gb@gse.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
