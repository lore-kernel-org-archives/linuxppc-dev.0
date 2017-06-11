Return-Path: <konrad.wilk@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wlgDk4XFpzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 12:37:57 +1000 (AEST)
Date: Sat, 10 Jun 2017 22:36:44 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/44] xen-swiotlb: consolidate xen_swiotlb_dma_ops
Message-ID: <20170611023644.GE30966@char.us.oracle.com>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608132609.32662-8-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 08, 2017 at 03:25:32PM +0200, Christoph Hellwig wrote:
> ARM and x86 had duplicated versions of the dma_ops structure, the
> only difference is that x86 hasn't wired up the set_dma_mask,
> mmap, and get_sgtable ops yet.  On x86 all of them are identical
> to the generic version, so they aren't needed but harmless.
> 
> All the symbols used only for xen_swiotlb_dma_ops can now be marked
> static as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/xen/mm.c              | 17 --------
>  arch/x86/xen/pci-swiotlb-xen.c | 14 -------
>  drivers/xen/swiotlb-xen.c      | 93 ++++++++++++++++++++++--------------------
>  include/xen/swiotlb-xen.h      | 62 +---------------------------
>  4 files changed, 49 insertions(+), 137 deletions(-)

Yeeey!

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
