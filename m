Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC40606A32D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VNsZdypM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLvh54cpYz2yh4;
	Sat, 07 Nov 2026 09:57:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794005829;
	cv=none; b=FEkeEL7oQnPpghpbSe2/TFlEOhU7yDSzYjdk0c3EoDAEiYiGTOPp/ToKiQzzkOFaNnZSWZ098VMupxj4aA4usVjUG1rhKMDx3jGdCX/sSj+0EemWeZWqxvMct/k5zj2VxVPwoMKJMGtojnILi0suF6BEoq/s0fTTiwKUfM6C/a6ejIno+Go0c7Bim0vE6TqIxz/JvufgJjTZnFi1wsWeSBA+CFqsA4X1HvJqajXyhAbrPmcu5G3e19j/qSZARI4uZPzFSFG6FoyLzpCggZsdCQCgPxS44M6DrNbXr8QIdcQ/coLl4N1JZeOCzG6VFt8AZBSFcD42G/uDDLqdegw8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794005829; c=relaxed/relaxed;
	bh=lTLmtK31hw/UKLvDWxom2CDHYzIzwP+MZGBxJv6sbMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ghag70dIY+9MItkxCdjGhofWK9moWv9zXMlNO0AH3CKhySIzBmShLKie0Ai04ycQEcetVXg6oxLbXpKAE3Pw1eO31+l6UZ4fQ2b1CJPxvkW+LO2CQ6sUsfWBmQd53HO0mZ14Qh7qqQdm3+cf3lm3rTvfo2tnaN5/IzbzGQJJ8ql76XAJFGaqTKdTY1+UY4UdwWjBkYi//nKylnHq2DSYiXg/xyqq5Mi5n1TKk5UuCVtn05T22TLHvW5wuEPRmvBk5zLv3UXi8QtPwg+6E0Q1Bo2zxMRG4XVflwxqOBJWIYldSMyeMVvIgqPz7i5L9QQ7XqjiqiKELbCmKyUrlzVvzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VNsZdypM; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VNsZdypM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLvgy13gJz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 09:57:01 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225651euoutp0243c170edb74bb5bf172971ef2300a8f4~llsfrtNeN0400204002euoutp02H
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 22:56:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261106225651euoutp0243c170edb74bb5bf172971ef2300a8f4~llsfrtNeN0400204002euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005812;
	bh=lTLmtK31hw/UKLvDWxom2CDHYzIzwP+MZGBxJv6sbMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNsZdypMr+ufFm2i3vAU+MGahJRXL9LYBLbKw3WKAuDAvyWhI5fopN7/I/5jj+AeV
	 WMmU+yT7SeGv0gJK1JYZ83Rqm/CR+upiruhZCpTAA3ULioyfKXQr6dtcmwZDqcykuQ
	 gkt6FAlj+l7Q5ZRAFP38wKXc1arLL6BqizvJ3ZA0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261106225650eucas1p1efb74e6071ef81de13ca8e1e67d83655~llseuRzt30802808028eucas1p1f;
	Fri,  6 Nov 2026 22:56:50 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225650eusmtip261d7fce2c0cc1b8258450c34970e6753~llsd_z2Wy2228922289eusmtip2S;
	Fri,  6 Nov 2026 22:56:50 +0000 (GMT)
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
Subject: [PATCH/RFC 3/7] MIPS: mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Fri,  6 Nov 2026 23:56:23 +0100
Message-ID: <20261106225628.215319-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106225628.215319-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261106225650eucas1p1efb74e6071ef81de13ca8e1e67d83655
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225650eucas1p1efb74e6071ef81de13ca8e1e67d83655
X-EPHeader: CA
X-CMS-RootMailID: 20261106225650eucas1p1efb74e6071ef81de13ca8e1e67d83655
References: <20261106225628.215319-1-m.szyprowski@samsung.com>
	<CGME20261106225650eucas1p1efb74e6071ef81de13ca8e1e67d83655@eucas1p1.samsung.com>
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


