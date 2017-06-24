Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvms1578pzDr0V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 17:18:59 +1000 (AEST)
Date: Sat, 24 Jun 2017 09:18:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: tndave <tushar.n.dave@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clean up and modularize arch dma_mapping interface V2
Message-ID: <20170624071855.GD14580@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
 <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 21, 2017 at 12:24:28PM -0700, tndave wrote:
> Thanks for doing this.
> So archs can still have their own definition for dma_set_mask() if 
> HAVE_ARCH_DMA_SET_MASK is y?
> (and similarly for dma_set_coherent_mask() when 
> CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK is y)
> Any plan to change these?

Yes, those should go away, but I'm not entirely sure how yet.  We'll
need some hook for switching between an IOMMU and a direct mapping
(I guess that's what you want to do for sparc as well?), and I need
to find the best way to do that.  Reimplementing all of dma_set_mask
and dma_set_coherent_mask is something that I want to move away from.
