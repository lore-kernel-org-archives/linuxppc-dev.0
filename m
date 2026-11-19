Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA40606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=GGwysuCM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhqj4n3Fz30Vy;
	Fri, 20 Nov 2026 02:15:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795101345;
	cv=none; b=isra/buX6XyxTHlLPOE6AvzEXl+RUSJeDISKt3fQAXFZWRZ9QP0isUFDVpKy6eLGRb/yPvQtZ/cfxw1XtbIT8Ny/6bPWHyISdl0ZxvnvCOktDD1soqRTG8f3e40liTeRTjBI/XEF4SIX3MA0skON4TvuKc40LOVENGI111D6ITgMrtYDUOYfLQz2CV/FNnOVsfK/LqYddsL50psNG15dGj2hIGAk25ObWGG3c1+8jtjOv1lN+764E7fgg/gZAini6sqSK5RyeM6qNSGVVWknBfjfHgjb69corqNWQdPJVAxsfsAnSvR4Y/3FGmP4kmlnDBGk6QyTDjlEIYuLQfO4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795101345; c=relaxed/relaxed;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=jFStaQK7anaOWzGk/ilW9dtkyhRh1mGXTTUcFzgcztPuCGfdu4fKUEKpe+mjk6DT5TfrXjBZTetzcL8uXhpCpUOBtjIffL08kJU/SOdymYy/wqBVkT6vGy6MzFVkjgFMHJ2urfv7eV3mExa9pHLPctXgSUnwGLMfLy6YyyW0oPCzQbhFTJJib43mp5DkxTsjE6jWIh4XpzaZjcb99GzaqRNciD4lPqQOs53RYz3pdlwf6pyrHunJE7gd89B7jO4VA+57jP5SHlr2PkSrqZngWFd4d1PtQVm5pItQp+NIsPCwcpuWr3mjv05FqLcy/i6PdxGHRQmFtIqnaQS3j+cwfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=GGwysuCM; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=GGwysuCM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhqg6Mk9z30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:15:43 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151534euoutp021470af6dc65d72862bc5b0101489123d~peycNl7VU1775817758euoutp02U
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 15:15:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119151534euoutp021470af6dc65d72862bc5b0101489123d~peycNl7VU1775817758euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101334;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGwysuCMXPEPYjVeusWJL4cnqdklOJrdDsEMbcw/j3NnvHZMPeqlUcr4E/oDluULx
	 4BwDs44vQQGvR0Z6rAM3EckKj6w3zfKtvxLpq5/xho3Zacs13TyFMxW0SYJahcYFYj
	 3IyjED6THoWPLR7KO/NTPgI9Xu+NcX+iHjPMbsr0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e~peybucct00881508815eucas1p2E;
	Thu, 19 Nov 2026 15:15:33 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151532eusmtip1c3870825822d25974aa0874a95107a8d~peya_J3Vx2049720497eusmtip15;
	Thu, 19 Nov 2026 15:15:32 +0000 (GMT)
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
Subject: [PATCH v3 7/8] dma-direct: do not skip cache maintenance for
 highmem pages in no-mapping allocations
Date: Thu, 19 Nov 2026 16:15:15 +0100
Message-ID: <20261119151520.2383226-8-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e
X-EPHeader: CA
X-CMS-RootMailID: 20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151533eucas1p26a727ce85c6e07dad9cb117162de518e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_direct_alloc_no_mapping() calls arch_dma_prep_coherent() only for
lowmem pages. The check was added when the DMA_ATTR_NO_KERNEL_MAPPING
handling was moved to dma-direct, because some implementations of the
hook used page_address() and could not handle highmem pages.

As a result, a buffer backed by a highmem CMA page is handed to the
device without removing the dirty cache lines covering it, which may
still be present from the previous user of the page. These lines can be
evicted later and corrupt data written by a non-coherent device.

All implementations of arch_dma_prep_coherent() now handle highmem
pages, and the hook is documented to do so; dma_direct_alloc() already
calls it on highmem pages in its remap path. Drop the check so that
highmem pages get the same cache maintenance as lowmem pages.

Fixes: d98849aff879 ("dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/direct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd..fea0dd36dd25 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -207,8 +207,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 		return NULL;
 
 	/* remove any dirty cache lines on the kernel alias */
-	if (!PageHighMem(page))
-		arch_dma_prep_coherent(page, size);
+	arch_dma_prep_coherent(page, size);
 	/*
 	 * return the page pointer as the opaque cookie.
 	 * Never used for unencrypted allocation
-- 
2.43.0


