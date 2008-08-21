Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 95D98DF5A0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:59:47 +1000 (EST)
Date: Thu, 21 Aug 2008 14:59:46 -0700 (PDT)
Message-Id: <20080821.145946.01710005.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/3]: sparc: Implement irq_of_parse_and_map() and
	irq_dispose_mapping().
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080821215611.GA14354@oksana.dev.rtsoft.ru>
References: <20080821.001017.261408123.davem@davemloft.net>
	<20080821215611.GA14354@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Fri, 22 Aug 2008 01:56:11 +0400

> On Thu, Aug 21, 2008 at 12:10:17AM -0700, David Miller wrote:
> > @@ -96,6 +96,14 @@ static inline void of_node_put(struct device_node *node)
> >  {
> >  }
> >  
> > +/* These routines are here to provide compatibility with how powerpc
> > + * handles IRQ mapping for OF device nodes.  We precompute and permanently
> > + * register them in the of_device objects, whereas powerpc computes them
> > + * on request.
> > + */
> > +extern int irq_of_parse_and_map(struct device_node *node, int index);
> 
> On powerpc irq_of_parse_and_map() returns unsigned type.
> 
> > +#define irq_dispose_mapping(irq) do { } while (0)
> 
> I'd rather write it as a static inline function, for type checking,
> plus, I think with this macros gcc may generate warnings about
> defined but unused variables.

Thanks, I'll fix that.

> > +
> >  /*
> >   * NB:  This is here while we transition from using asm/prom.h
> >   * to linux/of.h
> > diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
> > index cc4c235..56e9a71 100644
> > --- a/arch/sparc/kernel/of_device.c
> > +++ b/arch/sparc/kernel/of_device.c
> > @@ -29,6 +29,17 @@ struct of_device *of_find_device_by_node(struct device_node *dp)
> >  }
> >  EXPORT_SYMBOL(of_find_device_by_node);
> >  
> > +int irq_of_parse_and_map(struct device_node *node, int index)
> > +{
> > +	struct of_device *op = of_find_device_by_node(node);
> > +
> > +	if (!op || index >= op->num_irqs)
> > +		return 0xffffffff;
> 
> This is valid virq, unfortunately. There is only one invalid virq: 0.
> With this most drivers will fail to identify 'there is no irq' case.
> Does virq0 has special meaning on sparc?

No, I'll fix this up, thanks.
