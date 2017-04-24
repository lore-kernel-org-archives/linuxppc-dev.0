Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wB8L12TV2zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 11:45:12 +1000 (AEST)
Message-ID: <1492998299.25397.14.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: roy.pledge@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
Cc: madalin.bucur@nxp.com
Date: Sun, 23 Apr 2017 20:44:59 -0500
In-Reply-To: <1492634930-10765-3-git-send-email-roy.pledge@nxp.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
 <1492634930-10765-3-git-send-email-roy.pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 02/11] soc/fsl/qbman: Use shared-dma-pool for QMan
 private memory allocations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 16:48 -0400, Roy Pledge wrote:
> @@ -727,10 +730,81 @@ static int fsl_qman_probe(struct platform_device
> *pdev)
>  		qm_channel_caam = QMAN_CHANNEL_CAAM_REV3;
>  	}
>  
> -	ret = zero_priv_mem(dev, node, fqd_a, fqd_sz);
> -	WARN_ON(ret);
> -	if (ret)
> -		return -ENODEV;
> +	if (fqd_a) {
> +#ifdef CONFIG_PPC
> +		/*
> +		 * For PPC backward DT compatibility
> +		 * FQD memory MUST be zero'd by software
> +		 */
> +		zero_priv_mem(fqd_a, fqd_sz);
> +#endif

Should probably warn if you get here on non-PPC rather than silently accepting
it.

> +	} else {
> +		/*
> +		 * Order of memory regions is assumed as FQD followed by
> PFDR
> +		 * in order to ensure allocations from the correct regions
> the
> +		 * driver initializes then allocates each piece in order
> +		 */

This should be explicitly specified in the binding rather than here.



> +		ret = of_reserved_mem_device_init_by_idx(dev, dev->of_node, 
> 0);
> +		if (ret) {
> +			dev_err(dev, "of_reserved_mem_device_init_by_idx(0)
> failed 0x%x\n",
> +				ret);
> +			return -ENODEV;
> +		}
> +		mem_node = of_parse_phandle(dev->of_node, "memory-region",
> 0);
> +		if (mem_node) {
> +			ret = of_property_read_u64(mem_node, "size",
> &size);
> +			if (ret) {
> +				dev_err(dev, "FQD: of_address_to_resource
> fails 0x%x\n",
> +					ret);
> +				return -ENODEV;
> +			}
> +			fqd_sz = size;
> +		} else {
> +			dev_err(dev, "No memory-region found for FQD\n");
> +			return -ENODEV;
> +		}
> +		if (!dma_zalloc_coherent(dev, fqd_sz, &fqd_a, 0)) {
> +			dev_err(dev, "Alloc FQD memory failed\n");
> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * Disassociate the FQD reseverd memory area from the
> device
> +		 * because a device can only have one DMA memory area. This
> +		 * should be fine since the memory is allocated and
> initialized
> +		 * and only ever accessed by the QMan device from now on
> +		 */
> +		of_reserved_mem_device_release(dev);

s/reseverd/reserved/


> +	}
> +	dev_info(dev, "Allocated FQD 0x%llx 0x%zx\n", fqd_a, fqd_sz);

dev_dbg()?

-Scott
