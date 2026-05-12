Return-Path: <linuxppc-dev+bounces-20776-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40785CD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 09:06:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9gN72Gvz2yrX;
	Tue, 12 May 2026 19:06:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778576768;
	cv=none; b=PlniTU8XnhGX0h2kVNfaov97MWRieCVx+v4/bmvMe3DVenBsYPEDotf7+KlESXUkr9sYvNWyewNzoxf/CBsvesAzPAmbrVg85Kw0DPel1GZE28K9mZpu8Q+Xso7IwImvzK2stGkZ2wg6nETR8SIoiC28kN3F4KyCJBgx2tD1LWj/ybJBO/EAELrznrxy8juEHrLccxsBgnANTMWo4R0ermGVfivEctMIttEDgm8yqDSEC8jQoAhxdTC0/TSB4od/z8DaSPCcM8lNN1C7vUhs4bDD+NJQ49Wp11xXP1kVSLo2SKXGkwIRcf3npAFeX3/VkloY06BULeALMQZCXaSRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778576768; c=relaxed/relaxed;
	bh=hwkgKwxQEB4N/lycjHNgM+B8NLmz+/9SJqThMVz/1bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aY9dksxX1rttASgodvT0pZmf8jxSnEsvDeWDinp2b0iHVQ7LZToSi18+ufNK07lLhmMF+mpakvSfhJIuxaaVqBATzr0yFo7yNWb8yVG/mRYjdZA7gnDMH3Pv+TqRVM/H9xg59RC1OKQ5yMQ2iI+I38Xg5izEy+SD23yqq+8wW7ACjM8MW/uWZ3n1yQiPz0+mqbGLODGtzYtfDr2yZL9A5SYfICFCfQ+4a2WABNJcI6nHDISZrDrrfKXyyDKhOtS5m9LjJWO35RIcCS4xiPd/2nr2zy4Q4OU3bPZj5wcUMhqHPFskOsUf5lMn/wgEEgks226hDmrTK+QkPzomCSEvBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nVAK40Lf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nVAK40Lf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9gM4Dnlz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 19:06:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B94D260126;
	Tue, 12 May 2026 09:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C74EC2BCF5;
	Tue, 12 May 2026 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576765;
	bh=16IbbDmBI894AMGJNFhh69uBka8eAlp5FTjDwJZdlnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVAK40LfYZrBtDvRtjA7tMJs0cMnULnsZSnRoWepqQHZmIqmuO9je8PQQVCyNkkNg
	 Rc+KO9UbCW2vOCU+lW7aFNJLcd/+Sf/EeaMZhPN9SJXYOtncLxjbWoeYv2YtTFEoJZ
	 2APIaWChN5x4ArYIiPZjEy1HEkXcsFQ2nTfz6nFccGEeC66p0So8BhQr2Yen03LZLP
	 NRrZ4OT0eqMTdqRr6bc/hMMZl4e2PRbobg2h/udFtsQ45xPYs0LqE1tUFgXuKqgnoX
	 KgDFxMAbVhQoS4MVXkW9Rh8gLamKNOy++DEQYXPcgIddKiT5EDUMlaaRqAorqYLBhO
	 LK9KOABLNjAsg==
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
	x86@kernel.org
Subject: [PATCH v4 08/13] dma-direct: set decrypted flag for remapped DMA allocations
Date: Tue, 12 May 2026 14:34:03 +0530
Message-ID: <20260512090408.794195-9-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512090408.794195-1-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
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
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 56 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5aaa813c5509..f5da6e992d83 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -204,6 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 {
 	bool remap = false, set_uncached = false;
 	bool mark_mem_decrypt = false;
+	bool allow_highmem = true;
 	struct page *page;
 	void *ret;
 
@@ -222,6 +223,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
@@ -280,7 +290,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
 	if (!page)
 		return NULL;
 
@@ -295,6 +305,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
 
@@ -305,31 +323,39 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
+
 out_leak_pages:
 	return NULL;
 }
@@ -384,8 +410,16 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
+	}
+
+	if (mark_mem_encrypted) {
+		void *lm_addr;
+
+		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
+		if (set_memory_encrypted((unsigned long)lm_addr, PFN_UP(size))) {
+			pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
 			return;
+		}
 	}
 
 	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
-- 
2.43.0


