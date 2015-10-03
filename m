Return-Path: <BATV+4d33cd06d343d4174115+4423+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AB1E1A00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 18:20:11 +1000 (AEST)
Date: Sat, 3 Oct 2015 01:19:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151003081952.GC24025@infradead.org>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002200953.GB40695@linux.vnet.ibm.com>
 <1443819066.27295.19.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443819066.27295.19.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 03, 2015 at 06:51:06AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2015-10-02 at 13:09 -0700, Nishanth Aravamudan wrote:
> 
> > 1) add a generic dma_get_page_shift implementation that just returns
> > PAGE_SHIFT
> 
> So you chose to return the granularity of the iommu to the driver
> rather than providing a way for the driver to request a specific
> alignment for DMA mappings. Any specific reason ?

At least for NVMe that's the way to go - it allows to set a page set in
the device which should fit the IOMMU page size.
