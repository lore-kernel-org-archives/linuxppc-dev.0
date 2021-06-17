Return-Path: <SRS0=XOTo=LL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF4FC49361
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 23:33:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAD261184
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 23:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAD261184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5ddm350rz3ckK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 09:33:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QWqo3Dqx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sstabellini@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QWqo3Dqx; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5dbf47jVz3bx3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 09:31:10 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D38066128B;
 Thu, 17 Jun 2021 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623972667;
 bh=fWthFoIm/YEa+gCtln1XDDJSXfB5s/xQ0jk7l7+p7+0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=QWqo3DqxQjEKowfqO/s2UKUn1DguQmxVjG6us/vFiMAFxg5HmszETvkadqrhYhjO6
 p3G1uYRBl3sgiMDwarsK7QN9GUKmY1ppQedxfXy1LWj8nRA+raX38agu6FcFdZE8rE
 u0SnAZ+syPcnB24pk3013wQUUK3otAsHcsjjDaqnsrBDVB5TZNRykVgiRAM8ftohQB
 0zL9uqU+EGZZr7X8V66FRgKnYPrnYunWMJVUC4BfgidwO8ZU2Lg4VckOSqGuRd5+zs
 mHYalEYo2PrV1TSQiwCdtdYcCgfmpjbkd2fkGoESqy5HZncim8JNKQU8S6M5JXt0Mj
 NrYdTfVkjlQUA==
Date: Thu, 17 Jun 2021 16:31:05 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH v13 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
In-Reply-To: <20210617062635.1660944-7-tientzu@chromium.org>
Message-ID: <alpine.DEB.2.21.2106171433560.24906@sstabellini-ThinkPad-T480s>
References: <20210617062635.1660944-1-tientzu@chromium.org>
 <20210617062635.1660944-7-tientzu@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 Joerg Roedel <joro@8bytes.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 jxgao@google.com, daniel@ffwll.ch, Will Deacon <will@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, bhelgaas@google.com, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 tfiga@chromium.org,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 17 Jun 2021, Claire Chang wrote:
> Propagate the swiotlb_force into io_tlb_default_mem->force_bounce and
> use it to determine whether to bounce the data or not. This will be
> useful later to allow for different pools.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/swiotlb-xen.c |  2 +-
>  include/linux/swiotlb.h   | 11 +++++++++++
>  kernel/dma/direct.c       |  2 +-
>  kernel/dma/direct.h       |  2 +-
>  kernel/dma/swiotlb.c      |  4 ++++
>  5 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 0c6ed09f8513..4730a146fa35 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -369,7 +369,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	if (dma_capable(dev, dev_addr, size, true) &&
>  	    !range_straddles_page_boundary(phys, size) &&
>  		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
> -		swiotlb_force != SWIOTLB_FORCE)
> +		!is_swiotlb_force_bounce(dev))
>  		goto done;
>  
>  	/*
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index dd1c30a83058..8d8855c77d9a 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -84,6 +84,7 @@ extern enum swiotlb_force swiotlb_force;
>   *		unmap calls.
>   * @debugfs:	The dentry to debugfs.
>   * @late_alloc:	%true if allocated using the page allocator
> + * @force_bounce: %true if swiotlb bouncing is forced
>   */
>  struct io_tlb_mem {
>  	phys_addr_t start;
> @@ -94,6 +95,7 @@ struct io_tlb_mem {
>  	spinlock_t lock;
>  	struct dentry *debugfs;
>  	bool late_alloc;
> +	bool force_bounce;
>  	struct io_tlb_slot {
>  		phys_addr_t orig_addr;
>  		size_t alloc_size;
> @@ -109,6 +111,11 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  	return mem && paddr >= mem->start && paddr < mem->end;
>  }
>  
> +static inline bool is_swiotlb_force_bounce(struct device *dev)
> +{
> +	return dev->dma_io_tlb_mem->force_bounce;
> +}
> +
>  void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
> @@ -120,6 +127,10 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
>  	return false;
>  }
> +static inline bool is_swiotlb_force_bounce(struct device *dev)
> +{
> +	return false;
> +}
>  static inline void swiotlb_exit(void)
>  {
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 7a88c34d0867..a92465b4eb12 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -496,7 +496,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
>  {
>  	/* If SWIOTLB is active, use its maximum mapping size */
>  	if (is_swiotlb_active(dev) &&
> -	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
> +	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev)))
>  		return swiotlb_max_mapping_size(dev);
>  	return SIZE_MAX;
>  }
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 13e9e7158d94..4632b0f4f72e 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -87,7 +87,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
>  	phys_addr_t phys = page_to_phys(page) + offset;
>  	dma_addr_t dma_addr = phys_to_dma(dev, phys);
>  
> -	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> +	if (is_swiotlb_force_bounce(dev))
>  		return swiotlb_map(dev, phys, size, dir, attrs);
>  
>  	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 409694d7a8ad..13891d5de8c9 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -179,6 +179,10 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>  	mem->end = mem->start + bytes;
>  	mem->index = 0;
>  	mem->late_alloc = late_alloc;
> +
> +	if (swiotlb_force == SWIOTLB_FORCE)
> +		mem->force_bounce = true;
> +
>  	spin_lock_init(&mem->lock);
>  	for (i = 0; i < mem->nslabs; i++) {
>  		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 
