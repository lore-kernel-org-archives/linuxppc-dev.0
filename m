Date: Thu, 15 Nov 2001 14:00:53 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Paul Mackerras <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: floating-point under ppc/linux
In-Reply-To: <15347.45163.962240.790007@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0111151320560.30220-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Nov 2001, Paul Mackerras wrote:

> Gabriel Paubert writes:
>
> > There is another problem with making FE0/FE1 depending on SIGFPE
> > disposition, you would have to modify the MSR of all the CLONE_SIGHAND
> > threads, which might involve cross processor interrupts and a significant
> > increase in complexity. Actually this last argument is probably the killer
> > one: it very strongly favors disassociating FE0/FE1 setting from SIGFPE
> > disposition IMHO.
>
> That is a good point.  Actually the problem would occur when the
> disposition is SIG_IGN and some thread sets it to something else (and
> then it is a hard problem as you point out).  Going the other way is
> easier since we could take the exception and then, if the handler is
> SIG_IGN, set FE0/1 to 00 and continue.

If it's tough one way, it's tough enough to try to avoid it :-)

> CLONE_SIGHAND just controls whether we do a deep or a shallow copy of
> the signal state (i.e. do we just copy the pointer or do we copy the
> contents to a new signal struct).  Either way we end up with the same
> signal state initially.  The child starts with the same msr as the
> parent initially, just as it starts with the same values in all the
> registers except r3.  So that is OK.

All registers ? At least the sysv abi claims that the FPSCR should be
cleared, which makes sense (in a new context, you should at least clear
all architectural sticky bits).

Personally I would also clear the XER because it holds a sticky overflow
bit which could play havoc with programs written in languages that might
want to detect integer overflow, like Ada, but that one can be taken care
of by user space without incurring the overhead of an exception (IIRC
Altivec also has a status/control register with sticky bits).

>
> However, it sounds like we do need a system call to control FE0/1.  Is
> prctl the most appropriate one to use or is there a better one?  (I
> wonder what AIX does, I'll try to find out tomorrow.)

I think prctl is appropriate. From /usr/include/linux/sysctl.h:
[snipped]
/* Get/set unaligned access control bits (if meaningful) */
#define PR_GET_UNALIGN	  5
#define PR_SET_UNALIGN	  6
# define PR_UNALIGN_NOPRINT	1	/* silently fix up unaligned user accesses */
# define PR_UNALIGN_SIGBUS	2	/* generate SIGBUS on unaligned user access */
[snipped]

This somehow control the behaviour on exceptions, so I believe that it is
reasonable to extend it to handle FPU capabilities.

It would be probably better to ask Linus for a blessed prctl number, or
whether he prefers to give a specific number range (or negative numbers)
for arch specific prctl functions. I can't answer for Linus, but after
seeing this file, I see no philosophical reason to add another syscall
instead of adding a prctl suboption (even if PPC-specific).

Actually, for some architectures, it would be worth to have a
PR_SET_FPASSIST/PR_GET_FPASSIST for FPU instructions which trap for
software completion (there are cases where you'd prefer to get a signal
rather than go through the extremely slow software emulation).

Another possibility: prctl(2) has enough parameters to add option
PR_SET_${ARCH}_SPECIFIC/PR_GET_${ARCH}_SPECIFIC and then add subfields
(arg2 would be PPC_FPE_HANDLING and arg3 the value of FE0/FE1). So no two
archs would ever be able to step on each other...

It might require the addition of an include/asm-${arch}/prctl.h file, but
I don't see it as a big deal.

My $0.02...

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
