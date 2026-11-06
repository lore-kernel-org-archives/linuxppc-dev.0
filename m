Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DE606A32D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IZM7+FZh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLvh42l43z2yTQ;
	Sat, 07 Nov 2026 09:57:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794005828;
	cv=none; b=eb/mdoEwiceUpJiNft7OU+AxwUv8ljYdP63R7g79VO7hYfl9WoIZqbE5Fx8XpW5XL/CrXNlYVKyXDfGUmsyMS/EtXoDnnMkaMUS7becQaHw7Q79Yj3FavsozimWRMPj3EBGgMGVXtvDqXIc6enuAcbkOZcflIKfrAxyKxltxX13r7h02teG2a0c1o15C+QywZhZPxsXeT589UakDylHzsRmWj86z5b6VMz1kKKbblZNGCRKCDJsBIZgq7IR3WQw4A3eRtJwYVvzkjywk1U14CPBUt6F5W54oGoisVyjGrb8jHlYgd8jS55Y1qgeD5wyE7McD6I2K0jCepwlkWs8m0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794005828; c=relaxed/relaxed;
	bh=6ox8H2SB0a9cHlZt4WIpVZ59gqLnArKdF1x3visfTJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=QBELmyxehVqX/AJR47Cdh9EoIqtQDgLwzMek12/1w7r2aAPOiJlmLSq42Uf+bMqIeozEho0CJg5gzaK9cddgE3exZw5iqVQ7qhrEsvq/xDwZ1rtOaI58BeaKRc+wGvbUo01ZWmnmjssYMdF/AevxUx7OcrEvkAkESBaKIJZZyC1uV0OUVn99v/rWgnvyKtyuHtKqi9/O0t/drm1fb+r3k41hovgprKzVkB7glYouU5AC+9/CDjb8nCngOqdaZannhzQnmZvPQdpio94qmfjfpMbhsxAYX/kuVdrvvnRC8vRB55Wo+fSBbYbMXgUkFnGesMvup5ACtleXdpGN5RJHhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IZM7+FZh; dkim-atps=neutral; spf=pass (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IZM7+FZh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLvgy0zFtz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 09:57:00 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261106225649euoutp01ae9fd352945326f1de355111460e8c98~llsdXryz41319313193euoutp01C
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 22:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261106225649euoutp01ae9fd352945326f1de355111460e8c98~llsdXryz41319313193euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794005809;
	bh=6ox8H2SB0a9cHlZt4WIpVZ59gqLnArKdF1x3visfTJw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IZM7+FZh8nsiweFEbAr0S3ZBsmbv8xwZ4jOUX8inhKF5v/yJTgP1akoT3Aj2jFMgx
	 Eji0XU5WCYKJhcEaNstqcJZVqsMW7E+w40TXJDosvfiUQrIZcYvoTDcOhrVrErgUpK
	 ik4cCX3X6Kl32h0Urj/VJsYCneZ/8WsyAvpX56IE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc~llscO712W1955019550eucas1p2p;
	Fri,  6 Nov 2026 22:56:48 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261106225647eusmtip2ed800cd9a277538d08247abe06f701a8~llsbgLFSy2228922289eusmtip2P;
	Fri,  6 Nov 2026 22:56:47 +0000 (GMT)
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
Subject: [PATCH/RFC 0/7] dma-mapping: DMA_ATTR_NO_KERNEL_MAPPING related
 fixes
Date: Fri,  6 Nov 2026 23:56:20 +0100
Message-ID: <20261106225628.215319-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
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
X-CMS-MailID: 20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc
X-EPHeader: CA
X-CMS-RootMailID: 20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc
References: <CGME20261106225648eucas1p27da7cef5cdecc76ee6a3e0c1f0a20dfc@eucas1p2.samsung.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

arch_dma_prep_coherent() is called by the generic DMA code on pages
which may be located in highmem: dma_direct_alloc() forces the remap
path for a highmem page returned from CMA and calls this hook on it
before creating the uncached mapping. However, the hook has never been
documented and some implementations assume that the page has a kernel
linear mapping. This issue affects MIPS, xtensa and PowerPC. It gets
fixed by patches #2-#4.

xtensa also only invalidates the cache, which discards the zeroes
written by the dma_direct_alloc(). Patch #1 switches it to a
writeback+invalidate.

Patch #5 documents that arch_dma_prep_coherent() must write back dirty
lines and must accept highmem pages. With that in place, patch #6 drops
the PageHighMem() check in dma_direct_alloc_no_mapping(), which so far
skipped cache maintenance for highmem CMA pages allocated with
DMA_ATTR_NO_KERNEL_MAPPING.

Patch #7 makes dma_direct_alloc_no_mapping() always return zeroed
memory, like all other dma_alloc_* paths. Passing __GFP_ZERO is not
enough there, because CMA ignores.

The analysis and the patchset was prepared with the help of an LLM. The
code compiles fine, but it has not been runtime tested on any of the
affected architectures yet. Testing on real hardware would be
appreciated. I've reviewed the resulting changes.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (7):
  xtensa: write back dirty lines in arch_dma_prep_coherent()
  xtensa: handle highmem pages in arch_dma_prep_coherent()
  MIPS: mm: handle highmem pages in arch_dma_prep_coherent()
  powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
  dma-mapping: document that arch_dma_prep_coherent() must handle
    highmem
  dma-direct: do not skip cache maintenance for highmem pages in
    no-mapping allocations
  dma-direct: zero memory allocated with DMA_ATTR_NO_KERNEL_MAPPING

 arch/mips/mm/dma-noncoherent.c    | 10 +++++-----
 arch/powerpc/mm/dma-noncoherent.c |  4 +---
 arch/xtensa/kernel/pci-dma.c      | 12 +++++++++++-
 include/linux/dma-map-ops.h       | 10 ++++++++++
 kernel/dma/direct.c               |  9 +++++++--
 5 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.43.0


