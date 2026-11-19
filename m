Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759860A2634
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BIrdkgKD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhqh1cb1z30Pp;
	Fri, 20 Nov 2026 02:15:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795101343;
	cv=none; b=eFX8ZltFYNfpPxRzlkhyma8GZpkvYpM6iBCjsmpY1t5+++3vsrxRlvvRaIYX7uA6lf4csZinsAVk7ODq9JKG3JWZIBwhgtNaIeWK6PRHVjnStD+Z9at2gfvC7iCY2+Fr7v4eYxVvFGeUeN9c0nGVwN8YcuGmeW0KKoA0KKMikVnCKxkjvjYpat+HncSSTvzi9HkKzsagfHKuHHmIiG06RvbXv/ibolRLHn2VOzxVeMjGVTUDVyIKmkueCDYzm/ceRU0sfKzWTHKVQIXznhSxI0fqk2NqHKDhMBjUFVDSL7PtS+OAd2Q1XyHoC4ba8INEkS7eiMvDxdrGw0FD2meS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795101343; c=relaxed/relaxed;
	bh=i2GzEcfojg35eLu9fwG+rXcXBdIHA+y+JtfGhwa3unI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=OjZBOa145RArgIudXDpIViuoUoGGulHJ1z9D+F1TKRrbA4ITqLxo71pveWVUIyZxNvTFR8pL3IPYyVSd3k5D5f408HGH9XP7uyw75fiGRg8XPQ3ex0N60pb7TtU1aVT25VtKHpEGvKtjmDDRTh8RraebUSYgu9Eedfk5oo2dJ2TwD+cDcSo11QKdIXy72gtGLBXA9WrLRmr74Jym8m1Io9ukpl0T5zN46PciQACz9vLoOjLix//rQeNgk6raB7y+TAWu/Q07/36Zs914h7eOoZ6EzhhxW/w2kGwTkG/V+Q7IY5FOR7+1cNayA9k6HSAZM0ITVy3hsk5jsH0oiqPFCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BIrdkgKD; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BIrdkgKD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhqc74ysz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:15:40 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151531euoutp018078bd24a5f49ad3c4e3b219c5d958aa~peyZiZJRO2922729227euoutp01a
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 15:15:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151531euoutp018078bd24a5f49ad3c4e3b219c5d958aa~peyZiZJRO2922729227euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101331;
	bh=i2GzEcfojg35eLu9fwG+rXcXBdIHA+y+JtfGhwa3unI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIrdkgKDiOzg9gHz4gH3o71RswsACtDyyokIFJgAIiruK/ScIGGn7gw5PQAGO+dYd
	 j2Y1eSwXX7PVJfXnlE2FWNMCbk0pazaE4DXokrXPcBNeGsmiDB5DJ4rV3qaHJ6rw3H
	 YxhTaqceAru36Pwk1j9ExkFbqa6gMFxKBICN4n8s=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151530eucas1p1724ca5c2a4cb0e5a7d9ad91c936a2c6f~peyZMkmrr3078730787eucas1p1T;
	Thu, 19 Nov 2026 15:15:30 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151530eusmtip19c24465bd0b31b833b21629651ac1c4e~peyYclo922049720497eusmtip14;
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
Subject: [PATCH v3 4/8] powerpc/mm: skip kmap for lowmem pages in
 __dma_sync_page()
Date: Thu, 19 Nov 2026 16:15:12 +0100
Message-ID: <20261119151520.2383226-5-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151530eucas1p1724ca5c2a4cb0e5a7d9ad91c936a2c6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151530eucas1p1724ca5c2a4cb0e5a7d9ad91c936a2c6f
X-EPHeader: CA
X-CMS-RootMailID: 20261119151530eucas1p1724ca5c2a4cb0e5a7d9ad91c936a2c6f
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151530eucas1p1724ca5c2a4cb0e5a7d9ad91c936a2c6f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_HIGHMEM enabled, __dma_sync_page() unconditionally goes
through __dma_sync_page_highmem(), which disables interrupts and
kmaps the buffer one page at a time. This adds needless per-page
overhead to every streaming DMA sync on such kernels.

Use the per-page kmap path only when the buffer reaches into highmem
and do a single __dma_sync() on the linear mapping otherwise.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/powerpc/mm/dma-noncoherent.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 30260b5d146d..3ce7dfc213d9 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -96,12 +96,16 @@ static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
 	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
 	unsigned offset = paddr & ~PAGE_MASK;
 
+	if (!size)
+		return;
+
 #ifdef CONFIG_HIGHMEM
-	__dma_sync_page_highmem(page, offset, size, dir);
-#else
-	unsigned long start = (unsigned long)page_address(page) + offset;
-	__dma_sync((void *)start, size, dir);
+	if (PageHighMem(pfn_to_page(PHYS_PFN(paddr + size - 1)))) {
+		__dma_sync_page_highmem(page, offset, size, dir);
+		return;
+	}
 #endif
+	__dma_sync(page_address(page) + offset, size, dir);
 }
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-- 
2.43.0


