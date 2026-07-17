Return-Path: <linuxppc-dev+bounces-24361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B52DC44515
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 18:05:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1yWQ6mV9z3c2v;
	Sat, 18 Jul 2026 04:05:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784311538;
	cv=none; b=DC1HNfNG7tEAhkJse/V4Tvpro+Jam0aiigZYKLeB5ynADAA91F32FDM7sPGOXEH8OZ0ksastLbDyf1hD0UOw/sygGc1QEkte8i+LMHuOqkwuHBDsnIbAjq5Hk4w9y/P3I6NWZhFn6JIV7NI6d6i+YhHa0xk7Pem8hjSIb+hylsaQZO2YxeBzBP6CtcFzrqIJHociUKSfhkzetBO12v47APZ6eVwu5iAzHP6p0Q+XKfuRmXE7QAOlOpXMHfy/8MpDfajeBX/6xzRzT4ploGSVP6VbV+oh0cx/A8f1XIxsTf2Tu3RRQBOgX6o7WQTis5aoFAxc2dhpLLxaQgt/M5Xc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784311538; c=relaxed/relaxed;
	bh=6JAWb8OTjOFId3JccbNdiGr1f8/BydsRdPfwaJAJRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo58Gb0q8mZ9W4+TGhi0PH09u1AZW7efw6i60P5tTSGvMGKcsHLxkcPhWSmlJlcDahOSzP0cux20gnFaoyYO07ilF6uwCXdatgAKTqforqWxU3ItfsaLvyTdkApp6RanAxBQJutxNxVV7Sv3q/ztX5/Y9o+YJkjACf2zTctjBssr2phPb061sx9+j0NE/gP+D0bzEt7yGKI4ZArc8QMGimggbRs8Z2gtWQmLqQl3GqYdLEPM5Hy3N2t9fsgpLjw5qjA96GFUJkJA+owkWmR5jBduO1BZKnoHaICpVLTgzWSrq7Qakk3k9sci22A0LgQtQmKKu7uTEa9BuA15XjUSXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiVA0z2H; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PiVA0z2H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1yWQ1Hkdz3c2q
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 04:05:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A5FCF43987;
	Fri, 17 Jul 2026 18:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BB81F00A3D;
	Fri, 17 Jul 2026 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311536;
	bh=6JAWb8OTjOFId3JccbNdiGr1f8/BydsRdPfwaJAJRw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PiVA0z2H4Snzd6lFwW/aQE3N8yGaK1f96qr9raHxxnqHLOyMqLswOfAV3OmODRrA7
	 KWUigEa1nQENHkk2fpPUawIZcoNGzZNukyqTGX742GZmzNW6aE5IMprZ53p8Gl0ReC
	 PMiHzCvvyGrqH1+lS0m8KzVFNwiaw7wxbBglg+5j0c4X9d5VMAV2b8SiIO55sh8C1J
	 rRegbQR7pFr11wRS4d3YTLrh7NmJTjul0aBRX04PN8ZcVlAgfLB053IG6duvKqH9/Q
	 QbgfQb2XG57vWlQvnpcQYOqY+7NpdXzDTtJ0ZtvQWUXoQjjlNO9YmGnJeWLKkp7rqQ
	 O0E8L88PGpcHA==
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
Subject: [PATCH v8 03/23] iommu/dma: Check atomic pool allocation result directly
Date: Fri, 17 Jul 2026 23:34:21 +0530
Message-ID: <20260717180442.110954-4-aneesh.kumar@kernel.org>
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

The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
which returns the allocated page and fills cpu_addr only on success.

Do not rely on cpu_addr to detect allocation failure in this path. Check
the returned page directly before using it for the IOMMU mapping.

Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5598ed4bff72..6a45acbbfb0c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1671,13 +1671,16 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !gfpflags_allow_blocking(gfp) && !coherent)
+	    !gfpflags_allow_blocking(gfp) && !coherent) {
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-					       gfp, NULL);
-	else
+					   gfp, NULL);
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


