Return-Path: <linuxppc-dev+bounces-20218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5069FF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4XGC4CBnz2xld;
	Tue, 28 Apr 2026 17:32:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777361571;
	cv=none; b=cdovURSgyHnfttowTPSlCKLl1JsRXI6XGXC5JV9zcrOL5H5fcqWnsHqhAgF9c0pmvc4GN3KhiBy0HozD4yyXbhSKlD03U+c+tue/Tb/F8L2feRkH1PZatLyd+0kEzl+7HsVYKlc/gt7dZlVJYe5DsYO3Q+CW8Wxl2UUrLIJbB3kIksEpuLgs+fj9MzCinsCtTWRcR3/70I3XnNLd9PkMpq62JZlFAhqq3UL7qS/WLB4xgOtGBhWFgWJEr+YqjXj5WYGoKsyceCRZnE51/zSQXsaVRBbP2HrH5LdFDCWW6stqZ6Eb4dlGC7p3t/Vws0KRXZ7NDGQPYDH7ye/+T99aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777361571; c=relaxed/relaxed;
	bh=k12cCujQ2Gzo3MspddaiLfy8AcAN7OgiJ75sz5W+vT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU3nbwqTVWJQ+jE0dlt75MRS+aGXeZi3bsztMQpMWC3WfK1/8SVvla/Ksd+thkNJiKCC3uJ+ztL5qLWQaO86RUuvrD98il2+ycbRv51+w01iUpy9TZfAJ+VNqeTOHNunl1J2xxpHU2wec+gDOM4wwCvccWCTJC4/xC1g5yCyc/5A6pDxrV03FAyb2Hg9BNiCgQdJnnWjNQNXi8cvd0DA3soP1pPZdNexda4NAwzA/Dr2kS3KLByORMhh8Ll3blp3L0gJqBwc6poxveT4Rr8RsAnirZ96DHxM0m6EO8x4ttaC4/njcnkN/4Xqcc10GQyL6YYbLR+mtkZH7C2xpJaxdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KS7VVKWJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KS7VVKWJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4XGB6dVgz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:32:50 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 161C4444C1;
	Tue, 28 Apr 2026 07:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE54C2BCB8;
	Tue, 28 Apr 2026 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361565;
	bh=bivJkrDnkum5vfxFBGBfafZmKUqFTGG/gO14qECezIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KS7VVKWJYg+OP508UYe/zMGahM3pGjCvFKJNFgui6nFLKxhqcyUTWKExOOt/iPanR
	 1kpLWf3iizL3uPEkGZDnNELXdYcSQmR2QOME22VyoIok8i+xmr0YrQ82VEzaqP4hSd
	 kRkad5IRChKSJvPXOs9HjfC+HvNs2zfMj2hjHJXF8XzM/c51ES4I1dWBRptVLPgF9+
	 J3JdUsgduxLtmu8U4FMz4gPuVsoijnN0Uc2lZZHHNSLm4EJlzt1Juucu6EAMcKT16O
	 5IqdNjee3CXQ3PJCrp1Am+EErSqQV9mjC24edo3savF+AJDqw3zjJGobF99o8doFuv
	 ZWBbcOfL84Xiw==
Date: Tue, 28 Apr 2026 09:32:36 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/49] mm: panic on memory allocation failure in
 sparse_init_nid()
Message-ID: <afBilACQByFLa-hi@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-10-songmuchun@bytedance.com>
 <afBaMEBoR_35Fblc@kernel.org>
 <96DB49C7-A7C2-4F53-8321-FF4A4ECDFF95@linux.dev>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96DB49C7-A7C2-4F53-8321-FF4A4ECDFF95@linux.dev>

Hi Muchun,

On Tue, Apr 28, 2026 at 03:02:14PM +0800, Muchun Song wrote:
> 
> >> diff --git a/mm/sparse.c b/mm/sparse.c
> >> index effdac6b0ab1..5c12b979a618 100644
> >> --- a/mm/sparse.c
> >> +++ b/mm/sparse.c
> >> @@ -354,19 +354,15 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
> >>    unsigned long map_count)
> >> {
> >> 	unsigned long pnum;
> >> - 	struct page *map;
> >> - 	struct mem_section *ms;
> >> -
> >> - 	if (sparse_usage_init(nid, map_count)) {
> >> - 		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> >> - 		goto failed;
> >> - 	}
> >> 
> >> + 	if (sparse_usage_init(nid, map_count))
> >> + 		panic("The node[%d] usemap allocation failed\n", nid);
> > 
> > Please consider using memblock_alloc_or_panic() in sparse_usage_init(), it
> > would simplify the code even more.
> 
> Hi Mike,
> 
> Yes. I have several more updates for v2. Please hold off on reviewing
> the current version to avoid wasting your time; I’ll send the new one
> over shortly.

Thanks for the heads up!
I'll stop for now :)
 
> Thanks.

-- 
Sincerely yours,
Mike.

