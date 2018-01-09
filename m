Return-Path: <jesper.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGH5f4LRBzF0fn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 03:04:38 +1100 (AEDT)
Date: Tue, 9 Jan 2018 16:55:50 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 x86@kernel.org, linux-snps-arc@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/67] dma-mapping: replace PCI_DMA_BUS_IS_PHYS with a
 flag in struct dma_map_ops
Message-ID: <20180109155550.GP32368@axis.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229081911.2802-6-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 29, 2017 at 09:18:09AM +0100, Christoph Hellwig wrote:
> The current PCI_DMA_BUS_IS_PHYS decided if a dma implementation is bound
> by the dma mask in the device because it directly maps to a physical
> address range (modulo an offset in the device), or if it is virtualized
> by an iommu and can map any address (that includes virtual iommus like
> swiotlb).  The problem with this scheme is that it is per-architecture and
> not per dma_ops instance, and we are growing more and more setups that
> have multiple different dma operations in use on a single system, for
> which this scheme can't provide a correct answer.  Depending on the
> architecture that means we either get a false positive or false negative
> at the moment.
> 
> This patch instead extents the is_phys flag in struct dma_map_ops that
> is currently only used by a few architectures to be used tree wide.
> 
> Note that this means that we now need a struct device parent in the
> Scsi_Host or netdevice.  Every modern driver has these, but there might
> still be a few outdated legacy drivers out there, which now won't make
> an intelligent decision.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/arch-v32/drivers/pci/dma.c  |  1 +
>  arch/cris/include/asm/pci.h           |  6 ------

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
