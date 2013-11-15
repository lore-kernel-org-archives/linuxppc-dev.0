Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2807F2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2013 03:17:09 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 15 Nov 2013 16:17:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 73BC4219005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 16:17:02 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAFGGnj565994794
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 16:16:49 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAFGH0AO011300
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 09:17:02 -0700
Message-ID: <528648F7.20900@fr.ibm.com>
Date: Fri, 15 Nov 2013 17:16:55 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH 16/51] DMA-API: ppc: vio.c: replace
 dma_set_mask()+dma_set_coherent_mask() with new helper
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMly8-0007gy-Ru@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1VMly8-0007gy-Ru@rmk-PC.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 e1000-devel@lists.sourceforge.net, b43-dev@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, 

On 09/19/2013 11:41 PM, Russell King wrote:
> Replace the following sequence:
> 
> 	dma_set_mask(dev, mask);
> 	dma_set_coherent_mask(dev, mask);
> 
> with a call to the new helper dma_set_mask_and_coherent().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/powerpc/kernel/vio.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 78a3506..96b6c97 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1413,8 +1413,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
> 
>  		/* needed to ensure proper operation of coherent allocations
>  		 * later, in case driver doesn't set it explicitly */
> -		dma_set_mask(&viodev->dev, DMA_BIT_MASK(64));
> -		dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
> +		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
>  	}
> 
>  	/* register with generic device framework */
> 

The new helper routine dma_set_mask_and_coherent() breaks the 
initialization of the pseries vio devices which do not have an 
initial dev->dma_mask. I think we need to use dma_coerce_mask_and_coherent()
instead.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/kernel/vio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index e7d0c88f..76a6482 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1419,7 +1419,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 
 		/* needed to ensure proper operation of coherent allocations
 		 * later, in case driver doesn't set it explicitly */
-		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
+		dma_coerce_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
 	}
 
 	/* register with generic device framework */
-- 
1.7.10.4
