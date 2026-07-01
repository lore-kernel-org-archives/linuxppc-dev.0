Return-Path: <linuxppc-dev+bounces-23257-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88762C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:51:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqpzr0h0Bz2ykX;
	Wed, 01 Jul 2026 15:51:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885096;
	cv=none; b=W8QyOkan5W/oIQBnZtDorJOi/WPjmx0TYzYE+NW3ZBIZfaAHC0jeX0minN3wh9xG2r4xLjfMuM3u+9GVHZO45R3iLOEAUNoIdh83BSovPZ+v6Q1E1V9os0LSPdShdFvbxsjGm5SkZebzeTXDbosWWRKZ4M3C3He3oPKbhv5ynOoMm+6tGr9UCfDdi9tjdJ1UPyFyavptyE044kP24nvWO0xpzHJp/RB3GMSh1Uv91fTWQAoQOdZQDjjvDHRYnj2/QU+xyiaEKPdDp7l4XaXIRQfMQWASP6SGXSV3TfXg+XKl7lsoZcY4GUXABUsUYdcPDJy/ayUX42mJZFeV2Yqv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885096; c=relaxed/relaxed;
	bh=HkzqvFMXi/PgU+6F3kPwXboJDV9YU/zrJk+hhy58TBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wmv6GbbxV5c84IUbZaB42acNPRP761AKzjMSeFScgcOmjbRZRcR+XuAbADcx0ADGF7c+xmvzA7vjACgtLFxQgMxpl4jej9uTerfjiV+htUtNWXhVKVV6p3CAVke6u6Ea7uZP5xRPulJwjdeZdJ5G1GAwJpttjdxn7EvAVUoYCgwTDq96whmf/pxuvc6AvjLlqKP7hsz+fn1rk/UwbT0FIDn7xsMh6VT6DKTS3MoqdmbX5fng9hlp4E2X4TFA1IY0wLk7/GpefNOWzedjddvTMbr96dA+uNA68hPsGNhc51M0X7b7a/Pf2BIISbzSjY6BW+xD03ARqFp/qGl6Ueagvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9eddkM1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9eddkM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqpzq2mtzz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:51:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D9ABF43471;
	Wed,  1 Jul 2026 05:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F781F00A3A;
	Wed,  1 Jul 2026 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885093;
	bh=HkzqvFMXi/PgU+6F3kPwXboJDV9YU/zrJk+hhy58TBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9eddkM1K/T7RTCiQTgtIU6lixFvLYa9EeEaz+wMOZQ+xlTWidBriJTTjKfVC/I5F
	 DbEPOBhOq7rwUYznEf4REm9gXDeEp1M3sYIra0nuSE3fkyI6Su34Q67tLIRZacdrE8
	 EQ67aDfoPb3WmKbV8nNeJ4/20Zc1nX5lkSsP/2WmRmc1YI1xa0CTlyTefzlOAy/YGj
	 Vd4sOpYAA/vjSVMCGCJNxPejK40j4RHBqNtyUxe8TUuSo7feSUehna+CJJvcFNrkLv
	 kITtam5OAcs3m+jsILWL7XYWWvyqi0qndiFfiNXk+Mh6+l8mlKpTRdn0hEFQ8T4/ST
	 /puqkd/i1b9OA==
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
Subject: [PATCH v7 10/22] dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in alloc/free paths
Date: Wed,  1 Jul 2026 11:19:14 +0530
Message-ID: <20260701054926.825925-11-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
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

Propagate force_dma_unencrypted() into __DMA_ATTR_ALLOC_CC_SHARED in the
dma-direct allocation path and use the attribute to drive the related
decisions.

This updates dma_direct_alloc(), dma_direct_free(), and
dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  | 42 +++++++++++++++++++++++++++++++++---------
 kernel/dma/mapping.c |  9 +++++++++
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0cbf2b0835c4..98e47e0b332d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -192,16 +192,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
-	bool mark_mem_decrypt = true;
+	bool mark_mem_decrypt = false;
 	struct page *page;
 	void *ret;
 
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
+	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
+		mark_mem_decrypt = true;
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -235,7 +241,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || (attrs & __DMA_ATTR_ALLOC_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp)) {
 		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
 						  &ret, gfp);
@@ -314,12 +320,22 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	phys_addr_t phys;
-	bool mark_mem_encrypted = true;
+	bool mark_mem_encrypted = false;
 	struct io_tlb_pool *swiotlb_pool;
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	/*
+	 * If the allocation used decrypted/shared backing pages, restore
+	 * the encryption state on free.
+	 */
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
+	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
+		mark_mem_encrypted = true;
+
+	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) ==
+	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -368,10 +384,14 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	unsigned long attrs = 0;
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
+	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
 
 	if (is_swiotlb_for_alloc(dev)) {
@@ -405,7 +425,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	phys_addr_t phys;
 	void *vaddr = page_address(page);
 	struct io_tlb_pool *swiotlb_pool;
-	bool mark_mem_encrypted = true;
+	/*
+	 * if the device had requested for an unencrypted buffer,
+	 * convert it to encrypted on free
+	 */
+	bool mark_mem_encrypted = force_dma_unencrypted(dev);
 
 	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 4fe04669e5e6..d2f70b6ccd0f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -638,6 +638,15 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	if (WARN_ON_ONCE(flag & __GFP_COMP))
 		return NULL;
 
+	if (attrs & (DMA_ATTR_CC_SHARED | __DMA_ATTR_ALLOC_CC_SHARED)) {
+		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
+				attrs);
+		return NULL;
+	}
+
+	if (force_dma_unencrypted(dev))
+		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
+
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
 		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
 				DMA_BIDIRECTIONAL, flag, attrs);
-- 
2.43.0


