Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E317DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 14:26:45 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Support setting affinity for U3/U4 MSI sources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070917201229.GA17302@lixom.net>
References: <20070917201229.GA17302@lixom.net>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 14:26:37 +1000
Message-Id: <1190089597.6403.71.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-09-17 at 15:12 -0500, Olof Johansson wrote:
> Hook up affinity-setting for U3/U4 MSI interrupt sources.
> 
> Tested on Quad G5 with myri10ge.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8de29f2..22600fd 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -768,7 +768,7 @@ static void mpic_end_ipi(unsigned int irq)
>  
>  #endif /* CONFIG_SMP */
>  
> -static void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
> +void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
>  {
>  	struct mpic *mpic = mpic_from_irq(irq);
>  	unsigned int src = mpic_irq_to_hw(irq);
> diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
> index 3a1c3d2..1cb6bd8 100644
> --- a/arch/powerpc/sysdev/mpic.h
> +++ b/arch/powerpc/sysdev/mpic.h
> @@ -34,5 +34,6 @@ extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
>  extern void mpic_end_irq(unsigned int irq);
>  extern void mpic_mask_irq(unsigned int irq);
>  extern void mpic_unmask_irq(unsigned int irq);
> +extern void mpic_set_affinity(unsigned int irq, cpumask_t cpumask);
>  
>  #endif /* _POWERPC_SYSDEV_MPIC_H */
> diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
> index 305b864..0fc4e96 100644
> --- a/arch/powerpc/sysdev/mpic_u3msi.c
> +++ b/arch/powerpc/sysdev/mpic_u3msi.c
> @@ -40,6 +40,7 @@ static struct irq_chip mpic_u3msi_chip = {
>  	.unmask		= mpic_u3msi_unmask_irq,
>  	.eoi		= mpic_end_irq,
>  	.set_type	= mpic_set_irq_type,
> +	.set_affinity	= mpic_set_affinity,
>  	.typename	= "MPIC-U3MSI",
>  };
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
