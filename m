Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7C3FB7B69
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 15:19:56 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: rename get_dma_direct_offset get_dma_offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1251930200-4796-1-git-send-email-beckyb@kernel.crashing.org>
References: <1251930200-4796-1-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 21 Sep 2009 15:19:50 +1000
Message-Id: <1253510390.7103.127.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-02 at 17:23 -0500, Becky Bruce wrote:

>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  /*
> @@ -90,6 +89,14 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
>  	dev->archdata.dma_ops = ops;
>  }
>  
> +static inline unsigned long get_dma_offset(struct device *dev)
> +{
> +	if (dev)
> +		return (unsigned long)dev->archdata.dma_data;
> +
> +	return PCI_DRAM_OFFSET;
> +}

My main objection here is that this makes it look "too" generic ... it
only works for direct and swiotlb, not iommu. Maybe not a big deal but
I think at least there should be a comment explaining what it is and
when it can be used in the header.

Cheers,
Ben.
