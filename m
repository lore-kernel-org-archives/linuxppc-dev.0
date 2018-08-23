Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wtCV4rSpzF2X0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 15:25:10 +1000 (AEST)
Message-ID: <e074e74017742a60607c8ce7f78281dc8fdbcdc7.camel@kernel.crashing.org>
Subject: Re: [PATCH 01/20] kernel/dma/direct: take DMA offset into account
 in dma_direct_supported
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Date: Thu, 23 Aug 2018 15:24:48 +1000
In-Reply-To: <20180823052403.GA14388@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-2-hch@lst.de>
 <74068e4d2135ecad8645048ed97b1114891ccace.camel@kernel.crashing.org>
 <20180822065359.GB19284@lst.de>
 <079a961eaf548644250719df83930d3d72e34cac.camel@kernel.crashing.org>
 <20180823052403.GA14388@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-23 at 07:24 +0200, Christoph Hellwig wrote:
> > Well, iommus can have bypass regions, which we also use for
> > performance, so we do at dma_set_mask() time "swap" the ops around, and
> > in that case, we do want to check the mask against the actual top of
> > memory...
> 
> That is a bit of a powerpc special case (we also had one other arch
> doing that, but it got removed in the great purge, can't rember which
> one right now).  Everyone else has one set of ops, and they just switch
> to the direct mapping inside the iommu ops.

We more or less do that too in some of ours these days bcs of the whole
coherent_mask vs mask where a given device might need either depending
on the type of mapping.

Ben.
