Return-Path: <linuxppc-dev+bounces-20779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98615CD4F35
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 09:06:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9h22SR5z2yv4;
	Tue, 12 May 2026 19:06:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778576802;
	cv=none; b=jKhgc1dxKYEUwZYehKyEckxpxSBEJxI1kIKWDsy3V4q/26RJGZP2yEVZZzTVotkj9gxWJPFmgOTflGspHQhZ6zYyP5p6rqgjEZClZhFzoNzT5o2wtSqv63IaN4r2B9wKq7MN1wUJC4d/s2wQKVKA6in9e83R7R3lyWkR3ylIVJFDaKK5ZmwuvBbIumFF1V+DhfcxfZOskUNDaXZrtSg88Eo9DPlCWQigmvXBZbH//mv9DYovf/8penv5FAmSCaEMjs8mqaOiNJNmcltbCdaFJCEMhGda8bYLfb9qStusVj7CE8Q+4TbD5GaPxiesTMyxSu/CNY17GKtwOVGd4BX0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778576802; c=relaxed/relaxed;
	bh=1jmP/TvG+eVU58X498eguI1YKUfux/ase4Doi+Mx29Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6/Lk7hR0L7tIBvVNU4Q6lOsNa5z/gfInxiyQNSDcmjfJp/l1MkXRWSJLeMFw3MvnhfR5HPScTnAlvMJAmpOIIQs3DVgU6tAYc9KpaKeRH3npUUsGLlEraVGkXHh3t6exrD8nsknf8t+pCNa+EE2fHh3WpN/nPZ59oHj1NmoViZwPjTnRhfR14nu2zSJxk8FdYe5rLsl+xFNXE0fpnBgntmS3ikFnuHhXD1gjyw9/3cxNQ7S4l8Y9n5XivwU8UTZQq5XfetqS9BcZ+EAPO6BT7MeDl+3Yco4KtoEeaJpS2O+bAmom/1nMGRBwx7s9/MbTF0oRxCJ/3uNLQFNbA5/1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gg9NhAp7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gg9NhAp7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9h149Zpz2yv2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 19:06:41 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CE56E4391C;
	Tue, 12 May 2026 09:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC84C2BCF7;
	Tue, 12 May 2026 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576799;
	bh=mTlzwGmKaksgYc3F/GyUj4XB9AG9GATAkfL4j43fQ40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gg9NhAp7QAL+VjZbnyz/0jlu7gA+E880rsW1LbQ4Tm+kjB/qLh83dBTqQCogFkMnk
	 6ldiTPnH1BZAHckzOmx/zFVXOvdywPpPf75pIgEpalHO5cqsgAyIFMRGo1Pp+77GEO
	 MM0gflFTCnuDTyh7C+CWAabFjFk801in1C2uepCZveaoORNYDG2BAqk4lzaTwLJQO6
	 msRKi6DGIBt9MapjDJ/C6gK56qwGC2e+Q3E3tpjbe3FWjBA4z4aPUCiQI43o+zkFJu
	 mUPkM5VjW/y2kXSQuOj2NG74UZEsprayRa/8m7pL2NMYQAR7xaHdfQY+GzIyu7EPvK
	 ce/+WEjgnU5BQ==
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
Subject: [PATCH v4 11/13] dma-direct: rename ret to cpu_addr in alloc helpers
Date: Tue, 12 May 2026 14:34:06 +0530
Message-ID: <20260512090408.794195-12-aneesh.kumar@kernel.org>
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

ret in dma_direct_alloc() and dma_direct_alloc_pages() holds the returned
CPU mapping, not a generic return value. Rename it to cpu_addr and update
the remaining uses to match.

This makes the allocation paths easier to follow and keeps the local naming
consistent with what the variable actually represents.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1e9f9ff7b9d3..902008e40ea1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -212,7 +212,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	bool mark_mem_decrypt = false;
 	bool allow_highmem = true;
 	struct page *page;
-	void *ret;
+	void *cpu_addr;
 
 	/*
 	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
@@ -326,34 +326,33 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 
 		/* create a coherent mapping */
-		ret = dma_common_contiguous_remap(page, size, prot,
-				__builtin_return_address(0));
-		if (!ret)
+		cpu_addr = dma_common_contiguous_remap(page, size, prot,
+					__builtin_return_address(0));
+		if (!cpu_addr)
 			goto out_encrypt_pages;
 	} else {
-		ret = page_address(page);
+		cpu_addr = page_address(page);
 	}
 
-	memset(ret, 0, size);
+	memset(cpu_addr, 0, size);
 
 	if (set_uncached) {
 		void *uncached_cpu_addr;
 
 		arch_dma_prep_coherent(page, size);
-		uncached_cpu_addr = arch_dma_set_uncached(ret, size);
+		uncached_cpu_addr = arch_dma_set_uncached(cpu_addr, size);
 		if (IS_ERR(uncached_cpu_addr))
 			goto out_free_remap_pages;
-		ret = uncached_cpu_addr;
+		cpu_addr = uncached_cpu_addr;
 	}
 
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & DMA_ATTR_CC_SHARED));
-	return ret;
-
+	return cpu_addr;
 
 out_free_remap_pages:
 	if (remap)
-		dma_common_free_remap(ret, size);
+		dma_common_free_remap(cpu_addr, size);
 
 out_encrypt_pages:
 	if (mark_mem_decrypt &&
@@ -437,7 +436,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 {
 	unsigned long attrs = 0;
 	struct page *page;
-	void *ret;
+	void *cpu_addr;
 
 	if (force_dma_unencrypted(dev))
 		attrs |= DMA_ATTR_CC_SHARED;
@@ -455,7 +454,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 			swiotlb_free(dev, page, size);
 			return NULL;
 		}
-		ret = page_address(page);
+		cpu_addr = page_address(page);
 		goto setup_page;
 	}
 
@@ -463,11 +462,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	ret = page_address(page);
-	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, ret, size))
+	cpu_addr = page_address(page);
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, cpu_addr, size))
 		goto out_leak_pages;
 setup_page:
-	memset(ret, 0, size);
+	memset(cpu_addr, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return page;
-- 
2.43.0


