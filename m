Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 501A3DDE33
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 11:24:04 +1000 (EST)
Subject: Re: [PATCH] powerpc: mpic: minor optimization of ipi handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071019234950.GA18112@lixom.net>
References: <20071019185110.GA11911@lixom.net>
	<1192835859.17235.12.camel@pasglop> <20071019233134.GA17851@lixom.net>
	<20071019234950.GA18112@lixom.net>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 11:23:51 +1000
Message-Id: <1192843431.17235.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, jgarzik@pobox.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-19 at 18:49 -0500, Olof Johansson wrote:
> Optimize MPIC IPIs, by passing in the IPI number as the argument to the
> handler, since all we did was translate it back based on which mpic
> the interrupt came though on (and that was always the primary mpic).
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

> Oh, I see what you mean. You didn't make it easy to parse. :)
> 
> This should actually do the work.
> 
> -Olof

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index e479388..a8d7c68 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -614,10 +614,9 @@ static inline void mpic_eoi(struct mpic *mpic)
>  #ifdef CONFIG_SMP
>  static irqreturn_t mpic_ipi_action(int irq, void *data)
>  {
> -	struct mpic *mpic;
> +	long ipi = (long)data;
>  
> -	mpic = mpic_find(irq, NULL);
> -	smp_message_recv(mpic_irq_to_hw(irq) - mpic->ipi_vecs[0]);
> +	smp_message_recv(ipi);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1457,7 +1456,7 @@ unsigned int mpic_get_irq(void)
>  void mpic_request_ipis(void)
>  {
>  	struct mpic *mpic = mpic_primary;
> -	int i, err;
> +	long i, err;
>  	static char *ipi_names[] = {
>  		"IPI0 (call function)",
>  		"IPI1 (reschedule)",
> @@ -1472,14 +1471,14 @@ void mpic_request_ipis(void)
>  		unsigned int vipi = irq_create_mapping(mpic->irqhost,
>  						       mpic->ipi_vecs[0] + i);
>  		if (vipi == NO_IRQ) {
> -			printk(KERN_ERR "Failed to map IPI %d\n", i);
> +			printk(KERN_ERR "Failed to map IPI %ld\n", i);
>  			break;
>  		}
>  		err = request_irq(vipi, mpic_ipi_action,
>  				  IRQF_DISABLED|IRQF_PERCPU,
> -				  ipi_names[i], mpic);
> +				  ipi_names[i], (void *)i);
>  		if (err) {
> -			printk(KERN_ERR "Request of irq %d for IPI %d failed\n",
> +			printk(KERN_ERR "Request of irq %d for IPI %ld failed\n",
>  			       vipi, i);
>  			break;
>  		}
