Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0D60A260B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=AmzMUIjW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhqh4yYvz30TP;
	Fri, 20 Nov 2026 02:15:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795101344;
	cv=none; b=G6wxjSgES5KU/ne0iv0G0UYCD91SoVZkSW+ZCNCn+KEybJDRnzH9Wg+MNYa6cAsXEDDGeZFwl2tfFC8XE5rw46JGP7vFg8+AVgJIlm/KqZrvYW6QnC/kNzpEiduWgaxb33iVeP4GraRxELLSG+SETymj1l1iL/7XyvyEzo1KHCtljq3x/aIdYzUMaC7N1N7+1U50nm75FPc/bx5I0NWVZgQ5ml8RcqNfdq0SF2xL9zj3Q/D9t/MDpaunuouw+K75wOR/GULEuelyPjlCej79hGrmaMuyZyXBo4NAJEOhviLTJ94xkU7754lJqKAgcxRxgT2U4pn8ZePNlMm1htFGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795101344; c=relaxed/relaxed;
	bh=0/rZ8eFNR0SkR4KBoqJwpR6CsQYqYW0/WWAATt7aV9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=J4hJsiKvW1n74nqZc7WroszAFwNFxJb9nJKZcS1pcar47yEzlYxugcy2nVW7jrot3qziOpgB70rxZenVDUrAVQ4UNbQ4f35Dkd9Ug5G+gu6xgQDPOVXtrkCMLBTvV1EqV1GMEHGQ38bXJ7qJJdQpRVgSLCEamG+hwUGSuNSi95OQ+fwpPn9+xQ71kfE94y3BXlYgH1crsTE+9Rd/nemgqvb8mUkWXj0p60zaSP9iAiiGdPYnlS3oW6TyVFy2778QyuCWuoxB8Njd65E7p0+G8Nly5ugOe0nkRmQup8wU3a2r5qpt7EhzrWJ5FLy3fQvXhpM5H7WAFufK9bgTXfVQnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=AmzMUIjW; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=AmzMUIjW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhqf1s6Nz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:15:41 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151532euoutp019b71fbf7529ac87f0b79b716911b2a91~peyaaF_yG2591625916euoutp01P
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 15:15:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151532euoutp019b71fbf7529ac87f0b79b716911b2a91~peyaaF_yG2591625916euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101332;
	bh=0/rZ8eFNR0SkR4KBoqJwpR6CsQYqYW0/WWAATt7aV9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmzMUIjWkV7nFz2jgYxfJbOo4ayHi+MSjAXaPuA4nYUBmiWAYz/SJMGbK70mxfJjN
	 zpTbUrn4+ZLBuUcofDr5FMV6hTyZztdVvXfrHKu26sgLRZDCq8roNnYoHebRze8mFt
	 din6qHpP1x+AiR4sC/dFNFQ34TKGTsq4FAGigSzA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c~peyaDJkwh1566215662eucas1p24;
	Thu, 19 Nov 2026 15:15:31 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151531eusmtip15acd40c96d905159080b77d155c3b04e~peyZSMbLo1418314183eusmtip1N;
	Thu, 19 Nov 2026 15:15:30 +0000 (GMT)
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
Subject: [PATCH v3 5/8] powerpc/mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Thu, 19 Nov 2026 16:15:13 +0100
Message-ID: <20261119151520.2383226-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119151520.2383226-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c
X-EPHeader: CA
X-CMS-RootMailID: 20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

arch_dma_prep_coherent() performs the cache maintenance on the address
returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
is NULL for a highmem page which is not kmapped, so the flush would
operate on the wrong virtual range and leave the dirty lines of the
buffer in place.

The generic DMA code may pass highmem pages to this hook:
dma_direct_alloc() handles a highmem page returned by
dma_alloc_contiguous() by forcing the remap path, which calls
arch_dma_prep_coherent() on that page before creating the uncached
mapping. This cannot happen on powerpc today only because it does not
select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
there, but nothing in the hook's contract rules it out.

Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
one at a time. Without CONFIG_HIGHMEM it does the same
flush_dcache_range() on the linear mapping as before.

Fixes: f2902a2fb40c ("powerpc: use the generic dma coherent remap allocator")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/powerpc/mm/dma-noncoherent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 3ce7dfc213d9..af2a42e47016 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -122,7 +122,5 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	unsigned long kaddr = (unsigned long)page_address(page);
-
-	flush_dcache_range(kaddr, kaddr + size);
+	__dma_sync_page(page_to_phys(page), size, DMA_BIDIRECTIONAL);
 }
-- 
2.43.0


