Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: Fix compile error for CONFIG_VSX 
In-reply-to: <20080701040139.A6196702C9@localhost.localdomain> 
References: <20080701040139.A6196702C9@localhost.localdomain>
Date: Tue, 01 Jul 2008 14:51:29 +1000
Message-ID: <29725.1214887889@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <20080701040139.A6196702C9@localhost.localdomain> you wrote:
> Fix compile error when CONFIG_VSX is enabled.
> 
> arch/powerpc/kernel/signal_64.c: In function 'restore_sigcontext':
> arch/powerpc/kernel/signal_64.c:241: error: 'i' undeclared (first use in this
 function)

FYI.. this was caused by a merge conflict with sfr's patch
fcbc5a976b1cafe2e866871c86d239d57503bfd5

Mikey

> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> 
>  arch/powerpc/kernel/signal_64.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
> @@ -167,6 +167,7 @@ static long restore_sigcontext(struct pt
>  #endif
>  #ifdef CONFIG_VSX
>  	double buf[FP_REGS_SIZE];
> +	int i;
>  #endif
>  	unsigned long err = 0;
>  	unsigned long save_r13 = 0;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
