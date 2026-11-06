Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853E606A331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=j/fgjsYG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLvh12Twxz2y2R;
	Sat, 07 Nov 2026 09:57:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794005825;
	cv=none; b=RLhY3cRlPNsTG3fZzt9pG/GuqnGc5ynpEXgO+58H1k/qdQ9U6kfZ6oYD9sNjMEPHNzI5ldDyx2DSJzbcuFlLMa36J1j3EK4galPpreiugdEy8sM8yITVd2w5MZnkQX0OErg14FzJ42VQLA8N5g7p5wAtVtJjUaXVuFX9776GP4195l65uRqoEgi6elQUHqP0dHNr0B9tXxkkvwoZrfAxIbpVJleTzUjhARNF9C2D+6Yu2RoMAJ++UaI2oyhl/YyHBa2fBjUwnUOtjn7dYqFF/jtUWedihoZOWde4Ijr9qMEpy2BThvIqkPA9NG8oTjMbg6mzHhk85dqhNAadUiXCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794005825; c=relaxed/relaxed;
	bh=sqRiL704sMluKdRvVQ4zewuJOHUjmkrlRuUBPJbDhvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QIKvb7LSoqVz2YuaeLWaPn9uEVxLThfo0qMX14p1K5OwfXFzdXHcad+2aDIjuH8NRNAs+P3aQJaAOmX6q98a8iORKMqtReSq/pzNec8RNlGVldk1mfVevYwzvsZF0Qcfju+aJyZ1/WfGxuVSxYppsBP+RHZa4IXji4+zulnsfadhfYVVpz6citaLA3nGBdYHqQKeEKGqmskuoxHoo+SlqxYy54Kl73GIKLWAiK7iSzIi1Tjw66YPLDLUVNW4oFjoUSFeIEctdJ2eOaGKOsyVijxX8hXL5JT7ag9+4d1K1LQ0so5wMtOXFt79TG5meZ56tsza64G4PKY0OFBG6f7cpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=j/fgjsYG; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=j/fgjsYG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLvgy73fgz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 09:57:02 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225652euoutp012320017aa1ae8645dfb1d0aecb974823~llsgkBu5I1335413354euoutp01B
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 22:56:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261106225652euoutp012320017aa1ae8645dfb1d0aecb974823~llsgkBu5I1335413354euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005812;
	bh=sqRiL704sMluKdRvVQ4zewuJOHUjmkrlRuUBPJbDhvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/fgjsYG25Dr8LLRjgDua2IIhxtYzvZkR0LFi+LTfCvj5vAmxos71iwGw0kfjGqyE
	 e8UVGKPVyvvN2U6FKuxh3oJVx3lYKgnRIYgI5iQIj35Mz2EwcE71zQdxTaonViWWaD
	 S4BJ11hM+nDIiGdDfmzKXMblqF6kURWqVRsYXjkk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225651eucas1p2d038403b190875c1dd698da959eefbd3~llsfi4ujJ1972019720eucas1p21;
	Fri,  6 Nov 2026 22:56:51 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225651eusmtip2199876749caa2da8966a40ca82a8889d~llsezs8wl2228922289eusmtip2T;
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
Subject: [PATCH/RFC 4/7] powerpc/mm: handle highmem pages in
 arch_dma_prep_coherent()
Date: Fri,  6 Nov 2026 23:56:24 +0100
Message-ID: <20261106225628.215319-5-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261106225651eucas1p2d038403b190875c1dd698da959eefbd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225651eucas1p2d038403b190875c1dd698da959eefbd3
X-EPHeader: CA
X-CMS-RootMailID: 20261106225651eucas1p2d038403b190875c1dd698da959eefbd3
References: <20261106225628.215319-1-m.szyprowski@samsung.com>
	<CGME20261106225651eucas1p2d038403b190875c1dd698da959eefbd3@eucas1p2.samsung.com>
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

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/powerpc/mm/dma-noncoherent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 30260b5d146d..e646256365d5 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -118,7 +118,5 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	unsigned long kaddr = (unsigned long)page_address(page);
-
-	flush_dcache_range(kaddr, kaddr + size);
+	__dma_sync_page(page_to_phys(page), size, DMA_BIDIRECTIONAL);
 }
-- 
2.43.0


