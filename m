Return-Path: <linuxppc-dev+bounces-23265-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BB0C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:53:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqq1Y5LFCz2yqx;
	Wed, 01 Jul 2026 15:53:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885185;
	cv=none; b=ZWXnoJsYGF6ef8aoKDE9GVwz/QJx05pVRY5u1ITxyHV7iMCCfH4Tzu8Sxt16OPeNClMUeFkaTrGLA/bRy1KuBiN4zNysw5hKXzqyHHR4eky+A41Mk+AN3Cvlw5XGzeCH4h5yvUOBh+oeuHHNu+eChIQZYkCJWxlDsg5hnoNng0epVj7wwaVD2yfZS2W2dlr7huovkq7/v+kot/ZO4zoRx3bW692e5yjmku1pCYMPKoS3Tvghd2/rsoSBwqZ6o8P35VVJdhQkZdI6+eFY+avq9V4vF84ipRe+vjdbt6Y8pY8YEOWZqMlyapy9eo7OvFyvQk9h11Poq4A7fq0szRvX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885185; c=relaxed/relaxed;
	bh=xGRP07sIXhOW44W0Ke99D2HU+/3eVzVVhpBppwd6XuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU5Am6u1r21teA9zxER1OHs3zoH3yJskxpuYZqHM8v7wj9YIMAHv5FXjLHIFAnrFJKVYZyvseY+4RTRHwsBmaAouVm0EvUF8BecGjkBD6UWD39Hw5kZY4gUxkczmWZpLnynqwuvzNhu/yVZzetmEyg4ydqeFHOdNpbz4/kA/qNCzju0YmhaVlaEC9mYKQjlodwqNk5tFabTr4BxKDQvoGoarNREh+JYShpaaOoYiZgYhV/DWZ/HAZvpeNT1INXWqRq2TdymO8xU8Y7zwcCTrNJKbCAQo6W/0GeJdpoYyb15jtyLiuJKrNJ808NjW+n/RjrK01vIIJQYZHT1Y385W5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYXAmDET; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KYXAmDET;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqq1X6Zccz30VR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:53:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D9B7601D7;
	Wed,  1 Jul 2026 05:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA131F000E9;
	Wed,  1 Jul 2026 05:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885182;
	bh=xGRP07sIXhOW44W0Ke99D2HU+/3eVzVVhpBppwd6XuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYXAmDETQoVnPCedruRosGhHHuYgs8Ksa+15kuSAy9mlvG+SewOgGs8QqTR7oH9VE
	 8yfWyOl+XaW7dVBghqoeUWxGOM1LmS4I33tZM3LC9YoDRAYGuG7YmDQaAFXM8Mr7N3
	 d320gNJpf4Oxrsp4TCIZ7qZe6ptDHvB3Xvf/8uErjhj9No0KXlF9MOCS1xBLO22mWr
	 f2Gmj4t+D3fmjYusGweBMYw2yUbn2NPud7Jhy1Ae6kGkshpn6ymFSXUk34Es4/aU4E
	 g5YFwO+fPqmfhToeqJtsUtse4pzJt3tV2WGFtPjXimKWQFmDPCShZbfbFqSkVOWm19
	 aVkmW1/9K1Z3g==
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
Subject: [PATCH v7 18/22] dma-direct: select DMA address encoding from __DMA_ATTR_ALLOC_CC_SHARED
Date: Wed,  1 Jul 2026 11:19:22 +0530
Message-ID: <20260701054926.825925-19-aneesh.kumar@kernel.org>
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

Make the dma-direct helpers derive the DMA address encoding from
__DMA_ATTR_ALLOC_CC_SHARED instead of implicitly relying on
force_dma_unencrypted() inside phys_to_dma_direct()

Pass an explicit unencrypted/decrypted state into phys_to_dma_direct(),
make the alloc paths return DMA addresses that match the requested buffer
encryption state. Also only call dma_set_decrypted() when
__DMA_ATTR_ALLOC_CC_SHARED is actually set.

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 964e8b0d8709..23138519cf22 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -24,11 +24,11 @@
 u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
-		phys_addr_t phys)
+		phys_addr_t phys, bool unencrypted)
 {
-	if (force_dma_unencrypted(dev))
+	if (unencrypted)
 		return phys_to_dma_unencrypted(dev, phys);
-	return phys_to_dma(dev, phys);
+	return phys_to_dma_encrypted(dev, phys);
 }
 
 static inline struct page *dma_direct_to_page(struct device *dev,
@@ -39,8 +39,9 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
+	bool require_decrypted = force_dma_unencrypted(dev);
 	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
-	u64 max_dma = phys_to_dma_direct(dev, phys);
+	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -69,7 +70,8 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+	bool require_decrypted = force_dma_unencrypted(dev);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -79,17 +81,18 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
-		return 0;
-	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
+	int ret;
+
+	ret = set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
+	if (ret)
+		pr_warn_ratelimited("leaking DMA memory that can't be decrypted\n");
+	return ret;
 }
 
 static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
 		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
@@ -169,7 +172,8 @@ static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 				   dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));
 	return page;
 }
 
@@ -185,9 +189,11 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 	/* remove any dirty cache lines on the kernel alias */
 	if (!PageHighMem(page))
 		arch_dma_prep_coherent(page, size);
-
-	/* return the page pointer as the opaque cookie */
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	/*
+	 * return the page pointer as the opaque cookie.
+	 * Never used for unencrypted allocation
+	 */
+	*dma_handle = phys_to_dma_encrypted(dev, page_to_phys(page));
 	return page;
 }
 
@@ -324,7 +330,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = uncached_cpu_addr;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));
 	return ret;
 
 
@@ -445,11 +452,13 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 
 	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
+	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) &&
+	    dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 setup_page:
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 !!(attrs & __DMA_ATTR_ALLOC_CC_SHARED));
 	return page;
 out_leak_pages:
 	return NULL;
-- 
2.43.0


