From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106291829.f5TITNs464375@saturn.cs.uml.edu>
Subject: Re: giving up the FPU, MSR[FE0], MSR[FE1], and the FPSCR
To: fray@mvista.com (Mark Hatle)
Date: Fri, 29 Jun 2001 14:29:23 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3B3C9BC6.9AD7C208@mvista.com> from "Mark Hatle" at Jun 29, 2001 10:16:22 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark Hatle writes:
> [Albert Cahalan]
>> [somebody]

>>> [about lazy FP save/restore]
>>
>> It is a bad idea, because gcc now uses FP registers to copy structs.
>> Every program can be an FP program now, so why add complexity and
>> keep taking traps?
>
> One thing to keep in mind, GCC is perfectly capable of compiling without
> using floating point.  I routinely use code that has no floating point
> compiled in (including glibc).  If you build a system with -msoft-float
> (libraries through the apps) then the FPU never gets enabled and your
> context switching is faster.  (Is this measurable?  I'm not sure.
> But..) The system "seems" to preform better.

Maybe your gcc can't take advantage of FP registers for non-FP uses.

Your non-FP code might seem a wee bit better, but your FP code
ends up taking faults. Then with all the extra code, we end up
with extra problems -- for example the original poster's trouble.

> Lazy FPU initialization IMHO is a good thing for single purpose
> (embedded?) systems that are on a high end CPU, but do not need
> floating point.  One example could be a signal processing system
> that uses altivec and integer math heavily, but no floating point.

That is almost exactly the sort of system I work with.
AltiVec is used for signal processing, though with "float" data.

FP registers are still useful, for struct copies and for the
occasional standard C library function.

I suppose, if one does want lazy FP save/restore, that it ought
to be done with a per-process flag to prevent frequent faults.
When switching to an FP process, restore the registers. From time
to time take away the FP registers to deal with processes that
only use them once in a great while or only at startup. Maybe
take away FP after 1, 2, 4, 8, 16... ticks of use.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
