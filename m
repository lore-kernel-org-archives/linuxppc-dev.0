Return-Path: <linuxppc-dev+bounces-24360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8B8C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 18:05:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1yWC64Hjz3c2L;
	Sat, 18 Jul 2026 04:05:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784311527;
	cv=none; b=NAVjISpJu3zpMIrC/EVcNiaqP++mxsGOALfLGbVZzfXSG2uURTR2Y08lqL0frMb5+PWp95tYb+aTvlV/BDMa3IoKNoqfNCG/WidCDfwFQSxL7dGqbwRRuF9hC22h5Pafutds2XFRWuX7Xd/HvGyzy/MNfCIb+rPsROYHhUUMb2gGggvavT9DDOZNpVu4eNwtdYa+pTPn/TMXK8cbSfbCd6F5pWSVDVJ82lStAlzV74x3t5urkehi2f4Gj8VmQSQcCTNK7g0HKL3yHV/YQ8dMVNz0wqDg8Df3OlaXJbgGHlE2thOYWlcFr2CfP3Zpdt51opnvvF/QTgausUo9g645vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784311527; c=relaxed/relaxed;
	bh=Ss9PM/006K6SV5h+g0Mm+5y5zthxbL2BqyOfIndeCeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqr8f4DyNbIXklMKo/wVgZZZjZzJhWIaERJv4JrTdvvI43za0P+VObAiA7Y7E4oXWBX0zw0GuWORyG/UfhQ9r/ec+t1Hm33THePKLNXBpKpldkSCpqbbbAIfuOy5D7VX5d1GaAbzGQiqf0YM3HhDcp+/yST5wdfmdsN/kiu/pfBHI7jh0FMKGSG+lfesbHQ5sp+FS+G76uTIq4dMTCaqCKpsR4BIyXjVokw40CT3MkAzfobTic1VO5gYFGJw3CLHC+h1w1lG0OgTIw0xwDXfzGVudsj76TCqqWtvCniBsU1ev6x1TybX1eENSF+6FPSLfokYguy5WvrNNYMKjBsFCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuVQu0Md; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuVQu0Md;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1yWB722Hz3c2W
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 04:05:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BC0D641953;
	Fri, 17 Jul 2026 18:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20961F000E9;
	Fri, 17 Jul 2026 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311524;
	bh=Ss9PM/006K6SV5h+g0Mm+5y5zthxbL2BqyOfIndeCeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TuVQu0MdtCse0JkcTEXH2Lq3N8GnmxJYSHQ6CoRTHDltevRiIULT5pnqPM4+8+BAQ
	 /JYVDAwN6m05+4yZnuZwY+K+Uvh7axJ4AmMsAJCMR7dGUeQuyQp75bJT0fW4GwPxsr
	 r2m0krA+7xFAwrpSKW3D1wGN0ak4798EK1c2pnF1nE1AxAqM5JU7p2Y+uwKAtlzr/3
	 0SP8yoL0OntLzCWzdi5O4R036tEdejgeaZDyzHmy7KzUiLH+vr0e7bLicKBgrzgUFT
	 QWcdjpVZw+U9E+w0lbFwqX/3IGUvZJvLJDX+7Ctr3NP0ikMrI2SChaP0sOzNHVVMfQ
	 j3ClE0BUZz12A==
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v8 02/23] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Fri, 17 Jul 2026 23:34:20 +0530
Message-ID: <20260717180442.110954-3-aneesh.kumar@kernel.org>
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

atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled.

When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
such as gen_pool_add_virt(), jump to remove_mapping and return without
freeing the pages.

Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
that cleanup paths always release the allocation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


