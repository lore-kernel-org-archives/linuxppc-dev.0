Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863060A5BD7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HMuSmK0v
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhqd3jNSz2xNT;
	Fri, 20 Nov 2026 02:15:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795101341;
	cv=none; b=fFHc+3X6C8PFkRVV65zJoP/rfAAJF+v4zEgXBdK+iOy+VEInpGSCpSLEBHLWESIlaGt6VeL53bWfduAT4RVvbfWrX3Icm+S1qe4r0Ol8n1zf1oDW0tBAqYRmaO46IXXOnfudGm5/ezFHPwyRY6bGj03plBbWWI9pK8faLOFwY/ZDxwCQ/Mxe+8Oq+sDwU6LPJhcJG4Y5L4dJAcpbT6JOmu2ZR7bGv/Zsk1GyHat+igGBwjEH2UGmezWopkXsX3mgSPwY2RjRRkddF9RsfS6SiTq0B05KzbrzBLbTS9cSw+04Ag7MQFFZ2YtJKta7Zon4ICwhdOhJkjIwfQ+YXqiL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795101341; c=relaxed/relaxed;
	bh=IEgW4twElg7BhRZOum7kSGP0qGy7dRuOCQhsK+aKtks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=RicJ7a3C4lSNIhtyI21yxGdohmEbhTCGcI9RdfPy526ubLOjnKTat2LuNDx9CTXYct/SR70wCFrlE54AZADh1kFC4VF+5ao4k8zL7p3g4GfFF/eu/UDb5tvSxZt5a6OB1f3O9zso71rKGmtEhTUqNOeUUNOes4tVBYL9tYgsE+ruTKb0MzoEdXr2AHKZyDnyZaN/guoyA7NnMTk8fCbw6ciYv5mwswVEV1grc8kmIByzVlmDPDQ1KxdsmKP6K8hkn1Gu5whmeFh+DOVNaKm5n473v0xyARQGVIof8iSxkQ+1jRuv4Q9F0Od4SXWErnNDtN6GWSyG5R46HX+hV5/tGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HMuSmK0v; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=HMuSmK0v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhqZ61wHz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:15:37 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119151527euoutp02dcc92a6790678eb55bd0f438169c8f36~peyWK_vF71770917709euoutp02L
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 15:15:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119151527euoutp02dcc92a6790678eb55bd0f438169c8f36~peyWK_vF71770917709euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795101327;
	bh=IEgW4twElg7BhRZOum7kSGP0qGy7dRuOCQhsK+aKtks=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HMuSmK0vciD8RQGkLfrGpUJnZ/srENN84PugIdOxj5JSWTkIGDD6tTavunOO6WZZ2
	 Dv8bGAWh51j/oqkkq0CWmHRthTtvQG6LfLNUK5tNV11GmlhAbmrQTpKUs78iPzC7hg
	 OYW5+r+O2cAZYSRgQ03VO2Kg1HPdiyNKPLJmZ13I=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151527eucas1p16c69a0580b2caabe66f952572362021f~peyV3V5AX2357323573eucas1p1Z;
	Thu, 19 Nov 2026 15:15:27 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119151526eusmtip134f5dc711c4d05cf83c876262b52330f~peyVHCLrD2050420504eusmtip1r;
	Thu, 19 Nov 2026 15:15:26 +0000 (GMT)
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
Subject: [PATCH v3 0/7] dma-mapping: DMA_ATTR_NO_KERNEL_MAPPING related
 fixes
Date: Thu, 19 Nov 2026 16:15:08 +0100
Message-ID: <20261119151520.2383226-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261119151527eucas1p16c69a0580b2caabe66f952572362021f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151527eucas1p16c69a0580b2caabe66f952572362021f
X-EPHeader: CA
X-CMS-RootMailID: 20261119151527eucas1p16c69a0580b2caabe66f952572362021f
References: <CGME20261119151527eucas1p16c69a0580b2caabe66f952572362021f@eucas1p1.samsung.com>
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
fixed by patches #2-#5.

xtensa also only invalidates the cache, which discards the zeroes
written by the dma_direct_alloc(). Patch #1 switches it to a
writeback+invalidate.

Patch #6 documents that arch_dma_prep_coherent() must write back dirty
lines and must accept highmem pages. With that in place, patch #7 drops
the PageHighMem() check in dma_direct_alloc_no_mapping(), which so far
skipped cache maintenance for highmem CMA pages allocated with
DMA_ATTR_NO_KERNEL_MAPPING.

Patch #8 makes dma_direct_alloc_no_mapping() always return zeroed
memory, like all other dma_alloc_* paths. Passing __GFP_ZERO is not
enough there, because CMA ignores it.

The analysis and the patchset was prepared with the help of an LLM. The
code compiles fine, but it has not been runtime tested on any of the
affected architectures yet. Testing on real hardware would be
appreciated. I've reviewed the resulting changes.

I plan to merge this via my dma-mapping tree, I can provide a tag if
needed for merging it also to arch code.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Changelog:
v3:
- added patch improving lowmem handling in __dma_sync_page() (PowerPC
  arch) to avoid performance regression in latter patches
- added fixes tag to "powerpc/mm: handle highmem pages in
  arch_dma_prep_coherent()" patch
- collected tags

v2: https://lore.kernel.org/all/20261110094830.2081847-1-m.szyprowski@samsung.com/
- fixed minor issues in comments and patch descriptions pointed by sashiko
- dropped RFC annotation

v1: https://lore.kernel.org/all/20261106225628.215319-1-m.szyprowski@samsung.com/


Patch summary:

Marek Szyprowski (8):
  xtensa: write back dirty lines in arch_dma_prep_coherent()
  xtensa: handle highmem pages in arch_dma_prep_coherent()
  MIPS: mm: handle highmem pages in arch_dma_prep_coherent()
  powerpc/mm: skip kmap for lowmem pages in __dma_sync_page()
  powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
  dma-mapping: document that arch_dma_prep_coherent() must handle
    highmem
  dma-direct: do not skip cache maintenance for highmem pages in
    no-mapping allocations
  dma-direct: zero memory allocated with DMA_ATTR_NO_KERNEL_MAPPING

 arch/mips/mm/dma-noncoherent.c    | 10 +++++-----
 arch/powerpc/mm/dma-noncoherent.c | 16 +++++++++-------
 arch/xtensa/kernel/pci-dma.c      | 12 +++++++++++-
 include/linux/dma-map-ops.h       | 11 +++++++++++
 kernel/dma/direct.c               |  9 +++++++--
 5 files changed, 43 insertions(+), 15 deletions(-)

-- 
2.43.0


