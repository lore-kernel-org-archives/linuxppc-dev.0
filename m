Return-Path: <linuxppc-dev+bounces-20781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0995BCD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 09:07:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9hS5CRmz2yvH;
	Tue, 12 May 2026 19:07:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778576824;
	cv=none; b=md8HZSNqQo4Av0A7k4sylEBqW4VXqg3zjH2P4DkNP4Ve+Vs4LXn/FwOKOGlT9XOd2fjKgABOacTjt/9YZpLIT0iwcHgnFoiXEZ51729XYad2aIm4de7oSEoQn0/12iLBs61Z4E0x//FqNAK1JI0eBx5N1LzynowQ0/ScmU/8R2vPsXYhl4nUUJBlD6IjCfSmUbqvXvw5Gfyl5npAcythCI6eh1sQcDxE7Brjh37w1lX5g3C4pmMviKNsGxf0Mre+t2GHUYf1GTtXLzsS/hRk/lDR1Pm5r4a/FSsp25A4+MjgmUEn9QoSoFALH+RiPT6SC+3YzZ8eknw67BtQCj7Fng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778576824; c=relaxed/relaxed;
	bh=KpCb7a3H9F8F15EmfeMLTB4Sq6tRF6n/NPt9w2wubf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfnbgvU/gEaAXwHfAdzfFWEceR1F+tKymcSmBBUogH4RrKwkB0ATvhkOC1QUvEP45TLL6vBFMR3y0Gto+O0t1n08F0JiMKl3dIXMLYoRlfkA2it3Bno37zRgyhkDG1lwsRAAoZ7YsQKG8zggzUHvr+e8KrixX0h7Y/w/z5tCkKAKCgpDkj14K9luAj4J0mTwnawfEFKy0oiLhbQGTqYiui5s4k50HYKi+QLCRiMmr1LLhmKSot0guP6aSOt2W5YcAyNWmEuAk0KHvcWC83q9h/hybG123BT7zfQFzIg7k5SCw8KLOS9SmJuoXfTj2x69UGAxVKNLeqb7iJNWonpOKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GYt8EqYI; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GYt8EqYI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9hR5NDyz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 19:07:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C1FE43D35;
	Tue, 12 May 2026 09:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33B4C4AF0B;
	Tue, 12 May 2026 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576822;
	bh=SSIb9AffiyCb4tbfwh2yXw5+hoFTxTK0yIF3uaiiYAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYt8EqYIRUIaavvPuaPJBda78vHlfhOtAKKCeYDhg/engtvJHFapVeF+Ah9i0/FJE
	 fmqDPRJJt7SSe8N9iKzSLfWg1ueFG/uoakkMNldaxV0NBL8W795piGnbSbOjFxer3x
	 tHzfEvWrtUMhKxo/JyVufOYkwYsug6srjyXOEIjelTyvy9oZ/2taZiPlIsn2rzbK3O
	 RiLHESdmu1hBj05ocJaxuEA7CLneYuZT5I0BkcjWHL1PfZiP2VuP1VgdVY++Z4b7Lu
	 bhpIZ1gADFwea0mdzaZWhQa/8g6VijT0S7COzlnLvOSszVAynSv150Z4ZnbbeAHNjR
	 D6fbBzbPj/3lw==
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
Subject: [PATCH v4 13/13] x86/amd-gart: preserve the direct DMA address until GART mapping succeeds
Date: Tue, 12 May 2026 14:34:08 +0530
Message-ID: <20260512090408.794195-14-aneesh.kumar@kernel.org>
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

gart_alloc_coherent() first allocates memory through dma_direct_alloc(),
which returns a direct-mapped DMA address in dma_addr. When force_iommu is
enabled, the buffer is then remapped.

Do not overwrite dma_addr before dma_map_area() has succeeded. Keep the
dma_map_area result in a temporary variable so the direct DMA address
remains available for dma_direct_free() on the error path.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/kernel/amd_gart_64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index b5f1f031d45b..a109649c5649 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -467,18 +467,20 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		    gfp_t flag, unsigned long attrs)
 {
 	void *vaddr;
+	dma_addr_t dma_map_addr;
 
 	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
 	if (!vaddr ||
 	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		return vaddr;
 
-	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
-				 DMA_BIDIRECTIONAL,
-				 (1UL << get_order(size)) - 1, attrs);
+	dma_map_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
+				     DMA_BIDIRECTIONAL,
+				     (1UL << get_order(size)) - 1, attrs);
 	flush_gart();
-	if (unlikely(*dma_addr == DMA_MAPPING_ERROR))
+	if (unlikely(dma_map_addr == DMA_MAPPING_ERROR))
 		goto out_free;
+	*dma_addr = dma_map_addr;
 	return vaddr;
 out_free:
 	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
-- 
2.43.0


