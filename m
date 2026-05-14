Return-Path: <linuxppc-dev+bounces-20941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A81CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 07:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGMw94DbXz2xy8;
	Thu, 14 May 2026 17:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778745081;
	cv=none; b=MmLjsah9ZZivvVrRAb9ClGrNaH4OLwBOm6RSD/WL9yX0oIYx3+v4+d+ujd/iMkDGIPL04juH9EnN2tUgJxEW5+PQujLh5XBdDm7mO86p5MNmqcxWHrhAMwmSliynODfO+TDYzsOGm2cx8HTQh5WFMvNZzKVCo8GcIMSzW0eUXT3QAvJsCUflh8uctNTtENkOga9IuTNNG57rBuuE7KU+02jsHayk4bNDjTfwBsD27mG/LOqFOcq0oigdMR8XNLRrl/uA3l8QWPUSZP9w91Cj+4Qd/6VoqJH25pq/AdRzMZE7KYySjCS729FAMIL2lq7SJZqEVy29tntzfqSmBj4Xug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778745081; c=relaxed/relaxed;
	bh=e0oLzGvgjo+kkPs6eVlVX1mjY7PmbLR+my7KbcNIqtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjH67ywkEXxLK7u9qEG5o48JR6jBmMPX4YM4OCKPAu0t9LDOX2UVmxk1mxvQQEfS3i6YwlLILUJ5fAmOAnB+SFx/a9WueKfDyZoB+vHQ3uIqOf/UqqorNDJdZdXU/Fo/rUREyUbITHqVD0sN06HzToThdN2vDXm7pCNnUfLkWcThxWFiU23OxB82A4k/Om6ezDWNzEGFjbU3gsw5D6eSALpGR/0zcaW3l68aunv7/k10Q83AwZs+biPfYDOciIMd0hrwDPvrVlaGwFTyGhFIby+jpmXy9e54WPMj+Q9krUFbvD+F1+0+jpr1jcek/NbOYPs1MC/htiyL9Sm+S+w1pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mRn3LvCp; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AQKHof5U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mRn3LvCp; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AQKHof5U; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mRn3LvCp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AQKHof5U;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mRn3LvCp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AQKHof5U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 169664 seconds by postgrey-1.37 at boromir; Thu, 14 May 2026 17:51:18 AEST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGMw660FKz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 17:51:18 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3AA55E07E;
	Thu, 14 May 2026 07:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0oLzGvgjo+kkPs6eVlVX1mjY7PmbLR+my7KbcNIqtE=;
	b=mRn3LvCpWJvBTMoC8izGim1Rfz+aMKrO/0XhfY89fgfgFZbQpOuVOWAddvHYEkA7+LKJo5
	yCDRPKWakhGuIALgkP8CJljL6IaO4c9ke7cC4kzMQNXFVk5dx95HxNDIVzB+FvAy7wLM56
	Q9JDc7bSagTNpctJ2xOKh87bIB9lYiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0oLzGvgjo+kkPs6eVlVX1mjY7PmbLR+my7KbcNIqtE=;
	b=AQKHof5ULOD+6FSayUgMnMQ6mQXXktxN2vWkvdgWNvc+G23XX4cakwhKHUrvTZ1U+XMCqZ
	duisf5E59H58eOBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mRn3LvCp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AQKHof5U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0oLzGvgjo+kkPs6eVlVX1mjY7PmbLR+my7KbcNIqtE=;
	b=mRn3LvCpWJvBTMoC8izGim1Rfz+aMKrO/0XhfY89fgfgFZbQpOuVOWAddvHYEkA7+LKJo5
	yCDRPKWakhGuIALgkP8CJljL6IaO4c9ke7cC4kzMQNXFVk5dx95HxNDIVzB+FvAy7wLM56
	Q9JDc7bSagTNpctJ2xOKh87bIB9lYiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e0oLzGvgjo+kkPs6eVlVX1mjY7PmbLR+my7KbcNIqtE=;
	b=AQKHof5ULOD+6FSayUgMnMQ6mQXXktxN2vWkvdgWNvc+G23XX4cakwhKHUrvTZ1U+XMCqZ
	duisf5E59H58eOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D89C3593A9;
	Thu, 14 May 2026 07:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kLHKMvF+BWpSBQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 May 2026 07:51:13 +0000
