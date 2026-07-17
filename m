Return-Path: <linuxppc-dev+bounces-24381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744A6C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 18:09:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1ybv6HPnz3c9k;
	Sat, 18 Jul 2026 04:09:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784311771;
	cv=none; b=oqs0HqAjpJtdkDj0/RtsOfiWWjkO1rmTCf8UDXB77HXEyif+AtAKZQLumAaCjpUlNsnXuClcBtGNMK5NrV498EHVJTrhMR8n5pJ3GTpO8D0kT4gTR/+MtG7GFX18bm+s1iqHVgDXixYidU4KcHYbaILZARKGdZSx1YET0M/I3YponOlzd71bDtg5Rr0D/LWGmOpAEoyu24dw47T2ck6XFlCGpJNcoWX9lKGziKroPFsTHKn69U03iCyVEorAP1f5WaTClmAkXA2HPgL0WjwOFT+qqp2IElAJ0dnr/cenXOxp16J4goEJj31fXPRPDxWt4V25fDsKd57iiduNzOO+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784311771; c=relaxed/relaxed;
	bh=tkXR0ipZ7ma+5T3tic3bVYqHfLRJ5/MS0548pdfa6Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SezRcyaGISM0p+eu6rYt4Bl6ykAhyxZEq3DyAiQUzKm00lGLIR7DxPL50WlSkaNf7/JI0I4qtWAvIroaktRhDSBhZ0gN4ImdSdB2IUIbNB1LCCdJfDSz46zE3jdJ+KlR+YeLtYEOm0wqfEjgKD7rcDQOZkGryhgGOruhdtbBlaQEm/TPDLvFW5/ZIDt6tYQO9/unUsE87W5/p8VpH2gjWj37dzRh6M9Qf7eq1hJjKjE4R0paUedrXd+vDWxSL4Z++P/DgjkG5YeNUTvMDAwqnq+ltHRIWu7Y1bYDIctdykUXiMmZNnp04t/fB5E5YgWuKk5DpZF4YR3UIa6p0hkjzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKEaTtkj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKEaTtkj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1ybv0FVmz3c9j
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 04:09:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 13D5560A6D;
	Fri, 17 Jul 2026 18:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CFE1F00A3A;
	Fri, 17 Jul 2026 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311768;
	bh=tkXR0ipZ7ma+5T3tic3bVYqHfLRJ5/MS0548pdfa6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKEaTtkjlsYTecPUwUZYY5boRz8Hl5p9D2dk5Y5OHE5V+KrdaCWiMHICIVvyeZo8l
	 bfDENN6CkL/X2Nhd1Dhikwp79Ii7RZhp6+TdbxOWmncy5evwDeUC0PrecgKYvOfJ2i
	 z5t5X7pIAq2lJxusYJVvtvqityS5Yt1NuT1GCEYBv/ZX+VxYwD85Oz7Abz4+1TQJdX
	 wcai+O3Dp9MiHid7sAM+sdbkz+TE4Ihrj2BOXgkzKovblm2cKclw8oi9o7WFLwiD3J
	 OUQsZBxyG2lJSEe2eHv3+KJZZXFXBOwVqSpI2S4/WrMB2IqHdqF6IqWNhGaswGM9hg
	 XgoRYSziMoMAQ==
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 23/23] swiotlb: remove unused SWIOTLB_FORCE flag
Date: Fri, 17 Jul 2026 23:34:41 +0530
Message-ID: <20260717180442.110954-24-aneesh.kumar@kernel.org>
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

SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
controlled through the swiotlb=force command line option via
swiotlb_force_bounce.

Remove the unused flag and simplify the force_bounce initialization.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/swiotlb.h | 3 +--
 kernel/dma/swiotlb.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c3bf7ed6f7a6..9caca923c380 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,8 +15,7 @@ struct page;
 struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
-#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
-#define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
+#define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8b7e47504304..897aba538c5b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -400,8 +400,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
-	io_tlb_default_mem.force_bounce =
-		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
-- 
2.43.0


