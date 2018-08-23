Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wtBT2b3pzF2Py
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 15:24:17 +1000 (AEST)
Date: Thu, 23 Aug 2018 07:26:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 02/20] kernel/dma/direct: refine dma_direct_alloc zone
 selection
Message-ID: <20180823052604.GB14388@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-3-hch@lst.de>
 <7177553cdb5cd1b968f653a52d7e88bd71aae4d8.camel@kernel.crashing.org>
 <20180822065856.GC19284@lst.de>
 <d9866d44704073ecc418f62da0ba7587ce7c9af8.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d9866d44704073ecc418f62da0ba7587ce7c9af8.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2018 at 10:01:45AM +1000, Benjamin Herrenschmidt wrote:
> > The general scheme that architectures should implement is:
> > 
> > ZONE_DMA:	Any memory below a magic threshold that is lower than
> > 		32-bit.  Only enabled if actually required (usually
> > 		either 24-bit for ISA, or some other weird architecture
> > 		specific value like 32-bit for S/390)
> 
> It should have been ZONE_ISA_DMA :-)

For most of these use cases it should have been indeed, and that
would avoid a lot of confusion where people use GFP_DMA just because
they do DMA.

Anyway, switching powerpc to this scheme would be great, but I don't
think it is required - GFP_KERNEL will silently fall back to ZONE_DMA,
so except for an additional GFP_DMA fallback allocation when the
GFP_KERNEL one fails the code should just work.
