Return-Path: <linuxppc-dev+bounces-22012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63499CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 08:42:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWJ330j8qz2ytv;
	Thu, 04 Jun 2026 18:42:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780562527;
	cv=none; b=Rv1i+DpnDXzDCKDFxasSAxb5JADQqtJZWkTqMZJC5DJTgimPLmJbvOSp9uyIVu/Ah98P3D0XPAcxt/nqSZ/jsdYMkWe/xaCGUkbZGxRZzGWBPy1IAHcGqsW1ws1biwOHiQpAGGwhyZvhrDwVfvDmBTwJ6HvAGLaJDVzI5+M7shDTxckhL2TCWT1Sdfh00kiYyt7rJtl17zBKuQTlwIqIMf8bQaAJLTuRwESQJy/sAWeRRW6iVZaZ0ERb3HiKRrHi9hoOvmvmnhaGB29SW2R1Ur3VDJ9ikkmS0TYxW52EdmgUK2APmyVnlc9JaQT5/FfOebbjPZIXrbMBPlghvBiCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780562527; c=relaxed/relaxed;
	bh=OmMSb/sy1rEjM9SAjzcclksqW5ZMYzL/SObxAZ/44zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOskbqDFmgvb1CqmCwpZDd+4cOssyPf8W+1mHT26pUMtXRxTZIGiDCQyOMEhLbFxgxtyEtUym3IrroNSHI/KXkiW0+lRoHhNgnmzyLIYT8GYUxWSioLkjqRfboTRhudzt50BX8FMc6fQ4p/SRlHT0FdbPX7UhbCry5DxqcLGzbTXQuko3313K488Ondo4fSk6MGU6tSX9DJGtNq5WY6PmVwi0i52IsMJ9hJOzkE5ODGhHV5eSHq/L5jY+IpYZlUf3IqigeHUJItJpgKgHPFIeJfhnZW+LU+cpo/8wgg0bwxAIuQrikT4p5QGiH3GTvnrD4HS4dAwxtDtUEkbBueNxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PR2wINvc; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PR2wINvc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWJ323hL4z2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 18:42:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C41A6014B;
	Thu,  4 Jun 2026 08:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9321F00893;
	Thu,  4 Jun 2026 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562524;
	bh=OmMSb/sy1rEjM9SAjzcclksqW5ZMYzL/SObxAZ/44zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PR2wINvcuAOCRRLqDiFxasw3MjrjE8q1zZJKgb6GlACxxyI7AggfIZ1AUHukout58
	 WFjBXmrh6RwbkLBn6pSMkJEaQopuR45jlhfYS3oahFNCnzXAqapiJ393CO2ZDBFk4E
	 VYBiXWP1I0u8vF03YGx5un0/AFc9L1A14lgEAy0GOt2Fd29lB7wucGQQU8IUjtRlm5
	 wFcSHwaELzMOYASOyvnArsQplSlvlQjzzbjusg4Ltyj1pPMnwYWaQ6yqYbTDLXPI0w
	 k0OfdwRk+Aqa3jCdEnMpKEHGvUB6CZX/l7uFNqMZxzFd477Q8eWUY7nQQFufeSVeL1
	 WX93aDw8L+vRQ==
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
Subject: [PATCH v6 12/20] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Thu,  4 Jun 2026 14:09:51 +0530
Message-ID: <20260604083959.1265923-13-aneesh.kumar@kernel.org>
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

atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled.

When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
such as gen_pool_add_virt(), jump to remove_mapping and return without
freeing the pages.

Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
that cleanup paths always release the allocation.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index be78474a6c49..e7df8d279e75 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -146,9 +146,9 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
+#endif
 	if (!leak_pages)
 		__free_pages(page, order);
-#endif
 out:
 	return ret;
 }
-- 
2.43.0


