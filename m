Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2022606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VLZvUaM1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhqj6mG1z30Wd;
	Fri, 20 Nov 2026 02:15:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795101345;
	cv=none; b=Pr3J4YUPhMKFom4Iz8ZusI0hG2TGQgGaRB6W4yokOA3do2cT+U8UZP+eOnQn64icANn8nRGnDtRpriFgirDQXoXq5W+GlxefjQ201wJtDeHKWjc6D5mMEmtJG6I5DsZbaUhOXNT3I0wYgxB6xMJFy4RAdBnbNWM99eXwi5PrpbSQHVNZPHWJTH77TM/PylMs9zCUDGBG9SCCXO10N8EIEceZQlZHUJxh85Cjw8UME/eHyB6gQVFaX1FqyhPDi3ma+nyAkozurl98MAmzs9kUbDnaokXMc5jud+xobE7OVrdnPUo+YANHYW2bvgBVJ9yLkrG5VSW/4llvW2t3j9zjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795101345; c=relaxed/relaxed;
	bh=ax4MvHJyHLXrr5GwS+hGV9/dsrsTvA8fGhdsCAVYF24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=AjlLvZX+CRAr4QXrIoHlt4YaaQ1lQ7wyV/lp6HmpdD5li8vUJXI8/bP/11DDx01BnV1JXqpNAihcj6sC0nJ9qVSFGfiRJdbW5Nn0JZDYrMUIBfVXaeOkWtfQklcddDjCeiweVOcCVQtorQvJy75+hszPuYEyZU+9loNTgjPHlQ2JBKvClsIHEBaTtb/NROtrf9UugssD4AwtI0HB0rnUdK4AGcIcdwNJE4JyVUSkQhmBg+ixP5NG77l6N9SUMh97wK6q/yIcatonxaJO02bMkUHilq7Y8zbxg2FxVSuJ1PWW8XQjRNmfcJ5qrpuInN2wEnyMpx9+nWvUTzFboM2n5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VLZvUaM1; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=VLZvUaM1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhqg3zskz30DK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:15:43 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151533euoutp012e38c418d310a6ec37398bdb5b55e44f~peybvxBpY2728527285euoutp01G
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 15:15:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261119151533euoutp012e38c418d310a6ec37398bdb5b55e44f~peybvxBpY2728527285euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101333;
	bh=ax4MvHJyHLXrr5GwS+hGV9/dsrsTvA8fGhdsCAVYF24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLZvUaM13HP47U/Mu7cGknArwSWhmYxrLHbn13/RxK3w5RIrr6P+0x9dAbL+qTYO5
	 cthHT5ZH9acsPLxmJFyGwYan23fQMYeyzmNPzJgUUEKTlCuxUwXVSOjUQKvKnkEnny
	 UKhhNHhD61vyHTYMFiw+UTYnyA5jYqM163Ip43KA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c~peya4iPL63051430514eucas1p1_;
	Thu, 19 Nov 2026 15:15:32 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151531eusmtip145daf13e958c69886e733e79cb8fb7ec~peyaIqQwf2051120511eusmtip1m;
	Thu, 19 Nov 2026 15:15:31 +0000 (GMT)
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
Subject: [PATCH v3 6/8] dma-mapping: document that arch_dma_prep_coherent()
 must handle highmem
Date: Thu, 19 Nov 2026 16:15:14 +0100
Message-ID: <20261119151520.2383226-7-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c
X-EPHeader: CA
X-CMS-RootMailID: 20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c
References: <20261119151520.2383226-1-m.szyprowski@samsung.com>
	<CGME20261119151532eucas1p10487bf51eee4909dd4f76a53e298690c@eucas1p1.samsung.com>
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


