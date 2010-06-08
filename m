Return-Path: <cbouatmailru@gmail.com>
Date: Tue, 8 Jun 2010 19:57:02 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
Message-ID: <20100608155702.GA5419@oksana.dev.rtsoft.ru>
References: <20100608142152.26088.1108.stgit@angua>
	<20100608142643.26088.61366.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100608142643.26088.61366.stgit@angua>
Cc: ben@kernel.crashing.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 08, 2010 at 08:26:43AM -0600, Grant Likely wrote:
[...]
> +	dev = kzalloc(sizeof(*dev) + (sizeof(struct resource) * i), GFP_KERNEL);
>  	if (!dev)
>  		return NULL;
> -
>  	dev->dev.of_node = of_node_get(np);
>  	dev->dev.dma_mask = &dev->archdata.dma_mask;
>  	dev->dev.parent = parent;
>  	dev->dev.release = of_release_dev;
>  
> +	/* Populate the resource table */
> +	if (num_irq || num_reg) {
> +		dev->resource = (void*)&dev[1];

This is ugly. Why not allocate the memory specifically for
dev->resource? Is this because you plan to get rid of
of_release_dev(), and the generic release_dev() won't
know if it should free the dev->resource? There must
be a better way to handle this.

p.s.

[Two Minutes Hate for Grant.]

Just wonder what happened to of_gpio stuff? You blocked it
in 2.6.34 for no reason saying "I'll pick it into my OF
tree before the 2.6.35 merge window" and it's 2.6.36 merge
window quite soon.

It's still in origin/test-devicetree, which is obviously
not -next. What is your plan now?

Thanks,

> +		dev->num_resources = num_reg + num_irq;
> +		res = dev->resource;
> +		for (i = 0; i < num_reg; i++, res++) {
> +			rc = of_address_to_resource(np, i, res);
> +			WARN_ON(rc);
> +		}
> +		for (i = 0; i < num_irq; i++, res++) {
> +			rc = of_irq_to_resource(np, i, res);
> +			WARN_ON(rc == NO_IRQ);
> +		}
> +	}
> +
>  	if (bus_id)
>  		dev_set_name(&dev->dev, "%s", bus_id);
>  	else

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
