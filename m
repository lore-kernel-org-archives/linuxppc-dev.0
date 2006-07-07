Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C3DB67B66
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:57:59 +1000 (EST)
Subject: Re: G5 troubles booting powerpc-git (July 6)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060707015237.68c768f2.akpm@osdl.org>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
	<1152226587.9862.19.camel@localhost.localdomain>
	<20060707012330.f1dea5ac.akpm@osdl.org>
	<1152260824.9862.57.camel@localhost.localdomain>
	<20060707015237.68c768f2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 18:57:47 +1000
Message-Id: <1152262667.9862.64.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > If it doesn't fix it, then it's indeed a completely different issue that I'll have to track down tomorrow
> > hopefully.
> 
> Needs this to compile:

Yeah, it's a powermac-only patch at the moment... thanks for doing part
of my work tho :)

Cheers,
Ben.

> diff -puN arch/powerpc/platforms/pseries/ras.c~a-fix arch/powerpc/platforms/pseries/ras.c
> --- a/arch/powerpc/platforms/pseries/ras.c~a-fix
> +++ a/arch/powerpc/platforms/pseries/ras.c
> @@ -93,8 +93,7 @@ static void request_ras_irqs(struct devi
>  		for (i = 0; i < opicplen; i++) {
>  			if (count > 15)
>  				break;
> -			virqs[count] = irq_create_mapping(NULL, *(opicprop++),
> -							 IRQ_TYPE_NONE);
> +			virqs[count] = irq_create_mapping(NULL, *(opicprop++));
>  			if (virqs[count] == NO_IRQ)
>  				printk(KERN_ERR "Unable to allocate interrupt "
>  				       "number for %s\n", np->full_name);
> diff -puN arch/powerpc/platforms/pseries/xics.c~a-fix arch/powerpc/platforms/pseries/xics.c
> --- a/arch/powerpc/platforms/pseries/xics.c~a-fix
> +++ a/arch/powerpc/platforms/pseries/xics.c
> @@ -757,7 +757,7 @@ void xics_request_IPIs(void)
>  {
>  	unsigned int ipi;
>  
> -	ipi = irq_create_mapping(xics_host, XICS_IPI, 0);
> +	ipi = irq_create_mapping(xics_host, XICS_IPI);
>  	BUG_ON(ipi == NO_IRQ);
>  
>  	/*
> diff -puN drivers/char/hvsi.c~a-fix drivers/char/hvsi.c
> --- a/drivers/char/hvsi.c~a-fix
> +++ a/drivers/char/hvsi.c
> @@ -1299,7 +1299,7 @@ static int __init hvsi_console_init(void
>  		hp->inbuf_end = hp->inbuf;
>  		hp->state = HVSI_CLOSED;
>  		hp->vtermno = *vtermno;
> -		hp->virq = irq_create_mapping(NULL, irq[0], 0);
> +		hp->virq = irq_create_mapping(NULL, irq[0]);
>  		if (hp->virq == NO_IRQ) {
>  			printk(KERN_ERR "%s: couldn't create irq mapping for 0x%x\n",
>  				__FUNCTION__, irq[0]);
> _
> 
> But it still doesn't help.
> 
> 
> These:
> 
> arch/powerpc/sysdev/i8259.c:222: warning: initialization from incompatible pointer type
> arch/powerpc/platforms/pseries/xics.c:555: warning: initialization from incompatible pointer type
> arch/powerpc/platforms/pseries/xics.c:561: warning: initialization from incompatible pointer type
> 
> look like super-serious box-killers.  Hope I'm not using either of those.

As I said, it's powermac only for now. I need to fix the above among
others. It's simple changes in most case. In the meantime, try on your
quad using a g5_defconfig

Ben.
