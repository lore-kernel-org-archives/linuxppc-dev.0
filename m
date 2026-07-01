Return-Path: <linuxppc-dev+bounces-23248-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC48EC43327
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:49:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqpxy4rsdz2yQL;
	Wed, 01 Jul 2026 15:49:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782884998;
	cv=none; b=YP3goBJjpSdcosDEl94cez+xuXIh3M6NdO6GjWTBj0SccRmx+VwCeT/jqVSvI1dmsfNQQMcilnwOKIVsXvUqpIa69NRpoe09/LywpjXxu3cxWGNbP8lAGkRypUMWdGOrPtcFI0/9HIOZ4xRNq/AT7cAisqS/H7dwJvmiiK2q9numFfAjWykBWxB7VMTTciK6xYoRLh2dub1Ks8C2mH4YMmpbHUM2Nq+fG7mRQIrCeyavDLmH/NdR2l0Jz/5rQpcv4ELh3ZazxZIkaM4Kmn7Yv6CTgY+1mnl5JeE6QxYObUZ8QuuqgUxAbKWgVJJ/Oxrtk2f/4vdbomr7Z/2i064XDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782884998; c=relaxed/relaxed;
	bh=DDn6/hMBFkxaIDTWG6ELJ9BHD0gGmn2ym9lHK0DAGBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuLYKEn6ceQykr6J8vJvssbKQf4P848/Gb5Y1mepykQfOVZJOIAZcLMZ1J/3zuFexVAl3JMRoXEMVFmhKul7mED1N3tvSRMnQdUEDul65MfzbqofTnKXXo47VvmJSO4YPhP7Bv0lFNIwEEPcECdZcHB+6q3xqLxzT689e+Qqjht5xLNB7K9UVJf9Yup3n8iQCTgRd611i2D2nPkx8HKWbMMx2+NcQXKW51xGmuyWGq0FpYZ9E1t3dLTYEfzE6F2lNXEloAEiInNTiervZcqXy4vcaMn6C0uidEvCDsX2X5liuDl1/r+8eVh2dD3RNpJqXRgQg3wRYlnf4XxSlMGTjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/T2z7jo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/T2z7jo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqpxx6GGWz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:49:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0391E601D6;
	Wed,  1 Jul 2026 05:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F256F1F00A3A;
	Wed,  1 Jul 2026 05:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782884995;
	bh=DDn6/hMBFkxaIDTWG6ELJ9BHD0gGmn2ym9lHK0DAGBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/T2z7joqV/7Szo7Y6FCLPBWjs4VapdKJ+KPy/Ku43SEyDt4VnitmsW8lRvqODvMl
	 B0MXcLm7ZWWk+2LPK6OpNw6Q3+mzvXlr5NETR2VA7Gjs+2DJiTpQrj+udsy0x4T/t3
	 NuEG5V7zS0WlM5ziBr/L1q6WOCgsfDVWjMV+wvpm6IhKD8ASPll7G5wWwPa6+QOFTa
	 9SDXWxR4Ct5CXZGM6/pAVwaHSfPCH8mfKhi5ou1lS81pkpBHUIELi3XbHNcuQt4hIb
	 xRflhDKe0XIazwi3h04clh9VY69qxQ6HLLzpzsu1MTx9gdx8EY4pYu0u5clacZPU/9
	 g1lf1PeOrzCJA==
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
	stable@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 01/22] dma-direct: return struct page from dma_direct_alloc_from_pool()
Date: Wed,  1 Jul 2026 11:19:05 +0530
Message-ID: <20260701054926.825925-2-aneesh.kumar@kernel.org>
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

Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
helper") changed dma_direct_alloc_from_pool() to return the CPU address
from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
dma_direct_alloc_pages() also uses the helper and expects a struct page *.

Fix this by making dma_direct_alloc_from_pool() return the struct page *
again, and pass the CPU address back through an out-parameter for the
dma_direct_alloc() caller.

Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
Cc: stable@vger.kernel.org
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4391b797d4db..b4cb2c03e5d7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -164,22 +164,21 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
 
-static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp)
 {
 	struct page *page;
 	u64 phys_limit;
-	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
-	return ret;
+	return page;
 }
 
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
@@ -247,8 +246,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * the atomic pools instead if we aren't allowed block.
 	 */
 	if ((remap || force_dma_unencrypted(dev)) &&
-	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+	    dma_direct_use_pool(dev, gfp)) {
+		page = dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  &ret, gfp);
+		return page ? ret : NULL;
+	}
 
 	/* we always manually zero the memory once we are done */
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
@@ -357,7 +359,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle, &ret, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
-- 
2.43.0


