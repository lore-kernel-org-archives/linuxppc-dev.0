Return-Path: <lists@gate-nine.de>
Received: from csmtp3.one.com (csmtp3.one.com [91.198.169.23])
	by ozlabs.org (Postfix) with ESMTP id 65FB0B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 21:19:41 +1100 (EST)
Subject: Re: [PATCH][v1] powerpc/fsl: 85xx: add cache-sram support
From: Philipp Ittershagen <lists@gate-nine.de>
To: harninder.rai@freescale.com
In-Reply-To: <1286961435-3010-1-git-send-email-harninder.rai@freescale.com>
References: <1286961435-3010-1-git-send-email-harninder.rai@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 12:10:40 +0200
Message-ID: <1286964640.16168.8.camel@peter.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Harninder,

On Wed, 2010-10-13 at 14:47 +0530, harninder.rai@freescale.com wrote:
> +int __init instantiate_cache_sram(struct platform_device *dev,
> +		struct sram_parameters sram_params)
> +{
> +	if (cache_sram) {
> +		dev_err(&dev->dev, "Already initialized cache-sram\n");
> +		return -EBUSY;
> +	}
> +
> +	cache_sram = kzalloc(sizeof(struct mpc85xx_cache_sram), GFP_KERNEL);
> +	if (!cache_sram) {
> +		dev_err(&dev->dev, "Out of memory for cache_sram structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	cache_sram->base_phys = sram_params.sram_offset;
> +	cache_sram->size = sram_params.sram_size;
> +
> +	if (!request_mem_region(cache_sram->base_phys, cache_sram->size,
> +						"fsl_85xx_cache_sram")) {
> +		dev_err(&dev->dev, "%s: request memory failed\n",
> +				dev->dev.of_node->full_name);
> +		kfree(cache_sram);
> +		return -ENXIO;
> +	}
> +
> +	cache_sram->base_virt = ioremap_flags(cache_sram->base_phys,
> +				cache_sram->size, _PAGE_COHERENT | PAGE_KERNEL);
> +	if (!cache_sram->base_virt) {
> +		dev_err(&dev->dev, "%s: ioremap_flags failed\n",
> +				dev->dev.of_node->full_name);
> +		release_mem_region(cache_sram->base_phys, cache_sram->size);
> +		kfree(cache_sram);
> +		return -ENOMEM;
> +	}
> +
> +	cache_sram->rh = rh_create(sizeof(unsigned int));
> +	if (IS_ERR(cache_sram->rh)) {
> +		dev_err(&dev->dev, "%s: Unable to create remote heap\n",
> +				dev->dev.of_node->full_name);
> +		iounmap(cache_sram->base_virt);
> +		release_mem_region(cache_sram->base_phys, cache_sram->size);
> +		kfree(cache_sram);
> +		return PTR_ERR(cache_sram->rh);
> +	}
> +
> +	rh_attach_region(cache_sram->rh, 0, cache_sram->size);
> +	spin_lock_init(&cache_sram->lock);
> +
> +	dev_info(&dev->dev, "[base:0x%llx, size:0x%x] configured and loaded\n",
> +		(unsigned long long)cache_sram->base_phys, cache_sram->size);
> +	return 0;
> +}

You could save some redundant code by using goto statements for error
handling.

For example:

...

int ret;

if (!request_mem_region(...)) {
	ret = -ENXIO;
	goto out_free;
}


if (!ioremap(...)) {
	ret = -ENOMEM;
	goto out_release;
}

if (!IS_ERR(cache_sram->rh)) {
	ret = PTR_ERR(...);
	goto out_unmap;
}

...

return 0;

out_unmap:
	iounmap(...);
out_release:
	release_mem_region(...);
out_free:
	kfree(...);
	return ret;
}



-- Philipp
