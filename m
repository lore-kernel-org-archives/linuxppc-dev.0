Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xtKZv2bYWzDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 23:47:02 +1000 (AEST)
Date: Thu, 14 Sep 2017 14:46:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, arnd@arndb.de, madalin.bucur@nxp.com,
 linux@armlinux.org.uk, oss@buserror.net
Subject: Re: [v4 01/11] soc/fsl/qbman: Use shared-dma-pool for BMan private
 memory allocations
Message-ID: <20170914134656.if6qjfkp4gdtou5u@localhost>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-2-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503607075-28970-2-git-send-email-roy.pledge@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2017 at 04:37:45PM -0400, Roy Pledge wrote:
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
[...]
> @@ -201,6 +202,38 @@ static int fsl_bman_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/*
> +	 * If FBPR memory wasn't defined using the qbman compatible string
> +	 * try using the of_reserved_mem_device method
> +	 */
> +	if (!fbpr_a) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret) {
> +			dev_err(dev, "of_reserved_mem_device_init() failed 0x%x\n",
> +				ret);
> +			return -ENODEV;
> +		}
> +		mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
> +		if (mem_node) {
> +			ret = of_property_read_u64(mem_node, "size", &size);
> +			if (ret) {
> +				dev_err(dev, "FBPR: of_address_to_resource fails 0x%x\n",
> +					ret);
> +				return -ENODEV;
> +			}
> +			fbpr_sz = size;
> +		} else {
> +			dev_err(dev, "No memory-region found for FBPR\n");
> +			return -ENODEV;
> +		}
> +		if (!dma_zalloc_coherent(dev, fbpr_sz, &fbpr_a, 0)) {
> +			dev_err(dev, "Alloc FBPR memory failed\n");
> +			return -ENODEV;
> +		}
> +	}

At a quick look, I think I spotted this pattern a couple of more times
in the subsequent patch. Could it be moved to a common function?

-- 
Catalin
