Return-Path: <linuxppc-dev+bounces-21361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B250CD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 04:31:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMC5S2DLPz3bpJ;
	Fri, 22 May 2026 14:31:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779424268;
	cv=none; b=nNjdRthMKKQvb5qt4D6BsPmBSmc6/e+yx0ACnLy6LOl1D5oTGOjm3q7IYNLWAeHdmuM/WlznyHjcivuBzueZLEgKQqP6sqqX77OFTHFyLpbCtd3836k5YQGK/j9wk+YC7hn+XG5vwqgpm4B9A7iqx+dtmIJ0khTvMHCHCleqpRN143R8gwhV8SxdSzWhF05HmN7DG2tzWevO3S/QmoEfcvo2BrOUNvJ/q4bs6Wn2gXykdNcFcFnTpxe/ZEwfFDk/uEYpMOc9bDV8FJEu6v+jpmKTazCMFgXGtXEbmxl8Ie1eD+qKGF8Ao/EfQHKl72T3zpRGAUWfvFcJIfWXEaixQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779424268; c=relaxed/relaxed;
	bh=BRoOTjIXEIfZY33xB/HfCrHMNoIMuz43xHMqdbl/MXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnxkHpPW9TfZNBBq2vFiJoduc/n/WSRm5A+J2wmLqjGASggPUKpJrb6YuoZqMJFakryVEdtclAoCzg5n748yrMJ7ImsOXF8TUFsVgNGVsKwYkXkzTTgEsEyo6+7JNlhgdL1ym56mbys6I9RmdtMECKU/L9FO+O9F0pZ5dgdg/any8zCozfE5P5YyIMJFGjrO5KHOH+PSwf42vgDmPG+NVOSeGAFRNZWv/tLoUFI+lSAlZ0rNnXUvgLM4iv3Un0aHq1t9GTq0Iai003OQn+uPYAAoxAVV+5qWSSVLXNqYQNidNePCK0whDN6uYdbTG7UyhdSqkaJ1s8kjLyz/onOLXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJqOdGXU; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJqOdGXU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMC5R3YVxz3bpG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:31:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A08E560172;
	Fri, 22 May 2026 04:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295411F00A3D;
	Fri, 22 May 2026 04:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424265;
	bh=BRoOTjIXEIfZY33xB/HfCrHMNoIMuz43xHMqdbl/MXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJqOdGXUzoeK/2txik8hoWdiGyYw3ctMEtyPvywn3Wu8DCk3sMglax3QlyOPFYUVm
	 8R8/BKN2Pb5a9JjZcGIh2+8jAI+HZzKk1myOUuKKFuVs4/Xi969HK3/F0ktmoU8hwr
	 vQazAEaw5n9TwQ9VvmkrjlczEPvakOpbQd3Z69nW22XSfcxfiRCFxQkyRiwzUbM56D
	 Wrsqr4HHYb8mXz7NwrbgrDRNxbXy9s3hw+8PPcBENymcvkPLcF6Jwfzh3kTnal2jDl
	 xMuN2HcG+gwdFOdUIPxeDkD4gKLcj/208Gaf84OvuNRB0uDd08BUx/z1Db+drjlkGm
	 c2tylJmWR1M+A==
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
Subject: [PATCH v5 13/20] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Fri, 22 May 2026 09:58:08 +0530
Message-ID: <20260522042815.370873-14-aneesh.kumar@kernel.org>
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

atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled.

When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
such as gen_pool_add_virt(), jump to remove_mapping and return without
freeing the pages.

Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
that cleanup paths always release the allocation.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index be78474a6c49..e7df8d279e75 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -146,9 +146,9 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
+#endif
 	if (!leak_pages)
 		__free_pages(page, order);
-#endif
 out:
 	return ret;
 }
-- 
2.43.0


