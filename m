Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfLdY2X5XzDsgf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 23:51:45 +1000 (AEST)
In-Reply-To: <1472734602-14330-1-git-send-email-mauricfo@linux.vnet.ibm.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: jthumshirn@suse.com, duwe@suse.com
Subject: Re: powerpc: add kernel parameter iommu_alloc_quiet
Message-Id: <3sfLdY1WwLz9syB@ozlabs.org>
Date: Wed, 21 Sep 2016 23:51:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-09 at 12:56:42 UTC, Mauricio Faria de Oliveira wrote:
> This patch introduces the 'iommu_alloc_quiet=driver_name' parameter
> to suppress the 'iommu_alloc failures' messages for that one driver.
> 
> This is an additional approach for this 'problem' of flooding logs,
> not as fine-grained and not enabled by default as DMA_ATTR_NO_WARN,
> but it has the advantage that it doesn't introduce any ABI changes.
> 
> That is important/requirement for the distribution kernels - where
> the DMA_ATTR_NO_WARN changes to 'enum dma_attr' are not acceptable
> because it breaks the kernel ABI.

Adding an entry to an enum does not break the ABI.

In fact AFAIK the enum doesn't exist in the ABI, at the binary level an enum
just becomes an int (possibly excluding debug info).

Removing an entry from an enum would break the API (Note _P_). But I don't see
how adding one does.

Also kernel command line parameters are really poor in terms of usability. Folks
really don't want to have to change their kernel command line.

If we really need a hack for distros then I'd suggest we add a global struct
driver * in the powerpc iommu code, and then when nvme loads it sets that to
point at itself, and then the check becomes:

  		if (dma_handle == DMA_ERROR_CODE) {
 			if (dev->driver == ppc_no_iommu_warn_driver && printk_ratelimit()) {
  				dev_info(dev, "iommu_alloc failed, tbl %p vaddr %p npages %d\n", tbl, vaddr, npages);

cheers
