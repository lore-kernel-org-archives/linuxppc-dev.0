Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Ignore IPIs to offline CPUs
In-reply-to: <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com>
References: <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com>
Date: Wed, 21 Apr 2010 12:04:38 +1000
Message-ID: <12054.1271815478@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <201004210154.o3L1sXaR001791@d01av04.pok.ibm.com> you wrote:
> 
> Since there is nothing to stop an IPI from occurring to an
> offline CPU, rather than printing a warning to the logs,
> just ignore the IPI. This was seen while stress testing
> SMT enable/disable.

This seems like a recipe for disaster.  Do we at least need a
WARN_ON_ONCE?

> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  arch/powerpc/platforms/pseries/xics.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN arch/powerpc/platforms/pseries/xics.c~powerpc_xics_ipi_offline arch
/powerpc/platforms/pseries/xics.c
> --- linux-2.6/arch/powerpc/platforms/pseries/xics.c~powerpc_xics_ipi_offline
	2010-04-20 20:46:06.000000000 -0500
> +++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/xics.c	2010-04-20 20:4
7:53.000000000 -0500
> @@ -545,7 +545,8 @@ static irqreturn_t xics_ipi_dispatch(int
>  {
>  	unsigned long *tgt = &per_cpu(xics_ipi_message, cpu);
>  
> -	WARN_ON(cpu_is_offline(cpu));
> +	if (cpu_is_offline(cpu))
> +		return IRQ_HANDLED;
>  
>  	mb();	/* order mmio clearing qirr */
>  	while (*tgt) {
> _

FYI random white space change here.

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

Mikey
