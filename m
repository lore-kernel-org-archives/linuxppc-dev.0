Return-Path: <linuxppc-dev+bounces-23269-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C7AC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:53:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqq2N0X9Fz2yfS;
	Wed, 01 Jul 2026 15:53:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782885228;
	cv=none; b=HylQVbAxW7y1RtRClFP3rb4t8kqQlRHT5qOqvd9945iNiMHI1CT8MFar3MupRDlam1U76mfy9mxnbou1vbHVA81gu15Tu7IDtpJ4t5GufJBwNDuaCXYM0vyULZItvag1JywtNcL5tYvty35vi5tghqpGuUSSJHGsQtAF6dJDrgj660PNzGM/AboGCBzh6tuT12Ut3lvkoXMJfnNOG6ETp5ZS7jr/UqV8/tvGoswyLLeB9eKHVHZdvVwH42rrEJkDrZTq6GXB6h+039ZBii0sSGW4OPwV7+oP0c3htzy/SCMnZ5B7ryVexyvPjGPM32rgzzd1j97KY6a7gcGI+TKHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782885228; c=relaxed/relaxed;
	bh=s22aUv759o7jOuYTf2EHjxStbcsNFUSunZW4b9jUGRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2tVU38tcLsarQEXsISdGBvAlNjtwbfEbSx97jU89z8w68jR+u1JZ8H0to9M0I3HdmMQQLRxcdd6t7dtAUkzyAYtcqhOolVF2XrWqa/VnjRd9TIhUtZdVKK0fR/ZRR5EVUuVfo494NQkzEgh0RVKWkKMNgJvSdh03rLsjKpohOpRwhVnamNL/jnaOUdKmwRSAsQm4MQXvi8KxwUOFJPMI0kK45me4lbwSClG76eq+ygjuenl9idw7Tjwd5gF+OpxFGJB+l3SIjWo/ef+kocTFV/LyEWCV+KhYz6RhGyP176AQoknZ67/Ij7n1M2/df2c+9YVPwXKnhTqLOiJpIcAZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4vj3mIC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4vj3mIC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqq2M3gkJz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:53:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D950243720;
	Wed,  1 Jul 2026 05:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14681F000E9;
	Wed,  1 Jul 2026 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885225;
	bh=s22aUv759o7jOuYTf2EHjxStbcsNFUSunZW4b9jUGRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4vj3mICqCBG5J6Qz1J6ZL/CdmqQL9ug/kU7JGVQcXS/8c208ZLND9bS6m7eybLO3
	 wRL6NLoxPnyItyX6BkBvidUfufZTBjxayOXlZzNA2azgv4I1eWOEZB2TaqCfWlcnQC
	 Lhg+GmezbOHy6Z7trc8XjTQcmIocngXXawx1bfAk7MzOh6wGLGd6dsiULHFTHsgGUi
	 mAHVzEmlUlVthSQ+H6gHh09sCL2AdPHYDtYkKMEzikE7XJmHgMtxeB0B3Yh2RRNl9u
	 b1gMBtydG6RDBRmQfYyjayYc7c0SSo+Et5Q5wau0fZfwIuCBXoBqwuXpFpy3E3b5vi
	 XcxBdGsO01mCg==
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
Subject: [PATCH v7 22/22] swiotlb: remove unused SWIOTLB_FORCE flag
Date: Wed,  1 Jul 2026 11:19:26 +0530
Message-ID: <20260701054926.825925-23-aneesh.kumar@kernel.org>
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

SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
controlled through the swiotlb=force command line option via
swiotlb_force_bounce.

Remove the unused flag and simplify the force_bounce initialization.

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


