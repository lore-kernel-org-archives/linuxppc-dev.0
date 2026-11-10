Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725EB606B9CD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=t5H7erzo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP20x58hVz3dng;
	Tue, 10 Nov 2026 20:49:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794304145;
	cv=none; b=K1r6yumbqFJ1VL9uxja5v89A+h67Hqlu9PJq6LSphuE6u5cbjsQjYuDh9L3BVVdvI8cTBuyO9rc1RuAKrsDOuplDHLJWVhPDzqyOlyNi+3nXZPr1/pMSORucA8sihqjGaGrnpwcltvBGmAhXe/ZI7hiwXFefAvd4dFp54kBGP1Don9Kj07xkmYRGpm8ZWOBVEzYJ6AmibTz0ikWjUWTm6TE/qx4SAVKtxzCBbfqBEuxstP8frsq62as/o2aYyHX8+hb/c6nbGp7+1cI4q6O9Lte7JedeiOUZW4sF/I5z0bbOQSoe1rqN+4lq6s/gxwQnjF2z2Fd24P1F5WPRdufe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794304145; c=relaxed/relaxed;
	bh=3WfehI9fQijRo2A/YkZKLEEsknJgbPS4DyEKhXbP7KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=RRwjjzWk8xdStHWaRfdJvooUKwQbU3TzXZGJUspaKneJkUa2WTCJUXb2g0CceJl9bKxYjiP5Utgqx5GZ5OuSdN27yesIbA7GW6R9fNkpE/+T6LWklIQ7TI18G3h62ejCz86zQpLvGU6QfzWwZrT85Otcw2K0PglrKoPQ355mIT2bYN4AgfsnOTWhqP1bpAJ1sYEs/u8PO1iRBr84gSuxHCDrHQ6I+y0xfHLEANfyiTrKPfRhLu5j+ZEBIRj4Z+Zi/qtwx4EH7oCIckB2TQHPRcJmc9xWumzfXJnNLf6zhwmUdxj8R5e2im+TQxHU66oWIH5BZWTFQUUa3z8whrOluw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=t5H7erzo; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=t5H7erzo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP20q4QCxz3dnN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 20:48:58 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261110094847euoutp024433eb84b9e8870e78893d0597f90535~mphjqumUn2947129471euoutp02z
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:48:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261110094847euoutp024433eb84b9e8870e78893d0597f90535~mphjqumUn2947129471euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794304127;
	bh=3WfehI9fQijRo2A/YkZKLEEsknJgbPS4DyEKhXbP7KQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=t5H7erzotTjNcdaOkmaz3M4aA0Bqymkk4HSUDa58RSqUxDGN6OQYsxVyl1jgVDKGD
	 bLjcVFp9RRWjiC9Fcd+zIkUM6TTLjMXbv3wVY4MDaONJLRjuve1I7MrmM00BC+kuY9
	 Ah8MaNnhV/y3AztJNjfW33hOf5Z0Whnj6YtDNxQA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51~mphjEO8nd1080110801eucas1p1W;
	Tue, 10 Nov 2026 09:48:46 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261110094846eusmtip14801004a391e04a621db015af3a4d45a~mphiUYlbM3235732357eusmtip1b;
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
Subject: [PATCH v2 0/7] dma-mapping: DMA_ATTR_NO_KERNEL_MAPPING related
 fixes
Date: Tue, 10 Nov 2026 10:48:20 +0100
Message-ID: <20261110094830.2081847-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51
X-EPHeader: CA
X-CMS-RootMailID: 20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51
References: <CGME20261110094846eucas1p140d5ebfe71b47d4e4b5e2162ba051c51@eucas1p1.samsung.com>
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

I plan to merge this via my dma-mapping tree, so I would like to get
acks from xtensa, MIPS and PowerPC arch maintainers.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Changelog:
v2:
- fixed minor issues in comments and patch descriptions pointed by sashiko
- dropped RFC annotation

v1: https://lore.kernel.org/all/20261106225628.215319-1-m.szyprowski@samsung.com/


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
 include/linux/dma-map-ops.h       | 11 +++++++++++
 kernel/dma/direct.c               |  9 +++++++--
 5 files changed, 35 insertions(+), 11 deletions(-)

-- 
2.43.0


