Message-ID: <3B3C9BC6.9AD7C208@mvista.com>
Date: Fri, 29 Jun 2001 10:16:22 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: giving up the FPU, MSR[FE0], MSR[FE1], and the FPSCR
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> While I was puzzling over that (stepping through a SIGFPE handler in
>> gdb), I noticed something disturbing: some newly created processes
>> (grep and more and other random programs) started dying with unhandled
>> "Floating point exception" messages.  I'm at a loss to explain this,
>> but I saw it happen often enough to be convinced that I'm not imagining
>> the behavior.  I do wonder whether "lazily" enabling the FPU (and
> enabling FPU exceptions) when FPSCR[FEX] may be set is really a good
>> idea.
>...
>> I guess that I'm reporting a bug (or a few bugs) here; I certainly
>> understand the motivation behind doing lazy FPU switching, but question
>> whether it's done with adequate care when FP exceptions are enabled.
>
>It is a bad idea, because gcc now uses FP registers to copy structs.
>Every program can be an FP program now, so why add complexity and
>keep taking traps?

One thing to keep in mind, GCC is perfectly capable of compiling without
using floating point.  I routinely use code that has no floating point
compiled in (including glibc).  If you build a system with -msoft-float
(libraries through the apps) then the FPU never gets enabled and your
context switching is faster.  (Is this measurable?  I'm not sure.
But..) The system "seems" to preform better.

Lazy FPU initialization IMHO is a good thing for single purpose
(embedded?) systems that are on a high end CPU, but do not need floating
point.  One example could be a signal processing system that uses
altivec and integer math heavily, but no floating point.

--Mark Hatle
MontaVista Software, Inc.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
