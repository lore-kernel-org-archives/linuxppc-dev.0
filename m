Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 764752C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 12:28:36 +1100 (EST)
Message-ID: <1384910882.26969.57.camel@pasglop>
Subject: Re: [RFC PATCH powerpc] Fix a dma_mask issue of vio
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Wed, 20 Nov 2013 12:28:02 +1100
In-Reply-To: <1384848697.2511.17.camel@ThinkPad-T5421>
References: <1384848697.2511.17.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 rmk+kernel@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-19 at 16:11 +0800, Li Zhong wrote:
> I encountered following issue:
> [    0.283035] ibmvscsi 30000015: couldn't initialize event pool
> [    5.688822] ibmvscsi: probe of 30000015 failed with error -1
> 
> which prevents the storage from being recognized, and the machine from
> booting.
> 
> After some digging, it seems that it is caused by commit 4886c399da
> 
> as dma_mask pointer in viodev->dev is not set, so in
> dma_set_mask_and_coherent(), dma_set_coherent_mask() is not called
> because dma_set_mask(), which is dma_set_mask_pSeriesLP() returned EIO.
> While before the commit, dma_set_coherent_mask() is always called. 
> 
> I tried to replace dma_set_mask_and_coherent() with
> dma_coerce_mask_and_coherent(), and the machine could boot again. 
> 
> But I'm not sure whether this is the correct fix...

Russell, care to chime in ? I can't make sense of the semantics...

The original commit was fairly clear:

<<
    Replace the following sequence:
    
    	dma_set_mask(dev, mask);
    	dma_set_coherent_mask(dev, mask);
    
    with a call to the new helper dma_set_mask_and_coherent().
>>

It all makes sense so far ... but doesn't work for some odd reason,
and the "fix" uses a function whose name doesn't make much sense to
me ... what is the difference between "setting" and "coercing"
the mask ? And why doe replacing two "set" with a "set both" doesn't
work and require a coerce ?

I'm asking because I'm worried about breakage elsewhere...

Cheers,
Ben. 

> ---
>  arch/powerpc/kernel/vio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index e7d0c88..76a6482 100644
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
> 
> 
> 
> 
