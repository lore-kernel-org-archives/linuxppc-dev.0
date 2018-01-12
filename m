Return-Path: <konrad.r.wilk@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ3Dm5zfGzDqpn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 00:16:56 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id g10so5936809qtj.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:16:56 -0800 (PST)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date: Fri, 12 Jan 2018 08:16:48 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/33] dma-mapping: warn when there is no coherent_dma_mask
Message-ID: <20180112131646.GA26900@localhost.localdomain>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180110080027.13879-20-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2018 at 09:00:13AM +0100, Christoph Hellwig wrote:
> These days all devices should have a DMA coherent mask, and most dma_ops
> implementations rely on that fact.  But just to be sure add an assert to
> ring the warning bell if that is not the case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  include/linux/dma-mapping.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d84951865be7..9f28b2fa329e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -513,6 +513,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  	void *cpu_addr;
>  
>  	BUG_ON(!ops);
> +	WARN_ON_ONCE(!dev->coherent_dma_mask);
>  
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
> -- 
> 2.14.2
> 
