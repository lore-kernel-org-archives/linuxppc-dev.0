Return-Path: <keith.busch@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 17D751A048B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 01:09:19 +1100 (AEDT)
Date: Tue, 27 Oct 2015 14:06:47 +0000
From: "Busch, Keith" <keith.busch@intel.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Matthew Wilcox <willy@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/7 v2] powerpc/dma-mapping: override dma_get_page_shift
Message-ID: <20151027140647.GA15583@localhost.localdomain>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205718.GC10197@linux.vnet.ibm.com>
 <562F1368.1030204@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <562F1368.1030204@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2015 at 05:02:16PM +1100, Alexey Kardashevskiy wrote:
> >+unsigned long dma_get_page_shift(struct device *dev)
> >+{
> >+	struct iommu_table *tbl = get_iommu_table_base(dev);
> >+	if (tbl)
> >+		return tbl->it_page_shift;
> 
> 
> All PCI devices have this initialized on POWER (at least, our, IBM's
> POWER) so 4K will always be returned here while in the case of
> (get_dma_ops(dev)==&dma_direct_ops) it could actually return
> PAGE_SHIFT. Is 4K still preferred value to return here?

4k is always a safe option to return, but ideally you want to return the
highest guaranteed DMA address alignment. The driver just needs to know
which bits to mask from virtual addresses such that the offset is the
same as the DMA address.
