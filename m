Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E052A606BF01
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MDucNNo7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP20t2SlJz3ds1;
	Tue, 10 Nov 2026 20:49:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794304142;
	cv=none; b=gHCHSwTuVfbUj9gmCVJmweSUzhFfCcxPVvW5Zy4YwvsKhdykC3k6k63jKGW5hrfvrwmvh+Ia12KYem0QCffFRiblcWwChEXVsKgxChOBh3QzHuVS01U9LQH08NtYRyEZQPNyWhJkWNgfpP+7Qx76xqrPynRMxlIV9etMJQK3dLOBLlSZSzSXORyYJu25G031WA1ap7F8tRIBlC3jAN4Qv/WAHYfUJiP/X1kx2q+sbt2ti6t/XybnpxNWQy+AVnO41g88PFCGZSC+kfeybvGdG3aYM4UI7jU2vWI7tZZjNZf+Z8nZIer987D30pdrXoHZCb7bMiE/eoNX3Pmcnb94Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794304142; c=relaxed/relaxed;
	bh=rEjQMrO5ewCoTXLRmyADdnQOxAz7KvPx22hj0G2OEWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=cQQQE9uZwjUgc2wVHIVMtqSVbY5sGIz0ZxJ8xkSBpoT87x2LF6eT9QmUt4UGDanJgDci4wV8Pf7R+N3tA9nQ18iwzTaWF5hFA+C+vxuoPRTk/AZ7sALRuJzx5v1BdxYNZpeA9kicvqgKnjH3uitXD1zeypMkV5ytpawWJsx2qa6UDrAlmJzKpwvlDzZr/1jR/qvrgaIPNOmX5ilpnvGuqPrqJ6167KXFeZu9iKVPgWBRlW2BF0YthfyXyRkK5l0GRH3gxA13YVB9M6Ca0iITXE9egPRSlU7XVnLhmwWIThjKyZGmgRxcUhF9X6mrhvh2FfA3TTeNoWNEoeLEHVp3bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MDucNNo7; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MDucNNo7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP20q4TZCz3dng
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:48:59 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094849euoutp01c39c44ae3a4dcb456394f7bc2470d3ce~mphlLyUDT1103111031euoutp01T
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261110094849euoutp01c39c44ae3a4dcb456394f7bc2470d3ce~mphlLyUDT1103111031euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304129;
	bh=rEjQMrO5ewCoTXLRmyADdnQOxAz7KvPx22hj0G2OEWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDucNNo71VMaNT7O/enXd9HnluaC/80BTpCOhfJ8K+Uagdw52U4RKdtIGbL4/liDG
	 ptFVqFkZL0i1mzLXp8DlUFon5C1GkYlliT+bYX8+yZlUY/Scn0nEcUJ3vPCd1yTBQs
	 p5Cp2NrvUEIKB4dXPwjULV+QtgwBpcqtZTFu6/oY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08~mphksavJM2794027940eucas1p2h;
	Tue, 10 Nov 2026 09:48:48 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094847eusmtip1a4cc499316373287c2b9575c277efdb8~mphj9NX-N0299202992eusmtip1c;
	Tue, 10 Nov 2026 09:48:47 +0000 (GMT)
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
Subject: [PATCH v2 2/7] xtensa: handle highmem pages in
 arch_dma_prep_coherent()
Date: Tue, 10 Nov 2026 10:48:22 +0100
Message-ID: <20261110094830.2081847-3-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08
X-EPHeader: CA
X-CMS-RootMailID: 20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08@eucas1p2.samsung.com>
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


