Return-Path: <linuxppc-dev+bounces-23261-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA379C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:52:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqq0j32BCz2ynf;
	Wed, 01 Jul 2026 15:52:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885141;
	cv=none; b=UQ4hswEIbjZdNQupF5zgqgsWoQLl6KPPli1M4w89kN4UbOqu8in7Olm5vCfc8jjTRwGGdI3iJ8QM1pvTG/wy4xoElB5IOCqgdDmV8/aJSdcAdmcAa8h9tcQBpfSOUibqcLTzkm1RYiSUdkzxC0NaoV5GHvxuf4C+dMPvA6Oeritr6oaiaVHcLk7vnEkUla7E4FDBavSmDFUtUUU+g03qKm+L26NYPkEvHJEHs6xBiarlVOQOsIV8bSCbx6/fmL+Y9NoPk3zZQCfs4dt45ayF/81MHguSgT2Zwy70kJ7ufdGDQ7S8VUdkaeHS5ngroJXE67Xmnmm9YKYxaBBcLq/oaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885141; c=relaxed/relaxed;
	bh=WaFole9WpH4WOdu0NoPZcwNtksyiD1swupReo/MXirw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGRHu2UYqBicAx/LFDdjn3ECx2JYHzAJGT9A0MlHyZ7qSsoe/0JmBaSZbHB6fJGsLynd2y71HNcSl7IU1kyn25qHQmbRl+VegOamkHDRYMeRUh1+7GEkL/rQTtf5F3t+wt/CWsHmaz57eSVI8lhq6UgaiSwSG3SX44ZcB4ivN7dXyPHPeuvyOCIg4s+0BFSWS+Adt5av3n8Jmv647gg8DZJmk48wWsUAMP1AMHGxbjfxct0YgZtkLPUOC05ZF+fjrxzoJ2y1npldznxMEx4g5C0EVdKQUNdNl4VjI7sNBHVhAnIdoUZLAcwxJoB+mrb0uTJWRD5vCZika5g848SJLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTOPEfvw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTOPEfvw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqq0h3XMbz2yfy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:52:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84971601D7;
	Wed,  1 Jul 2026 05:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60B01F00A3A;
	Wed,  1 Jul 2026 05:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885138;
	bh=WaFole9WpH4WOdu0NoPZcwNtksyiD1swupReo/MXirw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTOPEfvw+FTCjKT/3u4xNFzwHn2wRv7oSUt5koWJF9u9uNkLVk0MOmnuX0sfPKxAR
	 A5jTcoIgUSqlN78yWHoDkpWvbDcimQDU8TpT+DslgtdgKQx8C59xg4vXr1vvuqUN3+
	 ITwjK3Ea3288affFm4tea8Z478PtpCkPaAOF3umxoqmh2VlYK5pMD5fWUGfWeb9KQi
	 7wB+vIqlrcEmteCtLDA3If4owvXWb8HNSPY+YsWg2vFQU4DiwxHgNPwp+ezusSFQwi
	 ZkKgOwXfldX9XL6QJOAF3jv7OaGA5XsBKIP72v4dlk3/zl9yyyC7xQlOzbYzmi9eKV
	 0wIHdeWYMTnTQ==
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
Subject: [PATCH v7 14/22] dma-mapping: make dma_pgprot() honor __DMA_ATTR_ALLOC_CC_SHARED
Date: Wed,  1 Jul 2026 11:19:18 +0530
Message-ID: <20260701054926.825925-15-aneesh.kumar@kernel.org>
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

Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
do not need to adjust the page protection separately.

Update dma_pgprot() to apply pgprot_decrypted() when DMA_ATTR_CC_SHARED or
__DMA_ATTR_ALLOC_CC_SHARED is set and pgprot_encrypted() otherwise Convert
the dma-direct mmap paths to pass DMA_ATTR_CC_SHARED instead of open-coding
force_dma_unencrypted() handling around dma_pgprot().

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  |  8 +++-----
 kernel/dma/mapping.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 64cb9f13ef03..9935f7caa459 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -283,9 +283,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
-			prot = pgprot_decrypted(prot);
-
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -605,9 +602,10 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
 	int ret = -ENXIO;
 
-	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 	if (force_dma_unencrypted(dev))
-		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d2f70b6ccd0f..a628820fd10e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -537,13 +537,21 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
  */
 pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
 {
+	pgprot_t dma_prot;
+
 	if (dev_is_dma_coherent(dev))
-		return prot;
+		dma_prot = prot;
 #ifdef CONFIG_ARCH_HAS_DMA_WRITE_COMBINE
-	if (attrs & DMA_ATTR_WRITE_COMBINE)
-		return pgprot_writecombine(prot);
+	else if (attrs & DMA_ATTR_WRITE_COMBINE)
+		dma_prot = pgprot_writecombine(prot);
 #endif
-	return pgprot_dmacoherent(prot);
+	else
+		dma_prot = pgprot_dmacoherent(prot);
+
+	if (attrs & (DMA_ATTR_CC_SHARED | __DMA_ATTR_ALLOC_CC_SHARED))
+		return pgprot_decrypted(dma_prot);
+	else
+		return pgprot_encrypted(dma_prot);
 }
 #endif /* CONFIG_MMU */
 
-- 
2.43.0


