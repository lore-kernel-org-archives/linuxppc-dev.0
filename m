Return-Path: <linuxppc-dev+bounces-28723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B7CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 08:23:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx1xm2h6Vz2yPG;
	Fri, 02 Oct 2026 18:23:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790929388;
	cv=none; b=XedQmOJPM+AJdjyJaUaUhOrObDHYY6tOQi6zUCfDzDHDP6bo1MXo0YvNUDtaOuJRheGFoahJZZDuA4HygEMGKzxS8L+2TOQ+k46LRC0QFR/rFCq3c9/qG1A4fMjAcheea9SARxT4yBtZiufauyqNhnGdR0cMCJfb5Tg1aoeHNUJZ7uBT+VaLYtOZcNn6vaMNn/I8MAq7gIJnoH3wr2afwMoyuMx/kmvm6WFlfUKDtg01QCqiVCmOD3ZnPadowa2z2/An8JZRcIaYNsEvhRM//qAYBu3ezUpfc4KmCPlqa0kXXeiZpaJwGTdrr7CnmZCD70Lm36jcBecGlHAOr3cVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790929388; c=relaxed/relaxed;
	bh=G/f9I4vHQK4JOyc+erbBtNclRJr/3Y4Kf9SezEHiCB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfoKRXGsCoLMjcQirlGcGjDr36AjkfPt//fGBuvdm6nX/jtqw4cXlahTRVcjgYpA8r+GzCZq+2sqInpYHlr8bBZwWCIuvpcPAzjmknyLzXC8RdLLmWSrW1TOorfzXc9SQtzVf4vfdBE58K5kzDEI6Xsr2h/bO5QE3OwdQ0VVYlAGiC9H2Il9ckCDabxIfXHZxK2Tgjeb4o/1dnzEQLMDNH79Qz6atdZ84s3WEkG4ySHsbiHpQKZsiythByd2S4bFXM1zUXDv8Hp+/HpSV9YiJ1GbDqBqkIp1KnXSBRsxhROM4RRuCd3GxsRMCMsKgBqopPI//IKhK+yUdXQqcBTQTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxfcHBD8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxfcHBD8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx1xl35Q4z2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 18:23:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A2B0160A6A;
	Fri,  2 Oct 2026 08:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB01F000FF;
	Fri,  2 Oct 2026 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929384;
	bh=G/f9I4vHQK4JOyc+erbBtNclRJr/3Y4Kf9SezEHiCB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HxfcHBD8rebzYNDmEhi6ZjEMfdZKUzhjRiJMId5JdydfC1VdWyb8c08N9eWtBVQDD
	 s8ik9RohZH4US83JNfPsnlk8g//6XwGPAYSZSRPl31LER1mBTyZgYsOP6gsIdd0tXy
	 nLTKGK1iGyLORSlzVOr6U7eeUq2VLTOa7+2TjgOF/DFKV0/MMF8BaQfnkxf64MzxSm
	 QR1mL6j6ja0eAy9STNBKy+bhwdvUtLq18bDlZgnYUnd+JP+TZ/wmn++l1Th5RBZj67
	 PnQXRbUhDXumsopPyQKJ5tmPfpqn8AdmtKB63Z0Mg+0rwMxgYTXHPogcXNKqrZLXFl
	 B+elqnABketew==
Date: Fri, 2 Oct 2026 10:22:55 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page
 init
Message-ID: <ar9p39Y9SmlxvbA_@kernel.org>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929053231.66085-7-songmuchun@bytedance.com>
 <ar5xbQsUpSQZg0wO@kernel.org>
 <78D5D6AA-BE36-432C-B0F7-453F93DF18C0@linux.dev>
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
In-Reply-To: <78D5D6AA-BE36-432C-B0F7-453F93DF18C0@linux.dev>

On Fri, Oct 02, 2026 at 09:48:42AM +0800, Muchun Song wrote:
> 
> 
> > On Oct 1, 2026, at 22:42, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > Hi Muchun,
> 
> Hi,
> 
> > 
> > On Tue, Sep 29, 2026 at 01:32:31PM +0800, Muchun Song wrote:
> >> For vmemmap-optimized sections, tail struct pages may be backed by
> >> shared vmemmap pages. Those shared pages must carry the same page zone
> >> ID as the struct pages initialized for the section.
> >> 
> >> Warn in __init_single_page() if the shared tail page has a different
> >> page_zone_id(), which would indicate inconsistent initialization.
> >> 
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> Acked-by: Qi Zheng <qi.zheng@linux.dev>
> >> ---
> >> v3:
> >> - Collect Acked-by from Qi Zheng
> >> 
> >> v2:
> >> - New patch.
> >> ---
> >> mm/mm_init.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >> index 1650d6bc1211..bd02e8d06965 100644
> >> --- a/mm/mm_init.c
> >> +++ b/mm/mm_init.c
> >> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
> >> if (!is_highmem_idx(zone))
> >> 	set_page_address(page, __va(pfn << PAGE_SHIFT));
> >> #endif
> >> + 	VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
> >> + 			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
> >> + 			page_zone_id(page));
> > 
> > Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized a tad later
> > than page so it'll have stale data in the page->flags, won't it?
> 
> Lance is right. The shared tail struct pages are already initialized by
> vmemmap_shared_tail_page() during vmemmap population, so they're not stale.
> The head 64 struct pages are initialized later — right here, after vmemmap
> population.

Still it looks out of place here, can this check be done in sparse-vmemmap
somehow?
 
> Thanks,
> Muchun
> 
> > 
> >> }
> >> 
> >> #ifdef CONFIG_NUMA
> >> -- 
> >> 2.54.0
> >> 
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> 
> 

-- 
Sincerely yours,
Mike.

