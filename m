Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1CB7E2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 21:14:16 +1100 (EST)
Message-ID: <1389694446.6933.14.camel@pasglop>
Subject: Re: [PATCH] powerpc: dma-mapping: Return dma_direct_ops variable
 when dev == NULL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Date: Tue, 14 Jan 2014 21:14:06 +1100
In-Reply-To: <1389692656-27758-1-git-send-email-Chunhe.Lan@freescale.com>
References: <1389692656-27758-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-14 at 17:44 +0800, Chunhe Lan wrote:
> Without this patch, kind of below error will be dumped if
> 'insmod ixgbevf.ko' is executed:
> 
>     ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function
>              Network Driver - version 2.7.12-k
>     ixgbevf: Copyright (c) 2009 - 2012 Intel Corporation.
>     ixgbevf 0000:01:10.0: enabling device (0000 -> 0002)
>     ixgbevf 0000:01:10.0: No usable DMA configuration, aborting
>     ixgbevf: probe of 0000:01:10.0 failed with error -5
>     ......
>     ......

That's not right. The DMA ops must be set properly for the VF somewhere
in the arch code instead. When creating VFs, is there a hook allowing
the arch to fix things up ?

(Also adding linux-pci on CC)

Ben.

> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Tested-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
>  arch/powerpc/include/asm/dma-mapping.h |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index e27e9ad..b8c10de 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -84,10 +84,15 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>  	 * only ISA DMA device we support is the floppy and we have a hack
>  	 * in the floppy driver directly to get a device for us.
>  	 */
> -	if (unlikely(dev == NULL))
> -		return NULL;
> -
> -	return dev->archdata.dma_ops;
> +	if (dev && dev->archdata.dma_ops)
> +		return dev->archdata.dma_ops;
> +	/*
> +	 * In some cases (for example, use the Intel(R) 10 Gigabit PCI
> +	 * expression Virtual Function Network Driver -- ixgbevf.ko),
> +	 * their value of dev is the NULL. If return NULL, the driver is
> +	 * aborting. So return dma_direct_ops variable when dev == NULL.
> +	 */
> +	return &dma_direct_ops;
>  }
>  
>  static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
