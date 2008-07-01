Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: fix compile warning in init_thread 
In-reply-to: <1214903256.20711.123.camel@pasglop> 
References: <1214895639.691008.114376646781.qpush@coopers>
	<1214903256.20711.123.camel@pasglop>
Date: Tue, 01 Jul 2008 21:02:06 +1000
Message-ID: <27368.1214910126@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <1214903256.20711.123.camel@pasglop> you wrote:
> On Tue, 2008-07-01 at 17:00 +1000, Michael Neuling wrote:
> > arch/powerpc/kernel/init_task.c:33: warning: missing braces around initiali
zer
> > arch/powerpc/kernel/init_task.c:33: warning: (near initialization for 'init
_task.thread.fpr[0]')
> > 
> > Noticed by SFR.
> > 
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> That's when fpr is part of the union but what if CONFIG_VSX is off ?

It's not a union anymore.  It's a 2D array irrespective of CONFIG_VSX.

	double		fpr[32][TS_FPRWIDTH];

Mikey

> 
> Ben.
> 
> > ---
> > 
> >  include/asm-powerpc/processor.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
> > +++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
> > @@ -222,7 +222,7 @@ struct thread_struct {
> >  	.ksp_limit = INIT_SP_LIMIT, \
> >  	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
> >  	.fs = KERNEL_DS, \
> > -	.fpr = {0}, \
> > +	.fpr = {{0}}, \
> >  	.fpscr = { .val = 0, }, \
> >  	.fpexc_mode = 0, \
> >  }
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
