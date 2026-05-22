Return-Path: <linuxppc-dev+bounces-21359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36564CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 04:30:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMC516sH0z3brt;
	Fri, 22 May 2026 14:30:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779424245;
	cv=none; b=bjSr+o6MNDYgHOg6FtnML6YpMbTg2O9LWLoV0qqAIi6SUKmNmE4e65bAhVjuwPVPh6j374YjwlMQvJaUwu8HjHlZ83DUkUKA+dNOoFc7tLehOlh00LL8saKpVs6mIYkNklPDEBvTzk0xgTI2+olSexeJmd3tBQgngoYQMY6ebV5EgMp28UyP0/nCYBp8bXfIQc4FYiREL6kIFnfC5O8SfhgF6PD5O6cUZOzgjrMRQbMv9/0lyjTC/Zv897DGo56icN38afCMD9Vdwtev74rVWqC/Sdb8EvQxgWxGBWguoewtWcOOzY1KSm2SGkdIdjzERy1kKUZMVGaZH+xLiVld1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779424245; c=relaxed/relaxed;
	bh=UimiJKf1atAV++YvZ9iVVwY9ppNjQrEQsdOyX7IBAF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCEiB1Cqx59gnTCxhxeQhhWuLhEd5HpoRTNqLuAIkstKe5O/xjtMkO8ULEKtng4VlClpi8EbZGUZaEp6zgSO5fLManuo37fQ55p2zjvthbj4mqHaFgHTiA9NZlZgA7HHZTa5Eq0/vJmhNiYajVHaQRGL8uZVkARHOA/pjxXLVElBO2Io7ZqV5DyAR8NyvPsBCODZVOszoAElf9LSPrWgjKIIMyld+6hzTaBTA+qjOBwYBKN6US8PW3O+Luc29pQswPXn99pfayY2/P8GrSSWbPYkfXmOFmS54vNVGht9nU0NOSYyw1EWWE1IoRv4IK6jH1KjIpD0iVZSWnVMdw+vjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcStVCGY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcStVCGY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMC511VR2z3brr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:30:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5185260172;
	Fri, 22 May 2026 04:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F821F00A3D;
	Fri, 22 May 2026 04:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424243;
	bh=UimiJKf1atAV++YvZ9iVVwY9ppNjQrEQsdOyX7IBAF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BcStVCGY45gRT0Uy65Q9yDB9Q8vYJCtFILxW2DeH3ca+eqKeay+TMRJW+rcDLlchP
	 uiUSexXj+f1vphGtExFKWaLuJ4lifT/f75SrSLaj6uFBJSRJvbpqkC+zDcEjg/Faci
	 CzBAwdbHOrDkibhosN3DPR0XpLOnI0GQ3RPWD5a+XYn7/Frs42+iNqXHviHM0W3ACX
	 409hXav7LUA+ommHdAAeJZ8zSR3SWyZXjNHe2kHYzQGElrVWWRt/lz2jjHQAhviP2s
	 gVGp512RqskgNglY48+z8v6IlWrObrVV6T6nHEMdrkb5U6eQHJoWLuaJfJDEDPHwH9
	 HvOmK5x6sr/7g==
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH v5 11/20] dma-direct: set decrypted flag for remapped DMA allocations
Date: Fri, 22 May 2026 09:58:06 +0530
Message-ID: <20260522042815.370873-12-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
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

Devices that are DMA non-coherent and require a remap were skipping
dma_set_decrypted(), leaving DMA buffers encrypted even when the device
requires unencrypted access. Move the call after the if (remap) branch
so that both the direct and remapped allocation paths correctly mark the
allocation as decrypted (or fail cleanly) before use.

Fix dma_direct_alloc() and dma_direct_free() to apply set_memory_*() to
the linear-map alias of the backing pages instead of the remapped CPU
address. Also disallow highmem pages for DMA_ATTR_CC_SHARED, because
highmem buffers do not provide a usable linear-map address.

Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
Tested-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 55 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9e65c8432b6e..d7eee77f95af 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -196,6 +196,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 {
 	bool remap = false, set_uncached = false;
 	bool mark_mem_decrypt = false;
+	bool allow_highmem = true;
 	struct page *page;
 	void *ret;
 
@@ -214,6 +215,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		mark_mem_decrypt = true;
 	}
 
+	if (attrs & DMA_ATTR_CC_SHARED)
+		/*
+		 * Unencrypted/shared DMA requires a linear-mapped buffer
+		 * address to look up the PFN and set architecture-required PFN
+		 * attributes. This is not possible with HighMem. Avoid HighMem
+		 * allocation.
+		 */
+		allow_highmem = false;
+
 	size = PAGE_ALIGN(size);
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
@@ -272,7 +282,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
 	if (!page)
 		return NULL;
 
@@ -287,6 +297,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		set_uncached = false;
 	}
 
+	if (mark_mem_decrypt) {
+		void *lm_addr;
+
+		lm_addr = page_address(page);
+		if (set_memory_decrypted((unsigned long)lm_addr, PFN_UP(size)))
+			goto out_leak_pages;
+	}
+
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
@@ -297,29 +315,36 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = dma_common_contiguous_remap(page, size, prot,
 				__builtin_return_address(0));
 		if (!ret)
-			goto out_free_pages;
+			goto out_encrypt_pages;
 	} else {
 		ret = page_address(page);
-		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))
-			goto out_leak_pages;
 	}
 
 	memset(ret, 0, size);
 
 	if (set_uncached) {
+		void *uncached_cpu_addr;
+
 		arch_dma_prep_coherent(page, size);
-		ret = arch_dma_set_uncached(ret, size);
-		if (IS_ERR(ret))
-			goto out_encrypt_pages;
+		uncached_cpu_addr = arch_dma_set_uncached(ret, size);
+		if (IS_ERR(uncached_cpu_addr))
+			goto out_free_remap_pages;
+		ret = uncached_cpu_addr;
 	}
 
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return ret;
 
+
+out_free_remap_pages:
+	if (remap)
+		dma_common_free_remap(ret, size);
+
 out_encrypt_pages:
-	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
-		return NULL;
-out_free_pages:
+	if (mark_mem_decrypt &&
+	    dma_set_encrypted(dev, page_address(page), size))
+		goto out_leak_pages;
+
 	if (!swiotlb_free(dev, page, size))
 		dma_free_contiguous(dev, page, size);
 	return NULL;
@@ -384,8 +409,16 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
+	}
+
+	if (mark_mem_encrypted) {
+		void *lm_addr;
+
+		lm_addr = phys_to_virt(phys);
+		if (set_memory_encrypted((unsigned long)lm_addr, PFN_UP(size))) {
+			pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
 			return;
+		}
 	}
 
 	if (swiotlb_pool)
-- 
2.43.0


