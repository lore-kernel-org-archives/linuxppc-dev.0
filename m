Return-Path: <linuxppc-dev+bounces-28088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C0DC98310
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 06:09:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr3Mb3rLRz30Tf;
	Thu, 24 Sep 2026 16:09:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790230187;
	cv=none; b=bn3rifWFR85kPS5KuB2YuFCkJex9gRyMp6m/3NtDoPbAfB2vCQAE3m/aF+ETJgLXU+NBxDHO9YoifCpMF2gmOdbGC5puEdekU8vlSNCtVYP3u10vDiaaDVRzwJ+Q5O/k3UbPjCFi3dbpyWY+G+kt9E5M6CQy4qc48+9u8OUUAAwNZbGYDK80OSR8VuPxSp4Rs1C9Os8MsSbu9zrqXsdZJ1aBqWFtFCI5NvhwQ0bAbhXJ2wiBWaDSZWHyN81uOjgeilmczdrBAJOjvHLU+fbqgcGCP+Pdavppc5H5pRYjq4RTTVqq1swbBa6nB/OtkwOgdwW9PdKoPyl5blplXpzgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790230187; c=relaxed/relaxed;
	bh=tusr1yJ0MgOFWnYBFAQROVz75fdWB9waVMwRJ7a9kV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjpS2N7fRHJUVvK/veiKbohDJ4fpPoeUuLvME21kBVmgHPGl5mpUr+wefVtX5gURUPnOn+R6Oug3SFV785T3uBVJ9buVkkVo4na1GMfoGgWIHKdJLwwCcJRmflZaxADKlPCbgIebBuXpu/hBjGfYO03mBarstnV4IWBgbfOcKw7jesZgSV9BktOcvLyEtFc6aA9fnX2ggaKN5aWmxKPTRinE1X8BGV8SxuA3Xux1dQ2U8/np6DN0SkanjZ6JLFf4+v4b4yJPKxLci8VwnZ6+obR2mm1KNVNBsicgL2fLwZyGbVDPKj1gEiwvShzLkiSb4cuyet9Zu6sgKW49zkM1yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCNOixZ1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCNOixZ1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr3MZ4m4Hz30TQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 16:09:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B050B60209;
	Thu, 24 Sep 2026 06:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16F91F000FF;
	Thu, 24 Sep 2026 06:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230184;
	bh=tusr1yJ0MgOFWnYBFAQROVz75fdWB9waVMwRJ7a9kV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DCNOixZ1Uff5UkaFVScwFmBw6mXUZbMx0tgzEzPPRjLmGZVot10iFQ0ssXfLbeo52
	 z7fTCAC0mZk2tXAEkEnMTDNkATIn8sbA9AO8GsxYR4xGD7P90W2FNMjkQysI1pf47w
	 LbD9PgYtrDtUxxVLrfl77xSmS8nUjRfRqlYI/5y+hUIgeSzBpFR3i8x1opZKu45s35
	 ezO3ufVmH5GDESRxdwtIbqlfidV30AS+NYPv2zC/MUFlnZR/aDK0wCzTU1HjyYV/Xe
	 9a8MCBjC42Bry8aSYtbpOkz3ae1A4V7BdqAyJoaZmvcPMeQ6W9CBkSe5SFYb4bt3g2
	 ho4cz+DiCI9Kw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 5/8] dma: swiotlb: Centralize minimal pool sizing
Date: Thu, 24 Sep 2026 11:37:53 +0530
Message-ID: <20260924060756.1325156-6-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
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

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 11 -----------
 arch/riscv/mm/init.c |  4 ----
 kernel/dma/swiotlb.c |  9 ++++++++-
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f55ebe57b8e1..95075b5c8207 100644
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
-		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
-	}
-
 	if (max_pfn > PFN_DOWN(arm64_dma_phys_limit))
 		flags |= SWIOTLB_INIT_ADDRESSING_LIMIT;
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2562cf45a8f2..96856114b387 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -183,10 +183,6 @@ void __init arch_mm_preinit(void)
 		 * memory when DRAM starts above dma32_phys_limit.  Allocate
 		 * ~1 MB per 1 GB of RAM.
 		 */
-		unsigned long size =
-			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
-		swiotlb_adjust_size(min(swiotlb_default_pool_size(), size));
-		swiotlb = true;
 		swiotlb_flags |= SWIOTLB_ANY;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ae315b2d0e7..75ee63cd354e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -469,9 +469,14 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
 static void __init
 swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
 {
+	unsigned long size;
+
 	switch (policy) {
 	case SWIOTLB_POOL_MINIMAL:
-		return;
+		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
+		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
+		size = min(swiotlb_default_pool_size(), size);
+		break;
 	case SWIOTLB_POOL_CC_GUEST:
 		return;
 	case SWIOTLB_POOL_NONE:
@@ -481,6 +486,8 @@ swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
 	default:
 		return;
 	}
+
+	swiotlb_adjust_size(size);
 }
 
 static enum swiotlb_pool_policy __init
-- 
2.43.0


