From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15326.8355.242681.874353@cargo.ozlabs.ibm.com>
Date: Tue, 30 Oct 2001 14:38:11 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: floating-point under ppc/linux
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there anyone on this list who does, or wants to do, serious
floating point computations on PPC?  I know that our FP exception
handling is a bit, um, deficient and I would like to fix it, but I
would like some advice about what would be the most useful way to have
it work.

I am thinking that the FE0 and FE1 bits in the MSR will be set
according to the disposition of the SIGFPE signal: SIG_IGN => 00
(disabled), SIG_DFL => 01 (imprecise nonrecoverable mode), user
handler => 10 (imprecise recoverable mode).

What I am not sure about is whether we should change FE0/FE1 when
SIGFPE is blocked.  Consider the case where SIGFPE has a user
handler and an FP exception occurs.  The cpu will take an FP exception
whenever the FEX bit in the FPSCR is set and (FE0 | FE1) is true.  So
we take the exception, generate the SIGFPE signal and deliver it,
which involves setting up the stack frame etc. for running the SIGFPE
handler in userspace.

Now during the execution of the signal handler, to avoid taking
continual FP exceptions we need to do one of two things: either set
FE0/FE1 to 00 in the MSR, or clear the FEX bit in the FPSCR.  Since
the FEX bit is not directly writable (it's just the OR of the AND of
the each of the exception status bits with the corresponding enable
bit), we would need to either clear the status bit or the enable bit
for the exception that occurred.

I don't like the idea of the kernel changing the FPSCR.  Clearing the
status bit means that the SIGFPE handler can't easily find out what
exception occurred.  And clearing the exception enable bit will change
the behaviour of various FP operations.

On the other hand, running with FE0/1 = 00 means that we have to take
account of whether SIGFPE is blocked, as well as its disposition, in
determining what to set FE0/1 to.

At a deeper level, when do we consider that the SIGFPE signal is
generated?  Is it generated whenever FEX is set, even if SIGFPE is
blocked at that time?  If that is the case, then SIGFPE will be
generated afresh after it is delivered since there will be a time when
the signal handler is running and has not yet cleared FEX.  Or is the
signal generated only when FEX is set and SIGFPE is not blocked?

In other words, if a program blocks SIGFPE, does something that
generates a floating-point exception, then clears the exception status
in FPSCR, then unblocks SIGFPE, should it get a SIGFPE signal
delivered to it at that point?

Finally, is it reasonable to say that it is the responsibility of the
signal handler to clear FEX, by clearing either the status or enable
bit for the exception that occurred?

Opinions?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
