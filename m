Return-Path: <linuxppc-dev+bounces-23249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601FFC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:50:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqpy953r0z2yR5;
	Wed, 01 Jul 2026 15:50:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885009;
	cv=none; b=Wzp1iFNpAWOHKG7QEOcFYPxT8+eSkY6maLr9lBZo9xLLYLdIwvDBdoUffgzQQdePcyk8u6kLqIqLUy0hKal1IDIbboUmckNMq2CKKLmJcpHMShoKw7UVWflTdjGVau/Y3w9zwiB4dP+pGxuI5jlDsZhnibitUzeacObOoyNB9/dMrwtyPFT9AUnvJlatrVkdgQQtRYG5YUpjB2UrPd9OZqa+8d14jSrmNwKCtUxL4NoqjE62zfQroDNeAxca6pcbglfvTCaxSr50fwrEOT5UPgeLL9pVsXRvRrJ7tzaOkIJu3ZzXz8oC90NAUMdXWRUX7Ev1VEUAZvCClJl+RL0eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885009; c=relaxed/relaxed;
	bh=YM/kzkdd2b4wz0/QuPV8d4m9Lm+x6hpDFjkd4v2KLO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjMlGdzma3PINxW10RhImp4RDvWhWRF1AIlEcK3RF6SpRzUJkzed1IxM6FDEwKtFN5TCKyVN71/VGoQxpIv5IDf+debLRq6qgiJY+dCHZe5IfqZeZj0dI4TMyQXT7Nss7UIyftjtKcXls4u4Gu146LSAX4arVS+PvCy9k3SvtRfXO2sRF9qzFW8xrpRmf1hg0fCOQOtbz2IPKpJEQnWJIYuBCC+XLNHc32rXQC6KzDp/ao1Du0HZgJ5Z2Ybv6Rb65uAavmZcN5Y6kW59q5nlDVrAFIxGM60pOZDFaB5EOZyYvH/c5JhB0qpbaeKE7mkFiOf6cplKK4n+jyFLo6ojew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVUePrtd; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVUePrtd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqpy85fq4z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:50:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD2F66001D;
	Wed,  1 Jul 2026 05:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628A81F00A3E;
	Wed,  1 Jul 2026 05:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885006;
	bh=YM/kzkdd2b4wz0/QuPV8d4m9Lm+x6hpDFjkd4v2KLO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVUePrtdGdfcHjX+cljzkAXWX8yQtKPyHxYbs9+rDOOIfIvI8HQob1dUJF+TOW/y0
	 fC5sqXl8TCTqr/8FrheOkNk8daMgGh8mpyaLj/+fVYuN40wIzhFqgHFJqQqshM2AAZ
	 QmS72TRjtqkOOrJbTcnATbGlXL4fSZouBBLMvDsNWlaDXpAHcdKnbWVdTCKxRWvKLi
	 FTiOEZh/3FHlbfRr7w7c+MZ7DEEe6AFLEpev1I+D+hE0x8kTOk80LKi5+7NbwXm/+H
	 JynSNQfMR3DglTV2+o+PCwvEpadWmlRiKgqn7fA8aS8g9TTAXMf6o7W7ysUHuYt6E1
	 ytVN3wRJb/NYQ==
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
Subject: [PATCH v7 02/22] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Wed,  1 Jul 2026 11:19:06 +0530
Message-ID: <20260701054926.825925-3-aneesh.kumar@kernel.org>
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

atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled.

When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
such as gen_pool_add_virt(), jump to remove_mapping and return without
freeing the pages.

Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
that cleanup paths always release the allocation.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/pool.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..b0303efbc153 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 {
 	unsigned int order;
 	struct page *page = NULL;
+	bool leak_pages = false;
 	void *addr;
 	int ret = -ENOMEM;
 
@@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	 */
 	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
 				   1 << order);
-	if (ret)
+	if (ret) {
+		leak_pages = true;
 		goto remove_mapping;
+	}
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
@@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 				   1 << order);
 	if (WARN_ON_ONCE(ret)) {
 		/* Decrypt succeeded but encrypt failed, purposely leak */
-		goto out;
+		leak_pages = true;
 	}
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
-	__free_pages(page, order);
 #endif
+	if (!leak_pages)
+		__free_pages(page, order);
 out:
 	return ret;
 }
-- 
2.43.0


