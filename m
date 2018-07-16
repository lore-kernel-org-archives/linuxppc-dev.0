Return-Path: <vbabka@suse.cz>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Tb761WwMzF35w
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 17:45:38 +1000 (AEST)
Subject: Re: [PATCH 2/2] dma: remove unsupported gfp_mask parameter from
 dma_alloc_from_contiguous()
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michal Nazarewicz <mina86@mina86.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chris Zankel <chris@zankel.net>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
 Laura Abbott <labbott@redhat.com>, linaro-mm-sig@lists.linaro.org
References: <20180709121956.20200-1-m.szyprowski@samsung.com>
 <CGME20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1@eucas1p2.samsung.com>
 <20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y@eucas1p2.samsung.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c4380664-e9c2-f366-f776-f24af8a42f27@suse.cz>
Date: Mon, 16 Jul 2018 09:45:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2018 02:19 PM, Marek Szyprowski wrote:
> The CMA memory allocator doesn't support standard gfp flags for memory
> allocation, so there is no point having it as a parameter for
> dma_alloc_from_contiguous() function. Replace it by a boolean no_warn
> argument, which covers all the underlaying cma_alloc() function supports.
> 
> This will help to avoid giving false feeling that this function supports
> standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,
> what has already been an issue: see commit dd65a941f6ba ("arm64:
> dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag").
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
