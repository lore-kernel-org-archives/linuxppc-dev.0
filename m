Return-Path: <linuxppc-dev+bounces-23251-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C75CC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:50:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqpyZ3mGNz2yfy;
	Wed, 01 Jul 2026 15:50:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885030;
	cv=none; b=D1VOzqEF7YBBJECbTh/hI9tG33HTBBUBTJ3noMUigNi2GeNnE5I6DKq7GY95t4Bv1FsV/Z8hxhuNjvIM/+IP2i246O8lzlwksnBlCk4IzpA3l/r/xh5iM08dxLs9QecE2e6F7SAjAfkw4IXjUdHThIcCag+5MWVOpZVeoDAc+XN4Q+4UgBGx2qk2wPNrX1nUgQLJgqBxPelwjxbzv4RZgSTGoFme13vrFXX0xmGgKGWWhpurm3KMe4qyWI8fqqm1zT7Fsm5OPB4yozB5zBnxteBdmlIZ6le3OTTneGl5ey1NAoEzK6s+DA4+yfpxj753GwAqZ6oBDTB92FD8CXR+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885030; c=relaxed/relaxed;
	bh=uK0F/gWRwNVcExGs/aIxWo/TgoVvALCb4U1mwxZD1ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkVPCC/m4hSXLqrkOHWiX+Zikt7SnJ+Qoj8i/zhsGjaIpMhTRsUIwF/EDuNqqLdVEWC1y2ltswgXd3kLVVsQkfBNpzeRi0S7jaowXfPgUBsuKJfec8OIcYss6/KbgeRQE6/Q7fGxHl8qjfrVQGtSe++yrGPBqEH3fPYy1oCs4X3Dc1HRBD4JUFdXQFuVX7V+YfLiCvmk9U253+qp8MFKZAy5aARsFP69pYoifxVfkKMucaLnjDiI39B3WYdFUM3Gn5zqhT9w2Ij6H88fuDNaMVZYDK8vN4axrC29SGubpZZ/+rjI6Y22ZLHlSMje0GLD/+CvNifx3FuP6NwRI1O1LA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDmtGiFg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDmtGiFg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqpyY5Wgfz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:50:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C2B1418A6;
	Wed,  1 Jul 2026 05:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA41F00A3D;
	Wed,  1 Jul 2026 05:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885028;
	bh=uK0F/gWRwNVcExGs/aIxWo/TgoVvALCb4U1mwxZD1ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDmtGiFgLXr0WvkfFZn8uSPkzcA16GAjnn54jLRiDJpcMm62Wz2J7FHoT9OU7pfGo
	 aDW41YlDlTKR8+ZZGuRsC1//sxp2nz1/HVYRRxTr2/mn55kX2HHdueW/2aPCQw73dd
	 uknDJVv5tDQVWK1jy4yvq0OSU3mljNcp2JqFC1vzWzFXgwTFHO1Cnc7rdv3suftGeb
	 56Bhk8NUZbwqfuSpui5K4uxQd3Gi3Vc4KSnZeNE0H+YnKtLxxlCYRmOKhBFrG2onhk
	 IdaiHcoPjuKXuagfPUmyJrGnMq2HdCTamC6HjH5u/F9/oj9pV/jtblD+gsXk3cfGLE
	 RsUhRYNWtvoVA==
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v7 04/22] dma: free atomic pool pages by physical address
Date: Wed,  1 Jul 2026 11:19:08 +0530
Message-ID: <20260701054926.825925-5-aneesh.kumar@kernel.org>
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

dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
atomic pools. The pool allocation is keyed by the virtual address stored in
the gen_pool, but the pages API returns only the backing struct page.

On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
to the gen_pool using their remapped virtual address.
dma_direct_free_pages() reconstructs a linear-map address with
page_address(page) and passes that to dma_free_from_pool(). That address
does not match the gen_pool virtual range, so the pool lookup can fail and
the code can fall through to freeing a pool-owned page through the normal
page allocator path.

Add a page-based pool free helper that looks up the owning pool chunk by
physical address, translates it back to the gen_pool virtual address, and
frees that address to the pool. Use it from dma_direct_free_pages() while
keeping the existing virtual-address helper for coherent allocation frees.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/dma-map-ops.h |  1 +
 kernel/dma/direct.c         |  4 +--
 kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index bcb5b5428aea..137e015c1750 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -215,6 +215,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		void **cpu_addr, gfp_t flags,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
+bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size);
 
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b4cb2c03e5d7..17f1e097499e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -381,9 +381,9 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 {
 	void *vaddr = page_address(page);
 
-	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
+	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    dma_free_from_pool(dev, vaddr, size))
+	    dma_free_from_pool_page(dev, page, size))
 		return;
 
 	if (dma_set_encrypted(dev, vaddr, size))
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index b0303efbc153..76bcafe03e44 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -311,3 +311,57 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
 	return false;
 }
+
+struct dma_pool_phys_match {
+	phys_addr_t phys;
+	size_t size;
+	unsigned long addr;
+	bool found;
+};
+
+static void dma_pool_find_phys(struct gen_pool *pool, struct gen_pool_chunk *chunk,
+			       void *data)
+{
+	struct dma_pool_phys_match *match = data;
+	phys_addr_t end = match->phys + match->size - 1;
+	phys_addr_t chunk_end;
+
+	if (match->found)
+		return;
+
+	chunk_end = chunk->phys_addr + (chunk->end_addr - chunk->start_addr);
+	if (match->phys < chunk->phys_addr || end > chunk_end)
+		return;
+
+	match->addr = chunk->start_addr + (match->phys - chunk->phys_addr);
+	match->found = true;
+}
+
+static bool dma_free_from_pool_phys(struct gen_pool *pool, phys_addr_t phys,
+				    size_t size)
+{
+	struct dma_pool_phys_match match = {
+		.phys = phys,
+		.size = size,
+	};
+
+	gen_pool_for_each_chunk(pool, dma_pool_find_phys, &match);
+	if (!match.found)
+		return false;
+
+	gen_pool_free(pool, match.addr, size);
+	return true;
+}
+
+bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)
+{
+	struct gen_pool *pool = NULL;
+	phys_addr_t phys = page_to_phys(page);
+
+	while ((pool = dma_guess_pool(pool, 0))) {
+		if (dma_free_from_pool_phys(pool, phys, size))
+			return true;
+	}
+
+	return false;
+}
-- 
2.43.0


