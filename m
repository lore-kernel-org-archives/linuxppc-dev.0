Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17421.62535.805543.661898@cargo.ozlabs.ibm.com>
Date: Wed, 8 Mar 2006 07:59:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: signal/syscall/swapcontext fixes
In-Reply-To: <1141736951.4110.167.camel@pmac.infradead.org>
References: <17421.32092.442696.49291@cargo.ozlabs.ibm.com>
	<1141736951.4110.167.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> The 64-bit version (bl .save_nvgprs) is prettier than the 32-bit version
> (doing it longhand), and they're still gratuitously different. We should
> probably fix that.

There's also the difference where ret_from_except in 32-bit does what
ret_from_except_lite does in 64-bit, and the 32-bit
ret_from_except_full is approximately the same as the 64-bit
ret_from_except. :)

> On a similar note, we should also do a ptrace stop when we deliver
> signals, to ensure that the debugger gets a stop _on_ the first
> instruction of the handler. Once upon a time there was a stop in
> handle_rt_signal() and handle_signal(), but doing it that way gave a
> _double_ stop when we ended up in a signal handler from sigsuspend(),
> because the syscall stop you just fixed for ppc32 happened too.

Do we have a fix for this for 2.6.16, or will we leave it until
2.6.17?

> On a purely cosmetic note I'm not sure about this though -- it was
> slightly easier to follow when it was more explicit:
> -       andi.   r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_SIGPENDING|_TIF_NEED_RESCHED|_TIF_RESTOREALL|_TIF_SAVE_NVGPRS|_TIF_NOERROR|_TIF_RESTORE_SIGMASK)
> +       andi.   r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)

I did it that way because we are clearing _TIF_PERSYSCALL_MASK further
down.  If we expand one we should expand both.

Paul.
