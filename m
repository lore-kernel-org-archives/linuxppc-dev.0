Return-Path: <linuxppc-dev+bounces-25550-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B28C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 09:26:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGf0k16BTz3c2K;
	Fri, 07 Aug 2026 19:26:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786094790;
	cv=none; b=PX9a9xDSfxU/dXUMiuaub2IGnJpCGAY2D11/cL/Rwhq9VcudNr+gnMyhLRuGyfxMtDdhpzvpEN247gA8qfYgxuGY0OT6s1sUPb2bEhlWsFQb7tHhjO3C+rHzohDOYgCTHftG6SMVVCkObata2JqFSR/PSRVz2YyFKVdfVf1yoS1ylTAimGwpcnjHbiN4rkKqRXpaHsKxfJ5T3HX7iVFchLzV2ObudJtpKTuAU4tSsgHES2iaSl15S5ZeXjn4fT5R7VE2qVU1zDj2mpvE/EEWuJe9wRt9oiqTr3hzxHv22jLDE3y6ToL5kewTmaXlSsg9659pPhLJ0qJ9wwVgW1mcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786094790; c=relaxed/relaxed;
	bh=n1DOBxxHQjvAtdVCr2XmzOoDCY/LkKFWumLIHDVnml4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5x7fsH+WIfGgFVrud0CQfrGkZzK0g6poacrndRAXI3/nySCW/H5EKoY/yr1gq//FNVZUhX44bkY9cXvOpt8Q+eMCIHxVFPJjspQ+wilwsFcPOUlbjh3kX4TUO8MgnKL1EGqQv+ZnE8HSNEwzy7AttvDRpVETrJ6Sa+5OSz+QuAFAaBwcMlakjD4s3xg+fA/0ny7sN9mc6mVUH2LIYUXDpb84IAGa6R1/r/35U5Dbyi4SjQ8P1gPG2dItGl1EDDG1qJHCojKF/hmxiLpuObGMRAdHjZ0q9+9mvG/VvC/FyY1grCNyUv9s/GynC7/xmv71nqe3ssLb/7n29MMRAgClQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfRd+7a/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KfRd+7a/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGf0j3lZMz3c1D
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 19:26:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5464760AB0;
	Fri,  7 Aug 2026 09:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F61F000E9;
	Fri,  7 Aug 2026 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094786;
	bh=n1DOBxxHQjvAtdVCr2XmzOoDCY/LkKFWumLIHDVnml4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfRd+7a/nQO5IHNyvsOPwguzYdeKqDRBtEiWacDi8mGZTtLnEJKuLyO6lsWudhrXX
	 Vjjh9c97Ixvp/GYuP/+8kczArrIotpjs+kee9O4So34wX1//sc1uZ4vU5zKkxj5o8C
	 ybxndGlgdAlKbBuROyiRVYbKZnwpCrnt+bqJe/XwtNOLHjc6fybJgRFYODdA3/hHsd
	 1iBuJRXBPFB4CfqFWpvLpZJSf3wPTHCNFxEieHBehqy968HIRk80iepSvtieSEy2DJ
	 OqfvvdvfLrRXVQ4vx9/D1V+LE6LR6bnyPivnccbVVWDr5bA4t1vmy5GyKPlCdC5712
	 NlmIj347nR/FQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
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
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH] arm64: swiotlb: Keep the default size for protected guests
Date: Fri,  7 Aug 2026 14:56:12 +0530
Message-ID: <20260807092612.2202005-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-18-aneesh.kumar@kernel.org>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
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

Realm guests and protected KVM guests may require swiotlb for device DMA
even when all system RAM is addressable by the DMA zones.

Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
guests, as the reduced number of slots can be exhausted during CCA guest
operation.

Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e308a7cabd12..24caaf10e755 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
-- 
2.43.0


