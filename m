Return-Path: <konrad.wilk@oracle.com>
Received: from acsinet14.oracle.com (acsinet14.oracle.com [141.146.126.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "acsinet14.oracle.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C77BB7CE6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 07:20:33 +1100 (EST)
Received: from acsinet11.oracle.com (acsinet11.oracle.com [141.146.126.233])
	by acsinet14.oracle.com (Sentrion-MP-4.0.0/Sentrion-MP-4.0.0) with
	ESMTP id o2JKKTCv022702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Mar 2010 20:20:29 GMT
Date: Fri, 19 Mar 2010 15:50:13 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [PATCH v5 08/10] wii: add mem2 dma mapping ops
Message-ID: <20100319195013.GC31908@phenom.dumpdata.com>
References: <1269023546-25534-1-git-send-email-albert_herranz@yahoo.es>
	<1269023546-25534-9-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269023546-25534-9-git-send-email-albert_herranz@yahoo.es>
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +int wii_set_mem2_dma_constraints(struct device *dev)
> +{
> +	struct dev_archdata *sd;
> +
> +	sd = &dev->archdata;
> +	sd->max_direct_dma_addr = 0;
> +	sd->min_direct_dma_addr = wii_hole_start + wii_hole_size;
> +
> +	set_dma_ops(dev, &wii_mem2_dma_ops);
> +	return 0;
> +}
> +EXPORT_SYMBOL(wii_set_mem2_dma_constraints);

Can you make them EXPORT_SYMBOL_GPL?
> +
> +/**
> + * wii_clear_mem2_dma_constraints() - clears device MEM2 DMA constraints
> + * @dev:	device for which DMA constraints are cleared
> + *
> + * Instructs device @dev to stop using MEM2 DMA buffers for DMA transfers.
> + * Must be called to undo wii_set_mem2_dma_constraints().
> + */
> +void wii_clear_mem2_dma_constraints(struct device *dev)
> +{
> +	struct dev_archdata *sd;
> +
> +	sd = &dev->archdata;
> +	sd->max_direct_dma_addr = 0;
> +	sd->min_direct_dma_addr = 0;
> +
> +	set_dma_ops(dev, &dma_direct_ops);
> +}
> +EXPORT_SYMBOL(wii_clear_mem2_dma_constraints);

Ditto..
> +
> +/*
> + * swiotlb-based DMA ops for MEM2-only devices on the Wii.
> + *
> + */
> +
> +/*
> + * Allocate the SWIOTLB from MEM2.
> + */
> +void * __init swiotlb_alloc_boot(size_t size, unsigned long nslabs)
> +{
> +	return __alloc_bootmem_low(size, PAGE_SIZE,
> +				   wii_hole_start + wii_hole_size);
> +}
> +
> +/*
> + * Bounce: copy the swiotlb buffer back to the original dma location
> + * This is a platform specific version replacing the generic __weak version.
> + */
> +void swiotlb_bounce(phys_addr_t phys, char *dma_buf, size_t size,
> +		    enum dma_data_direction dir)
> +{
> +	void *vaddr = phys_to_virt(phys);
> +
> +	if (dir == DMA_TO_DEVICE) {
> +		memcpy(dma_buf, vaddr, size);
> +		__dma_sync(dma_buf, size, dir);
> +	} else {
> +		__dma_sync(dma_buf, size, dir);
> +		memcpy(vaddr, dma_buf, size);
> +	}
> +}
> +
> +static dma_addr_t
> +mem2_virt_to_bus(struct device *dev, void *address)
> +{
> +	return phys_to_dma(dev, virt_to_phys(address));
> +}
> +
> +static int
> +mem2_dma_mapping_error(struct device *dev, dma_addr_t dma_handle)
> +{
> +	return dma_handle == mem2_virt_to_bus(dev, swiotlb_bk_overflow_buffer);
> +}
> +
> +static int
> +mem2_dma_supported(struct device *dev, u64 mask)
> +{
> +	return mem2_virt_to_bus(dev, swiotlb_bk_end - 1) <= mask;
> +}
> +
> +/*
> + * Determines if a given DMA region specified by @dma_handle
> + * requires bouncing.
> + *
> + * Bouncing is required if the DMA region falls within MEM1.
> + */
> +static int mem2_needs_dmabounce(dma_addr_t dma_handle)
> +{
> +	return dma_handle < wii_hole_start;
> +}
> +
> +/*
> + * Use the dma_direct_ops hooks for allocating and freeing coherent memory
> + * from the MEM2 DMA region.
> + */
> +
> +static void *mem2_alloc_coherent(struct device *dev, size_t size,
> +				 dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +	void *vaddr;
> +
> +	vaddr = dma_direct_ops.alloc_coherent(wii_mem2_dma_dev(), size,
> +					      dma_handle, gfp);
> +	if (vaddr && mem2_needs_dmabounce(*dma_handle)) {
> +		dma_direct_ops.free_coherent(wii_mem2_dma_dev(), size, vaddr,
> +					     *dma_handle);
> +		dev_err(dev, "failed to allocate MEM2 coherent memory\n");
> +		vaddr = NULL;
> +	}
> +	return vaddr;
> +}
> +
> +static void mem2_free_coherent(struct device *dev, size_t size,
> +			       void *vaddr, dma_addr_t dma_handle)
> +{
> +	dma_direct_ops.free_coherent(wii_mem2_dma_dev(), size, vaddr,
> +				     dma_handle);
> +}
> +
> +/*
> + * Maps (part of) a page so it can be safely accessed by a device.
> + *
> + * Calls the corresponding dma_direct_ops hook if the page region falls
> + * within MEM2.
> + * Otherwise, a bounce buffer allocated from MEM2 coherent memory is used.
> + */
> +static dma_addr_t
> +mem2_map_page(struct device *dev, struct page *page, unsigned long offset,
> +	      size_t size, enum dma_data_direction dir,
> +	      struct dma_attrs *attrs)
> +{
> +	phys_addr_t phys = page_to_phys(page) + offset;
> +	dma_addr_t dma_handle = phys_to_dma(dev, phys);
> +	dma_addr_t swiotlb_start_dma;
> +	void *map;
> +
> +	BUG_ON(dir == DMA_NONE);
> +
> +	if (dma_capable(dev, dma_handle, size) && !swiotlb_force) {
> +		return dma_direct_ops.map_page(dev, page, offset, size,
> +					       dir, attrs);
> +	}
> +
> +	swiotlb_start_dma = mem2_virt_to_bus(dev, swiotlb_bk_start);
> +	map = swiotlb_bk_map_single(dev, phys, swiotlb_start_dma, size, dir);
> +	if (!map) {
> +		swiotlb_full(dev, size, dir, 1);
> +		map = swiotlb_bk_overflow_buffer;
> +	}
> +
> +	dma_handle = mem2_virt_to_bus(dev, map);
> +	BUG_ON(!dma_capable(dev, dma_handle, size));
> +
> +	return dma_handle;
> +}
> +
> +/*
> + * Unmaps (part of) a page previously mapped.
> + *
> + * Calls the corresponding dma_direct_ops hook if the DMA region associated
> + * to the dma handle @dma_handle wasn't bounced.
> + * Otherwise, the associated bounce buffer is de-bounced.
> + */
> +static void
> +mem2_unmap_page(struct device *dev, dma_addr_t dma_handle, size_t size,
> +		enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +	swiotlb_unmap_page(dev, dma_handle, size, dir, attrs);
> +}
> +
> +/*
> + * Unmaps a scatter/gather list by unmapping each entry.
> + */
> +static void
> +mem2_unmap_sg(struct device *dev, struct scatterlist *sgl, int nents,
> +	      enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i)
> +		mem2_unmap_page(dev, sg->dma_address, sg->length, dir, attrs);
> +}
> +
> +/*
> + * Maps a scatter/gather list by mapping each entry.
> + */
> +static int
> +mem2_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
> +	    enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		sg->dma_length = sg->length;
> +		sg->dma_address = mem2_map_page(dev, sg_page(sg), sg->offset,
> +						sg->length, dir, attrs);
> +		if (mem2_dma_mapping_error(dev, sg->dma_address)) {
> +			mem2_unmap_sg(dev, sgl, i, dir, attrs);
> +			nents = 0;
> +			sgl[nents].dma_length = 0;
> +			pr_debug("%s: mem2_map_page error\n", __func__);

Maybe use 'dev_err(dev," mem2..." ?

> +			break;
> +		}
> +	}
> +	return nents;
> +}
> +
> +/*
> + * The sync functions synchronize streaming mode DMA translations
> + * making physical memory consistent before/after a DMA transfer.
> + *
> + * They call the corresponding dma_direct_ops hook if the DMA region
> + * associated to the dma handle @dma_handle wasn't bounced.
> + * Otherwise, original DMA buffers and their matching bounce buffers are put
> + * in sync.
> + */
> +
> +static int
> +mem2_sync_range(struct device *dev, dma_addr_t dma_handle,
> +		unsigned long offset, size_t size, int dir, int target)
> +{
> +	phys_addr_t paddr = dma_to_phys(dev, dma_handle) + offset;
> +	void *vaddr = phys_to_virt(paddr);
> +
> +	BUG_ON(dir == DMA_NONE);
> +
> +	if (is_swiotlb_buffer(paddr)) {
> +		swiotlb_bk_sync_single(dev, vaddr, size, dir, target);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static void
> +mem2_sync_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
> +			unsigned long offset, size_t size,
> +			enum dma_data_direction dir)
> +{
> +	int done = mem2_sync_range(dev, dma_handle, offset, size, dir,
> +				   SYNC_FOR_CPU);
> +	if (!done) {
> +		dma_direct_ops.sync_single_range_for_cpu(dev, dma_handle,
> +							 offset, size, dir);
> +	}
> +}
> +
> +static void
> +mem2_sync_range_for_device(struct device *dev, dma_addr_t dma_handle,
> +			   unsigned long offset, size_t size,
> +			   enum dma_data_direction dir)
> +{
> +	int done = mem2_sync_range(dev, dma_handle, offset, size, dir,
> +				   SYNC_FOR_DEVICE);
> +	if (!done) {
> +		dma_direct_ops.sync_single_range_for_device(dev, dma_handle,
> +							    offset, size, dir);
> +	}
> +}
> +
> +static void
> +mem2_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl, int nents,
> +		     enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		mem2_sync_range_for_cpu(dev, sg_dma_address(sg), sg->offset,
> +					sg_dma_len(sg), dir);
> +	}
> +}
> +
> +static void
> +mem2_sync_sg_for_device(struct device *dev, struct scatterlist *sgl, int nents,
> +			enum dma_data_direction dir)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i) {
> +		mem2_sync_range_for_device(dev, sg_dma_address(sg), sg->offset,
> +					   sg_dma_len(sg), dir);
> +	}
> +}
> +
> +/*
> + * Set of DMA operations for devices requiring MEM2 DMA buffers.
> + */
> +struct dma_map_ops wii_mem2_dma_ops = {
> +	.alloc_coherent = mem2_alloc_coherent,
> +	.free_coherent = mem2_free_coherent,
> +	.map_sg = mem2_map_sg,
> +	.unmap_sg = mem2_unmap_sg,
> +	.dma_supported = mem2_dma_supported,
> +	.map_page = mem2_map_page,
> +	.unmap_page = mem2_unmap_page,
> +	.sync_single_range_for_cpu = mem2_sync_range_for_cpu,
> +	.sync_single_range_for_device = mem2_sync_range_for_device,
> +	.sync_sg_for_cpu = mem2_sync_sg_for_cpu,
> +	.sync_sg_for_device = mem2_sync_sg_for_device,
> +	.mapping_error = mem2_dma_mapping_error,
> +};
> -- 
> 1.6.3.3
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/iommu
