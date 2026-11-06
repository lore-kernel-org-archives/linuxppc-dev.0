Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E99606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=H/SzY1mw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLvh537pGz2ygd;
	Sat, 07 Nov 2026 09:57:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794005829;
	cv=none; b=mBeMz2euky4OjsARtpT14k+3NEdB21vXbIl0Y5xtCj1Y45GVAFq6sTb3Koi2iVEx1izVwl2fW5iTw2goPjRLo7fPMu83IrFZ0QuDlkY/V+r71MlOA+0E/Nk7CT7am5yT65Pqmp3dEBA+tA7zQLel60Y8aiXPg5yEj/5ZqDjq/IluFC2d1lrc0xoSV1bPASZrmN6ms2c49ah2xvM+qqA1NOaZml0LD8Viw6wPy8bkwMre0CoGC7Avc6yiwkNxj4NDPyFhwXqxyqQM/ka52VBYHGo/t6uLQDSMaJUhL13rjoLXDPWAuTgmsZ2G+wriS92Ni28YpJ07kBAHzsZ39B/RZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794005829; c=relaxed/relaxed;
	bh=Xydf7D1Ug+18o9KjDGYgg5Q3bZN62iLYwR2p/Rz26AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=RW6JHwRMLsh7q2wt27/tL3Fl92VHeaSjIbsZAMlge5/r8usyqj9AOCSC0IVG+oEa8F19hU9eSOQFKhpILWRkzUW1GH1XbiMw3t/YCYsOnX66+4PvFRhRrl5FpCEZiKOfZtEcYyzvWHRECYintrEWeGXUUTayJj7VXNERxYYajFWSHVv1CkP1PTIf9AiV5OITWlzMcqD/f+Joy5rJboq6yMFTgB6e7lxHCTySTMp6VuaV8JIVcWoXsSPyN6MHO0jFIGek6WpkXt8w+/65pa7SCuedQtpWMLJQvPs7LC2ZZ1hiTE2zdPulPaYAx8oLTCXZLkCcqJn1A8HStVkRavYgVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=H/SzY1mw; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=H/SzY1mw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLvgz11cxz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 09:57:03 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225653euoutp01d242709ee7d50e411b9e8a9d7592ead6~llsgtMOvp1250812508euoutp01R
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 22:56:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261106225653euoutp01d242709ee7d50e411b9e8a9d7592ead6~llsgtMOvp1250812508euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005813;
	bh=Xydf7D1Ug+18o9KjDGYgg5Q3bZN62iLYwR2p/Rz26AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/SzY1mw3mA6Z56q3lZIMvfdcOBCrjc7dZDwRy01StWAF29fSNkLI3cm9/QjHG8/K
	 +44jfsOED7g7OjoBjFSu/K7Bt06FRI0BtX7WTeHmXIe0R3pvD3TWhEkAo+1fygM5bN
	 Ia4zVxYOK2nMvHb0NRTYr0NEst0n2+9TZA4BILts=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e~llsgXlFuR1955019550eucas1p2s;
	Fri,  6 Nov 2026 22:56:52 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225651eusmtip2930bd7ce74f96343191502d22feeb09d~llsfogufy2228922289eusmtip2U;
	Fri,  6 Nov 2026 22:56:51 +0000 (GMT)
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
Subject: [PATCH/RFC 5/7] dma-mapping: document that arch_dma_prep_coherent()
 must handle highmem
Date: Fri,  6 Nov 2026 23:56:25 +0100
Message-ID: <20261106225628.215319-6-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e
X-EPHeader: CA
X-CMS-RootMailID: 20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e
References: <20261106225628.215319-1-m.szyprowski@samsung.com>
	<CGME20261106225652eucas1p2d4da27e923c75a7460861531bb01b60e@eucas1p2.samsung.com>
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
 include/linux/dma-map-ops.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b..0c90e205df15 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -371,6 +371,16 @@ static inline void arch_sync_dma_for_cpu_all(void)
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
+ */
 #ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
 void arch_dma_prep_coherent(struct page *page, size_t size);
 #else
-- 
2.43.0


