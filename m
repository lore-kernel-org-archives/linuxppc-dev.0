Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF9606B9CD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NRnh/w8u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP20t2dFSz3ds7;
	Tue, 10 Nov 2026 20:49:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794304142;
	cv=none; b=KT/JeiN1tJF7WRj7qKUeaHVxiyEdbGHbE5ykfrJYK9b+BIUHWXoTT5jyuVgSAW05r8/xOVbj8PVJ8wMQmjbWcv4CIK9oT/JdAQvKKi1GJEL4/6+BFwdlMdj8I/pdYcoUu3oN22ZMlzP9T1EDRRDqilpnpfAi3OyRuSKT4A+JbPLx+uhT5lR9CM5qN5wL0W8xiJwVU1B40M7nZ59EKme563XJS8wJn6CBIK4BahC13SnPxYJX1MIyWpKdDCWDqIfZVRY8GeWURihV/vU3A/Lf8w7RmITCzVhmfcrz+hjAglwf/pD2tvkp1u/DwtpjaGps6opaAyR7Kx5badHl27pdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794304142; c=relaxed/relaxed;
	bh=lUyguL9bYx4+tZtCreSlh0gHH/nSZpnT13+K+grz3Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TRBgqc7rVGuYefxFe2MUhLuFjcBxonmDw9lu9xCmusSYKFTWs0TciU/urDkLC9IBzzs+2gkkf+XrowVKEHQiidP1Q6UWftOZZkF5bWWnzeKEJVlyfMZfIMLnQqpqt4PHuBA8Jqtw6KIGitsFzJSgj0SZECNsMVHq2Vhqc3tjEH/raH/eJMPU33aQgvdX6/G+jXirjh8HeS9Aw7scgYW07dSUAuuWg/VLtM+7OLsP0qf0noE7xFZ7/FJPHhiXKYTcLt08yB0EqkKkbk2xaF+MhUTHNXLEoiPh2OJ6sMraem47D5TPl8EDtMUltINELoHkpaQc/+MGog1F/2RHStRmPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NRnh/w8u; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NRnh/w8u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP20q4JL2z3dmy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:48:58 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094848euoutp028e9998b1f4255c81af6c28659f066040~mphkZGGzN2831028310euoutp02Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:48:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261110094848euoutp028e9998b1f4255c81af6c28659f066040~mphkZGGzN2831028310euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304128;
	bh=lUyguL9bYx4+tZtCreSlh0gHH/nSZpnT13+K+grz3Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRnh/w8uguMSSFmuvaVJuWD8Xk/n2AJnJs6+LnBJa5lup6AB5mcUxfu7aQLDSba3a
	 IPrHYFgAZFnYhbpXQwe/7WQSyafetXWXAwM4PJoOnqLRVwRnHHvzg8Y1XEimRoZ+Qa
	 2kNtnobFkym8UW4l09HSZOrQPo/DSkLpbsexzdq0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094847eucas1p125691a852f3621482adae13de1205223~mphj31FOE0320103201eucas1p1f;
	Tue, 10 Nov 2026 09:48:47 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094846eusmtip19270dee01afe96afd138549c54066498~mphjJx1YD0051500515eusmtip1E;
	Tue, 10 Nov 2026 09:48:46 +0000 (GMT)
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
Subject: [PATCH v2 1/7] xtensa: write back dirty lines in
 arch_dma_prep_coherent()
Date: Tue, 10 Nov 2026 10:48:21 +0100
Message-ID: <20261110094830.2081847-2-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094847eucas1p125691a852f3621482adae13de1205223
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094847eucas1p125691a852f3621482adae13de1205223
X-EPHeader: CA
X-CMS-RootMailID: 20261110094847eucas1p125691a852f3621482adae13de1205223
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094847eucas1p125691a852f3621482adae13de1205223@eucas1p1.samsung.com>
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


