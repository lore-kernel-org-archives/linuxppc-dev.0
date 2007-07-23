Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3B1BDDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 08:04:51 +1000 (EST)
Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Gong <g.chen@freescale.com>
In-Reply-To: <11851892311178-git-send-email-g.chen@freescale.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 08:04:37 +1000
Message-Id: <1185228277.5439.141.camel@localhost.localdomain>
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

On Mon, 2007-07-23 at 19:13 +0800, Chen Gong wrote:
> This patch adds a new member 'name' for irq host's name to
> structure irq_host and modifies the definition of the
> function irq_alloc_host(). The assignment to the
> irq host's name is also added to irq_alloc_host().

I would instead prefer adding a irq_name callback to host, which would
return a per-irq name. In some cases, they could return the OF path to
the host for example.

Ben.

> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Chen Gong <G.Chen@freescale.com>
> ---
>  arch/powerpc/kernel/irq.c |    4 +++-
>  include/asm-powerpc/irq.h |    4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 2fc8786..2c46c6d 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -421,7 +421,8 @@ EXPORT_SYMBOL_GPL(virq_to_hw);
>  struct irq_host *irq_alloc_host(unsigned int revmap_type,
>  				unsigned int revmap_arg,
>  				struct irq_host_ops *ops,
> -				irq_hw_number_t inval_irq)
> +				irq_hw_number_t inval_irq,
> +				const char *name)
>  {
>  	struct irq_host *host;
>  	unsigned int size = sizeof(struct irq_host);
> @@ -446,6 +447,7 @@ struct irq_host *irq_alloc_host(unsigned int revmap_type,
>  	host->revmap_type = revmap_type;
>  	host->inval_irq = inval_irq;
>  	host->ops = ops;
> +	host->name = name;
>  
>  	spin_lock_irqsave(&irq_big_lock, flags);
>  
> diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
> index 0485c53..cd0ba2d 100644
> --- a/include/asm-powerpc/irq.h
> +++ b/include/asm-powerpc/irq.h
> @@ -124,6 +124,7 @@ struct irq_host {
>  	struct irq_host_ops	*ops;
>  	void			*host_data;
>  	irq_hw_number_t		inval_irq;
> +	const char		*name;
>  };
>  
>  /* The main irq map itself is an array of NR_IRQ entries containing the
> @@ -159,7 +160,8 @@ extern irq_hw_number_t virq_to_hw(unsigned int virq);
>  extern struct irq_host *irq_alloc_host(unsigned int revmap_type,
>  				       unsigned int revmap_arg,
>  				       struct irq_host_ops *ops,
> -				       irq_hw_number_t inval_irq);
> +				       irq_hw_number_t inval_irq,
> +				       const char *name);
>  
> 
>  /**
