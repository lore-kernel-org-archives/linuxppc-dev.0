Return-Path: <linuxppc-dev+bounces-27809-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6BAC982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 06:38:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpD7c5HlKz2yK7;
	Mon, 21 Sep 2026 16:38:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789972684;
	cv=none; b=d0v+NNnhKk3epVlkmh6E3ebyUqDxWYnCs6Saat/bWSVRdZjR42Yp8fmYs9MoLrQpLLUaTofaTtf/CFduOLP+piY6PtmwhVcUyL3cBb/MIx/1y8uwvqOy3CH3ag5DBj+/jvbFOcz+C4iYW7z7bz9dyZTEKiIoeKwho4TgLU90tALrM9vEXw2MJhYbb8Er7zluHkiuCFitRzb/VmUgyq2rbXforO0kQ6wAZqGzyqpgDzTzlMq2gdFhLrKNVx93pC8RDNePfrQsEYOahDf2HCa0F1e9yr8j+X4Ju1vjb1THdLZ3kMuzRy9OLSRb70HZuHIFKoyOg76pQmyTOpaL04lnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789972684; c=relaxed/relaxed;
	bh=fFLFmWm1E4cYQvctfCBtN7dfMLeyqysLCL+XSA6T+I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKPvVeF3QNy5QrGSlvVGlA1TkF4rx1t6eWABtxD9U9/QTSYdXnFzh+izklzwrbIb2PXlc3ykrEgRXeg9SMYrpIYNkmUXb7hZdHiT00Pd3UwGmVbRXpOiMDoKZAqntcC3TGofD4+jS65kroQ593jubz4GOuka5Cu9BQ3vuSJSxIgfnL6SdAW/JdmwEQN5SS9qkMMjmsmoUcDPj6ara0B9pW/NW86kVdP/DXCHPRSsETr4H9GyucKSk3k5TivEwWd5x1PmYMZxG0L3+WpRHfoIUF6q79gBWUzB7Zc6LAmJfJubLELWrjSoQdK0TbK4ivCpHoXF6unaJ0Mary0DE6V15A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzMXPOCT; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzMXPOCT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpD7b6Pphz2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 16:38:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 102F0405BB;
	Mon, 21 Sep 2026 06:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2311F00893;
	Mon, 21 Sep 2026 06:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972681;
	bh=fFLFmWm1E4cYQvctfCBtN7dfMLeyqysLCL+XSA6T+I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZzMXPOCTNLT/Q06TPayEJbdJT7MQQSUndDMUDLI3EMDAYQ+ZfmB9ubQwVZW+enXMt
	 uT90JLd+XDvkd0sD6UcZZgSwd4/rSGIVYnHuOlGMF6f2zIm1TBOB3cllrOXnZwMF/P
	 1pJEuMwCRcF8JyzZRuK0U7VkO/lD2WKx+me+XlL8hLFUHKqX7y64RzH1AoYguyG2GU
	 FC4ngD0nR5T7IQWneSJer06E8CkgWGsL1FfDUbjCNF+4oqtNOBRAYegt1bngwv2fzp
	 t9y2vsjkaS7nevJRsRxHDS/J850Unx3q5CdI+f0YtOFCMlA/x5M0tQc/ZOJrn2O6yw
	 wrDjlEyssQp3w==
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
Subject: [PATCH v5 5/6] dma: swiotlb: Add an overridable architecture pool opt-out
Date: Mon, 21 Sep 2026 12:06:27 +0530
Message-ID: <20260921063628.362078-6-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921063628.362078-1-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
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

On x86, iommu=off historically prevented SWIOTLB initialization by not
setting SWIOTLB_INIT_ADDRESSING_LIMIT. This overloads that flag: it
controls both whether a pool is selected and where the pool is
allocated. If another requirement, swiotlb=force selects a pool
independently, omitting SWIOTLB_INIT_ADDRESSING_LIMIT may place it above
the addressable range of devices which need bounce buffering.

Add SWIOTLB_INIT_FORCE_DISABLE to let an architecture opt out of normal
pool initialization without discarding the pool placement constraints.

Unlike swiotlb_force_disable, which is set by swiotlb=noforce and
unconditionally prevents pool initialization, the new flag is an
architecture default. Explicit requirements such as memory encryption,
architecture remapping, or swiotlb=force take precedence over it.

iommu=soft retains SWIOTLB_INIT_ADDRESSING_LIMIT because it requests
software bounce buffering for devices whose DMA masks cannot address all
system memory. Such devices must be able to reach the bounce pool.

Clear both flags for Xen because Xen explicitly requires a remapped
SWIOTLB pool and may allocate it anywhere in directly mapped memory.

With no override, iommu=off disables both hardware IOMMU translation and
SWIOTLB bouncing. Direct DMA remains available; mappings outside a
device's addressable range fail instead of being bounced.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/kernel/pci-dma.c | 11 ++++++++---
 include/linux/swiotlb.h   |  2 ++
 kernel/dma/swiotlb.c      | 10 ++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 0cff255827ba..ce257b20ea9c 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -44,9 +44,13 @@ static unsigned int x86_swiotlb_flags;
 static void __init pci_swiotlb_detect(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
-		x86_swiotlb_enable = true;
+	if (no_iommu)
+		x86_swiotlb_flags |= SWIOTLB_INIT_DEFAULT_OFF;
+
+	if (max_possible_pfn > MAX_DMA32_PFN) {
 		x86_swiotlb_flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
+		if (!no_iommu)
+			x86_swiotlb_enable = true;
 	}
 
 	/*
@@ -84,7 +88,8 @@ static void __init pci_xen_swiotlb_init(void)
 		return;
 	x86_swiotlb_enable = true;
 	/* Xen can use a SWIOTLB pool anywhere in directly mapped memory. */
-	x86_swiotlb_flags &= ~SWIOTLB_INIT_ADDRESSING_LIMIT;
+	x86_swiotlb_flags &= ~(SWIOTLB_INIT_ADDRESSING_LIMIT |
+			       SWIOTLB_INIT_DEFAULT_OFF);
 	x86_swiotlb_flags |= SWIOTLB_INIT_REMAP | SWIOTLB_ANY;
 	swiotlb_init_remap(x86_swiotlb_flags, xen_swiotlb_fixup);
 	dma_ops = &xen_swiotlb_dma_ops;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index be3962a33fc6..466c33795db0 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -20,6 +20,8 @@ struct scatterlist;
 #define SWIOTLB_INIT_ADDRESSING_LIMIT	(1 << 2)
 /* Initialize a default-sized pool that requires architecture remapping. */
 #define SWIOTLB_INIT_REMAP		(1 << 3)
+/* Do not initialize a pool unless SWIOTLB is explicitly required. */
+#define SWIOTLB_INIT_DEFAULT_OFF		(1 << 4)
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19675846fc1..46b789eb0806 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -563,10 +563,16 @@ swiotlb_select_pool_policy(unsigned int flags)
 	if (flags & SWIOTLB_INIT_REMAP)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
+	if (swiotlb_force_bounce)
 		return SWIOTLB_POOL_DEFAULT;
 
-	if (swiotlb_force_bounce)
+	/*
+	 * Explicit requirements above override an architecture's default opt-out.
+	 */
+	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
+		return SWIOTLB_POOL_NONE;
+
+	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
 		return SWIOTLB_POOL_DEFAULT;
 
 	if (swiotlb_kmalloc_needs_bounce())
-- 
2.43.0


