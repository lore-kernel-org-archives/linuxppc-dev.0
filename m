Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C799606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=hs91eL7m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLvh12NVyz2y2Q;
	Sat, 07 Nov 2026 09:57:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794005825;
	cv=none; b=NyB4nD4GfwpFK2VFAF2xVB24ZEx0+s1flsLsqHw4S2f62gumRs/XN/GSl9X5RB7j9CcEofxari6q/IU1U32gPvFlYw/KTOGYfrZI/kunTxgg8ZqiNYnRbkw/opB46FyGLRKeXpGq/I4eeh7C2DDQ7CIvqDWWM3E1AC6W2Q8gtgtBwOhYx2UuYJ4lZ0zTF03x3Sy+Y4sLo5XRXZ7wHP1fgTwBy76nvsbP/2w6P8JvBRyk/34XCGIsncQiVbkbH/n8KDC8ZJf2+V1idcioU+fdTP5zZEhLDsxRdQVpBGWfWcdV71q7zs3oFtIQUzrcTpkHdRGS+z2rRxyNcFVtsCZY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794005825; c=relaxed/relaxed;
	bh=IJCShxZcd5Lye/mgdSMJcV5l3GYpCC0DWWah+SYwQXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=I1F8szEqN1wNMtt8WI0Y+AEChgW6sBgf7FmW55pbQRBSoBpGIbGugSB13RV3A8HxWjFbUR14I4oUaH9OI0lSejGmNB7kf6VdXpBOIe0UDhX4EDhyjaUkxA/L4ydm38GK8oLD77kjU6tyXFdTN2tw0Fyu+d3QyygWjoHTN3dsvCfqObVYzhKxTjD18TqCaPrvA9q44D9Ltiqcw3dse4D0fH/LSumW1l85sNZNY2G4rYE8xX3syVjAjyf+blUODbiMRzBn9O4wkzpbz5Vpm1QjvRExRjoJFHcWO6hy791aWNxE2Z2T4CO0jFOAHIaloB24ZukseN+/6ffniLgSfWHKjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=hs91eL7m; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=hs91eL7m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLvgy0ts6z2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 09:56:59 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225649euoutp02077e9360eb1b2643d12e5b37b1fea9be~llsds1zee0391003910euoutp02G
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 22:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261106225649euoutp02077e9360eb1b2643d12e5b37b1fea9be~llsds1zee0391003910euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005809;
	bh=IJCShxZcd5Lye/mgdSMJcV5l3GYpCC0DWWah+SYwQXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hs91eL7mUpYnQeSAfRDH1Oq+s2tCrEuouC64XdTIwtASMPJBU1vza7uF0dRcjQG6l
	 q8P1PvEVI+KgJm8jIxpVYUtLd4PJWoFnMXODmdxhf/iAuu483uETIfBkdaposYWl//
	 td4bhQPxPNEGWQY5o4h/JjtfT26PjiqLggJxx2lE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225649eucas1p27f1d64162099ef1c7472469f2a33201e~llsdEb1b41955019550eucas1p2q;
	Fri,  6 Nov 2026 22:56:49 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225648eusmtip2ae191027336406180fa85101917bad82~llscVidfA2228922289eusmtip2Q;
	Fri,  6 Nov 2026 22:56:48 +0000 (GMT)
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
Subject: [PATCH/RFC 1/7] xtensa: write back dirty lines in
 arch_dma_prep_coherent()
Date: Fri,  6 Nov 2026 23:56:21 +0100
Message-ID: <20261106225628.215319-2-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261106225649eucas1p27f1d64162099ef1c7472469f2a33201e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225649eucas1p27f1d64162099ef1c7472469f2a33201e
X-EPHeader: CA
X-CMS-RootMailID: 20261106225649eucas1p27f1d64162099ef1c7472469f2a33201e
References: <20261106225628.215319-1-m.szyprowski@samsung.com>
	<CGME20261106225649eucas1p27f1d64162099ef1c7472469f2a33201e@eucas1p2.samsung.com>
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
The same applies to dma_direct_alloc_no_mapping(), which allocates the
pages with __GFP_ZERO before calling arch_dma_prep_coherent().

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


