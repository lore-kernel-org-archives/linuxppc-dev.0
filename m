Return-Path: <linuxppc-dev+bounces-24374-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52127C44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 18:08:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1yZP04shz3c7M;
	Sat, 18 Jul 2026 04:08:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784311692;
	cv=none; b=QyWEqWNcu4PoW60mfH0R4o1YKS5wb6Xt7SHWhCh5ksIKdxU6oQSLFfBn47hovyi/fjztjW0yG68/lh8B4tBWs81mpUR9tQqnvVopV15iFGBPd1e7RBRne32A6uW2MrlwgRJ/3K7Rr8uB2AHQYnNkUXW4Ii1rQdT3sWwlz9YmDaw9QrSWu9yqUECRqaaJVYze8zAhxdVcOPXIqRAqyq+AmMNzB28bUHX5CDS6MHUDFhtHFGmjE+TsbjERThgTBlSmdP6JrnifuvgSDOWJgn8fB+LEo9ucdRBKAfZMsFXi6knw3SBXvL503hmFn9IDvyGbsw9RNwC53jObmEbxEgdWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784311692; c=relaxed/relaxed;
	bh=PwGwo2v1bc/tfRKKTB7zzFn/AHGX4mQVp7Ym9P3mvNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAH+qzWBFREvf0P+mYN6RInLuiOFxOI6XJvSF6S2DlNQzBU9ds/59dqqHShmqOO/IwKOEHvnSfZvLYjqJBuirmCg2La2Ly7WCb0llU+4GXRYJGq0hOLAJWwISo38lx3x5+Iza/APYsyNzKm1Qf056ghG8ytu0MHELw2K+EsON3IflrB2RQhkREkfIS+SFbj5TwXJoWKPnE6WDdWa2hJYmBx7x18NUGQQASFR3GQ6jB8Noc6z0llMX3wccY/vfdBerfk32DG9pDpUL2JPVA5/bs0wXIMCnlJQsTrOT+Q/jKz5b30fzqBVBH/zlzusON64DpqR7BZCuiGccqkCdsiCpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP5iTTw7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP5iTTw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1yZM6KNWz3c4P
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 04:08:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B02C74188F;
	Fri, 17 Jul 2026 18:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABC81F000E9;
	Fri, 17 Jul 2026 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311687;
	bh=PwGwo2v1bc/tfRKKTB7zzFn/AHGX4mQVp7Ym9P3mvNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BP5iTTw71m+JzUVT4oQamNjA8tRrSdlrhJHPabvG4jvbiWwSchW6LscApjzvzfSYm
	 MQCa8o0m1ipdDX7SdMuLHgTZ4IWXQxJktMmbiNLIQ+gJUPsFyi0XLXhJwYwxMpWaiL
	 SWcUDH7wvsith+5+bko8GxVl0wq3lBLtnfCOZfDXmaHKztP/qHL3IowfvzKQ5EzoBP
	 h4t+FDvFCW6cSzB18rA8aSxbkoiIIlsu9iUi8pNYrKPB6S3FtoxcP4so3dP5UOSKr3
	 fNoA1XnRHK/caUQEAWeczcbWRQAFkU5QeVq6grwcH/uSyIyJ/o5fqvAYN618S/gMjP
	 dLx40xNRBhQtw==
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
Subject: [PATCH v8 16/23] dma-direct: Move dma_direct_map_phys() to dma/direct.c
Date: Fri, 17 Jul 2026 23:34:34 +0530
Message-ID: <20260717180442.110954-17-aneesh.kumar@kernel.org>
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

dma_direct_map_phys() is too large to benefit from being inlined. Move its
implementation to direct.c and leave the declaration in direct.h.

No functional change in this patch

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.h | 56 +++------------------------------------------
 2 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f54c7929b97f..2413235c50f0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -620,6 +620,59 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 }
 
+dma_addr_t dma_direct_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs, bool flush)
+{
+	dma_addr_t dma_addr;
+
+	if (is_swiotlb_force_bounce(dev)) {
+		if (!(attrs & DMA_ATTR_CC_SHARED)) {
+			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+				return DMA_MAPPING_ERROR;
+
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		}
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		return DMA_MAPPING_ERROR;
+	}
+
+	if (attrs & DMA_ATTR_MMIO) {
+		dma_addr = phys;
+		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
+			goto err_overflow;
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		dma_addr = phys_to_dma_unencrypted(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
+			goto err_overflow;
+	} else {
+		dma_addr = phys_to_dma(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
+		    dma_kmalloc_needs_bounce(dev, size, dir)) {
+			if (is_swiotlb_active(dev) &&
+			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
+				return swiotlb_map(dev, phys, size, dir, attrs);
+
+			goto err_overflow;
+		}
+	}
+
+	if (!dev_is_dma_coherent(dev) &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
+		arch_sync_dma_for_device(phys, size, dir);
+		if (flush)
+			arch_sync_dma_flush();
+	}
+	return dma_addr;
+
+err_overflow:
+	dev_WARN_ONCE(
+		dev, 1,
+		"DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+		&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+	return DMA_MAPPING_ERROR;
+}
+
 int dma_direct_supported(struct device *dev, u64 mask)
 {
 	u64 min_mask = ((u64)max_pfn << PAGE_SHIFT) - 1;
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e05dc7649366..a7adadb1b2a5 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -17,6 +17,9 @@ bool dma_direct_can_mmap(struct device *dev);
 int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
+dma_addr_t dma_direct_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs, bool flush);
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
@@ -82,59 +85,6 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 	swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 }
 
-static inline dma_addr_t dma_direct_map_phys(struct device *dev,
-		phys_addr_t phys, size_t size, enum dma_data_direction dir,
-		unsigned long attrs, bool flush)
-{
-	dma_addr_t dma_addr;
-
-	if (is_swiotlb_force_bounce(dev)) {
-		if (!(attrs & DMA_ATTR_CC_SHARED)) {
-			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
-				return DMA_MAPPING_ERROR;
-
-			return swiotlb_map(dev, phys, size, dir, attrs);
-		}
-	} else if (attrs & DMA_ATTR_CC_SHARED) {
-		return DMA_MAPPING_ERROR;
-	}
-
-	if (attrs & DMA_ATTR_MMIO) {
-		dma_addr = phys;
-		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
-			goto err_overflow;
-	} else if (attrs & DMA_ATTR_CC_SHARED) {
-		dma_addr = phys_to_dma_unencrypted(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
-			goto err_overflow;
-	} else {
-		dma_addr = phys_to_dma(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
-		    dma_kmalloc_needs_bounce(dev, size, dir)) {
-			if (is_swiotlb_active(dev) &&
-			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
-				return swiotlb_map(dev, phys, size, dir, attrs);
-
-			goto err_overflow;
-		}
-	}
-
-	if (!dev_is_dma_coherent(dev) &&
-	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
-		arch_sync_dma_for_device(phys, size, dir);
-		if (flush)
-			arch_sync_dma_flush();
-	}
-	return dma_addr;
-
-err_overflow:
-	dev_WARN_ONCE(
-		dev, 1,
-		"DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-		&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
-	return DMA_MAPPING_ERROR;
-}
-
 static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs,
 		bool flush)
-- 
2.43.0


