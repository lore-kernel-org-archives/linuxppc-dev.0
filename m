Return-Path: <linuxppc-dev+bounces-20943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9A9CD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 08:00:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGN6g4lC3z2xy8;
	Thu, 14 May 2026 18:00:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778745627;
	cv=none; b=IcNGhtgH3hKqJocT+R8t2hO0q+zufabFz6MhbPhn75m4OmLd7JKwqN7QcIM5MSZ9TcELbdBEwIPbtPIkyorletF+Vdzn4VoxjaqmIWWrT8tK4kAobgm7KIb7FvCSRQK+lJWDzAO2+KIivfTaBGv0z+4lsX/JX0ZtS9nPI3tbL4esZKhVFqajrmFuOf1AyAZkbVLKJY/BxgCFy6DQfLvBrYDPr4OStldH63uyX6kH6ymiNT08dZRDwJOLHTHFbsJCCWEtHN74pOXZiNgAujNeCz5JIYpI6vwf8YH0G2rs+wudXLM1IdAVrGIDVNAlzpk0/hHJHpcdjAzaBi+FAbqN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778745627; c=relaxed/relaxed;
	bh=0ApyV1SJgz5wtbwoXbn/VnkSAGGIM5s57P85+2beKro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXmdFrb6uV+n2lfGFaHQUFDLfxJbxmmNiXDwC9pFjdzTomjXZPAYnQhwGPKzpMQ4JpYCViW4VfVmwQw2LcN9uYNK/iXavGu4yYxj1t0+rr0I3CuheuK9ifgn0m3HvMmhZ5RJ1FmzWSg35Pg4yfb9AFj/NhXJY5Btez9JD2NSLmqhefvoHoEwyaeBbMSVtF+bOH4ATsMw5D9ysShxXY5wduqt/1omiDH4cXfAB7YbR1LpES24tWjQQwxZhC9F1+VzTF4TWS/QeKlsmyL0Nx+bco9zEtFloOcMcIc9LvbM/27dizNAU8VeTv2nQCiN2DS1cSJcXBWQvtw0lgAMWBmuRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CJLjzcwG; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C4248gcx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CJLjzcwG; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C4248gcx; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CJLjzcwG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C4248gcx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CJLjzcwG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=C4248gcx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGN6b3FqZz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:00:23 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0A575E0B4;
	Thu, 14 May 2026 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ApyV1SJgz5wtbwoXbn/VnkSAGGIM5s57P85+2beKro=;
	b=CJLjzcwGlCsOVB9un6xLW22kKcw6V4Xlum6RMNosJGw32EAzNkqaZ0dXBputXg8joCGJh5
	ZC1jpkQXSTxpbM6WBhRM4oeLo+fYzd66yI5ebrozqIG9PAWcPh+1jwQnrrgvtShLJAV6m0
	iztuO6FRDH7X+dSyQAMxzhaR+0Yiy8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ApyV1SJgz5wtbwoXbn/VnkSAGGIM5s57P85+2beKro=;
	b=C4248gcxLcOZ45VZ6Xk2Ku4O2ABnN9dD5IGpb7ZAPZEdfu+e2hfvYKSUMmGYh5vpD4fT12
	zLyXzyaJCm0GMMAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ApyV1SJgz5wtbwoXbn/VnkSAGGIM5s57P85+2beKro=;
	b=CJLjzcwGlCsOVB9un6xLW22kKcw6V4Xlum6RMNosJGw32EAzNkqaZ0dXBputXg8joCGJh5
	ZC1jpkQXSTxpbM6WBhRM4oeLo+fYzd66yI5ebrozqIG9PAWcPh+1jwQnrrgvtShLJAV6m0
	iztuO6FRDH7X+dSyQAMxzhaR+0Yiy8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ApyV1SJgz5wtbwoXbn/VnkSAGGIM5s57P85+2beKro=;
	b=C4248gcxLcOZ45VZ6Xk2Ku4O2ABnN9dD5IGpb7ZAPZEdfu+e2hfvYKSUMmGYh5vpD4fT12
	zLyXzyaJCm0GMMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D86D3593AA;
	Thu, 14 May 2026 08:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4xHQMhKBBWr/DQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 May 2026 08:00:18 +0000
Date: Thu, 14 May 2026 10:00:17 +0200
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
Subject: Re: [PATCH v2 03/69] powerpc/mm: Fix wrong addr_pfn tracking in
 compound vmemmap population
Message-ID: <agWBEXHO0EfmOWMV@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-4-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-4-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,bytedance.com:email,imap1.dmz-prg2.suse.org:helo]

On Wed, May 13, 2026 at 09:04:31PM +0800, Muchun Song wrote:
> vmemmap_populate_compound_pages() uses addr_pfn to determine the PFN
> offset within a compound page and to decide whether the current
> vmemmap slot should be populated as a head page mapping or should reuse
> a tail page mapping.
> 
> However, addr_pfn is advanced manually in parallel with addr.  The loop
> itself progresses in vmemmap address space, so each PAGE_SIZE step in
> addr covers PAGE_SIZE / sizeof(struct page) struct page slots.  Since
> addr_pfn is compared against nr_pages in data-PFN units, it should
> advance by the same number of PFNs.  The existing manual increments do
> not match that and therefore do not reliably track the PFN
> corresponding to the current addr.
> 
> As a result, pfn_offset can be computed from the wrong PFN and the code
> can make the head/tail decision for the wrong compound-page position.
> 
> Fix this by deriving addr_pfn directly from the current vmemmap address
> instead of carrying it as loop state.
> 
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

