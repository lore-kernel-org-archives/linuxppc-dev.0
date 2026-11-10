Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA8606B9D5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=G5DWh+To
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP20y2gDBz3f1b;
	Tue, 10 Nov 2026 20:49:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794304146;
	cv=none; b=XWPhXY14mkCxfrGzmH8+Y6fikVbPA5i8hgxG3yVxeq5uk59PA5kB+v1HQAgKleb5H8ohEG8ViGZGPM6MKeRURURlOjT3ccSATddOmCzxD9gioAjk+oq5/tVHWU05wSGFMQBSeV7dDiGpnbge/pycJdtHz0dPKFU3tQ2WhsaDcaX/6u8kQT3w076cwCf8gYjhZkXnmUBTz1CXzvPl1sIeQ7+mQQ0F5agPh9rMtNg7IsjFpa0EAfG9EhUSBeljSy9gxyaCP59lCe7u+vHGvGjRttwWmRIT2I8wYBKoBwIRqno/IOfJwD+MXIQeXOtGjz7cKCC4i3bJmUrIuNJxHp2aww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794304146; c=relaxed/relaxed;
	bh=ax4MvHJyHLXrr5GwS+hGV9/dsrsTvA8fGhdsCAVYF24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=G23PSYeiSzipd696OkzJpmDYhEcx8k2BX+/zai0tNy2RHVDLuR8x1RzigoQUYHadP2bmaYFYNT/Y+foki0qHYBxirbKjYTWK8ZwROBxnPpla4SPzeLc0PFUzw/P/RKSauukUDchXrGb5s/2YN5Qd3VBia93iNxzmZnUKlqbI2UI02OM00hUZQqYbGk3Rwsa+5pcRdCWz71iPyA+oH6tm/9TKEyyf5HCpPTJGraHYWT0Qhx5wAB2b4lmD68Wmgy3dQRKybR7JDRxnOVuYax8JY6XdwHn8lLx+od4BpKpwPNyfFTVzdToxnmTj8uivCYd1+kmGaoxyC2lg0ouCUuUxKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=G5DWh+To; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=G5DWh+To;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP20t00wJz3drk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:49:01 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094852euoutp022b86d87acee54a7954c0ac7162f111ce~mphoAeIjD2831028310euoutp02d
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:48:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261110094852euoutp022b86d87acee54a7954c0ac7162f111ce~mphoAeIjD2831028310euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304132;
	bh=ax4MvHJyHLXrr5GwS+hGV9/dsrsTvA8fGhdsCAVYF24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5DWh+TodT1wHEmqB2NZ5J8cakFau/XrIhiBecUjljKySHdEYTfI78JDRF6rt3YF+
	 /WZxGvXkpuLd3JVbNIyZsZfC6D7hSDFPgXQGxcxnXdfuyrNGXpq0WJJZ9BdYBkvVdo
	 zKPZs5fx2VmD/9KazTglN/6WkL10DgKGOsZz5kEE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094851eucas1p10eccf143e36dcc8933008074dee399c9~mphnM8IAJ2784927849eucas1p11;
	Tue, 10 Nov 2026 09:48:51 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094850eusmtip1ca4aaef9449d1bd8d0a657cb62cfc5af~mphmcNYpF3192331923eusmtip1W;
	Tue, 10 Nov 2026 09:48:50 +0000 (GMT)
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
Subject: [PATCH v2 5/7] dma-mapping: document that arch_dma_prep_coherent()
 must handle highmem
Date: Tue, 10 Nov 2026 10:48:25 +0100
Message-ID: <20261110094830.2081847-6-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094851eucas1p10eccf143e36dcc8933008074dee399c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094851eucas1p10eccf143e36dcc8933008074dee399c9
X-EPHeader: CA
X-CMS-RootMailID: 20261110094851eucas1p10eccf143e36dcc8933008074dee399c9
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094851eucas1p10eccf143e36dcc8933008074dee399c9@eucas1p1.samsung.com>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

arch_dma_prep_coherent() has no documentation, and several
implementations assumed that the page passed to it always has a kernel
linear mapping and used page_address() on it. That is not the case:
dma_direct_alloc() and atomic_pool_expand() can get a highmem page from
CMA and pass it to arch_dma_prep_coherent() before remapping it, and
dma-iommu allocates the pages for non-contiguous buffers with
__GFP_HIGHMEM.

Add a kernel-doc comment describing what the hook has to do and stating
explicitly that it must accept highmem pages without a permanent kernel
mapping.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/dma-map-ops.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b..ee4ac12bf2ad 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -371,6 +371,17 @@ static inline void arch_sync_dma_for_cpu_all(void)
 }
 #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
 
+/**
+ * arch_dma_prep_coherent - prepare memory for use as a coherent DMA buffer
+ * @page: first page of the physically contiguous buffer
+ * @size: size of the buffer in bytes
+ *
+ * Called before the buffer is accessed through an uncached alias or handed
+ * to a non-coherent device. The implementation must write back any dirty
+ * data cache lines covering the buffer, so no dirty line can be evicted
+ * later on top of data written through the uncached alias or by the device.
+ * Must accept highmem pages without a permanent kernel mapping.
+ */
 #ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
 void arch_dma_prep_coherent(struct page *page, size_t size);
 #else
-- 
2.43.0


