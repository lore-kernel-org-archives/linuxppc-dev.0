Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KYcn5cfdzF1LK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 16:10:01 +1000 (AEST)
Message-ID: <0db2832f46cf183619e648c11e26458445eba847.camel@russell.cc>
Subject: Re: [PATCH 2/3] powerpc/powernv: DMA operations for discontiguous
 allocation
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 alistair@popple.id.au, tpearson@raptorengineering.com
Date: Tue, 03 Jul 2018 16:09:53 +1000
In-Reply-To: <20180702184756.72cfde38@aik.ozlabs.ibm.com>
References: <20180629073437.4060-1-ruscur@russell.cc>
 <20180629073437.4060-3-ruscur@russell.cc>
 <20180702184756.72cfde38@aik.ozlabs.ibm.com>
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

On Mon, 2018-07-02 at 18:47 +1000, Alexey Kardashevskiy wrote:
> On Fri, 29 Jun 2018 17:34:36 +1000
> Russell Currey <ruscur@russell.cc> wrote:
> 
> > DMA pseudo-bypass is a new set of DMA operations that solve some
> > issues for
> > devices that want to address more than 32 bits but can't address
> > the 59
> > bits required to enable direct DMA.
> > 
> > The previous implementation for POWER8/PHB3 worked around this by
> > configuring a bypass from the default 32-bit address space into 64-
> > bit
> > address space.  This approach does not work for POWER9/PHB4 because
> > regions of memory are discontiguous and many devices will be unable
> > to
> > address memory beyond the first node.
> > 
> > Instead, implement a new set of DMA operations that allocate TCEs
> > as DMA
> > mappings are requested so that all memory is addressable even when
> > a
> > one-to-one mapping between real addresses and DMA addresses isn't
> > possible.  These TCEs are the maximum size available on the
> > platform,
> > which is 256M on PHB3 and 1G on PHB4.
> > 
> > Devices can now map any region of memory up to the maximum amount
> > they can
> > address according to the DMA mask set, in chunks of the largest
> > available
> > TCE size.
> > 
> > This implementation replaces the need for the existing PHB3
> > solution and
> > should be compatible with future PHB versions.
> > 
> > It is, however, rather naive.  There is no unmapping, and as a
> > result
> > devices can eventually run out of space if they address their
> > entire
> > DMA mask worth of TCEs.  An implementation with unmap() will come
> > in
> > future (and requires a much more complex implementation), but this
> > is a
> > good start due to the drastic performance improvement.
> 
> 
> Why does not dma_iommu_ops work in this case? I keep asking and yet
> no
> comment in the commit log or mails...

Yes, I should cover this in the commit message.

So the primary reason that the IOMMU doesn't work for this case is the
TCE allocation - the IOMMU doesn't have a refcount and will allocate
(in this case on P9) 1GB TCEs to each map which will quickly fail.

This isn't intended to be a replacement for the IOMMU, it's a
roundabout way of achieving what the direct ops do (like NVIDIA devices
on P8 can do today).
