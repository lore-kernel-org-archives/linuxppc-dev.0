Return-Path: <linuxppc-dev+bounces-24362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E230C44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 18:05:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1yWf4KLgz3c2q;
	Sat, 18 Jul 2026 04:05:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784311550;
	cv=none; b=P7IGHzE53R/JMQK17DuxweceDQq0B+ElvePOM/dvexhW5fEME6FESA5AJbBP2FtBlQxVG7VTYN9XmFRqXb9Sl67bm6yZE9wWSJSwNru6tBPza4PrJFPGJdKm0mfrtIXnqJfnQRB+cD8YpSs3Q7FntK8/pDkrEM1V9+HYGk1q+cJRrYctef4Z47cu3mRpjsGa2m6CBoax1pBAY98kurq9N4C+svTMi1ZGNfdLW8j3n/Kj10E3Trhl1sNbIYOfCLfcU++PCIzMW1n9klq3igQIX1xTtNgUh7VtSNc91H/c7c0oBoDt4yO1YZfWf6IF+GxCl8nYBrOw4KprfTZKj6eUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784311550; c=relaxed/relaxed;
	bh=z6dDgE7JkOObtE2Hn1HKt3eeloSTK5VxIseLNnZOFlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxkLNLatZaFnH6x6jC6nCTcQS4Cmj6L148axdaJt+rE8yn1dmwvdk+qQNgyc/5hDuTNa3aPcxJ2jHr+l9jERD2/FQfCTPASA16ENXmP0lMpeRzt3SgT1B//nTJqmw58rLuw0azEfKPLpHInnLVzGq6ifBZ30P3jTGO4xmWbl6ruSp0DZ4mp+xfgVjHkGJ3lq/c2c5gQWvdBJ8Zor7kCSIyNrA40UkCkyenBsHQPjZTnT1T1/Lss02eZs1KzQ/E/qU0NDJvak8fnnUtVnIbGSKYtgOaM48Cgc6e3qkw4NFMLPvtN6V9wwbw1b+bDqUXNhMba2ZEwqJcPAA9HcIacyWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeF+Ifxp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeF+Ifxp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1yWd5KzHz3c2K
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 04:05:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3D47E41953;
	Fri, 17 Jul 2026 18:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813691F000E9;
	Fri, 17 Jul 2026 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311548;
	bh=z6dDgE7JkOObtE2Hn1HKt3eeloSTK5VxIseLNnZOFlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeF+IfxpYmSZu1u63a32cjs/L6r2e1rcv4bFhtQBcuR85N5csGMHhS2Zv4clRRRfo
	 166/0G3NoQm3IkkzhttzLiZor3pQyQuRBeIi7AUb6eNG/m9T26xDOD0U7IBM5q3JD2
	 KDj0cfreenJRdo5kM018PQi+WeqxvoKAsj6IjfGXWjwZFhBuo0Ovvq3OR5H73JZoBS
	 AnPoFylIrnK6Oo6qmRifNa4hFKTXFTTxF0DVCZ4aRukA0AGbk+98JPvjtojnbw7dnm
	 4d3c38FgZhROoLkjtF1V6KXLi89DhnzsYwwQZ+rHP1+zvJyKLm4edWgJzrrUnBBTBT
	 mpGs1kqSePKhA==
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
Subject: [PATCH v8 04/23] dma: free atomic pool pages by physical address
Date: Fri, 17 Jul 2026 23:34:22 +0530
Message-ID: <20260717180442.110954-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
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
 kernel/dma/pool.c           | 61 +++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

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
index 363d984d90e7..a81597f8c3ed 100644
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
index b0303efbc153..e981c1faaadf 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -311,3 +311,64 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
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
+/*
+ * FIXME: We could avoid this by storing the remapped virtual address in
+ * struct page and using that for lookup.
+ */
+bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)
+{
+	struct gen_pool *pool = NULL;
+	phys_addr_t phys = page_to_phys(page);
+
+	if (!IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
+		return dma_free_from_pool(dev, page_address(page), size);
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


