Return-Path: <konrad.r.wilk@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ3Qr6kcYzF0cQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 00:25:40 +1100 (AEDT)
Received: by mail-qk0-x242.google.com with SMTP id i141so8620918qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:25:40 -0800 (PST)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date: Fri, 12 Jan 2018 08:25:34 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Michal Simek <monstr@monstr.eu>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/22] x86: rename swiotlb_dma_ops
Message-ID: <20180112132534.GE26900@localhost.localdomain>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180110080932.14157-6-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2018 at 09:09:15AM +0100, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/kernel/pci-swiotlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 9d3e35c33d94..0d77603c2f50 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -48,7 +48,7 @@ void x86_swiotlb_free_coherent(struct device *dev, size_t size,
>  		dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
>  }
>  
> -static const struct dma_map_ops swiotlb_dma_ops = {
> +static const struct dma_map_ops x86_swiotlb_dma_ops = {
>  	.mapping_error = swiotlb_dma_mapping_error,
>  	.alloc = x86_swiotlb_alloc_coherent,
>  	.free = x86_swiotlb_free_coherent,
> @@ -112,7 +112,7 @@ void __init pci_swiotlb_init(void)
>  {
>  	if (swiotlb) {
>  		swiotlb_init(0);
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &x86_swiotlb_dma_ops;
>  	}
>  }
>  
> -- 
> 2.14.2
> 
