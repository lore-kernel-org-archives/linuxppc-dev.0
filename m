Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3660E679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 13:52:28 +1000 (EST)
Subject: Re: [PATCH] Make irq_dispose_mapping(NO_IRQ) a nop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20061024033735.AF71B67B6D@ozlabs.org>
References: <20061024033735.AF71B67B6D@ozlabs.org>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 13:52:17 +1000
Message-Id: <1161661937.10524.549.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-24 at 13:37 +1000, Michael Ellerman wrote:
> It makes for a friendlier API if irq_dispose_mapping(NO_IRQ) is a
> nop, rather than triggering a WARN_ON.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
>  arch/powerpc/kernel/irq.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: git/arch/powerpc/kernel/irq.c
> ===================================================================
> --- git.orig/arch/powerpc/kernel/irq.c
> +++ git/arch/powerpc/kernel/irq.c
> @@ -626,10 +626,14 @@ EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
>  
>  void irq_dispose_mapping(unsigned int virq)
>  {
> -	struct irq_host *host = irq_map[virq].host;
> +	struct irq_host *host;
>  	irq_hw_number_t hwirq;
>  	unsigned long flags;
>  
> +	if (virq == NO_IRQ)
> +		return;
> +
> +	host = irq_map[virq].host;
>  	WARN_ON (host == NULL);
>  	if (host == NULL)
>  		return;
