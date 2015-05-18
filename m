Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35CB51A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:40:27 +1000 (AEST)
In-Reply-To: <1431921411.4160.134.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/iommu: Support "hybrid" iommu/direct DMA ops for
 coherent_mask < dma_mask
Message-Id: <20150518064027.27A97140D18@ozlabs.org>
Date: Mon, 18 May 2015 16:40:27 +1000 (AEST)
Cc: Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-18-05 at 03:56:51 UTC, Benjamin Herrenschmidt wrote:
> This patch adds the ability to the DMA direct ops to fallback to the IOMMU
> ops for coherent alloc/free if the coherent mask of the device isn't
> suitable for accessing the direct DMA space and the device also happens
> to have an active IOMMU table.

Can you do the removal of the union, the #ifdef PPC64 and the static inlines as
a precursor patch, that would remove some of the noise in the diff.

And can you explain the changes to dart, pseries and powernv.

There's also some whitespace changes in iommu.h that I assume you didn't want?

cheers
