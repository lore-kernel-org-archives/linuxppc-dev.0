Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 493FB679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 11:18:58 +1000 (EST)
From: Horms <horms@verge.net.au>
Subject: Re: [PATCH] powerpc: unify 32 and 64bit panic_on_oops messages
In-Reply-To: <20060706101521.GE26612@verge.net.au>
To: linuxppc-dev@ozlabs.org
Message-Id: <20060711011854.8D21A340AA@koto.vergenet.net>
Date: Tue, 11 Jul 2006 10:18:54 +0900 (JST)
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First up, sorry for the silly subject in the original post, that was an
error.

Secondly, when I sent the x86_64 version of this patch Andi Kleen
pointed out that calling ssleep() will just cause an early panic if the
code is in interrupt context. Accordingly, I plan to post patches to
remoove the ssleep(). So please ignore the patch that is bellow.

Thanks

-- 
Horms                                           
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

On Thu, 6 Jul 2006 19:15:22 +0900, Horms wrote:
> I have been looking at unifying the way that panic_on_oops logs
> what it is doing between the different architectures that implement it.
> The first cab off the rank is the patch below which removes a seemingly
> silly difference between the behaviour on 32 and 64 bit powerpc.
> 
> I have not been able to test this as I do not have a ppc64 machine
> at my disposal. However I did test that it compiles thanks to
> the wonders of crosstool.
> 
> Signed-Off-By: Horms <horms@verge.net.au>
> 
> arch/powerpc/kernel/traps.c |    2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 52f5659..908231a 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -157,10 +157,8 @@ #endif
> 		panic("Fatal exception in interrupt");
> 
> 	if (panic_on_oops) {
> -#ifdef CONFIG_PPC64
> 		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
> 		ssleep(5);
> -#endif
> 		panic("Fatal exception");
> 	}
> 	do_exit(err);
