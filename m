Return-Path: <linuxppc-dev+bounces-21364-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C27ECD5BAF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 04:31:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMC6468Ltz3bpm;
	Fri, 22 May 2026 14:31:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779424300;
	cv=none; b=UP6mzhG7WMXxINq/mlc0gfXBYy1VL5t4vhcZmVxzEbltzVxBkILrD2SAxqNEcFqK24Ma7K08iVIkVhX5THlObjj7LYX5SxJWfCLV/MnRmF6ijvcySmu7suJwuebBkFOq+TAl0/Xh/GLdFqcbA0wpQ//1Lj5k3mGolVm5DL+lE9Tx8i63d10MoGpVaduiBuF7kwzRC5C5cqY8kIiHmLexuA4p6cJuQyTE8lmUk1xWUTyLFeAX33OTULU0dwzYDQNcVr30csZoEiNiirxy0RszeputpD56ljDjLD7ib6I2nWOfzRRSpOTUbDLoi5CBY+9/wj+pi3KD1yxUk044pCY5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779424300; c=relaxed/relaxed;
	bh=eNxPV4X8+LJvSw+1YGCbEG9piVGDIt8Se6Gkeol8Ww0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLmw3JVIICx3LwnwbObHwwU9XklajC/4hxQk6e55588iA8iFHySXMqrrEN0pQJRYDdWOH/DaL5o8oGjyiMdHOHK5RV+1n3KI5bGwgWXtOp6Dvhvy0+yVYO4TSFulsGrINWKB23J4HzkiW/2tF986cdPjvPNxY/bQ3E8jextTEMs2YH0aFpfhoKh4ywotiyv+WxxmBLUNW9LimZY3mAC9RXhYLCBZ7F0IGCRUiDKS0KjMGx8F848j6wHZtZNM4lkQay0h30CbJ6K06ArB9J/DljxCtfnT21JwvJJqp1jg08cn03pBEUm2GS7UnJPhzlCYShIsRkRC7uiDSQO/xDRPlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnEzxNen; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnEzxNen;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMC642WpPz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 14:31:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B80A343B48;
	Fri, 22 May 2026 04:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB661F00A3D;
	Fri, 22 May 2026 04:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424298;
	bh=eNxPV4X8+LJvSw+1YGCbEG9piVGDIt8Se6Gkeol8Ww0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnEzxNenegVHPTY+nqLjqtzKZpEkvdGMmUqLl7CrAAfRurgXThzU7ToDaiLG38rB5
	 gB0hJ3EocpSYOc2M5i8i9Dp1Ui3+aFSDCE8zAYwD4S/cUQYmG1sYMCkfsxWRQy9kuZ
	 ndgnDw20jy7R+n7mbHcpPHHqs2TxMcZGJkIod2vyMBmShf+bJjxOYp+DWQ/Et0EUM3
	 zoI9t8zIj/2zVJ0ozOizxl7i8+a+Qxr4J1ssSZOz+HA+DZfmqpWkefoRIKIZP/zISp
	 rqA41qNbKiCFSBEkjyGCO7Si8F4XX/tHCby/WZearmmtasBok8wnPn+TaMvHw53sHB
	 fCKm8mG+JiYmA==
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
Subject: [PATCH v5 16/20] iommu/dma: Check atomic pool allocation result directly
Date: Fri, 22 May 2026 09:58:11 +0530
Message-ID: <20260522042815.370873-17-aneesh.kumar@kernel.org>
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

The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
which returns the allocated page and fills cpu_addr only on success.

Do not rely on cpu_addr to detect allocation failure in this path. Check
the returned page directly before using it for the IOMMU mapping.

Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 725c7adb0a8d..52c599f4472c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1671,13 +1671,16 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !gfpflags_allow_blocking(gfp) && !coherent)
+	    !gfpflags_allow_blocking(gfp) && !coherent) {
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
 					   gfp, attrs, NULL);
-	else
+		if (!page)
+			return NULL;
+	} else {
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
-	if (!cpu_addr)
-		return NULL;
+		if (!cpu_addr)
+			return NULL;
+	}
 
 	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
 			dev->coherent_dma_mask);
-- 
2.43.0


