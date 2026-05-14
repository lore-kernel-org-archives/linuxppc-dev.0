Return-Path: <linuxppc-dev+bounces-20944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059A5CD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 08:05:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGNDv4vgnz2xy8;
	Thu, 14 May 2026 18:05:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778745951;
	cv=none; b=AXNSx541RG1V7Q97/Fp8zeMBo6qgglLjU/KPs5rpkKn/KHZ94Y3pLNtxQ8VUf157N6Mvbeg+XwdHnW9ALGZNULr3XOlxGrmoJaNijO8W3LPEtlr00EzHTpjDsnCnp4+PQbdmf7T6h/x/3J4EfXpxWl7ZApYBW41jIDMvmP8pOOKKpeJPaKyYjThmfD0nLvigNTkBrJtYCUbXXDkhgEJTXhjI9D3awEZh/oTq/KfRjWuQLU9znGQ9b51Wgho7IT88FxxPHOYgzHNmnjVkdKUKqJ0cyUNLcLMX+ojpehJl0iqnK3u6M76wkWiz/ySr5UWaOA4EUmQGfYkp7N8w6nYkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778745951; c=relaxed/relaxed;
	bh=7Lbg6cyj1Jb1nO4maZGvNBfgjbvvB27TqDOLgXK9cAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fd9+ZYu/fD/YbVzxiWhf/egfyt5mBUY7GbSJCOPlPrN0QymtShw/FSZpYiLXz6vIvdKR9IJQ2imI3Vp8nPsemNOA4aWnaadbwAL86LKn8OFCqQfczMlaYA6QZyUEI3PuPG1VlY9gIeEc4xIrPwnwdK7VesZmxt3Y7lcm1WV9e3OaTin2SeG3EkTljt8kH7iyy79boYLOcvher2Br43gv92VtGJWPMZASs4EmiELtyS5qEAhIJE3Xz0Cju5VHBbpzomYVkMUVpoKIzetvwmKEZLOYeiPJtmIWR6Q6lFhvRWRxvKH1x+NQeF2Vl5MjMkrIu3CdPLWNpWoGlLtdmn4ycQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G8ERET/K; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YN2yPZc6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G8ERET/K; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YN2yPZc6; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G8ERET/K;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YN2yPZc6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=G8ERET/K;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YN2yPZc6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGNDq3W54z2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:05:47 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FDAD672AE;
	Thu, 14 May 2026 08:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Lbg6cyj1Jb1nO4maZGvNBfgjbvvB27TqDOLgXK9cAo=;
	b=G8ERET/KxDKWZ6jcm0+zZzQgpn8Mw38CeVTUw13UI2jZWyxFvh3cLONHhAcYl7dsZI1BYX
	owqI0E6GXgIoAONd/sFlzleyPfgdLsVE7+sRr64PnIX7e+ivMV3oV56C97RFa6o+CzNjmO
	b20q4U6WyT5BkfG9o41ElzspWg2drzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Lbg6cyj1Jb1nO4maZGvNBfgjbvvB27TqDOLgXK9cAo=;
	b=YN2yPZc6ftnQsh1QKMPUd/fbSSAWcHhc7YoVx3x/UClmmYvZ89La1Xtm468U90g2+5H8lM
	HJBo/b0woDIqYFDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="G8ERET/K";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YN2yPZc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Lbg6cyj1Jb1nO4maZGvNBfgjbvvB27TqDOLgXK9cAo=;
	b=G8ERET/KxDKWZ6jcm0+zZzQgpn8Mw38CeVTUw13UI2jZWyxFvh3cLONHhAcYl7dsZI1BYX
	owqI0E6GXgIoAONd/sFlzleyPfgdLsVE7+sRr64PnIX7e+ivMV3oV56C97RFa6o+CzNjmO
	b20q4U6WyT5BkfG9o41ElzspWg2drzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Lbg6cyj1Jb1nO4maZGvNBfgjbvvB27TqDOLgXK9cAo=;
	b=YN2yPZc6ftnQsh1QKMPUd/fbSSAWcHhc7YoVx3x/UClmmYvZ89La1Xtm468U90g2+5H8lM
	HJBo/b0woDIqYFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3146F593A9;
	Thu, 14 May 2026 08:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vh5aCVeCBWruEwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 May 2026 08:05:43 +0000
Date: Thu, 14 May 2026 10:05:41 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/69] mm/hugetlb: Initialize gigantic bootmem
 hugepage struct pages earlier
Message-ID: <agWCVeywSo5lk1Vs@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-5-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513130542.35604-5-songmuchun@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0FDAD672AE

On Wed, May 13, 2026 at 09:04:32PM +0800, Muchun Song wrote:
> Gigantic bootmem HugeTLB pages are currently initialized from hugetlb_init(),
> but page_alloc_init_late() runs earlier and walks pageblocks to determine
> zone contiguity.
> 
> If a bootmem HugeTLB region is marked noinit, set_zone_contiguous() can
> observe still-uninitialized struct pages through __pageblock_pfn_to_page().
> This may not trigger an immediate failure, but it can make
> set_zone_contiguous() compute the wrong zone contiguity state. If extra
> poisoned-page checks are added in this path, such as PF_POISONED_CHECK()
> in page_zone_id(), it can also trigger an early boot panic.
> 
> Initialize gigantic bootmem HugeTLB struct pages from page_alloc_init_late(),
> before zone contiguity is evaluated, so later page allocator setup only
> sees valid struct page state. This also makes the initialization order
> more natural, as struct pages should be initialized before later code
> inspects them.
> 
> Fixes: fde1c4ecf916 ("mm: hugetlb: skip initialization of gigantic tail struct pages if freed by HVO")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

but

> ---
>  include/linux/hugetlb.h | 5 +++++
>  mm/hugetlb.c            | 3 +--
>  mm/mm_init.c            | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 93418625d3c5..52a2c30f866c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -173,6 +173,7 @@ extern int movable_gigantic_pages __read_mostly;
>  extern int sysctl_hugetlb_shm_group __read_mostly;
>  extern struct list_head huge_boot_pages[MAX_NUMNODES];
>  
> +void hugetlb_struct_page_init(void);

we lost the hint that this only takes care of bootmem pages.
So I think hugetlb_bootmem_struct_page_init or something like that would make
it more clear?


-- 
Oscar Salvador
SUSE Labs

