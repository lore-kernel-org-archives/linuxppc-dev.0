Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A113EB7CF6
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2010 13:24:53 +1100 (EST)
Subject: Re: [PATCH] powerpc: Don't clear larx reservation on system call exit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100215014028.GB13355@kryten>
References: <20100215014028.GB13355@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Feb 2010 13:24:47 +1100
Message-ID: <1266200687.16346.110.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-02-15 at 12:40 +1100, Anton Blanchard wrote:
> Right now we clear the larx reservation on every system call exit. No code
> should exist that tries to make use of larx/stcx across a system call (because
> it would fail 100% of the time).
> 
> We could continue to play it safe but system call latency affects so many
> workloads. In the past we have already cut down the set of registers we
> save and restore across a system call and this could be seen as an
> extension of that. The PowerPC system call ABI does not (and could not)
> preserve a larx reservation.
> 
> On POWER6 the poster child for system call improvements, getppid, improves 6%.
> 
> A more useful test is the private futex wake system call and that improves 5%.
> This is a decent speedup on an important system call for threaded applications.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> If my previous patches didn't worry you then this one is sure to.
> 
> Getting this wrong will make someone's life miserable, so it could do with
> some double checking (eg we don't branch through there on other exceptions and
> we dont invoke system calls from the kernel that rely on the reservation being
> cleared).

Well, the main issue here is leaking kernel reservations into userspace,
and thus the question of whether it is a big deal or not. There's also
an issue I can see with signals.

The risk with kernel reservations leaking into userspace is a problem on
some processors that do not compare the reservation address locally
(only for snoops), thus userspace code doing lwarx/syscall/stwcx. might
end up with a suceeding stwcx. despite the fact that the original
reservation was long lost. 

At this stage it becomes an ABI problem, ie, whether we define the
behaviour of a lwarx/stwcx. accross a syscall as defined or not.

The other problem I see is that signal handlers would have to be made
very careful not to leave dangling reservations since the return from
the syscall is a syscall, unless we add code specifically to this (and
set_context too I'd say) to clear reservations.

IE. You could have something like:

lwarx, <interrupt>, signal handler, sigreturn, stwcx.

In the above case, the reservation would be cleared by the return from
the interrupt, but the signal handler might leave a dangling one, which
sigreturn might fail to clear (in practice, our current implementation
of sys_sigreturn() will probably clear any reservation as a side effect
of restore_sigmask() spinlock or set_thread_flag() but it sounds a bit
fragile to rely on unless it's well documented). 

Cheers,
Ben.

> Index: powerpc.git/arch/powerpc/kernel/entry_64.S
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/kernel/entry_64.S	2010-02-13 16:26:43.794322638 +1100
> +++ powerpc.git/arch/powerpc/kernel/entry_64.S	2010-02-13 16:27:03.205575405 +1100
> @@ -202,7 +202,6 @@ syscall_exit:
>  	bge-	syscall_error
>  syscall_error_cont:
>  	ld	r7,_NIP(r1)
> -	stdcx.	r0,0,r1			/* to clear the reservation */
>  	andi.	r6,r8,MSR_PR
>  	ld	r4,_LINK(r1)
>  	/*
