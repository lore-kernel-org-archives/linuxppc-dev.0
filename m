Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B92B7DDEB9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 09:17:50 +1000 (EST)
Subject: Re: [PATCH] powerpc: mpic: minor optimization of ipi handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071019185110.GA11911@lixom.net>
References: <20071019185110.GA11911@lixom.net>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 09:17:39 +1000
Message-Id: <1192835859.17235.12.camel@pasglop>
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


On Fri, 2007-10-19 at 13:51 -0500, Olof Johansson wrote:
> Jeff Garzik pointed out that we don't actually have to lookup the mpic
> instance since it's passed in as the interrupt handler data for IPIs.

Note that's typically one of the annoying case where we use "irq"
for a good reasons, getting the way of Jeff attempt at removing
this argument.

I suppose a working approach would be to have 4 mpic IPI handlers...

Ben. 

> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index e479388..6bf56f4 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -612,11 +612,10 @@ static inline void mpic_eoi(struct mpic *mpic)
>  }
>  
>  #ifdef CONFIG_SMP
> -static irqreturn_t mpic_ipi_action(int irq, void *dev_id)
> +static irqreturn_t mpic_ipi_action(int irq, void *data)
>  {
> -	struct mpic *mpic;
> +	struct mpic *mpic = data;
>  
> -	mpic = mpic_find(irq, NULL);
>  	smp_message_recv(mpic_irq_to_hw(irq) - mpic->ipi_vecs[0]);
>  
>  	return IRQ_HANDLED;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
