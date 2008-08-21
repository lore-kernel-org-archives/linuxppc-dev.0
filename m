Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F0866DF6B9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:56:13 +1000 (EST)
Date: Fri, 22 Aug 2008 01:56:11 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3]: sparc: Implement irq_of_parse_and_map() and
	irq_dispose_mapping().
Message-ID: <20080821215611.GA14354@oksana.dev.rtsoft.ru>
References: <20080821.001017.261408123.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080821.001017.261408123.davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 12:10:17AM -0700, David Miller wrote:
> 
> sparc: Implement irq_of_parse_and_map() and irq_dispose_mapping().
> 
> This allows more OF layer code to be shared between powerpc and
> sparc.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/prom.h   |    8 ++++++++
>  arch/sparc/kernel/of_device.c   |   11 +++++++++++
>  arch/sparc64/kernel/of_device.c |   11 +++++++++++
>  3 files changed, 30 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
> index b5efc4d..58b85fa 100644
> --- a/arch/sparc/include/asm/prom.h
> +++ b/arch/sparc/include/asm/prom.h
> @@ -96,6 +96,14 @@ static inline void of_node_put(struct device_node *node)
>  {
>  }
>  
> +/* These routines are here to provide compatibility with how powerpc
> + * handles IRQ mapping for OF device nodes.  We precompute and permanently
> + * register them in the of_device objects, whereas powerpc computes them
> + * on request.
> + */
> +extern int irq_of_parse_and_map(struct device_node *node, int index);

On powerpc irq_of_parse_and_map() returns unsigned type.

> +#define irq_dispose_mapping(irq) do { } while (0)

I'd rather write it as a static inline function, for type checking,
plus, I think with this macros gcc may generate warnings about
defined but unused variables.

> +
>  /*
>   * NB:  This is here while we transition from using asm/prom.h
>   * to linux/of.h
> diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
> index cc4c235..56e9a71 100644
> --- a/arch/sparc/kernel/of_device.c
> +++ b/arch/sparc/kernel/of_device.c
> @@ -29,6 +29,17 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
>  }
>  EXPORT_SYMBOL(of_find_device_by_node);
>  
> +int irq_of_parse_and_map(struct device_node *node, int index)
> +{
> +	struct of_device *op = of_find_device_by_node(node);
> +
> +	if (!op || index >= op->num_irqs)
> +		return 0xffffffff;

This is valid virq, unfortunately. There is only one invalid virq: 0.
With this most drivers will fail to identify 'there is no irq' case.
Does virq0 has special meaning on sparc?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
