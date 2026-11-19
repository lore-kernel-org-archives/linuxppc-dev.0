Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1460A5BE1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NumuFMSP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhqd3tcGz2xSZ;
	Fri, 20 Nov 2026 02:15:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795101341;
	cv=none; b=g7hmt8darMFTOGdpim8+8WMDLKreahmV6pgI8OKQKr8lyMwyOdEbDAdeZbNcZ8aezs35V6il517QHP4p2N23/JhysMUmsCNx0IcjGiJkbp5U4/s28TWC/jN3OoXoDjreJ+WfsIEaN53ZQR14DAxmWgJs/KlzoVDeBKww5yTXUM7R3IIjnhpYXZak18nkdfqbsafVKOBoB2fiYCysFQP0P0cs1FSx9865fhhM2qGKIrDa5LDohTj41TGljDf4brsKsdErW/BUdueRz39uj+OAun6aiImwrcilu59HmM5pJUb/ToqNqvSpzCTqoazyXwuCw3ZaNpZHgkBEu9LgyNjT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795101341; c=relaxed/relaxed;
	bh=lk76tC7IRw8G2FlFrQK7QuoBU9z+K90N8pTbYK1Qz7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=U4uIe0CjgEVinwu618gckkM60nlPrawgywMkfjtwC7EmDxdrUOhmYpzsZHZcPS2gzf8Op4dBi1WWcf21jfFYQ4aNudvfXCOdWhNlsIDJTQ9feuLYp7bG60tDxU0gqo5JoJVhkq9ocpSB5dz5GneuZycIFVi7MmDtWeXW7g/lq7EEiAmDVJmsvTJwRQ/VodCK/kqlx/iSFlae/ey0tetUG/VcHyKjmq5rCY4uLirrukJlFxwniuj+UBmFPIWClz+FgX0g8zOob//RIFR+ppFFumChzE3pfd/GbIQQ/OHQZiOvEMWvkHFH28KTHa4YwsETzxzEiqhllv3Vnaw9sC4gKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NumuFMSP; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NumuFMSP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhqZ66Kmz2xLF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:15:38 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151528euoutp025aed978dc467e4e88e31df48f4b3faa8~peyW96mEK1495314953euoutp02O
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 15:15:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119151528euoutp025aed978dc467e4e88e31df48f4b3faa8~peyW96mEK1495314953euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101328;
	bh=lk76tC7IRw8G2FlFrQK7QuoBU9z+K90N8pTbYK1Qz7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NumuFMSPByZ5+Yut0WRgxfNhSko/XQKMoeqT9BE/yz24jAwDaNiWhEso/zRjdOnY6
	 Cw9dmXs1FSkJQVtfo/iiS+15BXZTl4ff0aTALnHxK2/H9JR91kVqq03fb/by33nnbn
	 /G02+PMLAETIQqCtRs4U/9taA9cg5STSmpDPAVnc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69~peyWsVDFm3051330513eucas1p1O;
	Thu, 19 Nov 2026 15:15:28 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151527eusmtip1fcc6a501e576876aab9549d86cc48193~peyV87Obe1418314183eusmtip1L;
	Thu, 19 Nov 2026 15:15:27 +0000 (GMT)
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
Subject: [PATCH v3 1/8] xtensa: write back dirty lines in
 arch_dma_prep_coherent()
Date: Thu, 19 Nov 2026 16:15:09 +0100
Message-ID: <20261119151520.2383226-2-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69
X-EPHeader: CA
X-CMS-RootMailID: 20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151528eucas1p133a01863b1cbf6d6b5e1361ba590ac69@eucas1p1.samsung.com>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

arch_dma_prep_coherent() is expected to remove any dirty cache lines
covering the buffer, so that they are neither lost nor evicted later on
top of data written through the uncached alias or by the device.
xtensa implements it with __invalidate_dcache_range(), which uses the
DHI instruction and discards dirty lines without writing them back.

This loses data written through the cached kernel mapping right before
the call. dma_direct_alloc() zeroes the buffer with memset() on the
cached linear mapping and only then calls arch_dma_prep_coherent() and
switches to the KSEG bypass alias via arch_dma_set_uncached(). On cores
with a write-back data cache the zeroes still sitting in the cache are
dropped, and dma_alloc_coherent() returns a buffer with stale content.

Use __flush_invalidate_dcache_range() (DHWBI) instead, which writes the
dirty lines back before invalidating them. On cores with a write-through
data cache it maps to __invalidate_dcache_range(), so nothing changes
there.

Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/xtensa/kernel/pci-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 94955caa4488..e1c00ec37eed 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -82,7 +82,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	__invalidate_dcache_range((unsigned long)page_address(page), size);
+	__flush_invalidate_dcache_range((unsigned long)page_address(page), size);
 }
 
 /*
-- 
2.43.0


