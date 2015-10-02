Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF01A1A0319
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 07:04:43 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 15:04:41 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E8E2D19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 14:52:50 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92L4csP3735938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 14:04:38 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92L4at5016140
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 15:04:38 -0600
Date: Fri, 2 Oct 2015 14:04:35 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5 v2] Fix NVMe driver support on Power with 32-bit DMA
Message-ID: <20151002210435.GM8040@linux.vnet.ibm.com>
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

On 03.10.2015 [06:51:06 +1000], Benjamin Herrenschmidt wrote:
> On Fri, 2015-10-02 at 13:09 -0700, Nishanth Aravamudan wrote:
> 
> > 1) add a generic dma_get_page_shift implementation that just returns
> > PAGE_SHIFT
> 
> So you chose to return the granularity of the iommu to the driver
> rather than providing a way for the driver to request a specific
> alignment for DMA mappings. Any specific reason ?

Right, I did start with your advice and tried that approach, but it
turned out I was wrong about the actual issue at the time. The problem
for NVMe isn't actually the starting address alignment (which it can
handle not being aligned to the device's page size). It doesn't handle
(addr + len % dev_page_size != 0). That is, it's really a length
alignment issue.

It seems incredibly device specific to have a an API into the DMA code
to request an end alignment -- no other device seems to have this
issue/design. If you think that's better, I can fiddle with that
instead.

Sorry, I should have called this out better as an alternative
consideration.

-Nish
