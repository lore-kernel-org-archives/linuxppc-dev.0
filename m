Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3E041A074F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 09:52:28 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 16:52:26 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 56D631FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 16:40:34 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9FMpKAv59179134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 15:51:20 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9FMqKRd028424
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 16:52:22 -0600
Date: Thu, 15 Oct 2015 15:52:19 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/5 v2] dma-mapping: add generic dma_get_page_shift API
Message-ID: <20151015225219.GD30179@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <20151002201142.GC40695@linux.vnet.ibm.com>
 <20151006095136.GB14144@infradead.org>
 <20151012210651.GB26702@linux.vnet.ibm.com>
 <20151014153900.GC30179@linux.vnet.ibm.com>
 <20151014154251.GA7271@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151014154251.GA7271@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.10.2015 [08:42:51 -0700], Christoph Hellwig wrote:
> Hi Nishanth,
> 
> sorry for the late reply.
> 
> > > On Power, since it's technically variable, we'd need a function. So are
> > > you suggesting define'ing it to a function just on Power and leaving it
> > > a constant elsewhere?
> > > 
> > > I noticed that sparc has a IOMMU_PAGE_SHIFT already, fwiw.
> > 
> > Sorry, I should have been more specific -- I'm ready to spin out a v3,
> > with a sparc-specific function.
> > 
> > Are you ok with leaving it a function for now (the only caller is in
> > NVMe obviously).
> 
> 
> I guess we do indeed need a function then.  I'll take a look at your
> patch, but as long you found a way to avoid adding too much boilerplate
> code it should be fine.

Ok, so I've got the moved function (include/linux/dma-mapping.h instead
of dma-mapping-common.h) ready to go, which should only involve changing
the first patch in the series. But I'm really mystified by what to do
for sparc, which defines IOMMU_PAGE_SHIFT and IO_PAGE_SHIFT in
arch/sparc/kernel/iommu_common.h.

1) Which constant reflects the value we mean for this function on sparc?
I assume it should be IOMMU_PAGE_SHIFT, but they are the same value and
I want to make sure I get the semantics right.

2) Where would I put sparc's definition of dma_get_page_shift()? Should
it be in a asm/dma-mapping.h? Should we move some of the constants from
arch/sparc/kernel/iommu_common.h to
arch/sparc/include/asm/iommu_common.h and then #include that in
asm/dma-mapping.h?

Dave M., any opinions/insights? Essentially, this helper function
assists the NVMe driver in determining what page size it should use to
satisfy both the device and IOMMU's requirements. Maybe I misunderstand
the constants on sparc and PAGE_SHIFT is fine there too?

-Nish
