Return-Path: <ckoenig.leichtzumerken@gmail.com>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhpn1c1XzF0gR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:23:12 +1100 (AEDT)
Received: by mail-wm0-x232.google.com with SMTP id 141so8455506wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 00:23:12 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: consolidate swiotlb dma_map implementations
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek
 <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180110080932.14157-1-hch@lst.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5ef96935-f781-96e1-37cc-528d399f0150@gmail.com>
Date: Wed, 10 Jan 2018 09:23:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

Regards,
Christian.

Am 10.01.2018 um 09:09 schrieb Christoph Hellwig:
> A lot of architectures have essentially identical dma_map_ops
> implementations to use swiotlb.  This series adds new generic
> swiotlb_alloc/free helpers that take the attrs argument exposed
> in dma_map_ops, and which do an enhanced direct allocation
> modelled after x86 and reused from the dma-direct code, and
> then switches most architectures over to it.  The only exceptions
> are mips, which requires additional cache flushing which will
> need a new abstraction, and x86 itself which will be handled in
> a later series with other x86 dma mapping changes.
>
> To support the generic code a few architectures that currently
> use ZONE_DMA/GFP_DMA for <= 32-bit allocations are switched to
> implement ZONE_DMA32 instead.
>
> This series is based on the previously sent series to consolidate
> the direct dma mapping implementation.  A git tree with this
> series as well as the prerequisites is available here:
>
>     git://git.infradead.org/users/hch/misc.git swiotlb
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb
