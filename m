Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45B6C1A0028
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 08:56:38 +1000 (EST)
Date: Wed, 3 Sep 2014 17:56:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nikhil Badola <nikhil.badola@freescale.com>
Subject: Re: powerpc : dma-mapping : Check null condition for
 dev->archdata.dma_ops
Message-ID: <20140903225621.GA4657@home.buserror.net>
References: <1405677892-7201-1-git-send-email-nikhil.badola@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1405677892-7201-1-git-send-email-nikhil.badola@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 18, 2014 at 03:34:52PM +0530, Nikhil Badola wrote:
> Modifies get_dma_ops() implementation on ppc arch to check null condition
> for dev->archdata.dma_ops; returns common dma_direct_ops structure in
> case its NULL
> 
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> ---
>  arch/powerpc/include/asm/dma-mapping.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

I'm not sure why this was delegated to me in patchwork, as it doesn't
appear to be FSL-specific...  I wish patchwork showed the history of
changes to a patch.

> The use case in which ops are null is while running USB in Gadget and
> Otg mode.
> 
> For PPC architecture, whenever a platform device is registered,
> pdev->dev is assigned dma_ops.  In USB, one single chipidea platform
> device is registered for any mode (host, gadget or otg) whose dev, as
> explained above, has dma_ops set and this dev is assigned to
> ci->dev(dev of chipidea struct) which is used by host controller
> device.  That is why we don't need the above null case checking in host
> mode.  But when we run usb in gadget/otg mode, the device structure
> used is ci->gadget.dev which does not have dma_ops set and it crashes
> when dma transaction starts when it calls get_dma_ops() which returns
> NULL.
>
> A similar approach is used in ARM architecture which checks for null
> condition and returns common dma_ops

The above doesn't make it clear to me why dma_ops is NULL in non-host
modes, or why "direct" is necessarily the right ops -- what if swiotlb or
an iommu is needed?

If the problem is that you're using a "struct device" other than the
platform device, shouldn't that be fixed?  Or make sure that this other
"struct device" has been properly set up by arch code for doing DMA.

>  }
>  
> +
>  static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)

Don't add this newline

-Scott
