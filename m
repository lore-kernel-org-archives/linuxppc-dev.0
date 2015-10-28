Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9292B1A01CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 12:55:01 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 21:54:59 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6BFC538C803B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 21:54:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9S1su1c54657228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 01:54:56 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9S1srmo022836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 21:54:55 -0400
Date: Tue, 27 Oct 2015 18:54:51 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-ID: <20151028015451.GH7716@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com>
 <562F1368.1030204@ozlabs.ru>
 <20151027222706.GF7716@linux.vnet.ibm.com>
 <56301E24.1060304@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56301E24.1060304@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.10.2015 [12:00:20 +1100], Alexey Kardashevskiy wrote:
> On 10/28/2015 09:27 AM, Nishanth Aravamudan wrote:
> >On 27.10.2015 [17:02:16 +1100], Alexey Kardashevskiy wrote:
> >>On 10/24/2015 07:57 AM, Nishanth Aravamudan wrote:
> >>>On Power, the kernel's page size can differ from the IOMMU's page size,
> >>>so we need to override the generic implementation, which always returns
> >>>the kernel's page size. Lookup the IOMMU's page size from struct
> >>>iommu_table, if available. Fallback to the kernel's page size,
> >>>otherwise.
> >>>
> >>>Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> >>>---
> >>>  arch/powerpc/include/asm/dma-mapping.h | 3 +++
> >>>  arch/powerpc/kernel/dma.c              | 9 +++++++++
> >>>  2 files changed, 12 insertions(+)
> >>>
> >>>diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> >>>index 7f522c0..c5638f4 100644
> >>>--- a/arch/powerpc/include/asm/dma-mapping.h
> >>>+++ b/arch/powerpc/include/asm/dma-mapping.h
> >>>@@ -125,6 +125,9 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
> >>>  #define HAVE_ARCH_DMA_SET_MASK 1
> >>>  extern int dma_set_mask(struct device *dev, u64 dma_mask);
> >>>
> >>>+#define HAVE_ARCH_DMA_GET_PAGE_SHIFT 1
> >>>+extern unsigned long dma_get_page_shift(struct device *dev);
> >>>+
> >>>  #include <asm-generic/dma-mapping-common.h>
> >>>
> >>>  extern int __dma_set_mask(struct device *dev, u64 dma_mask);
> >>>diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> >>>index 59503ed..e805af2 100644
> >>>--- a/arch/powerpc/kernel/dma.c
> >>>+++ b/arch/powerpc/kernel/dma.c
> >>>@@ -335,6 +335,15 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
> >>>  }
> >>>  EXPORT_SYMBOL(dma_set_mask);
> >>>
> >>>+unsigned long dma_get_page_shift(struct device *dev)
> >>>+{
> >>>+	struct iommu_table *tbl = get_iommu_table_base(dev);
> >>>+	if (tbl)
> >>>+		return tbl->it_page_shift;
> >>
> >>
> >>All PCI devices have this initialized on POWER (at least, our, IBM's
> >>POWER) so 4K will always be returned here while in the case of
> >>(get_dma_ops(dev)==&dma_direct_ops) it could actually return
> >>PAGE_SHIFT. Is 4K still preferred value to return here?
> >
> >Right, so the logic of my series, goes like this:
> >
> >a) We currently are assuming DMA_PAGE_SHIFT (conceptual constant) is
> >PAGE_SHIFT everywhere, including Power.
> >
> >b) After 2/7, the Power code will return either the IOMMU table's shift
> >value, if set, or PAGE_SHIFT (I guess this would be the case if
> >get_dma_ops(dev) == &dma_direct_ops, as you said). That is no different
> >than we have now, except we can return the accurate IOMMU value if
> >available.
> 
> If it is not available, then something went wrong and BUG_ON(!tbl ||
> !tbl->it_page_shift) make more sense here than pretending that this
> function can ever return PAGE_SHIFT. imho.

That's a good point, thanks!

> >3) After 3/7, the platform can override the generic Power
> >get_dma_page_shift().
> >
> >4) After 4/7, pseries will return the DDW value, if available, then
> >fallback to the IOMMU table's value. I think in the case of
> >get_dma_ops(dev)==&dma_direct_ops, the only way that can happen is if we
> >are using DDW, right?
> 
> This is for pseries guests; for the powernv host it is a "bypass"
> mode which does 64bit direct DMA mapping and there is no additional
> window for that (i.e. DIRECT64_PROPNAME, etc).

You're right! I should update the code to handle both cases.

In "bypass" mode, what TCE size is used? Is it guaranteed to be 4K?

Seems like this would be a different platform implentation I'd put in
for 'powernv', is that right?

My apologies for missing that, and thank you for the review!

-Nish
