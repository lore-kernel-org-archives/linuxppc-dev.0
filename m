Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FB06DE021
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:28:22 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix support for latencytop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200807170012.25859.arnd@arndb.de>
References: <48755237.9070701@nortel.com> <200807101608.18643.arnd@arndb.de>
	<20080716202236.GZ9594@localdomain> <200807170012.25859.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 08:28:00 +1000
Message-Id: <1216247280.7740.213.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-17 at 00:12 +0200, Arnd Bergmann wrote:
> We need to pass the kernel stack pointer instead of the user space
> stack pointer in save_stack_trace_tsk().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> On Wednesday 16 July 2008, Nathan Lynch wrote:
> > Arnd Bergmann wrote:
> > > Implement save_stack_trace_tsk on powerpc, so that we can run with
> > > latencytop.
> > 
> > So I tried latencytop with linux-next and got the following oops, but
> > I didn't really look into it yet.
> 
> Oh, I didn't even realize that benh had merged that patch of mine.
> As I wrote in the description, it was entirely untested. You found
> another obvious bug: The code was passing the user space stack
> pointer instead of the kernel stack pointer.
> 
> Again, this patch is entirely untested, and I would not be at all
> surprised to find other trivial bugs.

I missed that part of your description and it didn't seem to break the
kernel stack trace so ... :-) It's a nice feature to have and bugs can
be fixed before release.

Now we should probably look at making the stacktrace code a bit more
robust vs. wild pointers anyway.

> --- a/arch/powerpc/kernel/stacktrace.c
> +++ b/arch/powerpc/kernel/stacktrace.c
> @@ -59,6 +59,6 @@ EXPORT_SYMBOL_GPL(save_stack_trace);
>  
>  void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  {
> -	save_context_stack(trace, tsk->thread.regs->gpr[1], tsk, 0);
> +	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
