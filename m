Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk7TC0dpnzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 15:43:42 +1000 (AEST)
Message-ID: <1504244603.4974.73.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 8/8] powerpc/xive: improve debugging macros
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 01 Sep 2017 15:43:23 +1000
In-Reply-To: <20170830194617.26621-9-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
 <20170830194617.26621-9-clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 21:46 +0200, Cédric Le Goater wrote:
> Having the CPU identifier in the debug logs is helpful when tracking
> issues. Also add some more logging and fix a compile issue in
> xive_do_source_eoi().
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/sysdev/xive/common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 8fd58773c241..1c087ed7427f 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -40,7 +40,8 @@
>  #undef DEBUG_ALL
>  
>  #ifdef DEBUG_ALL
> -#define DBG_VERBOSE(fmt...)	pr_devel(fmt)
> +#define DBG_VERBOSE(fmt, ...)	pr_devel("cpu %d - " fmt, \
> +					 smp_processor_id(), ## __VA_ARGS__)
>  #else
>  #define DBG_VERBOSE(fmt...)	do { } while(0)
>  #endif
> @@ -344,7 +345,7 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
>  			xive_esb_read(xd, XIVE_ESB_LOAD_EOI);
>  		else {
>  			eoi_val = xive_esb_read(xd, XIVE_ESB_SET_PQ_00);
> -			DBG_VERBOSE("eoi_val=%x\n", offset, eoi_val);
> +			DBG_VERBOSE("eoi_val=%x\n", eoi_val);
>  
>  			/* Re-trigger if needed */
>  			if ((eoi_val & XIVE_ESB_VAL_Q) && xd->trig_mmio)
> @@ -1004,6 +1005,9 @@ static void xive_ipi_eoi(struct irq_data *d)
>  {
>  	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
>  
> +	DBG_VERBOSE("IPI eoi: irq=%d [0x%lx] (HW IRQ 0x%x) pending=%02x\n",
> +		    d->irq, irqd_to_hwirq(d), xc->hw_ipi, xc->pending_prio);
> +
>  	/* Handle possible race with unplug and drop stale IPIs */
>  	if (!xc)
>  		return;
