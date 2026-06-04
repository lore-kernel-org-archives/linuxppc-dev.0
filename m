Return-Path: <linuxppc-dev+bounces-22003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8869CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWJ1R3w0Wz2ytv;
	Thu, 04 Jun 2026 18:40:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780562443;
	cv=none; b=g4DxrF7OkUkOsi2su2ZQFTvxQ1Z49P/tmWT9PfL2oXwmRiWLqYAH7XVq1gsSimSRUqLVkjzX9T9U+xM4IlJhq5+3oLa6F5gD+P06xjyGbtnu7ndopJhhfQX7AH3LhWrTmKDzRMsPDFZUFnefFSu9aGNRVR1J7xP3ZHsfJIAyfi1OiRoHY+BJc8q8JFbkd2T31RgJqbVuimI3Rmuklo1hJffmSsc7c8CiK6dU+K7524utEtZRZ5CgxOrIqiwnvRlzxKCgqtCxyvPaXIVYz0J81XDaoneoi+QemFxC0BNFFTJbhFlMZ1dSoJZ4yfK3AD5RnsZDRsjC+0HIFv0OV2/6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780562443; c=relaxed/relaxed;
	bh=+B5f91SDYjAMs4Y9geXO5xScntRrhAje95uzpPpXQjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZebn/Q3KwA/+tWpKa2Sz1M09IgVlwqszfV8ZTt3rzqt+aCOuhseydnUyqIjdK5vW1ts5rCj9lEfa5L6tJIw3cR90FXCCX2L8MK9gBWqtgZr/Z1twL3LaB1klfBTSgOE9qOvVLQJu3KvOMPFd0vh8811pt+yCG98281zUFuLrnJ5H6CzdwhpwTR2bLZq1NQJ/nAQqx4woHkxMXxgECvkubyJL4H0RokL6eVHxrXaeyiA0EZrQYix1TQ7l81TWUe53okgzXsq9NALaWp5s9JmUi8CP09tNkuSIMs3vkvH//EMRRi2JlZ5VmBl6bfWGKC+1Gac+SwVp8NMsUhbKLXbcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzQj+Xv1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzQj+Xv1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWJ1Q64Svz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 18:40:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E6F9432E8;
	Thu,  4 Jun 2026 08:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8164C1F00898;
	Thu,  4 Jun 2026 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562441;
	bh=+B5f91SDYjAMs4Y9geXO5xScntRrhAje95uzpPpXQjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzQj+Xv1YAFhivBTK7CKWkM+0NQuzr0RN2f9LB9ULjUJFlIfftky7+KoKyQ6ybxAb
	 kZq+RqQ2asniAHfXZsuPLq5Cl8ip0oTmOAqQn9C7X+nvS1coYG67x7Cpm3bSVL+bL5
	 vrepqvziucoNCPihmTW6n77YoFQWBwZ2w0MV4E2d9QIzNbohyIR9tfS9i0iaosR/eU
	 Ipx7IIKwdgW1G7X8FTC8/8X8E5CF3blsI7qoIrOeeLUmOcsQfBnyhE14/6nLKxglOR
	 QcTn9ne7mZ3pscR/8jBpwRPIxIH/OO/KhbSOctArSt0uYE7p88CBCpdkjgJ+ciwNBz
	 2iqe8OEs0HMTQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
Date: Thu,  4 Jun 2026 14:09:42 +0530
Message-ID: <20260604083959.1265923-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
dma-direct allocation path and use the attribute to drive the related
decisions.

This updates dma_direct_alloc(), dma_direct_free(), and
dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 53 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a741c8a2ee66..90dc5057a0c0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = true;
+	bool mark_mem_decrypt = false;
 	struct page *page;
 	void *ret;
 
+	/*
+	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
+	 * attribute. The direct allocator uses it internally after it has
+	 * decided that the backing pages must be shared/decrypted, so the
+	 * rest of the allocation path can consistently select DMA addresses,
+	 * choose compatible pools and restore encryption on free.
+	 */
+	if (attrs & DMA_ATTR_CC_SHARED)
+		return NULL;
+
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_decrypt = true;
+	}
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -236,7 +251,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -312,12 +327,24 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	phys_addr_t phys;
-	bool mark_mem_encrypted = true;
+	bool mark_mem_encrypted = false;
 	struct io_tlb_pool *swiotlb_pool;
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	/* see dma_direct_alloc() for details */
+	WARN_ON(attrs & DMA_ATTR_CC_SHARED);
+
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	if (force_dma_unencrypted(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+		mark_mem_encrypted = true;
+	}
+
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -366,10 +393,14 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	unsigned long attrs = 0;
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	if (is_swiotlb_for_alloc(dev)) {
@@ -403,7 +434,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	phys_addr_t phys;
 	void *vaddr = page_address(page);
 	struct io_tlb_pool *swiotlb_pool;
-	bool mark_mem_encrypted = true;
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	bool mark_mem_encrypted = force_dma_unencrypted(dev);
 
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-- 
2.43.0


