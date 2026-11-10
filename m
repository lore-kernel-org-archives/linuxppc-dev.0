Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950F606B9E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rBvgoobj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP20y41stz3f1d;
	Tue, 10 Nov 2026 20:49:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794304146;
	cv=none; b=V2fvOff6lFOTJII0aWas/JDHVZqgT8RkDjAfNcCjF31XlATG1rXLt9mOKR19LwdfQEF3iFYT2UFqEY5s6Y7FS+pdFArK9bLnk1kWdGNhgiMr7wnY4u4PaxLLknx7HXB1lFKRy1nl8Ub4DPJIONEuQgOIr/D1XYAIH7FT0VdnMLGxIA9aCCDZduYZKz29qjdsma0SKz+KfbudDHWlIsFi8Cngk9KqnE7CbARAc+h8qO03kJBKIwVvuQkEIabHKbODHAzlLQgIGEeJWsMJgw+nlqb5Iz/kwueFVooXGs7XGphqPap5+WwVIkUBhQcIEPWTH2ZVxgyBiHphDhqnjXfP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794304146; c=relaxed/relaxed;
	bh=lTLmtK31hw/UKLvDWxom2CDHYzIzwP+MZGBxJv6sbMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=in9zplzLkfcO+Bc4MzJlF0X3vNMnnjG1fHFto3/pUujqlzzrdt6yHuSYqdi00mYIAPus6E+DA9VITt8yDsXUX4aN9lEoejrAM1rQduELl9qidAvYTyW6uCReE/0RZDW0qLbR4kgNPRlM3Rq6Sbw57hotWZt85p1cRzerNYQ08I9rf/tQjRAQasT456Wp+3RzwwHlysesKse7Ge9lee1eItnUbVrjyiPP9d8Emc5PauUkQ6eqgXV0/lm7g66/e/+gY+nv8huxKZgAl4BF7o1Y2R6gNncTC9FBCVjTkUxGU2jsKzviilTUpjcb0h6/uad1Q6h1mScRjs8IhAQ2ddUl9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rBvgoobj; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rBvgoobj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP20q513tz3dpC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:48:59 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094849euoutp02c7b68c42a4764eeb4187ad8d81989f59~mphl1RH_z2843628436euoutp02b
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261110094849euoutp02c7b68c42a4764eeb4187ad8d81989f59~mphl1RH_z2843628436euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304129;
	bh=lTLmtK31hw/UKLvDWxom2CDHYzIzwP+MZGBxJv6sbMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBvgoobjlJlSBCWbgyIn+0BHY3I5ZjRZ4jeQHB4eksmAQ90VrUq0QYbP/5c4xEzds
	 TqefGzLHCZLJ58dgN8NQ1oy4aGRC4qLk4xRCEmM7zf9LDNBOhoiv/9Sor1CglY6New
	 6xLOyiOYuWtnm9DarBCavT/aiczJ5k9FsBAUYiJU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be~mphliOKVy2669326693eucas1p2b;
	Tue, 10 Nov 2026 09:48:49 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094848eusmtip19361ff8ec94d0397d58e26e0d22b3e37~mphkzEaCR3235732357eusmtip1c;
	Tue, 10 Nov 2026 09:48:48 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 3/7] MIPS: mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Tue, 10 Nov 2026 10:48:23 +0100
Message-ID: <20261110094830.2081847-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110094830.2081847-1-m.szyprowski@samsung.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be
X-EPHeader: CA
X-CMS-RootMailID: 20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be@eucas1p2.samsung.com>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

arch_dma_prep_coherent() performs the cache maintenance on the address
returned by page_address(). On 32-bit MIPS with CONFIG_HIGHMEM the kernel
uses HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem
page that is not kmapped, and dma_cache_wback_inv() then operates on
the virtual range starting at 0 instead of the buffer, leaving any dirty
cache lines of the buffer in place.

Highmem pages do reach this function: dma_alloc_contiguous() can return
a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
path and calling arch_dma_prep_coherent() on that page before creating
the uncached mapping. Since commit f5ff79fddf0e ("dma-mapping: remove
CONFIG_DMA_REMAP") this path is available on all MMU architectures,
including MIPS, which previously rejected highmem CMA pages.

Fix this by reusing dma_sync_phys(), which already handles highmem pages
by mapping them one page at a time with kmap_atomic(). For lowmem pages
it does a single dma_cache_wback_inv() over the whole range, so the
behaviour is unchanged there.

Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/mips/mm/dma-noncoherent.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 30ef3e247eb7..d8e5bc85bb3b 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -44,11 +44,6 @@ static inline bool cpu_needs_post_dma_flush(void)
 	}
 }
 
-void arch_dma_prep_coherent(struct page *page, size_t size)
-{
-	dma_cache_wback_inv((unsigned long)page_address(page), size);
-}
-
 void *arch_dma_set_uncached(void *addr, size_t size)
 {
 	return (void *)(__pa(addr) + UNCAC_BASE);
@@ -127,6 +122,11 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 	dma_sync_phys(paddr, size, dir, true);
 }
 
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	dma_sync_phys(page_to_phys(page), size, DMA_BIDIRECTIONAL, true);
+}
+
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
-- 
2.43.0


