Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB179C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:52:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1B8233CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1B8233CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DG6m01gsszDqnD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 23:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DG6h60HTyzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 23:48:53 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D787F68AFE; Wed, 13 Jan 2021 13:48:47 +0100 (CET)
Date: Wed, 13 Jan 2021 13:48:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [RFC PATCH v3 4/6] swiotlb: Add restricted DMA alloc/free support.
Message-ID: <20210113124847.GC1383@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-5-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106034124.30560-5-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org, grant.likely@arm.com,
 paulus@samba.org, frowand.list@gmail.com, mingo@kernel.org,
 m.szyprowski@samsung.com, sstabellini@kernel.org, saravanak@google.com,
 joro@8bytes.org, rafael.j.wysocki@intel.com, hch@lst.de,
 bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org, treding@nvidia.com,
 devicetree@vger.kernel.org, will@kernel.org, konrad.wilk@oracle.com,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, jgross@suse.com,
 drinkcat@chromium.org, gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 iommu@lists.linux-foundation.org, xypron.glpk@gmx.de, robin.murphy@arm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> +#ifdef CONFIG_SWIOTLB
> +	if (unlikely(dev->dma_io_tlb_mem))
> +		return swiotlb_alloc(dev, size, dma_handle, attrs);
> +#endif

Another place where the dma_io_tlb_mem is useful to avoid the ifdef.

> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static int swiotlb_tbl_find_free_region(struct device *hwdev,
> +					dma_addr_t tbl_dma_addr,
> +					size_t alloc_size,
> +					unsigned long attrs)

> +static void swiotlb_tbl_release_region(struct device *hwdev, int index,
> +				       size_t size)

This refactoring should be another prep patch.


> +void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		    unsigned long attrs)

I'd rather have the names convey there are for the per-device bounce
buffer in some form.

> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;

While we're at it I wonder if the io_tlb is something we could change
while we're at it.  Maybe replace io_tlb_mem with struct swiotlb
and rename the field in struct device to dev_swiotlb?

> +	int index;
> +	void *vaddr;
> +	phys_addr_t tlb_addr;
> +
> +	size = PAGE_ALIGN(size);
> +	index = swiotlb_tbl_find_free_region(dev, mem->start, size, attrs);
> +	if (index < 0)
> +		return NULL;
> +
> +	tlb_addr = mem->start + (index << IO_TLB_SHIFT);
> +	*dma_handle = phys_to_dma_unencrypted(dev, tlb_addr);
> +
> +	if (!dev_is_dma_coherent(dev)) {
> +		unsigned long pfn = PFN_DOWN(tlb_addr);
> +
> +		/* remove any dirty cache lines on the kernel alias */
> +		arch_dma_prep_coherent(pfn_to_page(pfn), size);

Can we hook in somewhat lower level in the dma-direct code so that all
the remapping in dma-direct can be reused instead of duplicated?  That
also becomes important if we want to use non-remapping uncached support,
e.g. on mips or x86, or the direct changing of the attributes that Will
planned to look into for arm64.
