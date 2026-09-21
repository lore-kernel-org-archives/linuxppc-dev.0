Return-Path: <linuxppc-dev+bounces-27807-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C02C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 06:37:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpD764KTDz2ygK;
	Mon, 21 Sep 2026 16:37:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789972658;
	cv=none; b=hAwCdhkwrEWH7vH0CYhNNxmrcZVV+CzVutHGaBuwDLVjZcu61i7HqWrfVGO3Lmae/Ki9f+MbrtKqgPjnJ+BQSFeBfUH17eZpb8hZXzmH+URyo0nbHNDaw87qD/qPRfFiJ0p+3p8VCHSvt0u0TQ9A7Sf93ulFxbecojnP2CQBhyZuzsc72TtXwynIZ5hkgk2D6rp3RwSClTgcELNrowbUOU4myCzRNdG4UBusJbtEKRALiwrqLQ9X48p85Ur7jI/VJbb28nPWiM8yes4ouTQXBh+6J8dzL8kjFo2gM+ZVVq5A1KeAvuOT1roSRaAQCOmNlqsjYtdLNc5QDcVkp4VMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789972658; c=relaxed/relaxed;
	bh=K+b48+bUbw9Zp4TfNEQmI2aqQxUfqoVbbM+1xt10BLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gz/QwFbrprC4sDluyeCP5sOG9hulfjPEzaG/xe8iUFc2/Bb20gR2SXMoxFCpP8LG3vRFww2wBuCF0UbbYaDSn8Sr3dFe8v57OMOsOaHmZzvS3clRGjGzsGLnFyfJsnwDvbBn2HubEiKRVwpqoHdAQBbt/J/QxHxRLXl+e45sehmpebOB+TNZZw62Ig4tz6Z3iicPRdXl9ur5wyG1WjDkaCpu3sM7Hdm/rYZCcR3KYHH3ti92kUKmQPZjbC6d9Z7bWZJs8QdyqQdVC5z0bEv6geJ9erUyBzp83Zw6t5jLhB5bUZgfy6hz4Poga1NwazzetcoRo6L6buCLzTYNDmLGsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1lXqpcv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1lXqpcv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpD755H7kz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 16:37:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A13554031F;
	Mon, 21 Sep 2026 06:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096271F0089B;
	Mon, 21 Sep 2026 06:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972655;
	bh=K+b48+bUbw9Zp4TfNEQmI2aqQxUfqoVbbM+1xt10BLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i1lXqpcv+CPfidLk/96Fek4pilhGGmkGJ7Nr4F2IHCJJ6FuqR0PTsYqukoIkeg7gt
	 XEB9TgelNnrAWy/D50/VDHEv9mauRfXNtb4u80xZDG/3sIG+NIxMhNyTAwCt1FY/O4
	 758rYhWOpB4ZClrdEKI2yugVJBN9iGbpxqHZv8446bbnmfrCn+S1xVmOXvWyIe/17B
	 h8gETpRxuPbaozRiXDcHU9TPq4ltfM6zu83g6IuiarcsJqrjY4S8y1tgFU+5lKC1rv
	 ZuU3QfyH0StC3QqvAVG4LCTAwEFMRG1wXe65yq7rUqmD2xPy6QvChT0gB5/jz8a/Bb
	 JJoEXmVRzmg5Q==
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
Subject: [PATCH v5 3/6] dma: swiotlb: Centralize minimal pool sizing
Date: Mon, 21 Sep 2026 12:06:25 +0530
Message-ID: <20260921063628.362078-4-aneesh.kumar@kernel.org>
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

A default SWIOTLB pool used only for unaligned kmalloc bouncing can be
smaller than one required for limited DMA addressing. Arm64 and RISC-V
currently implement this sizing independently, using 1 MiB of SWIOTLB
space per GiB of RAM.

The SWIOTLB core now identifies this case with SWIOTLB_POOL_MINIMAL.
Size that policy in swiotlb_adjust_pool_size() and remove the
architecture-specific adjustments.

Explicit swiotlb= sizing remains unchanged because swiotlb_adjust_size()
preserves a user-configured size.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 11 -----------
 arch/riscv/mm/init.c |  4 ----
 kernel/dma/swiotlb.c | 11 ++++++++++-
 3 files changed, 10 insertions(+), 16 deletions(-)

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
index e0e4c103d603..96856114b387 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -183,10 +183,6 @@ void __init arch_mm_preinit(void)
 		 * memory when DRAM starts above dma32_phys_limit.  Allocate
 		 * ~1 MB per 1 GB of RAM.
 		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
-		swiotlb = true;
 		swiotlb_flags |= SWIOTLB_ANY;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8f86deb25be2..f368a73f4ed0 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,9 +483,18 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
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


