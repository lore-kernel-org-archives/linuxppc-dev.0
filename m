Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wJQD2gZbzF2FN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 17:02:28 +1000 (AEST)
Date: Wed, 22 Aug 2018 09:04:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 17/20] powerpc/dma-swiotlb: use generic swiotlb_dma_ops
Message-ID: <20180822070406.GE19284@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-18-hch@lst.de>
 <556a4302d13b1caafb223112c4de43d959146215.camel@kernel.crashing.org>
 <777010cd04645b55aa4197eddcc880f010f0ef6d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <777010cd04645b55aa4197eddcc880f010f0ef6d.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2018 at 11:57:53AM +1000, Benjamin Herrenschmidt wrote:
> Note: We will still need to implement some custom variant of this
> for our secure VMs ... 
> 
> Basically we'll need to use the existing bounce bufferring as-is but
> the condition will be different, it won't be whether the address is
> below a certain limit, it will be *always*.

The conditions are in the dma_capable() helper that the architecture
can override (and which powerpc already does override).
