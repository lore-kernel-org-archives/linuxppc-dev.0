Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A95606B9CD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W8PyNThn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP20z0NXTz3f1s;
	Tue, 10 Nov 2026 20:49:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794304146;
	cv=none; b=oFMCHDJt9Ufgyuim2v2+ptWPMD1MKGiLo+wukzFXqLEjoW1p+2jtvieIlX3LuODPMhDn0ZwfO2uXgxW+hXQ2LxhDaWk2Z0DGK8cocr/qN4SW4byWPHdpag1v1Ki9fkPa6LC07RRyLGPzWYoPzsaVvRRKFurQZGfN44JHD7c6jhSrBwf/tzD8I+XjqRliT/jybXs1N6KA0+CMVUH75FQdShg3If4vwER7RbH/lbBn6YSEFKKV4phvTSKyZRJZV0xBdWEcVNhkbMscFYPygEIzXs4XhvkTwkKnZBJlHkgHHA0hO+PYVfFTtbb7FzBjkdz0TqgKAcuO8suFFpqxLc/hZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794304146; c=relaxed/relaxed;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ULwtrurpXe8am5amQT+mFTkG3+MzC/eCMxqvOci7WnR4IqhpdwVxyUNdk5nzXRRRksXm6vcJfuLs33NsmDgH4pQ0RvRL6LmsYnKinL5epaqiBPSNocRhPuKWGAa7dZ3ngtNd0hWG9WnhhJCDzxKYCsD5ojsILmgLyaK3K8RdO2zDD5eIbKSz1/7g2ojjksSHw+7AsoA4gxIpFHAzgjmaSjyUN+E840EXXz1PbWSnxM+ZRfIRL6/kNYw9QmFUt2c5buu0wru52vHi05l1X82Nuo7efI7aif9nVwjD92/EK7PhVsOGRQw+6zCh6CTFtePPYLSSt0Rbs8vpL0RXKfqyRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W8PyNThn; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W8PyNThn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP20v2BtKz3dwr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:49:02 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094853euoutp01ebd9722c2e3ed55556658004a8e78388~mpho4U2ro1103211032euoutp01V
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:48:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261110094853euoutp01ebd9722c2e3ed55556658004a8e78388~mpho4U2ro1103211032euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304133;
	bh=PAOoyIXuxloMyFzXEbyj4BFenlPEGjvo8fDerrpcXPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8PyNThnlQcp7PmR1yN6Rrpv06MxIyDsVc/z+kwv/zaBP+/FtY2ea4Bk/RXQr7JSa
	 Kb2JCIowk/YNHX2jW8JKT+PouuJ7BzICax6XnFOiaATqw3tugUE9MGxqeZWkTFY0mE
	 jYL7muKoO9OMpJucPU8o4v4pfUNLhp6I2ewQKHJs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a~mphoBaH7z1404414044eucas1p2x;
	Tue, 10 Nov 2026 09:48:52 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094851eusmtip1e09b2c252063ce2db3a6fe60e6c01e19~mphnSDeWc0098400984eusmtip18;
	Tue, 10 Nov 2026 09:48:51 +0000 (GMT)
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
Subject: [PATCH v2 6/7] dma-direct: do not skip cache maintenance for
 highmem pages in no-mapping allocations
Date: Tue, 10 Nov 2026 10:48:26 +0100
Message-ID: <20261110094830.2081847-7-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a
X-EPHeader: CA
X-CMS-RootMailID: 20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094852eucas1p28920baba9ddde5dbb2760e45fee7179a@eucas1p2.samsung.com>
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


