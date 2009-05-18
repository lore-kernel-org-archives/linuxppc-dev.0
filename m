Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA07DDE060
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 14:49:23 +1000 (EST)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 18 May 2009 14:49:01 +1000
Message-Id: <1242622141.18075.37.camel@pasglop>
Mime-Version: 1.0
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-14 at 17:42 -0500, Becky Bruce wrote:
> This patch includes the basic infrastructure to use swiotlb
> bounce buffering on 32-bit powerpc.  It is not yet enabled on
> any platforms.  Probably the most interesting bit is the
> addition of addr_needs_map to dma_ops - we need this as
> a dma_op because the decision of whether or not an addr
> can be mapped by a device is device-specific.
> 
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>

Hi Becky !

Finally I got to look at your patch :-)

A few comments below...

>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  /*
>   * DMA-consistent mapping functions for PowerPCs that don't support
> @@ -76,6 +85,8 @@ struct dma_mapping_ops {
>  				dma_addr_t dma_address, size_t size,
>  				enum dma_data_direction direction,
>  				struct dma_attrs *attrs);
> +	int		(*addr_needs_map)(struct device *dev, dma_addr_t addr,
> +				size_t size);

What annoys me here is that we basically end up with two indirect
function calls for pretty much any DMA map. One was bad enough on low
end processors or very intensive networking, but this is getting real
bad don't you think ?

Granted, this is only used when swiotlb is used too, but still...

So the problem is that the region that can pass-through is somewhat
a mix of bus specific (incoming DMA window location & size) and
device specific (device addressing limitations).

Now, if we can always reduce it to a single range though, which I
think is practically the case, can't we instead pre-calculate that
range and stick -that- in the struct dev archdata or similar thus
speeding up the decision for a given address as to whether it needs
a swiotlb mapping or not ? Or does it gets too messy ?

Cheers,
Ben.
