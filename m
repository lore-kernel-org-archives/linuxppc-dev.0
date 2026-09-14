Return-Path: <linuxppc-dev+bounces-27197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D065C88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:02:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjx1H3XKYz30Lw;
	Mon, 14 Sep 2026 17:02:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789369363;
	cv=none; b=JdMHQGRlex3qFMat22NCR9EcdTSjOJMkBntXzgpbIqWAHEwP1tet1t9M4dCTOzUDoO/7jIEp5vmy6I0YtcYbisLrx/ztIzyxwBu0368JDthH2U6lnZI8JwbyqhFC/3EAU8jTr6BG/rWaXmrTCHiWogheQDpabcforyrnc+XqS54yERIRgYANoby/8ccpEXAActqQAavsY+zCfT6Mh9T76fWSaznDY1lDKN6nybWl4XylBOvj/94mPbG6LqnoNTeunNUkEVykQog1YFkLpAh4SAbfOZ/2x+BL1zQ+1tJ0h1yVMcrvTyJ3/+sGEUwZ4WkwPdiuYtr4JeoWdjl4rF2vWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789369363; c=relaxed/relaxed;
	bh=x/3HHuzVNx7bnN1ihAdxW0VYZ7WW0MmVjDxqeSNWa6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPV//BqGvwwwzaqYLnQE4MP2lclAEZk+cArxrhoKjbcoC5lD3pxSqJPGShKdxfwEMGlQg4hltN/IlZq35bsEeRgXlHUhe9y6YhdRaTtSHKyfSWb2vk4sZQ+bwYXYZ6q8291vcW91WZu/PHphGRUZaZoJOfIYy4eNJPI3+SXsekCvffIACgkm6EEzEPtgqGg6BNKj6VFoJDzKSoY9hKkFKjimY6TcaKiXRmKtGL4ABqf5p7xMUFPrmNzkTvZJu412ADtryks+sIjUZA8T983d+ZG04mAQJDKqxIhgvvwr8fTA5juG75Dj7qK/OZNxM4WJzt6s5G7jReivATp91SbCxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ytm3AkCw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ytm3AkCw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjx1G4zK5z2yln
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:02:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D53FE4181A;
	Mon, 14 Sep 2026 07:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48331F00893;
	Mon, 14 Sep 2026 07:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789369360;
	bh=x/3HHuzVNx7bnN1ihAdxW0VYZ7WW0MmVjDxqeSNWa6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ytm3AkCwSvjvCcrN3ZF//ngq6yIBw6+I+v5QtNlcXv0wNUy6MLRc/S9+Iof8AXsBS
	 dbicnLQgv7BgX09r+7c1JpSYD3VTsHoI4ZsatvaYbPJ0HHQDZRkGSN2tdThTINgAkZ
	 2Uifqnt3Xlj1QAAbT7snma0EDr43TLWf1Z8MrYlrRTkmaKcv4preGOOCu3mOQh2As+
	 2k7/yiOlBb+0xkJg8D+kJBGSE5Yxba2mx94h7IQq+ZHMmBddUVlKwknqp/9GMRguKv
	 GUoS2ZcMQrAnAAWJ0RfGcq0Go7zU0j9V5jitLdu3Fuih8ORLZWyvYVJjE+UHCJVTsM
	 iGCCsPWM0HYLw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
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
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 2/5] dma: swiotlb: Centralize minimal pool sizing
Date: Mon, 14 Sep 2026 12:31:31 +0530
Message-ID: <20260914070135.313337-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914070135.313337-1-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
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

A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
smaller than one required for limited DMA addressing. Arm64 and RISC-V
currently implement this sizing independently, using 1 MiB of SWIOTLB
space per GiB of RAM.

The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
Size that policy in swiotlb_adjust_pool_size() and remove the
architecture-specific adjustments.

Explicit swiotlb= sizing remains unchanged because swiotlb_adjust_size()
preserves a user-configured size.

NOTE: We lose the RISC-V SWIOTLB_ANY setting in this patch. It will be
reinstated in a follow-up patch where we make SWIOTLB_ANY redundant.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 11 -----------
 arch/riscv/mm/init.c | 20 --------------------
 kernel/dma/swiotlb.c | 18 ++++++++++++++++--
 3 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7d51fb5f5a71..95075b5c8207 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -340,17 +340,6 @@ void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
-		/*
-		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
-		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
-		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
-	}
-
 	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e0e4c103d603..734712230f35 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -165,31 +165,11 @@ static void print_vm_layout(void) { }
 
 void __init arch_mm_preinit(void)
 {
-	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit) &&
-		       memblock_start_of_DRAM() < dma32_phys_limit;
 	unsigned int swiotlb_flags = SWIOTLB_VERBOSE;
 #ifdef CONFIG_FLATMEM
 	BUG_ON(!mem_map);
 #endif /* CONFIG_FLATMEM */
 
-	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
-	    dma_cache_alignment != 1) {
-		/*
-		 * No 32-bit DMA bouncing needed (either all DRAM is within
-		 * the 32-bit limit, or it all starts above it), but
-		 * kmalloc() buffers whose sizes are not cache-line-aligned
-		 * still require bouncing for non-coherent DMA.  Use
-		 * SWIOTLB_ANY so that the buffer can be allocated from high
-		 * memory when DRAM starts above dma32_phys_limit.  Allocate
-		 * ~1 MB per 1 GB of RAM.
-		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
-		swiotlb = true;
-		swiotlb_flags |= SWIOTLB_ANY;
-	}
-
 	if ((max_pfn > PFN_DOWN(dma32_phys_limit)) &&
 	     (memblock_start_of_DRAM() < dma32_phys_limit))
 		swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aa19e81ae544..90e0bfd0715c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -304,6 +304,11 @@ unsigned long swiotlb_size_or_default(void)
 	return default_nslabs << IO_TLB_SHIFT;
 }
 
+static bool __init swiotlb_default_size_changed(void)
+{
+	return default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
+}
+
 void __init swiotlb_adjust_size(unsigned long size)
 {
 	/*
@@ -311,7 +316,7 @@ void __init swiotlb_adjust_size(unsigned long size)
 	 * architectures such as those supporting memory encryption to
 	 * adjust/expand SWIOTLB size for their use.
 	 */
-	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
+	if (swiotlb_default_size_changed())
 		return;
 
 	default_nslabs = swiotlb_aligned_nslabs(size);
@@ -476,9 +481,18 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
 static void __init
 swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
 {
+	if (swiotlb_default_size_changed())
+		return;
+
 	switch (policy) {
-	case SWIOTLB_POOL_MINIMAL:
+	case SWIOTLB_POOL_MINIMAL: {
+		unsigned long size;
+
+		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
+		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
+		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
 		break;
+	}
 	case SWIOTLB_POOL_CC_GUEST:
 		break;
 	case SWIOTLB_POOL_NONE:
-- 
2.43.0


