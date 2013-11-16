Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F107B2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2013 02:33:24 +1100 (EST)
Date: Sat, 16 Nov 2013 15:32:44 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 16/51] DMA-API: ppc: vio.c: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
Message-ID: <20131116153244.GD25039@n2100.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMly8-0007gy-Ru@rmk-PC.arm.linux.org.uk> <528648F7.20900@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <528648F7.20900@fr.ibm.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 05:16:55PM +0100, Cedric Le Goater wrote:
> The new helper routine dma_set_mask_and_coherent() breaks the 
> initialization of the pseries vio devices which do not have an 
> initial dev->dma_mask. I think we need to use dma_coerce_mask_and_coherent()
> instead.

Who wants to handle this patch?

Also, is it possible to fix it so that dev->dma_mask is correctly setup
by the code which creates the device, as it should be in the first place?

Thanks

> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---
>  arch/powerpc/kernel/vio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index e7d0c88f..76a6482 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1419,7 +1419,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
>  
>  		/* needed to ensure proper operation of coherent allocations
>  		 * later, in case driver doesn't set it explicitly */
> -		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
> +		dma_coerce_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
>  	}
>  
>  	/* register with generic device framework */
> -- 
> 1.7.10.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
