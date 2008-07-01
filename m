Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24E68DDF7B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 19:07:53 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix compile warning in init_thread
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <1214895639.691008.114376646781.qpush@coopers>
References: <1214895639.691008.114376646781.qpush@coopers>
Content-Type: text/plain
Date: Tue, 01 Jul 2008 19:07:36 +1000
Message-Id: <1214903256.20711.123.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-01 at 17:00 +1000, Michael Neuling wrote:
> arch/powerpc/kernel/init_task.c:33: warning: missing braces around initializer
> arch/powerpc/kernel/init_task.c:33: warning: (near initialization for 'init_task.thread.fpr[0]')
> 
> Noticed by SFR.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

That's when fpr is part of the union but what if CONFIG_VSX is off ?

Ben.

> ---
> 
>  include/asm-powerpc/processor.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
> @@ -222,7 +222,7 @@ struct thread_struct {
>  	.ksp_limit = INIT_SP_LIMIT, \
>  	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
>  	.fs = KERNEL_DS, \
> -	.fpr = {0}, \
> +	.fpr = {{0}}, \
>  	.fpscr = { .val = 0, }, \
>  	.fpexc_mode = 0, \
>  }
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
