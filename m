Return-Path: <linuxppc-dev+bounces-23256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1608CC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:51:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqpzd5yhNz2yjs;
	Wed, 01 Jul 2026 15:51:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885085;
	cv=none; b=nmozeG726arbwR/Cpk/0wBsrGmuzDggRkpyLbpwdI+XuhbURVz4LhiYRQutt0+pmTe5+ZFsqRwO0lFtnpjDIz4FVD3da5SJjgyDXRp/3qKQqVl0PnMkFjU1wDQDBt93ggUAqfOzEnMae/clWouBIxY0yYlhzEXEqs9guODgFOiz32jrm9L1mDTB8HpEkbRz91VuRt57zj2dUc7xPrQYN1GraZ/AwTr43HnmL1BPj1v4VxBcx429P/ASajqE2T4h196FxCZigJZ52YDVSu6ltRHdPSJs+JN1+Bx0KL2+a2d8nGIe9jBkmdBBu7EAzsFxx+CBCPn3gXLggM/TtFHvlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885085; c=relaxed/relaxed;
	bh=Z/Bk6tzCc0Ng60ebNXKHAwFhGzmK1E5JjUoQiZztakc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IL2v/7sSD7qrKLL5nLUT//uRmpE/KCYU1DnYBpsfZK4jt4zJcpqv3Opc3wqb9Xj5cUSQLdiauFH0cCXTxuYwpYbH1eRHGhT/H5XgE9OZeTwFPsCvv4cl+D2e5qClamujDj0nR6vEhdJSBZiTInN0X/2G5qrfMxy3oI8PPpdP/xdzuYJMGaj/VTIf3ycwAo/HlXsA3Lsi8HlbtDyXgmz4WlNauBhXorA9hY8B83JqG1BoCV1MC+WDAJhGWRQ0l+BzBH5WLbqidX/9lGdckTGwVrekzXMqa9Z8P8Rgdeohrect7I8hWHvaEsAeBgEqd690H0xY+6SGSfeu5VzLpcP/lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFbJEcer; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFbJEcer;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqpzc70qYz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:51:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD9964011E;
	Wed,  1 Jul 2026 05:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D91F000E9;
	Wed,  1 Jul 2026 05:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885082;
	bh=Z/Bk6tzCc0Ng60ebNXKHAwFhGzmK1E5JjUoQiZztakc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BFbJEcer+pvCfD4YUpM6qeq3850G1Mf8qSExScerA+W0eWoi6XkmzRrs1MKSikMPN
	 HQ2Vgf9e9NSsfd0JZNbKIGNd1wnyyP/Ms2Y1tLNUCFysjaIWLP+rQt4vtypalBqYYM
	 I0e/MDGxfVD3X+0UOxTf7PJ6hwtX4DSZiiuYzr4G9pZ0DkFmH+21HSoXAqVhgIhr2y
	 zo8uXi2DVCyxNogKLik9E5TcSNrEPJmKHIIo4WpHBUiPmAKszp78s/FAvPQlqjG9BF
	 FKlCxXd9QiM4LWVLynylWeb94+bHhfXl/HMqFn/DV38j2ejGShzAvogtCgSIoHwVZW
	 eATAbo7Q3VnpQ==
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
Subject: [PATCH v7 09/22] dma-mapping: Add internal shared allocation attribute
Date: Wed,  1 Jul 2026 11:19:13 +0530
Message-ID: <20260701054926.825925-10-aneesh.kumar@kernel.org>
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

DMA_ATTR_CC_SHARED describes an existing DMA mapping whose backing memory
is already shared, or decrypted, for confidential computing. It is a
mapping attribute: callers use it to request a shared DMA address encoding
for memory that has already been prepared for shared DMA.

Allocation paths need a related but different state. Once the DMA core
decides that an allocation must use shared backing pages, the lower-level
allocation helpers need to select shared pools, decrypt newly allocated
pages, derive the DMA address with the shared-memory translation and
restore encryption on free. That state is internal to the DMA-mapping
implementation and should not be passed by drivers to dma_alloc_attrs().

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/core-api/dma-attributes.rst | 29 +++++++++++++++++++++++
 include/linux/dma-mapping.h               |  8 +++++++
 include/trace/events/dma.h                |  3 ++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 123c8468d58f..eee743184acd 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -179,3 +179,32 @@ interface when building their uAPIs, when possible.
 
 It must never be used in an in-kernel driver that only works with
 kernel memory.
+
+DMA_ATTR_CC_SHARED
+------------------
+
+This attribute indicates that a DMA mapping is shared, or decrypted, for
+confidential computing guests. For normal system memory, the caller must
+already have marked the memory decrypted with set_memory_decrypted(). CPU
+PTEs for the mapping must use pgprot_decrypted(), and the same shared
+semantic may be passed to a vIOMMU when it sets up the IOPTE.
+
+This attribute describes an existing mapping. It does not allocate shared
+backing pages and must not be passed to dma_alloc_attrs(). For MMIO, use
+this together with DMA_ATTR_MMIO to indicate shared MMIO. Unless
+DMA_ATTR_MMIO is provided, the mapping requires a struct page.
+
+__DMA_ATTR_ALLOC_CC_SHARED
+--------------------------
+
+This is an internal DMA-mapping attribute for confidential computing guests.
+It is used by allocation paths after the DMA core has determined that the
+backing pages must be shared, or decrypted. For example, the direct DMA and
+SWIOTLB allocation paths use it to select shared DMA pools, decrypt newly
+allocated pages, derive DMA addresses using the shared-memory translation, and
+restore encryption on free.
+
+__DMA_ATTR_ALLOC_CC_SHARED differs from DMA_ATTR_CC_SHARED in that it is not
+a caller-visible DMA API attribute. DMA_ATTR_CC_SHARED describes an
+already-shared mapping and requires the caller to have prepared normal
+system memory before mapping it.
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index cc0823a99cfd..a3e880649fa4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -103,6 +103,14 @@
  */
 #define DMA_ATTR_CC_SHARED	(1UL << 13)
 
+/*
+ * __DMA_ATTR_ALLOC_CC_SHARED: Internal DMA-mapping attribute used by
+ * allocation paths that create shared (decrypted) backing pages for
+ * confidential computing guests. Drivers must not pass this attribute to
+ * dma_alloc_attrs().
+ */
+#define __DMA_ATTR_ALLOC_CC_SHARED	(1UL << 14)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 31c9ddf72c9d..9df02c1511de 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -35,7 +35,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_MMIO, "MMIO" }, \
 		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
 		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
-		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
+		{ DMA_ATTR_CC_SHARED, "CC_SHARED" }, \
+		{ __DMA_ATTR_ALLOC_CC_SHARED, "ALLOC_CC_SHARED" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
-- 
2.43.0


