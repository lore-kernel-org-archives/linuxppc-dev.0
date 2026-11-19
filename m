Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC322606A333
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W0dBpksl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhqg2T8Cz30CZ;
	Fri, 20 Nov 2026 02:15:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795101343;
	cv=none; b=hMWja7mso+m5EzZxgICtlKyHM2J1+Smfxb40qIdcjjR8vmfUI5E9KfECz4zAnh+65kpRa1NlNDRNZN/e8Dlz3BEjCqskxQ754BBn+mcx/vSMtgZ8p9fH7W6RidsF4tj42AaFin6x0zegtQqnVCXhypko+cxxvWPkAybGx+83X+ibWw/uXh0rCSo/U1Hg0tgjednY8BleGBX8yMx6f6tOMrJI0HdWRWNvjH7GbBnzrM+7XLEdgp2kHmtVD9ggIosByvnF7K9hz0A/X+bBNZBn7HQPjzyFg1aS+yOyjTuFNcWi7yuDRcJVhLJIuZNkXZ0fsPyqlDARRVSgJSCdpl6mrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795101343; c=relaxed/relaxed;
	bh=Nc1YEcw0cuZI+ZNt+M3puu2lLT6GGNnfXJngXlOIKwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=NiRnAUXbxgGpz2ddyppVwlH89XnWepspYor0iALE2TyP1QVJu4bIH1QuK/NyiIqhwy5KkZ2GXMmJEIOabxTW7RPs5WG+FNBHmGRWpbGyijMfK1UClZoghXo3t4XdG8Ps9AdyX7BNwc69KVz7vCwFh+XGY0dv5CM8BHGtZFwDQmEt7OxU/6hYgiskycpb72jKPYombkghEhtHKJ7wGqyjLtSnSvcjfy4x21fEP1DzwHWvrk59quqtu5ZWJmeFa5OojeNpAY2Kqrp5/gviNPWIZ6g/x/RqZFa1a+c2yVv6/wxNFRvn7Tzr75IL12Ri43UcWlnpI/7gOGnjfzQt/uGwYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W0dBpksl; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W0dBpksl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhqb55GTz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:15:39 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151529euoutp014ff6aa5a3fed40a0589dcc6df5da4793~peyXzPZqA2563125631euoutp01W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 15:15:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151529euoutp014ff6aa5a3fed40a0589dcc6df5da4793~peyXzPZqA2563125631euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101329;
	bh=Nc1YEcw0cuZI+ZNt+M3puu2lLT6GGNnfXJngXlOIKwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0dBpksl5wKzOmAKJI5IO7VYsp+Q7+CUMcYAO0GIvvs/NCKmSOjmzXyrtpsulwoXd
	 mi3TKx5gkgyqVy+wQWacBrSyoboy+L6vfVDT1DJ52WuDENbVMgmaRpaejFeFPR14U+
	 2evJ+MkOlGzBUr/kngIiJPI6KIlo/tieZedGLOKM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098~peyXhUBRl3199131991eucas1p1c;
	Thu, 19 Nov 2026 15:15:29 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151528eusmtip1d6e9a0583fa34b4c7775053c77fb38b5~peyWx_5_O2388823888eusmtip1H;
	Thu, 19 Nov 2026 15:15:28 +0000 (GMT)
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
Subject: [PATCH v3 2/8] xtensa: handle highmem pages in
 arch_dma_prep_coherent()
Date: Thu, 19 Nov 2026 16:15:10 +0100
Message-ID: <20261119151520.2383226-3-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098
X-EPHeader: CA
X-CMS-RootMailID: 20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151529eucas1p18e158b8528f576fc36ae5b743acf0098@eucas1p1.samsung.com>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

arch_dma_prep_coherent() performs the cache maintenance on the address
returned by page_address(). xtensa with CONFIG_HIGHMEM uses
HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem page
that is not kmapped, and the cache operation then works on the virtual
range starting at 0 instead of the buffer, leaving any dirty cache lines
of the buffer in place.

Highmem pages do reach this function: dma_alloc_contiguous() can return
a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
path and calling arch_dma_prep_coherent() on that page before creating
the uncached mapping.

Fix this by reusing do_cache_op(), which the arch_sync_dma_for_*() hooks
already use and which maps highmem pages one page at a time with
kmap_atomic(). For lowmem pages it does a single cache operation over
the whole range, so the behaviour is unchanged there. A small wrapper
is needed because __flush_invalidate_dcache_range() is a macro on cores
with a write-through data cache.

Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/xtensa/kernel/pci-dma.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index e1c00ec37eed..41467a1ba068 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -80,9 +80,19 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 	}
 }
 
+/*
+ * __flush_invalidate_dcache_range() may be a macro on cores with a
+ * write-through data cache, so it cannot be passed to do_cache_op().
+ */
+static void flush_invalidate_dcache_range(unsigned long start,
+					  unsigned long size)
+{
+	__flush_invalidate_dcache_range(start, size);
+}
+
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	__flush_invalidate_dcache_range((unsigned long)page_address(page), size);
+	do_cache_op(page_to_phys(page), size, flush_invalidate_dcache_range);
 }
 
 /*
-- 
2.43.0


