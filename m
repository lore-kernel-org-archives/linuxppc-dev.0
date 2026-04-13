Return-Path: <linuxppc-dev+bounces-19689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECF1F34C49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 12:05:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvR1H5sLZz2ydn;
	Mon, 13 Apr 2026 22:05:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776081907;
	cv=none; b=VlpZ9jlr6y2rBTQ+UIkm/zlZBnJfLddIlZ7ZfvR9hBx5mYwthH+2bnHP5PQqjNii7A8MiDIBfo9QupTT71gWiKz3oyaOB9HHvQ++7EDjcbbfMuTb/CVsrvE3JK25FU0qwAnJ6dhcGPoW3UDTtAaIdnlAEREe8suOLSajpwebfSoh0VarvtaidMyg8VrD074MEMAqabhSAsf3taQqd/a8/DRvY1/hctJ/B9cirHOT+yHvfWnp7NL8hs4i6a5GDUG/y4IiUdYtdGwdGunKe2hL1eMmAChLQPEMk0MwSxG+s/D0efQNeKpAdcILDiWBBp5RGbyjaVo3S/6c65EzH6+ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776081907; c=relaxed/relaxed;
	bh=NH2W+2csUqWt6/5/R4OcEjsSkmHjk2BuSHBIUQjDBks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkUtvgBTC18d+CPhJzw8L9PUln5ZSYv5/SG+91q2hehVYIAnk1yGpvOrrtZ1dlAICbU2jw0HGfS/DaqkxaMM+WKvzUHMGaen8f1HeZmdG2f+YvsCogLCYapLAs+vq8OGp1RJovg/h8syl2tfwrUbmROA0x/lYhM+Av3Ie6kueI4d9taTUZtbk2t0SX/AsWmj3dQzzg79ivhbHfBbc5EyZGN3DzMe941bI2BNyYs1UUcJPi0ohnCEJSdcfgkBAQVqu9V4wBwDg1hZ+2bhANwqDZRgWemH/6TzsvHJk/yAh2cR9sk7jb/ATiRIblJ8iwAbfVs1oB63TJxLecrDuGzkDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=at+QCcd8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=at+QCcd8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvR1G6XzZz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 22:05:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EAF2060180;
	Mon, 13 Apr 2026 12:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EFDC19421;
	Mon, 13 Apr 2026 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776081903;
	bh=cSo4sEdsNwlz/Iqs10U18EHsNdWWL3XI+9TPegcabV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=at+QCcd8hldAMXHMewcQlTRTSnPiYtb+AMBMRvJ2S3KRydAkuWOSAT5L5UCYcSoX/
	 ROa9bELImeOFvQzvTvpDpcl4kesvAFWZEWDTyLABjzRsnNsdUqSTmHo8oGoko42yP1
	 ySfzT1F5fS+ieBGBLG+LF/vt9HIB747aetWSZlmf5ZsXJNo8GFsCT2SCUVjsNcF0+D
	 Y6DQqlHoXOTwKiulifQcVyMaqFKxVh70yge0I5RxWAyvSyVsOM3ft5xcsQIebGm+6U
	 4yi40VjDnwrKe0gqOTVZYA/w2Lw0t9gyBbQ8clbAsFDUDIHE47hCCod4Zw1isILUZB
	 tqQdQ9IAZeV3Q==
Date: Mon, 13 Apr 2026 15:04:54 +0300
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
Subject: Re: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on
 memory hotplug error
Message-ID: <adzb5o9aWxFWphRK@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-2-songmuchun@bytedance.com>
 <ady1LQMN1xhPGcuT@kernel.org>
 <ady40BWw5WgQHf3z@kernel.org>
 <35454ADD-C983-4577-997E-884266C56FB6@linux.dev>
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
In-Reply-To: <35454ADD-C983-4577-997E-884266C56FB6@linux.dev>

On Mon, Apr 13, 2026 at 05:49:17PM +0800, Muchun Song wrote:
> 
> 
> > On Apr 13, 2026, at 17:35, Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > On Mon, Apr 13, 2026 at 12:19:50PM +0300, Mike Rapoport wrote:
> >> On Sun, Apr 05, 2026 at 08:51:52PM +0800, Muchun Song wrote:
> >>> In section_activate(), if populate_section_memmap() fails, the error
> >>> handling path calls section_deactivate() to roll back the state. This
> >>> approach introduces an accounting imbalance.
> >>> 
> >>> Since the commit c3576889d87b ("mm: fix accounting of memmap pages"),
> >>> memmap pages are accounted for only after populate_section_memmap()
> >>> succeeds. However, section_deactivate() unconditionally decrements the
> >>> vmemmap account. Consequently, a failure in populate_section_memmap()
> >>> leads to a negative offset (underflow) in the system's vmemmap tracking.
> >>> 
> >>> We can fix this by ensuring that the vmemmap accounting is incremented
> >>> immediately before checking for the success of populate_section_memmap().
> >>> If populate_section_memmap() fails, the subsequent call to
> >>> section_deactivate() will decrement the accounting, perfectly offsetting
> >>> the increment and maintaining balance.
> >>> 
> >>> Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>> mm/sparse-vmemmap.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>> 
> >>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >>> index 6eadb9d116e4..ee27d0c0efe2 100644
> >>> --- a/mm/sparse-vmemmap.c
> >>> +++ b/mm/sparse-vmemmap.c
> >>> @@ -822,11 +822,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >>> return pfn_to_page(pfn);
> >>> 
> >>> memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> >>> + memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> >> 
> >> This logically belongs to success path in populate_section_memmap(). If we
> >> update the counter there, we won't need to temporarily increase it at all.
> > 
> > Not strictly related to this patchset, but it seems, we can have a single
> > memmap_boot_pages_add() in memmap_alloc() rather than to update the counter
> > in memmap_alloc() callers.
> 
> It will indeed become simpler and is a good cleanup direction, but there
> is a slight change in semantics: the page tables used for vmemmap page
> mapping will also be counted in memmap_boot_pages_add(). This might not
> be an issue (after all, the size of the page tables is very small compared
> to struct pages, right?).
> 
> Additionally, I still lean toward making no changes to this patch, because
> this is a pure bugfix patch — of course, it is meant to facilitate backporting
> for those who need it. The cleanup would involve many more changes, so I
> prefer to do that in a separate patch. What do you think?

For this patch and easy backporting I still think that cleaner to have the
counter incremented in populate_section_memmap() rather immediately after
it.
 
> Thanks,
> Muchun.
> 
> > 
> >>> if (!memmap) {
> >>> section_deactivate(pfn, nr_pages, altmap);
> >>> return ERR_PTR(-ENOMEM);
> >>> }
> >>> - memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> >>> 
> >>> return memmap;
> >>> }
> >>> -- 
> >>> 2.20.1
> >>> 
> >> 
> >> -- 
> >> Sincerely yours,
> >> Mike.
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> 
> 
> 

-- 
Sincerely yours,
Mike.