Date: Thu, 14 May 2026 09:51:12 +0200
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
Subject: Re: [PATCH v2 01/69] mm/hugetlb: Fix boot panic with CONFIG_DEBUG_VM
 and HVO bootmem pages
Message-ID: <agV-8Ng-E0tZ9G5k@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-2-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-2-songmuchun@bytedance.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B3AA55E07E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Wed, May 13, 2026 at 09:04:29PM +0800, Muchun Song wrote:
> Commit 622026e87c40 ("mm/hugetlb: remove fake head pages") switched
> HVO to reuse per-zone shared tail pages from zone->vmemmap_tails[].
> 
> Those shared tail pages were initialized in hugetlb_vmemmap_init(), but
> bootmem HugeTLB folios are prepared earlier from gather_bootmem_prealloc().
> With hugetlb_free_vmemmap=on, prep_and_add_bootmem_folios() can access
> pageblock flags on bootmem HugeTLB pages whose mirrored tail struct pages
> already point to the shared tail page. On CONFIG_DEBUG_VM kernels,
> get_pfnblock_bitmap_bitidx() then dereferences the still-uninitialized
> shared tail page and can panic during boot.
> 
> Initialize zone->vmemmap_tails[] from gather_bootmem_prealloc(), before
> bootmem HugeTLB folios are processed, and drop the later initialization
> from hugetlb_vmemmap_init().
> 
> This bug only affects CONFIG_DEBUG_VM kernels, where the relevant
> assertion is evaluated.
> 
> Fixes: 622026e87c40 ("mm/hugetlb: remove fake head pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

For the correctness of the change

Acked-by: Oscar Salvador <osalvador@suse.de>

but I have a couple of comments:

> ---
>  mm/hugetlb.c         | 19 +++++++++++++++++++
>  mm/hugetlb_vmemmap.c | 17 -----------------
>  2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 31b34ca0f402..d22683ab30a1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3382,6 +3382,25 @@ static void __init gather_bootmem_prealloc(void)
>  		.max_threads	= num_node_state(N_MEMORY),
>  		.numa_aware	= true,
>  	};
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +	struct zone *zone;
> +
> +	for_each_zone(zone) {
> +		for (int i = 0; i < NR_VMEMMAP_TAILS; i++) {
> +			struct page *tail, *p;
> +			unsigned int order;
> +
> +			tail = zone->vmemmap_tails[i];
> +			if (!tail)
> +				continue;
> +
> +			order = i + VMEMMAP_TAIL_MIN_ORDER;
> +			p = page_to_virt(tail);
> +			for (int j = 0; j < PAGE_SIZE / sizeof(struct page); j++)
> +				init_compound_tail(p + j, NULL, order, zone);
> +		}
> +	}

This deserves a comment why do we need to initialize those pages here, no need for
a fat one but a hint, because everybody else looking at this will wonder why do not
have it in hugetlb_vmemmap_init(), as the name suggests.


> +#endif
>  
>  	padata_do_multithreaded(&job);
>  }
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 4a077d231d3a..62e61af18c9a 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -870,27 +870,10 @@ static const struct ctl_table hugetlb_vmemmap_sysctls[] = {
>  static int __init hugetlb_vmemmap_init(void)

At this point, hugetlb_vmemmap_init only initialites the sysctls for
each hstate, should the name reflect that better?

Also, vmemmap_get_tail() still thinks that tail pages are initialized
here from this comment:

 "/*
   * Only allocate the page, but do not initialize it.
   *
   * Any initialization done here will be overwritten by memmap_init().
   *
   * hugetlb_vmemmap_init() will take care of initialization after
   * memmap_init().
   */"

so we might want to adjust that as well, and I am not sure if we have
more comments in the tree referencing hugetlb_vmemmap_init() as the init
point for those pages that need correction.

 
Having said that, and this is just a question, we cannot really make
gather_bootmem_prealloc() also do the initialization of the sysfs right?
I see that hugetlb sysfs gets initialized from hugetlb_init() a few
calls after, so.. meh.

Anyway, maybe just convert hugetlb_vmemmap_init to hugetlb_vmemmap_sysfs_create
(pick a better name), so it does not look like having two entry points
for vmemmap init stuff.

-- 
Oscar Salvador
SUSE Labs

