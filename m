From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15347.45163.962240.790007@cargo.ozlabs.ibm.com>
Date: Thu, 15 Nov 2001 23:09:15 +1100 (EST)
To: Gabriel Paubert <paubert@iram.es>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: floating-point under ppc/linux
In-Reply-To: <Pine.LNX.4.33.0111151030280.30220-100000@gra-lx1.iram.es>
References: <15347.21652.410313.109535@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.33.0111151030280.30220-100000@gra-lx1.iram.es>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> IOW: the FPSCR should be cleared for signal handlers (and obviously
> restored on return to interrupted program), however I belive that FE0 and
> FE1 should not be changed, so that these are global process (actually
> thread) flags.

I have an implementation which I am testing at the moment, I'll post a
patch tomorrow once it works.  I have added a fpexc_mode field to the
thread_struct which contains the FE0/1 values that we want to have in
the MSR.

> There is another problem with making FE0/FE1 depending on SIGFPE
> disposition, you would have to modify the MSR of all the CLONE_SIGHAND
> threads, which might involve cross processor interrupts and a significant
> increase in complexity. Actually this last argument is probably the killer
> one: it very strongly favors disassociating FE0/FE1 setting from SIGFPE
> disposition IMHO.

That is a good point.  Actually the problem would occur when the
disposition is SIG_IGN and some thread sets it to something else (and
then it is a hard problem as you point out).  Going the other way is
easier since we could take the exception and then, if the handler is
SIG_IGN, set FE0/1 to 00 and continue.

> OTOH I don't have any idea on inheritance of FE0 and FE1 flags on
> clone(2), should they depend on CLONE_SIGHAND flag or not ?

CLONE_SIGHAND just controls whether we do a deep or a shallow copy of
the signal state (i.e. do we just copy the pointer or do we copy the
contents to a new signal struct).  Either way we end up with the same
signal state initially.  The child starts with the same msr as the
parent initially, just as it starts with the same values in all the
registers except r3.  So that is OK.

However, it sounds like we do need a system call to control FE0/1.  Is
prctl the most appropriate one to use or is there a better one?  (I
wonder what AIX does, I'll try to find out tomorrow.)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
