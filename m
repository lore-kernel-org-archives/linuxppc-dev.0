Date: Tue, 30 Oct 2001 18:59:14 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: floating-point under ppc/linux
In-Reply-To: <15326.8355.242681.874353@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0110301820520.10911-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Oct 2001, Paul Mackerras wrote:

>
> Is there anyone on this list who does, or wants to do, serious
> floating point computations on PPC?  I know that our FP exception

I do, some for scientific computations but mostly for data acquisition of
correlators in radioastronomy.

> handling is a bit, um, deficient and I would like to fix it, but I
> would like some advice about what would be the most useful way to have
> it work.

I agree that it is somwheat deficient as soon as you are not happy with
the IEEE defaults.

>
> I am thinking that the FE0 and FE1 bits in the MSR will be set
> according to the disposition of the SIGFPE signal: SIG_IGN => 00
> (disabled), SIG_DFL => 01 (imprecise nonrecoverable mode), user
> handler => 10 (imprecise recoverable mode).

I'd rather put 11 for user handler. I want to be able to pinpoint the
instruction which caused the fault in the handler. Besides, most
processors these days only implement the ignore and precise FP exceptions
modes. I suspect that it is because once you have implemented the
hardware for out of order and speculative execution, implementing the
imprecise exception modes would be a lot of work for little gain.

>
> What I am not sure about is whether we should change FE0/FE1 when
> SIGFPE is blocked.  Consider the case where SIGFPE has a user
> handler and an FP exception occurs.  The cpu will take an FP exception
> whenever the FEX bit in the FPSCR is set and (FE0 | FE1) is true.  So
> we take the exception, generate the SIGFPE signal and deliver it,
> which involves setting up the stack frame etc. for running the SIGFPE
> handler in userspace.
>
> Now during the execution of the signal handler, to avoid taking
> continual FP exceptions we need to do one of two things: either set
> FE0/FE1 to 00 in the MSR, or clear the FEX bit in the FPSCR.  Since
> the FEX bit is not directly writable (it's just the OR of the AND of
> the each of the exception status bits with the corresponding enable
> bit), we would need to either clear the status bit or the enable bit
> for the exception that occurred.
>
> I don't like the idea of the kernel changing the FPSCR.  Clearing the
> status bit means that the SIGFPE handler can't easily find out what
> exception occurred.  And clearing the exception enable bit will change
> the behaviour of various FP operations.

Well, the handler should have a look at the FPSCR image it has on the
stack, not the one it has in its own registers. On x86, the exception
handlers are entered with the FPU initialized (of course with the
damned register stack, you don't have any other reasonable solution).

Look at it the other way around, imagine that I enable some FPU exception
in one routine, and then disable it before returning. Now if a signal
handler uses floating point, this means that the behaviour of the handler
and the results of its computations may depend on which routine was
executing when the signal was delivered. That's incredibly _bad_. I am
firmly convinced that all signal handlers should always be entered with a
known FPSCR value, 0, and that it should be documented too...

On the other hand, the ability to control FE0 and FE1, values that can be
global to a program, through a system call would be a good thing. I wanted
long ago to add this capability to prctl but never came around to it.

>
> On the other hand, running with FE0/1 = 00 means that we have to take
> account of whether SIGFPE is blocked, as well as its disposition, in
> determining what to set FE0/1 to.
>
> At a deeper level, when do we consider that the SIGFPE signal is
> generated?  Is it generated whenever FEX is set, even if SIGFPE is
> blocked at that time?  If that is the case, then SIGFPE will be
> generated afresh after it is delivered since there will be a time when
> the signal handler is running and has not yet cleared FEX.  Or is the
> signal generated only when FEX is set and SIGFPE is not blocked?
>
> In other words, if a program blocks SIGFPE, does something that
> generates a floating-point exception, then clears the exception status
> in FPSCR, then unblocks SIGFPE, should it get a SIGFPE signal
> delivered to it at that point?

No. Use the machine state to determine if an exception should be
delivered, it always makes things simpler.

Now if a process blocks SIGFPE and then generates a FPU exception,
just kill it. The best way to block floating-point exceptions is to clear
the enable bits in the FPSCR anyway, and having two ways to do the same
thing is always confusing.

Moreover, from man signal: "According to POSIX, the behaviour of a
process is undefined after it ignores a SIGFPE, SIGILL, or SIGSEGV signal
that was not generated by the kill() or the raise() functions."

>
> Finally, is it reasonable to say that it is the responsibility of the
> signal handler to clear FEX, by clearing either the status or enable
> bit for the exception that occurred?

Definitely.

>
> Opinions?

Quite a few, and rather strong. Oh, yes, keep it simple and stupid.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
