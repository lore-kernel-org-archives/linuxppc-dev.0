Date: Thu, 15 Nov 2001 12:30:18 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: floating-point under ppc/linux
In-Reply-To: <15347.21652.410313.109535@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0111151030280.30220-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Nov 2001, Paul Mackerras wrote:

> > I'd rather put 11 for user handler. I want to be able to pinpoint the
> > instruction which caused the fault in the handler. Besides, most
> > processors these days only implement the ignore and precise FP exceptions
> > modes. I suspect that it is because once you have implemented the
> > hardware for out of order and speculative execution, implementing the
> > imprecise exception modes would be a lot of work for little gain.
>
> I did some research.  It turns out that the 604 family are the only
> PPCs that implement anything other than 00 and 11.  The 604 also
> implements mode 01 (imprecise nonrecoverable mode).  I have no idea
> whether mode 01 would be faster than mode 11.  No implementation does
> mode 10 differently from mode 11.  So I'm happy to use mode 11 instead
> of 10.

Exactly. I believe that there can only be a large performance difference
between 01 and 11 on long latency operations (fdiv). The fmadd and friends
have such a low latency on 604 (3 clocks except for corner cases) that
keeping them in the queue for precise exception handling is probably not a
big deal performance-wise.

Note that is is a generic problem with all floating-point intensive code:
avoid divisions first (I've found PPC to be relatively more sensitive to
that then other archs, perhaps because the fused multiply add have such a
low latency compared to a division).

Browsing other archs, I have found that IA64 signal handlers are entered
with default FPSR, as well as Sparc64/MIPS64 (if I understand MIPS code
correctly). I have been unable to find something equivalent for Alpha/PA,
but I'd rather belive that this is an Alpha/PA specific bug. For m68k, I
can't remember if the fsave instruction actually resets the FPU state to
default or not, so I can't tell.


>
> > I am
> > firmly convinced that all signal handlers should always be entered with a
> > known FPSCR value, 0, and that it should be documented too...
>
> Good idea.  Let's do that.  That would solve the major problem.

Indeed, it also makes porting from x86 easier. Besides that, imagine that
your signal handler interrupts a routine with non-default rounding mode,
the results will be different if you don't reset these bits to default.
At least this way we avoid the nightmare of somebody complaining from
occasionally different result in a signal handler (try to track that) :-).

IOW: the FPSCR should be cleared for signal handlers (and obviously
restored on return to interrupted program), however I belive that FE0 and
FE1 should not be changed, so that these are global process (actually
thread) flags. In this case, the signal handler can enable FPU exceptions
without having to enter the kernel to change FE0 and FE1. However, this is
just a gut feeling that this is the best solution, anybody that has a
solid counter argument should raise his voice.

Basically there are a few classes of floating-point applications that I
have encountered myself:

- the ones done by people who do not understand the issues and do not want
to bother about the problems. The default is just fine for them.

- the scientific applications during the debugging phase: you enable all
exceptions (except precision, even beginners knows that FP is imprecise,
so why was it introduced in the first place). Underflow is enabled except
in the routines where you know that it is harmless.

- the scientific production code, you enable a few exceptions just to
catch problems, but you want speed (you may want to enable/disable
underflow exception on a function by function basis). The goal here is to
stop processing ASAP in case of errors (unlikely on well debugged code but
hours of compute time on high end machines/clusters cost real money), but
proceed as fast as possible otherwise (you may have some places where you
look for plausibility of the intermediate results and abort if something
looks completely out of range).

- real-time data processing. In this case you don't want the overhead of
an exception, but more predictable timing. The best method is to clear the
exception flags at the beginning and then to check for the potentially
harmful errors that have happened and flag the whole data as bad or
dubious. After all, it's truly an exceptional condition which in my cases
only happens (modulo bugs) in case of hardware problems: when processing
involves Fourier transforms, a single bad value read from the hardware
corrupts all the results, so a global flag is a fast and valid, although
not very refined, solution. OTOH for debugging, you enable exceptions,
very similar to scientific code debuggging.

>
> > On the other hand, the ability to control FE0 and FE1, values that can be
> > global to a program, through a system call would be a good thing. I wanted
> > long ago to add this capability to prctl but never came around to it.
>
> It seems to me that if we are only using modes 00 and 11 then using
> the SIGFPE disposition to control it is adequate.  If people want to
> use mode 01 but still catch the signals then we would need a prctl or
> something.  Does anyone use 604s for FP-intensive stuff these days, I
> wonder?

Well, there are still 43P-150 on the IBM online catalog, based on 250 and
375 MHz 604. There are probably quite a few still in operation, too, as
well as SMP 604 servers. Howveer, I doubt that they are used for FP
intensive stuff.

I'd personaly prefer a separate prctl and avoid linking the two in the
kernel (this would be some kind of policy in the kernel), handling it
properly should rather be left to userspace and claim that it's userspace
fault if it's set in an inconsistent state.

[Thinking a little while browsing sources...]

There is another problem with making FE0/FE1 depending on SIGFPE
disposition, you would have to modify the MSR of all the CLONE_SIGHAND
threads, which might involve cross processor interrupts and a significant
increase in complexity. Actually this last argument is probably the killer
one: it very strongly favors disassociating FE0/FE1 setting from SIGFPE
disposition IMHO.

OTOH I don't have any idea on inheritance of FE0 and FE1 flags on
clone(2), should they depend on CLONE_SIGHAND flag or not ?

Copying them if CLONE_SIGHAND is set and clearing them otherwise might
make sense. Although I'm always in favor of simplicity first, this could
come handy for applications that create rather short-lived threads.

Ok, I stop here, I'm again too verbose, and quite sure that I would find a
way to double the size of this post if I started digging a little more in
the code.


	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
