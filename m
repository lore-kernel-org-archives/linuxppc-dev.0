Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48600606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tCKrdnen
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVfD40KRZz30C9;
	Fri, 20 Nov 2026 00:18:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795094291;
	cv=none; b=n65djK1hZ4/BEP/4WWVTEp6+ITDZ1VqxY1pmsQrI7kw8sCBWaz2plQN9GwjcA2RbZTq0tv+1mlEt4rKMht6BewGceNJ/Os68TAkp62tiVEdUDHKWk2ACZAuIfWF0uIFMaV3kh80PYlQ+IvFiK5Uaz009fDlxy7VRNKgyerk2+/OzTSiToNxtJOn5UtIfynLTrVEouVDSVKZ+mFz6kSykaQuzbCyMfQid0oDLy3am0Z10wk0qaCeJOkrjKfuN0kcRJdVugmCRl+SruX79hugMbfa/OQd0zRRAf9j/uLblIY9gJ4ekX0Z3v2y2UnghSPB5GDmlm0xWk38MDCJxQ7TEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795094291; c=relaxed/relaxed;
	bh=c4JodCXFJYsFjKsG9M4trE9wchuTecCsKm5CSZLC4hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XtV5V+I9GBiW627X/v6A2dFlcAHR8tkBs2YbP4L+aQ6XGfIwsPQxDUysUHzbx/on+vU0IVLxq6KvdnuGKpE8sopuX8vAbJwirX7igqTkQ8Xjz8h7usJGZMlGUEPEzHzi/FIDuBWYGhMJ0oYaIUJmQl0UymOubRJdq1Pr4J9HM8zueNNuCWUgi8pr93Q8maxXRBBnneJjxaLybK3qHcKh5qfI+mv1l8+81AeAm8dkd0s6BTwknZh66K8IUKRoiw/ovLgBHb3nZs0gbNgnonhQPHAyC6xwvIrIiIe4hFcStROQKmRoJ8ztK4q3zgdPPh1Szwm3qDYRaxLcgybjExkdjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com; dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tCKrdnen; dkim-atps=neutral; spf=pass (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org) smtp.mailfrom=samsung.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tCKrdnen;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samsung.com (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com; envelope-from=m.szyprowski@samsung.com; receiver=lists.ozlabs.org)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVfD20cLbz2xQK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 00:18:06 +1100 (AEDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119131751euoutp02ec1e724a6328b2ae4dec5a2f6ce78af4~pdLqeZ6b81208812088euoutp02H
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 13:17:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119131751euoutp02ec1e724a6328b2ae4dec5a2f6ce78af4~pdLqeZ6b81208812088euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795094271;
	bh=c4JodCXFJYsFjKsG9M4trE9wchuTecCsKm5CSZLC4hc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tCKrdnenBcm3IgpjF1SGdlm8gc80Rzy8MOKtLvZHDbZ4DzfnsSTC/cJYb64iIQeE0
	 hKy5i/cFoAD0ok+eLMz/0ElmTyA/dK0x6TappCbdLTAe7isXOWreRT5TypImh4S6th
	 9TGQZMmpSxkATQ+cLpVdE6FVbrBWriGKEhdwNoO4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119131751eucas1p188066757e9cd9eb57dbdceb523c9b7ec~pdLqNmLTa2917429174eucas1p1w;
	Thu, 19 Nov 2026 13:17:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119131750eusmtip1b09a8063fcb8f57bec92422ad0c4bde6~pdLpUEplc1427414274eusmtip1n;
	Thu, 19 Nov 2026 13:17:50 +0000 (GMT)
Message-ID: <2b64e853-89a7-4fa5-a4f8-2c6b0b62bf74@samsung.com>
Date: Thu, 19 Nov 2026 14:17:49 +0100
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
Subject: Re: [PATCH v2 4/7] powerpc/mm: handle highmem pages in
 arch_dma_prep_coherent()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, "Christophe Leroy (CS
 GROUP)" <chleroy@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig
	<hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov
	<jcmvbkbc@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <jym96n4p.ritesh.list@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119131751eucas1p188066757e9cd9eb57dbdceb523c9b7ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094850eucas1p1f10fa1473aca341473077f60a088b490
X-EPHeader: CA
X-CMS-RootMailID: 20261110094850eucas1p1f10fa1473aca341473077f60a088b490
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094850eucas1p1f10fa1473aca341473077f60a088b490@eucas1p1.samsung.com>
	<20261110094830.2081847-5-m.szyprowski@samsung.com>
	<jym96n4p.ritesh.list@gmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19.11.2026 13:07, Ritesh Harjani (IBM) wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>
>> arch_dma_prep_coherent() performs the cache maintenance on the address
>> returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
>> is NULL for a highmem page which is not kmapped, so the flush would
>> operate on the wrong virtual range and leave the dirty lines of the
>> buffer in place.
>>
>> The generic DMA code may pass highmem pages to this hook:
>> dma_direct_alloc() handles a highmem page returned by
>> dma_alloc_contiguous() by forcing the remap path, which calls
>> arch_dma_prep_coherent() on that page before creating the uncached
>> mapping. This cannot happen on powerpc today only because it does not
>> select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
>> there, but nothing in the hook's contract rules it out.
>>
>> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
>> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
>> one at a time. Without CONFIG_HIGHMEM it does the same
>> flush_dcache_range() on the linear mapping as before.
>>
> Does that mean, this change can add additional overhead for
> CONFIG_HIGHMEM=y kernels, where the buffer received still belongs to
> lowmem? (Because of extra per-page book keeping like
> local_irq_save/restore, kmap_xxx). Thoughts?
>
> Although functionally the change looks correct to me. But maybe
> __dma_sync_page() on powerpc side could use some cleanups (outside of
> this patch series perhaps).
Indeed, __dma_sync_page() could be improved by calling __dma_sync_page_highmem()
only for highmem pages. Something like:


diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index e646256365d5..199ce0467b58 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -97,11 +97,12 @@ static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
        unsigned offset = paddr & ~PAGE_MASK;

 #ifdef CONFIG_HIGHMEM
-       __dma_sync_page_highmem(page, offset, size, dir);
-#else
-       unsigned long start = (unsigned long)page_address(page) + offset;
-       __dma_sync((void *)start, size, dir);
+       if (PageHighMem(pfn_to_page(PHYS_PFN(paddr + size - 1)))) {
+               __dma_sync_page_highmem(page, offset, size, dir);
+               return;
+       }
 #endif
+       __dma_sync(page_address(page) + offset, size, dir);
 }

 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,


Do You want me to add it as another patch for this series?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


