Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D26606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=m3vwdRBI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVmqC2ctbz2xLF;
	Fri, 20 Nov 2026 05:15:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795112135;
	cv=none; b=AwsZ4fUWY5HFE1iVnzJyXHrANfRqt1ZSa0f05i2rP8h57uii85FdlOm/b6aWnHahg6ekPeHus6MDdGyqFJU7Q3QIT3ogz/nSROtzYXZvBolSfpe4QXZ0UTgR7+PLEC811NnPlbJEOvYK9E+c7bSNIMVQ8zuf5QcTFQ4lZnrKaWd3p5KlU4QtJ/mCO9EZSHT/x6iTkk2tRNSAHobcIClxHpZ0iQ+kN/4mBmTHkpnc19oXXdhYpjG5HMhfkFWnqRn4Mtj+2UZGa2B506lWKyP5aGRWBDqMCcTA6bZDyvXEcwY7iHC74L7XyZbVejGJadSntLdxPXE17GAfvquLhr7Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795112135; c=relaxed/relaxed;
	bh=mqGkD9I85lMxxh2pXUJtphRW9gwZyygiSvkEg9y6zhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=dnFTaIzTutb4/6tMjNPdMTxJqw+Ldvfn7WciNG9B5d9FdBz5ORrzqUZgME/kL2biEwq8pa3wlVezDobJAhkbXy5cfx11/CmrSt2r32rIbFGgeCrHSMrgDRFf/x16PHfRgyKlBtIqOwCTyTXbQOvAEjXO+6dB9huXVWeMA8el8HO8Shjy0U303oueCmUBQ8RGBGO/UB5lGSdQDUCSYRrx61JZ5CLckPmgU0bPwJZMmA91r67T9E9cEZ5MybblczqdVVpqr+Oc5nV9b4JqDHr4iUB+z6o9WHJ4rSrvUdNBSCSzvyHRJW2Re85stA4+MB9Y4jLIR5SIYajRoI4Mq/U12g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=m3vwdRBI; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=m3vwdRBI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVmq858KXz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 05:15:31 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119181521euoutp02b0a7e28b360f51570e6c491b8a020bd7~phPagpFVq1500415004euoutp02B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 18:15:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119181521euoutp02b0a7e28b360f51570e6c491b8a020bd7~phPagpFVq1500415004euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795112121;
	bh=mqGkD9I85lMxxh2pXUJtphRW9gwZyygiSvkEg9y6zhg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=m3vwdRBIFQ+xJcwYjPZUilKlUyqOuRlXHG+GoDe3w3tVL80BjVNUIOuqx9BdV299U
	 LSWlUw7lWPZVxqSZJvxwWpozPn2D8yudVaik143glGyt0vDTL+N/6Ki0Lhy3K6r0Nx
	 +1eyxGxqyfZLYbp8mj79YuHQPO6Hpz8+L4+ZEf6s=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119181520eucas1p15056e661966e438ca7fcf5f4cc6f83da~phPZc8smn3120131201eucas1p1R;
	Thu, 19 Nov 2026 18:15:20 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119181518eusmtip1f369868376049534c22cce45c363981b~phPYUTA913171431714eusmtip1Q;
	Thu, 19 Nov 2026 18:15:18 +0000 (GMT)
Message-ID: <8cbec036-10ec-4fd4-81a7-2235260985a0@samsung.com>
Date: Thu, 19 Nov 2026 19:15:18 +0100
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
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/7] dma-mapping: DMA_ATTR_NO_KERNEL_MAPPING related
 fixes
To: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig
	<hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy
 (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)"
	<ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris
	Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261119151520.2383226-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119181520eucas1p15056e661966e438ca7fcf5f4cc6f83da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151527eucas1p16c69a0580b2caabe66f952572362021f
X-EPHeader: CA
X-CMS-RootMailID: 20261119151527eucas1p16c69a0580b2caabe66f952572362021f
References: <CGME20261119151527eucas1p16c69a0580b2caabe66f952572362021f@eucas1p1.samsung.com>
	<20261119151520.2383226-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19.11.2026 16:15, Marek Szyprowski wrote:
> arch_dma_prep_coherent() is called by the generic DMA code on pages
> which may be located in highmem: dma_direct_alloc() forces the remap
> path for a highmem page returned from CMA and calls this hook on it
> before creating the uncached mapping. However, the hook has never been
> documented and some implementations assume that the page has a kernel
> linear mapping. This issue affects MIPS, xtensa and PowerPC. It gets
> fixed by patches #2-#5.
>
> xtensa also only invalidates the cache, which discards the zeroes
> written by the dma_direct_alloc(). Patch #1 switches it to a
> writeback+invalidate.
>
> Patch #6 documents that arch_dma_prep_coherent() must write back dirty
> lines and must accept highmem pages. With that in place, patch #7 drops
> the PageHighMem() check in dma_direct_alloc_no_mapping(), which so far
> skipped cache maintenance for highmem CMA pages allocated with
> DMA_ATTR_NO_KERNEL_MAPPING.
>
> Patch #8 makes dma_direct_alloc_no_mapping() always return zeroed
> memory, like all other dma_alloc_* paths. Passing __GFP_ZERO is not
> enough there, because CMA ignores it.
>
> The analysis and the patchset was prepared with the help of an LLM. The
> code compiles fine, but it has not been runtime tested on any of the
> affected architectures yet. Testing on real hardware would be
> appreciated. I've reviewed the resulting changes.
>
> I plan to merge this via my dma-mapping tree, I can provide a tag if
> needed for merging it also to arch code.
>
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland


Merged into dma-mapping-for-next, with Fixes tag dropped in patch #5
as requested by Ritesh. Here is a stable tag if one needs to merge
this patchset also to arch tree:

git://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/no_kernel_mapping_fixes

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


