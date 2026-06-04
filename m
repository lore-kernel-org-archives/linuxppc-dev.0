Return-Path: <linuxppc-dev+bounces-22015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6365CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:42:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWJ3Z30TLz3bp7;
	Thu, 04 Jun 2026 18:42:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780562554;
	cv=none; b=HO3ZkEci3kIQDfkTcaLdpOtGCUi8Ldarvaqu7KIBsGDzF2RuuEZycR5MZmrpWbOVCe3YtCN8gXCcx3hTI2cIYPn9hmSBXBRL1mlRgFjutnh8/0AwTEF8VVDTf8JURFvK9N1g4UHH+EZbEVakCQ7GWKKJhes9kXuCND16kJnZ2KBXVkVIEFsdBSU4JMYue55cpKuuOk2gUcVDc460EP7l6HYRfGmgZARSLC85XeothmuPUQS61PQiprf6lL/IqNVJ7VafFfkfvOj7JxS822UypP/oLek8lKsYcQIOSOmCVDGXc4WrkEKJ5qXsF26Rrj6BJ1FHG04/agQSIj8m7VSElA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780562554; c=relaxed/relaxed;
	bh=8RqOZoZWEO6SeOB2Dx6VDRiy1MZJt2V2zJgzbuqAzxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ5jIdwJB1J57u4PLI7Unk5G3FxiT9mJyLoB/ys9nfeNNZzlY8N4WtJUf3/elxAoAhqcmw5z9dSIez6yS7JPfv/moqyDAxKsisE4/y0Tt3r/wpD6obLLEEYDRsnGUnaKIX0vmxl4dnx6c4yPoszn4gkmtijwvoCJRI7bceDAnFv342GbKhvLcbtUljwgVlMUn/ezmGdyNBvHQ8H051SuTpVysTCy/pVkYKpk9GxiUgXBE2+ACxoA+9HXGz6dE06PPxUOsUmYvZnUHDVAPSqr5WZIJfrZuiczk0phOKuggQtUkrdzxC7coyY4Ky8CSnSzx+W5/ofnPhzZcVAQIE3YSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVwvBUGl; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVwvBUGl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWJ3Y5j6bz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 18:42:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E60E7601D6;
	Thu,  4 Jun 2026 08:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A01F00898;
	Thu,  4 Jun 2026 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562551;
	bh=8RqOZoZWEO6SeOB2Dx6VDRiy1MZJt2V2zJgzbuqAzxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IVwvBUGl4YDJfsvKSMOpRRLu9z169sOpVXGOlzsJjuX3Lja/6J7Ym0aDhuyJpk9q/
	 Pwj8t+ZfHxry2X9UyTDAOecWvmygXTI7WYYPOORCoCIK6usXlD5ajDVD50sd+t2g+G
	 ykNn9OVAw+Cb+87vzbKgAL4tCIA3er6EHBms9OADHr5V7I0Uzij2bpY6SVxY4xK5sn
	 wnQwdH2eTCJpj0cdObPeW8Be7wcAxXJPicFwBeSmnY2tlfE7KhDJZ1ot5WB6r/UdHg
	 UttmA0BLx44bicDZJj4IMIg9+YfMzqXZvrAYKDqaSKYLTTC9sW3wT1O46HhnUxY/im
	 PKU7uTrrkRrKQ==
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
Subject: [PATCH v6 15/20] iommu/dma: Check atomic pool allocation result directly
Date: Thu,  4 Jun 2026 14:09:54 +0530
Message-ID: <20260604083959.1265923-16-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
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
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
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


