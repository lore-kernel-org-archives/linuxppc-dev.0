Return-Path: <SRS0+9f45c3c67972581a37c1+926+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A7AA679E6
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Mar 2006 00:09:20 +1100 (EST)
Subject: Re: signal/syscall/swapcontext fixes
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17421.32092.442696.49291@cargo.ozlabs.ibm.com>
References: <17421.32092.442696.49291@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 13:09:11 +0000
Message-Id: <1141736951.4110.167.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-07 at 23:32 +1100, Paul Mackerras wrote:
> * The TIF_SAVE_NVGPRS mechanism was only being used by swapcontext, so
>   I removed it and put swapcontext back the way it was in 2.6.15, with
>   an assembler stub to save the non-volatile GPRs before calling the C
>   code.  The save_general_regs functions now WARN_ON(!FULL_REGS(regs)).

OK. As observed, I'd mostly obsoleted TIF_SAVE_NVGPRS when I implemented
TIF_RESTORE_SIGMASK.

The 64-bit version (bl .save_nvgprs) is prettier than the 32-bit version
(doing it longhand), and they're still gratuitously different. We should
probably fix that.

> * 32-bit wasn't testing the _TIF_NOERROR bit in the syscall fast exit
>   path, so it was only doing anything with it once it saw some other
>   bit being set.

OK.

> * 32-bit wasn't doing the call to ptrace_notify in the syscall exit
>   path when the _TIF_SINGLESTEP bit was set.

Yeah. That was historical (arch/ppc never did this) but nonetheless
still wrong. Without it, we never stop on the instruction immediately
following the 'sc', when we're supposed to be single-stepping.

On a similar note, we should also do a ptrace stop when we deliver
signals, to ensure that the debugger gets a stop _on_ the first
instruction of the handler. Once upon a time there was a stop in
handle_rt_signal() and handle_signal(), but doing it that way gave a
_double_ stop when we ended up in a signal handler from sigsuspend(),
because the syscall stop you just fixed for ppc32 happened too.

> * _TIF_RESTOREALL was in both _TIF_USER_WORK_MASK and
>   _TIF_PERSYSCALL_MASK, which is odd since _TIF_RESTOREALL is only set
>   by system calls.  I took it out of _TIF_USER_WORK_MASK.

Right.

> * On 64-bit, _TIF_RESTOREALL wasn't causing the non-volatile registers
>   to be restored (unless perhaps a signal was delivered or the syscall
>   was traced or single-stepped).  Thus the non-volatile registers
>   weren't restored on exit from a signal handler.  We probably got
>   away with it mostly because signal handlers written in C wouldn't
>   alter the non-volatile registers.

Hm, yes. The idea behind TIF_RESTOREALL was just to prevent r3 and the
flags from getting stomped on -- I didn't look at the nvgprs at that
point, and I'm not sure if the nvgprs were being restored on ppc32
before my changes. They could well have been on ppc64 -- this was
another area in which the two were different.

> * On 32-bit I simplified the code and made it more like 64-bit by
>   making the syscall exit path jump to ret_from_except to handle
>   preemption and signal delivery.

OK, good. It would actually be nice if we could split a bunch of this
code out into a shared file and use the PPC_LL, PPC_STL, etc. macros.

> * 32-bit was calling do_signal unnecessarily when _TIF_RESTOREALL was
>   set - but I think because of that 32-bit was actually restoring the
>   non-volatile registers on exit from a signal handler.

OK.

> * I changed the order of enabling interrupts and saving the
>   non-volatile registers before calling do_syscall_trace_leave; now we
>   enable interrupts first.

OK.

> Any comments before I send this off to Linus to go in 2.6.16?

Looks good.

On a purely cosmetic note I'm not sure about this though -- it was
slightly easier to follow when it was more explicit:
-       andi.   r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_SAVE_NVGPRS|_TIF_NOERROR|_TIF_RESTORE_SIGMASK)
+       andi.   r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)

-- 
dwmw2
