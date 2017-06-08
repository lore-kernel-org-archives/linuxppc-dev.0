Return-Path: <julian.calaby@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk71q3wMDzDqPX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 00:23:11 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id w1so8420243qtg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 07:23:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170608132609.32662-29-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-29-hch@lst.de>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 9 Jun 2017 00:22:48 +1000
Message-ID: <CAGRGNgUJ3J_LEwhJ1rFHuzZ_J4OnTV9-DekcuT=N5z1pBKcb3A@mail.gmail.com>
Subject: Re: [PATCH 28/44] sparc: remove arch specific dma_supported
 implementations
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On Thu, Jun 8, 2017 at 11:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> Usually dma_supported decisions are done by the dma_map_ops instance.
> Switch sparc to that model by providing a ->dma_supported instance for
> sbus that always returns false, and implementations tailored to the sun4u
> and sun4v cases for sparc64, and leave it unimplemented for PCI on
> sparc32, which means always supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sparc/include/asm/dma-mapping.h |  3 ---
>  arch/sparc/kernel/iommu.c            | 40 +++++++++++++++---------------------
>  arch/sparc/kernel/ioport.c           | 22 ++++++--------------
>  arch/sparc/kernel/pci_sun4v.c        | 17 +++++++++++++++
>  4 files changed, 39 insertions(+), 43 deletions(-)
>
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index dd081d557609..12894f259bea 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -401,6 +401,11 @@ static void sbus_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>         BUG();
>  }
>
> +static int sbus_dma_supported(struct device *dev, u64 mask)
> +{
> +       return 0;
> +}
> +

I'm guessing there's a few places that have DMA ops but DMA isn't
actually supported. Why not have a common method for this, maybe
"dma_not_supported"?

>  static const struct dma_map_ops sbus_dma_ops = {
>         .alloc                  = sbus_alloc_coherent,
>         .free                   = sbus_free_coherent,
> @@ -410,6 +415,7 @@ static const struct dma_map_ops sbus_dma_ops = {
>         .unmap_sg               = sbus_unmap_sg,
>         .sync_sg_for_cpu        = sbus_sync_sg_for_cpu,
>         .sync_sg_for_device     = sbus_sync_sg_for_device,
> +       .dma_supported          = sbus_dma_supported,
>  };
>
>  static int __init sparc_register_ioport(void)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
